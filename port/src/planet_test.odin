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

@(test)
test_step_orbit :: proc(t: ^testing.T) {
	m := new(Machine)
	defer free(m)
	load_embedded(m)
	di := u16(offset_of(DS_Segment, planets))

	// Kind 0 returns before the phase increment.
	write_u8(&m.ds, di, 1)
	write_u16(&m.ds, add16(di, 1), 100)
	write_u16(&m.ds, add16(di, 3), 200)
	write_u8(&m.ds, add16(di, 7), 5)
	write_u8(&m.ds, add16(di, 8), 0)
	step_orbit(m, di)
	testing.expect_value(t, read_u16(&m.ds, add16(di, 1)), u16(100))
	testing.expect_value(t, read_u16(&m.ds, add16(di, 3)), u16(200))
	testing.expect_value(t, read_u8(&m.ds, add16(di, 7)), u8(5))

	// Kind 1, phase 0. CS:43F9[0] is 0x27. Y index 8 is 0xFC, which is -4.
	write_u16(&m.ds, add16(di, 1), 0)
	write_u16(&m.ds, add16(di, 3), 0)
	write_u8(&m.ds, add16(di, 7), 0)
	write_u8(&m.ds, add16(di, 8), 1)
	step_orbit(m, di)
	testing.expect_value(t, read_u8(&m.ds, add16(di, 7)), u8(1))
	testing.expect_value(t, read_u16(&m.ds, add16(di, 1)), u16(0x27))
	testing.expect_value(t, read_u16(&m.ds, add16(di, 3)), u16(0xFFFC))

	// Phase 0xFF wraps, and the mask keeps the index inside the 32-byte table.
	write_u16(&m.ds, add16(di, 1), 0)
	write_u16(&m.ds, add16(di, 3), 0)
	write_u8(&m.ds, add16(di, 7), 0xFF)
	step_orbit(m, di)
	testing.expect_value(t, read_u8(&m.ds, add16(di, 7)), u8(0))
	testing.expect_value(t, read_u16(&m.ds, add16(di, 1)), u16(0x27))
	testing.expect_value(t, read_u16(&m.ds, add16(di, 3)), u16(4))

	// The word add wraps and is not masked with 0x3FFF.
	write_u16(&m.ds, add16(di, 1), 0xFFF0)
	write_u16(&m.ds, add16(di, 3), 0x3FF0)
	write_u8(&m.ds, add16(di, 7), 0)
	step_orbit(m, di)
	testing.expect_value(t, read_u16(&m.ds, add16(di, 1)), u16(0x0017))
	testing.expect_value(t, read_u16(&m.ds, add16(di, 3)), u16(0x3FEC))

	// Kind 2 uses CS:4419. Phase 0 indexes X at 0 (0x27) and Y at 0x10 (0xFE).
	write_u16(&m.ds, add16(di, 1), 0)
	write_u16(&m.ds, add16(di, 3), 10)
	write_u8(&m.ds, add16(di, 7), 0)
	write_u8(&m.ds, add16(di, 8), 2)
	step_orbit(m, di)
	testing.expect_value(t, read_u8(&m.ds, add16(di, 7)), u8(1))
	testing.expect_value(t, read_u16(&m.ds, add16(di, 1)), u16(0x27))
	testing.expect_value(t, read_u16(&m.ds, add16(di, 3)), u16(8))

	// Any kind other than 0 or 1 takes that same table.
	write_u16(&m.ds, add16(di, 1), 0)
	write_u16(&m.ds, add16(di, 3), 10)
	write_u8(&m.ds, add16(di, 7), 0)
	write_u8(&m.ds, add16(di, 8), 0xFF)
	step_orbit(m, di)
	testing.expect_value(t, read_u16(&m.ds, add16(di, 1)), u16(0x27))
	testing.expect_value(t, read_u16(&m.ds, add16(di, 3)), u16(8))
}

