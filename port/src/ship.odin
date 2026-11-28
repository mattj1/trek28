package trek

import "base:intrinsics"

// 1000:239b add_pending_charge.
// DI is one ship record. AX is the amount to add.
//
// ADD word ptr [DI+0C], AX saturates at 0xFFFF when the add carries.
// The original AX is kept. SHR AX, 1 twice, and if AH is nonzero that
// byte is added to damage at [DI+0E]. The byte add wraps.
// AX of 0x400 is the smallest value that bumps damage, by 1.
// 1000:237b falls into this entry after it may shrink AX.

// @proc 1000:239b
// status: tested
// Odin: add_pending_charge
// 1000:239b  FUN_1000_239b:
// 1000:239b      01 45 0c                 ADD word ptr [DI + 0xc],AX
// 1000:239e      73 05                    JNC 0x1000:23a5
// 1000:23a0      c7 45 0c ff ff           MOV word ptr [DI + 0xc],0xffff
// 1000:23a5  LAB_1000_23a5:
// 1000:23a5      50                       PUSH AX
// 1000:23a6      d1 e8                    SHR AX,0x1
// 1000:23a8      d1 e8                    SHR AX,0x1
// 1000:23aa      22 e4                    AND AH,AH
// 1000:23ac      74 03                    JZ 0x1000:23b1
// 1000:23ae      00 65 0e                 ADD byte ptr [DI + 0xe],AH
// 1000:23b1  LAB_1000_23b1:
// 1000:23b1      58                       POP AX
// 1000:23b2      c3                       RET

add_pending_charge :: proc(ship: ^Ship_Record, ax: u16) {
	sum, carry := intrinsics.overflow_add(ship.pending_charge, ax)
	if carry {
		sum = 0xFFFF
	}
	ship.pending_charge = sum

	// SHR AX, 1 / SHR AX, 1. AH is then bits 15..10 of the original AX.
	bumped := ax >> 2
	ah := u8(bumped >> 8)
	if ah != 0 {
		damage, _ := intrinsics.overflow_add(ship.damage, ah)
		ship.damage = damage
	}
}

// 1000:221e slew_heading.
// The heading byte is two nibbles. The high nibble is desired and the low
// nibble is actual. Actual steps toward desired around a 16-step circle:
// a gap of 1..4 steps forward by 1, 5..8 by 2, 9..11 back by 2, and 12..15
// back by 1. When seek has any of its low 5 bits set and seek distance is
// at most 0xFA, actual is copied from desired in this same call.

// @proc 1000:221e
// status: tested
// Odin: slew_heading
// 1000:221e  FUN_1000_221e:
// 1000:221e      8a 45 0a                 MOV AL,byte ptr [DI + 0xa]
// 1000:2221      d0 e8                    SHR AL,0x1
// 1000:2223      d0 e8                    SHR AL,0x1
// 1000:2225      d0 e8                    SHR AL,0x1
// 1000:2227      d0 e8                    SHR AL,0x1
// 1000:2229      8a e8                    MOV CH,AL
// 1000:222b      8a 4d 0a                 MOV CL,byte ptr [DI + 0xa]
// 1000:222e      80 65 0a f0              AND byte ptr [DI + 0xa],0xf0
// 1000:2232      80 e1 0f                 AND CL,0xf
// 1000:2235      f6 45 11 1f              TEST byte ptr [DI + 0x11],0x1f
// 1000:2239      74 09                    JZ 0x1000:2244
// 1000:223b      81 7d 12 fa 00           CMP word ptr [DI + 0x12],0xfa
// 1000:2240      77 02                    JA 0x1000:2244
// 1000:2242      8a cd                    MOV CL,CH
// 1000:2244  LAB_1000_2244:
// 1000:2244      2a e9                    SUB CH,CL
// 1000:2246      74 1d                    JZ 0x1000:2265
// 1000:2248      79 03                    JNS 0x1000:224d
// 1000:224a      80 c5 10                 ADD CH,0x10
// 1000:224d  LAB_1000_224d:
// 1000:224d      fe c1                    INC CL
// 1000:224f      80 fd 04                 CMP CH,0x4
// 1000:2252      76 11                    JBE 0x1000:2265
// 1000:2254      fe c1                    INC CL
// 1000:2256      80 fd 08                 CMP CH,0x8
// 1000:2259      76 0a                    JBE 0x1000:2265
// 1000:225b      80 e9 04                 SUB CL,0x4
// 1000:225e      80 fd 0b                 CMP CH,0xb
// 1000:2261      76 02                    JBE 0x1000:2265
// 1000:2263      fe c1                    INC CL
// 1000:2265  LAB_1000_2265:
// 1000:2265      80 e1 0f                 AND CL,0xf
// 1000:2268      08 4d 0a                 OR byte ptr [DI + 0xa],CL
// 1000:226b      c3                       RET

