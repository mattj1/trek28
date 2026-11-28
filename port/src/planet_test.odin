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
test_reject_near_planet :: proc(t: ^testing.T) {
	m := new(Machine)
	defer free(m)
	load_embedded(m)
	ds := transmute(^DS_Segment)&m.ds
	origin := planet_at(0, 0)
	other := planet_at(0, 1)

	// A zero count walks nothing. 8086 LOOP would repeat 65536 times.
	ds.objects_per_level = 0
	place_object(m, origin, 10, 10)
	write_u8(&m.ds, add16(origin, 5), 0)
	testing.expect_value(t, reject_near_planet(m, origin), false)

	// The record itself is skipped, and an X of 0 is empty.
	ds.objects_per_level = 2
	place_object(m, other, 0, 10)
	write_u8(&m.ds, add16(other, 5), 0)
	testing.expect_value(t, reject_near_planet(m, origin), false)

	// Same point and same plane rejects.
	place_object(m, other, 10, 10)
	testing.expect_value(t, reject_near_planet(m, origin), true)

	// A different plane returns 0xFFFE, which is not below 0x28A.
	write_u8(&m.ds, add16(other, 5), 1)
	testing.expect_value(t, reject_near_planet(m, origin), false)
	write_u8(&m.ds, add16(other, 5), 0)

	// Too far returns 0xFFFF and does not reject.
	place_object(m, other, 10, 0x2010)
	testing.expect_value(t, reject_near_planet(m, origin), false)

	// A gap of 0x200 still comes back below 0x28A. A gap of 0x300 does not.
	// Equality would not reject. The sqrt step rounds, so the raw gap is not the compare.
	place_object(m, other, 10, 10 + 0x200)
	ax, _ := distance_if_same_plane(m, origin, other, 2)
	testing.expect(t, ax < 0x28A)
	testing.expect_value(t, reject_near_planet(m, origin), true)
	place_object(m, other, 10, 10 + 0x300)
	ax, _ = distance_if_same_plane(m, origin, other, 2)
	testing.expect(t, ax >= 0x28A)
	testing.expect_value(t, reject_near_planet(m, origin), false)

	// Level 1 walks planets[1]. A neighbor on level 0 does not count.
	level1 := planet_at(1, 0)
	level1_next := planet_at(1, 1)
	place_object(m, level1, 20, 20)
	write_u8(&m.ds, add16(level1, 5), 1)
	place_object(m, origin, 20, 20)
	write_u8(&m.ds, add16(origin, 5), 0)
	place_object(m, level1_next, 0, 0)
	write_u8(&m.ds, add16(level1_next, 5), 1)
	testing.expect_value(t, reject_near_planet(m, level1), false)
	place_object(m, level1_next, 20, 20)
	testing.expect_value(t, reject_near_planet(m, level1), true)

	// Count 0x51 walks out of planets[0] into planets[1].
	ds.objects_per_level = 0x51
	place_object(m, other, 0, 0)
	place_object(m, origin, 30, 30)
	write_u8(&m.ds, add16(origin, 5), 0)
	place_object(m, level1, 0, 0)
	testing.expect_value(t, reject_near_planet(m, origin), false)
	place_object(m, level1, 30, 30)
	write_u8(&m.ds, add16(level1, 5), 0)
	testing.expect_value(t, reject_near_planet(m, origin), true)
}

@(private)
planet_at :: proc(level, index: u16) -> u16 {
	return add16(u16(offset_of(DS_Segment, planets)), add16(level * 0x370, index * 0x0B))
}

@(test)
test_random_base_coord :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)

	// Frame 4, seed 6. The first draw is already inside the range.
	ds.frame_count = 4
	ds.rng_seed = 6
	testing.expect_value(t, random_base_coord(ds), u16(0x07B8))
	testing.expect_value(t, ds.rng_seed, u16(0xC7B8))

	// Seed 2 draws 0x03B8 first, which is below 0x5DC, then 0x39E9.
	ds.rng_seed = 2
	testing.expect_value(t, random_base_coord(ds), u16(0x39E9))
	testing.expect_value(t, ds.rng_seed, u16(0x39E9))

	// Both ends of the range are kept. The high byte of the frame is ignored.
	ds.frame_count = 0x0101
	ds.rng_seed = 35588
	testing.expect_value(t, random_base_coord(ds), u16(0x05DC))
	testing.expect_value(t, ds.rng_seed, u16(0x45DC))

	ds.frame_count = 1
	ds.rng_seed = 54586
	testing.expect_value(t, random_base_coord(ds), u16(0x3A24))
	testing.expect_value(t, ds.rng_seed, u16(0xFA24))
}

