package trek

import "core:testing"

@(test)
test_add_pending_charge :: proc(t: ^testing.T) {
	ship: Ship_Record
	ship.flags = 0xAB
	ship.impulse = 0x11
	ship.invisibility = 0xCD

	add_pending_charge(&ship, 0)
	testing.expect_value(t, ship.pending_charge, u16(0))
	testing.expect_value(t, ship.damage, u8(0))

	add_pending_charge(&ship, 50)
	testing.expect_value(t, ship.pending_charge, u16(50))
	testing.expect_value(t, ship.damage, u8(0))

	// 0x3FF shifted twice is 0xFF, so AH is still 0.
	clear_charge(&ship)
	add_pending_charge(&ship, 0x3FF)
	testing.expect_value(t, ship.pending_charge, u16(0x3FF))
	testing.expect_value(t, ship.damage, u8(0))

	// 0x400 shifted twice is 0x100. Damage increases by 1.
	clear_charge(&ship)
	add_pending_charge(&ship, 0x400)
	testing.expect_value(t, ship.pending_charge, u16(0x400))
	testing.expect_value(t, ship.damage, u8(1))

	// 0x7FF still has AH == 1. 0x800 has AH == 2.
	clear_charge(&ship)
	add_pending_charge(&ship, 0x7FF)
	testing.expect_value(t, ship.damage, u8(1))
	clear_charge(&ship)
	add_pending_charge(&ship, 0x800)
	testing.expect_value(t, ship.pending_charge, u16(0x800))
	testing.expect_value(t, ship.damage, u8(2))

	// A full AX stores 0xFFFF and adds 0x3F to damage.
	clear_charge(&ship)
	add_pending_charge(&ship, 0xFFFF)
	testing.expect_value(t, ship.pending_charge, u16(0xFFFF))
	testing.expect_value(t, ship.damage, u8(0x3F))

	// Carry replaces the wrapped sum with 0xFFFF. Damage still follows AX.
	clear_charge(&ship)
	ship.pending_charge = 0xFFFF
	ship.damage = 5
	add_pending_charge(&ship, 1)
	testing.expect_value(t, ship.pending_charge, u16(0xFFFF))
	testing.expect_value(t, ship.damage, u8(5))

	clear_charge(&ship)
	ship.pending_charge = 0xFFFF
	ship.damage = 5
	add_pending_charge(&ship, 0x400)
	testing.expect_value(t, ship.pending_charge, u16(0xFFFF))
	testing.expect_value(t, ship.damage, u8(6))

	// 0xC000 + 0x5000 carries. 0x5000 >> 10 is 0x14.
	clear_charge(&ship)
	ship.pending_charge = 0xC000
	add_pending_charge(&ship, 0x5000)
	testing.expect_value(t, ship.pending_charge, u16(0xFFFF))
	testing.expect_value(t, ship.damage, u8(0x14))

	// 0x200 >> 10 is 0, so a saturating add leaves damage alone.
	clear_charge(&ship)
	ship.pending_charge = 0xFF00
	ship.damage = 9
	add_pending_charge(&ship, 0x200)
	testing.expect_value(t, ship.pending_charge, u16(0xFFFF))
	testing.expect_value(t, ship.damage, u8(9))

	// The damage byte wraps. 0xFF + 1 becomes 0. 0xE0 + 0x3F becomes 0x1F.
	clear_charge(&ship)
	ship.damage = 0xFF
	add_pending_charge(&ship, 0x400)
	testing.expect_value(t, ship.damage, u8(0))

	clear_charge(&ship)
	ship.pending_charge = 0xFFFF
	ship.damage = 0xE0
	add_pending_charge(&ship, 0xFFFF)
	testing.expect_value(t, ship.pending_charge, u16(0xFFFF))
	testing.expect_value(t, ship.damage, u8(0x1F))

	testing.expect_value(t, ship.flags, u8(0xAB))
	testing.expect_value(t, ship.impulse, u8(0x11))
	testing.expect_value(t, ship.invisibility, u8(0xCD))
}

@(test)
test_add_pending_charge_on_ds_ship :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)
	ship := &ds.ships[2][3]
	ship.flags = 0x80
	ship.impulse = 0x11
	add_pending_charge(ship, 0x400)
	testing.expect_value(t, ship.pending_charge, u16(0x400))
	testing.expect_value(t, ship.damage, u8(1))
	testing.expect_value(t, ship.flags, u8(0x80))
	testing.expect_value(t, ship.impulse, u8(0x11))
	testing.expect_value(t, ds.ships[2][2].pending_charge, u16(0))
	testing.expect_value(t, ds.extra_records[0].pending_charge, u16(0))
}

@(test)
test_slew_heading :: proc(t: ^testing.T) {
	Case :: struct {
		heading:  u8,
		seek:     u8,
		distance: u16,
		want:     u8,
	}
	cases := []Case{
		{0x33, 0x00, 0, 0x33},
		{0x10, 0x00, 0, 0x11},
		{0x40, 0x00, 0, 0x41},
		{0x50, 0x00, 0, 0x52},
		{0x80, 0x00, 0, 0x82},
		{0x90, 0x00, 0, 0x9E},
		{0xB0, 0x00, 0, 0xBE},
		{0xC0, 0x00, 0, 0xCF},
		{0xF0, 0x00, 0, 0xFF},
		{0x0F, 0x00, 0, 0x00},
		{0x1F, 0x00, 0, 0x10},
		{0xA1, 0x00, 0, 0xAF},
		{0xFF, 0x00, 0, 0xFF},
		{0x50, 0x01, 0x0000, 0x55},
		{0x50, 0x01, 0x00FA, 0x55},
		{0x50, 0x1F, 0x00FA, 0x55},
		{0x5A, 0x03, 100, 0x55},
		{0x50, 0x01, 0x00FB, 0x52},
		{0x50, 0x01, 0xFFFF, 0x52},
		{0x50, 0xE0, 0, 0x52},
		{0x10, 0x01, 0xFFFF, 0x11},
	}
	for c in cases {
		ship: Ship_Record
		ship.heading = c.heading
		ship.seek = c.seek
		ship.seek_distance = c.distance
		ship.flags = 0x80
		ship.energy = 0x1234
		slew_heading(&ship)
		testing.expect_value(t, ship.heading, c.want)
		testing.expect_value(t, ship.flags, u8(0x80))
		testing.expect_value(t, ship.energy, u16(0x1234))
		testing.expect_value(t, ship.seek, c.seek)
		testing.expect_value(t, ship.seek_distance, c.distance)
	}
}

@(test)
test_step_impulse :: proc(t: ^testing.T) {
	ship: Ship_Record
	ship.impulse_wait = 5
	ship.pending_charge = 9
	got := step_impulse(&ship, 0x33)
	testing.expect_value(t, got, u8(3))
	testing.expect_value(t, ship.impulse_wait, u8(0))
	testing.expect_value(t, ship.pending_charge, u16(9))

	// Desired 5, actual 0. The first call only arms the wait at ((12-5) >> 2) + 1.
	ship = {}
	got = step_impulse(&ship, 0x50)
	testing.expect_value(t, got, u8(0))
	testing.expect_value(t, ship.impulse_wait, u8(2))
	testing.expect_value(t, ship.pending_charge, u16(0))

	got = step_impulse(&ship, 0x50)
	testing.expect_value(t, got, u8(0))
	testing.expect_value(t, ship.impulse_wait, u8(1))
	testing.expect_value(t, ship.pending_charge, u16(0))

	// The call that reaches zero steps actual to 1 and charges 2 * 5.
	got = step_impulse(&ship, 0x50)
	testing.expect_value(t, got, u8(1))
	testing.expect_value(t, ship.pending_charge, u16(10))
	testing.expect_value(t, ship.impulse_wait, u8(4))
	testing.expect_value(t, ship.damage, u8(0))

	// Desired 1, actual 5. Wait 1 steps the actual nibble down and charges 8.
	ship = {}
	ship.impulse_wait = 1
	got = step_impulse(&ship, 0x15)
	testing.expect_value(t, got, u8(4))
	testing.expect_value(t, ship.pending_charge, u16(8))
	testing.expect_value(t, ship.impulse_wait, u8(5))

	// A long wait is pulled down when 12 - gap still covers it. Gap 1: (11 >> 1) + 1 = 6.
	ship = {}
	ship.impulse_wait = 20
	got = step_impulse(&ship, 0x10)
	testing.expect_value(t, got, u8(0))
	testing.expect_value(t, ship.impulse_wait, u8(6))
	testing.expect_value(t, ship.pending_charge, u16(0))

	// A wait already below 12 - gap only decrements.
	ship.impulse_wait = 10
	got = step_impulse(&ship, 0x10)
	testing.expect_value(t, got, u8(0))
	testing.expect_value(t, ship.impulse_wait, u8(9))

	// Gap 13 wraps 12 - gap. The armed wait is (0xFF >> 2) + 1.
	ship = {}
	got = step_impulse(&ship, 0xD0)
	testing.expect_value(t, got, u8(0))
	testing.expect_value(t, ship.impulse_wait, u8(0x40))

	// Gap 15 steps down. 0xFFFE + 30 carries, so the charge saturates.
	ship = {}
	ship.impulse_wait = 1
	ship.pending_charge = 0xFFFE
	got = step_impulse(&ship, 0x0F)
	testing.expect_value(t, got, u8(14))
	testing.expect_value(t, ship.pending_charge, u16(0xFFFF))
	testing.expect_value(t, ship.impulse_wait, u8(0x7F))
	testing.expect_value(t, ship.damage, u8(0))
}

@(test)
test_slew_impulse :: proc(t: ^testing.T) {
	ship: Ship_Record
	ship.heading = 0x10
	slew_impulse(&ship)
	testing.expect_value(t, ship.heading, u8(0x11))
	testing.expect_value(t, ship.impulse, u8(0))
	testing.expect_value(t, ship.impulse_wait, u8(0))

	// Warp is 0 and the desired nibble is 11, so it becomes 10 before the arm.
	ship = {}
	ship.impulse = 0xB3
	slew_impulse(&ship)
	testing.expect_value(t, ship.impulse, u8(0xA3))
	testing.expect_value(t, ship.impulse_wait, u8(2))

	// A running warp timer leaves desired 11 in place. Gap 8 arms a wait of 2.
	ship = {}
	ship.warp = 5
	ship.impulse = 0xB3
	slew_impulse(&ship)
	testing.expect_value(t, ship.impulse, u8(0xB3))
	testing.expect_value(t, ship.impulse_wait, u8(2))
	testing.expect_value(t, ship.warp, u8(5))

	// Desired 10 is below the pull. The byte stays, and the wait arms for gap 5.
	ship = {}
	ship.impulse = 0xAF
	slew_impulse(&ship)
	testing.expect_value(t, ship.impulse, u8(0xAF))
	testing.expect_value(t, ship.impulse_wait, u8(2))

	// Wait 1 steps actual from 0 to 1 and keeps desired 5. Charge is 10.
	ship = {}
	ship.impulse = 0x50
	ship.impulse_wait = 1
	ship.flags = 0x80
	slew_impulse(&ship)
	testing.expect_value(t, ship.impulse, u8(0x51))
	testing.expect_value(t, ship.pending_charge, u16(10))
	testing.expect_value(t, ship.impulse_wait, u8(4))
	testing.expect_value(t, ship.flags, u8(0x80))

	// The pull to desired 10 happens before the step. Gap 10 charges 20.
	ship = {}
	ship.impulse = 0xB0
	ship.impulse_wait = 1
	slew_impulse(&ship)
	testing.expect_value(t, ship.impulse, u8(0xA1))
	testing.expect_value(t, ship.pending_charge, u16(20))
	testing.expect_value(t, ship.impulse_wait, u8(2))

	// Heading gap 2 steps by 1 in the same call that arms impulse gap 1.
	ship = {}
	ship.heading = 0x20
	ship.impulse = 0x10
	slew_impulse(&ship)
	testing.expect_value(t, ship.heading, u8(0x21))
	testing.expect_value(t, ship.impulse, u8(0x10))
	testing.expect_value(t, ship.impulse_wait, u8(3))
}