slew_heading :: proc(ship: ^Ship_Record) {
	desired := ship.heading >> 4
	actual := ship.heading & 0x0F
	ship.heading &= 0xF0
	if (ship.seek & 0x1F) != 0 && ship.seek_distance <= 0xFA {
		actual = desired
	}

	// SUB of the two nibbles. A wrapped result has bit 7 set, and adding
	// 0x10 brings the gap back into 1..15.
	gap, _ := intrinsics.overflow_sub(desired, actual)
	if gap != 0 {
		if gap >= 0x80 {
			gap, _ = intrinsics.overflow_add(gap, 0x10)
		}
		actual, _ = intrinsics.overflow_add(actual, 1)
		if gap > 4 {
			actual, _ = intrinsics.overflow_add(actual, 1)
			if gap > 8 {
				actual, _ = intrinsics.overflow_sub(actual, 4)
				if gap > 0x0B {
					actual, _ = intrinsics.overflow_add(actual, 1)
				}
			}
		}
	}
	ship.heading |= actual & 0x0F
}

// 1000:218b slew_impulse.
// Slews the heading, then the impulse byte. While the warp timer is 0, a
// desired nibble of 11 or more is pulled down by one before the step.
// 1000:21af returns the new actual nibble in BL. This procedure ORs that
// nibble with the desired nibble it saved in BH and stores the byte.

// @proc 1000:218b
// status: tested
// Odin: slew_impulse
// 1000:218b  FUN_1000_218b:
// 1000:218b      e8 90 00                 CALL 0x1000:221e
// 1000:218e      80 7d 14 00              CMP byte ptr [DI + 0x14],0x0
// 1000:2192      75 0a                    JNZ 0x1000:219e
// 1000:2194      80 7d 0b b0              CMP byte ptr [DI + 0xb],0xb0
// 1000:2198      72 04                    JC 0x1000:219e
// 1000:219a      80 6d 0b 10              SUB byte ptr [DI + 0xb],0x10
// 1000:219e  LAB_1000_219e:
// 1000:219e      8a 45 0b                 MOV AL,byte ptr [DI + 0xb]
// 1000:21a1      8a f8                    MOV BH,AL
// 1000:21a3      80 e7 f0                 AND BH,0xf0
// 1000:21a6      e8 06 00                 CALL 0x1000:21af
// 1000:21a9      0a df                    OR BL,BH
// 1000:21ab      88 5d 0b                 MOV byte ptr [DI + 0xb],BL
// 1000:21ae      c3                       RET

slew_impulse :: proc(ship: ^Ship_Record) {
	slew_heading(ship)
	if ship.warp == 0 && ship.impulse >= 0xB0 {
		pulled, _ := intrinsics.overflow_sub(ship.impulse, 0x10)
		ship.impulse = pulled
	}
	desired := ship.impulse & 0xF0
	ship.impulse = step_impulse(ship, ship.impulse) | desired
}

// 1000:21af step_impulse.
// AL is the impulse byte. The high nibble is desired and the low nibble is
// actual. BL returns the actual nibble. The caller keeps the desired nibble.
//
// A matching pair clears impulse_wait. A mismatch with a zero wait only arms
// the wait: ((12 - gap) >> 2) + 1. Each later call decrements the wait. The
// nibble steps by one, toward the desired nibble, on the call that reaches
// zero, and add_pending_charge runs with AX = 2 * gap. The gap is the plain
// difference of the nibbles before that step. The wait stored after a step
// is ((12 - gap) >> 1) + 1. A countdown that has not finished can be pulled
// down to that same one-shift value when 12 - gap is still within the
// remaining wait. 12 - gap wraps in a byte when the gap is above 12.

