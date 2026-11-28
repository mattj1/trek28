package trek

import "base:intrinsics"

// 1000:437a mix_rng.
// The notes call this the RNG. It mixes the low byte of frame_count into
// rng_seed and stores the word back. AX on return is that new seed.
// XOR clears carry. Even parity of the mixed byte leaves carry clear.
// Odd parity sets DL to 2 and sets carry. Four rotates through carry
// then fold the bytes into the new seed.

// @proc 1000:437a
// status: tested
// Odin: mix_rng
// 1000:437a  FUN_1000_437a:
// 1000:437a      a0 d2 89                 MOV AL,[0x89d2]
// 1000:437d      34 a5                    XOR AL,0xa5
// 1000:437f      52                       PUSH DX
// 1000:4380      53                       PUSH BX
// 1000:4381      8b 1e d0 89              MOV BX,word ptr [0x89d0]
// 1000:4385      33 d2                    XOR DX,DX
// 1000:4387      32 c7                    XOR AL,BH
// 1000:4389      7a 03                    JP 0x1000:438e
// 1000:438b      b2 02                    MOV DL,0x2
// 1000:438d      f9                       STC
// 1000:438e  LAB_1000_438e:
// 1000:438e      d0 d8                    RCR AL,0x1
// 1000:4390      8a f0                    MOV DH,AL
// 1000:4392      d0 da                    RCR DL,0x1
// 1000:4394      8a e2                    MOV AH,DL
// 1000:4396      d0 d8                    RCR AL,0x1
// 1000:4398      d0 da                    RCR DL,0x1
// 1000:439a      32 c6                    XOR AL,DH
// 1000:439c      8a f0                    MOV DH,AL
// 1000:439e      8a c2                    MOV AL,DL
// 1000:43a0      32 c4                    XOR AL,AH
// 1000:43a2      32 c3                    XOR AL,BL
// 1000:43a4      8a f8                    MOV BH,AL
// 1000:43a6      8a de                    MOV BL,DH
// 1000:43a8      89 1e d0 89              MOV word ptr [0x89d0],BX
// 1000:43ac      8b c3                    MOV AX,BX
// 1000:43ae      5b                       POP BX
// 1000:43af      5a                       POP DX
// 1000:43b0      c3                       RET

mix_rng :: proc(ds: ^DS_Segment) -> u16 {
	al := u8(ds.frame_count) ~ 0xA5
	bl := u8(ds.rng_seed)
	bh := u8(ds.rng_seed >> 8)
	al ~= bh
	dl: u8 = 0
	carry := false
	if !parity_even(al) {
		dl = 2
		carry = true
	}
	al, carry = rcr8(al, carry)
	dh := al
	dl, carry = rcr8(dl, carry)
	ah := dl
	al, carry = rcr8(al, carry)
	dl, carry = rcr8(dl, carry)
	al ~= dh
	dh = al
	al = dl
	al ~= ah
	al ~= bl
	bh = al
	bl = dh
	ds.rng_seed = u16(bh) << 8 | u16(bl)
	return ds.rng_seed
}

// 1000:428a random_base_coord.
// The name is inferred. mix_rng runs until the low 14 bits sit in
// [0x5DC, 0x3A24]. Both ends are accepted.

// @proc 1000:428a
// status: tested
// Odin: random_base_coord
// 1000:428a  FUN_1000_428a:
// 1000:428a      e8 ed 00                 CALL 0x1000:437a
// 1000:428d      25 ff 3f                 AND AX,0x3fff
// 1000:4290      3d dc 05                 CMP AX,0x5dc
// 1000:4293      72 f5                    JC 0x1000:428a
// 1000:4295      3d 24 3a                 CMP AX,0x3a24
// 1000:4298      77 f0                    JA 0x1000:428a
// 1000:429a      c3                       RET

random_base_coord :: proc(ds: ^DS_Segment) -> u16 {
	for {
		ax := mix_rng(ds) & 0x3FFF
		if ax >= 0x5DC && ax <= 0x3A24 {
			return ax
		}
	}
}

// 1000:429b random_planet_coord.
// The name is inferred. Same draw as random_base_coord, with the
// accepted window [0x1F4, 0x3E0C]. Both ends are kept.

// @proc 1000:429b
// status: tested
// Odin: random_planet_coord
// 1000:429b  FUN_1000_429b:
// 1000:429b      e8 dc 00                 CALL 0x1000:437a
// 1000:429e      25 ff 3f                 AND AX,0x3fff
// 1000:42a1      3d f4 01                 CMP AX,0x1f4
// 1000:42a4      72 f5                    JC 0x1000:429b
// 1000:42a6      3d 0c 3e                 CMP AX,0x3e0c
// 1000:42a9      77 f0                    JA 0x1000:429b
// 1000:42ab      c3                       RET

random_planet_coord :: proc(ds: ^DS_Segment) -> u16 {
	for {
		ax := mix_rng(ds) & 0x3FFF
		if ax >= 0x1F4 && ax <= 0x3E0C {
			return ax
		}
	}
}