@(test)
test_apply_damage_thresholds :: proc(t: ^testing.T) {
	Case :: struct {
		damage:        u8,
		flags:         u8,
		want_flags:    u8,
		seek:          u8,
		want_seek:     u8,
		cooldown:      u8,
		want_cooldown: u8,
		byte_2a:       u8,
		want_2a:       u8,
		get_mine:      u8,
		want_mine:     u8,
	}
	cases := []Case{
		{0x00, 0xFF, 0xFF, 0x1A, 0x1A, 0x05, 0x05, 0x08, 0x08, 0x01, 0x01},
		{0x07, 0xB4, 0xB4, 0x1A, 0x1A, 0x05, 0x05, 0x08, 0x08, 0x01, 0x01},
		{0x08, 0xFF, 0xCF, 0x1A, 0x1A, 0x05, 0x05, 0x08, 0x08, 0x01, 0x01},
		{0x0B, 0xB0, 0x80, 0x1F, 0x1F, 0x00, 0x00, 0xFF, 0xFF, 0x03, 0x03},
		{0x0C, 0xFF, 0xCF, 0x1A, 0x00, 0x05, 0x05, 0x08, 0x08, 0x01, 0x01},
		{0x0F, 0xF5, 0xC5, 0xFF, 0x00, 0x01, 0x01, 0x08, 0x08, 0x01, 0x01},
		{0x10, 0xFF, 0xCF, 0x1A, 0x00, 0x01, 0x18, 0x08, 0x08, 0x01, 0x01},
		{0x13, 0x80, 0x80, 0x02, 0x00, 0xFF, 0x18, 0x08, 0x08, 0x01, 0x01},
		{0x14, 0xFF, 0xCF, 0x1A, 0x00, 0x00, 0x18, 0xFF, 0x00, 0xFF, 0x00},
		{0xFF, 0xB5, 0x85, 0x11, 0x00, 0x18, 0x18, 0x04, 0x00, 0x01, 0x00},
	}
	for c in cases {
		ship: Ship_Record
		ship.damage = c.damage
		ship.flags = c.flags
		ship.seek = c.seek
		ship.seek_distance = 0x00FA
		ship.weapons_cooldown = c.cooldown
		ship.byte_2a = c.byte_2a
		ship.get_mine = c.get_mine
		ship.invisibility = 0x63
		ship.energy = 0x1234
		ship.heading = 0x21
		apply_damage_thresholds(&ship)
		testing.expect_value(t, ship.damage, c.damage)
		testing.expect_value(t, ship.flags, c.want_flags)
		testing.expect_value(t, ship.seek, c.want_seek)
		testing.expect_value(t, ship.seek_distance, u16(0x00FA))
		testing.expect_value(t, ship.weapons_cooldown, c.want_cooldown)
		testing.expect_value(t, ship.byte_2a, c.want_2a)
		testing.expect_value(t, ship.get_mine, c.want_mine)
		testing.expect_value(t, ship.invisibility, u8(0x63))
		testing.expect_value(t, ship.energy, u16(0x1234))
		testing.expect_value(t, ship.heading, u8(0x21))
	}

	// Damage that stays at 0x10 stores 0x18 again on the next call.
	ship: Ship_Record
	ship.damage = 0x10
	ship.flags = 0x80
	ship.weapons_cooldown = 0x18
	apply_damage_thresholds(&ship)
	ship.weapons_cooldown = 0x99
	apply_damage_thresholds(&ship)
	testing.expect_value(t, ship.weapons_cooldown, u8(0x18))
	testing.expect_value(t, ship.flags, u8(0x80))
}

@(test)
test_charge_impulse_and_heal :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)
	ds.ships[2][2].energy = 0x1111

	// A side byte of exactly 1 zeros energy and leaves the rest of the record.
	ds.current_side = 0
	ds.side_89d8[0] = 1
	ds.frame_count = 0
	ship := &ds.ships[0][0]
	ship.energy = 0x1000
	ship.weapons_cooldown = 5
	ship.warp = 3
	ship.pending_charge = 9
	ship.damage = 4
	ship.impulse = 0x58
	ship.flags = 0xA0
	ship.heading = 0x21
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.energy, u16(0))
	testing.expect_value(t, ship.weapons_cooldown, u8(5))
	testing.expect_value(t, ship.warp, u8(3))
	testing.expect_value(t, ship.pending_charge, u16(9))
	testing.expect_value(t, ship.damage, u8(4))
	testing.expect_value(t, ship.impulse, u8(0x58))
	testing.expect_value(t, ship.flags, u8(0xA0))
	testing.expect_value(t, ship.heading, u8(0x21))

	// current_side selects the byte. Side 1 is 1, so this ship is zeroed.
	ds.side_89d8 = {0, 1, 0, 0}
	ds.current_side = 1
	ship = &ds.ships[1][2]
	ship.energy = 50
	ship.weapons_cooldown = 2
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.energy, u16(0))
	testing.expect_value(t, ship.weapons_cooldown, u8(2))

	// Side 0 is 0. Frame 1 still ticks the cooldown and clears warp at 0x7D0.
	ds.current_side = 0
	ds.frame_count = 1
	ship = &ds.ships[0][1]
	ship.energy = 0x07D0
	ship.warp = 9
	ship.weapons_cooldown = 1
	ship.impulse = 0x4F
	ship.pending_charge = 11
	ship.damage = 6
	ship.flags = 0x80
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.energy, u16(0x07D0))
	testing.expect_value(t, ship.warp, u8(0))
	testing.expect_value(t, ship.weapons_cooldown, u8(0))
	testing.expect_value(t, ship.pending_charge, u16(11))
	testing.expect_value(t, ship.damage, u8(6))

	// Energy 0x7D1 keeps warp. A zero cooldown stays 0. Frame 3 skips the charge.
	ds.frame_count = 3
	ship.energy = 0x07D1
	ship.warp = 4
	ship.weapons_cooldown = 0
	ship.pending_charge = 11
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.warp, u8(4))
	testing.expect_value(t, ship.weapons_cooldown, u8(0))
	testing.expect_value(t, ship.pending_charge, u16(11))
	testing.expect_value(t, ship.energy, u16(0x07D1))

	// A side byte of 0x81 is not 1. The high byte of the frame word is ignored.
	ds.side_89d8[0] = 0x81
	ds.frame_count = 0x0101
	ship.energy = 0x2000
	ship.warp = 6
	ship.weapons_cooldown = 8
	ship.pending_charge = 3
	ship.damage = 2
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.energy, u16(0x2000))
	testing.expect_value(t, ship.warp, u8(6))
	testing.expect_value(t, ship.weapons_cooldown, u8(7))
	testing.expect_value(t, ship.pending_charge, u16(3))
	testing.expect_value(t, ship.damage, u8(2))

	// Energy above both thresholds. Frame 0 charges the actual nibble and does
	// not heal while damage is 0.
	ds.side_89d8[0] = 0
	ds.frame_count = 0
	costs := []u16{0, 5, 5, 5, 10, 10, 10, 10, 15, 15, 15, 10, 10, 10, 10, 10}
	for nibble in 0 ..< 16 {
		ship.energy = 0x2000
		ship.warp = 6
		ship.weapons_cooldown = 0
		ship.flags = 0x80
		ship.impulse = 0xA0 | u8(nibble)
		ship.pending_charge = 0
		ship.damage = 0
		charge_impulse_and_heal(ds, ship)
		testing.expectf(t, ship.pending_charge == costs[nibble], "nibble %d charge %d", nibble, ship.pending_charge)
		testing.expectf(t, ship.damage == 0, "nibble %d damage %d", nibble, ship.damage)
		testing.expectf(t, ship.warp == 6, "nibble %d warp %d", nibble, ship.warp)
		testing.expectf(t, ship.impulse == 0xA0 | u8(nibble), "nibble %d impulse %d", nibble, ship.impulse)
	}

	// 0x3E8 halves the cost. 0x3E9 keeps it. Nibble 8 costs 15, so the halves are 7 and 15.
	ship.energy = 0x03E8
	ship.impulse = 0x08
	ship.pending_charge = 0
	ship.damage = 0
	ship.flags = 0x80
	ship.warp = 2
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.pending_charge, u16(7))
	testing.expect_value(t, ship.warp, u8(0))

	ship.energy = 0x03E9
	ship.pending_charge = 0
	ship.warp = 2
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.pending_charge, u16(15))
	testing.expect_value(t, ship.warp, u8(0))

	// Flag bit 0x20 adds energy / 0x4B to the unhalved cost. 3000 / 75 + 10 = 50.
	ship.energy = 3000
	ship.flags = 0xA0
	ship.impulse = 0x14
	ship.pending_charge = 0
	ship.damage = 4
	ship.warp = 5
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.pending_charge, u16(50))
	testing.expect_value(t, ship.damage, u8(4))
	testing.expect_value(t, ship.warp, u8(5))
	testing.expect_value(t, ship.flags, u8(0xA0))

	// The same energy without the flag charges only the nibble cost.
	ship.flags = 0x80
	ship.pending_charge = 20
	ship.damage = 4
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.pending_charge, u16(30))
	testing.expect_value(t, ship.damage, u8(4))

	// Low energy halves before the division is added. 150 / 75 + (15 >> 1) = 9.
	ship.energy = 150
	ship.flags = 0xA0
	ship.impulse = 0x08
	ship.pending_charge = 0
	ship.damage = 0
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.pending_charge, u16(9))

	// 0xFFFF / 75 + 10 = 883. That stays below the damage bump at 0x400.
	ship.energy = 0xFFFF
	ship.flags = 0xA0
	ship.impulse = 0x0F
	ship.pending_charge = 0
	ship.damage = 9
	ship.warp = 1
	ds.frame_count = 8
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.pending_charge, u16(883))
	testing.expect_value(t, ship.damage, u8(9))
	testing.expect_value(t, ship.warp, u8(1))

	// Frame 0 heals when the actual nibble is at most 2, and leaves higher nibbles.
	ds.frame_count = 0
	ship.energy = 0x2000
	ship.flags = 0x80
	ship.impulse = 0x02
	ship.pending_charge = 0
	ship.damage = 4
	ship.warp = 6
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.pending_charge, u16(5))
	testing.expect_value(t, ship.damage, u8(3))

	ship.impulse = 0x03
	ship.pending_charge = 0
	ship.damage = 4
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.pending_charge, u16(5))
	testing.expect_value(t, ship.damage, u8(4))

	ship.impulse = 0x00
	ship.pending_charge = 0
	ship.damage = 0
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.pending_charge, u16(0))
	testing.expect_value(t, ship.damage, u8(0))

	// Frame 4 has bit 2 set, so nibble 15 heals too. 0x0104 uses the same low byte.
	ds.frame_count = 0x0104
	ship.impulse = 0x0F
	ship.pending_charge = 0
	ship.damage = 1
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.pending_charge, u16(10))
	testing.expect_value(t, ship.damage, u8(0))

	// A charge already at 0xFFFE saturates. The added 5 does not bump damage.
	ds.frame_count = 0
	ship.energy = 0x2000
	ship.impulse = 0x01
	ship.pending_charge = 0xFFFE
	ship.damage = 0
	charge_impulse_and_heal(ds, ship)
	testing.expect_value(t, ship.pending_charge, u16(0xFFFF))
	testing.expect_value(t, ship.damage, u8(0))

	testing.expect_value(t, ds.frame_count, u16(0))
	testing.expect_value(t, ds.ships[2][2].energy, u16(0x1111))
	testing.expect_value(t, ds.ships[2][2].pending_charge, u16(0))
}

