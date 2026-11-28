package trek

import "core:fmt"
import "core:strings"
import "core:testing"

LISTING :: #load("../../disassembly/functions.txt")
DISTANCE_SRC :: #load("distance.odin")
SQRT_SRC :: #load("sqrt.odin")
SHIP_SRC :: #load("ship.odin")
PLANET_SRC :: #load("planet.odin")

// Named entries the listing gives, which functions.txt does not.
ORPHAN_PROCS :: [?]string{
	"1000:5eea",
	"1000:5fe3",
	"1000:6820",
	"1000:684b",
	"1000:6a0c",
}

@(test)
test_every_listing_proc_is_represented :: proc(t: ^testing.T) {
	want: map[string]struct{}
	defer delete(want)
	text := string(LISTING)
	for line in strings.split_lines_iterator(&text) {
		if len(line) < 9 || !strings.has_prefix(line, "1000:") do continue
		want[line[:9]] = {}
	}

	got: map[string]struct{}
	defer delete(got)
	orphans: map[string]struct{}
	defer delete(orphans)
	for p in listing_procs {
		p.body()
		if p.listing {
			got[p.addr] = {}
		} else {
			orphans[p.addr] = {}
		}
	}

	distance_src := string(DISTANCE_SRC)
	sqrt_src := string(SQRT_SRC)
	ship_src := string(SHIP_SRC)
	planet_src := string(PLANET_SRC)
	buf: [32]u8
	for addr in translated_procs {
		marker := fmt.bprintf(buf[:], "@proc %s", addr)
		found := strings.contains(distance_src, marker) || strings.contains(sqrt_src, marker) || strings.contains(ship_src, marker) || strings.contains(planet_src, marker)
		testing.expect(t, found)
		got[addr] = {}
	}

	testing.expect_value(t, len(got), len(want))
	for addr in want {
		testing.expect(t, addr in got)
	}
	for addr in got {
		testing.expect(t, addr in want)
	}

	testing.expect_value(t, len(orphans), len(ORPHAN_PROCS))
	for addr in ORPHAN_PROCS {
		testing.expect(t, addr in orphans)
	}
}
