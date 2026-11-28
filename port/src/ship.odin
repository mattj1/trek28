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

// 1000:1759 drain_key_ring.
// The notes already use this name. Up to four bytes are copied from the ring
// at 00E5 into key_packet. The read pointer wraps from 00ED back to 00E5.
// An empty ring or a zero key fills the packet's remaining bytes with 0, or
// with 0x86 when clock_enable is 0. A zero key is consumed before the fill.

// @proc 1000:1759
// status: tested
// Odin: drain_key_ring
// 1000:1759  FUN_1000_1759:
// 1000:1759      bf 0d a2                 MOV DI,0xa20d
// 1000:175c      b9 04 00                 MOV CX,0x4
// 1000:175f  LAB_1000_175f:
// 1000:175f      8b 1e e1 00              MOV BX,word ptr [0xe1]
// 1000:1763      3b 1e e3 00              CMP BX,word ptr [0xe3]
// 1000:1767      b0 00                    MOV AL,0x0
// 1000:1769      74 18                    JZ 0x1000:1783
// 1000:176b      8a 07                    MOV AL,byte ptr [BX]
// 1000:176d      43                       INC BX
// 1000:176e      81 fb ed 00              CMP BX,0xed
// 1000:1772      75 03                    JNZ 0x1000:1777
// 1000:1774      bb e5 00                 MOV BX,0xe5
// 1000:1777  LAB_1000_1777:
// 1000:1777      89 1e e1 00              MOV word ptr [0xe1],BX
// 1000:177b      22 c0                    AND AL,AL
// 1000:177d      74 04                    JZ 0x1000:1783
// 1000:177f      aa                       STOSB ES:DI
// 1000:1780      e2 dd                    LOOP 0x1000:175f
// 1000:1782      c3                       RET
// 1000:1783  LAB_1000_1783:
// 1000:1783      80 3e 03 a2 00           CMP byte ptr [0xa203],0x0
// 1000:1788      75 02                    JNZ 0x1000:178c
// 1000:178a      b0 86                    MOV AL,0x86
// 1000:178c  LAB_1000_178c:
// 1000:178c      f3 aa                    STOSB.REP ES:DI
// 1000:178e      c3                       RET

drain_key_ring :: proc(ds: ^DS_Segment) {
	// REP STOSB writes the slots still counted, including the one being filled.
	fill :: proc(ds: ^DS_Segment, at, count: int) {
		al := u8(0)
		if ds.clock_enable == 0 {
			al = 0x86
		}
		for i in 0 ..< count {
			ds.key_packet[at + i] = al
		}
	}

	at := 0
	left := 4
	for {
		if ds.key_read == ds.key_write {
			fill(ds, at, left)
			return
		}
		key := ds.key_ring[ds.key_read - 0x00E5]
		next := ds.key_read + 1
		if next == 0x00ED {
			next = 0x00E5
		}
		ds.key_read = next
		if key == 0 {
			fill(ds, at, left)
			return
		}
		ds.key_packet[at] = key
		at += 1
		left -= 1
		if left == 0 {
			return
		}
	}
}

// 1000:382a step_position.
// The notes already use this name. Speed is AH before the decrement and
// heading is AL. The word table at CS:387C holds eight bytes per speed and
// two bytes per heading low nibble. The low byte is the X step and the high
// byte is the Y step. Heading bits 2–3 rotate that vector, and both axes
// are masked with 0x3FFF. A ship caller aims DI at the record. A shot caller
// adds 0x19 to DI first, so the adds land on the shot position. DEC of a
// zero speed wraps the row index into the bytes after the 31-row table.
// The ship caller skips that zero.

// @proc 1000:382a
// status: tested
// Odin: step_position
// 1000:382a  FUN_1000_382a:
// 1000:382a      52                       PUSH DX
// 1000:382b      51                       PUSH CX
// 1000:382c      fe cc                    DEC AH
// 1000:382e      8a dc                    MOV BL,AH
// 1000:3830      32 ff                    XOR BH,BH
// 1000:3832      03 db                    ADD BX,BX
// 1000:3834      03 db                    ADD BX,BX
// 1000:3836      03 db                    ADD BX,BX
// 1000:3838      81 c3 7c 38              ADD BX,0x387c
// 1000:383c      8a d0                    MOV DL,AL
// 1000:383e      81 e2 03 00              AND DX,0x3
// 1000:3842      03 d2                    ADD DX,DX
// 1000:3844      03 da                    ADD BX,DX
// 1000:3846      8a d0                    MOV DL,AL
// 1000:3848      2e 8b 07                 MOV AX,word ptr CS:[BX]
// 1000:384b      8a cc                    MOV CL,AH
// 1000:384d      32 e4                    XOR AH,AH
// 1000:384f      32 ed                    XOR CH,CH
// 1000:3851      80 e2 0c                 AND DL,0xc
// 1000:3854      74 13                    JZ 0x1000:3869
// 1000:3856      91                       XCHG AX,CX
// 1000:3857      f7 d9                    NEG CX
// 1000:3859      80 fa 04                 CMP DL,0x4
// 1000:385c      74 0b                    JZ 0x1000:3869
// 1000:385e      91                       XCHG AX,CX
// 1000:385f      f7 d9                    NEG CX
// 1000:3861      80 fa 08                 CMP DL,0x8
// 1000:3864      74 03                    JZ 0x1000:3869
// 1000:3866      91                       XCHG AX,CX
// 1000:3867      f7 d9                    NEG CX
// 1000:3869  LAB_1000_3869:
// 1000:3869      01 45 01                 ADD word ptr [DI + 0x1],AX
// 1000:386c      81 65 01 ff 3f           AND word ptr [DI + 0x1],0x3fff
// 1000:3871      01 4d 03                 ADD word ptr [DI + 0x3],CX
// 1000:3874      81 65 03 ff 3f           AND word ptr [DI + 0x3],0x3fff
// 1000:3879      59                       POP CX
// 1000:387a      5a                       POP DX
// 1000:387b      c3                       RET

@(private)
STEP_COM :: #load("../../TREK28.COM")

step_position :: proc(x, y: ^u16, speed, heading: u8) {
	image := string(STEP_COM)
	row, _ := intrinsics.overflow_sub(speed, 1)
	off := 0x387C + int(row) * 8 + int(heading & 3) * 2
	dx := u16(image[off])
	dy := u16(image[off + 1])
	quad := heading & 0x0C
	if quad != 0 {
		dx, dy = dy, dx
		dy = neg16(dy)
		if quad != 4 {
			dx, dy = dy, dx
			dy = neg16(dy)
			if quad != 8 {
				dx, dy = dy, dx
				dy = neg16(dy)
			}
		}
	}
	x^ = add16(x^, dx) & 0x3FFF
	y^ = add16(y^, dy) & 0x3FFF
}

// 1000:1d64 fill_mine_slot.
// The name is inferred. The notes describe this filler, used by the mine
// command and by energy death, and they do not name the procedure.
// SI is one side's 20 mine slots. The first zero lifetime receives 0xFA,
// the ship's X, Y, and plane, side +17, and team +18. The mine count
// decrements, and that byte wraps. A full side returns with the ship
// untouched.

// @proc 1000:1d64
// status: tested
// Odin: fill_mine_slot
// 1000:1d64  FUN_1000_1d64:
// 1000:1d64      b9 14 00                 MOV CX,0x14
// 1000:1d67  LAB_1000_1d67:
// 1000:1d67      80 3c 00                 CMP byte ptr [SI],0x0
// 1000:1d6a      74 06                    JZ 0x1000:1d72
// 1000:1d6c      83 c6 08                 ADD SI,0x8
// 1000:1d6f      e2 f6                    LOOP 0x1000:1d67
// 1000:1d71      c3                       RET
// 1000:1d72  LAB_1000_1d72:
// 1000:1d72      fe 4d 06                 DEC byte ptr [DI + 0x6]
// 1000:1d75      c6 04 fa                 MOV byte ptr [SI],0xfa
// 1000:1d78      8b 45 01                 MOV AX,word ptr [DI + 0x1]
// 1000:1d7b      89 44 01                 MOV word ptr [SI + 0x1],AX
// 1000:1d7e      8b 45 03                 MOV AX,word ptr [DI + 0x3]
// 1000:1d81      89 44 03                 MOV word ptr [SI + 0x3],AX
// 1000:1d84      8a 45 05                 MOV AL,byte ptr [DI + 0x5]
// 1000:1d87      88 44 05                 MOV byte ptr [SI + 0x5],AL
// 1000:1d8a      8a 45 18                 MOV AL,byte ptr [DI + 0x18]
// 1000:1d8d      88 44 07                 MOV byte ptr [SI + 0x7],AL
// 1000:1d90      8a 45 17                 MOV AL,byte ptr [DI + 0x17]
// 1000:1d93      88 44 06                 MOV byte ptr [SI + 0x6],AL
// 1000:1d96      c3                       RET