@(test)
test_add_scaled_charge :: proc(t: ^testing.T) {
	Case :: struct {
		ax:          u16,
		byte_34:     u8,
		flags:       u8,
		shot:        u8,
		charge:      u16,
		damage:      u8,
		want_charge: u16,
		want_damage: u8,
		want_ax:     u16,
	}
	cases := []Case{
		{0x0400, 0x00, 0x00, 0x00, 0x0000, 0x00, 0x0400, 0x01, 0x0400},
		{0x1000, 0x01, 0x00, 0x00, 0x0000, 0x00, 0x0400, 0x01, 0x0400},
		{0x0FFF, 0xFF, 0x00, 0x00, 0x0000, 0x00, 0x03FF, 0x00, 0x03FF},
		{10, 0x00, 0x20, 0x00, 0x0000, 0x00, 3, 0x00, 3},
		{10, 0x00, 0x20, 0x80, 0x0000, 0x00, 10, 0x00, 10},
		{8, 0x00, 0x20, 0x26, 0x0000, 0x00, 2, 0x00, 2},
		{5, 0x00, 0xA0, 0x00, 0x0000, 0x00, 1, 0x00, 1},
		{5, 0x00, 0x00, 0x00, 0x0000, 0x00, 5, 0x00, 5},
		{0xFFFF, 0x01, 0x20, 0x00, 0x0000, 0x00, 5461, 0x05, 5461},
		{0xFFFF, 0x00, 0x20, 0x00, 0x0000, 0x00, 0x5555, 21, 0x5555},
		{0xFFFF, 0x01, 0x00, 0x00, 0x0000, 0x00, 0x3FFF, 15, 0x3FFF},
		{0x0200, 0x00, 0x00, 0x00, 0xFF00, 0x00, 0xFFFF, 0x00, 0x0200},
		{0, 0x00, 0x20, 0x00, 0xFFFF, 0x04, 0xFFFF, 0x04, 0},
		{2, 0x00, 0x20, 0x7F, 0x0000, 0x00, 0, 0x00, 0},
		{0x1000, 0x01, 0x20, 0x80, 0x0000, 0x00, 0x0400, 0x01, 0x0400},
		{0x0400, 0x00, 0x00, 0x00, 0x0000, 0xFF, 0x0400, 0x00, 0x0400},
		{0xFFFF, 0x00, 0x20, 0x00, 0xFF00, 0xF0, 0xFFFF, 0x05, 0x5555},
		{100, 0x00, 0x20, 0x00, 0x0000, 0x00, 33, 0x00, 33},
		{0x1388, 0x01, 0x20, 0x00, 0x0000, 0x00, 416, 0x00, 416},
		{1, 0x00, 0x20, 0x00, 7, 0x00, 7, 0x00, 0},
	}
	for c in cases {
		ship: Ship_Record
		ship.byte_34 = c.byte_34
		ship.flags = c.flags
		ship.shot = c.shot
		ship.pending_charge = c.charge
		ship.damage = c.damage
		ship.energy = 0x1234
		ship.heading = 0x21
		got := add_scaled_charge(&ship, c.ax)
		testing.expect_value(t, got, c.want_ax)
		testing.expect_value(t, ship.pending_charge, c.want_charge)
		testing.expect_value(t, ship.damage, c.want_damage)
		testing.expect_value(t, ship.byte_34, c.byte_34)
		testing.expect_value(t, ship.flags, c.flags)
		testing.expect_value(t, ship.shot, c.shot)
		testing.expect_value(t, ship.energy, u16(0x1234))
		testing.expect_value(t, ship.heading, u8(0x21))
	}
}

@(test)
test_read_handicap :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)
	ds.ids[0][3] = 9
	ds.ids[0][4] = 2
	ds.ids[1][4] = 7
	ds.ids[2][4] = 0
	ds.ids[3][4] = 0xFF

	ds.current_side = 0
	testing.expect_value(t, read_handicap(ds), u8(2))
	ds.current_side = 1
	testing.expect_value(t, read_handicap(ds), u8(7))
	ds.current_side = 2
	testing.expect_value(t, read_handicap(ds), u8(0))
	ds.current_side = 3
	testing.expect_value(t, read_handicap(ds), u8(0xFF))
	// 1000:1ece masks the side with 3. 5 selects the same record as 1.
	ds.current_side = 5
	testing.expect_value(t, read_handicap(ds), u8(7))
	testing.expect_value(t, ds.ids[0][3], u8(9))
	testing.expect_value(t, ds.ids[1][4], u8(7))
}

@(test)
test_drain_invisibility :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)
	ds.current_side = 0
	ds.ids[0][4] = 0

	// Odd frames return before any of the ship tests.
	ds.frame_count = 1
	ship := &ds.ships[0][0]
	ship.flags = 0x90
	ship.invisibility = 5
	ship.shot = 0
	drain_invisibility(ds, ship)
	testing.expect_value(t, ship.invisibility, u8(5))
	testing.expect_value(t, ship.flags, u8(0x90))

	// A shot in flight, a clear invisible bit, or flag bits 0x44 return.
	ds.frame_count = 0
	ship.shot = 0x26
	drain_invisibility(ds, ship)
	testing.expect_value(t, ship.invisibility, u8(5))
	ship.shot = 0
	ship.flags = 0x80
	drain_invisibility(ds, ship)
	testing.expect_value(t, ship.invisibility, u8(5))
	testing.expect_value(t, ship.flags, u8(0x80))
	ship.flags = 0x14
	drain_invisibility(ds, ship)
	testing.expect_value(t, ship.flags, u8(0x14))
	ship.flags = 0x50
	drain_invisibility(ds, ship)
	testing.expect_value(t, ship.flags, u8(0x50))

	// An invisibility byte of 0 clears bit 0x10 and does not read the handicap.
	ds.ids[0][4] = 9
	ship.flags = 0xB1
	ship.invisibility = 0
	ship.energy = 0x1234
	drain_invisibility(ds, ship)
	testing.expect_value(t, ship.flags, u8(0xA1))
	testing.expect_value(t, ship.invisibility, u8(0))
	testing.expect_value(t, ds.ids[0][4], u8(9))
	testing.expect_value(t, ship.energy, u16(0x1234))

	// Handicap below 4 decrements on every even frame, including frame 0.
	ds.ids[0][4] = 3
	ship.flags = 0x90
	ship.invisibility = 3
	ds.frame_count = 0
	drain_invisibility(ds, ship)
	testing.expect_value(t, ship.invisibility, u8(2))
	testing.expect_value(t, ship.flags, u8(0x90))

	// The decrement that reaches zero clears the invisible bit.
	ship.invisibility = 1
	drain_invisibility(ds, ship)
	testing.expect_value(t, ship.invisibility, u8(0))
	testing.expect_value(t, ship.flags, u8(0x80))

	// Handicap 4 skips a frame whose low two bits are clear, and decrements
	// when they are 2. The high byte of the frame word is not read.
	ds.ids[0][4] = 4
	ship.flags = 0x90
	ship.invisibility = 5
	ds.frame_count = 0x0100
	drain_invisibility(ds, ship)
	testing.expect_value(t, ship.invisibility, u8(5))
	testing.expect_value(t, ship.flags, u8(0x90))
	ds.frame_count = 0x0102
	drain_invisibility(ds, ship)
	testing.expect_value(t, ship.invisibility, u8(4))
	testing.expect_value(t, ship.flags, u8(0x90))

	// current_side selects the handicap byte. Side 1 is below 4.
	ds.current_side = 1
	ds.ids[1][4] = 1
	ds.frame_count = 4
	ship = &ds.ships[1][0]
	ship.flags = 0x10
	ship.invisibility = 2
	drain_invisibility(ds, ship)
	testing.expect_value(t, ship.invisibility, u8(1))
	testing.expect_value(t, ship.flags, u8(0x10))
}

@(test)
test_spawn_debris :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)
	ship := &ds.ships[0][0]
	ship.x = 0x1234
	ship.y = 0xABCD
	ship.plane = 2
	ship.team = 7
	ship.flags = 0x08

	spawn_debris(ds, ship)
	testing.expect_value(t, ds.debris[0][0], u8(0xC8))
	testing.expect_value(t, ds.debris[0][1], u8(0x34))
	testing.expect_value(t, ds.debris[0][2], u8(0x12))
	testing.expect_value(t, ds.debris[0][3], u8(0xCD))
	testing.expect_value(t, ds.debris[0][4], u8(0xAB))
	testing.expect_value(t, ds.debris[0][5], u8(2))
	testing.expect_value(t, ds.debris[0][6], u8(7))
	testing.expect_value(t, ds.debris[1][0], u8(0))
	testing.expect_value(t, ship.flags, u8(0x08))
	testing.expect_value(t, ship.x, u16(0x1234))

	// The next free slot is used, and junk in that slot is overwritten.
	ds.debris[1][1] = 0xEE
	ds.debris[1][4] = 0xEE
	ship.x = 1
	ship.y = 2
	ship.plane = 0
	ship.team = 3
	spawn_debris(ds, ship)
	testing.expect_value(t, ds.debris[0][0], u8(0xC8))
	testing.expect_value(t, ds.debris[1][0], u8(0xC8))
	testing.expect_value(t, ds.debris[1][1], u8(1))
	testing.expect_value(t, ds.debris[1][2], u8(0))
	testing.expect_value(t, ds.debris[1][3], u8(2))
	testing.expect_value(t, ds.debris[1][4], u8(0))
	testing.expect_value(t, ds.debris[1][5], u8(0))
	testing.expect_value(t, ds.debris[1][6], u8(3))
	testing.expect_value(t, ds.debris[2][0], u8(0))

	for &slot in ds.debris {
		slot[0] = 1
	}
	spawn_debris(ds, ship)
	for slot in ds.debris {
		testing.expect_value(t, slot[0], u8(1))
	}
	testing.expect_value(t, ship.x, u16(1))
}

@(test)
test_tick_mine_lifetimes :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)
	ds.bases[0][6] = 20
	ds.bases[0][0] = 0x80
	ds.bases[1][6] = 0xFF
	ds.mines[0][0][0] = 0
	ds.mines[0][0][1] = 0x11
	ds.mines[0][1][0] = 1
	ds.mines[0][1][3] = 0x22
	ds.mines[0][2][0] = 2
	ds.mines[0][3][0] = 3
	ds.mines[0][4][0] = 0x10
	ds.mines[1][0][0] = 1
	ds.mines[1][1][0] = 1
	ds.mines[3][19][0] = 4
	ds.frame_count = 1

	tick_mine_lifetimes(ds)
	testing.expect_value(t, ds.mines[0][0][0], u8(0))
	testing.expect_value(t, ds.mines[0][0][1], u8(0x11))
	testing.expect_value(t, ds.mines[0][1][0], u8(0))
	testing.expect_value(t, ds.mines[0][1][3], u8(0x22))
	testing.expect_value(t, ds.mines[0][2][0], u8(1))
	testing.expect_value(t, ds.mines[0][3][0], u8(3))
	testing.expect_value(t, ds.mines[0][4][0], u8(0x10))
	testing.expect_value(t, ds.bases[0][6], u8(21))
	testing.expect_value(t, ds.bases[0][0], u8(0x80))
	// Two expirations on side 1 wrap the stock byte.
	testing.expect_value(t, ds.mines[1][0][0], u8(0))
	testing.expect_value(t, ds.mines[1][1][0], u8(0))
	testing.expect_value(t, ds.bases[1][6], u8(1))
	testing.expect_value(t, ds.mines[3][19][0], u8(4))

	// Frame low byte 0 decrements lifetimes above 2. The high byte is ignored.
	ds.frame_count = 0x0100
	ds.mines[0][2][0] = 2
	tick_mine_lifetimes(ds)
	testing.expect_value(t, ds.mines[0][2][0], u8(1))
	testing.expect_value(t, ds.mines[0][3][0], u8(2))
	testing.expect_value(t, ds.mines[0][4][0], u8(0x0F))
	testing.expect_value(t, ds.mines[3][19][0], u8(3))
	testing.expect_value(t, ds.bases[0][6], u8(21))
}

