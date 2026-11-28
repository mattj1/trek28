package trek

import "core:testing"

@(test)
test_image_seek_letters :: proc(t: ^testing.T) {
	m := new(Machine)
	defer free(m)
	load_embedded(m)
	got := string(m.ds[0x110:][:20])
	testing.expect_value(t, got, " *EMDIBSRTXQGHm 1234")
	testing.expect_value(t, m.cs_len, COM_SIZE)
}

@(test)
test_isqrt_xlat_table :: proc(t: ^testing.T) {
	m := new(Machine)
	defer free(m)
	load_embedded(m)
	cs := m.cs[:m.cs_len]
	// One sample from each XLAT range. These are the table bytes, not floor(sqrt).
	cases := []struct {
		n, want: u16,
	}{
		{0, 0},
		{1, 1},
		{3, 2},
		{25, 5},
		{100, 10},
		{255, 16},
		{0x100, 16},
		{0x1FF, 23},
		{0x240, 24},
		{0x7FF, 45},
		{0x800, 45},
		{0x1000, 64},
		{0x3FFF, 128},
		{0x4000, 128},
		{0x8000, 181},
		{0xFFFF, 255},
		{5625, 75},
	}
	for c in cases {
		testing.expect_value(t, isqrt_xlat(cs, c.n), c.want)
	}
}

@(test)
test_toroidal_distance :: proc(t: ^testing.T) {
	m := new(Machine)
	defer free(m)
	load_embedded(m)

	// 3-4-5, same place on Y for the axis check, shift 0.
	write_object(m, 0x100, 0, 0, 0)
	write_object(m, 0x140, 3, 4, 0)
	ax, carry := toroidal_distance(m, 0x100, 0x140, 0)
	testing.expect_value(t, ax, u16(5))
	testing.expect_value(t, carry, false)

	// Across the seam. 0 and 0x3FF0 differ by 16 on a 0x4000 torus.
	write_object(m, 0x100, 0, 10, 0)
	write_object(m, 0x140, 0x3FF0, 10, 0)
	ax, carry = toroidal_distance(m, 0x100, 0x140, 0)
	testing.expect_value(t, ax, u16(16))
	testing.expect_value(t, carry, false)

	// Shift scales a 6-8-10 triangle down and back: 3-4-5, then SHL 1.
	write_object(m, 0x100, 0, 0, 0)
	write_object(m, 0x140, 6, 8, 0)
	ax, carry = toroidal_distance(m, 0x100, 0x140, 1)
	testing.expect_value(t, ax, u16(10))
	testing.expect_value(t, carry, false)

	// 300 shrunk by 2 is 75. 75*75 is 5625, the table returns 75, SHL 2 is 300.
	write_object(m, 0x140, 300, 0, 0)
	ax, carry = toroidal_distance(m, 0x100, 0x140, 2)
	testing.expect_value(t, ax, u16(300))
	testing.expect_value(t, carry, false)

	// Does not fit in a byte after the shift.
	write_object(m, 0x140, 300, 0, 0)
	ax, carry = toroidal_distance(m, 0x100, 0x140, 0)
	testing.expect_value(t, ax, u16(0xFFFF))
	testing.expect_value(t, carry, true)

	// Both axes fit, and the sum of the squares does not.
	write_object(m, 0x140, 200, 200, 0)
	ax, carry = toroidal_distance(m, 0x100, 0x140, 0)
	testing.expect_value(t, ax, u16(0xFFFF))
	testing.expect_value(t, carry, true)
}

@(test)
test_distance_same_plane :: proc(t: ^testing.T) {
	m := new(Machine)
	defer free(m)
	load_embedded(m)
	write_object(m, 0x100, 0, 0, 1)
	write_object(m, 0x140, 0, 0, 2)
	ax, carry := distance_if_same_plane(m, 0x100, 0x140, 0)
	testing.expect_value(t, ax, u16(0xFFFE))
	testing.expect_value(t, carry, true)

	// 1000:23cc does not look at the level. The same pair still has distance 0.
	ax, carry = toroidal_distance(m, 0x100, 0x140, 0)
	testing.expect_value(t, ax, u16(0))
	testing.expect_value(t, carry, false)

	write_object(m, 0x140, 3, 4, 1)
	ax, carry = distance_if_same_plane(m, 0x100, 0x140, 0)
	testing.expect_value(t, ax, u16(5))
	testing.expect_value(t, carry, false)
}

@(test)
test_host_stubs :: proc(t: ^testing.T) {
	h: Host
	testing.expect(t, host_push_key(&h, 'W'))
	key, pressed := host_poll_key(&h)
	testing.expect_value(t, key, u8('W'))
	testing.expect_value(t, pressed, true)
	key, pressed = host_poll_key(&h)
	testing.expect_value(t, key, u8(0))
	testing.expect_value(t, pressed, false)

	frame := []u8{1, 2, 3, 4}
	host_blit(&h, frame)
	testing.expect_value(t, h.frame_len, 4)
	testing.expect_value(t, h.frame[3], u8(4))

	host_set_palette(&h, 1)
	host_color_select(&h, 0x14)
	host_speaker(&h, 0x0300, true)
	testing.expect_value(t, h.palette, u8(1))
	testing.expect_value(t, h.color_select, u8(0x14))
	testing.expect_value(t, h.speaker_divisor, u16(0x0300))
	testing.expect_value(t, h.speaker_on, true)

	score := []u8{'C', 'B', 'M'}
	testing.expect(t, host_score_write(&h, score))
	buf: [8]u8
	n := host_score_read(&h, buf[:])
	testing.expect_value(t, n, 3)
	testing.expect_value(t, buf[0], u8('C'))

	host_quit(&h, "Program Corrupted!!")
	testing.expect(t, h.quit)
	testing.expect_value(t, h.quit_msg, "Program Corrupted!!")
}

@(private)
write_object :: proc(m: ^Machine, at, x, y: u16, plane: u8) {
	write_u16(&m.ds, add16(at, 1), x)
	write_u16(&m.ds, add16(at, 3), y)
	write_u8(&m.ds, add16(at, 5), plane)
}

@(test)
test_word_wrap :: proc(t: ^testing.T) {
	testing.expect_value(t, abs_diff(0, 0x8000), u16(0x8000))
	testing.expect_value(t, abs_diff(0x8000, 0), u16(0x8000))
	testing.expect_value(t, torus_axis(0x3FF0), u16(16))
	testing.expect_value(t, shr_word(1, 16), u16(0))
	testing.expect_value(t, shl_word(1, 16), u16(0))
	testing.expect_value(t, xchg_bytes(0x1234), u16(0x3412))

	// A word at DS:FFFF stores its high byte at DS:0000.
	m := new(Machine)
	defer free(m)
	write_u16(&m.ds, 0xFFFF, 0x1234)
	testing.expect_value(t, read_u16(&m.ds, 0xFFFF), u16(0x1234))
	testing.expect_value(t, m.ds[0], u8(0x12))
}