@(test)
test_random_planet_coord :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)

	// 0x03B8 is inside the planet window and below the base window.
	ds.frame_count = 4
	ds.rng_seed = 2
	testing.expect_value(t, random_planet_coord(ds), u16(0x03B8))
	testing.expect_value(t, ds.rng_seed, u16(0xC3B8))

	// Seed 0 draws 0x01B8 first, below 0x1F4, then 0x3828.
	ds.rng_seed = 0
	testing.expect_value(t, random_planet_coord(ds), u16(0x3828))
	testing.expect_value(t, ds.rng_seed, u16(0xB828))

	ds.frame_count = 1
	ds.rng_seed = 60160
	testing.expect_value(t, random_planet_coord(ds), u16(0x01F4))
	testing.expect_value(t, ds.rng_seed, u16(0x41F4))

	ds.rng_seed = 46398
	testing.expect_value(t, random_planet_coord(ds), u16(0x3E0C))
	testing.expect_value(t, ds.rng_seed, u16(0xFE0C))
}

@(test)
test_walk_planets :: proc(t: ^testing.T) {
	m := new(Machine)
	defer free(m)
	load_embedded(m)
	ds := transmute(^DS_Segment)&m.ds
	a := planet_at(0, 0)
	b := planet_at(0, 1)
	c := planet_at(0, 2)

	// galaxy_levels 0 still walks level 0 once. Frame 7 and CL 1 step the orbit.
	ds.galaxy_levels = 0
	ds.objects_per_level = 1
	ds.frame_count = 7
	ds.mode_bits = 0
	write_u8(&m.ds, a, 1)
	write_u8(&m.ds, add16(a, 6), 4)
	write_u8(&m.ds, add16(a, 7), 0)
	write_u8(&m.ds, add16(a, 8), 1)
	walk_planets(m)
	testing.expect_value(t, read_u8(&m.ds, add16(a, 7)), u8(1))
	testing.expect_value(t, read_u16(&m.ds, add16(a, 1)), u16(0x27))
	testing.expect_value(t, read_u16(&m.ds, add16(a, 3)), u16(0xFFFC))
	testing.expect_value(t, read_u8(&m.ds, add16(a, 6)), u8(3))
	testing.expect_value(t, ds.byte_a280, u8(0))

	// Frame 6 steps the first of two records (CL 2) and skips the second (CL 1).
	ds.objects_per_level = 2
	ds.frame_count = 6
	write_u8(&m.ds, a, 1)
	write_u16(&m.ds, add16(a, 1), 0)
	write_u16(&m.ds, add16(a, 3), 0)
	write_u8(&m.ds, add16(a, 6), 5)
	write_u8(&m.ds, add16(a, 7), 0)
	write_u8(&m.ds, add16(a, 8), 1)
	write_u8(&m.ds, b, 1)
	write_u16(&m.ds, add16(b, 1), 9)
	write_u16(&m.ds, add16(b, 3), 9)
	write_u8(&m.ds, add16(b, 6), 5)
	write_u8(&m.ds, add16(b, 7), 0)
	write_u8(&m.ds, add16(b, 8), 1)
	walk_planets(m)
	testing.expect_value(t, read_u8(&m.ds, add16(a, 7)), u8(1))
	testing.expect_value(t, read_u8(&m.ds, add16(a, 6)), u8(4))
	testing.expect_value(t, read_u8(&m.ds, add16(b, 7)), u8(0))
	testing.expect_value(t, read_u16(&m.ds, add16(b, 1)), u16(9))
	testing.expect_value(t, read_u8(&m.ds, add16(b, 6)), u8(5))

	// A zero nibble off the 128-frame mark does not age.
	ds.objects_per_level = 1
	ds.frame_count = 1
	write_u8(&m.ds, a, 0)
	write_u8(&m.ds, add16(a, 6), 4)
	ds.byte_a280 = 7
	walk_planets(m)
	testing.expect_value(t, read_u8(&m.ds, add16(a, 6)), u8(4))
	testing.expect_value(t, ds.byte_a280, u8(0))

	// Lifetime 2 ages to 1 and does not scatter.
	ds.frame_count = 0
	ds.rng_seed = 0
	write_u8(&m.ds, a, 0x20)
	write_u8(&m.ds, add16(a, 6), 2)
	walk_planets(m)
	testing.expect_value(t, read_u8(&m.ds, a), u8(0x20))
	testing.expect_value(t, read_u8(&m.ds, add16(a, 6)), u8(1))
	testing.expect_value(t, ds.byte_a280, u8(0))
	testing.expect_value(t, ds.rng_seed, u16(0))

	// Lifetime 1 hits 0. Seed 0 draws 0xC07B, so the type is ORed with 0x0F.
	write_u8(&m.ds, add16(a, 6), 1)
	walk_planets(m)
	testing.expect_value(t, read_u8(&m.ds, a), u8(0x2F))
	testing.expect_value(t, read_u8(&m.ds, add16(a, 6)), u8(0))
	testing.expect_value(t, ds.byte_a280, u8(1))
	testing.expect_value(t, ds.rng_seed, u16(0xC07B))

	// A zero lifetime does not scatter, and it clears the flag.
	write_u8(&m.ds, a, 0)
	write_u8(&m.ds, add16(a, 6), 0)
	ds.rng_seed = 0
	walk_planets(m)
	testing.expect_value(t, read_u8(&m.ds, a), u8(0))
	testing.expect_value(t, ds.byte_a280, u8(0))
	testing.expect_value(t, ds.rng_seed, u16(0))

	// Seed 6656 draws 0x41B0. The zero nibble relocates to 0x304B, 0x0ACF.
	ds.rng_seed = 6656
	write_u8(&m.ds, a, 0)
	write_u8(&m.ds, add16(a, 5), 2)
	write_u8(&m.ds, add16(a, 6), 1)
	write_u8(&m.ds, add16(a, 7), 4)
	write_u8(&m.ds, add16(a, 8), 3)
	walk_planets(m)
	testing.expect_value(t, read_u16(&m.ds, add16(a, 1)), u16(0x304B))
	testing.expect_value(t, read_u16(&m.ds, add16(a, 3)), u16(0x0ACF))
	testing.expect_value(t, read_u8(&m.ds, a), u8(0x0E))
	testing.expect_value(t, read_u8(&m.ds, add16(a, 5)), u8(2))
	testing.expect_value(t, read_u8(&m.ds, add16(a, 6)), u8(0))
	testing.expect_value(t, read_u8(&m.ds, add16(a, 7)), u8(0))
	testing.expect_value(t, read_u8(&m.ds, add16(a, 8)), u8(0))
	testing.expect_value(t, read_u8(&m.ds, add16(a, 0x0A)), u8(0xFF))
	testing.expect_value(t, ds.rng_seed, u16(0x8ACF))

	// The expiry flag makes the next nibble of 1..0x0A scatter too.
	// A nibble above 0x0A stays on the orbit path and leaves the flag set.
	ds.objects_per_level = 3
	ds.frame_count = 0
	ds.rng_seed = 0
	ds.mode_bits = 0
	write_u8(&m.ds, a, 0)
	write_u8(&m.ds, add16(a, 6), 1)
	write_u8(&m.ds, b, 5)
	write_u8(&m.ds, add16(b, 6), 9)
	write_u8(&m.ds, c, 0x0B)
	write_u8(&m.ds, add16(c, 6), 9)
	write_u8(&m.ds, add16(c, 7), 3)
	write_u8(&m.ds, add16(c, 8), 1)
	walk_planets(m)
	testing.expect_value(t, read_u8(&m.ds, a), u8(0x0F))
	testing.expect_value(t, read_u8(&m.ds, b), u8(0x0F))
	testing.expect_value(t, read_u8(&m.ds, add16(b, 6)), u8(9))
	testing.expect_value(t, read_u8(&m.ds, c), u8(0x0B))
	testing.expect_value(t, read_u8(&m.ds, add16(c, 7)), u8(3))
	testing.expect_value(t, ds.byte_a280, u8(1))

	// galaxy_levels 1 does not walk level 1.
	ds.galaxy_levels = 1
	ds.objects_per_level = 1
	ds.frame_count = 7
	level1 := planet_at(1, 0)
	write_u8(&m.ds, a, 0)
	write_u8(&m.ds, add16(a, 6), 0)
	write_u8(&m.ds, level1, 1)
	write_u8(&m.ds, add16(level1, 7), 0)
	write_u8(&m.ds, add16(level1, 8), 1)
	walk_planets(m)
	testing.expect_value(t, read_u8(&m.ds, add16(level1, 7)), u8(0))

	// Levels 3 and 4 both walk planets[3], so one record steps twice.
	ds.galaxy_levels = 5
	ds.objects_per_level = 1
	ds.frame_count = 7
	shared := planet_at(3, 0)
	write_u8(&m.ds, a, 0)
	write_u8(&m.ds, add16(a, 6), 0)
	write_u8(&m.ds, planet_at(1, 0), 0)
	write_u8(&m.ds, planet_at(2, 0), 0)
	write_u8(&m.ds, shared, 1)
	write_u16(&m.ds, add16(shared, 1), 0)
	write_u16(&m.ds, add16(shared, 3), 0)
	write_u8(&m.ds, add16(shared, 6), 0)
	write_u8(&m.ds, add16(shared, 7), 0)
	write_u8(&m.ds, add16(shared, 8), 1)
	walk_planets(m)
	testing.expect_value(t, read_u8(&m.ds, add16(shared, 7)), u8(2))
	testing.expect_value(t, read_u16(&m.ds, add16(shared, 1)), u16(0x4D))
	testing.expect_value(t, read_u16(&m.ds, add16(shared, 3)), u16(0xFFF1))
}