@(test)
test_update_pause :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)

	ds.pause_delay = 5
	update_pause(ds)
	testing.expect_value(t, ds.pause_mask, u8(0))
	testing.expect_value(t, ds.pause_delay, u8(0))

	ds.pause_mask = 0x01
	ds.pause_delay = 0
	update_pause(ds)
	testing.expect_value(t, ds.pause_mask, u8(0x8F))

	ds.pause_mask = 0x10
	update_pause(ds)
	testing.expect_value(t, ds.pause_mask, u8(0x9F))

	ds.pause_mask = 0x05
	ds.pause_delay = 3
	update_pause(ds)
	testing.expect_value(t, ds.pause_mask, u8(0x05))
	testing.expect_value(t, ds.pause_delay, u8(2))

	for side in 0 ..< 4 {
		ds.ids[side][0] = 'm'
		ds.side_end[side] = 0
	}
	ds.pause_mask = 0x8F
	ds.pause_delay = 9
	update_pause(ds)
	testing.expect_value(t, ds.pause_mask, u8(0x8F))
	testing.expect_value(t, ds.pause_delay, u8(9))

	ds.side_end[1] = 1
	update_pause(ds)
	testing.expect_value(t, ds.pause_mask, u8(0x8D))
	testing.expect_value(t, ds.side_end[1], u8(1))

	ds.side_end[1] = 0
	ds.ids[2][0] = 'x'
	ds.pause_mask = 0xFF
	update_pause(ds)
	testing.expect_value(t, ds.pause_mask, u8(0xFB))
	testing.expect_value(t, ds.ids[2][0], u8('x'))

	for side in 0 ..< 4 {
		ds.side_end[side] = 1
	}
	ds.pause_mask = 0x8F
	update_pause(ds)
	testing.expect_value(t, ds.pause_mask, u8(0))

	ds.pause_mask = 0x80
	for side in 0 ..< 4 {
		ds.side_end[side] = 0
		ds.ids[side][0] = 'm'
	}
	update_pause(ds)
	testing.expect_value(t, ds.pause_mask, u8(0))
}

@(test)
test_drain_key_ring :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)
	ds.clock_enable = 1
	ds.key_read = 0x00E5
	ds.key_write = 0x00E9
	ds.key_ring[0] = 0x41
	ds.key_ring[1] = 0x42
	ds.key_ring[2] = 0x43
	ds.key_ring[3] = 0x44
	for &b in ds.key_packet {
		b = 0xFF
	}
	drain_key_ring(ds)
	testing.expect_value(t, ds.key_packet[0], u8(0x41))
	testing.expect_value(t, ds.key_packet[1], u8(0x42))
	testing.expect_value(t, ds.key_packet[2], u8(0x43))
	testing.expect_value(t, ds.key_packet[3], u8(0x44))
	testing.expect_value(t, ds.key_read, u16(0x00E9))
	testing.expect_value(t, ds.key_write, u16(0x00E9))

	ds.key_packet = {0xFF, 0xFF, 0xFF, 0xFF}
	drain_key_ring(ds)
	testing.expect_value(t, ds.key_packet[0], u8(0))
	testing.expect_value(t, ds.key_packet[1], u8(0))
	testing.expect_value(t, ds.key_packet[2], u8(0))
	testing.expect_value(t, ds.key_packet[3], u8(0))
	testing.expect_value(t, ds.key_read, u16(0x00E9))

	ds.clock_enable = 0
	drain_key_ring(ds)
	testing.expect_value(t, ds.key_packet[0], u8(0x86))
	testing.expect_value(t, ds.key_packet[3], u8(0x86))

	ds.clock_enable = 1
	ds.key_read = 0x00E5
	ds.key_write = 0x00E7
	ds.key_ring[0] = 0x11
	ds.key_ring[1] = 0x22
	drain_key_ring(ds)
	testing.expect_value(t, ds.key_packet[0], u8(0x11))
	testing.expect_value(t, ds.key_packet[1], u8(0x22))
	testing.expect_value(t, ds.key_packet[2], u8(0))
	testing.expect_value(t, ds.key_packet[3], u8(0))
	testing.expect_value(t, ds.key_read, u16(0x00E7))

	// A zero key is consumed, and the bytes after it stay in the ring.
	ds.key_read = 0x00E5
	ds.key_write = 0x00E8
	ds.key_ring[0] = 0x41
	ds.key_ring[1] = 0
	ds.key_ring[2] = 0x42
	drain_key_ring(ds)
	testing.expect_value(t, ds.key_packet[0], u8(0x41))
	testing.expect_value(t, ds.key_packet[1], u8(0))
	testing.expect_value(t, ds.key_packet[2], u8(0))
	testing.expect_value(t, ds.key_packet[3], u8(0))
	testing.expect_value(t, ds.key_read, u16(0x00E7))
	testing.expect_value(t, ds.key_ring[2], u8(0x42))

	ds.clock_enable = 0
	ds.key_read = 0x00E5
	ds.key_write = 0x00E8
	drain_key_ring(ds)
	testing.expect_value(t, ds.key_packet[0], u8(0x41))
	testing.expect_value(t, ds.key_packet[1], u8(0x86))
	testing.expect_value(t, ds.key_packet[2], u8(0x86))
	testing.expect_value(t, ds.key_packet[3], u8(0x86))

	// The read pointer wraps from 00ED to 00E5.
	ds.clock_enable = 1
	ds.key_read = 0x00EC
	ds.key_write = 0x00E6
	ds.key_ring[7] = 0x11
	ds.key_ring[0] = 0x22
	drain_key_ring(ds)
	testing.expect_value(t, ds.key_packet[0], u8(0x11))
	testing.expect_value(t, ds.key_packet[1], u8(0x22))
	testing.expect_value(t, ds.key_packet[2], u8(0))
	testing.expect_value(t, ds.key_packet[3], u8(0))
	testing.expect_value(t, ds.key_read, u16(0x00E6))
	testing.expect_value(t, ds.key_write, u16(0x00E6))

	ds.key_read = 0x00EA
	ds.key_write = 0x00E8
	ds.key_ring[5] = 1
	ds.key_ring[6] = 2
	ds.key_ring[7] = 3
	ds.key_ring[0] = 4
	ds.key_ring[1] = 5
	ds.key_ring[2] = 6
	drain_key_ring(ds)
	testing.expect_value(t, ds.key_packet[0], u8(1))
	testing.expect_value(t, ds.key_packet[1], u8(2))
	testing.expect_value(t, ds.key_packet[2], u8(3))
	testing.expect_value(t, ds.key_packet[3], u8(4))
	testing.expect_value(t, ds.key_read, u16(0x00E6))
	testing.expect_value(t, ds.key_write, u16(0x00E8))
	testing.expect_value(t, ds.key_ring[1], u8(5))
}

@(test)
test_step_position :: proc(t: ^testing.T) {
	x, y: u16
	step_position(&x, &y, 1, 0)
	testing.expect_value(t, x, u16(0))
	testing.expect_value(t, y, u16(5))

	x, y = 0, 0
	step_position(&x, &y, 1, 1)
	testing.expect_value(t, x, u16(2))
	testing.expect_value(t, y, u16(4))

	x, y = 0, 0
	step_position(&x, &y, 1, 2)
	testing.expect_value(t, x, u16(3))
	testing.expect_value(t, y, u16(3))

	x, y = 0, 0
	step_position(&x, &y, 1, 3)
	testing.expect_value(t, x, u16(4))
	testing.expect_value(t, y, u16(2))

	x, y = 0, 0
	step_position(&x, &y, 1, 4)
	testing.expect_value(t, x, u16(5))
	testing.expect_value(t, y, u16(0))

	x, y = 0, 0
	step_position(&x, &y, 1, 8)
	testing.expect_value(t, x, u16(0))
	testing.expect_value(t, y, u16(0x3FFB))

	x, y = 0, 0
	step_position(&x, &y, 1, 0x0C)
	testing.expect_value(t, x, u16(0x3FFB))
	testing.expect_value(t, y, u16(0))

	// Bit 4 is outside the quadrant field, so this matches heading 0.
	x, y = 0, 0
	step_position(&x, &y, 1, 0x10)
	testing.expect_value(t, x, u16(0))
	testing.expect_value(t, y, u16(5))

	// Heading 5 takes the second vector of speed 1 and rotates it once.
	x, y = 0, 0
	step_position(&x, &y, 1, 5)
	testing.expect_value(t, x, u16(4))
	testing.expect_value(t, y, u16(0x3FFE))

	x, y = 0, 0
	step_position(&x, &y, 1, 9)
	testing.expect_value(t, x, u16(0x3FFE))
	testing.expect_value(t, y, u16(0x3FFC))

	x, y = 0, 0
	step_position(&x, &y, 1, 0x0D)
	testing.expect_value(t, x, u16(0x3FFC))
	testing.expect_value(t, y, u16(2))

	x, y = 0, 0
	step_position(&x, &y, 1, 0xF5)
	testing.expect_value(t, x, u16(4))
	testing.expect_value(t, y, u16(0x3FFE))

	x, y = 0, 0
	step_position(&x, &y, 2, 0)
	testing.expect_value(t, x, u16(0))
	testing.expect_value(t, y, u16(9))

	x, y = 0, 0
	step_position(&x, &y, 31, 0)
	testing.expect_value(t, x, u16(0))
	testing.expect_value(t, y, u16(0x8C))

	x, y = 0, 0
	step_position(&x, &y, 31, 1)
	testing.expect_value(t, x, u16(0x36))
	testing.expect_value(t, y, u16(0x82))

	x, y = 0, 0
	step_position(&x, &y, 31, 0x0C)
	testing.expect_value(t, x, u16(0x3F74))
	testing.expect_value(t, y, u16(0))

	x, y = 0x3FFE, 0x3FFC
	step_position(&x, &y, 1, 4)
	testing.expect_value(t, x, u16(3))
	testing.expect_value(t, y, u16(0x3FFC))

	x, y = 10, 2
	step_position(&x, &y, 1, 8)
	testing.expect_value(t, x, u16(10))
	testing.expect_value(t, y, u16(0x3FFD))

	// DEC of speed 0 indexes CS:4074, whose first word is bytes A2 C6.
	x, y = 0, 0
	step_position(&x, &y, 0, 0)
	testing.expect_value(t, x, u16(0xA2))
	testing.expect_value(t, y, u16(0xC6))

	ship: Ship_Record
	step_position(&ship.x, &ship.y, 1, 0)
	testing.expect_value(t, ship.x, u16(0))
	testing.expect_value(t, ship.y, u16(5))
	ship.shot_x = 100
	ship.shot_y = 100
	step_position(&ship.shot_x, &ship.shot_y, 1, 4)
	testing.expect_value(t, ship.shot_x, u16(105))
	testing.expect_value(t, ship.shot_y, u16(100))
	testing.expect_value(t, ship.x, u16(0))
	testing.expect_value(t, ship.y, u16(5))
}

