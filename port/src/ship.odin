package trek

import "base:intrinsics"

// 1000:239b add_pending_charge.
// DI is one ship record. AX is the amount to add.
//
// ADD word ptr [DI+0C], AX saturates at 0xFFFF when the add carries.
// The original AX is kept. SHR AX, 1 twice, and if AH is nonzero that
// byte is added to damage at [DI+0E]. The byte add wraps.
// AX of 0x400 is the smallest value that bumps damage, by 1.
// 1000:237b add_scaled_charge falls into this entry after it may shrink AX.

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

// 1000:237b add_scaled_charge.
// The name is inferred. DI is one ship and AX is the incoming amount.
// A nonzero byte_34 shifts AX right twice. Flag bit 0x20 set and shot bit 7
// clear divides that AX by 3. The division is unsigned, DX and CX are saved,
// and the remainder is discarded. Execution then falls into add_pending_charge.
// 1000:239b returns the AX it was given, and 1000:2ed4 scores that value.

// @proc 1000:237b
// status: tested
// Odin: add_scaled_charge
// 1000:237b  FUN_1000_237b:
// 1000:237b      80 7d 34 00              CMP byte ptr [DI + 0x34],0x0
// 1000:237f      74 04                    JZ 0x1000:2385
// 1000:2381      d1 e8                    SHR AX,0x1
// 1000:2383      d1 e8                    SHR AX,0x1
// 1000:2385  LAB_1000_2385:
// 1000:2385      f6 05 20                 TEST byte ptr [DI],0x20
// 1000:2388      74 11                    JZ 0x1000:239b
// 1000:238a      f6 45 19 80              TEST byte ptr [DI + 0x19],0x80
// 1000:238e      75 0b                    JNZ 0x1000:239b
// 1000:2390      52                       PUSH DX
// 1000:2391      33 d2                    XOR DX,DX
// 1000:2393      51                       PUSH CX
// 1000:2394      b9 03 00                 MOV CX,0x3
// 1000:2397      f7 f1                    DIV CX
// 1000:2399      59                       POP CX
// 1000:239a      5a                       POP DX
// Falls into 1000:239b.