@(test)
test_relocate_planet :: proc(t: ^testing.T) {
	m := new(Machine)
	defer free(m)
	load_embedded(m)
	ds := transmute(^DS_Segment)&m.ds
	di := u16(offset_of(DS_Segment, planets))

	// Frame 4, seed 0. The first planet draw is 0x3828, the second is 0x29CA.
	// No live base, so that pair is kept. The level byte is not written.
	ds.frame_count = 4
	ds.rng_seed = 0
	ds.mode_bits = 0
	write_u8(&m.ds, di, 0xFF)
	write_u8(&m.ds, add16(di, 5), 3)
	write_u8(&m.ds, add16(di, 6), 9)
	write_u8(&m.ds, add16(di, 7), 9)
	write_u8(&m.ds, add16(di, 8), 9)
	write_u8(&m.ds, add16(di, 0x0A), 0)
	relocate_planet(m, di)
	testing.expect_value(t, read_u16(&m.ds, add16(di, 1)), u16(0x3828))
	testing.expect_value(t, read_u16(&m.ds, add16(di, 3)), u16(0x29CA))
	testing.expect_value(t, read_u8(&m.ds, di), u8(0x0E))
	testing.expect_value(t, read_u8(&m.ds, add16(di, 5)), u8(3))
	testing.expect_value(t, read_u8(&m.ds, add16(di, 6)), u8(0))
	testing.expect_value(t, read_u8(&m.ds, add16(di, 7)), u8(0))
	testing.expect_value(t, read_u8(&m.ds, add16(di, 8)), u8(0))
	testing.expect_value(t, read_u8(&m.ds, add16(di, 0x0A)), u8(0xFF))
	testing.expect_value(t, ds.rng_seed, u16(0xE9CA))

	// Mode bit 0 turns the type into 0xFE. A live base on the first pair
	// forces a second draw, at 0x0A36, 0x37EF.
	ds.rng_seed = 0
	ds.mode_bits = 1
	base := u16(offset_of(DS_Segment, bases))
	place_object(m, base, 0x3828, 0x29CA)
	write_u16(&m.ds, add16(base, 8), 50)
	relocate_planet(m, di)
	testing.expect_value(t, read_u16(&m.ds, add16(di, 1)), u16(0x0A36))
	testing.expect_value(t, read_u16(&m.ds, add16(di, 3)), u16(0x37EF))
	testing.expect_value(t, read_u8(&m.ds, di), u8(0xFE))
	testing.expect_value(t, ds.rng_seed, u16(0x77EF))
}

