# Trek 2.8 port

Odin port of TREK28.COM. The disassembly stays in `../disassembly`. This directory is the program.

Every procedure in the Ghidra function list has an Odin procedure. The listing is in a comment above the body. An unread procedure is named `fun_` plus its address, and the body is empty. A `notes:` line is a name already recorded in the annotation notes. Translating a procedure means writing the body and moving its address from `listing_procs` to `translated_procs` in `src/proc_index.odin`.

Five named entries sit in the listing without a Ghidra function header: `serial_isr` (`1000:5eea`), `int01_trap` (`1000:5fe3`), `int1c_timer` (`1000:6820`), `int03_break` (`1000:684b`), and `int24_criterr` (`1000:6a0c`). Each one is its own procedure. A label inside a larger procedure stays in that procedure's comment. The bytes before `1000:0018` are the DOS entry stub.

`odin test src` checks that the procedure list matches `../disassembly/functions.txt`.

DOS and CGA sit behind `Host` in `src/host.odin`. The game will keep writing its offscreen frame. `host_blit` is the copy to the screen. Keys, the speaker, the score file, and quitting are the other seams. The timer will call into the game later. There is no interrupt vector table.

Drawing procedures are in `src/draw.odin`. Stores into CGA video memory (segment B800) and writes to port `0x3D9` stay empty stubs.

## Build

The compiler used here is the `dev-2026-11` binary in `/opt/odin-sdk`, on `PATH` as `odin`. Linking needs `clang`.

```
odin test src
odin run src
```

`src/machine.odin` embeds `../TREK28.COM` with `#load`. Rebuild after that file changes.

## Translated