fill_mine_slot :: proc(slots: ^[20][8]u8, ship: ^Ship_Record) {
	for &slot in slots {
		if slot[0] != 0 {
			continue
		}
		mines, _ := intrinsics.overflow_sub(ship.mines, 1)
		ship.mines = mines
		slot[0] = 0xFA
		slot[1] = u8(ship.x)
		slot[2] = u8(ship.x >> 8)
		slot[3] = u8(ship.y)
		slot[4] = u8(ship.y >> 8)
		slot[5] = ship.plane
		slot[6] = ship.own_side
		slot[7] = ship.team
		return
	}
}

// 1000:210a apply_energy_charge.
// The notes already use this name. A handicap of 3 or more halves the
// pending charge. Flag bits 0x44 shift that charge twice more, and again
// when it is still at least 0x1F40. Energy below 0x2710 is left alone on
// that path. Energy at or above 0x2710 is reduced and then floored at
// 0x2710. The other path adds 10 when the frame's low two bits are clear
// and energy is at most 0x88B8, then subtracts the charge. A zero result
// or a borrow dumps one mine per mine still carried and replaces the flag
// byte with 8, or with 12 when the original charge word is at least
// 0xC350. A full mine list does not decrement the count, so that dump
// repeats. Energy at or below 0xC8 clears flag bit 4. The charge word is
// stored as 0 on every path.

// @proc 1000:210a
// status: tested
// Odin: apply_energy_charge
// 1000:210a  FUN_1000_210a:
// 1000:210a      e8 a6 02                 CALL 0x1000:23b3
// 1000:210d      3c 03                    CMP AL,0x3
// 1000:210f      8b 45 0c                 MOV AX,word ptr [DI + 0xc]
// 1000:2112      72 02                    JC 0x1000:2116
// 1000:2114      d1 e8                    SHR AX,0x1
// 1000:2116  LAB_1000_2116:
// 1000:2116      8b 5d 08                 MOV BX,word ptr [DI + 0x8]
// 1000:2119      f6 05 44                 TEST byte ptr [DI],0x44
// 1000:211c      74 20                    JZ 0x1000:213e
// 1000:211e      d1 e8                    SHR AX,0x1
// 1000:2120      d1 e8                    SHR AX,0x1
// 1000:2122      3d 40 1f                 CMP AX,0x1f40
// 1000:2125      72 04                    JC 0x1000:212b
// 1000:2127      d1 e8                    SHR AX,0x1
// 1000:2129      d1 e8                    SHR AX,0x1
// 1000:212b  LAB_1000_212b:
// 1000:212b      81 fb 10 27              CMP BX,0x2710
// 1000:212f      72 54                    JC 0x1000:2185
// 1000:2131      2b d8                    SUB BX,AX
// 1000:2133      81 fb 10 27              CMP BX,0x2710
// 1000:2137      77 19                    JA 0x1000:2152
// 1000:2139      bb 10 27                 MOV BX,0x2710
// 1000:213c      eb 14                    JMP 0x1000:2152
// 1000:213e  LAB_1000_213e:
// 1000:213e      f6 06 d2 89 03           TEST byte ptr [0x89d2],0x3
// 1000:2143      75 09                    JNZ 0x1000:214e
// 1000:2145      81 fb b8 88              CMP BX,0x88b8
// 1000:2149      77 03                    JA 0x1000:214e
// 1000:214b      83 c3 0a                 ADD BX,0xa
// 1000:214e  LAB_1000_214e:
// 1000:214e      2b d8                    SUB BX,AX
// 1000:2150      76 0e                    JBE 0x1000:2160
// 1000:2152  LAB_1000_2152:
// 1000:2152      89 5d 08                 MOV word ptr [DI + 0x8],BX
// 1000:2155      81 fb c8 00              CMP BX,0xc8
// 1000:2159      77 2a                    JA 0x1000:2185
// 1000:215b      80 25 ef                 AND byte ptr [DI],0xef
// 1000:215e      eb 25                    JMP 0x1000:2185
// 1000:2160  LAB_1000_2160:
// 1000:2160      e8 6b fd                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:216b  [ptr] 1000:904c 1000:90ec 1000:918c 1000:922c
// 1000:216b  LAB_1000_216b:
// 1000:216b      8b f3                    MOV SI,BX
// 1000:216d      f6 45 06 ff              TEST byte ptr [DI + 0x6],0xff
// 1000:2171      74 05                    JZ 0x1000:2178
// 1000:2173      e8 ee fb                 CALL 0x1000:1d64
// 1000:2176      eb e8                    JMP 0x1000:2160
// 1000:2178  LAB_1000_2178:
// 1000:2178      81 7d 0c 50 c3           CMP word ptr [DI + 0xc],0xc350
// 1000:217d      b0 08                    MOV AL,0x8
// 1000:217f      72 02                    JC 0x1000:2183
// 1000:2181      b0 0c                    MOV AL,0xc
// 1000:2183  LAB_1000_2183:
// 1000:2183      88 05                    MOV byte ptr [DI],AL
// 1000:2185  LAB_1000_2185:
// 1000:2185      c7 45 0c 00 00           MOV word ptr [DI + 0xc],0x0
// 1000:218a      c3                       RET

apply_energy_charge :: proc(ds: ^DS_Segment, ship: ^Ship_Record) {
	// 2152 stores the surviving energy and clears invisibility at or below 0xC8.
	store_energy :: proc(ship: ^Ship_Record, energy: u16) {
		ship.energy = energy
		if energy <= 0xC8 {
			ship.flags &= 0xEF
		}
	}

	charge := ship.pending_charge
	if read_handicap(ds) >= 3 {
		charge >>= 1
	}
	energy := ship.energy
	if ship.flags & 0x44 != 0 {
		charge >>= 2
		if charge >= 0x1F40 {
			charge >>= 2
		}
		if energy >= 0x2710 {
			energy = sub16(energy, charge)
			if energy <= 0x2710 {
				energy = 0x2710
			}
			store_energy(ship, energy)
		}
	} else {
		if u8(ds.frame_count) & 3 == 0 && energy <= 0x88B8 {
			energy = add16(energy, 10)
		}
		result, borrow := intrinsics.overflow_sub(energy, charge)
		if borrow || result == 0 {
			for ship.mines != 0 {
				fill_mine_slot(&ds.mines[ds.current_side & 3], ship)
			}
			ship.flags = 8
			if ship.pending_charge >= 0xC350 {
				ship.flags = 12
			}
		} else {
			store_energy(ship, result)
		}
	}
	ship.pending_charge = 0
}

// 1000:37ac move_ships_and_shots.
// The notes already use this name. It walks the 8 records at 8A8C and then
// the 16 ships. An alive record whose actual impulse nibble is nonzero takes
// one step. Actual impulse of 11 or more, a nonzero warp timer, and energy
// of at least 2000 decrements the timer, charges 0x64, and adds 9 to the
// speed. A shot in flight steps from the word at +1F. Below 4, that word's
// high byte is replaced with the shot byte times 4. The shot byte then
// counts down, and a result of 0x80 or 0xC0 is stored as 0.