@(test)
test_random_planet_type :: proc(t: ^testing.T) {
	m := new(Machine)
	defer free(m)
	load_embedded(m)
	ds := transmute(^DS_Segment)&m.ds

	// Frame 4, seed 0. 0xC1B8 & 0x1F is 24, and CS:42BD[24] is 5.
	ds.frame_count = 4
	ds.rng_seed = 0
	testing.expect_value(t, random_planet_type(m), u8(5))
	testing.expect_value(t, ds.rng_seed, u16(0xC1B8))

	// Frame 0, seed 3584. The low 5 bits are 31, the last table byte.
	ds.frame_count = 0
	ds.rng_seed = 3584
	testing.expect_value(t, random_planet_type(m), u8(0x0E))
	testing.expect_value(t, ds.rng_seed, u16(0x41BF))
	testing.expect_value(t, m.cs[0x42BD], u8(1))
	testing.expect_value(t, m.cs[0x42BD + 31], u8(0x0E))
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

@(test)
test_satellite_level :: proc(t: ^testing.T) {
	m := new(Machine)
	defer free(m)
	load_embedded(m)
	ds := transmute(^DS_Segment)&m.ds
	si := u16(offset_of(DS_Segment, planets))

	// CX outside 3..8 returns 0 with carry clear. The 8086 left AL alone.
	for cx in ([]u16{0, 1, 2, 9, 0x8000, 0xFFFF}) {
		write_u8(&m.ds, add16(si, 5), 0xAB)
		al, carry := satellite_level(m, si, cx)
		testing.expect_value(t, al, u8(0))
		testing.expect_value(t, carry, false)
	}

	// galaxy_levels 0 never adds 10. The twelve table bytes stay.
	ds.galaxy_levels = 0
	table := [12]u8{1, 0, 0, 0, 2, 2, 1, 1, 3, 3, 3, 2}
	groups := [3]u16{3, 5, 7}
	for group in 0 ..< 3 {
		for level in 0 ..< 4 {
			write_u8(&m.ds, add16(si, 5), u8(level))
			al, carry := satellite_level(m, si, groups[group])
			testing.expect_value(t, al, table[group * 4 + level])
			testing.expect_value(t, carry, false)
			// CX+1 shares the same pair of table rows.
			al, carry = satellite_level(m, si, groups[group] + 1)
			testing.expect_value(t, al, table[group * 4 + level])
			testing.expect_value(t, carry, false)
		}
	}

	// A level byte above 3 keeps only its low 2 bits.
	write_u8(&m.ds, add16(si, 5), 0xFE)
	al, carry := satellite_level(m, si, 3)
	testing.expect_value(t, al, u8(0))
	testing.expect_value(t, carry, false)

	// galaxy_levels 1 adds 10 only when the table byte is 0.
	ds.galaxy_levels = 1
	write_u8(&m.ds, add16(si, 5), 0)
	al, carry = satellite_level(m, si, 3)
	testing.expect_value(t, al, u8(1))
	testing.expect_value(t, carry, false)
	write_u8(&m.ds, add16(si, 5), 1)
	al, carry = satellite_level(m, si, 3)
	testing.expect_value(t, al, u8(10))
	testing.expect_value(t, carry, true)

	// galaxy_levels 4 lifts every reachable table byte.
	ds.galaxy_levels = 4
	for group in 0 ..< 3 {
		for level in 0 ..< 4 {
			write_u8(&m.ds, add16(si, 5), u8(level))
			al, carry = satellite_level(m, si, groups[group])
			testing.expect_value(t, al, table[group * 4 + level] + 10)
			testing.expect_value(t, carry, true)
		}
	}

	// galaxy_levels 3 leaves a table byte of 3 and lifts 2.
	ds.galaxy_levels = 3
	write_u8(&m.ds, add16(si, 5), 0)
	al, carry = satellite_level(m, si, 7)
	testing.expect_value(t, al, u8(3))
	testing.expect_value(t, carry, false)
	write_u8(&m.ds, add16(si, 5), 3)
	al, carry = satellite_level(m, si, 7)
	testing.expect_value(t, al, u8(12))
	testing.expect_value(t, carry, true)
}

@(test)
test_place_planet_coords :: proc(t: ^testing.T) {
	m := new(Machine)
	defer free(m)
	load_embedded(m)
	ds := transmute(^DS_Segment)&m.ds
	si := planet_at(0, 0)
	other := planet_at(0, 1)

	// Frame 4, seed 2. The first planet pair is 0x03B8, 0x39E9.
	// Nothing else is occupied, so that pair is kept. The level stays.
	ds.frame_count = 4
	ds.rng_seed = 2
	ds.objects_per_level = 0
	ds.mode_bits = 0
	write_u8(&m.ds, si, 0x05)
	write_u8(&m.ds, add16(si, 5), 1)
	place_planet_coords(m, si)
	testing.expect_value(t, read_u16(&m.ds, add16(si, 1)), u16(0x03B8))
	testing.expect_value(t, read_u16(&m.ds, add16(si, 3)), u16(0x39E9))
	testing.expect_value(t, ds.rng_seed, u16(0x39E9))
	testing.expect_value(t, read_u8(&m.ds, si), u8(0x05))
	testing.expect_value(t, read_u8(&m.ds, add16(si, 5)), u8(1))

	// The same pair already occupied on this level forces the next pair.
	ds.rng_seed = 2
	ds.objects_per_level = 2
	write_u8(&m.ds, add16(si, 5), 0)
	place_object(m, other, 0x03B8, 0x39E9)
	write_u8(&m.ds, add16(other, 5), 0)
	place_planet_coords(m, si)
	testing.expect_value(t, read_u16(&m.ds, add16(si, 1)), u16(0x28AA))
	testing.expect_value(t, read_u16(&m.ds, add16(si, 3)), u16(0x2BF6))
	testing.expect_value(t, ds.rng_seed, u16(0x6BF6))
	testing.expect_value(t, read_u16(&m.ds, add16(other, 1)), u16(0x03B8))
	testing.expect_value(t, read_u16(&m.ds, add16(other, 3)), u16(0x39E9))

	// A live base on the first pair rejects it. No other planet is walked.
	ds.rng_seed = 2
	ds.objects_per_level = 0
	base := u16(offset_of(DS_Segment, bases))
	place_object(m, base, 0x03B8, 0x39E9)
	write_u16(&m.ds, add16(base, 8), 1)
	place_planet_coords(m, si)
	testing.expect_value(t, read_u16(&m.ds, add16(si, 1)), u16(0x28AA))
	testing.expect_value(t, read_u16(&m.ds, add16(si, 3)), u16(0x2BF6))
	testing.expect_value(t, ds.rng_seed, u16(0x6BF6))
	testing.expect_value(t, read_u16(&m.ds, add16(base, 8)), u16(1))
}

@(test)
test_place_base_coords :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)
	raw := transmute(^[DS_SIZE]u8)ds
	base := u16(offset_of(DS_Segment, bases))

	ds.frame_count = 4
	ds.rng_seed = 6
	ds.bases[0][0] = 0x80
	ds.bases[0][5] = 0x11
	ds.bases[1][1] = 0x22
	place_base_coords(ds, base)
	testing.expect_value(t, read_u16(raw, add16(base, 1)), u16(0x07B8))
	testing.expect_value(t, read_u16(raw, add16(base, 3)), u16(0x382A))
	testing.expect_value(t, ds.rng_seed, u16(0x382A))
	testing.expect_value(t, ds.bases[0][0], u8(0x80))
	testing.expect_value(t, ds.bases[0][5], u8(0x11))
	testing.expect_value(t, ds.bases[1][1], u8(0x22))

	// SI+3 at FFFF wraps the high byte onto 0000.
	ds.frame_count = 4
	ds.rng_seed = 6
	ds.objects_per_level = 0x99
	place_base_coords(ds, 0xFFFC)
	testing.expect_value(t, raw[0xFFFD], u8(0xB8))
	testing.expect_value(t, raw[0xFFFE], u8(0x07))
	testing.expect_value(t, raw[0xFFFF], u8(0x2A))
	testing.expect_value(t, raw[0x0000], u8(0x38))
}

@(private)
place_object :: proc(m: ^Machine, at, x, y: u16) {
	write_u16(&m.ds, add16(at, 1), x)
	write_u16(&m.ds, add16(at, 3), y)
}