@(test)
test_fill_mine_slot :: proc(t: ^testing.T) {
	slots: [20][8]u8
	ship: Ship_Record
	ship.x = 0x1234
	ship.y = 0xABCD
	ship.plane = 2
	ship.own_side = 1
	ship.team = 7
	ship.mines = 3
	fill_mine_slot(&slots, &ship)
	testing.expect_value(t, slots[0][0], u8(0xFA))
	testing.expect_value(t, slots[0][1], u8(0x34))
	testing.expect_value(t, slots[0][2], u8(0x12))
	testing.expect_value(t, slots[0][3], u8(0xCD))
	testing.expect_value(t, slots[0][4], u8(0xAB))
	testing.expect_value(t, slots[0][5], u8(2))
	testing.expect_value(t, slots[0][6], u8(1))
	testing.expect_value(t, slots[0][7], u8(7))
	testing.expect_value(t, ship.mines, u8(2))
	testing.expect_value(t, slots[1][0], u8(0))

	slots[0][0] = 1
	slots[1][1] = 0xEE
	fill_mine_slot(&slots, &ship)
	testing.expect_value(t, slots[0][0], u8(1))
	testing.expect_value(t, slots[0][1], u8(0x34))
	testing.expect_value(t, slots[1][0], u8(0xFA))
	testing.expect_value(t, slots[1][1], u8(0x34))
	testing.expect_value(t, ship.mines, u8(1))
	testing.expect_value(t, slots[2][0], u8(0))

	ship.mines = 0
	fill_mine_slot(&slots, &ship)
	testing.expect_value(t, ship.mines, u8(0xFF))
	testing.expect_value(t, slots[2][0], u8(0xFA))
	testing.expect_value(t, slots[2][6], u8(1))

	full: [20][8]u8
	for &slot in full {
		slot[0] = 1
		slot[7] = 0x5A
	}
	ship.mines = 4
	ship.x = 0x1111
	fill_mine_slot(&full, &ship)
	testing.expect_value(t, ship.mines, u8(4))
	testing.expect_value(t, ship.x, u16(0x1111))
	testing.expect_value(t, full[0][1], u8(0))
	testing.expect_value(t, full[19][0], u8(1))
	testing.expect_value(t, full[19][7], u8(0x5A))
}

@(test)
test_apply_energy_charge :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)
	ship: Ship_Record
	ship.flags = 0x90
	ship.energy = 1000
	ship.pending_charge = 100
	ds.frame_count = 0
	ds.ids[0][4] = 2
	apply_energy_charge(ds, &ship)
	testing.expect_value(t, ship.energy, u16(910))
	testing.expect_value(t, ship.pending_charge, u16(0))
	testing.expect_value(t, ship.flags, u8(0x90))

	ship.flags = 0x90
	ship.energy = 210
	ship.pending_charge = 10
	ds.frame_count = 1
	apply_energy_charge(ds, &ship)
	testing.expect_value(t, ship.energy, u16(200))
	testing.expect_value(t, ship.flags, u8(0x80))

	ship.flags = 0x90
	ship.energy = 211
	ship.pending_charge = 10
	apply_energy_charge(ds, &ship)
	testing.expect_value(t, ship.energy, u16(201))
	testing.expect_value(t, ship.flags, u8(0x90))

	ship.flags = 0x80
	ship.energy = 1000
	ship.pending_charge = 200
	ds.ids[0][4] = 3
	ds.frame_count = 1
	apply_energy_charge(ds, &ship)
	testing.expect_value(t, ship.energy, u16(900))

	ship.energy = 1000
	ship.pending_charge = 200
	ds.ids[0][4] = 2
	apply_energy_charge(ds, &ship)
	testing.expect_value(t, ship.energy, u16(800))

	ship.flags = 0x84
	ship.energy = 0x270F
	ship.pending_charge = 0x1000
	ds.ids[0][4] = 0
	apply_energy_charge(ds, &ship)
	testing.expect_value(t, ship.energy, u16(0x270F))
	testing.expect_value(t, ship.pending_charge, u16(0))
	testing.expect_value(t, ship.flags, u8(0x84))

	ship.flags = 0x84
	ship.energy = 0x2710
	ship.pending_charge = 0x1000
	apply_energy_charge(ds, &ship)
	testing.expect_value(t, ship.energy, u16(0x2710))
	testing.expect_value(t, ship.flags, u8(0x84))

	ship.flags = 0x40
	ship.energy = 20000
	ship.pending_charge = 0x8000
	apply_energy_charge(ds, &ship)
	testing.expect_value(t, ship.energy, u16(0x4620))
	testing.expect_value(t, ship.flags, u8(0x40))

	ship.flags = 0x80
	ship.energy = 0x88B8
	ship.pending_charge = 0
	ds.frame_count = 0x0100
	ds.ids[0][4] = 0
	apply_energy_charge(ds, &ship)
	testing.expect_value(t, ship.energy, u16(0x88C2))

	ship.energy = 0x88B9
	ship.pending_charge = 0
	apply_energy_charge(ds, &ship)
	testing.expect_value(t, ship.energy, u16(0x88B9))

	ship.flags = 0x90
	ship.energy = 5
	ship.pending_charge = 15
	ship.mines = 0
	ds.frame_count = 0
	apply_energy_charge(ds, &ship)
	testing.expect_value(t, ship.energy, u16(5))
	testing.expect_value(t, ship.flags, u8(8))
	testing.expect_value(t, ship.pending_charge, u16(0))

	ship.flags = 0xB1
	ship.energy = 100
	ship.pending_charge = 0xC34F
	ship.mines = 0
	ship.x = 0x1234
	ship.y = 0x00AB
	ship.plane = 3
	ship.own_side = 2
	ship.team = 9
	ds.frame_count = 1
	ds.current_side = 5
	ds.ids[1][4] = 0
	ds.mines[1][0][0] = 1
	ds.mines[1][0][1] = 0x11
	apply_energy_charge(ds, &ship)
	testing.expect_value(t, ship.energy, u16(100))
	testing.expect_value(t, ship.flags, u8(8))
	testing.expect_value(t, ship.mines, u8(0))
	testing.expect_value(t, ds.mines[1][0][0], u8(1))
	testing.expect_value(t, ds.mines[1][0][1], u8(0x11))
	testing.expect_value(t, ds.mines[0][1][0], u8(0))

	ship.flags = 0xB1
	ship.energy = 100
	ship.pending_charge = 0xC350
	ship.mines = 2
	ds.current_side = 5
	apply_energy_charge(ds, &ship)
	testing.expect_value(t, ship.flags, u8(12))
	testing.expect_value(t, ship.mines, u8(0))
	testing.expect_value(t, ship.energy, u16(100))
	testing.expect_value(t, ship.pending_charge, u16(0))
	testing.expect_value(t, ds.mines[1][1][0], u8(0xFA))
	testing.expect_value(t, ds.mines[1][1][1], u8(0x34))
	testing.expect_value(t, ds.mines[1][1][2], u8(0x12))
	testing.expect_value(t, ds.mines[1][1][3], u8(0xAB))
	testing.expect_value(t, ds.mines[1][1][5], u8(3))
	testing.expect_value(t, ds.mines[1][1][6], u8(2))
	testing.expect_value(t, ds.mines[1][1][7], u8(9))
	testing.expect_value(t, ds.mines[1][2][0], u8(0xFA))
	testing.expect_value(t, ds.mines[1][3][0], u8(0))
	testing.expect_value(t, ds.ids[1][4], u8(0))
}

@(test)
test_move_ships_and_shots :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)

	ds.extra_records[0].flags = 0x80
	ds.extra_records[0].impulse = 1
	move_ships_and_shots(ds)
	testing.expect_value(t, ds.extra_records[0].x, u16(0))
	testing.expect_value(t, ds.extra_records[0].y, u16(5))

	ds.extra_records[1].flags = 0
	ds.extra_records[1].impulse = 1
	ds.extra_records[1].x = 50
	ds.extra_records[1].y = 50
	ds.extra_records[1].shot = 0x0A
	ds.extra_records[1].shot_heading = 0x0100
	move_ships_and_shots(ds)
	testing.expect_value(t, ds.extra_records[1].x, u16(50))
	testing.expect_value(t, ds.extra_records[1].y, u16(50))
	testing.expect_value(t, ds.extra_records[1].shot_y, u16(5))
	testing.expect_value(t, ds.extra_records[1].shot, u8(9))
	testing.expect_value(t, ds.extra_records[0].y, u16(10))

	ds.extra_records[2].flags = 0x80
	ds.extra_records[2].impulse = 0x0B
	ds.extra_records[2].warp = 5
	ds.extra_records[2].energy = 0x07D0
	move_ships_and_shots(ds)
	testing.expect_value(t, ds.extra_records[2].y, u16(0x5A))
	testing.expect_value(t, ds.extra_records[2].warp, u8(4))
	testing.expect_value(t, ds.extra_records[2].pending_charge, u16(0x64))
	testing.expect_value(t, ds.extra_records[2].damage, u8(0))

	ds.extra_records[3].flags = 0x80
	ds.extra_records[3].impulse = 0x0B
	ds.extra_records[3].warp = 5
	ds.extra_records[3].energy = 0x07CF
	move_ships_and_shots(ds)
	testing.expect_value(t, ds.extra_records[3].y, u16(0x32))
	testing.expect_value(t, ds.extra_records[3].warp, u8(5))
	testing.expect_value(t, ds.extra_records[3].pending_charge, u16(0))

	ds.extra_records[4].flags = 0x80
	ds.extra_records[4].impulse = 0x0B
	ds.extra_records[4].warp = 0
	ds.extra_records[4].energy = 0x2000
	move_ships_and_shots(ds)
	testing.expect_value(t, ds.extra_records[4].y, u16(0x32))
	testing.expect_value(t, ds.extra_records[4].warp, u8(0))

	ds.extra_records[5].flags = 0x80
	ds.extra_records[5].heading = 0x10
	ds.extra_records[5].x = 1
	ds.extra_records[5].y = 1
	move_ships_and_shots(ds)
	testing.expect_value(t, ds.extra_records[5].x, u16(1))
	testing.expect_value(t, ds.extra_records[5].y, u16(1))

	ds.extra_records[6].flags = 0x80
	ds.extra_records[6].impulse = 1
	ds.extra_records[6].heading = 0x14
	ds.extra_records[6].x = 0x3FFE
	move_ships_and_shots(ds)
	testing.expect_value(t, ds.extra_records[6].x, u16(3))
	testing.expect_value(t, ds.extra_records[6].y, u16(0))

	ds.extra_records[7].flags = 0x80
	ds.extra_records[7].impulse = 0x0F
	ds.extra_records[7].warp = 1
	ds.extra_records[7].energy = 3000
	move_ships_and_shots(ds)
	testing.expect_value(t, ds.extra_records[7].y, u16(0x6C))
	testing.expect_value(t, ds.extra_records[7].warp, u8(0))
	testing.expect_value(t, ds.extra_records[7].pending_charge, u16(0x64))

	ship := &ds.ships[1][2]
	ship.flags = 0x80
	ship.shot = 2
	ship.shot_heading = 0xFF00
	move_ships_and_shots(ds)
	testing.expect_value(t, ship.shot_heading, u16(0x0800))
	testing.expect_value(t, ship.shot_y, u16(0x24))
	testing.expect_value(t, ship.shot, u8(1))
	testing.expect_value(t, ship.x, u16(0))
	testing.expect_value(t, ship.y, u16(0))

	phaser := &ds.ships[0][0]
	phaser.shot = 0x81
	phaser.shot_heading = 0x0100
	phaser.shot_x = 10
	move_ships_and_shots(ds)
	testing.expect_value(t, phaser.shot_x, u16(10))
	testing.expect_value(t, phaser.shot_y, u16(5))
	testing.expect_value(t, phaser.shot, u8(0))

	aft := &ds.ships[0][1]
	aft.shot = 0xC1
	aft.shot_heading = 0
	move_ships_and_shots(ds)
	testing.expect_value(t, aft.shot, u8(0))
	testing.expect_value(t, aft.shot_x, u16(0))
	testing.expect_value(t, aft.shot_y, u16(0))

	held := &ds.ships[0][2]
	held.shot = 5
	held.shot_heading = 0x0003
	move_ships_and_shots(ds)
	testing.expect_value(t, held.shot, u8(4))
	testing.expect_value(t, held.shot_heading, u16(0x0003))
	testing.expect_value(t, held.shot_x, u16(0))

	last := &ds.ships[3][3]
	last.flags = 0x80
	last.impulse = 1
	last.y = 7
	move_ships_and_shots(ds)
	testing.expect_value(t, last.y, u16(12))
	testing.expect_value(t, ds.ships[2][0].y, u16(0))
}