// @proc 1000:37ac
// status: tested
// Odin: move_ships_and_shots
// 1000:37ac  FUN_1000_37ac:
// 1000:37ac      bf 8c 8a                 MOV DI,0x8a8c
// 1000:37af      b1 08                    MOV CL,0x8
// 1000:37b1      80 c1 10                 ADD CL,0x10
// 1000:37b4      32 ed                    XOR CH,CH
// 1000:37b6  LAB_1000_37b6:
// 1000:37b6      51                       PUSH CX
// 1000:37b7      f6 05 80                 TEST byte ptr [DI],0x80
// 1000:37ba      74 30                    JZ 0x1000:37ec
// 1000:37bc      8b 45 0a                 MOV AX,word ptr [DI + 0xa]
// 1000:37bf      80 e4 0f                 AND AH,0xf
// 1000:37c2      80 fc 0b                 CMP AH,0xb
// 1000:37c5      72 1b                    JC 0x1000:37e2
// 1000:37c7      f6 45 14 ff              TEST byte ptr [DI + 0x14],0xff
// 1000:37cb      74 15                    JZ 0x1000:37e2
// 1000:37cd      81 7d 08 d0 07           CMP word ptr [DI + 0x8],0x7d0
// 1000:37d2      72 0e                    JC 0x1000:37e2
// 1000:37d4      fe 4d 14                 DEC byte ptr [DI + 0x14]
// 1000:37d7      50                       PUSH AX
// 1000:37d8      b8 64 00                 MOV AX,0x64
// 1000:37db      e8 bd eb                 CALL 0x1000:239b
// 1000:37de      58                       POP AX
// 1000:37df      80 c4 09                 ADD AH,0x9
// 1000:37e2  LAB_1000_37e2:
// 1000:37e2      80 e4 1f                 AND AH,0x1f
// 1000:37e5      74 05                    JZ 0x1000:37ec
// 1000:37e7      24 0f                    AND AL,0xf
// 1000:37e9      e8 3e 00                 CALL 0x1000:382a
// 1000:37ec  LAB_1000_37ec:
// 1000:37ec      8a 45 19                 MOV AL,byte ptr [DI + 0x19]
// 1000:37ef      a8 ff                    TEST AL,0xff
// 1000:37f1      74 30                    JZ 0x1000:3823
// 1000:37f3      3c 04                    CMP AL,0x4
// 1000:37f5      73 07                    JNC 0x1000:37fe
// 1000:37f7      02 c0                    ADD AL,AL
// 1000:37f9      02 c0                    ADD AL,AL
// 1000:37fb      88 45 20                 MOV byte ptr [DI + 0x20],AL
// 1000:37fe  LAB_1000_37fe:
// 1000:37fe      8b 45 1f                 MOV AX,word ptr [DI + 0x1f]
// 1000:3801      25 0f 1f                 AND AX,0x1f0f
// 1000:3804      80 fc 00                 CMP AH,0x0
// 1000:3807      74 08                    JZ 0x1000:3811
// 1000:3809      57                       PUSH DI
// 1000:380a      83 c7 19                 ADD DI,0x19
// 1000:380d      e8 1a 00                 CALL 0x1000:382a
// 1000:3810      5f                       POP DI
// 1000:3811  LAB_1000_3811:
// 1000:3811      fe 4d 19                 DEC byte ptr [DI + 0x19]
// 1000:3814      8a 45 19                 MOV AL,byte ptr [DI + 0x19]
// 1000:3817      3c 80                    CMP AL,0x80
// 1000:3819      74 04                    JZ 0x1000:381f
// 1000:381b      3c c0                    CMP AL,0xc0
// 1000:381d      75 04                    JNZ 0x1000:3823
// 1000:381f  LAB_1000_381f:
// 1000:381f      c6 45 19 00              MOV byte ptr [DI + 0x19],0x0
// 1000:3823  LAB_1000_3823:
// 1000:3823      83 c7 3b                 ADD DI,0x3b
// 1000:3826      59                       POP CX
// 1000:3827      e2 8d                    LOOP 0x1000:37b6
// 1000:3829      c3                       RET

move_ships_and_shots :: proc(ds: ^DS_Segment) {
	record_at :: proc(ds: ^DS_Segment, index: int) -> ^Ship_Record {
		if index < 8 {
			return &ds.extra_records[index]
		}
		n := index - 8
		return &ds.ships[n / 4][n % 4]
	}

	for index in 0 ..< 24 {
		ship := record_at(ds, index)
		if ship.flags & 0x80 != 0 {
			speed := ship.impulse & 0x0F
			if speed >= 0x0B && ship.warp != 0 && ship.energy >= 0x07D0 {
				ship.warp -= 1
				add_pending_charge(ship, 0x64)
				speed += 9
			}
			speed &= 0x1F
			if speed != 0 {
				step_position(&ship.x, &ship.y, speed, ship.heading & 0x0F)
			}
		}
		if ship.shot != 0 {
			if ship.shot < 4 {
				ship.shot_heading = (ship.shot_heading & 0x00FF) | (u16(ship.shot << 2) << 8)
			}
			shot_speed := u8(ship.shot_heading >> 8) & 0x1F
			shot_heading := u8(ship.shot_heading) & 0x0F
			if shot_speed != 0 {
				step_position(&ship.shot_x, &ship.shot_y, shot_speed, shot_heading)
			}
			ship.shot -= 1
			if ship.shot == 0x80 || ship.shot == 0xC0 {
				ship.shot = 0
			}
		}
	}
}

// 1000:4459 spawn_ship.
// The notes already use this name. DI is the ship and CL is its index in
// the side, 0..3. Carry set means the base refused the spawn.
//
// Formation, byte 34, and seek are cleared before either check. No ships
// left, or base energy at or below 200, returns carry and leaves the rest
// of the record and the base alone. Otherwise the base spends one ship and
// 100 energy. The repeat store then zeroes the 0x3B record at DI, which
// wipes those three stores. The fill copies the base's side byte to +17
// and +2B, the team, and the plane to +05 and +31, then the base position
// into the ship and the homing words. Flags become 0x80 and impulse 0x11.
// Handicap 4, or mode bit 0, keeps 5 torpedoes, energy 0x1D4C, and
// invisibility 0x63. Handicap 3 steps down to 2, 0x0BB8, and 0x32. Any
// other handicap stores 0, 0x03E8, and 0x14. The heading byte is the index
// times 68, computed with 8-bit adds, so an index of 4 wraps to 0x10.
// 1000:1ece's base table is bases[current_side & 3].

// @proc 1000:4459
// status: tested
// Odin: spawn_ship
// 1000:4459  FUN_1000_4459:
// 1000:4459      c7 45 32 00 00           MOV word ptr [DI + 0x32],0x0
// 1000:445e      c6 45 34 00              MOV byte ptr [DI + 0x34],0x0
// 1000:4462      c6 45 11 00              MOV byte ptr [DI + 0x11],0x0
// 1000:4466      e8 65 da                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:4471  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
// 1000:4471  LAB_1000_4471:
// 1000:4471      8b f3                    MOV SI,BX
// 1000:4473      80 7c 0a 00              CMP byte ptr [SI + 0xa],0x0
// 1000:4477      75 02                    JNZ 0x1000:447b
// 1000:4479      f9                       STC
// 1000:447a      c3                       RET
// 1000:447b  LAB_1000_447b:
// 1000:447b      81 7c 08 c8 00           CMP word ptr [SI + 0x8],0xc8
// 1000:4480      77 02                    JA 0x1000:4484
// 1000:4482      f9                       STC
// 1000:4483      c3                       RET
// 1000:4484  LAB_1000_4484:
// 1000:4484      fe 4c 0a                 DEC byte ptr [SI + 0xa]
// 1000:4487      83 6c 08 64              SUB word ptr [SI + 0x8],0x64
// 1000:448b      57                       PUSH DI
// 1000:448c      51                       PUSH CX
// 1000:448d      32 c0                    XOR AL,AL
// 1000:448f      b9 3b 00                 MOV CX,0x3b
// 1000:4492      f3 aa                    STOSB.REP ES:DI
// 1000:4494      59                       POP CX
// 1000:4495      5f                       POP DI
// 1000:4496      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
// 1000:4499      88 45 17                 MOV byte ptr [DI + 0x17],AL
// 1000:449c      88 45 2b                 MOV byte ptr [DI + 0x2b],AL
// 1000:449f      8a 44 0c                 MOV AL,byte ptr [SI + 0xc]
// 1000:44a2      88 45 18                 MOV byte ptr [DI + 0x18],AL
// 1000:44a5      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
// 1000:44a8      88 45 05                 MOV byte ptr [DI + 0x5],AL
// 1000:44ab      88 45 31                 MOV byte ptr [DI + 0x31],AL
// 1000:44ae      c6 05 80                 MOV byte ptr [DI],0x80
// 1000:44b1      c6 45 2c 00              MOV byte ptr [DI + 0x2c],0x0
// 1000:44b5      8b 44 01                 MOV AX,word ptr [SI + 0x1]
// 1000:44b8      89 45 01                 MOV word ptr [DI + 0x1],AX
// 1000:44bb      89 45 2d                 MOV word ptr [DI + 0x2d],AX
// 1000:44be      8b 44 03                 MOV AX,word ptr [SI + 0x3]
// 1000:44c1      89 45 03                 MOV word ptr [DI + 0x3],AX
// 1000:44c4      89 45 2f                 MOV word ptr [DI + 0x2f],AX
// 1000:44c7      c6 45 06 00              MOV byte ptr [DI + 0x6],0x0
// 1000:44cb      c6 45 2a 00              MOV byte ptr [DI + 0x2a],0x0
// 1000:44cf      e8 e1 de                 CALL 0x1000:23b3
// 1000:44d2      c6 45 07 05              MOV byte ptr [DI + 0x7],0x5
// 1000:44d6      c7 45 08 4c 1d           MOV word ptr [DI + 0x8],0x1d4c
// 1000:44db      c6 45 0f 63              MOV byte ptr [DI + 0xf],0x63
// 1000:44df      3c 04                    CMP AL,0x4
// 1000:44e1      74 25                    JZ 0x1000:4508
// 1000:44e3      f6 06 12 00 01           TEST byte ptr [0x12],0x1
// 1000:44e8      75 1e                    JNZ 0x1000:4508
// 1000:44ea      c6 45 07 02              MOV byte ptr [DI + 0x7],0x2
// 1000:44ee      c7 45 08 b8 0b           MOV word ptr [DI + 0x8],0xbb8
// 1000:44f3      c6 45 0f 32              MOV byte ptr [DI + 0xf],0x32
// 1000:44f7      3c 03                    CMP AL,0x3
// 1000:44f9      74 0d                    JZ 0x1000:4508
// 1000:44fb      c6 45 07 00              MOV byte ptr [DI + 0x7],0x0
// 1000:44ff      c7 45 08 e8 03           MOV word ptr [DI + 0x8],0x3e8
// 1000:4504      c6 45 0f 14              MOV byte ptr [DI + 0xf],0x14
// 1000:4508  LAB_1000_4508:
// 1000:4508      8a c1                    MOV AL,CL
// 1000:450a      02 c0                    ADD AL,AL
// 1000:450c      02 c0                    ADD AL,AL
// 1000:450e      02 c0                    ADD AL,AL
// 1000:4510      02 c0                    ADD AL,AL
// 1000:4512      02 c1                    ADD AL,CL
// 1000:4514      02 c0                    ADD AL,AL
// 1000:4516      02 c0                    ADD AL,AL
// 1000:4518      88 45 0a                 MOV byte ptr [DI + 0xa],AL
// 1000:451b      c6 45 0b 11              MOV byte ptr [DI + 0xb],0x11
// 1000:451f      c6 45 29 01              MOV byte ptr [DI + 0x29],0x1
// 1000:4523      f8                       CLC
// 1000:4524      c3                       RET