// @proc 1000:21af
// status: tested
// Odin: step_impulse
// 1000:21af  FUN_1000_21af:
// 1000:21af      8a e0                    MOV AH,AL
// 1000:21b1      80 e4 0f                 AND AH,0xf
// 1000:21b4      8a dc                    MOV BL,AH
// 1000:21b6      d0 e8                    SHR AL,0x1
// 1000:21b8      d0 e8                    SHR AL,0x1
// 1000:21ba      d0 e8                    SHR AL,0x1
// 1000:21bc      d0 e8                    SHR AL,0x1
// 1000:21be      24 0f                    AND AL,0xf
// 1000:21c0      3a c4                    CMP AL,AH
// 1000:21c2      75 05                    JNZ 0x1000:21c9
// 1000:21c4      c6 45 10 00              MOV byte ptr [DI + 0x10],0x0
// 1000:21c8      c3                       RET
// 1000:21c9  LAB_1000_21c9:
// 1000:21c9      f6 45 10 ff              TEST byte ptr [DI + 0x10],0xff
// 1000:21cd      74 3b                    JZ 0x1000:220a
// 1000:21cf      fe 4d 10                 DEC byte ptr [DI + 0x10]
// 1000:21d2      74 17                    JZ 0x1000:21eb
// 1000:21d4      2a c4                    SUB AL,AH
// 1000:21d6      79 02                    JNS 0x1000:21da
// 1000:21d8      f6 d8                    NEG AL
// 1000:21da  LAB_1000_21da:
// 1000:21da      b4 0c                    MOV AH,0xc
// 1000:21dc      2a e0                    SUB AH,AL
// 1000:21de      3a 65 10                 CMP AH,byte ptr [DI + 0x10]
// 1000:21e1      77 07                    JA 0x1000:21ea
// 1000:21e3      d0 ec                    SHR AH,0x1
// 1000:21e5      fe c4                    INC AH
// 1000:21e7      88 65 10                 MOV byte ptr [DI + 0x10],AH
// 1000:21ea  LAB_1000_21ea:
// 1000:21ea      c3                       RET
// 1000:21eb  LAB_1000_21eb:
// 1000:21eb      2a c4                    SUB AL,AH
// 1000:21ed      78 04                    JS 0x1000:21f3
// 1000:21ef      fe c3                    INC BL
// 1000:21f1      eb 04                    JMP 0x1000:21f7
// 1000:21f3  LAB_1000_21f3:
// 1000:21f3      fe cb                    DEC BL
// 1000:21f5      f6 d8                    NEG AL
// 1000:21f7  LAB_1000_21f7:
// 1000:21f7      b4 0c                    MOV AH,0xc
// 1000:21f9      2a e0                    SUB AH,AL
// 1000:21fb      d0 ec                    SHR AH,0x1
// 1000:21fd      fe c4                    INC AH
// 1000:21ff      88 65 10                 MOV byte ptr [DI + 0x10],AH
// 1000:2202      02 c0                    ADD AL,AL
// 1000:2204      b4 00                    MOV AH,0x0
// 1000:2206      e8 92 01                 CALL 0x1000:239b
// 1000:2209      c3                       RET
// 1000:220a  LAB_1000_220a:
// 1000:220a      2a c4                    SUB AL,AH
// 1000:220c      79 02                    JNS 0x1000:2210
// 1000:220e      f6 d8                    NEG AL
// 1000:2210  LAB_1000_2210:
// 1000:2210      b4 0c                    MOV AH,0xc
// 1000:2212      2a e0                    SUB AH,AL
// 1000:2214      d0 ec                    SHR AH,0x1
// 1000:2216      d0 ec                    SHR AH,0x1
// 1000:2218      fe c4                    INC AH
// 1000:221a      88 65 10                 MOV byte ptr [DI + 0x10],AH
// 1000:221d      c3                       RET

step_impulse :: proc(ship: ^Ship_Record, impulse: u8) -> (actual: u8) {
	// 220a shifts the (12 - gap) byte twice. 21e3 and 21fb shift it once.
	reload :: proc(gap: u8, shifts: int) -> u8 {
		raw, _ := intrinsics.overflow_sub(u8(0x0C), gap)
		for _ in 0 ..< shifts {
			raw >>= 1
		}
		raw, _ = intrinsics.overflow_add(raw, 1)
		return raw
	}

	desired := impulse >> 4
	actual = impulse & 0x0F
	if desired == actual {
		ship.impulse_wait = 0
		return
	}

	// SUB / JNS / NEG. Both nibbles are 0..15, so the absolute gap fits in a byte.
	gap, _ := intrinsics.overflow_sub(desired, actual)
	if gap >= 0x80 {
		gap, _ = intrinsics.overflow_sub(0, gap)
	}

	if ship.impulse_wait == 0 {
		ship.impulse_wait = reload(gap, 2)
		return
	}
	wait, _ := intrinsics.overflow_sub(ship.impulse_wait, 1)
	ship.impulse_wait = wait
	if wait != 0 {
		// JA keeps the decremented wait when 12 - gap is still above it.
		raw, _ := intrinsics.overflow_sub(u8(0x0C), gap)
		if raw > wait {
			return
		}
		ship.impulse_wait = reload(gap, 1)
		return
	}

	if desired < actual {
		actual, _ = intrinsics.overflow_sub(actual, 1)
	} else {
		actual, _ = intrinsics.overflow_add(actual, 1)
	}
	ship.impulse_wait = reload(gap, 1)
	add_pending_charge(ship, u16(gap) * 2)
	return
}
