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

clear_charge :: proc(ship: ^Ship_Record) {
	ship.pending_charge = 0
	ship.damage = 0
}
