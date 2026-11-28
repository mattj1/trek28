package trek

// 1000:23cc toroidal_distance.
// 1000:23c4 and 1000:241a are the same body with a galaxy-level check in front.
// 1000:241a is a second copy of 1000:23c4. Both call 1000:2470.
//
// DX and DY are shrunk by CL. Each axis must then fit in one byte, and the
// sum of the squares must fit in one word. Otherwise the result is 0xFFFF
// with carry set. A level mismatch is 0xFFFE with carry set, and the axes
// are not read. Carry clear means the distance in AX is usable.
//
//	MOV AX, [SI+01]
//	SUB AX, [DI+01]
//	JNS x_abs
//	NEG AX
//	x_abs:
//	CMP AH, 0x20
//	JC x_shift
//	SUB AX, 0x4000
//	NEG AX
//	x_shift:
//	SHR AX, CL
//	AND AH, AH
//	JNZ too_far
//	MUL AL
//	XCHG AX, DX
//	; same for [SI+03] / [DI+03], then
//	ADD AX, DX
//	JC too_far
//	CALL 1000:2470
//	SHL AX, CL
//	CLC

// @proc 1000:23cc
// status: tested
// Odin: toroidal_distance
// 1000:23cc  FUN_1000_23cc:
// 1000:23cc      8b 44 01                 MOV AX,word ptr [SI + 0x1]
// 1000:23cf      2b 45 01                 SUB AX,word ptr [DI + 0x1]
// 1000:23d2      79 02                    JNS 0x1000:23d6
// 1000:23d4      f7 d8                    NEG AX
// 1000:23d6  LAB_1000_23d6:
// 1000:23d6      80 fc 20                 CMP AH,0x20
// 1000:23d9      72 05                    JC 0x1000:23e0
// 1000:23db      2d 00 40                 SUB AX,0x4000
// 1000:23de      f7 d8                    NEG AX
// 1000:23e0  LAB_1000_23e0:
// 1000:23e0      d3 e8                    SHR AX,CL
// 1000:23e2      22 e4                    AND AH,AH
// 1000:23e4      75 2a                    JNZ 0x1000:2410
// 1000:23e6      f6 e0                    MUL AL
// 1000:23e8      92                       XCHG AX,DX
// 1000:23e9      8b 44 03                 MOV AX,word ptr [SI + 0x3]
// 1000:23ec      2b 45 03                 SUB AX,word ptr [DI + 0x3]
// 1000:23ef      79 02                    JNS 0x1000:23f3
// 1000:23f1      f7 d8                    NEG AX
// 1000:23f3  LAB_1000_23f3:
// 1000:23f3      80 fc 20                 CMP AH,0x20
// 1000:23f6      72 05                    JC 0x1000:23fd
// 1000:23f8      2d 00 40                 SUB AX,0x4000
// 1000:23fb      f7 d8                    NEG AX
// 1000:23fd  LAB_1000_23fd:
// 1000:23fd      d3 e8                    SHR AX,CL
// 1000:23ff      22 e4                    AND AH,AH
// 1000:2401      75 0d                    JNZ 0x1000:2410
// 1000:2403      f6 e0                    MUL AL
// 1000:2405      03 c2                    ADD AX,DX
// 1000:2407      72 07                    JC 0x1000:2410
// 1000:2409      e8 64 00                 CALL 0x1000:2470
// 1000:240c      d3 e0                    SHL AX,CL
// 1000:240e      f8                       CLC
// 1000:240f      c3                       RET
// 1000:2410  LAB_1000_2410:
// 1000:2410      b8 ff ff                 MOV AX,0xffff
// 1000:2413      f9                       STC
// 1000:2414      c3                       RET
// 1000:2415  LAB_1000_2415:
// 1000:2415      b8 fe ff                 MOV AX,0xfffe
// 1000:2418      f9                       STC
// 1000:2419      c3                       RET
toroidal_distance :: proc(m: ^Machine, si, di: u16, shift: u8) -> (ax: u16, carry: bool) {
	dx, ok_x := axis_component(m, add16(si, 1), add16(di, 1), shift)
	if !ok_x {
		return 0xFFFF, true
	}
	dy, ok_y := axis_component(m, add16(si, 3), add16(di, 3), shift)
	if !ok_y {
		return 0xFFFF, true
	}
	sum := u32(dx) + u32(dy)
	if sum > 0xFFFF {
		return 0xFFFF, true
	}
	root := isqrt_xlat(m.cs[:m.cs_len], u16(sum))
	return shl_word(root, shift), false
}