spawn_ship :: proc(ds: ^DS_Segment, ship: ^Ship_Record, index: u8) -> bool {
	ship.formation = 0
	ship.byte_34 = 0
	ship.seek = 0

	base := &ds.bases[ds.current_side & 3]
	if base[0x0A] == 0 {
		return true
	}
	energy := u16(base[8]) | u16(base[9]) << 8
	if energy <= 0xC8 {
		return true
	}
	base[0x0A] -= 1
	energy = sub16(energy, 0x64)
	base[8] = u8(energy)
	base[9] = u8(energy >> 8)

	ship^ = {}
	ship.own_side = base[0x0B]
	ship.fire_control = base[0x0B]
	ship.team = base[0x0C]
	ship.plane = base[5]
	ship.homing_level = base[5]
	ship.flags = 0x80
	ship.pad_2c[0] = 0
	bx := u16(base[1]) | u16(base[2]) << 8
	by := u16(base[3]) | u16(base[4]) << 8
	ship.x = bx
	ship.homing_x = bx
	ship.y = by
	ship.homing_y = by
	ship.mines = 0
	ship.byte_2a = 0

	handicap := read_handicap(ds)
	ship.torpedoes = 5
	ship.energy = 0x1D4C
	ship.invisibility = 0x63
	if handicap != 4 && ds.mode_bits & 1 == 0 {
		ship.torpedoes = 2
		ship.energy = 0x0BB8
		ship.invisibility = 0x32
		if handicap != 3 {
			ship.torpedoes = 0
			ship.energy = 0x03E8
			ship.invisibility = 0x14
		}
	}

	// AL = CL; four adds double it, one adds CL, two more double it.
	heading := index
	heading, _ = intrinsics.overflow_add(heading, heading)
	heading, _ = intrinsics.overflow_add(heading, heading)
	heading, _ = intrinsics.overflow_add(heading, heading)
	heading, _ = intrinsics.overflow_add(heading, heading)
	heading, _ = intrinsics.overflow_add(heading, index)
	heading, _ = intrinsics.overflow_add(heading, heading)
	heading, _ = intrinsics.overflow_add(heading, heading)
	ship.heading = heading
	ship.impulse = 0x11
	ship.byte_29 = 1
	return false
}

// 1000:1f1c update_side_ships.
// The notes already use this name. DI is the four ship records of one side.
// 1000:1ee6 stores current_side as 0..3 and points DI at that side.
//
// byte_a295 counts records that are still alive at the end of the walk.
// Bit 7 runs charge_impulse_and_heal, slew_impulse, drain_invisibility,
// apply_damage_thresholds, and apply_energy_charge. If bit 7 is clear
// after that, the walk falls through into the dead path, so a death flag
// of 8 or 12 is decremented on this same call. A zero flag byte calls
// spawn_ship with the slot index. Carry set leaves the count down. Any
// other flag byte counts down, and reaching zero calls spawn_debris.
//
// A nonzero side_end returns after the walk. side_89d8 equal to 1 stores
// end code 3 and leaves side_89dc alone. Otherwise a base energy of 0
// clears ships remaining and decrements +0D when that byte is nonzero.
// side_89dc receives the wrapping sum of the alive count and ships
// remaining. A zero sum stores end code 1. A nonzero end code then clears
// ships remaining, base energy, and +0D, clears flag bytes whose bit 7
// is set on the side's own four records, stores 0 in id byte 5, and
// zeroes the score. side_end, side_89d8, side_89dc, and side_score use
// current_side directly. Bases, the wiped ships, and ids are masked
// with 3, matching 1000:1ece.

// @proc 1000:1f1c
// status: tested
// Odin: update_side_ships
// 1000:1f1c  FUN_1000_1f1c:
// 1000:1f1c      b1 00                    MOV CL,0x0
// 1000:1f1e      c6 06 95 a2 00           MOV byte ptr [0xa295],0x0
// 1000:1f23  LAB_1000_1f23:
// 1000:1f23      fe 06 95 a2              INC byte ptr [0xa295]
// 1000:1f27      51                       PUSH CX
// 1000:1f28      f6 05 80                 TEST byte ptr [DI],0x80
// 1000:1f2b      74 14                    JZ 0x1000:1f41
// 1000:1f2d      e8 25 01                 CALL 0x1000:2055
// 1000:1f30      e8 58 02                 CALL 0x1000:218b
// 1000:1f33      e8 36 03                 CALL 0x1000:226c
// 1000:1f36      e8 aa 01                 CALL 0x1000:20e3
// 1000:1f39      e8 ce 01                 CALL 0x1000:210a
// 1000:1f3c      f6 05 80                 TEST byte ptr [DI],0x80
// 1000:1f3f      75 1d                    JNZ 0x1000:1f5e
// 1000:1f41  LAB_1000_1f41:
// 1000:1f41      fe 0e 95 a2              DEC byte ptr [0xa295]
// 1000:1f45      f6 05 ff                 TEST byte ptr [DI],0xff
// 1000:1f48      75 0d                    JNZ 0x1000:1f57
// 1000:1f4a      59                       POP CX
// 1000:1f4b      51                       PUSH CX
// 1000:1f4c      e8 0a 25                 CALL 0x1000:4459
// 1000:1f4f      72 0d                    JC 0x1000:1f5e
// 1000:1f51      fe 06 95 a2              INC byte ptr [0xa295]
// 1000:1f55      eb 07                    JMP 0x1000:1f5e
// 1000:1f57  LAB_1000_1f57:
// 1000:1f57      fe 0d                    DEC byte ptr [DI]
// 1000:1f59      75 03                    JNZ 0x1000:1f5e
// 1000:1f5b      e8 a4 00                 CALL 0x1000:2002
// 1000:1f5e  LAB_1000_1f5e:
// 1000:1f5e      83 c7 3b                 ADD DI,0x3b
// 1000:1f61      59                       POP CX
// 1000:1f62      fe c1                    INC CL
// 1000:1f64      80 f9 04                 CMP CL,0x4
// 1000:1f67      72 ba                    JC 0x1000:1f23
// 1000:1f69      e8 62 ff                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:1f74  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
// 1000:1f74  LAB_1000_1f74:
// 1000:1f74      8b f3                    MOV SI,BX
// 1000:1f76      8a 1e 74 a2              MOV BL,byte ptr [0xa274]
// 1000:1f7a      b7 00                    MOV BH,0x0
// 1000:1f7c      80 bf e0 89 00           CMP byte ptr [BX + 0x89e0],0x0
// 1000:1f81      75 7e                    JNZ 0x1000:2001
// 1000:1f83      80 bf d8 89 01           CMP byte ptr [BX + 0x89d8],0x1
// 1000:1f88      75 05                    JNZ 0x1000:1f8f
// 1000:1f8a      b0 03                    MOV AL,0x3
// 1000:1f8c      eb 26                    JMP 0x1000:1fb4
// 1000:1f8f  LAB_1000_1f8f:
// 1000:1f8f      83 7c 08 00              CMP word ptr [SI + 0x8],0x0
// 1000:1f93      75 0d                    JNZ 0x1000:1fa2
// 1000:1f95      c6 44 0a 00              MOV byte ptr [SI + 0xa],0x0
// 1000:1f99      80 7c 0d 00              CMP byte ptr [SI + 0xd],0x0
// 1000:1f9d      74 03                    JZ 0x1000:1fa2
// 1000:1f9f      fe 4c 0d                 DEC byte ptr [SI + 0xd]
// 1000:1fa2  LAB_1000_1fa2:
// 1000:1fa2      a0 95 a2                 MOV AL,[0xa295]
// 1000:1fa5      02 44 0a                 ADD AL,byte ptr [SI + 0xa]
// 1000:1fa8      88 87 dc 89              MOV byte ptr [BX + 0x89dc],AL
// 1000:1fac      3c 00                    CMP AL,0x0
// 1000:1fae      b0 01                    MOV AL,0x1
// 1000:1fb0      74 02                    JZ 0x1000:1fb4
// 1000:1fb2      b0 00                    MOV AL,0x0
// 1000:1fb4  LAB_1000_1fb4:
// 1000:1fb4      88 87 e0 89              MOV byte ptr [BX + 0x89e0],AL
// 1000:1fb8      3c 00                    CMP AL,0x0
// 1000:1fba      74 45                    JZ 0x1000:2001
// 1000:1fbc      c6 44 0a 00              MOV byte ptr [SI + 0xa],0x0
// 1000:1fc0      c7 44 08 00 00           MOV word ptr [SI + 0x8],0x0
// 1000:1fc5      c6 44 0d 00              MOV byte ptr [SI + 0xd],0x0
// 1000:1fc9      e8 02 ff                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:1fd4  [ptr] 1000:8c64 1000:8d50 1000:8e3c 1000:8f28
// 1000:1fd4  LAB_1000_1fd4:
// 1000:1fd4      b9 04 00                 MOV CX,0x4
// 1000:1fd7  LAB_1000_1fd7:
// 1000:1fd7      f6 07 80                 TEST byte ptr [BX],0x80
// 1000:1fda      74 03                    JZ 0x1000:1fdf
// 1000:1fdc      c6 07 00                 MOV byte ptr [BX],0x0
// 1000:1fdf  LAB_1000_1fdf:
// 1000:1fdf      83 c3 3b                 ADD BX,0x3b
// 1000:1fe2      e2 f3                    LOOP 0x1000:1fd7
// 1000:1fe4      e8 e7 fe                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:1fef  [ptr] 1000:a226 1000:a231 1000:a23c 1000:a247
// 1000:1fef  LAB_1000_1fef:
// 1000:1fef      c6 47 05 00              MOV byte ptr [BX + 0x5],0x0
// 1000:1ff3      8a 1e 74 a2              MOV BL,byte ptr [0xa274]
// 1000:1ff7      32 ff                    XOR BH,BH
// 1000:1ff9      d1 e3                    SHL BX,0x1
// 1000:1ffb      c7 87 e4 89 00 00        MOV word ptr [BX + 0x89e4],0x0
// 1000:2001  LAB_1000_2001:
// 1000:2001      c3                       RET