@(test)
test_update_side_ships :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)

	blank :: proc(ds: ^DS_Segment) {
		ds.ships = {}
		ds.bases = {}
		ds.debris = {}
		ds.side_end = {}
		ds.side_89d8 = {}
		ds.side_89dc = {}
		ds.side_score = {}
		ds.ids = {}
		ds.byte_a295 = 0
		ds.frame_count = 1
		ds.current_side = 0
		ds.mode_bits = 0
	}

	// One alive ship and three empty slots. The base has no ships left.
	blank(ds)
	alive := &ds.ships[0][0]
	alive.flags = 0x80
	alive.energy = 5000
	alive.formation = 7
	for index in 1 ..< 4 {
		ds.ships[0][index].formation = 9
		ds.ships[0][index].byte_34 = 4
		ds.ships[0][index].seek = 2
	}
	ds.bases[0][0x0A] = 0
	set_base_energy(&ds.bases[0], 1000)
	update_side_ships(ds, &ds.ships[0])
	testing.expect_value(t, ds.byte_a295, u8(1))
	testing.expect_value(t, ds.side_89dc[0], u8(1))
	testing.expect_value(t, ds.side_end[0], u8(0))
	testing.expect_value(t, alive.flags, u8(0x80))
	testing.expect_value(t, alive.energy, u16(5000))
	testing.expect_value(t, alive.formation, u16(7))
	testing.expect_value(t, ds.bases[0][0x0A], u8(0))
	testing.expect_value(t, base_energy(&ds.bases[0]), u16(1000))
	for index in 1 ..< 4 {
		testing.expect_value(t, ds.ships[0][index].flags, u8(0))
		testing.expect_value(t, ds.ships[0][index].formation, u16(0))
		testing.expect_value(t, ds.ships[0][index].byte_34, u8(0))
		testing.expect_value(t, ds.ships[0][index].seek, u8(0))
	}

	// Two ships spawn. The last two slots refuse once the stock is gone.
	blank(ds)
	ds.bases[0][0x0A] = 2
	set_base_energy(&ds.bases[0], 5000)
	ds.bases[0][6] = 0x14
	ds.ids[0][0] = 1
	ds.ids[0][4] = 0
	ds.ships[0][2].formation = 3
	ds.ships[0][3].formation = 3
	update_side_ships(ds, &ds.ships[0])
	testing.expect_value(t, ds.ships[0][0].flags, u8(0x80))
	testing.expect_value(t, ds.ships[0][0].heading, u8(0x00))
	testing.expect_value(t, ds.ships[0][0].energy, u16(0x03E8))
	testing.expect_value(t, ds.ships[0][0].impulse, u8(0x11))
	testing.expect_value(t, ds.ships[0][0].torpedoes, u8(0))
	testing.expect_value(t, ds.ships[0][1].flags, u8(0x80))
	testing.expect_value(t, ds.ships[0][1].heading, u8(0x44))
	testing.expect_value(t, ds.ships[0][2].flags, u8(0))
	testing.expect_value(t, ds.ships[0][2].formation, u16(0))
	testing.expect_value(t, ds.ships[0][3].flags, u8(0))
	testing.expect_value(t, ds.ships[0][3].formation, u16(0))
	testing.expect_value(t, ds.bases[0][0x0A], u8(0))
	testing.expect_value(t, base_energy(&ds.bases[0]), u16(4800))
	testing.expect_value(t, ds.bases[0][6], u8(0x14))
	testing.expect_value(t, ds.ids[0][0], u8(1))
	testing.expect_value(t, ds.ids[0][4], u8(0))
	testing.expect_value(t, ds.byte_a295, u8(2))
	testing.expect_value(t, ds.side_89dc[0], u8(2))
	testing.expect_value(t, ds.side_end[0], u8(0))

	// Slot 2 is the one that spawns. Its heading is index times 68.
	blank(ds)
	ds.ships[0][0].flags = 0x80
	ds.ships[0][0].energy = 5000
	ds.ships[0][1].flags = 0x80
	ds.ships[0][1].energy = 5000
	ds.ships[0][3].formation = 8
	ds.bases[0][0x0A] = 1
	set_base_energy(&ds.bases[0], 1000)
	update_side_ships(ds, &ds.ships[0])
	testing.expect_value(t, ds.ships[0][0].flags, u8(0x80))
	testing.expect_value(t, ds.ships[0][0].energy, u16(5000))
	testing.expect_value(t, ds.ships[0][0].heading, u8(0))
	testing.expect_value(t, ds.ships[0][1].energy, u16(5000))
	testing.expect_value(t, ds.ships[0][2].flags, u8(0x80))
	testing.expect_value(t, ds.ships[0][2].heading, u8(0x88))
	testing.expect_value(t, ds.ships[0][2].energy, u16(0x03E8))
	testing.expect_value(t, ds.ships[0][3].flags, u8(0))
	testing.expect_value(t, ds.ships[0][3].formation, u16(0))
	testing.expect_value(t, ds.bases[0][0x0A], u8(0))
	testing.expect_value(t, base_energy(&ds.bases[0]), u16(900))
	testing.expect_value(t, ds.byte_a295, u8(3))
	testing.expect_value(t, ds.side_89dc[0], u8(3))
	testing.expect_value(t, ds.side_end[0], u8(0))

	// A flag of 1 reaches zero and copies the wreck. A flag of 5 counts down.
	blank(ds)
	ds.ships[0][0].flags = 1
	ds.ships[0][0].x = 0x1234
	ds.ships[0][0].y = 0x00AB
	ds.ships[0][0].plane = 4
	ds.ships[0][0].team = 6
	ds.ships[0][1].flags = 5
	ds.ships[0][2].flags = 3
	ds.ships[0][3].flags = 3
	ds.bases[0][0x0A] = 1
	set_base_energy(&ds.bases[0], 1000)
	update_side_ships(ds, &ds.ships[0])
	testing.expect_value(t, ds.ships[0][0].flags, u8(0))
	testing.expect_value(t, ds.ships[0][1].flags, u8(4))
	testing.expect_value(t, ds.ships[0][2].flags, u8(2))
	testing.expect_value(t, ds.ships[0][3].flags, u8(2))
	testing.expect_value(t, ds.debris[0][0], u8(0xC8))
	testing.expect_value(t, ds.debris[0][1], u8(0x34))
	testing.expect_value(t, ds.debris[0][2], u8(0x12))
	testing.expect_value(t, ds.debris[0][3], u8(0xAB))
	testing.expect_value(t, ds.debris[0][4], u8(0x00))
	testing.expect_value(t, ds.debris[0][5], u8(4))
	testing.expect_value(t, ds.debris[0][6], u8(6))
	testing.expect_value(t, ds.debris[1][0], u8(0))
	testing.expect_value(t, ds.bases[0][0x0A], u8(1))
	testing.expect_value(t, ds.byte_a295, u8(0))
	testing.expect_value(t, ds.side_89dc[0], u8(1))
	testing.expect_value(t, ds.side_end[0], u8(0))

	// Energy death stores flag 8, and this walk immediately decrements it to 7.
	blank(ds)
	ds.ships[0][0].flags = 0x80
	ds.ships[0][0].energy = 50
	ds.ships[0][0].pending_charge = 100
	ds.ships[0][1].flags = 2
	ds.ships[0][2].flags = 2
	ds.ships[0][3].flags = 2
	ds.bases[0][0x0A] = 1
	set_base_energy(&ds.bases[0], 1000)
	update_side_ships(ds, &ds.ships[0])
	testing.expect_value(t, ds.ships[0][0].flags, u8(7))
	testing.expect_value(t, ds.ships[0][0].energy, u16(50))
	testing.expect_value(t, ds.ships[0][0].pending_charge, u16(0))
	testing.expect_value(t, ds.ships[0][0].mines, u8(0))
	testing.expect_value(t, ds.debris[0][0], u8(0))
	testing.expect_value(t, ds.ships[0][1].flags, u8(1))
	testing.expect_value(t, ds.bases[0][0x0A], u8(1))
	testing.expect_value(t, ds.byte_a295, u8(0))
	testing.expect_value(t, ds.side_89dc[0], u8(1))
	testing.expect_value(t, ds.side_end[0], u8(0))

	// A charge of at least 0xC350 stores flag 12, then this walk decrements it to 11.
	blank(ds)
	ds.ships[0][0].flags = 0x80
	ds.ships[0][0].energy = 50
	ds.ships[0][0].pending_charge = 0xC350
	ds.ships[0][1].flags = 2
	ds.ships[0][2].flags = 2
	ds.ships[0][3].flags = 2
	ds.bases[0][0x0A] = 1
	set_base_energy(&ds.bases[0], 1000)
	update_side_ships(ds, &ds.ships[0])
	testing.expect_value(t, ds.ships[0][0].flags, u8(11))
	testing.expect_value(t, ds.ships[0][0].energy, u16(50))
	testing.expect_value(t, ds.ships[0][0].pending_charge, u16(0))
	testing.expect_value(t, ds.debris[0][0], u8(0))
	testing.expect_value(t, ds.side_end[0], u8(0))
	testing.expect_value(t, ds.bases[0][0x0A], u8(1))

	// A side that is already out still updates ships, then returns. The empty slots spawn.
	blank(ds)
	ds.side_end[0] = 2
	ds.side_89dc[0] = 9
	ds.side_score[0] = 40
	ds.ids[0][5] = 6
	ds.ships[0][0].flags = 1
	ds.ships[0][0].x = 0x0007
	ds.ships[0][0].y = 0x0008
	ds.ships[0][0].plane = 1
	ds.ships[0][0].team = 2
	ds.bases[0][0x0A] = 3
	set_base_energy(&ds.bases[0], 2000)
	update_side_ships(ds, &ds.ships[0])
	testing.expect_value(t, ds.ships[0][0].flags, u8(0))
	testing.expect_value(t, ds.debris[0][0], u8(0xC8))
	testing.expect_value(t, ds.ships[0][1].flags, u8(0x80))
	testing.expect_value(t, ds.ships[0][1].heading, u8(0x44))
	testing.expect_value(t, ds.ships[0][2].heading, u8(0x88))
	testing.expect_value(t, ds.ships[0][3].heading, u8(0xCC))
	testing.expect_value(t, ds.byte_a295, u8(3))
	testing.expect_value(t, ds.side_end[0], u8(2))
	testing.expect_value(t, ds.side_89dc[0], u8(9))
	testing.expect_value(t, ds.side_score[0], u16(40))
	testing.expect_value(t, ds.ids[0][5], u8(6))
	testing.expect_value(t, ds.bases[0][0x0A], u8(0))
	testing.expect_value(t, base_energy(&ds.bases[0]), u16(1700))

	// side_89d8 of 1 stores end code 3. The ship survives the zeroed energy, then the wipe clears it.
	blank(ds)
	ds.frame_count = 0
	ds.side_89d8[0] = 1
	ds.side_89dc[0] = 9
	ds.ships[0][0].flags = 0x80
	ds.ships[0][0].energy = 5000
	ds.ships[0][1].flags = 2
	ds.ships[0][2].flags = 2
	ds.ships[0][3].flags = 2
	ds.bases[0][0x0A] = 4
	ds.bases[0][0x0D] = 4
	set_base_energy(&ds.bases[0], 1000)
	ds.ids[0][0] = 0x42
	ds.ids[0][4] = 2
	ds.ids[0][5] = 7
	ds.side_score[0] = 30
	ds.side_score[1] = 50
	update_side_ships(ds, &ds.ships[0])
	testing.expect_value(t, ds.ships[0][0].flags, u8(0))
	testing.expect_value(t, ds.ships[0][0].energy, u16(10))
	testing.expect_value(t, ds.ships[0][1].flags, u8(1))
	testing.expect_value(t, ds.ships[0][2].flags, u8(1))
	testing.expect_value(t, ds.ships[0][3].flags, u8(1))
	testing.expect_value(t, ds.side_end[0], u8(3))
	testing.expect_value(t, ds.side_89dc[0], u8(9))
	testing.expect_value(t, ds.bases[0][0x0A], u8(0))
	testing.expect_value(t, base_energy(&ds.bases[0]), u16(0))
	testing.expect_value(t, ds.bases[0][0x0D], u8(0))
	testing.expect_value(t, ds.ids[0][5], u8(0))
	testing.expect_value(t, ds.ids[0][4], u8(2))
	testing.expect_value(t, ds.ids[0][0], u8(0x42))
	testing.expect_value(t, ds.side_score[0], u16(0))
	testing.expect_value(t, ds.side_score[1], u16(50))

	// Base energy 0 clears the ship stock and decrements +0D. A living ship keeps the end code at 0.
	blank(ds)
	ds.ships[0][0].flags = 0x80
	ds.ships[0][0].energy = 5000
	ds.ships[0][1].flags = 2
	ds.ships[0][2].flags = 2
	ds.ships[0][3].flags = 2
	ds.bases[0][0x0A] = 5
	ds.bases[0][0x0D] = 4
	set_base_energy(&ds.bases[0], 0)
	update_side_ships(ds, &ds.ships[0])
	testing.expect_value(t, ds.ships[0][0].flags, u8(0x80))
	testing.expect_value(t, ds.ships[0][0].energy, u16(5000))
	testing.expect_value(t, ds.bases[0][0x0A], u8(0))
	testing.expect_value(t, ds.bases[0][0x0D], u8(3))
	testing.expect_value(t, base_energy(&ds.bases[0]), u16(0))
	testing.expect_value(t, ds.byte_a295, u8(1))
	testing.expect_value(t, ds.side_89dc[0], u8(1))
	testing.expect_value(t, ds.side_end[0], u8(0))

	// One living ship plus a remaining count of 0xFF wraps the sum and wipes the side.
	blank(ds)
	ds.ships[0][0].flags = 0x80
	ds.ships[0][0].energy = 5000
	ds.ships[0][1].flags = 2
	ds.ships[0][2].flags = 2
	ds.ships[0][3].flags = 2
	ds.bases[0][0x0A] = 0xFF
	ds.bases[0][0x0D] = 4
	set_base_energy(&ds.bases[0], 1000)
	ds.side_score[0] = 12
	ds.ids[0][5] = 3
	update_side_ships(ds, &ds.ships[0])
	testing.expect_value(t, ds.byte_a295, u8(1))
	testing.expect_value(t, ds.side_89dc[0], u8(0))
	testing.expect_value(t, ds.side_end[0], u8(1))
	testing.expect_value(t, ds.ships[0][0].flags, u8(0))
	testing.expect_value(t, ds.ships[0][0].energy, u16(5000))
	testing.expect_value(t, ds.ships[0][1].flags, u8(1))
	testing.expect_value(t, ds.ships[0][2].flags, u8(1))
	testing.expect_value(t, ds.ships[0][3].flags, u8(1))
	testing.expect_value(t, ds.bases[0][0x0A], u8(0))
	testing.expect_value(t, base_energy(&ds.bases[0]), u16(0))
	testing.expect_value(t, ds.bases[0][0x0D], u8(0))
	testing.expect_value(t, ds.side_score[0], u16(0))
	testing.expect_value(t, ds.ids[0][5], u8(0))

	// Side 1's walk leaves side 0 alone.
	blank(ds)
	ds.current_side = 1
	ds.ships[1][0].flags = 0x80
	ds.ships[1][0].energy = 5000
	ds.ships[1][1].formation = 9
	ds.bases[1][0x0A] = 0
	set_base_energy(&ds.bases[1], 1000)
	ds.bases[0][0x0A] = 9
	set_base_energy(&ds.bases[0], 0x1111)
	ds.side_89dc[0] = 8
	ds.side_score[0] = 77
	ds.ids[0][5] = 4
	ds.ids[0][4] = 1
	update_side_ships(ds, &ds.ships[1])
	testing.expect_value(t, ds.byte_a295, u8(1))
	testing.expect_value(t, ds.side_89dc[1], u8(1))
	testing.expect_value(t, ds.side_end[1], u8(0))
	testing.expect_value(t, ds.ships[1][0].flags, u8(0x80))
	testing.expect_value(t, ds.ships[1][0].energy, u16(5000))
	testing.expect_value(t, ds.ships[1][1].flags, u8(0))
	testing.expect_value(t, ds.ships[1][1].formation, u16(0))
	testing.expect_value(t, ds.bases[1][0x0A], u8(0))
	testing.expect_value(t, base_energy(&ds.bases[1]), u16(1000))
	testing.expect_value(t, ds.bases[0][0x0A], u8(9))
	testing.expect_value(t, base_energy(&ds.bases[0]), u16(0x1111))
	testing.expect_value(t, ds.side_89dc[0], u8(8))
	testing.expect_value(t, ds.side_end[0], u8(0))
	testing.expect_value(t, ds.side_score[0], u16(77))
	testing.expect_value(t, ds.ids[0][5], u8(4))
	testing.expect_value(t, ds.ids[0][4], u8(1))

	// The wipe clears the side's own records, including ones this call did not walk.
	blank(ds)
	local: [4]Ship_Record
	local[0].formation = 4
	ds.ships[0][0].flags = 0x80
	ds.ships[0][0].energy = 400
	ds.ships[0][1].flags = 2
	ds.ships[1][0].flags = 0x80
	ds.bases[0][0x0A] = 0
	ds.bases[0][0x0D] = 4
	set_base_energy(&ds.bases[0], 1000)
	ds.side_score[0] = 15
	ds.side_score[1] = 60
	ds.ids[0][0] = 0x41
	ds.ids[0][5] = 3
	ds.ids[1][5] = 8
	update_side_ships(ds, &local)
	testing.expect_value(t, local[0].flags, u8(0))
	testing.expect_value(t, local[0].formation, u16(0))
	testing.expect_value(t, ds.ships[0][0].flags, u8(0))
	testing.expect_value(t, ds.ships[0][0].energy, u16(400))
	testing.expect_value(t, ds.ships[0][1].flags, u8(2))
	testing.expect_value(t, ds.ships[1][0].flags, u8(0x80))
	testing.expect_value(t, ds.side_end[0], u8(1))
	testing.expect_value(t, ds.side_89dc[0], u8(0))
	testing.expect_value(t, ds.bases[0][0x0A], u8(0))
	testing.expect_value(t, base_energy(&ds.bases[0]), u16(0))
	testing.expect_value(t, ds.bases[0][0x0D], u8(0))
	testing.expect_value(t, ds.side_score[0], u16(0))
	testing.expect_value(t, ds.side_score[1], u16(60))
	testing.expect_value(t, ds.ids[0][0], u8(0x41))
	testing.expect_value(t, ds.ids[0][5], u8(0))
	testing.expect_value(t, ds.ids[1][5], u8(8))
}