// 1000:23c4. Falls into 1000:23cc when the galaxy levels match.
// 1000:241a is the same procedure.
// @proc 1000:23c4
// status: tested
// Odin: distance_if_same_plane
// 1000:23c4  FUN_1000_23c4:
// 1000:23c4      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
// 1000:23c7      3a 45 05                 CMP AL,byte ptr [DI + 0x5]
// 1000:23ca      75 49                    JNZ 0x1000:2415
// @proc 1000:241a
// status: tested
// Odin: distance_if_same_plane
// 1000:241a  FUN_1000_241a:
// 1000:241a      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
// 1000:241d      3a 45 05                 CMP AL,byte ptr [DI + 0x5]
// 1000:2420      75 49                    JNZ 0x1000:246b
// 1000:2422      8b 44 01                 MOV AX,word ptr [SI + 0x1]
// 1000:2425      2b 45 01                 SUB AX,word ptr [DI + 0x1]
// 1000:2428      79 02                    JNS 0x1000:242c
// 1000:242a      f7 d8                    NEG AX
// 1000:242c  LAB_1000_242c:
// 1000:242c      80 fc 20                 CMP AH,0x20
// 1000:242f      72 05                    JC 0x1000:2436
// 1000:2431      2d 00 40                 SUB AX,0x4000
// 1000:2434      f7 d8                    NEG AX
// 1000:2436  LAB_1000_2436:
// 1000:2436      d3 e8                    SHR AX,CL
// 1000:2438      22 e4                    AND AH,AH
// 1000:243a      75 2a                    JNZ 0x1000:2466
// 1000:243c      f6 e0                    MUL AL
// 1000:243e      92                       XCHG AX,DX
// 1000:243f      8b 44 03                 MOV AX,word ptr [SI + 0x3]
// 1000:2442      2b 45 03                 SUB AX,word ptr [DI + 0x3]
// 1000:2445      79 02                    JNS 0x1000:2449
// 1000:2447      f7 d8                    NEG AX
// 1000:2449  LAB_1000_2449:
// 1000:2449      80 fc 20                 CMP AH,0x20
// 1000:244c      72 05                    JC 0x1000:2453
// 1000:244e      2d 00 40                 SUB AX,0x4000
// 1000:2451      f7 d8                    NEG AX
// 1000:2453  LAB_1000_2453:
// 1000:2453      d3 e8                    SHR AX,CL
// 1000:2455      22 e4                    AND AH,AH
// 1000:2457      75 0d                    JNZ 0x1000:2466
// 1000:2459      f6 e0                    MUL AL
// 1000:245b      03 c2                    ADD AX,DX
// 1000:245d      72 07                    JC 0x1000:2466
// 1000:245f      e8 0e 00                 CALL 0x1000:2470
// 1000:2462      d3 e0                    SHL AX,CL
// 1000:2464      f8                       CLC
// 1000:2465      c3                       RET
// 1000:2466  LAB_1000_2466:
// 1000:2466      b8 ff ff                 MOV AX,0xffff
// 1000:2469      f9                       STC
// 1000:246a      c3                       RET
// 1000:246b  LAB_1000_246b:
// 1000:246b      b8 fe ff                 MOV AX,0xfffe
// 1000:246e      f9                       STC
// 1000:246f      c3                       RET
distance_if_same_plane :: proc(m: ^Machine, si, di: u16, shift: u8) -> (ax: u16, carry: bool) {
	// MOV AL, [SI+05] / CMP AL, [DI+05] / JNZ different_plane
	if read_u8(&m.ds, add16(si, 5)) != read_u8(&m.ds, add16(di, 5)) {
		return 0xFFFE, true
	}
	return toroidal_distance(m, si, di, shift)
}

// One axis: absolute wrapped delta, shift, reject if it no longer fits in AL.
// MUL AL leaves the square in a word. ok is false on the 1000:2410 path.
@(private)
axis_component :: proc(m: ^Machine, a, b: u16, shift: u8) -> (square: u16, ok: bool) {
	delta := torus_axis(abs_diff(read_u16(&m.ds, a), read_u16(&m.ds, b)))
	delta = shr_word(delta, shift)
	// AND AH, AH / JNZ too_far
	if delta > 0xFF {
		return 0, false
	}
	al := u8(delta)
	return u16(al) * u16(al), true
}