update_side_ships :: proc(ds: ^DS_Segment, ships: ^[4]Ship_Record) {
	ds.byte_a295 = 0
	for index in 0 ..< 4 {
		ds.byte_a295 += 1
		ship := &ships[index]
		if ship.flags & 0x80 != 0 {
			charge_impulse_and_heal(ds, ship)
			slew_impulse(ship)
			drain_invisibility(ds, ship)
			apply_damage_thresholds(ship)
			apply_energy_charge(ds, ship)
			if ship.flags & 0x80 != 0 {
				continue
			}
		}
		ds.byte_a295 -= 1
		if ship.flags == 0 {
			if !spawn_ship(ds, ship, u8(index)) {
				ds.byte_a295 += 1
			}
		} else {
			ship.flags -= 1
			if ship.flags == 0 {
				spawn_debris(ds, ship)
			}
		}
	}

	side := ds.current_side
	if ds.side_end[side] != 0 {
		return
	}

	base := &ds.bases[side & 3]
	end_code: u8 = 0
	if ds.side_89d8[side] == 1 {
		end_code = 3
	} else {
		energy := u16(base[8]) | u16(base[9]) << 8
		if energy == 0 {
			base[0x0A] = 0
			if base[0x0D] != 0 {
				base[0x0D] -= 1
			}
		}
		sum, _ := intrinsics.overflow_add(ds.byte_a295, base[0x0A])
		ds.side_89dc[side] = sum
		if sum == 0 {
			end_code = 1
		}
	}
	ds.side_end[side] = end_code
	if end_code == 0 {
		return
	}

	base[0x0A] = 0
	base[8] = 0
	base[9] = 0
	base[0x0D] = 0
	side_ships := &ds.ships[side & 3]
	for &slot in side_ships {
		if slot.flags & 0x80 != 0 {
			slot.flags = 0
		}
	}
	ds.ids[side & 3][5] = 0
	ds.side_score[side] = 0
}

// 1000:3228 planet_array_for_level.
// The notes already use this name. AL selects one of the four 11-byte
// planet arrays. 0, 1, and 2 are 92CC, 963C, and 99AC. Any other byte,
// including 3 and above, is 9D1C. The level is not masked with 3.
// CX is objects_per_level at DS:0000, zero-extended, and it is not
// clamped to the 0x50 records in the array. 1000:3225 loads AL from
// the record at SI+5 and falls into this entry. That wrapper is
// planet_array_for_record.

// @proc 1000:3228
// status: tested
// Odin: planet_array_for_level
// 1000:3228  FUN_1000_3228:
// 1000:3228      bf cc 92                 MOV DI,0x92cc
// 1000:322b      22 c0                    AND AL,AL
// 1000:322d      74 11                    JZ 0x1000:3240
// 1000:322f      bf 3c 96                 MOV DI,0x963c
// 1000:3232      fe c8                    DEC AL
// 1000:3234      74 0a                    JZ 0x1000:3240
// 1000:3236      bf ac 99                 MOV DI,0x99ac
// 1000:3239      fe c8                    DEC AL
// 1000:323b      74 03                    JZ 0x1000:3240
// 1000:323d      bf 1c 9d                 MOV DI,0x9d1c
// 1000:3240  LAB_1000_3240:
// 1000:3240      8a 0e 00 00              MOV CL,byte ptr [0x0]
// 1000:3244      32 ed                    XOR CH,CH
// 1000:3246      c3                       RET

planet_array_for_level :: proc(ds: ^DS_Segment, level: u8) -> (array: ^[0x50][11]u8, count: u16) {
	index := 3
	if level == 0 {
		index = 0
	} else if level == 1 {
		index = 1
	} else if level == 2 {
		index = 2
	}
	return &ds.planets[index], u16(ds.objects_per_level)
}

// 1000:1970 to_upper.
// The notes already use this name. A byte from 'a' through 'z' loses
// bit 5. Anything outside that range is unchanged.

// @proc 1000:1970
// status: tested
// Odin: to_upper
// 1000:1970  FUN_1000_1970:
// 1000:1970      3c 61                    CMP AL,0x61
// 1000:1972      72 06                    JC 0x1000:197a
// 1000:1974      3c 7a                    CMP AL,0x7a
// 1000:1976      77 02                    JA 0x1000:197a
// 1000:1978      24 5f                    AND AL,0x5f
// 1000:197a  LAB_1000_197a:
// 1000:197a      c3                       RET

to_upper :: proc(al: u8) -> u8 {
	if al >= 'a' && al <= 'z' {
		return al & 0x5F
	}
	return al
}

// 1000:0b07 key_is_down.
// The notes already use this name. ZF is set when AL is '+' or 0xD0.
// The bool is that flag: true means the key is down.

// @proc 1000:0b07
// status: tested
// Odin: key_is_down
// 1000:0b07  FUN_1000_0b07:
// 1000:0b07      3c 2b                    CMP AL,0x2b
// 1000:0b09      74 02                    JZ 0x1000:0b0d
// 1000:0b0b      3c d0                    CMP AL,0xd0
// 1000:0b0d  LAB_1000_0b0d:
// 1000:0b0d      c3                       RET

key_is_down :: proc(al: u8) -> bool {
	return al == '+' || al == 0xD0
}

// 1000:0b0e key_is_up.
// The notes already use this name. ZF is set when AL is '-' or 0xC8.

// @proc 1000:0b0e
// status: tested
// Odin: key_is_up
// 1000:0b0e  FUN_1000_0b0e:
// 1000:0b0e      3c 2d                    CMP AL,0x2d
// 1000:0b10      74 02                    JZ 0x1000:0b14
// 1000:0b12      3c c8                    CMP AL,0xc8
// 1000:0b14  LAB_1000_0b14:
// 1000:0b14      c3                       RET

key_is_up :: proc(al: u8) -> bool {
	return al == '-' || al == 0xC8
}

// 1000:0b15 toggle_player_count.
// The notes already use this name. A player count of 1 becomes 2.
// Every other value, including 0, becomes 1.

// @proc 1000:0b15
// status: tested
// Odin: toggle_player_count
// 1000:0b15  FUN_1000_0b15:
// 1000:0b15      80 3e 0a 00 01           CMP byte ptr [0xa],0x1
// 1000:0b1a      74 06                    JZ 0x1000:0b22
// 1000:0b1c      c6 06 0a 00 01           MOV byte ptr [0xa],0x1
// 1000:0b21      c3                       RET
// 1000:0b22  LAB_1000_0b22:
// 1000:0b22      c6 06 0a 00 02           MOV byte ptr [0xa],0x2
// 1000:0b27      c3                       RET

