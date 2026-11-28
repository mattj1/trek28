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
| `1000:22a2` | `walk_planets` | tested. The name is inferred. Walks each level, including level 0 when `galaxy_levels` is 0. Levels from 3 share `planets[3]`. A zero nibble ages on frames whose low 7 bits are clear and scatters when the lifetime hits 0. Nibbles `1..0x0A` scatter while `byte_a280` is 1. Other records step their orbit when `(frame + CL) & 7` is 0 |
| `1000:226c` | `drain_invisibility` | tested. On an even frame, with no shot and flag bit `0x10` set, the invisibility byte counts down. A handicap of 4 or more skips the frames whose low two bits are clear. Zero clears bit `0x10` |
| `1000:2002` | `spawn_debris` | tested. The first debris slot with a zero lifetime receives `0xC8`, the ship's X and Y, its plane, and its team |
| `1000:1d64` | `fill_mine_slot` | tested. The name is inferred. The first empty mine slot receives lifetime `0xFA` and the ship's position, plane, side, and team, and the mine count decrements. A full side leaves the ship untouched |
| `1000:2310` | `relocate_planet` | tested. The name is inferred. Draws a planet coordinate pair until `reject_near_base` accepts it, stores type `0x0E` through `timed_type`, and clears the phase, the orbit kind, and the lifetime |
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
| `1000:425b` | `reject_near_planet` | tested. The name is inferred. Carry set when another occupied planet on this level is closer than `0x28A`. An X of 0 and the record itself are skipped. A zero `objects_per_level` walks nothing |
| `1000:428a` | `random_base_coord` | tested. The name is inferred. Keeps drawing until the low 14 bits of the seed are in `[0x5DC, 0x3A24]` |
| `1000:429b` | `random_planet_coord` | tested. The name is inferred. Same draw, accepted window `[0x1F4, 0x3E0C]` |
| `1000:42ac` | `random_planet_type` | tested. The name is inferred. The low 5 bits of the seed index the 32-byte table at `CS:42BD` |
| `1000:43b1` | `step_orbit` | tested. Kind 0 leaves the planet alone. Kind 1 steps through the 32-byte table at `CS:43F9`. Any other kind uses the 64-byte table at `CS:4419`. The phase byte wraps, and the sign-extended step is added to X and Y |
| `1000:1970` | `to_upper` | tested. `'a'..'z'` loses bit 5. Every other byte is unchanged |
| `1000:0b07` | `key_is_down` | tested. ZF is set for `'+'` and for `0xD0` |
| `1000:0b0e` | `key_is_up` | tested. ZF is set for `'-'` and for `0xC8` |
| `1000:0b15` | `toggle_player_count` | tested. A count of 1 becomes 2. Every other value becomes 1 |
| `1000:0b28` | `cycle_computer_count` | tested. Mode bits 2–3 cycle `00`, `04`, `0C`, then `00`. The other bits stay |
| `1000:2b36` | `short_delta` | tested. The name is inferred. A positive value at or above `0x2000` loses `0x4000` and stays negative. A negative value whose magnitude reaches `0x2000` comes back positive. `0x8000` returns `0xC000` |
| `1000:1cc3` | `set_invisible_bit` | tested. The name is inferred. An invisibility charge of at least 1 ORs flag bit `0x10`. A charge of 0 leaves the bit alone |
| `1000:31d1` | `decay_impulse` | tested. The name is inferred. The impulse byte decrements when seek's low 5 bits are 0, byte `0x16` has bit 2, byte `0x2A` is above 2, and the actual nibble is above 6 |
| `1000:37a1` | `cap_weapons_cooldown` | tested. The name is inferred. A cooldown above `0x0C` is stored as `0x0C` |
| `1000:2b52` | `abs_word` | tested. The name is inferred. Bit 15 selects `NEG`. `0x8000` stays `0x8000` |
| `1000:1a97` | `store_if_local_ship` | tested. AX is stored at DS:BX when `(current_side XOR local_side) & 3` is 0. A word at `FFFF` wraps onto `0000` |
| `1000:1ec1` | `ship_flag_ptr` | tested. Returns `side_flags` indexed by `current_side & 3` |
| `1000:2a0c` | `ship_ptr_from_al` | tested. AL keeps its low 2 bits. `current_side` is shifted left twice as a byte and ORed in. The record is `0x8C64` plus that index times `0x3B`. Bit 7 is the alive flag. An index of 16 or more is past the 16 ships |
| `1000:2ed4` | `add_score_div100` | tested. BL below 4 adds round(AX / 100) into that side's score. A remainder of `0x32` or more rounds up. The word add wraps |
| `1000:1cdb` | `apply_warp` | tested. The name is inferred. Seek bit 7 is cleared. Flag bits `0x44` force the actual impulse nibble to 11, then the byte is stored with desired nibble 11. Warp above `0x5A` becomes `0x64`. Otherwise it gains 10 |
| `1000:1d0f` | `emergency_stop` | tested. The name is inferred. The actual impulse nibble, or `0x14` when that nibble is above 10, is shifted left 5 and charged. Warp and the impulse byte are cleared |
| `1000:1696` | `add_energy_score` | tested. The name is inferred. Each side adds round(energy / 100) for its four living ships and round(base energy / 10). A dead ship adds nothing. The total is added to that side's score and wraps |
| `1000:16e9` | `end_two_player_sides` | tested. The name is inferred. When two players are in and the word at `side_end[0]` is nonzero, `side_end[2]` and `side_end[3]` become 3 |
| `1000:1a4d` | `scroll_message_queue` | tested. The name is inferred. The last three message lines move up, and the last line is cleared |
| `1000:2b74` | `clear_frame_scratch` | tested. The name is inferred. The 16 ships lose bytes `0x16`, `0x28`, and `0x34`, and the formation word. An alive ship also loses flag bits 0 and 1. Each base byte 0 loses its low 3 bits |
| `1000:2f24` | `cancel_close_shots` | tested. The name is inferred. Both shot bytes must be in 3..`0x7F`. A same-plane distance of `0x5A` or less stores 3 into a shot that is at least 4 |
| `1000:3f57` | `planet_team_flag` | tested. The name is inferred. Returns ZF. A nonzero planet lifetime clears it. An owner of `0xFF` sets it. Otherwise it is set when the ship team matches the owner |
| `1000:3fc1` | `store_desired_heading` | tested. The name is inferred. CH is shifted left 4 as a byte and stored in the desired heading nibble. The actual nibble stays |
| `1000:42dd` | `satellite_level` | tested. The name is inferred. CX in 3..8 indexes the 12-byte table at `CS:4306`. A table byte below `galaxy_levels` gains 10 and sets carry. Any other CX returns 0 with carry clear. The 8086 left AL unchanged on that path |
| `1000:1a68` | `beep` | tested. The name is inferred. Stores 1 in `sound_beep` when the side is local, through `store_if_local_ship`. The bytes from `1a71` stay unread |
| `1000:1b78` | `set_base_view` | tested. The name is inferred. ORs bit `0x10` into `side_flags[current_side & 3]`. The bytes from `1b7f` stay unread |
| `1000:197b` | `tick_message_countdown` | tested. The name is inferred. A zero countdown returns. At zero after the decrement it scrolls the queue, and a nonempty first line stores `0x14` |
| `1000:427d` | `place_base_coords` | tested. The name is inferred. Two draws from `random_base_coord` are stored at `SI+1` and `SI+3`. A word at `FFFF` wraps onto `0000` |
| `1000:41fa` | `place_planet_coords` | tested. The name is inferred. A planet pair is kept when `reject_near_planet` and `reject_near_base` (`BP` `0x3E8`, `DX` `0x1770`) both accept it. Either rejection draws a new pair |
| `1000:3e2a` | `discount_seek_distance` | tested. The name is inferred. Each energy threshold the ship fails to clear, from `0x61A8` down to `0x0FA0`, subtracts `0x12C` from AX while AX is at least `0x12C` |
| `1000:2be8` | `hit_base` | tested. The name is inferred. AX above `0xA0` returns. Bit 7 of the base flag is set. A shot below 4 returns. Otherwise the ship's side scores `0x1388`, the shot becomes 3, and base energy loses `0x1F4`. A negative result is stored as 0. `0x8000 - 0x1F4` stays `0x7E0C`. The local base points `sound_list` at `0x00EE` |
| `1000:2ef3` | `cancel_shots_between_sides` | tested. The name is inferred. Each side's four ships are compared with every ship of a later side, through `cancel_close_shots`. Extra records are not included |

`Ship_Record` in `src/ds.odin` is one ship. `DS_Segment.ships` is `[4][4]Ship_Record` and `extra_records` is `[8]Ship_Record`. `Machine.ds` stays a raw segment for the image copy and for an offset that is only known at runtime.

Word arithmetic wraps through `intrinsics.overflow_add` and `overflow_sub` in `src/cpu.odin`. A shift of 16 or more yields 0.

## Next

`1000:1ee6` updates every side. It calls `walk_planets` and `1000:202f` before `update_side_ships`. `1000:202f` ages debris and, at expiry, calls `1000:ac37`. Those stay unported until `ac37` is an explicit decision: check the embedded COM, or a stub that returns.

How to resume on another machine is in `RESUME.md`.
