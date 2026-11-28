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
| `1000:221e` | `slew_heading` | tested. Actual heading steps toward desired by 1 or 2 around the 16-step circle. Seek distance `<= 0xFA` copies desired into actual |
| `1000:21af` | `step_impulse` | tested. Actual impulse steps by 1 when `impulse_wait` reaches 0, and charges `2 * gap`. A zero wait only arms the countdown |
| `1000:218b` | `slew_impulse` | tested. Slews heading, pulls a desired impulse of 11 down to 10 while warp is 0, then stores the nibble from `step_impulse` |
| `1000:20e3` | `apply_damage_thresholds` | tested. Damage from 8 clears flag bits 4 and 5. From `0x0C` it zeros seek. From `0x10` it stores weapons cooldown `0x18` on every call. From `0x14` it zeros `byte_2a` and `get_mine` |

`Ship_Record` in `src/ds.odin` is one ship. `DS_Segment.ships` is `[4][4]Ship_Record` and `extra_records` is `[8]Ship_Record`. `Machine.ds` stays a raw segment for the image copy and for an offset that is only known at runtime.

Word arithmetic wraps through `intrinsics.overflow_add` and `overflow_sub` in `src/cpu.odin`. A shift of 16 or more yields 0.

## Next

`1000:2055` is the next procedure to translate. It is the charge-and-heal pass that runs just before `slew_impulse` on an alive ship. The assembly is in `src/proc_02.odin`.