@(test)
test_spawn_ship :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)
	ship: Ship_Record

	// No ships left. Carry, base untouched, only the three fields cleared.
	ship.flags = 0x80
	ship.x = 9
	ship.formation = 1
	ship.byte_34 = 2
	ship.seek = 3
	ship.damage = 4
	ds.current_side = 0
	ds.bases[0][0x0A] = 0
	set_base_energy(&ds.bases[0], 5000)
	ds.bases[0][6] = 0x14
	refused := spawn_ship(ds, &ship, 0)
	testing.expect(t, refused)
	testing.expect_value(t, ds.bases[0][0x0A], u8(0))
	testing.expect_value(t, base_energy(&ds.bases[0]), u16(5000))
	testing.expect_value(t, ds.bases[0][6], u8(0x14))
	testing.expect_value(t, ship.formation, u16(0))
	testing.expect_value(t, ship.byte_34, u8(0))
	testing.expect_value(t, ship.seek, u8(0))
	testing.expect_value(t, ship.flags, u8(0x80))
	testing.expect_value(t, ship.x, u16(9))
	testing.expect_value(t, ship.damage, u8(4))

	// Energy exactly 200 refuses and does not spend a ship.
	ship.formation = 5
	ship.byte_34 = 6
	ship.seek = 7
	ship.flags = 0x11
	ds.bases[0][0x0A] = 3
	set_base_energy(&ds.bases[0], 0xC8)
	refused = spawn_ship(ds, &ship, 1)
	testing.expect(t, refused)
	testing.expect_value(t, ds.bases[0][0x0A], u8(3))
	testing.expect_value(t, base_energy(&ds.bases[0]), u16(0xC8))
	testing.expect_value(t, ship.formation, u16(0))
	testing.expect_value(t, ship.byte_34, u8(0))
	testing.expect_value(t, ship.seek, u8(0))
	testing.expect_value(t, ship.flags, u8(0x11))

	// Energy 201 spends one ship and 100 energy, then fills the record.
	ship.flags = 0xFF
	ship.damage = 9
	ship.shot = 4
	ship.word_24 = 0xABCD
	ship.formation = 1
	ds.bases[0][0x0A] = 3
	set_base_energy(&ds.bases[0], 0xC9)
	ds.bases[0][1] = 0x34
	ds.bases[0][2] = 0x12
	ds.bases[0][3] = 0xCD
	ds.bases[0][4] = 0xAB
	ds.bases[0][5] = 2
	ds.bases[0][6] = 0x14
	ds.bases[0][7] = 0x7D
	ds.bases[0][0x0B] = 3
	ds.bases[0][0x0C] = 7
	ds.ids[0][0] = 0x41
	ds.ids[0][4] = 4
	ds.mode_bits = 0
	refused = spawn_ship(ds, &ship, 1)
	testing.expect(t, !refused)
	testing.expect_value(t, ds.bases[0][0x0A], u8(2))
	testing.expect_value(t, base_energy(&ds.bases[0]), u16(0x65))
	testing.expect_value(t, ds.bases[0][6], u8(0x14))
	testing.expect_value(t, ds.bases[0][7], u8(0x7D))
	testing.expect_value(t, ds.ids[0][4], u8(4))
	testing.expect_value(t, ds.ids[0][0], u8(0x41))
	testing.expect_value(t, ship.flags, u8(0x80))
	testing.expect_value(t, ship.x, u16(0x1234))
	testing.expect_value(t, ship.y, u16(0xABCD))
	testing.expect_value(t, ship.homing_x, u16(0x1234))
	testing.expect_value(t, ship.homing_y, u16(0xABCD))
	testing.expect_value(t, ship.plane, u8(2))
	testing.expect_value(t, ship.homing_level, u8(2))
	testing.expect_value(t, ship.own_side, u8(3))
	testing.expect_value(t, ship.fire_control, u8(3))
	testing.expect_value(t, ship.team, u8(7))
	testing.expect_value(t, ship.mines, u8(0))
	testing.expect_value(t, ship.byte_2a, u8(0))
	testing.expect_value(t, ship.pad_2c[0], u8(0))
	testing.expect_value(t, ship.damage, u8(0))
	testing.expect_value(t, ship.shot, u8(0))
	testing.expect_value(t, ship.word_24, u16(0))
	testing.expect_value(t, ship.formation, u16(0))
	testing.expect_value(t, ship.byte_34, u8(0))
	testing.expect_value(t, ship.seek, u8(0))
	testing.expect_value(t, ship.torpedoes, u8(5))
	testing.expect_value(t, ship.energy, u16(0x1D4C))
	testing.expect_value(t, ship.invisibility, u8(0x63))
	testing.expect_value(t, ship.heading, u8(0x44))
	testing.expect_value(t, ship.impulse, u8(0x11))
	testing.expect_value(t, ship.byte_29, u8(1))

	// current_side 5 uses bases[1] and ids[1]. bases[0] stays.
	ds.current_side = 5
	ds.bases[0][0x0A] = 9
	set_base_energy(&ds.bases[0], 0x1111)
	ds.bases[0][1] = 0x01
	ds.bases[0][2] = 0x00
	ds.bases[1][0x0A] = 3
	set_base_energy(&ds.bases[1], 0xC9)
	ds.bases[1][1] = 0x34
	ds.bases[1][2] = 0x12
	ds.bases[1][3] = 0xCD
	ds.bases[1][4] = 0xAB
	ds.bases[1][5] = 2
	ds.bases[1][6] = 0x14
	ds.bases[1][0x0B] = 3
	ds.bases[1][0x0C] = 7
	ds.ids[0][4] = 9
	ds.ids[1][4] = 4
	ds.mode_bits = 0
	refused = spawn_ship(ds, &ship, 0)
	testing.expect(t, !refused)
	testing.expect_value(t, ds.bases[0][0x0A], u8(9))
	testing.expect_value(t, base_energy(&ds.bases[0]), u16(0x1111))
	testing.expect_value(t, ds.bases[0][1], u8(0x01))
	testing.expect_value(t, ds.bases[1][0x0A], u8(2))
	testing.expect_value(t, base_energy(&ds.bases[1]), u16(0x65))
	testing.expect_value(t, ds.ids[0][4], u8(9))
	testing.expect_value(t, ds.ids[1][4], u8(4))
	testing.expect_value(t, ship.x, u16(0x1234))
	testing.expect_value(t, ship.own_side, u8(3))
	testing.expect_value(t, ship.team, u8(7))
	testing.expect_value(t, ship.fire_control, u8(3))
	testing.expect_value(t, ship.plane, u8(2))
	testing.expect_value(t, ship.homing_level, u8(2))
	testing.expect_value(t, ship.torpedoes, u8(5))
	testing.expect_value(t, ds.bases[1][6], u8(0x14))

	// Timed bit keeps the high loadout when the handicap is not 4.
	ds.current_side = 0
	ds.mode_bits = 1
	ds.ids[0][4] = 0
	ds.bases[0][0x0A] = 2
	set_base_energy(&ds.bases[0], 1000)
	refused = spawn_ship(ds, &ship, 0)
	testing.expect(t, !refused)
	testing.expect_value(t, ship.torpedoes, u8(5))
	testing.expect_value(t, ship.energy, u16(0x1D4C))
	testing.expect_value(t, ship.invisibility, u8(0x63))

	ds.mode_bits = 3
	ds.ids[0][4] = 2
	ds.bases[0][0x0A] = 2
	set_base_energy(&ds.bases[0], 1000)
	refused = spawn_ship(ds, &ship, 0)
	testing.expect(t, !refused)
	testing.expect_value(t, ship.torpedoes, u8(5))
	testing.expect_value(t, ship.energy, u16(0x1D4C))
	testing.expect_value(t, ship.invisibility, u8(0x63))

	// Handicap 3, timed bit clear.
	ds.mode_bits = 0
	ds.ids[0][4] = 3
	ds.bases[0][0x0A] = 2
	set_base_energy(&ds.bases[0], 1000)
	refused = spawn_ship(ds, &ship, 0)
	testing.expect(t, !refused)
	testing.expect_value(t, ship.torpedoes, u8(2))
	testing.expect_value(t, ship.energy, u16(0x0BB8))
	testing.expect_value(t, ship.invisibility, u8(0x32))

	// Handicap 2 and 5 both take the low loadout. 5 is not the beginner case.
	ds.ids[0][4] = 2
	ds.bases[0][0x0A] = 2
	set_base_energy(&ds.bases[0], 1000)
	refused = spawn_ship(ds, &ship, 0)
	testing.expect(t, !refused)
	testing.expect_value(t, ship.torpedoes, u8(0))
	testing.expect_value(t, ship.energy, u16(0x03E8))
	testing.expect_value(t, ship.invisibility, u8(0x14))

	ds.ids[0][4] = 5
	ds.bases[0][0x0A] = 2
	set_base_energy(&ds.bases[0], 1000)
	refused = spawn_ship(ds, &ship, 0)
	testing.expect(t, !refused)
	testing.expect_value(t, ship.torpedoes, u8(0))
	testing.expect_value(t, ship.energy, u16(0x03E8))
	testing.expect_value(t, ship.invisibility, u8(0x14))
	testing.expect_value(t, ds.ids[0][4], u8(5))

	// Headings for indexes 0..3, and the wrap at index 4.
	want := [5]u8{0x00, 0x44, 0x88, 0xCC, 0x10}
	ds.ids[0][4] = 4
	ds.mode_bits = 0
	ds.bases[0][0x0A] = 5
	set_base_energy(&ds.bases[0], 5000)
	for index in 0 ..< 5 {
		refused = spawn_ship(ds, &ship, u8(index))
		testing.expect(t, !refused)
		testing.expect_value(t, ship.heading, want[index])
	}
	testing.expect_value(t, ds.bases[0][0x0A], u8(0))
	testing.expect_value(t, base_energy(&ds.bases[0]), u16(4500))
}

