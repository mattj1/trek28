package trek

import "core:testing"

@(test)
test_mix_rng :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)

	ds.frame_count = 0
	ds.rng_seed = 0
	testing.expect_value(t, mix_rng(ds), u16(0xC07B))
	testing.expect_value(t, ds.rng_seed, u16(0xC07B))

	ds.rng_seed = 0
	ds.frame_count = 1
	testing.expect_value(t, mix_rng(ds), u16(0x01BB))

	ds.rng_seed = 1
	ds.frame_count = 0
	testing.expect_value(t, mix_rng(ds), u16(0xC17B))

	ds.rng_seed = 0xFFFF
	testing.expect_value(t, mix_rng(ds), u16(0x7F3B))

	// 0xA5 cancels the constant, and a zero seed stays zero.
	ds.frame_count = 0xA5
	ds.rng_seed = 0
	testing.expect_value(t, mix_rng(ds), u16(0))
	testing.expect_value(t, ds.rng_seed, u16(0))

	// The high byte of the frame word is not read.
	ds.frame_count = 0x0100
	ds.rng_seed = 0
	testing.expect_value(t, mix_rng(ds), u16(0xC07B))

	ds.frame_count = 4
	ds.rng_seed = 0x1234
	testing.expect_value(t, mix_rng(ds), u16(0x75B5))

	ds.frame_count = 0xFF
	ds.rng_seed = 0x8000
	testing.expect_value(t, mix_rng(ds), u16(0x819B))

	ds.frame_count = 7
	ds.rng_seed = 0x00A5
	testing.expect_value(t, mix_rng(ds), u16(0x24B9))

	// Eight steps from a zero seed on frame 4.
	ds.frame_count = 4
	ds.rng_seed = 0
	want := [8]u16{0xC1B8, 0xB828, 0xE9CA, 0xCA36, 0x77EF, 0x6E9E, 0xDE54, 0x15E0}
	for i in 0 ..< 8 {
		testing.expect_value(t, mix_rng(ds), want[i])
	}
}
