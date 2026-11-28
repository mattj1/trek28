# Resume

Handoff for the Trek 2.8 Odin port. The program is `port/`. The disassembly and the annotation notes stay in `../disassembly`. GitHub `master` is the copy to clone: `https://github.com/mattj1/trek28.git`.

HEAD before this note was `eabf915` (`Translate the side ship update at 1000:1f1c.`). The suite at that commit was 27 tests, exit 0, seed `38291647227036`.

## Machine

Odin is `dev-2026-11-nightly:9a69916` at `/opt/odin-sdk/odin`. This machine linked `/usr/local/bin/odin` to that binary. Linking needs `clang` (here, Debian clang 19.1.7).

```
cd port && odin test src -define:ODIN_TEST_THREADS=1
cd port && odin run src
```

`odin test src` from the repo root fails because `src` is under `port/`. `port/src/machine.odin` embeds `../../TREK28.COM` with `#load`. From `port/src` the disassembly list is `../../disassembly/functions.txt`.

`git add` from inside `port/` with a `port/...` path looks for `port/port` and fails. Add from the repo root: `git -C /path/to/trek28 add port/...`.

One translated procedure per commit. Do not amend. The message shape is `Translate the <role> at 1000:ADDR.` plus a short body. Push only when asked.

## Working agreement

Trust `disassembly/TREK28.asm` over `disassembly/decompiled.c`. Do not compile `decompiled.c`. Leave `TREK28.asm`, `decompiled.c`, `disassembly/ANNOTATIONS.md`, and the repo-root `README.md` unchanged unless asked. Names go in the port, and only when the notes or the operands already support them. `fill_mine_slot` is inferred; the comment says so. `byte_a295` stays that name. Mark a guessed name in the comment.

This is a game port. Translate a procedure only when the body is accounted for, and keep the listing as comments. An instruction emulator was not ruled out. It can check one procedure by running the bytes in `TREK28.COM` and comparing memory with the Odin result. It is not a reason to discard the port. DOS, CGA, and interrupts stay behind `Host` in `src/host.odin`. Stores into CGA segment `B800` and writes to port `0x3D9` stay empty. Writers of the offscreen frame at `DS:39C1` stay empty until that drawing is translated. Drawing procedures live in `src/draw.odin`.

`Machine.ds` stays a raw `[0x10000]u8`. Distance uses runtime offsets, and a word at `DS:FFFF` wraps onto `DS:0000`. Ship code uses `Ship_Record`. Distance still uses `read_*` and `write_*` on the raw segment.

Listing stubs are empty and take no arguments. Coverage calls them that way. Do not regenerate the stub generator. There is no `proc_05.odin`. `draw.odin` holds `1000:4530` through `1000:580c`, plus `1000:5815` and `1000:596c`.

## Translating a procedure

1. Move the listing into the implementation file. The comment keeps `// @proc 1000:XXXX`. Set `status: tested` only after the suite passes.
2. Delete the empty `fun_` procedure. Leave a one-line pointer where the stub was: `// 1000:XXXX name is in ship.odin.` Replace from the `@proc` header through the empty procedure, including the following newline. A header-only swap leaves the listing body behind.
3. Remove the `listing_procs` entry in `src/proc_index.odin` together with its newline. A deleted line that drops the newline leaves a blank array slot.
4. Insert the address into `translated_procs` in numeric order.
5. The coverage test `#load`s only `distance.odin`, `sqrt.odin`, and `ship.odin` (`src/proc_coverage_test.odin`). A new file of translated procedures has to be added there. `functions.txt` has 250 entries. Five listing entries have no Ghidra header and stay `listing=false`: `1000:5eea` `serial_isr`, `1000:5fe3` `int01_trap`, `1000:6820` `int1c_timer`, `1000:684b` `int03_break`, `1000:6a0c` `int24_criterr`.
6. Update the table and the Next paragraph in `port/README.md`.
7. Run the suite from `port/`. Commit that procedure alone.

## Compiler