toggle_player_count :: proc(ds: ^DS_Segment) {
	if ds.player_count == 1 {
		ds.player_count = 2
		return
	}
	ds.player_count = 1
}

// 1000:0b28 cycle_computer_count.
// The notes already use this name. Bits 2–3 of mode_bits cycle
// 00, then 04, then 0C, then back to 00. Every other bit stays.

// @proc 1000:0b28
// status: tested
// Odin: cycle_computer_count
// 1000:0b28  FUN_1000_0b28:
// 1000:0b28      a0 12 00                 MOV AL,[0x12]
// 1000:0b2b      24 0c                    AND AL,0xc
// 1000:0b2d      75 06                    JNZ 0x1000:0b35
// 1000:0b2f      80 0e 12 00 04           OR byte ptr [0x12],0x4
// 1000:0b34      c3                       RET
// 1000:0b35  LAB_1000_0b35:
// 1000:0b35      3c 04                    CMP AL,0x4
// 1000:0b37      75 06                    JNZ 0x1000:0b3f
// 1000:0b39      80 0e 12 00 08           OR byte ptr [0x12],0x8
// 1000:0b3e      c3                       RET
// 1000:0b3f  LAB_1000_0b3f:
// 1000:0b3f      80 26 12 00 f3           AND byte ptr [0x12],0xf3
// 1000:0b44      c3                       RET

cycle_computer_count :: proc(ds: ^DS_Segment) {
	masked := ds.mode_bits & 0x0C
	if masked == 0 {
		ds.mode_bits |= 0x04
		return
	}
	if masked == 0x04 {
		ds.mode_bits |= 0x08
		return
	}
	ds.mode_bits &= 0xF3
}

// 1000:2b52 abs_word.
// The name is inferred. Bit 15 selects NEG. NEG of 0x8000 stays 0x8000.

// @proc 1000:2b52
// status: tested
// Odin: abs_word
// 1000:2b52  FUN_1000_2b52:
// 1000:2b52      f7 c3 00 80              TEST BX,0x8000
// 1000:2b56      74 02                    JZ 0x1000:2b5a
// 1000:2b58      f7 db                    NEG BX
// 1000:2b5a  LAB_1000_2b5a:
// 1000:2b5a      c3                       RET

abs_word :: proc(bx: u16) -> u16 {
	if bx & 0x8000 != 0 {
		return neg16(bx)
	}
	return bx
}

// 1000:2b36 short_delta.
// The name is inferred. Both callers subtract a word into BX and then
// call here, so the sign flag is bit 15 of BX. A positive value below
// 0x2000 is unchanged. A positive value at or above 0x2000 loses 0x4000
// and is returned still negative. A negative value is negated, and if
// that absolute value is below 0x2000 it is negated back. Otherwise
// 0x4000 is subtracted before the second negate. NEG of 0x8000 stays
// 0x8000, so that input returns 0xC000.

// @proc 1000:2b36
// status: tested
// Odin: short_delta
// 1000:2b36  FUN_1000_2b36:
// 1000:2b36      78 0b                    JS 0x1000:2b43
// 1000:2b38      81 fb 00 20              CMP BX,0x2000
// 1000:2b3c      72 13                    JC 0x1000:2b51
// 1000:2b3e      81 eb 00 40              SUB BX,0x4000
// 1000:2b42      c3                       RET
// 1000:2b43  LAB_1000_2b43:
// 1000:2b43      f7 db                    NEG BX
// 1000:2b45      81 fb 00 20              CMP BX,0x2000
// 1000:2b49      72 04                    JC 0x1000:2b4f
// 1000:2b4b      81 eb 00 40              SUB BX,0x4000
// 1000:2b4f  LAB_1000_2b4f:
// 1000:2b4f      f7 db                    NEG BX
// 1000:2b51  LAB_1000_2b51:
// 1000:2b51      c3                       RET

short_delta :: proc(bx: u16) -> u16 {
	if bx & 0x8000 == 0 {
		if bx < 0x2000 {
			return bx
		}
		return sub16(bx, 0x4000)
	}
	abs := neg16(bx)
	if abs >= 0x2000 {
		abs = sub16(abs, 0x4000)
	}
	return neg16(abs)
}

// 1000:37a1 cap_weapons_cooldown.
// The name is inferred. A weapons cooldown above 0x0C is stored as 0x0C.
// 0x0C itself stays.

// @proc 1000:37a1
// status: tested
// Odin: cap_weapons_cooldown
// 1000:37a1  FUN_1000_37a1:
// 1000:37a1      80 7d 15 0c              CMP byte ptr [DI + 0x15],0xc
// 1000:37a5      76 04                    JBE 0x1000:37ab
// 1000:37a7      c6 45 15 0c              MOV byte ptr [DI + 0x15],0xc
// 1000:37ab  LAB_1000_37ab:
// 1000:37ab      c3                       RET

cap_weapons_cooldown :: proc(ship: ^Ship_Record) {
	if ship.weapons_cooldown > 0x0C {
		ship.weapons_cooldown = 0x0C
	}
}

// 1000:1cc3 set_invisible_bit.
// The name is inferred. An invisibility charge of at least 1 ORs flag
// bit 0x10. A charge of 0 leaves the flags alone, including that bit.
// 1000:1ccd is a command loop in the same listing. This entry returns
// before it, and that loop stays unread.

// @proc 1000:1cc3
// status: tested
// Odin: set_invisible_bit
// 1000:1cc3  FUN_1000_1cc3:
// 1000:1cc3      80 7c 0f 01              CMP byte ptr [SI + 0xf],0x1
// 1000:1cc7      72 03                    JC 0x1000:1ccc
// 1000:1cc9      80 0c 10                 OR byte ptr [SI],0x10
// 1000:1ccc  LAB_1000_1ccc:
// 1000:1ccc      c3                       RET
// 1000:1ccd  LAB_1000_1ccd:
// 1000:1ccd      e8 c2 01                 CALL 0x1000:1e92
// 1000:1cd0      e8 08 00                 CALL 0x1000:1cdb
// 1000:1cd3      8b 74 32                 MOV SI,word ptr [SI + 0x32]
// 1000:1cd6      23 f6                    AND SI,SI
// 1000:1cd8      75 f3                    JNZ 0x1000:1ccd
// 1000:1cda      c3                       RET

set_invisible_bit :: proc(ship: ^Ship_Record) {
	if ship.invisibility >= 1 {
		ship.flags |= 0x10
	}
}

// 1000:31d1 decay_impulse.
// The name is inferred. The whole impulse byte decrements when seek's
// low 5 bits are 0, byte 0x16 has bit 2 set, byte 0x2A is above 2, and
// the actual impulse nibble is above 6. That nibble check means the
// decrement does not borrow into the desired nibble.

// @proc 1000:31d1
// status: tested
// Odin: decay_impulse
// 1000:31d1  FUN_1000_31d1:
// 1000:31d1      f6 45 11 1f              TEST byte ptr [DI + 0x11],0x1f
// 1000:31d5      75 18                    JNZ 0x1000:31ef
// 1000:31d7      f6 45 16 04              TEST byte ptr [DI + 0x16],0x4
// 1000:31db      74 12                    JZ 0x1000:31ef
// 1000:31dd      80 7d 2a 02              CMP byte ptr [DI + 0x2a],0x2
// 1000:31e1      76 0c                    JBE 0x1000:31ef
// 1000:31e3      8a 45 0b                 MOV AL,byte ptr [DI + 0xb]
// 1000:31e6      24 0f                    AND AL,0xf
// 1000:31e8      3c 06                    CMP AL,0x6
// 1000:31ea      76 03                    JBE 0x1000:31ef
// 1000:31ec      fe 4d 0b                 DEC byte ptr [DI + 0xb]
// 1000:31ef  LAB_1000_31ef:
// 1000:31ef      c3                       RET

decay_impulse :: proc(ship: ^Ship_Record) {
	if ship.seek & 0x1F != 0 {
		return
	}
	if ship.byte_16 & 0x04 == 0 {
		return
	}
	if ship.byte_2a <= 2 {
		return
	}
	if ship.impulse & 0x0F <= 6 {
		return
	}
	next, _ := intrinsics.overflow_sub(ship.impulse, 1)
	ship.impulse = next
}

// 1000:1a97 store_if_local_ship.
// AX is written at DS:BX when (current_side XOR local_side) & 3 is 0.
// A word stored at FFFF wraps the high byte onto 0000.
// The entry returns at 1aa6. The bytes from 1aa7 through 1b77 are the
// rest of this listing and stay unread.

