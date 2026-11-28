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
