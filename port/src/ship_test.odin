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

clear_charge :: proc(ship: ^Ship_Record) {
	ship.pending_charge = 0
	ship.damage = 0
}