// @proc 1000:1a97
// status: tested
// Odin: store_if_local_ship
// 1000:1a97  FUN_1000_1a97:
// 1000:1a97      50                       PUSH AX
// 1000:1a98      a0 74 a2                 MOV AL,[0xa274]
// 1000:1a9b      32 06 6f a2              XOR AL,byte ptr [0xa26f]
// 1000:1a9f      24 03                    AND AL,0x3
// 1000:1aa1      58                       POP AX
// 1000:1aa2      75 02                    JNZ 0x1000:1aa6
// 1000:1aa4      89 07                    MOV word ptr [BX],AX
// 1000:1aa6  LAB_1000_1aa6:
// 1000:1aa6      c3                       RET
// 1000:1aa7      b0 01                    MOV AL,0x1
// 1000:1aa9      8a 0e 74 a2              MOV CL,byte ptr [0xa274]
// 1000:1aad      d2 e0                    SHL AL,CL
// 1000:1aaf      84 06 6c a2              TEST byte ptr [0xa26c],AL
// 1000:1ab3      74 0c                    JZ 0x1000:1ac1
// 1000:1ab5      f6 06 6c a2 80           TEST byte ptr [0xa26c],0x80
// 1000:1aba      74 1c                    JZ 0x1000:1ad8
// 1000:1abc      30 06 6c a2              XOR byte ptr [0xa26c],AL
// 1000:1ac0      c3                       RET
// 1000:1ac1  LAB_1000_1ac1:
// 1000:1ac1      f6 06 6c a2 80           TEST byte ptr [0xa26c],0x80
// 1000:1ac6      75 10                    JNZ 0x1000:1ad8
// 1000:1ac8      30 06 6c a2              XOR byte ptr [0xa26c],AL
// 1000:1acc      80 3e 6d a2 00           CMP byte ptr [0xa26d],0x0
// 1000:1ad1      75 05                    JNZ 0x1000:1ad8
// 1000:1ad3      c6 06 6d a2 07           MOV byte ptr [0xa26d],0x7
// 1000:1ad8  LAB_1000_1ad8:
// 1000:1ad8      c3                       RET
// 1000:1ad9      b0 00                    MOV AL,0x0
// 1000:1adb      eb 0a                    JMP 0x1000:1ae7
// 1000:1add  LAB_1000_1add:
// 1000:1add      b0 01                    MOV AL,0x1
// 1000:1adf      eb 06                    JMP 0x1000:1ae7
// 1000:1ae1      b0 02                    MOV AL,0x2
// 1000:1ae3      eb 02                    JMP 0x1000:1ae7
// 1000:1ae5      b0 03                    MOV AL,0x3
// 1000:1ae7  LAB_1000_1ae7:
// 1000:1ae7      50                       PUSH AX
// 1000:1ae8      e8 21 0f                 CALL 0x1000:2a0c
// 1000:1aeb      74 0e                    JZ 0x1000:1afb
// 1000:1aed      89 36 50 a3              MOV word ptr [0xa350],SI
// 1000:1af1      e8 cd 03                 CALL 0x1000:1ec1
// 1000:1af4      80 27 e8                 AND byte ptr [BX],0xe8
// 1000:1af7      58                       POP AX
// 1000:1af8      08 07                    OR byte ptr [BX],AL
// 1000:1afa      c3                       RET
// 1000:1afb  LAB_1000_1afb:
// 1000:1afb      58                       POP AX
// 1000:1afc      c3                       RET
// 1000:1afd      b0 00                    MOV AL,0x0
// 1000:1aff      eb 46                    JMP 0x1000:1b47
// 1000:1b01      b0 01                    MOV AL,0x1
// 1000:1b03      eb 42                    JMP 0x1000:1b47
// 1000:1b05      b0 02                    MOV AL,0x2
// 1000:1b07      eb 3e                    JMP 0x1000:1b47
// 1000:1b09      b0 03                    MOV AL,0x3
// 1000:1b0b      eb 3a                    JMP 0x1000:1b47
// 1000:1b0d      b0 04                    MOV AL,0x4
// 1000:1b0f      eb 36                    JMP 0x1000:1b47
// 1000:1b11      b0 05                    MOV AL,0x5
// 1000:1b13      eb 32                    JMP 0x1000:1b47
// 1000:1b15      b0 06                    MOV AL,0x6
// 1000:1b17      eb 2e                    JMP 0x1000:1b47
// 1000:1b19      b0 07                    MOV AL,0x7
// 1000:1b1b      eb 2a                    JMP 0x1000:1b47
// 1000:1b1d      b0 08                    MOV AL,0x8
// 1000:1b1f      eb 26                    JMP 0x1000:1b47
// 1000:1b21      b0 09                    MOV AL,0x9
// 1000:1b23      eb 22                    JMP 0x1000:1b47
// 1000:1b25      b0 0a                    MOV AL,0xa
// 1000:1b27      eb 1e                    JMP 0x1000:1b47
// 1000:1b29      b0 0b                    MOV AL,0xb
// 1000:1b2b      eb 1a                    JMP 0x1000:1b47
// 1000:1b2d      b0 0c                    MOV AL,0xc
// 1000:1b2f      eb 16                    JMP 0x1000:1b47
// 1000:1b31      b0 0d                    MOV AL,0xd
// 1000:1b33      eb 12                    JMP 0x1000:1b47
// 1000:1b35      b0 0e                    MOV AL,0xe
// 1000:1b37      eb 0e                    JMP 0x1000:1b47
// 1000:1b39      b0 10                    MOV AL,0x10
// 1000:1b3b      eb 0a                    JMP 0x1000:1b47
// 1000:1b3d      b0 11                    MOV AL,0x11
// 1000:1b3f      eb 06                    JMP 0x1000:1b47
// 1000:1b41      b0 12                    MOV AL,0x12
// 1000:1b43      eb 02                    JMP 0x1000:1b47
// 1000:1b45      b0 13                    MOV AL,0x13
// 1000:1b47  LAB_1000_1b47:
// 1000:1b47      e8 48 03                 CALL 0x1000:1e92
// 1000:1b4a      88 44 11                 MOV byte ptr [SI + 0x11],AL
// 1000:1b4d      a8 10                    TEST AL,0x10
// 1000:1b4f      74 18                    JZ 0x1000:1b69
// 1000:1b51      b9 05 00                 MOV CX,0x5
// 1000:1b54  LAB_1000_1b54:
// 1000:1b54      56                       PUSH SI
// 1000:1b55      e8 b4 0e                 CALL 0x1000:2a0c
// 1000:1b58      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
// 1000:1b5b      5e                       POP SI
// 1000:1b5c      a8 10                    TEST AL,0x10
// 1000:1b5e      74 09                    JZ 0x1000:1b69
// 1000:1b60      e2 f2                    LOOP 0x1000:1b54
// 1000:1b62      c6 44 11 00              MOV byte ptr [SI + 0x11],0x0
// 1000:1b66      e9 ff fe                 JMP 0x1000:1a68
// 1000:1b69  LAB_1000_1b69:
// 1000:1b69      80 7c 0b 50              CMP byte ptr [SI + 0xb],0x50
// 1000:1b6d      77 08                    JA 0x1000:1b77
// 1000:1b6f      80 64 0b 0f              AND byte ptr [SI + 0xb],0xf
// 1000:1b73      80 4c 0b 50              OR byte ptr [SI + 0xb],0x50
// 1000:1b77  LAB_1000_1b77:
// 1000:1b77      c3                       RET

store_if_local_ship :: proc(ds: ^DS_Segment, bx, ax: u16) {
	if (ds.current_side ~ ds.local_side) & 3 != 0 {
		return
	}
	raw := transmute(^[DS_SIZE]u8)ds
	write_u16(raw, bx, ax)
}

// 1000:1ec1 ship_flag_ptr.
// BX is side_flags indexed by current_side masked with 3. Side 5
// selects the second byte.

// @proc 1000:1ec1
// status: tested
// Odin: ship_flag_ptr
// 1000:1ec1  FUN_1000_1ec1:
// 1000:1ec1      8a 1e 74 a2              MOV BL,byte ptr [0xa274]
// 1000:1ec5      81 e3 03 00              AND BX,0x3
// 1000:1ec9      81 c3 d4 89              ADD BX,0x89d4
// 1000:1ecd      c3                       RET

ship_flag_ptr :: proc(ds: ^DS_Segment) -> ^u8 {
	return &ds.side_flags[ds.current_side & 3]
}

// 1000:2a0c ship_ptr_from_al.
// AL keeps its low 2 bits. current_side is shifted left twice as a byte,
// so bits above the low 6 fall off, and that byte is ORed in. The record
// is 0x8C64 plus the index times 0x3B. Bit 7 of the first byte is the
// alive flag. An index of 16 or more is past the 16 ship records: side 4
// addresses the first base, and the pointer is nil. The alive bit is
// still read from that byte.