// 1000:43b1 step_orbit.
// The notes already use this name. DI is one 11-byte planet.
// Kind 0 at +08 returns with the phase and the position unchanged.
// Kind 1 reads the 32-byte table at CS:43F9 and masks the phase with 0x1F.
// Any other kind reads the 64-byte table at CS:4419 and masks with 0x3F.
// The phase byte increments, wrapping through 0xFF. The table byte is
// sign-extended and added to X, then the phase plus 8 or 16 indexes Y.
// The position add is not masked with 0x3FFF.

// @proc 1000:43b1
// status: tested
// Odin: step_orbit
// 1000:43b1  FUN_1000_43b1:
// 1000:43b1      56                       PUSH SI
// 1000:43b2      53                       PUSH BX
// 1000:43b3      51                       PUSH CX
// 1000:43b4      52                       PUSH DX
// 1000:43b5      8a 45 08                 MOV AL,byte ptr [DI + 0x8]
// 1000:43b8      22 c0                    AND AL,AL
// 1000:43ba      74 38                    JZ 0x1000:43f4
// 1000:43bc      bb f9 43                 MOV BX,0x43f9
// 1000:43bf      b2 08                    MOV DL,0x8
// 1000:43c1      b1 1f                    MOV CL,0x1f
// 1000:43c3      fe c8                    DEC AL
// 1000:43c5      74 07                    JZ 0x1000:43ce
// 1000:43c7      bb 19 44                 MOV BX,0x4419
// 1000:43ca      b2 10                    MOV DL,0x10
// 1000:43cc      b1 3f                    MOV CL,0x3f
// 1000:43ce  LAB_1000_43ce:
// 1000:43ce      8a 45 07                 MOV AL,byte ptr [DI + 0x7]
// 1000:43d1      fe 45 07                 INC byte ptr [DI + 0x7]
// 1000:43d4      8a e8                    MOV CH,AL
// 1000:43d6      22 c1                    AND AL,CL
// 1000:43d8      32 e4                    XOR AH,AH
// 1000:43da      8b f0                    MOV SI,AX
// 1000:43dc      2e 8a 00                 MOV AL,byte ptr CS:[BX + SI]
// 1000:43df      98                       CBW
// 1000:43e0      01 45 01                 ADD word ptr [DI + 0x1],AX
// 1000:43e3      8a c5                    MOV AL,CH
// 1000:43e5      02 c2                    ADD AL,DL
// 1000:43e7      22 c1                    AND AL,CL
// 1000:43e9      32 e4                    XOR AH,AH
// 1000:43eb      8b f0                    MOV SI,AX
// 1000:43ed      2e 8a 00                 MOV AL,byte ptr CS:[BX + SI]
// 1000:43f0      98                       CBW
// 1000:43f1      01 45 03                 ADD word ptr [DI + 0x3],AX
// 1000:43f4  LAB_1000_43f4:
// 1000:43f4      5a                       POP DX
// 1000:43f5      59                       POP CX
// 1000:43f6      5b                       POP BX
// 1000:43f7      5e                       POP SI
// 1000:43f8      c3                       RET

step_orbit :: proc(m: ^Machine, di: u16) {
	kind := read_u8(&m.ds, add16(di, 8))
	if kind == 0 {
		return
	}
	table := u16(0x43F9)
	y_bias: u8 = 8
	mask: u8 = 0x1F
	if kind != 1 {
		table = 0x4419
		y_bias = 0x10
		mask = 0x3F
	}
	phase := read_u8(&m.ds, add16(di, 7))
	next, _ := intrinsics.overflow_add(phase, 1)
	write_u8(&m.ds, add16(di, 7), next)
	dx := cbw(m.cs[int(table) + int(phase & mask)])
	x := read_u16(&m.ds, add16(di, 1))
	write_u16(&m.ds, add16(di, 1), add16(x, dx))
	y_phase, _ := intrinsics.overflow_add(phase, y_bias)
	dy := cbw(m.cs[int(table) + int(y_phase & mask)])
	y := read_u16(&m.ds, add16(di, 3))
	write_u16(&m.ds, add16(di, 3), add16(y, dy))
}

// 1000:3225 planet_array_for_record.
// The name is inferred. This entry falls into planet_array_for_level.
// AL is the level byte at SI+5. A word offset near the top of the
// segment wraps onto DS:0000.

// @proc 1000:3225
// status: tested
// Odin: planet_array_for_record
// 1000:3225  FUN_1000_3225:
// 1000:3225      8a 44 05                 MOV AL,byte ptr [SI + 0x5]

planet_array_for_record :: proc(ds: ^DS_Segment, si: u16) -> (array: ^[0x50][11]u8, count: u16) {
	raw := transmute(^[DS_SIZE]u8)ds
	return planet_array_for_level(ds, raw[add16(si, 5)])
}

// 1000:41f0 timed_type.
// The name is inferred. When mode bit 0 is set, the type byte in AL
// is ORed with 0xF0. Otherwise AL is unchanged.

