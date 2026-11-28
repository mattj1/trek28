package trek

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