// @proc 1000:2a0c
// status: tested
// Odin: ship_ptr_from_al
// 1000:2a0c  FUN_1000_2a0c:
// 1000:2a0c      24 03                    AND AL,0x3
// 1000:2a0e      8a 26 74 a2              MOV AH,byte ptr [0xa274]
// 1000:2a12      d0 e4                    SHL AH,0x1
// 1000:2a14      d0 e4                    SHL AH,0x1
// 1000:2a16      0a c4                    OR AL,AH
// 1000:2a18      b4 3b                    MOV AH,0x3b
// 1000:2a1a      f6 e4                    MUL AH
// 1000:2a1c      be 64 8c                 MOV SI,0x8c64
// 1000:2a1f      03 f0                    ADD SI,AX
// 1000:2a21      8a 04                    MOV AL,byte ptr [SI]
// 1000:2a23      24 80                    AND AL,0x80
// 1000:2a25      c3                       RET

ship_ptr_from_al :: proc(ds: ^DS_Segment, al: u8) -> (ship: ^Ship_Record, alive: bool) {
	index := (al & 3) | u8(u16(ds.current_side) << 2)
	off := add16(u16(offset_of(DS_Segment, ships)), u16(index) * 0x3B)
	raw := transmute(^[DS_SIZE]u8)ds
	alive = raw[off] & 0x80 != 0
	if index < 16 {
		ship = &ds.ships[index >> 2][index & 3]
	}
	return
}

// 1000:2ed4 add_score_div100.
// BH is cleared, so only BL selects the side. BL of 4 or more returns.
// AX is divided by 100. A remainder of 0x32 or more increments the
// quotient, and that word is added to side_score[BL]. The add wraps.

// @proc 1000:2ed4
// status: tested
// Odin: add_score_div100
// 1000:2ed4  FUN_1000_2ed4:
// 1000:2ed4      32 ff                    XOR BH,BH
// 1000:2ed6      83 fb 04                 CMP BX,0x4
// 1000:2ed9      73 17                    JNC 0x1000:2ef2
// 1000:2edb      d1 e3                    SHL BX,0x1
// 1000:2edd      52                       PUSH DX
// 1000:2ede      53                       PUSH BX
// 1000:2edf      33 d2                    XOR DX,DX
// 1000:2ee1      bb 64 00                 MOV BX,0x64
// 1000:2ee4      f7 f3                    DIV BX
// 1000:2ee6      83 fa 32                 CMP DX,0x32
// 1000:2ee9      72 01                    JC 0x1000:2eec
// 1000:2eeb      40                       INC AX
// 1000:2eec  LAB_1000_2eec:
// 1000:2eec      5b                       POP BX
// 1000:2eed      5a                       POP DX
// 1000:2eee      01 87 e4 89              ADD word ptr [BX + 0x89e4],AX
// 1000:2ef2  LAB_1000_2ef2:
// 1000:2ef2      c3                       RET

add_score_div100 :: proc(ds: ^DS_Segment, bl: u8, ax: u16) {
	if bl >= 4 {
		return
	}
	quot := ax / 100
	if ax % 100 >= 0x32 {
		quot += 1
	}
	sum, _ := intrinsics.overflow_add(ds.side_score[bl], quot)
	ds.side_score[bl] = sum
}

// 1000:1cdb apply_warp.
// The name is inferred. Seek bit 7 is cleared. Flag bits 0x44 force
// the actual impulse nibble to 11. The impulse byte is then stored
// with desired nibble 11. Warp above 0x5A becomes 0x64. Otherwise it
// gains 10. The entry returns at 1cfb or 1d00. The bytes from 1d01
// are a command loop in this listing and stay unread.

// @proc 1000:1cdb
// status: tested
// Odin: apply_warp
// 1000:1cdb  FUN_1000_1cdb:
// 1000:1cdb      80 64 11 7f              AND byte ptr [SI + 0x11],0x7f
// 1000:1cdf      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
// 1000:1ce2      24 0f                    AND AL,0xf
// 1000:1ce4      f6 04 44                 TEST byte ptr [SI],0x44
// 1000:1ce7      74 02                    JZ 0x1000:1ceb
// 1000:1ce9      b0 0b                    MOV AL,0xb
// 1000:1ceb  LAB_1000_1ceb:
// 1000:1ceb      0c b0                    OR AL,0xb0
// 1000:1ced      88 44 0b                 MOV byte ptr [SI + 0xb],AL
// 1000:1cf0      8a 44 14                 MOV AL,byte ptr [SI + 0x14]
// 1000:1cf3      3c 5a                    CMP AL,0x5a
// 1000:1cf5      77 05                    JA 0x1000:1cfc
// 1000:1cf7      80 44 14 0a              ADD byte ptr [SI + 0x14],0xa
// 1000:1cfb      c3                       RET
// 1000:1cfc  LAB_1000_1cfc:
// 1000:1cfc      c6 44 14 64              MOV byte ptr [SI + 0x14],0x64
// 1000:1d00      c3                       RET
// 1000:1d01  LAB_1000_1d01:
// 1000:1d01      e8 8e 01                 CALL 0x1000:1e92
// 1000:1d04      e8 08 00                 CALL 0x1000:1d0f
// 1000:1d07      8b 74 32                 MOV SI,word ptr [SI + 0x32]
// 1000:1d0a      23 f6                    AND SI,SI
// 1000:1d0c      75 f3                    JNZ 0x1000:1d01
// 1000:1d0e      c3                       RET

apply_warp :: proc(ship: ^Ship_Record) {
	ship.seek &= 0x7F
	nibble := ship.impulse & 0x0F
	if ship.flags & 0x44 != 0 {
		nibble = 0x0B
	}
	ship.impulse = nibble | 0xB0
	if ship.warp > 0x5A {
		ship.warp = 0x64
	} else {
		ship.warp += 0x0A
	}
}

// 1000:1d0f emergency_stop.
// The name is inferred. AX is the actual impulse nibble. A nibble above
// 10 is replaced with 0x14, then AX is shifted left 5 and passed to
// add_pending_charge. Warp and the whole impulse byte are cleared.
// The entry returns at 1d2e. The bytes from 1d2f are a command loop in
// this listing and stay unread. That loop calls 1000:1ece.

// @proc 1000:1d0f
// status: tested
// Odin: emergency_stop
// 1000:1d0f  FUN_1000_1d0f:
// 1000:1d0f      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
// 1000:1d12      25 0f 00                 AND AX,0xf
// 1000:1d15      3d 0a 00                 CMP AX,0xa
// 1000:1d18      76 03                    JBE 0x1000:1d1d
// 1000:1d1a      b8 14 00                 MOV AX,0x14
// 1000:1d1d  LAB_1000_1d1d:
// 1000:1d1d      b1 05                    MOV CL,0x5
// 1000:1d1f      d3 e0                    SHL AX,CL
// 1000:1d21      c6 44 14 00              MOV byte ptr [SI + 0x14],0x0
// 1000:1d25      c6 44 0b 00              MOV byte ptr [SI + 0xb],0x0
// 1000:1d29      8b fe                    MOV DI,SI
// 1000:1d2b      e8 6d 06                 CALL 0x1000:239b
// 1000:1d2e      c3                       RET
// 1000:1d2f  LAB_1000_1d2f:
// 1000:1d2f      e8 60 01                 CALL 0x1000:1e92
// 1000:1d32      c6 44 22 00              MOV byte ptr [SI + 0x22],0x0
// 1000:1d36      80 7c 15 14              CMP byte ptr [SI + 0x15],0x14
// 1000:1d3a      77 17                    JA 0x1000:1d53
// 1000:1d3c      e8 8f 01                 CALL 0x1000:1ece
// 1000:1d47  LAB_1000_1d47:
// 1000:1d47      8b fb                    MOV DI,BX
// 1000:1d49      87 fe                    XCHG SI,DI
// 1000:1d4b      80 7d 06 00              CMP byte ptr [DI + 0x6],0x0
// 1000:1d4f      75 13                    JNZ 0x1000:1d64
// 1000:1d51      87 fe                    XCHG SI,DI
// 1000:1d53  LAB_1000_1d53:
// 1000:1d53      8b 74 32                 MOV SI,word ptr [SI + 0x32]
// 1000:1d56      23 f6                    AND SI,SI
// 1000:1d58      75 d5                    JNZ 0x1000:1d2f
// 1000:1d5a      b8 04 00                 MOV AX,0x4
// 1000:1d5d      bb 5a a2                 MOV BX,0xa25a
// 1000:1d60      e8 34 fd                 CALL 0x1000:1a97
// 1000:1d63      c3                       RET

emergency_stop :: proc(ship: ^Ship_Record) {
	ax := u16(ship.impulse & 0x0F)
	if ax > 10 {
		ax = 0x14
	}
	ax = shl_word(ax, 5)
	ship.warp = 0
	ship.impulse = 0
	add_pending_charge(ship, ax)
}
