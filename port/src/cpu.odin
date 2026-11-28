package trek

import "base:intrinsics"

// 8086 word operations used by the translated procedures.
// This compiler traps on a signed or unsigned overflow and has no wrap
// operator, so the 16-bit add and subtract go through intrinsics.
// A shift of 16 or more yields 0. An 8086 keeps shifting bits out for those
// counts. The callers in this game pass a small count.

add16 :: proc(a, b: u16) -> u16 {
	r, _ := intrinsics.overflow_add(a, b)
	return r
}

sub16 :: proc(a, b: u16) -> u16 {
	r, _ := intrinsics.overflow_sub(a, b)
	return r
}

neg16 :: proc(v: u16) -> u16 {
	return sub16(0, v)
}

xchg_bytes :: proc(v: u16) -> u16 {
	return (v >> 8) | (v << 8)
}

shr_word :: proc(v: u16, n: u8) -> u16 {
	if n >= 16 do return 0
	return v >> uint(n)
}

shl_word :: proc(v: u16, n: u8) -> u16 {
	if n >= 16 do return 0
	return v << uint(n)
}

// SUB, then NEG when the sign flag is set. NEG of 0x8000 stays 0x8000.
abs_diff :: proc(a, b: u16) -> u16 {
	d, _ := intrinsics.overflow_sub(transmute(i16)a, transmute(i16)b)
	if d < 0 {
		d, _ = intrinsics.overflow_sub(i16(0), d)
	}
	return transmute(u16)d
}

// Shortest gap on one axis of the 0x4000 torus.
// CMP AH, 0x20 / JC keep / SUB AX, 0x4000 / NEG AX
torus_axis :: proc(delta: u16) -> u16 {
	if delta < 0x2000 do return delta
	return neg16(sub16(delta, 0x4000))
}