@(test)
test_planet_array_for_level :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)

	ds.objects_per_level = 0x50
	ds.planets[0][0][0] = 0x07
	ds.planets[1][0][0] = 0x0E
	ds.planets[2][1][5] = 0x22
	ds.planets[3][0x4F][10] = 0xFF

	array, count := planet_array_for_level(ds, 0)
	testing.expect_value(t, count, u16(0x50))
	testing.expect_value(t, array[0][0], u8(0x07))
	array[0][1] = 0x11
	testing.expect_value(t, ds.planets[0][0][1], u8(0x11))
	testing.expect_value(t, ds.planets[1][0][1], u8(0))

	array, count = planet_array_for_level(ds, 1)
	testing.expect_value(t, count, u16(0x50))
	testing.expect_value(t, array[0][0], u8(0x0E))
	testing.expect_value(t, array[0][1], u8(0))

	array, _ = planet_array_for_level(ds, 2)
	testing.expect_value(t, array[1][5], u8(0x22))
	testing.expect_value(t, array[0][0], u8(0))

	array, _ = planet_array_for_level(ds, 3)
	testing.expect_value(t, array[0x4F][10], u8(0xFF))
	array, _ = planet_array_for_level(ds, 4)
	testing.expect_value(t, array[0x4F][10], u8(0xFF))
	array, _ = planet_array_for_level(ds, 0xFF)
	testing.expect_value(t, array[0x4F][10], u8(0xFF))
	testing.expect_value(t, ds.planets[2][0x4F][10], u8(0))

	ds.objects_per_level = 0
	_, count = planet_array_for_level(ds, 0)
	testing.expect_value(t, count, u16(0))

	ds.objects_per_level = 0xFF
	_, count = planet_array_for_level(ds, 2)
	testing.expect_value(t, count, u16(0xFF))
}

@(test)
test_short_delta :: proc(t: ^testing.T) {
	testing.expect_value(t, short_delta(0), u16(0))
	testing.expect_value(t, short_delta(0x1FFF), u16(0x1FFF))
	testing.expect_value(t, short_delta(0x2000), u16(0xE000))
	testing.expect_value(t, short_delta(0x3FFF), u16(0xFFFF))
	testing.expect_value(t, short_delta(0x4000), u16(0))
	testing.expect_value(t, short_delta(0x7FFF), u16(0x3FFF))
	testing.expect_value(t, short_delta(0x8000), u16(0xC000))
	testing.expect_value(t, short_delta(0x8001), u16(0xC001))
	testing.expect_value(t, short_delta(0xC000), u16(0))
	testing.expect_value(t, short_delta(0xD000), u16(0x1000))
	testing.expect_value(t, short_delta(0xE000), u16(0x2000))
	testing.expect_value(t, short_delta(0xF000), u16(0xF000))
	testing.expect_value(t, short_delta(0xFFFF), u16(0xFFFF))
}

@(test)
test_abs_word :: proc(t: ^testing.T) {
	testing.expect_value(t, abs_word(0), u16(0))
	testing.expect_value(t, abs_word(1), u16(1))
	testing.expect_value(t, abs_word(0x7FFF), u16(0x7FFF))
	testing.expect_value(t, abs_word(0x8000), u16(0x8000))
	testing.expect_value(t, abs_word(0x8001), u16(0x7FFF))
	testing.expect_value(t, abs_word(0xFFFF), u16(1))
}

@(test)
test_cycle_computer_count :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)
	ds.mode_bits = 0
	cycle_computer_count(ds)
	testing.expect_value(t, ds.mode_bits, u8(0x04))
	cycle_computer_count(ds)
	testing.expect_value(t, ds.mode_bits, u8(0x0C))
	cycle_computer_count(ds)
	testing.expect_value(t, ds.mode_bits, u8(0))

	ds.mode_bits = 0x08
	cycle_computer_count(ds)
	testing.expect_value(t, ds.mode_bits, u8(0))

	ds.mode_bits = 0xF1
	cycle_computer_count(ds)
	testing.expect_value(t, ds.mode_bits, u8(0xF5))
	cycle_computer_count(ds)
	testing.expect_value(t, ds.mode_bits, u8(0xFD))
	cycle_computer_count(ds)
	testing.expect_value(t, ds.mode_bits, u8(0xF1))
	ds.mode_bits = 0xF9
	cycle_computer_count(ds)
	testing.expect_value(t, ds.mode_bits, u8(0xF1))
}

@(test)
test_toggle_player_count :: proc(t: ^testing.T) {
	ds := new(DS_Segment)
	defer free(ds)
	ds.player_count = 1
	toggle_player_count(ds)
	testing.expect_value(t, ds.player_count, u8(2))
	toggle_player_count(ds)
	testing.expect_value(t, ds.player_count, u8(1))
	ds.player_count = 0
	toggle_player_count(ds)
	testing.expect_value(t, ds.player_count, u8(1))
	ds.player_count = 5
	toggle_player_count(ds)
	testing.expect_value(t, ds.player_count, u8(1))
}

@(test)
test_key_is_up :: proc(t: ^testing.T) {
	testing.expect_value(t, key_is_up('-'), true)
	testing.expect_value(t, key_is_up(0xC8), true)
	testing.expect_value(t, key_is_up('+'), false)
	testing.expect_value(t, key_is_up(0xD0), false)
	testing.expect_value(t, key_is_up(0), false)
	testing.expect_value(t, key_is_up('A'), false)
}

@(test)
test_key_is_down :: proc(t: ^testing.T) {
	testing.expect_value(t, key_is_down('+'), true)
	testing.expect_value(t, key_is_down(0xD0), true)
	testing.expect_value(t, key_is_down('-'), false)
	testing.expect_value(t, key_is_down(0xC8), false)
	testing.expect_value(t, key_is_down(0), false)
	testing.expect_value(t, key_is_down('A'), false)
}

@(test)
test_to_upper :: proc(t: ^testing.T) {
	testing.expect_value(t, to_upper('a'), u8('A'))
	testing.expect_value(t, to_upper('z'), u8('Z'))
	testing.expect_value(t, to_upper('m'), u8('M'))
	testing.expect_value(t, to_upper('A'), u8('A'))
	testing.expect_value(t, to_upper('`'), u8('`'))
	testing.expect_value(t, to_upper('{'), u8('{'))
	testing.expect_value(t, to_upper(0), u8(0))
	testing.expect_value(t, to_upper(0xFF), u8(0xFF))
}

clear_charge :: proc(ship: ^Ship_Record) {
	ship.pending_charge = 0
	ship.damage = 0
}
set_base_energy :: proc(base: ^[0x0E]u8, energy: u16) {
	base[8] = u8(energy)
	base[9] = u8(energy >> 8)
}

base_energy :: proc(base: ^[0x0E]u8) -> u16 {
	return u16(base[8]) | u16(base[9]) << 8
}