| Address | Procedure | Status |
| --- | --- | --- |
| `1000:2470` | `isqrt_xlat` | tested |
| `1000:23cc` | `toroidal_distance` | tested |
| `1000:23c4`, `1000:241a` | `distance_if_same_plane` | tested. `241a` is a second copy of `23c4` |
| `1000:239b` | `add_pending_charge` | tested. `Ship_Record.pending_charge` saturates at `0xFFFF`. `damage` gains `AX >> 10` and the byte wraps |
| `1000:237b` | `add_scaled_charge` | tested. A nonzero `byte_34` shifts `AX` right twice. Flag bit `0x20` with shot bit 7 clear divides `AX` by 3. The result is added and returned |
| `1000:23b3` | `read_handicap` | tested. Returns `ids[current_side & 3][4]` |
| `1000:226c` | `drain_invisibility` | tested. On an even frame, with no shot and flag bit `0x10` set, the invisibility byte counts down. A handicap of 4 or more skips the frames whose low two bits are clear. Zero clears bit `0x10` |
| `1000:2002` | `spawn_debris` | tested. The first debris slot with a zero lifetime receives `0xC8`, the ship's X and Y, its plane, and its team |
| `1000:1d64` | `fill_mine_slot` | tested. The name is inferred. The first empty mine slot receives lifetime `0xFA` and the ship's position, plane, side, and team, and the mine count decrements. A full side leaves the ship untouched |
| `1000:2343` | `tick_mine_lifetimes` | tested. Lifetime 1 clears the mine and increments base stock, which wraps. Lifetime 2 decrements every call. A higher lifetime decrements when `frame_count & 7` is 0 |
| `1000:16fe` | `update_pause` | tested. A zero mask clears the delay. Bit 7 clear arms `0x8F` or counts the delay down. Bit 7 set drops a side bit when that side is out or its id does not start with `m`, and a zero low nibble clears the mask |
| `1000:1759` | `drain_key_ring` | tested. Copies up to four ring bytes into the packet. An empty ring or a zero key fills the rest with 0, or with `0x86` when the clock is stopped |
| `1000:382a` | `step_position` | tested. One step from the word table at `CS:387C`. Heading bits 2–3 rotate the vector, and both axes are masked with `0x3FFF` |
| `1000:37ac` | `move_ships_and_shots` | tested. Walks the 24 records at `8A8C`. An alive record steps on its actual impulse. Warp at impulse 11 or more charges `0x64` and adds 9 to the speed. A shot steps from `+1F`, then counts down and clears at `0x80` or `0xC0` |
| `1000:4459` | `spawn_ship` | tested. A base with no ships left, or energy at or below 200, returns carry and only clears formation, byte 34, and seek. Otherwise it spends one ship and 100 energy, zeroes the record, and fills side, team, plane, position, and a heading of index times 68 |
| `1000:1f1c` | `update_side_ships` | tested. Four records run the alive chain, a countdown, or a spawn. A side already out returns. End code 3, or a zero sum of living ships and ships remaining, wipes the base, the alive flags, id byte 5, and the score |
| `1000:221e` | `slew_heading` | tested. Actual heading steps toward desired by 1 or 2 around the 16-step circle. Seek distance `<= 0xFA` copies desired into actual |
| `1000:21af` | `step_impulse` | tested. Actual impulse steps by 1 when `impulse_wait` reaches 0, and charges `2 * gap`. A zero wait only arms the countdown |
| `1000:218b` | `slew_impulse` | tested. Slews heading, pulls a desired impulse of 11 down to 10 while warp is 0, then stores the nibble from `step_impulse` |
| `1000:20e3` | `apply_damage_thresholds` | tested. Damage from 8 clears flag bits 4 and 5. From `0x0C` it zeros seek. From `0x10` it stores weapons cooldown `0x18` on every call. From `0x14` it zeros `byte_2a` and `get_mine` |
| `1000:2055` | `charge_impulse_and_heal` | tested. A side byte of 1 zeros energy. Otherwise the weapons cooldown ticks, low energy clears warp, and every fourth frame charges the actual impulse and may heal one damage |
| `1000:210a` | `apply_energy_charge` | tested. A handicap of 3 or more halves the pending charge. Flag bits `0x44` floor energy at `0x2710`. Otherwise the charge is subtracted, a quiet frame may add 10 first, and a zero or a borrow dumps the mines and stores flag 8, or 12 when the charge was at least `0xC350`. The charge word is cleared on every path |
| `1000:3225` | `planet_array_for_record` | tested. The name is inferred. Loads the level at `SI+5`, wrapping a word at the top of the segment, and falls into `planet_array_for_level` |
| `1000:3228` | `planet_array_for_level` | tested. Levels 0, 1, and 2 select the arrays at `92CC`, `963C`, and `99AC`. Any other level byte selects `9D1C`. The count is `objects_per_level`, zero-extended |
| `1000:437a` | `mix_rng` | tested. The low byte of `frame_count` is mixed into `rng_seed`. Even parity leaves carry clear. Odd parity rotates in a set carry. The stored seed is the return value |
| `1000:41f0` | `timed_type` | tested. The name is inferred. Mode bit 0 ORs the type in AL with `0xF0` |
| `1000:4217` | `reject_near_base` | tested. The name is inferred. Carry set rejects the position. Mode bit 1 rejects when the shift-5 distance from `DS:0100` is at least DX. A base with energy rejects when the shift-4 distance is below BP. BP `0x157C` shrinks to `0x1F4` for that walk |
| `1000:428a` | `random_base_coord` | tested. The name is inferred. Keeps drawing until the low 14 bits of the seed are in `[0x5DC, 0x3A24]` |
| `1000:43b1` | `step_orbit` | tested. Kind 0 leaves the planet alone. Kind 1 steps through the 32-byte table at `CS:43F9`. Any other kind uses the 64-byte table at `CS:4419`. The phase byte wraps, and the sign-extended step is added to X and Y |

`Ship_Record` in `src/ds.odin` is one ship. `DS_Segment.ships` is `[4][4]Ship_Record` and `extra_records` is `[8]Ship_Record`. `Machine.ds` stays a raw segment for the image copy and for an offset that is only known at runtime.

Word arithmetic wraps through `intrinsics.overflow_add` and `overflow_sub` in `src/cpu.odin`. A shift of 16 or more yields 0.

## Next

`1000:1ee6` updates every side. It calls `1000:22a2` and `1000:202f` before `update_side_ships`. `1000:22a2` calls `planet_array_for_level`, `mix_rng`, `step_orbit`, and `1000:2310`. `2310` stays unread. `1000:41f0` (`timed_type`) ORs a type with `0xF0` when mode bit 0 is set. `1000:4217` (`reject_near_base`) rejects a position that is outside the multi-plane radius or too close to a live base. `1000:428a` (`random_base_coord`) draws a base coordinate. `1000:202f` ages debris and, at expiry, calls `1000:ac37`. Those stay unported. `1000:3225` (`planet_array_for_record`) loads a planet's level and falls into `3228`.

How to resume on another machine is in `RESUME.md`.