@(test)
test_planet_array_for_record :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)
	ds.objects_per_level = 0x50
	ds.planets[0][0][5] = 1
	array, count := planet_array_for_record(ds, u16(offset_of(DS_Segment, planets)))
	testing.expect_value(t, array, &ds.planets[1])
	testing.expect_value(t, count, u16(0x50))

	ds.planets[0][0][5] = 0xFF
	array, count = planet_array_for_record(ds, u16(offset_of(DS_Segment, planets)))
	testing.expect_value(t, array, &ds.planets[3])

	// SI+5 wraps onto DS:0000, which is objects_per_level.
	ds.objects_per_level = 2
	array, count = planet_array_for_record(ds, 0xFFFB)
	testing.expect_value(t, array, &ds.planets[2])
	testing.expect_value(t, count, u16(2))
}

@(test)
test_timed_type :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)

	ds.mode_bits = 0
	testing.expect_value(t, timed_type(ds, 0x0E), u8(0x0E))

	ds.mode_bits = 0x02
	testing.expect_value(t, timed_type(ds, 0x01), u8(0x01))

	ds.mode_bits = 0x01
	testing.expect_value(t, timed_type(ds, 0x0E), u8(0xFE))
	testing.expect_value(t, timed_type(ds, 0xF0), u8(0xF0))
	testing.expect_value(t, timed_type(ds, 0), u8(0xF0))

	ds.mode_bits = 0xF3
	testing.expect_value(t, timed_type(ds, 0x0E), u8(0xFE))
	testing.expect_value(t, ds.mode_bits, u8(0xF3))
}

@(test)
test_reject_near_base :: proc(t: ^testing.T) {
	m := new(Machine)
	defer free(m)
	load_embedded(m)
	ds := transmute(^DS_Segment)&m.ds
	si := u16(offset_of(DS_Segment, planets))
	base0 := u16(offset_of(DS_Segment, bases))
	base1 := add16(base0, 0x0E)

	// No live base, and multi-plane is clear. The position is accepted.
	place_object(m, si, 0, 0)
	testing.expect_value(t, reject_near_base(m, si, 1, 1), false)

	// A live base at the same point rejects when the distance is below BP.
	place_object(m, base0, 0, 0)
	write_u16(&m.ds, add16(base0, 8), 100)
	testing.expect_value(t, reject_near_base(m, si, 1, 1), true)

	// BP of 0 never sees a distance below it. 0xFFFF is also not below BP.
	testing.expect_value(t, reject_near_base(m, si, 0, 1), false)
	place_object(m, si, 0, 0x2000)
	testing.expect_value(t, reject_near_base(m, si, 0x100, 1), false)

	// SI is the base itself, so that base is skipped.
	testing.expect_value(t, reject_near_base(m, base0, 1, 1), false)

	// The first base is empty and the second is on top of SI.
	write_u16(&m.ds, add16(base0, 8), 0)
	place_object(m, si, 50, 60)
	place_object(m, base1, 50, 60)
	write_u16(&m.ds, add16(base1, 8), 1)
	testing.expect_value(t, reject_near_base(m, si, 1, 1), true)
	write_u16(&m.ds, add16(base1, 8), 0)

	// Mode bit 1 rejects when the shift-5 distance from DS:0100 is >= DX.
	ds.mode_bits = 2
	place_object(m, 0x0100, 0, 0)
	place_object(m, si, 0, 0x2000)
	testing.expect_value(t, reject_near_base(m, si, 1, 1), true)

	// Inside that radius, a colocated live base still rejects.
	place_object(m, si, 0, 0)
	place_object(m, base0, 0, 0)
	write_u16(&m.ds, add16(base0, 8), 100)
	testing.expect_value(t, reject_near_base(m, si, 0x157C, 1), true)

	// Y gap 0x200 is below the unshrunk BP and not below the shrunk 0x1F4.
	place_object(m, base0, 0, 0x200)
	ax, carry := toroidal_distance(m, si, base0, 4)
	testing.expect_value(t, carry, false)
	testing.expect_value(t, ax, u16(0x200))
	testing.expect_value(t, reject_near_base(m, si, 0x157C, 0xFFFF), false)
	testing.expect_value(t, reject_near_base(m, si, 0x300, 0xFFFF), true)
}

@(private)
place_object :: proc(m: ^Machine, at, x, y: u16) {
	write_u16(&m.ds, add16(at, 1), x)
	write_u16(&m.ds, add16(at, 3), y)
}