// @proc 1000:41f0
// status: tested
// Odin: timed_type
// 1000:41f0  FUN_1000_41f0:
// 1000:41f0      f6 06 12 00 01           TEST byte ptr [0x12],0x1
// 1000:41f5      74 02                    JZ 0x1000:41f9
// 1000:41f7      0c f0                    OR AL,0xf0
// 1000:41f9  LAB_1000_41f9:
// 1000:41f9      c3                       RET

timed_type :: proc(ds: ^DS_Segment, al: u8) -> u8 {
	if ds.mode_bits & 1 != 0 {
		return al | 0xF0
	}
	return al
}

// 1000:4217 reject_near_base.
// The name is inferred. Carry set means the position is rejected.
// SI is the record being placed. DX is the multi-plane radius.
// BP is the base radius, and a local copy shrinks from 0x157C to 0x1F4.
// That copy does not escape to the caller.
//
// Mode bit 1 compares SI with the record at DS:0100, shift 5.
// Distance >= DX rejects immediately. The distance carry is ignored.
// Then each of the four bases at 9014 is checked, stride 0x0E, shift 4.
// A base is skipped when SI is that base or its energy word at +08 is 0.
// Distance < BP rejects. 0xFFFF is not below BP.

// @proc 1000:4217
// status: tested
// Odin: reject_near_base
// 1000:4217  FUN_1000_4217:
// 1000:4217      51                       PUSH CX
// 1000:4218      f6 06 12 00 02           TEST byte ptr [0x12],0x2
// 1000:421d      74 19                    JZ 0x1000:4238
// 1000:421f      bf 00 01                 MOV DI,0x100
// 1000:4222      b1 05                    MOV CL,0x5
// 1000:4224      52                       PUSH DX
// 1000:4225      e8 a4 e1                 CALL 0x1000:23cc
// 1000:4228      5a                       POP DX
// 1000:4229      3b c2                    CMP AX,DX
// 1000:422b      f5                       CMC
// 1000:422c      72 2b                    JC 0x1000:4259
// 1000:422e      81 fd 7c 15              CMP BP,0x157c
// 1000:4232      f8                       CLC
// 1000:4233      75 03                    JNZ 0x1000:4238
// 1000:4235      bd f4 01                 MOV BP,0x1f4
// 1000:4238  LAB_1000_4238:
// 1000:4238      bf 14 90                 MOV DI,0x9014
// 1000:423b      b9 04 00                 MOV CX,0x4
// 1000:423e  LAB_1000_423e:
// 1000:423e      3b f7                    CMP SI,DI
// 1000:4240      74 11                    JZ 0x1000:4253
// 1000:4242      83 7d 08 00              CMP word ptr [DI + 0x8],0x0
// 1000:4246      74 0b                    JZ 0x1000:4253
// 1000:4248      51                       PUSH CX
// 1000:4249      b1 04                    MOV CL,0x4
// 1000:424b      e8 7e e1                 CALL 0x1000:23cc
// 1000:424e      59                       POP CX
// 1000:424f      3b c5                    CMP AX,BP
// 1000:4251      72 06                    JC 0x1000:4259
// 1000:4253  LAB_1000_4253:
// 1000:4253      83 c7 0e                 ADD DI,0xe
// 1000:4256      e2 e6                    LOOP 0x1000:423e
// 1000:4258      f8                       CLC
// 1000:4259  LAB_1000_4259:
// 1000:4259      59                       POP CX
// 1000:425a      c3                       RET

reject_near_base :: proc(m: ^Machine, si, bp, dx: u16) -> bool {
	ds := transmute(^DS_Segment)&m.ds
	radius := bp
	if ds.mode_bits & 2 != 0 {
		ax, _ := toroidal_distance(m, si, 0x0100, 5)
		// CMP AX, DX / CMC / JC. Carry is set when AX >= DX.
		if ax >= dx {
			return true
		}
		if radius == 0x157C {
			radius = 0x1F4
		}
	}
	di := u16(0x9014)
	for _ in 0 ..< 4 {
		if si != di {
			energy := read_u16(&m.ds, add16(di, 8))
			if energy != 0 {
				ax, _ := toroidal_distance(m, si, di, 4)
				if ax < radius {
					return true
				}
			}
		}
		di = add16(di, 0x0E)
	}
	return false
}

// CBW. A byte at or above 0x80 becomes a negative word.
@(private)
cbw :: proc(v: u8) -> u16 {
	if v & 0x80 != 0 {
		return 0xFF00 | u16(v)
	}
	return u16(v)
}

@(private)
parity_even :: proc(v: u8) -> bool {
	bits: u8 = 0
	n := v
	for _ in 0 ..< 8 {
		bits += n & 1
		n >>= 1
	}
	return bits & 1 == 0
}

@(private)
rcr8 :: proc(v: u8, carry: bool) -> (u8, bool) {
	out_carry := v & 1 == 1
	next := v >> 1
	if carry {
		next |= 0x80
	}
	return next, out_carry
}