This Odin traps on overflow and has no wrap operators. Use `intrinsics.overflow_add` and `intrinsics.overflow_sub`. Both return values are required. A procedure parameter cannot be assigned; copy it to a local. `u8` `+= 1` and `-= 1` trap on wrap, so guard a decrement that is known nonzero or use `overflow_*`. A shift count of 16 or more yields 0. `NEG` of `u16` `0x8000` stays `0x8000` through `overflow_sub(0, v)`.

`#load` returns `[]u8`. `string(#load(...))` converts it. String `+` is constant-only. `or_return` treats the last bool as success. Nested procedures are allowed. `for &slot in slots` works on a `^[20][8]u8` and on a `^[4]Ship_Record`. `free` is a builtin. `u8` can index arrays. `ship_test.odin` imports `core:testing` only and uses `testing.expect_value`. A lone `Ship_Record` can live on the stack. A `DS_Segment` test uses `new(DS_Segment)` and `defer free` (64K, zero-filled).

Word helpers are `add16`, `sub16`, `neg16`, `xchg_bytes`, `shr_word`, `shl_word`, `abs_diff`, and `torus_axis` in `src/cpu.odin`.

## Memory

Ghidra loads `TREK28.COM` at `1000:0000`. After startup, `DS = CS+0x0AC7`. The file offset of an initialized DS variable is `0xAC70 + DS_offset`. DS `0x0000`–`0x4BCF` are in the COM. Above that is BSS. `A4A0` and up are BSS.

`DAT_2000_XXXX` in the decompiler is `DS:(XXXX − 0x5390)`. A `CS:` or `ES:` operand is not a DS field. `ES=B800` is CGA. `1000:4459` `REP STOSB` writes `ES:DI` with `ES=DS`, so it zeroes the ship record in DS.

`DS_Segment` in `src/ds.odin` is `#packed`, little-endian, size `0x10000`, and every field offset is asserted. `Ship_Record` is packed and `0x3B` bytes. `extra_records` is `[8]Ship_Record` at `8A8C`. `ships` is `[4][4]Ship_Record` at `8C64`. Those 24 records are contiguous. Bases are `[4][0x0E]u8` at `9014`. Mines are `[4][20][8]u8` at `904C`, side stride `0xA0`. Debris is `[48][7]u8` at `A08C`. Ids are `[4][11]u8` at `A226`.

`current_side` is the byte at `A274`. Callers in the game store 0..3. `1000:1ece` (`pick_ptr`) pops the return address, masks the side with 3, and returns the pointer from the table that follows the call. Do not port that stack pop. Inline the table. Bases, ships, mines, and ids are masked with 3. `side_end`, `side_89d8`, `side_89dc`, and `side_score` are indexed by the raw byte.

`mode_bits` at `0012`: bit 0 timed game, bit 1 multi-plane, bits 2–3 computer count. `frame_count` at `89D2` is a word. Bit tests read the low byte. `byte_a295` at `A295` is the living-ship count inside `1000:1f1c`.

A base is 14 bytes. `+00` HUD flag, `+01` X word, `+03` Y word, `+05` plane, `+06` mine stock, `+07` torpedo stock, `+08` energy word, `+0A` ships remaining, `+0B` side copied to ship `+17` and `+2B`, `+0C` team, `+0D` a byte `1000:1f1c` decrements when base energy is 0. Spawn copies plane to the ship and to homing level.

A mine slot is 8 bytes: `+00` lifetime, `+01` X word, `+03` Y word, `+05` plane, `+06` owner side (ship `+17`), `+07` team (ship `+18`). Debris is 7 bytes: lifetime `0xC8`, X, Y, plane, team.

Id byte 4 is the handicap `read_handicap` returns. Id byte 5 is cleared when a side is wiped. Id bytes 0–2 are the letters. A leading 0 means the side is unused.

## Traps already paid for