add_scaled_charge :: proc(ship: ^Ship_Record, ax: u16) -> u16 {
	amount := ax
	if ship.byte_34 != 0 {
		amount >>= 2
	}
	if ship.flags & 0x20 != 0 && ship.shot & 0x80 == 0 {
		amount /= 3
	}
	add_pending_charge(ship, amount)
	return amount
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

// 1000:20e3 apply_damage_thresholds.
// The name is inferred from the four comparisons. DI is one ship record.
// Damage below 8 leaves the record alone. From 8, flag bits 4 and 5 are
// cleared. From 0x0C, seek is stored as 0. From 0x10, weapons_cooldown is
// stored as 0x18 on every call. From 0x14, byte_2a and get_mine are stored
// as 0. Each threshold includes the effects of the ones below it.

// @proc 1000:20e3
// status: tested
// Odin: apply_damage_thresholds
// 1000:20e3  FUN_1000_20e3:
// 1000:20e3      8a 45 0e                 MOV AL,byte ptr [DI + 0xe]
// 1000:20e6      3c 08                    CMP AL,0x8
// 1000:20e8      72 1f                    JC 0x1000:2109
// 1000:20ea      80 25 cf                 AND byte ptr [DI],0xcf
// 1000:20ed      3c 0c                    CMP AL,0xc
// 1000:20ef      72 18                    JC 0x1000:2109
// 1000:20f1      c6 45 11 00              MOV byte ptr [DI + 0x11],0x0
// 1000:20f5      3c 10                    CMP AL,0x10
// 1000:20f7      72 10                    JC 0x1000:2109
// 1000:20f9      c6 45 15 18              MOV byte ptr [DI + 0x15],0x18
// 1000:20fd      3c 14                    CMP AL,0x14
// 1000:20ff      72 08                    JC 0x1000:2109
// 1000:2101      c6 45 2a 00              MOV byte ptr [DI + 0x2a],0x0
// 1000:2105      c6 45 22 00              MOV byte ptr [DI + 0x22],0x0
// 1000:2109  LAB_1000_2109:
// 1000:2109      c3                       RET

apply_damage_thresholds :: proc(ship: ^Ship_Record) {
	damage := ship.damage
	if damage < 8 {
		return
	}
	ship.flags &= 0xCF
	if damage < 0x0C {
		return
	}
	ship.seek = 0
	if damage < 0x10 {
		return
	}
	ship.weapons_cooldown = 0x18
	if damage < 0x14 {
		return
	}
	ship.byte_2a = 0
	ship.get_mine = 0
}

// 1000:2055 charge_impulse_and_heal.
// The notes already use this name. DI is one ship. The side byte is
// side_89d8 indexed by current_side, and the frame tests read the low byte
// of frame_count.
//
// A side byte of exactly 1 stores energy 0 and returns. Otherwise a nonzero
// weapons cooldown decrements, and energy at or below 0x7D0 stores warp 0.
// The impulse charge and the heal run when the frame byte's low two bits are
// clear. The actual impulse nibble costs 0, 5, 10, 15, or 10. Energy at or
// below 0x3E8 halves that cost. Flag bit 0x20 adds energy / 0x4B, an
// unsigned division. The sum goes through add_pending_charge. Damage then
// decrements when it is nonzero, on every such frame if bit 2 of the frame
// byte is set, and otherwise only when the actual nibble is at most 2.

// @proc 1000:2055
// status: tested
// Odin: charge_impulse_and_heal
// 1000:2055  FUN_1000_2055:
// 1000:2055      8a 1e 74 a2              MOV BL,byte ptr [0xa274]
// 1000:2059      b7 00                    MOV BH,0x0
// 1000:205b      80 bf d8 89 01           CMP byte ptr [BX + 0x89d8],0x1
// 1000:2060      75 06                    JNZ 0x1000:2068
// 1000:2062      c7 45 08 00 00           MOV word ptr [DI + 0x8],0x0
// 1000:2067      c3                       RET
// 1000:2068  LAB_1000_2068:
// 1000:2068      f6 45 15 ff              TEST byte ptr [DI + 0x15],0xff
// 1000:206c      74 03                    JZ 0x1000:2071
// 1000:206e      fe 4d 15                 DEC byte ptr [DI + 0x15]
// 1000:2071  LAB_1000_2071:
// 1000:2071      81 7d 08 d0 07           CMP word ptr [DI + 0x8],0x7d0
// 1000:2076      77 04                    JA 0x1000:207c
// 1000:2078      c6 45 14 00              MOV byte ptr [DI + 0x14],0x0
// 1000:207c  LAB_1000_207c:
// 1000:207c      f6 06 d2 89 03           TEST byte ptr [0x89d2],0x3
// 1000:2081      75 5f                    JNZ 0x1000:20e2
// 1000:2083      ba 00 00                 MOV DX,0x0
// 1000:2086      8a 45 0b                 MOV AL,byte ptr [DI + 0xb]
// 1000:2089      24 0f                    AND AL,0xf
// 1000:208b      74 14                    JZ 0x1000:20a1
// 1000:208d      b2 05                    MOV DL,0x5
// 1000:208f      3c 04                    CMP AL,0x4
// 1000:2091      72 0e                    JC 0x1000:20a1
// 1000:2093      b2 0a                    MOV DL,0xa
// 1000:2095      3c 08                    CMP AL,0x8
// 1000:2097      72 08                    JC 0x1000:20a1
// 1000:2099      b2 0f                    MOV DL,0xf
// 1000:209b      3c 0b                    CMP AL,0xb
// 1000:209d      72 02                    JC 0x1000:20a1
// 1000:209f      b2 0a                    MOV DL,0xa
// 1000:20a1  LAB_1000_20a1:
// 1000:20a1      81 7d 08 e8 03           CMP word ptr [DI + 0x8],0x3e8
// 1000:20a6      77 02                    JA 0x1000:20aa
// 1000:20a8      d1 ea                    SHR DX,0x1
// 1000:20aa  LAB_1000_20aa:
// 1000:20aa      8b c2                    MOV AX,DX
// 1000:20ac      f6 05 20                 TEST byte ptr [DI],0x20
// 1000:20af      74 0e                    JZ 0x1000:20bf
// 1000:20b1      52                       PUSH DX
// 1000:20b2      b9 4b 00                 MOV CX,0x4b
// 1000:20b5      8b 45 08                 MOV AX,word ptr [DI + 0x8]
// 1000:20b8      33 d2                    XOR DX,DX
// 1000:20ba      f7 f1                    DIV CX
// 1000:20bc      5a                       POP DX
// 1000:20bd      03 c2                    ADD AX,DX
// 1000:20bf  LAB_1000_20bf:
// 1000:20bf      e8 d9 02                 CALL 0x1000:239b
// 1000:20c2      f6 06 d2 89 03           TEST byte ptr [0x89d2],0x3
// 1000:20c7      75 19                    JNZ 0x1000:20e2
// 1000:20c9      f6 06 d2 89 04           TEST byte ptr [0x89d2],0x4
// 1000:20ce      75 09                    JNZ 0x1000:20d9
// 1000:20d0      8a 45 0b                 MOV AL,byte ptr [DI + 0xb]
// 1000:20d3      24 0f                    AND AL,0xf
// 1000:20d5      3c 02                    CMP AL,0x2
// 1000:20d7      77 09                    JA 0x1000:20e2
// 1000:20d9  LAB_1000_20d9:
// 1000:20d9      f6 45 0e ff              TEST byte ptr [DI + 0xe],0xff
// 1000:20dd      74 03                    JZ 0x1000:20e2
// 1000:20df      fe 4d 0e                 DEC byte ptr [DI + 0xe]
// 1000:20e2  LAB_1000_20e2:
// 1000:20e2      c3                       RET

charge_impulse_and_heal :: proc(ds: ^DS_Segment, ship: ^Ship_Record) {
	// Actual nibble. 0 costs nothing. 1..3 cost 5, 4..7 cost 10, 8..10 cost
	// 15, and 11..15 cost 10. The comparisons are unsigned, matching JC.
	impulse_cost :: proc(nibble: u8) -> u16 {
		if nibble == 0 {
			return 0
		}
		if nibble < 4 {
			return 5
		}
		if nibble < 8 {
			return 10
		}
		if nibble < 0x0B {
			return 15
		}
		return 10
	}

	if ds.side_89d8[ds.current_side] == 1 {
		ship.energy = 0
		return
	}
	if ship.weapons_cooldown != 0 {
		ship.weapons_cooldown -= 1
	}
	if ship.energy <= 0x07D0 {
		ship.warp = 0
	}
	// TEST byte ptr [frame_count], 3. The high byte of the word is not read.
	frame := u8(ds.frame_count)
	if frame & 3 != 0 {
		return
	}

	cost := impulse_cost(ship.impulse & 0x0F)
	if ship.energy <= 0x03E8 {
		cost >>= 1
	}
	ax := cost
	if ship.flags & 0x20 != 0 {
		// Unsigned DIV of the energy word by 0x4B. The quotient is added to
		// the cost. The add wraps; these inputs stay inside a word.
		ax, _ = intrinsics.overflow_add(ship.energy / 0x4B, cost)
	}
	add_pending_charge(ship, ax)

	// 1000:20c2 repeats the test at 2081. The charge call does not write the
	// frame count, so both tests see the same byte.
	if frame & 3 != 0 {
		return
	}
	if frame & 4 == 0 && (ship.impulse & 0x0F) > 2 {
		return
	}
	if ship.damage != 0 {
		ship.damage -= 1
	}
}

// 1000:23b3 read_handicap.
// The notes already use this name. 1000:1ece pops the return address and
// reads the pointer table that follows this call. That table is the four id
// records at A226, stride 0x0B. The returned byte is ids[current_side & 3][4].

// @proc 1000:23b3
// status: tested
// Odin: read_handicap
// 1000:23b3  FUN_1000_23b3:
// 1000:23b3      53                       PUSH BX
// 1000:23b4      e8 17 fb                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:23bf  [ptr] 1000:a226 1000:a231 1000:a23c 1000:a247
// 1000:23bf  LAB_1000_23bf:
// 1000:23bf      8a 47 04                 MOV AL,byte ptr [BX + 0x4]
// 1000:23c2      5b                       POP BX
// 1000:23c3      c3                       RET

read_handicap :: proc(ds: ^DS_Segment) -> u8 {
	return ds.ids[ds.current_side & 3][4]
}

// 1000:226c drain_invisibility.
// The notes already use this name. DI is one ship. The frame tests read the
// low byte of frame_count. An odd frame returns. A shot in flight, flag bit
// 0x10 clear, or flag bits 0x44 set also return. An invisibility byte of 0
// clears flag bit 0x10. Otherwise the byte decrements. A handicap of 4 or
// more skips that decrement when the frame byte's low two bits are clear.
// Reaching zero clears flag bit 0x10.

// @proc 1000:226c
// status: tested
// Odin: drain_invisibility
// 1000:226c  FUN_1000_226c:
// 1000:226c      a0 d2 89                 MOV AL,[0x89d2]
// 1000:226f      24 01                    AND AL,0x1
// 1000:2271      75 2e                    JNZ 0x1000:22a1
// 1000:2273      f6 45 19 ff              TEST byte ptr [DI + 0x19],0xff
// 1000:2277      75 28                    JNZ 0x1000:22a1
// 1000:2279      f6 05 10                 TEST byte ptr [DI],0x10
// 1000:227c      74 23                    JZ 0x1000:22a1
// 1000:227e      f6 05 44                 TEST byte ptr [DI],0x44
// 1000:2281      75 1e                    JNZ 0x1000:22a1
// 1000:2283      8a 45 0f                 MOV AL,byte ptr [DI + 0xf]
// 1000:2286      22 c0                    AND AL,AL
// 1000:2288      74 13                    JZ 0x1000:229d
// 1000:228a      e8 26 01                 CALL 0x1000:23b3
// 1000:228d      3c 04                    CMP AL,0x4
// 1000:228f      72 07                    JC 0x1000:2298
// 1000:2291      f6 06 d2 89 03           TEST byte ptr [0x89d2],0x3
// 1000:2296      74 09                    JZ 0x1000:22a1
// 1000:2298  LAB_1000_2298:
// 1000:2298      fe 4d 0f                 DEC byte ptr [DI + 0xf]
// 1000:229b      75 04                    JNZ 0x1000:22a1
// 1000:229d  LAB_1000_229d:
// 1000:229d      80 25 ef                 AND byte ptr [DI],0xef
// 1000:22a0      c3                       RET
// 1000:22a1  LAB_1000_22a1:
// 1000:22a1      c3                       RET

drain_invisibility :: proc(ds: ^DS_Segment, ship: ^Ship_Record) {
	frame := u8(ds.frame_count)
	if frame & 1 != 0 {
		return
	}
	if ship.shot != 0 {
		return
	}
	if ship.flags & 0x10 == 0 {
		return
	}
	if ship.flags & 0x44 != 0 {
		return
	}
	if ship.invisibility != 0 {
		handicap := read_handicap(ds)
		if handicap >= 4 && frame & 3 == 0 {
			return
		}
		ship.invisibility -= 1
		if ship.invisibility != 0 {
			return
		}
	}
	ship.flags &= 0xEF
}

// 1000:2002 spawn_debris.
// The notes already use this name. DI is the ship. The first of the 48
// debris slots whose lifetime byte is 0 receives lifetime 0xC8, the ship's
// X and Y, its plane, and its team. A full list leaves the ship untouched.

// @proc 1000:2002
// status: tested
// Odin: spawn_debris
// 1000:2002  FUN_1000_2002:
// 1000:2002      be 8c a0                 MOV SI,0xa08c
// 1000:2005      b9 30 00                 MOV CX,0x30
// 1000:2008  LAB_1000_2008:
// 1000:2008      80 3c 00                 CMP byte ptr [SI],0x0
// 1000:200b      74 06                    JZ 0x1000:2013
// 1000:200d      83 c6 07                 ADD SI,0x7
// 1000:2010      e2 f6                    LOOP 0x1000:2008
// 1000:2012      c3                       RET
// 1000:2013  LAB_1000_2013:
// 1000:2013      c6 04 c8                 MOV byte ptr [SI],0xc8
// 1000:2016      8b 45 01                 MOV AX,word ptr [DI + 0x1]
// 1000:2019      89 44 01                 MOV word ptr [SI + 0x1],AX
// 1000:201c      8b 45 03                 MOV AX,word ptr [DI + 0x3]
// 1000:201f      89 44 03                 MOV word ptr [SI + 0x3],AX
// 1000:2022      8a 45 18                 MOV AL,byte ptr [DI + 0x18]
// 1000:2025      88 44 06                 MOV byte ptr [SI + 0x6],AL
// 1000:2028      8a 45 05                 MOV AL,byte ptr [DI + 0x5]
// 1000:202b      88 44 05                 MOV byte ptr [SI + 0x5],AL
// 1000:202e      c3                       RET

spawn_debris :: proc(ds: ^DS_Segment, ship: ^Ship_Record) {
	for &slot in ds.debris {
		if slot[0] != 0 {
			continue
		}
		slot[0] = 0xC8
		slot[1] = u8(ship.x)
		slot[2] = u8(ship.x >> 8)
		slot[3] = u8(ship.y)
		slot[4] = u8(ship.y >> 8)
		slot[5] = ship.plane
		slot[6] = ship.team
		return
	}
}

// 1000:2343 tick_mine_lifetimes.
// The name is inferred from the lifetime byte. Four bases, 20 mines each.
// A lifetime of 0 stays. A lifetime of 1 is cleared and the base stock at
// +06 increments, wrapping in the byte. A lifetime of 2 decrements on every
// call. A lifetime above 2 decrements when the low byte of frame_count has
// its low three bits clear.

// @proc 1000:2343
// status: tested
// Odin: tick_mine_lifetimes
// 1000:2343  FUN_1000_2343:
// 1000:2343      be 14 90                 MOV SI,0x9014
// 1000:2346      bf 4c 90                 MOV DI,0x904c
// 1000:2349      b9 04 00                 MOV CX,0x4
// 1000:234c  LAB_1000_234c:
// 1000:234c      51                       PUSH CX
// 1000:234d      b9 14 00                 MOV CX,0x14
// 1000:2350  LAB_1000_2350:
// 1000:2350      8a 05                    MOV AL,byte ptr [DI]
// 1000:2352      22 c0                    AND AL,AL
// 1000:2354      74 19                    JZ 0x1000:236f
// 1000:2356      fe c8                    DEC AL
// 1000:2358      74 0f                    JZ 0x1000:2369
// 1000:235a      fe c8                    DEC AL
// 1000:235c      74 07                    JZ 0x1000:2365
// 1000:235e      f6 06 d2 89 07           TEST byte ptr [0x89d2],0x7
// 1000:2363      75 0a                    JNZ 0x1000:236f
// 1000:2365  LAB_1000_2365:
// 1000:2365      fe 0d                    DEC byte ptr [DI]
// 1000:2367      eb 06                    JMP 0x1000:236f
// 1000:2369  LAB_1000_2369:
// 1000:2369      c6 05 00                 MOV byte ptr [DI],0x0
// 1000:236c      fe 44 06                 INC byte ptr [SI + 0x6]
// 1000:236f  LAB_1000_236f:
// 1000:236f      83 c7 08                 ADD DI,0x8
// 1000:2372      e2 dc                    LOOP 0x1000:2350
// 1000:2374      59                       POP CX
// 1000:2375      83 c6 0e                 ADD SI,0xe
// 1000:2378      e2 d2                    LOOP 0x1000:234c
// 1000:237a      c3                       RET

tick_mine_lifetimes :: proc(ds: ^DS_Segment) {
	frame := u8(ds.frame_count)
	for side in 0 ..< 4 {
		for &mine in ds.mines[side] {
			life := mine[0]
			if life == 0 {
				continue
			}
			if life == 1 {
				mine[0] = 0
				stock, _ := intrinsics.overflow_add(ds.bases[side][6], 1)
				ds.bases[side][6] = stock
				continue
			}
			if life == 2 || frame & 7 == 0 {
				mine[0] = life - 1
			}
		}
	}
}

// 1000:16fe update_pause.
// The notes already use this name. A zero mask clears the delay. While bit 7
// is clear, a zero delay ORs 0x8F into the mask and a nonzero delay
// decrements. While bit 7 is set, a side whose end byte is nonzero, or whose
// id does not start with 'm', loses its low bit. A zero low nibble then
// clears the whole mask.

// @proc 1000:16fe
// status: tested
// Odin: update_pause
// 1000:16fe  FUN_1000_16fe:
// 1000:16fe      f6 06 6c a2 ff           TEST byte ptr [0xa26c],0xff
// 1000:1703      75 06                    JNZ 0x1000:170b
// 1000:1705      c6 06 6d a2 00           MOV byte ptr [0xa26d],0x0
// 1000:170a      c3                       RET
// 1000:170b  LAB_1000_170b:
// 1000:170b      f6 06 6c a2 80           TEST byte ptr [0xa26c],0x80
// 1000:1710      75 12                    JNZ 0x1000:1724
// 1000:1712      80 3e 6d a2 00           CMP byte ptr [0xa26d],0x0
// 1000:1717      75 06                    JNZ 0x1000:171f
// 1000:1719      80 0e 6c a2 8f           OR byte ptr [0xa26c],0x8f
// 1000:171e      c3                       RET
// 1000:171f  LAB_1000_171f:
// 1000:171f      fe 0e 6d a2              DEC byte ptr [0xa26d]
// 1000:1723      c3                       RET
// 1000:1724  LAB_1000_1724:
// 1000:1724      bb e0 89                 MOV BX,0x89e0
// 1000:1727      bf 26 a2                 MOV DI,0xa226
// 1000:172a      b9 00 00                 MOV CX,0x0
// 1000:172d  LAB_1000_172d:
// 1000:172d      80 3f 00                 CMP byte ptr [BX],0x0
// 1000:1730      75 05                    JNZ 0x1000:1737
// 1000:1732      80 3d 6d                 CMP byte ptr [DI],0x6d
// 1000:1735      75 0a                    JNZ 0x1000:1741
// 1000:1737  LAB_1000_1737:
// 1000:1737      b0 01                    MOV AL,0x1
// 1000:1739      d2 e0                    SHL AL,CL
// 1000:173b      f6 d0                    NOT AL
// 1000:173d      20 06 6c a2              AND byte ptr [0xa26c],AL
// 1000:1741  LAB_1000_1741:
// 1000:1741      fe c1                    INC CL
// 1000:1743      43                       INC BX
// 1000:1744      83 c7 0b                 ADD DI,0xb
// 1000:1747      80 f9 04                 CMP CL,0x4
// 1000:174a      72 e1                    JC 0x1000:172d
// 1000:174c      f6 06 6c a2 0f           TEST byte ptr [0xa26c],0xf
// 1000:1751      75 05                    JNZ 0x1000:1758
// 1000:1753      c6 06 6c a2 00           MOV byte ptr [0xa26c],0x0
// 1000:1758  LAB_1000_1758:
// 1000:1758      c3                       RET

update_pause :: proc(ds: ^DS_Segment) {
	if ds.pause_mask == 0 {
		ds.pause_delay = 0
		return
	}
	if ds.pause_mask & 0x80 == 0 {
		if ds.pause_delay == 0 {
			ds.pause_mask |= 0x8F
		} else {
			ds.pause_delay -= 1
		}
		return
	}
	for side in 0 ..< 4 {
		if ds.side_end[side] != 0 || ds.ids[side][0] != 'm' {
			bit := u8(1) << uint(side)
			ds.pause_mask &= ~bit
		}
	}
	if ds.pause_mask & 0x0F == 0 {
		ds.pause_mask = 0
	}
}
