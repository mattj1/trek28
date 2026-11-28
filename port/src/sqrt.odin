package trek

// 1000:2470 isqrt_xlat. Integer square root of AX through CS XLAT tables.
// The tables sit in the COM image:
//
//   AX < 0x0100  CS:250D  index = AX
//   AX < 0x0200  CS:260D  index = (AX & 0xFF) >> 1
//   AX < 0x0400  CS:268D  index = (AX & 0x01FF) >> 2
//   AX < 0x0800  CS:270D  index = (AX & 0x03FF) >> 3
//   AX < 0x1000  CS:278D  index = (AX & 0x07FF) >> 4
//   AX < 0x2000  CS:280D  index from AND 0x0FE0, SHL 3, XCHG
//   AX < 0x4000  CS:288D  index from AND 0x1FC0, SHL 2, XCHG
//   AX < 0x8000  CS:290D  index from AND 0x3F80, SHL 1, XCHG
//   else         CS:298C  index from AND 0x7F00, XCHG
//
// XLAT writes AL and leaves AH clear on every path here, so the result is a byte.
// Values are close to floor(sqrt(n)) and round up on some inputs (3 -> 2, 255 -> 16).

// @proc 1000:2470
// status: tested
// Odin: isqrt_xlat
// 1000:2470  FUN_1000_2470:
// 1000:2470      3d 00 80                 CMP AX,0x8000
// 1000:2473      73 29                    JNC 0x1000:249e
// 1000:2475      3d 00 40                 CMP AX,0x4000
// 1000:2478      73 2f                    JNC 0x1000:24a9
// 1000:247a      3d 00 20                 CMP AX,0x2000
// 1000:247d      73 37                    JNC 0x1000:24b6
// 1000:247f      3d 00 10                 CMP AX,0x1000
// 1000:2482      73 41                    JNC 0x1000:24c5
// 1000:2484      3d 00 08                 CMP AX,0x800
// 1000:2487      73 4d                    JNC 0x1000:24d6
// 1000:2489      3d 00 04                 CMP AX,0x400
// 1000:248c      73 59                    JNC 0x1000:24e7
// 1000:248e      3d 00 02                 CMP AX,0x200
// 1000:2491      73 63                    JNC 0x1000:24f6
// 1000:2493      3d 00 01                 CMP AX,0x100
// 1000:2496      73 6b                    JNC 0x1000:2503
// 1000:2498      bb 0d 25                 MOV BX,0x250d
// 1000:249b      2e d7                    XLAT CS:BX
// 1000:249d      c3                       RET
// 1000:249e  LAB_1000_249e:
// 1000:249e      25 00 7f                 AND AX,0x7f00
// 1000:24a1      86 c4                    XCHG AH,AL
// 1000:24a3      bb 8c 29                 MOV BX,0x298c
// 1000:24a6      2e d7                    XLAT CS:BX
// 1000:24a8      c3                       RET
// 1000:24a9  LAB_1000_24a9:
// 1000:24a9      25 80 3f                 AND AX,0x3f80
// 1000:24ac      d1 e0                    SHL AX,0x1
// 1000:24ae      86 c4                    XCHG AH,AL
// 1000:24b0      bb 0d 29                 MOV BX,0x290d
// 1000:24b3      2e d7                    XLAT CS:BX
// 1000:24b5      c3                       RET
// 1000:24b6  LAB_1000_24b6:
// 1000:24b6      25 c0 1f                 AND AX,0x1fc0
// 1000:24b9      d1 e0                    SHL AX,0x1
// 1000:24bb      d1 e0                    SHL AX,0x1
// 1000:24bd      86 c4                    XCHG AH,AL
// 1000:24bf      bb 8d 28                 MOV BX,0x288d
// 1000:24c2      2e d7                    XLAT CS:BX
// 1000:24c4      c3                       RET
// 1000:24c5  LAB_1000_24c5:
// 1000:24c5      25 e0 0f                 AND AX,0xfe0
// 1000:24c8      d1 e0                    SHL AX,0x1
// 1000:24ca      d1 e0                    SHL AX,0x1
// 1000:24cc      d1 e0                    SHL AX,0x1
// 1000:24ce      86 c4                    XCHG AH,AL
// 1000:24d0      bb 0d 28                 MOV BX,0x280d
// 1000:24d3      2e d7                    XLAT CS:BX
// 1000:24d5      c3                       RET
// 1000:24d6  LAB_1000_24d6:
// 1000:24d6      80 e4 07                 AND AH,0x7
// 1000:24d9      d1 e8                    SHR AX,0x1
// 1000:24db      d1 e8                    SHR AX,0x1
// 1000:24dd      d1 e8                    SHR AX,0x1
// 1000:24df      d1 e8                    SHR AX,0x1
// 1000:24e1      bb 8d 27                 MOV BX,0x278d
// 1000:24e4      2e d7                    XLAT CS:BX
// 1000:24e6      c3                       RET
// 1000:24e7  LAB_1000_24e7:
// 1000:24e7      80 e4 03                 AND AH,0x3
// 1000:24ea      d1 e8                    SHR AX,0x1
// 1000:24ec      d1 e8                    SHR AX,0x1
// 1000:24ee      d1 e8                    SHR AX,0x1
// 1000:24f0      bb 0d 27                 MOV BX,0x270d
// 1000:24f3      2e d7                    XLAT CS:BX
// 1000:24f5      c3                       RET
// 1000:24f6  LAB_1000_24f6:
// 1000:24f6      80 e4 01                 AND AH,0x1
// 1000:24f9      d1 e8                    SHR AX,0x1
// 1000:24fb      d1 e8                    SHR AX,0x1
// 1000:24fd      bb 8d 26                 MOV BX,0x268d
// 1000:2500      2e d7                    XLAT CS:BX
// 1000:2502      c3                       RET
// 1000:2503  LAB_1000_2503:
// 1000:2503      32 e4                    XOR AH,AH
// 1000:2505      d1 e8                    SHR AX,0x1
// 1000:2507      bb 0d 26                 MOV BX,0x260d
// 1000:250a      2e d7                    XLAT CS:BX
// 1000:250c      c3                       RET
isqrt_xlat :: proc(cs: []u8, ax_in: u16) -> u16 {
	ax := ax_in
	bx: u16
	// CMP AX, 0x8000 / JNC
	if ax >= 0x8000 {
		ax &= 0x7F00
		ax = xchg_bytes(ax)
		bx = 0x298C
		return u16(xlat(cs, bx, u8(ax)))
	}
	// CMP AX, 0x4000 / JNC
	if ax >= 0x4000 {
		ax &= 0x3F80
		ax = shl_word(ax, 1)
		ax = xchg_bytes(ax)
		bx = 0x290D
		return u16(xlat(cs, bx, u8(ax)))
	}
	// CMP AX, 0x2000 / JNC
	if ax >= 0x2000 {
		ax &= 0x1FC0
		ax = shl_word(ax, 2)
		ax = xchg_bytes(ax)
		bx = 0x288D
		return u16(xlat(cs, bx, u8(ax)))
	}
	// CMP AX, 0x1000 / JNC
	if ax >= 0x1000 {
		ax &= 0x0FE0
		ax = shl_word(ax, 3)
		ax = xchg_bytes(ax)
		bx = 0x280D
		return u16(xlat(cs, bx, u8(ax)))
	}
	// CMP AX, 0x800 / JNC ; AND AH, 7 ; SHR AX, 4
	if ax >= 0x800 {
		ax &= 0x07FF
		ax = shr_word(ax, 4)
		bx = 0x278D
		return u16(xlat(cs, bx, u8(ax)))
	}
	// CMP AX, 0x400 / JNC ; AND AH, 3 ; SHR AX, 3
	if ax >= 0x400 {
		ax &= 0x03FF
		ax = shr_word(ax, 3)
		bx = 0x270D
		return u16(xlat(cs, bx, u8(ax)))
	}
	// CMP AX, 0x200 / JNC ; AND AH, 1 ; SHR AX, 2
	if ax >= 0x200 {
		ax &= 0x01FF
		ax = shr_word(ax, 2)
		bx = 0x268D
		return u16(xlat(cs, bx, u8(ax)))
	}
	// CMP AX, 0x100 / JNC ; XOR AH, AH ; SHR AX, 1
	if ax >= 0x100 {
		ax &= 0x00FF
		ax = shr_word(ax, 1)
		bx = 0x260D
		return u16(xlat(cs, bx, u8(ax)))
	}
	// MOV BX, 0x250D / XLAT
	bx = 0x250D
	return u16(xlat(cs, bx, u8(ax)))
}

// XLAT CS:BX. AL = CS:[BX + AL].
@(private)
xlat :: proc(cs: []u8, bx: u16, al: u8) -> u8 {
	addr := int(bx) + int(al)
	return cs[addr]
}