`spawn_ship` clears formation, byte 34, and seek before either refuse check. A refused spawn leaves every other ship field and the base untouched. The `0x3B` zero runs only after both checks pass, and it wipes those three stores. Energy equal to 200 refuses. The heading byte is the index times 68, computed with 8-bit adds, so index 4 wraps to `0x10`. The game passes 0..3. Handicap 4, or mode bit 0, keeps torpedoes 5, energy `0x1D4C`, invisibility `0x63`. Handicap 3 steps to 2, `0x0BB8`, `0x32`. Any other handicap, including 5, stores 0, `0x03E8`, `0x14`. The handicap test is equality with 4.

`apply_energy_charge` on flag bits `0x44` floors energy and does not dump mines. A death test has to leave bits 2 and 6 clear. Death replaces the flag byte with 8, or with 12 when the original pending charge is at least `0xC350`, and does not store the energy. The charge word is cleared on every path. A full mine list does not decrement the ship's mine count, so the dump loop repeats forever. Do not test that case.

`update_side_ships` falls through when `apply_energy_charge` clears bit 7, so a death flag of 8 or 12 becomes 7 or 11 in the same call. The later wipe clears a flag byte only while bit 7 is still set. `side_89d8 == 1` makes `charge_impulse_and_heal` zero energy first. With frame low byte 0 and a zero charge, regen then leaves energy 10 and the wipe can clear the still-alive flag. With frame low byte 1 that ship dies and the flag ends at 7. The `+0D` decrement is visible only when the end code stays 0, because a wipe stores `+0D` as 0 afterwards. The sum of the alive count and ships remaining is a wrapping byte add. `1 + 0xFF` stores end code 1 and wipes. The other three records need a nonzero flag so spawn does not consume that `0xFF` stock.

A quiet alive ship for that walk is flags `0x80`, energy 5000, impulse 0, heading 0, pending charge 0, damage 0, frame low byte odd, `side_89d8` 0, handicap below 3. Matching impulse nibbles clear `impulse_wait`.

`step_position` reads speed as `AH` before the decrement. Speed 0 indexes the wrapped row at `CS:4074`. `fill_mine_slot` decrements the mine count with a wrapping subtract, so a count of 0 becomes `0xFF` when a slot is free.

## Where the frame is

`1000:1473` is the main loop, still unread. The per-frame body is at `1000:154d`. It drains the key ring (`1000:1759`), dispatches keys, and, while pause bit 7 is clear, calls `1000:1ee6`, `1000:37ac` (translated), `1000:178f`, `1000:2b74`, `1000:3974`, and combat `1000:2b5b`. It always draws the HUD (`1000:4530`), counts the message down, checks game over, updates pause (`1000:16fe`, translated), and sends the command packet. `1000:178f` is INT 16h. Leave it behind `Host`.

`1000:1ee6` is the next ship-update caller. In order it calls `1000:22a2`, `1000:202f`, `1000:2343` (translated), then `update_side_ships` four times. It sets `current_side` to 0..3 and DI to `8C64`, `8D50`, `8E3C`, `8F28`.

`1000:22a2` is the planet walk. It calls `1000:3228` (translated), `1000:43b1` (`step_orbit`, translated), `1000:437a` (`mix_rng`, translated), and `1000:2310`. `2310` is still a stub. `1000:3228` returns `planets[0]`, `[1]`, or `[2]` for levels 0, 1, and 2, and `planets[3]` for every other level byte. The count is `objects_per_level` with the high byte clear. It is not clamped to `0x50`. `1000:3225` is the fall-in that loads AL from `[SI+5]`. Leave it unread.

`1000:202f` ages debris when `(frame_count & 7) == 4`. A lifetime that hits zero calls `1000:ac37`. That procedure subtracts `0x233` words at `CS:A800` from AX. A zero result returns. A nonzero result clears interrupts and IRETs through a reset-style stack. It is an image checksum. Leave `1000:202f` unported until `1000:ac37` is an explicit decision: check the embedded COM, or a stub that returns.

`1000:1ece` stays a stack pop. Inline each call site.

Translated addresses, in numeric order, are the `translated_procs` array in `src/proc_index.odin`. The behavior table is in `port/README.md`.
