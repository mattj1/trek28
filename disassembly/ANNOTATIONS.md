# TREK28 annotation

Notes on `TREK28.asm` and `decompiled.c`. Those two files are the Ghidra export and are not edited. Confidence is marked where a name is inferred rather than proven.

Trek 2.8 (Carl McLawhorn, 1 Aug 1987) is a real-mode DOS COM. Ghidra loads it at `1000:0000`, which is the COM image at PSP:0100. About 9000 instructions, 250 functions. Video is CGA mode 4 (320x200, 4 colors), set with `INT 10h` AH=0 AL=4 at `1000:00a7`.

## How addresses line up

Startup (`1000:0018`) does this before any game logic:

- Saves the incoming PSP segment in `CS:[0x0004]` and clears `CS:[0x0002]`.
- Sets `DS = CS + 0x0AC7`. Under the Ghidra load that is `1AC7`. `CS:[0x0000]` holds that segment.
- Sets `SS = CS + 0x1532`, `SP = 0x0200`.
- Almost every later `[0xNNNN]` operand is a **DS offset**, not a `1000:` address and not a linear address.

File offset of an initialized DS variable: `0xAC70 + DS_offset`. The image ends at file `0xF840`, so DS offsets `0x0000`–`0x4BCF` are in the COM file and the rest is BSS cleared at startup.

Ghidra also invented a `2000:` overlay of the same RAM. `DAT_2000_XXXX` is `DS:(XXXX - 0x5390)`. Example: saved SP is asm `[0xa343]`, decompiler `DAT_2000_4fb3`, because `0x4FB3 + 0x5390 = 0xA343`. A raw `*(byte *)0xa274` in `decompiled.c` is the same kind of DS offset. `DAT_1000_YYYY` on initialized data is usually file offset `YYYY`, so its DS offset is `YYYY - 0xAC70`.

`CS:` overrides are real. The menu table, key tables, fonts, and the checksum all read through `CS`.

## Startup

`1000:0000` is a short jump that IRETs to `1000:0018` so CS becomes the load segment. `start` then:

1. `FUN_1000_0113` checks the environment. DOS version via `INT 21h` AH=30h must be at least 2.00, otherwise it prints `DS:0022` ("Requires DOS 2.0 or Higher.") and far-jumps `CS:[0x0002]` (a zeroed vector, so it dies). If `SS+0x32` is below the PSP top in BP, it prints `DS:0040` ("Not Enough Memory") the same way. `INT 11h` equipment: if the video bits are `0x30`, it clears bit 4 of BIOS `0040:0010` (forces a video mode the game can use).
2. Zeros memory from the end of the image up through the stack.
3. Saves the PIC mask (`IN AL,0x21`) at `[0xa200]` and the current SP at `[0xa343]`.
4. Hooks IVT entries, then `STI`:
   - `0000:0070` (INT 1Ch, timer user tick) → `1000:6820`
   - `0000:0004` (INT 1) → `1000:5fe3`
   - `0000:000C` (INT 3) → `1000:684b`
5. Sets CGA mode 4, applies the palette, checksums the image, seeds the RNG from `INT 1Ah`, finds a COM port, then spins about 2000 iterations (each calling the keyboard poll and bumping the seed) and enters the primary menu.

`[0xa5]` is the Esc longjmp target. The keyboard poll, on AL=`1Bh`, sets `[0xa272]=1` and jumps through `[0xa5]`. Menus store `0x0166` there so Esc redraws the primary menu. That same store is what clears the "required reading" gate.

### Integrity checksum — `1000:0c7c`

Sums words from `CS:0006` through `CS:AC64`. The sum must be 0. On failure it masks every IRQ, prints "Program Corrupted!!", waits on `[0xa255]`, and quits through `1000:0496`. The primary menu and the start of a game both call this. Quit restores the saved INT 1Ch vector, sets BIOS video mode 3, restores DS to the PSP, and far-jumps `CS:[0x0002]`.

## Saved settings (DS:0007, 20 bytes)

`1000:6c8c` ("save defaults") copies 20 bytes from `DS:0007` to `DS:A4AF` and writes them inside `TREK28.SCO`. `1000:6c9d` copies them back and leaves the menu cursor on "play". Bytes below `0007` are scratch, not part of this record. Defaults below are the bytes in the COM at file `0xAC70`.

| DS | default | name | values |
| --- | --- | --- | --- |
| 0007–0009 | `"   "` | player initials | three letters. A leading space means "not entered yet". Edited by `1000:04cd`. Printed by `1000:0562`. |
| 000A | 1 | player count | 1 = one player, 2 = two player (modem). Forced back to 1 if no COM port has a base address. Toggled by `1000:0b15`. |
| 000B | 0 | baud index | 0..7 into the table at `DS:00A9`: 110, 150, 300, 600, 1200, 2400, 4800, 9600. Each entry is 5 bytes, `FF`-terminated. Printed by `1000:0c6a`. |
| 000C | 0 | COM port index | 0..3 = COM1..COM4. `1000:0585` walks BIOS `0000:0400` and keeps the first nonzero UART base. |
| 000D | 0 | playing speed | 0 slow, 1 medium, 2 fast, 3 maximum. Names from `1000:07ef`. Frame delay loaded into `[0xa257]` is 9, 8, 7, 6 ticks. |
| 000E | 0 | link type | 0 acoustic coupler, nonzero smart modem. |
| 000F | 0 | computer speed | same 0..3 names as playing speed. One-player setup only. |
| 0010 | 4 | player handicap | 1 expert, 2 normal, 3 novice, 4 beginner (`1000:0882`). Enter cycles 4→3→2→1→4. |
| 0011 | 4 | computer handicap | same scale. |
| 0012 | 0 | mode bits | see below. |
| 0013 | 0 | computer bases | one-player. Stored 0..2, displayed as 1..3. |
| 0014 | 3 | speaker bits | ORed into port `0x61` bits 0–1 by the timer. 3 = sound on, 0 = off. Ctrl-S (`AL=0x13`) does `XOR [0x14], 3`. |
| 0015 | 0 | CGA palette | bit 0. Ctrl-P (`AL=0x10`) flips it and calls `INT 10h` AH=0Bh BH=1 (`1000:0baf`). |
| 0016 | `28CD` | font pointer | word. `CS:28CD` is the Trek font, `CS:311D` is the IBM font. Ctrl-F (`AL=0x06`) swaps them. Glyphs are 16 bytes (8×8). A character ≥ `0x90` aborts through `1000:0496`. |
| 0017–001A | 0 | rest of the 20-byte record | copied to the score file with the fields above. Not identified yet. |

`[0x0012]` bits:

- bit 0: 0 long game (clock counts up), 1 timed game (clock counts down).
- bit 1: 0 single-plane, 1 multi-plane.
- bits 0–1 cycle together in setup: long/single, timed/single, long/multi, timed/multi. Printed by `1000:0830`.
- bits 2–3: "number of computers" in the two-player menu (`1000:0b28`). `00` → 0, `04` → 1, `08`/`0C` → 2. Cycle is `00 → 04 → 0C → 00`.

`[0x0003]` is a "serial settings changed" flag. Set when baud or COM port changes. `1000:0d60` calls `1000:5dd6` while it is set, then clears it. `[0x00a7]` (word) is the UART I/O base copied from the BIOS COM table. The two-player menu prints it as hex (`1000:0c52` is a nibble-to-ASCII helper).

Other low DS bytes that are **not** settings. `1000:13a5` fills the first three at the start of a game, after the "AGAINST / COMPUTER" line. `AL` there is the player count and `AH` is the computer count:

- `[0x0000]` objects per galaxy level. Starts at `0x50` (80). Multi-plane subtracts `((players + computers) * 8) - 6`.
- `[0x0001]` how many extra `0x3B` records to build at `DS:8A8C`. Starts at 4. Multi-plane adds `players + computers`. The movement loop at `1000:37ac` always walks 24 records from `8A8C`, which is 8 extra slots plus the 16 ships. Single-plane leaves the upper extra slots empty.
- `[0x0002]` number of galaxy levels to fill. 1 in single-plane. Multi-plane uses `players + computers`.
- `[0x0005]` is still a word. The image has `0x0035`. `1000:58e9` / `1000:58f2` store `0x0050` or `0x0035`, and a couple of loops compare DI against it.

The same routine writes one computer id record per computer, starting at the id slot after the human players. Each record is 11 bytes: `'m'`, `'e'`, `'0'+n`, the byte at `[0x39c0]`, the handicap byte, then six zeros. One-player uses the computer handicap at `[0x0011]`; otherwise the handicap byte written here is 1.

## Menus

Highlight position for the current row is two words at `[0x0091]` and `[0x0093]`. The row table is **CS** `1000:03ca`, 8 entries of 6 bytes: column word, row word, handler word. `1000:0393` indexes it with `AL * 6` from `[0xa267]`. Setup uses the same table for the cursor only.

Primary menu (`1000:0166`), cursor `[0xa267]` wrapped to 0..7. `+` / Down moves down, `-` / Up moves up, Enter runs the handler. Until `[0xa272]` is 1, every handler other than `1000:0496` is forced to the instructions at `1000:6d60`. Esc is what sets `[0xa272]`.

| row | screen text | handler |
| --- | --- | --- |
| 0x1D | instructions | `1000:6d60` |
| 0x2F | display statistics | `1000:6bc5` |
| 0x41 | enter / change initials | `1000:04cd` |
| 0x53 | setup game | `1000:05c0` |
| 0x65 | enter terminal mode | `1000:0d70` |
| 0x77 | play game | `1000:0575` (requires initials, then `1000:0d60`, then `1000:1473`) |
| 0x89 | save defaults | `1000:03fa` → `1000:6c8c` |
| 0x9B | quit | `1000:0428` → `1000:0496` |

`+` and `-` here are not ASCII tests done in the menu. `1000:0b07` returns ZF if AL is `+` or scan-code `0x50|0x80` (Down). `1000:0b0e` does the same for `-` and Up (`0x48|0x80`).

Setup (`1000:05c0`, cursor `[0xa33e]`) has two layouts. One-player rows: player count, game mode, player handicap, computer handicap, computer speed, computer bases, playing speed. Two-player rows (`1000:08c8`): player count, game mode, player handicap, baud, COM port, acoustic/smart, number of computers, playing speed. Enter on row 0 always toggles player count and switches layout.

Keyboard poll `1000:0b45` (`INT 16h` AH=1, then AH=0):

- no key: AL=0, ZF set. Callers spin on that.
- Esc: set `[0xa272]=1`, clear `[0xa26c]`, jump `[0xa5]`.
- Ins (`AH=0x52`), Del (`AH=0x53`), or any key with AL=0: return `AH|0x80` so scan codes survive.
- Ctrl-S, Ctrl-P, Ctrl-F are eaten here (sound, palette, font) except Ctrl-F still returns AL=6 so the menu redraws.

## Score file

`DS:39A0` is the filename `TREK28.SCO`. `1000:6980` opens it (`INT 21h` AH=3Dh), creates it (`AH=3Ch`) if missing, and zeros a 512-byte buffer at `DS:A4AD`. `1000:6d27` writes those 512 bytes (`AH=40h`) and closes the handle in `[0xa4ab]`.

A displayed result (`1000:6cae`) is 10 bytes:

| offset | contents |
| --- | --- |
| 0..2 | player initials. 0 at byte 0 means an empty slot |
| 3..5 | opponent initials |
| 6 | word, player score (`1000:5415` prints a word) |
| 8 | word, opponent score |

The 20-byte settings block is stored at buffer offset 2 (`A4AF - A4AD`).

## Timer, clock, sound

INT 1Ch (`1000:6820`) switches to the game DS and calls, in order:

- `INT 3` → `1000:684b`, which decrements `[0xa255]` (word), `[0xa254]` (byte), and `[0xa257]` (word) if they are nonzero. The main loop and the menus wait on these. `[0xa257]` is the frame pacing counter.
- `INT 1` → `1000:5fe3`. If `[0xa209]` is nonzero it `CALL`s that word and then `IRET`. The word is a resume pointer for the two-player byte pump, not a single-step handler. `1000:5fa0` clears it when the player count is not 2, and otherwise points it into the pump.
- `1000:688e` sound.
- `1000:4649` (every tick; not mapped).
- `1000:6903` the one-second clock, if the game is running.
- `1000:686d` watches BIOS keyboard flag `0040:0017` bit 3 (Alt) and reloads `[0xa266]` to 12 when Alt is up. Alt-key repeat guard.

Clock (`[0xa203]` must be 1, and `[0xa26c]` bit 7 must be clear):

- `[0xa204]` counts 18 ticks, `[0xa205]` counts 5 of those. Every fifth second `[0xa204]` is stretched by one tick. 18.2 Hz × (18×5+1) ≈ 5.00 s, so the clock stays near wall time.
- Long game (bit 0 of `[0x0012]` clear): `[0xa206]` seconds, `[0xa207]` minutes, `[0xa208]` hours, counting up.
- Timed game: `[0xa207]` starts at `0x1E` (30 minutes) and `[0xa206]` counts down. Hitting zero clears `[0xa203]`. The key pump then fills the command slots with `0x86`.

Sound (`1000:688e`) writes the 8253 channel 2 (port `0x42`) and gates the speaker through port `0x61` using `[0x0014]`:

- `[0xa25a]` countdown, divisor `0x0300`
- `[0xa262]` pointer to a word list of divisors, terminated by `0xFFFF`
- `[0xa25c]` countdown, divisor `0x0600`
- `[0xa25e]` countdown, divisor `0x6000`

`1000:1a97` stores AX into BX only when the ship being processed is the local side. Callers pass `BX=0xa25a`, so a beep is a local-player effect.

## Frame loop — `1000:1473`

Plays one game.

1. Prints "SETTING UP UNIVERSE #", then a letter `A`–`Z` from `[0x89d0] mod 26` and the quotient (`1000:1449` prints that word). The seed is the clock tick captured at startup and stirred by the menu.
2. Calls `1000:3fd1` to build the universe. Waits until `[0xa255]` (loaded with `0xA2`) hits zero.
3. Calls `1000:5fa0`. One-player just clears `[0xa209]`. Two-player loads a 4-byte timing record from `DS:3976 + baud_index*4` and starts the modem pump (see Serial).
4. Reloads SP from `[0xa343]`, clears the 20-byte command area at `[0xa212]`, checksums the image again (`BX=0x0c7c`).
5. Starts the clock. Timed games get 30:00.
6. Frame loop, paced by `[0xa257]`:
   - `1000:1759` pulls up to 4 keys out of the ring buffer into `[0xa20d]`.
   - increments `[0x89d2]`, the frame counter. Later code tests bits 0, 1–2, 3, and bit 3 (`TEST ..., 1/3/7/8`) to run work every 2nd, 4th, or 8th frame.
   - `1000:1837` dispatches queued keys for ship slots 0..3.
   - if `[0xa26c]` bit 7 is clear: `1000:1ee6` (move all four ship groups), `1000:37ac`, `1000:178f`, `1000:2b74`, `1000:3974`, `1000:178f`, `1000:2b5b`.
   - always: `1000:178f`, `1000:4530` (draws the scanner; it prints "Short"/"Med"/"Long"/"Map" from `[0xa270]`), `1000:178f`, `1000:197b`, `1000:15d2`, `1000:16fe`, `1000:15b4`.

`1000:15b4` builds the outgoing command packet. One-player copies 4 bytes from `[0xa20d]` to `[0xa212]` and stores a 1. Two-player calls `1000:5d22` (serial). Then it jumps to `1000:6310`.

`1000:15d2` watches the four bytes at `[0x89e0]`. When the local side's byte is nonzero it treats the game as over: forces the scanner to medium, draws, waits, prints "HIT Esc TO CONTINUE", and jumps to the statistics screen `1000:6bc5`.

`[0xa26c]` is the pause mask. Bits 0–3 are one bit per ship slot (`1000:1aa7`, the Esc handler, toggles `1 << ship`). Bit 7 means the simulation and the clock are paused. `[0xa26d]` is the pause arming delay; `1000:16fe` counts it down and, at zero, sets bits 0–3 and bit 7 together (`OR 0x8F`). Clearing the low bits clears bit 7.

## Sides, ships, bases

`[0xa274]` is the side currently being updated, 0..3. `[0xa26f]` is the local player side, 0 or 1 (the modem handshake at `1000:59cd` / `1000:59dc` assigns it). Scanner changes, beeps, and a few HUD writes are ignored unless `(side XOR local) & 3 == 0`.

There are four sides. Each side has four ships. `1000:2a0c` does `SI = 8C64 + ((([0xa274] & 3) << 2) | (AL & 3)) * 0x3B` and leaves ZF set from bit 7 of that record (alive). Side `s`, ship `i` is `8C64 + s*0xEC + i*0x3B`. The HUD prints `Ship ` plus `(flag & 3) + 1`.

`1000:1ec1` returns `BX = 0x89D4 + (side & 3)`. Low 2 bits of that byte are the selected ship. F1–F4 (`1000:1ad9`) require the ship to be alive, then `AND` the flag with `0xE8` and `OR` in 0..3. Bit `0x10` is base view: F9 (`1000:1b78`) sets it, and the HUD and the command gate both test it. Universe build writes `(random & 3) | 0x50` into each of the four bytes, then zeros `[0x89d2]`.

`1000:1ece` (`pick_ptr`) pops the return address, reads `CS:[return + side*2]`, skips the 8-byte table, and returns that pointer in BX.

| table | stride | what it is |
| --- | --- | --- |
| `8C64, 8D50, 8E3C, 8F28` | `0xEC` | four ship records of `0x3B` bytes. `0xEC` is `4 * 0x3B` |
| `9014, 9022, 9030, 903E` | `0x0E` | the side's base, 14 bytes |
| `904C, 90EC, 918C, 922C` | `0xA0` | 20 mine slots of 8 bytes. `0xA0` is `20 * 8` |
| `A226, A231, A23C, A247` | `0x0B` | 11-byte id. Bytes 0–2 are the letters ("CBM", "me1" in the demo at `1000:6d99`). Byte 4 is the handicap `1000:23b3` returns. A leading 0 means the side is unused |

Also per side, not through `pick_ptr`:

- `DS:89EC + side*0x28` — 40-byte buffer. Empty vs nonempty selects which half of the key table is used (`1000:1884`). This is the message line. Tab (`1000:1a71`) flips bit 0 of the current ship.
- `DS:89D8 + side` — key `0x85` (`1000:1e7d`) ORs bit 0. If the byte equals 1, `1000:2055` zeros that ship's energy and returns.
- `DS:89DC + side` — printed as the `#` on the score line (`1000:4b63`).
- `DS:89E0 + side` — 0 while the side is still in. Nonzero selects the end text in `1000:4ac2`: low nibble 1 `NO SHIPS`, 2 `NO BASE`, 3 `SURRENDERED`, anything else `**** TIE ****`. The panel also prints `(OUT)` next to the id.
- `DS:89E4 + side*2` — score word, printed while `89E0` is 0. `1000:2ed4` adds `round(AX / 100)` (remainder ≥ 50 rounds up) when `BX < 4`. Wiping a side's ships stores 0 (`1000:1ffb`).
- `[0x89d2]` is the frame counter during play (bit tests gate per-frame work). During universe build it is a temporary count of bases placed, and build zeros it before returning. `[0x00ed]` is the "clock ran out" flag: cleared at `1000:122a`, set by key `0x86` (`1000:1e8c`), tested by the game-over check `1000:15d2`.

While a side is still in, `1000:4b18` prints `E=` as the sum of `energy / 10` over that side's four alive ships, plus the base energy word with no divide, then the literal character `0` and `#=` and the byte at `89DC`. Ship energy is the only term that is divided.

### Base, 14 bytes at `DS:9014`

Written by `1000:3fd1` for each id whose first byte is nonzero. Spawn (`1000:4459`) refuses if `+0A` is 0 or energy is `<= 200`, then decrements `+0A` and subtracts 100 from energy.

| + | value at creation | use |
| --- | --- | --- |
| 00 | (not set here) | HUD flag. Bit 7 blinks the word "Base" with the frame counter. Low 3 bits pick the color: 0 → color 1, 1 → color 3, else color 2 |
| 01, 03 | random words | X, Y. `1000:428a` keeps them in `[0x5DC, 0x3A24]` |
| 05 | side index, multi-plane only | galaxy level. Spawn copies it to the ship. Single-plane leaves it 0 |
| 06 | `0x14` (20) | mine stock. The base HUD prints `M=` and this byte |
| 07 | `0xAF` (175) if handicap ≥ 3, else `0x7D` (125) | torpedo stock. The base HUD prints `T=` and this byte |
| 08 | `0x61A8` (25000) if handicap ≥ 3, else `0x4E20` (20000) | base energy. Printed as `E=` with no divide. A base with energy 0 is skipped by the distance scans |
| 0A | `(handicap << 1) + 4` | ships remaining. Handicap 1→6, 2→8, 3→10, 4→12. Spawn decrements it |
| 0B | side index | copied to ship `+17` and `+2B` |
| 0C | `[0xa282]` | team tag, copied to ship `+18`. `[0xa282]` starts at 0. After each side it becomes the next side index, or `0x20` when the next id begins with `'m'` (`0x6D`). Combat that compares `+18` skips a target whose tag matches |
| 0D | 4 | 0 means the base is dead (`BASE DEAD!`) |

### Mine slot, 8 bytes

Twenty slots per side, cleared at build: byte 0 = 0, `+6` = side, `+7` = the team tag. Drop mine (`M`, `1000:1d2f` / `1000:1d64`) requires weapons cooldown `+15 <= 0x14` and ship `+06 != 0`, then the first empty slot:

| + | stored |
| --- | --- |
| 00 | `0xFA`, the lifetime |
| 01, 03 | ship X, Y |
| 05 | ship galaxy level |
| 06 | ship `+17` (owner side) |
| 07 | ship `+18` (team tag) |

The drop decrements ship `+06` and clears ship `+22`. On energy death, `1000:210a` calls the same filler once per mine the ship still holds.

### Ship record, 0x3B bytes

`1000:1f1c` walks the four ships of the current side. Bit 7 set: call `2055`, `218b`, `226c`, `20e3`, `210a`. Byte 0 equal to 0: `1000:4459` tries to spawn. Any other value is a countdown; at zero `1000:2002` copies the wreck into a free 7-byte slot.

`1000:1e92` is the command gate. If the ship is dead, or pause bit 7 is set, or this side's pause bit is set, or base view is on, it beeps (`AX=6` into `[0xa25a]`, local side only) and pops the return address so the command body does not run.

7-byte wrecks live at `DS:A08C`, 48 of them (stride 7). `1000:2002` fills one with lifetime `0xC8`, X, Y, galaxy level from `+05`, and the team tag from `+18`. `1000:202f` decrements a live lifetime when `(frame & 7) == 4`. At zero it calls `1000:ac37`.

| + | kind | role |
| --- | --- | --- |
| 00 | flags | bit 7 alive (spawn stores `0x80`). Bit 5 super shields: `S` ORs `0x20`, `D` ANDs `0xDF`, both walk `+32`. Bit 4 invisible: `I` ORs `0x10` when `+0F >= 1`, `V` ANDs `0xEF`. Bit 2 is part of the `0x44` warp test. Bit 0 is toggled by Tab. At damage ≥ 8, `1000:20e3` clears bits 4 and 5 |
| 01 | word | X. Movement masks with `0x3FFF` |
| 03 | word | Y. Same mask. The torus is `0x4000` (16384) on both axes |
| 05 | byte | galaxy level. HUD prints `'A' + level` when multi-plane is on. Distance (`1000:23c4`) returns `0xFFFE` with carry set when the two levels differ. Spawn copies the base level here and to `+31` |
| 06 | byte | mines carried. Spawn stores 0. The HUD draws one icon per mine (`1000:575e`). Drop refuses at 0 |
| 07 | byte | torpedoes carried. Space decrements it and refuses at 0. The base line calls the same field `T`. Spawn stores 5 for beginner or a timed game, 2 for novice, 0 otherwise. The icon drawer (`1000:5778`) paints at most 9 icons and adds an overflow glyph when the count is ≥ 11 |
| 08 | word | energy. HUD prints `E=` and this word (`1000:540e`). Spawn: `0x1D4C` (7500), `0x0BB8` (3000), or `0x03E8` (1000) on the same handicap split as the torpedoes. Destruct (`Z`) beeps and returns when energy ≥ `0x1388` (5000); below that it writes `0xC350` into `+0C` |
| 0A | byte | heading, one nibble each. High nibble is desired: turn clockwise adds `0x10`, counterclockwise subtracts `0x10` (16 steps, full circle). Low nibble is actual. `1000:221e` slews actual toward desired by 1 or 2 steps, the short way around the circle. A seek with distance `<= 0xFA` snaps actual to desired. The compass (`1000:5711`) draws one hand from each nibble. Spawn sets both nibbles equal: `68 * ship_index` → `0x00`, `0x44`, `0x88`, `0xCC` |
| 0B | byte | impulse, one nibble each. High nibble is desired: `+` / Down adds `0x10` while it is `< 0xA0` (0.0 through 1.0). `−` / Up subtracts `0x10`. Low nibble is actual. `1000:21af` steps actual toward desired and stores the wait in `+10`. Warp always sets the desired nibble to `0xB` (11). It sets the actual nibble to 11 only when flags `& 0x44` is already set; otherwise the actual nibble is kept. The gauge (`1000:56b0`) draws both nibbles, capped at 11. Spawn stores `0x11` |
| 0C | word | pending energy charge, not a balance. `1000:239b` adds AX, saturates at `0xFFFF`, and if `AX >= 0x400` also adds `AX / 1024` to `+0E`. `1000:210a` then subtracts it from energy and stores 0. It does not itself subtract energy |
| 0E | byte | damage. HUD: shields `INOP` at ≥ 8, computer `INOP` at ≥ 12. `1000:20e3`: ≥ 8 clears invisible and super shields, ≥ 12 clears seek, ≥ 16 forces weapons cooldown to `0x18`, ≥ 20 zeros `+2A` and `+22`. Healed by `1000:2055` (below) |
| 0F | byte | invisibility charge. Spawn: 99 / 50 / 20 by the same handicap split. `I` requires it ≥ 1. While invisible, not firing, and flags `& 0x44` clear, `1000:226c` decrements it every other frame (every fourth frame for handicap 4) and clears bit 4 at 0. Drawn as a bar at row `0x2C` |
| 10 | byte | ticks until the next impulse step. Cleared when desired and actual impulse match |
| 11 | byte | seek type. Low 5 bits index `DS:0110`. Spawn clears it. Turn keys zero it. Damage ≥ 12 zeros it. Bit 7 is cleared by warp |
| 12 | word | seek distance. HUD prints it when it is `<= 9999` |
| 14 | byte | warp timer. Warp adds 10, capped at `0x64` (100). Cleared by impulse-down, by emergency stop, and by `1000:2055` when energy `<= 2000`. While it is 0, a desired impulse of 11 is pulled back to 10. Drawn as a bar at row `0x22`. `1000:37ac` decrements it once per move while actual impulse ≥ 11 and energy ≥ 2000, and charges 100 |
| 15 | byte | weapons cooldown. HUD: 0 and `+19 == 0` → `Ready`; `+19 != 0` → `Fired`; 1..12 with `+19 == 0` → `Wait`; `> 12` → `INOP`. Torpedo sets 6, forward phaser `0x0C`, aft phaser `0x0A`. Decremented every update while nonzero. Drop-mine allowed while `<= 0x14` |
| 17 | byte | own side, copied from base `+0B` |
| 18 | byte | team tag, copied from base `+0C`. Stored into mines and wrecks. Same tag is not treated as a target |
| 19 | byte | shot in flight. 0 = none. Torpedo sets `0x26`. Forward phaser sets `0x8C`, aft sets `0xCA` (bit 7; a phaser refuses if bit 7 is already set). `1000:37ac` decrements it each move and zeros it if the result is `0x80` or `0xC0`, so a forward phaser lasts 12 steps and an aft phaser 10. Below 4, `+20` is set to `+19 * 4` |
| 1A, 1C | words | shot X, Y. Fire copies the ship position; `1000:382a` then steps these words |
| 1E | byte | shot galaxy level, copied at fire |
| 1F | word | shot heading. Fire stores the masked heading nibbles. Forward phaser adds 9 to the high nibble, plus 7 more when the warp timer is nonzero and the sum is already ≥ `0x13`. Aft phaser subtracts 9, and if that goes negative it negates and XORs the low nibble with 8 |
| 22 | byte | get-mine toggle. `G` XORs bit 0 when `+2A != 0`. Drop-mine clears it |
| 29 | byte | `F` XORs bit 1 (flag planet). Spawn stores 1 |
| 2A | byte | spawn stores 0. Get-mine checks it nonzero. Damage ≥ 20 clears it |
| 2B | byte | fire-control side. F5 increments it and ANDs with 3. HUD prints `*` when it equals `+17`, otherwise `'A' + (value & 3)`. Spawn copies the own side into both |
| 2D, 2F | words | homing point. Spawn copies the base position. `H` (`1000:1b7f`) overwrites them with the ship position when base `+05` equals ship `+17`, and copies that level to `+31` |
| 31 | byte | homing level. Spawn copies `+05` |
| 32 | word | formation link. Commands that repeat (`S`, `D`, `I`, `V`, warp, stop, phasers, torpedo, mine) do `MOV SI,[SI+32]` / `JNZ`. Spawn stores 0. Who writes the link is not mapped |
| 34 | byte | spawn stores 0. Compared against 0 in a few later paths. Not named |

### Heading, impulse, energy

`1000:382a` steps a position. `AH` is the speed (it decrements `AH` and indexes `CS:387C`, 8 bytes per speed). `AL` is the heading: bits 0–1 pick a vector in that group, bits 2–3 rotate it through the four quadrants. X and Y are then masked with `0x3FFF`. `1000:37ac` calls it for every alive record in the 24 slots at `8A8C` whose actual impulse is nonzero, and again for a shot in flight (with `DI` aimed at `+19`, so the adds land on `+1A` / `+1C`). Warp movement (actual impulse ≥ 11, timer nonzero, energy ≥ 2000) adds 9 to the speed for that step.

Distance `1000:23cc` (and the copy at `1000:241a`): absolute dx, dy; if the high byte is `>= 0x20`, subtract `0x4000` and negate, which is the short way around the torus. Shift by `CL`. If the high byte is still nonzero, return `0xFFFF` with carry. Otherwise `sqrt(dx²+dy²) << CL`. `1000:2470` is the square root (`XLAT`). `1000:23c4` checks the galaxy level first and returns `0xFFFE` on a mismatch.

Impulse cost is accumulated by `1000:2055`, and only when `(frame & 3) == 0`. The actual-impulse nibble selects the charge: 0 → 0, 1–3 → 5, 4–7 → 10, 8–10 → 15, ≥ 11 → 10. Energy `<= 1000` halves it. Super shields add `energy / 75`. Changing speed (`1000:21af`) also charges `2 * |desired − actual|` on the step that actually moves the nibble. Forward phaser charges 200, aft charges 100, emergency stop charges `(min(actual, 10) << 5)` and then zeros both impulse nibbles and the warp timer.

`1000:210a` applies `+0C` and clears it:

- Handicap ≥ 3 halves the charge first.
- Flags `& 0x44` (the warp pair): quarter the charge, quarter it again if it is still above 8000, and do not take energy below 10000. If energy is already below 10000 the charge is dropped.
- Otherwise, on every fourth frame, energy `<= 35000` gains 10 before the charge is subtracted. A result `<= 0` kills the ship: remaining mines are dropped, and byte 0 becomes 8, or 12 when the charge was `>= 0xC350` (the destruct value).
- After a non-fatal apply, energy `<= 200` clears the invisible bit.

Damage heals inside `1000:2055` on that same fourth-frame beat: every time, if frame bit 2 is set; otherwise only when actual impulse is `<= 2`.

### HUD gauges — `1000:4530`

Draws the local side. Base view (flag bit `0x10`) takes the level and the color from the base. Otherwise it points at the selected ship and draws:

| caller | input | what is on screen |
| --- | --- | --- |
| `1000:5711` | `+0A` | heading compass. Background sprite `DS:0727`. High nibble indexes `DS:0F1B` (stride `0x1C`), low nibble indexes `DS:10D3` |
| `1000:56b0` | `+0B` | impulse gauge. Background `DS:04D3` at column `0x24`. Both nibbles capped at 11. High nibble indexes `DS:0D3B`, low nibble `DS:0E2B`, stride `0x14` |
| `1000:575e` | `+06` | one mine icon (`DS:18A3`) per count, from column `0x4A` |
| `1000:5778` | `+07` | torpedo icons (`DS:128B`), 5 per row from column `0x4B`. Count ≥ 11 draws 9 icons plus `DS:129D` |
| `1000:57af` | `+14`, row `0x22`, sprite `DS:1D41` | warp-timer bar. Each 4 units is one full segment; a remainder of 1, 2, or 3 selects a shorter segment |
| `1000:57af` | `+0F`, row `0x2C`, sprite `DS:1D1B` | invisibility bar, same segment rule |

`1000:466f` is the text block under the gauges: `Ship N`, `E=`, `Seeking` plus the letter and the distance, `Level`, `Weapons`, `Shields`, `Scanner`, `Computer`, `Fire Ctl`, then the base line `E=` / `T=` / `M=`. `1000:4b83` prints the seek letter: `AL = [DS:0110 + (seek & 0x1F)]`.

`1000:4649` runs from the timer tick. While palette bit 0 is clear it writes the CGA color register at port `0x3D9`. `[0xa299]` nonzero makes it blink (decrement, and OR `0x04` on odd values). The scanner stores `(damage << 2)` into the high bits of that byte.

### Seek values

The handlers at `1000:1afd`–`1000:1b45` all fall into `1000:1b47`, which stores `AL` at `+11`. The bytes in the COM at `DS:0110` are ` *EMDIBSRTXQGHm 1234`. Stored value, letter, key:

| AL | letter | key |
| --- | --- | --- |
| 0..13 | space, `*`, `E`, `M`, `D`, `I`, `B`, `S`, `R`, `T`, `X`, `Q`, `G`, `H` | Alt-C, A, E, M, D, I, B, S, V, T, X, Q, G, H |
| `0x0E` | `m` | Alt-F9 (`1000:1b35`). The scan code is `0xF0`; the stored seek type is `0x0E` |
| `0x10`..`0x13` | `1`..`4` | Alt-F1..F4. Bit 4 marks a formation seek |

If desired impulse is `<= 0x50`, `1000:1b47` forces the desired nibble to 5 and leaves the actual nibble alone. For a formation value it follows the low 2 bits through `1000:2a0c` up to five times. Each step reads that ship's `+11`. If all five still have bit 4 set, the new seek is cleared.

### Planets, 11 bytes

`1000:3228` returns the array for galaxy level `AL`, and `CX = [0x0000]`:

| level | base |
| --- | --- |
| 0 | `DS:92CC` |
| 1 | `DS:963C` |
| 2 | `DS:99AC` |
| ≥ 3 | `DS:9D1C` |

`1000:3fd1` fills one array per level in `[0x0002]`. The first object of a level is type `0x07`, the next two are type `0x0E`, and the rest come from a random draw (`1000:42ac` indexes a 32-byte table at `CS:42BD`). A timed game ORs `0xF0` onto the type (`1000:41f0`). X, Y come from `1000:429b`, kept in `[0x1F4, 0x3E0C]`, and placement is rejected when too close to a base (`1000:4217`) or another planet (`1000:425b`).

Fields written at creation: `+01`/`+03` position, `+05` level, `+06` 0, `+07` 0, `+08` 0, `+0A` `0xFF`. A type whose low nibble is 0 also gets a lifetime in `+06` (random byte in `[0x28, 0xFA]`) and up to two satellites. A satellite is another 11-byte record at the same X, Y plus `0xC8` or `0x190`, with `+08` set to 1 or 2. Build then calls `1000:43b1` a random 0..63 times so the satellite starts somewhere on its orbit.

`1000:43b1` is the orbit step. `+08 == 0` does nothing. `+08 == 1` adds a signed byte from `CS:43F9` (32 entries) to X and a byte a quarter turn away to Y. Any other value uses `CS:4419` (64 entries). `+07` is the phase and increments each call.

`1000:22a2` walks every level's array. A nonzero type is moved every 8th frame, and a nonzero `+06` counts down on that tick. A type whose low nibble is 0 counts `+06` down every 128 frames; hitting 0 relocates the object (1 chance in 16, new type `0x0E`) or ORs `0x0F` into the type, and the same treatment then applies to the following objects until the next type-0 record. The low-nibble values themselves (7, 0x0E, and the `CS:42BD` bytes) are not named yet.

### Universe build — `1000:3fd1`

1. Save `[0x89d0]`, clear `[0x00d1]` bytes at `89D0`, restore the seed.
2. For each side, if the id's first byte is nonzero, place the base and fill its stock. Always write the team tag, the side, `+0D = 4`, and in multi-plane the level. Clear that side's 20 mine slots.
3. If `[0xa271] == 1`, return (instructions / demo).
4. Fill the planet arrays, then call `1000:4312` once per extra record counted by `[0x0001]`.
5. Write the four `89D4` flags and zero `[0x89d2]`.

`1000:4312` itself is not read yet. The RNG is `1000:437a`: it mixes `[0x89d0]` and writes the new word back.

### Command keys — `1000:1884`

Each slot has up to four pending key bytes at `DS:A212 + slot*5` (one-player source is `DS:A20D`). The local keyboard ring is `DS:00E5`–`DS:00EC`, with read pointer `[0x00e1]` and write pointer `[0x00e3]`, both initialized to `0x00e5`. `1000:1759` pops that ring. If the clock has stopped it pads with `0x86`.

`1000:1970` uppercases `a`–`z`. The dispatcher matches AL against a list of `(byte key, word handler)` at `CS:18C4`, terminated by a 0 key. While the 40-byte buffer is nonempty it starts matching at `CS:1909`, so flight keys are ignored and only selection, seek, Tab, and Esc remain. That is the message-entry mode.

BIOS keys with no ASCII, plus Ins and Del, arrive as `scan|0x80`.

| key | scan or ASCII | handler | manual name |
| --- | --- | --- | --- |
| `+`, Down | `+`, `0xD0` | `1BEB` | impulse up |
| `-`, Up | `-`, `0xC8` | `1C00` | impulse down |
| Space | `0x20` | `1C33` | fire torpedo |
| C | | `1C17` | cancel torpedo |
| M | | `1D2F` | drop mine |
| P | | `1D97` | forward phasers |
| A | | `1DF8` | aft phasers |
| S | | `1BB7` | super shields |
| I | | `1CB5` | invisible |
| V | | `1E54` | visible |
| Z | | `1E62` | destruct |
| D | | `1BC5` | drop super shields |
| 1, 2, 3, 4 | | `1A78` `1A7C` `1A80` `1A84` | scan short / med / long / map. Stores 2, 4, 6, 7 into `[0xa270]`, and only for the local side |
| H | | `1B7F` | drop homing device |
| W | | `1CCD` | warp |
| E | | `1D01` | emergency stop |
| G | | `1C9F` | get mine |
| F | | `1CAD` | flag planet |
| F1–F4 | `0xBB`–`0xBE` | `1AD9`–`1AE5` | select ship 1–4 |
| F5 | `0xBF` | `1BA5` | select enemy |
| F9 | `0xC3` | `1B78` | base view |
| F10 | `0xC4` | `1BB0` | change ship id |
| Left, Ins | `0xCB`, `0xD2` | `1BDF` | turn counterclockwise |
| Right, Del | `0xCD`, `0xD3` | `1BD3` | turn clockwise |
| (internal) | `0x85`, `0x86` | `1E7D`, `1E8C` | `0x85` sets bit 0 of `89D8+side`. `0x86` stores 1 at `[0x00ed]`, which `1000:15d2` treats as game over. The key pump writes `0x86` when the clock has stopped |
| Tab | `0x09` | `1A71` | message window |
| Esc | `0x1B` | `1AA7` | pause this ship. Separate from the menu Esc path in `1000:0b45` |
| Alt-C, A, E, M, D, I, B, S, V, T, X, Q, G, H | `0xAE` `9E` `92` `B2` `A0` `97` `B0` `9F` `AF` `94` `AD` `90` `A2` `A3` | `1AFD` then `1B01`+ | computer seek. All of these store a small integer and share `1000:1b47` |
| Alt-F1–F4 | `0xE8`–`0xEB` | `1B39`–`1B45` | seek your ships |
| Alt-F9 | `0xF0` | `1B35` | seek mini-base |

The seek handlers store the small integers in the Seek values section above, not the scan codes in this table. `DS:0110` is the letter string those integers index.

Scanner value `[0xa270]`, read by `1000:4530`: `<=2` short, `<=4` med, `<=6` long, else map. The manual ranges are 400, 1600, 6400, and 16384.

## Video and scripts

`[0xa293]` is the write cursor into an offscreen frame. `1000:5669` sets it to `DL * 0x54 + CX + 0x3F01`. Row stride is `0x54` (84) bytes, which is the CGA 4-color pitch used here (8 glyph rows are stored `0x2A` words apart). `[0xa29b]` is the color, 1–3.

`1000:5554` (`print_cstr`) prints the bytes after the CALL. 0 ends the string, 1–3 set the color, anything else is a character. `1000:557b` expands one glyph from the font at `[0x0016]` into the frame. Color 1 shifts the bits, color 2 ORs the shifted copy (both CGA bit planes), color 3 stores the glyph raw.

`1000:57fb` (`print_inline`) and `1000:0e70` (`print_encoded`) set `[0xa264]=1` and run `1000:5815` (`exec_script`) / `1000:596c` (`decode_script_byte`). The listing already comments each call with the decoded text. `1000:54b0` (`blit_screen`) copies the frame to CGA memory.

`DS:39B5` / `DS:39B7` are the X/Y used while the instruction pages drop help boxes on the HUD. They are not ship coordinates. Each help caption in the script is paired with one of these stores.

## Serial and terminal

`1000:0d70` is the terminal. It clears the screen, draws a receive area and a send area (`1000:0dbd`), and loops on `1000:0f85`. `[0x0096]` and `[0x009b]` are the two cursors (column, row). `[0x00a0]` is the send cursor. Enter transmits.

`1000:0f85`, `1000:5e8c`, `1000:5ed7`, `1000:5eb8`, `1000:5dd6`, `1000:5d22`, `1000:6310` are the serial path (carrier, Hayes `ATDT` / `ATA` strings, and the in-game packet). Not broken down past that. COM3/COM4 work because the UART base comes from BIOS `0040:0000` rather than a hardcoded `3F8`/`2F8`.

## RNG

`[0x89d0]` is a word. Startup stores the BIOS tick count there (`INT 1Ah`, bytes of DX swapped), then increments it on every key poll and every intro iteration. The universe id is this word. It is also incremented in menu idle loops, so it keeps moving while waiting for a key.

## Function names worth using

Only functions with direct evidence. Sizes are from `functions.txt`.

| address | suggested name | why |
| --- | --- | --- |
| `0018` | `start` | already named |
| `0113` | `check_dos_and_memory` | DOS 2.0 and memory gate |
| `0158` | `puts_dos` | `INT 21h` AH=02h on a DS string |
| `0166` | `primary_menu` | menu text and dispatch |
| `0393` | `menu_row_from_index` | loads the `CS:03ca` row |
| `0496` | `quit_to_dos` | restores IVT, mode 3, far jump |
| `04cd` | `edit_initials` | |
| `0562` | `print_initials` | |
| `0585` | `find_com_port` | BIOS `0040:0000` |
| `07ef` | `print_speed_name` | slow/medium/fast/maximum |
| `0830` | `print_game_mode` | long/timed, single/multi |
| `0882` | `print_handicap` | expert..beginner |
| `05c0` | `setup_menu` | falls into `08c8` for two-player |
| `0b07` | `key_is_down` | `+` or Down |
| `0b0e` | `key_is_up` | `-` or Up |
| `0b15` | `toggle_player_count` | |
| `0b28` | `cycle_computer_count` | bits 2–3 of `[0x0012]` |
| `0b45` | `poll_key` | `INT 16h`, global hotkeys |
| `0baf` | `set_palette` | |
| `0c4c` | `serial_cli_call` | CLI, call `5f7b`, STI |
| `0c52` | `print_al_hex` | |
| `0c6a` | `print_baud` | |
| `0c7c` | `checksum_image` | |
| `0d60` | `apply_serial_if_dirty` | |
| `0d70` | `terminal_mode` | |
| `0dbd` | `draw_terminal_screen` | |
| `0e70` | `print_encoded` | already named |
| `0e91` | `terminal_putc` | one byte at the BX cursor |
| `1473` | `play_game` | universe setup and frame loop |
| `15b4` | `send_command_packet` | local copy or `5d22` |
| `15d2` | `check_game_over` | |
| `16fe` | `update_pause` | |
| `1759` | `drain_key_ring` | |
| `1837` | `dispatch_ship_keys` | |
| `1884` | `lookup_key` | |
| `1970` | `to_upper` | |
| `1a97` | `store_if_local_ship` | guards sound and similar |
| `1b47` | `set_seek` | stores AL at ship `+11`, formation check, cruise at 0.5 |
| `1e92` | `command_gate` | dead, paused, or base view skips the command |
| `1ec1` | `ship_flag_ptr` | `BX = 89D4 + side` |
| `1ece` | `pick_ptr` | already named |
| `1ee6` | `update_all_ships` | four calls to `1f1c` |
| `1f1c` | `update_side_ships` | four ship records of `0x3B` |
| `2002` | `spawn_debris` | fills a 7-byte wreck slot |
| `202f` | `age_debris` | when `(frame & 7) == 4` |
| `2055` | `charge_impulse_and_heal` | adds the impulse cost to `+0C`, heals `+0E` |
| `210a` | `apply_energy_charge` | subtracts `+0C` from energy, then clears it |
| `218b` | `slew_impulse` | actual impulse follows desired; calls `21af` |
| `221e` | `slew_heading` | actual heading follows desired |
| `226c` | `drain_invisibility` | decrements `+0F` while invisible |
| `239b` | `add_pending_charge` | adds AX to `+0C`; large adds also bump `+0E` |
| `23b3` | `read_handicap` | id record byte 4 |
| `23cc` | `toroidal_distance` | same body as `241a`. `2470` is the sqrt |
| `2a0c` | `ship_ptr_from_al` | side in `[0xa274]`, ship in `AL & 3` |
| `2ed4` | `add_score_div100` | `89E4` for side BX |
| `3228` | `planet_array_for_level` | `92CC`, `963C`, `99AC`, `9D1C` |
| `37ac` | `move_ships_and_shots` | 24 records from `8A8C`, then shots |
| `382a` | `step_position` | 16-direction step, mask `0x3FFF` |
| `39bf` | (large, 1131 bytes) | seek steering. Not read |
| `3fd1` | `build_universe` | bases, mines, planets, extra records |
| `43b1` | `step_orbit` | planet `+08` selects the table |
| `4459` | `spawn_ship` | spends one ship and 100 base energy |
| `4530` | `draw_hud` | gauges, status text, blit |
| `4649` | `cga_blink_tick` | port `0x3D9` from `[0xa299]` |
| `466f` | `draw_status_text` | Ship, E=, Seeking, Weapons, Shields, base |
| `56b0` | `draw_impulse_gauge` | both nibbles of `+0B` |
| `5711` | `draw_heading_gauge` | both nibbles of `+0A` |
| `575e` | `draw_mine_icons` | one per `+06` |
| `5778` | `draw_torpedo_icons` | `+07`, overflow at ≥ 11 |
| `57af` | `draw_bar_meter` | warp timer and invisibility |
| `54b0` | `blit_screen` | already named |
| `5554` | `print_cstr` | already named |
| `557b` | `draw_glyph` | |
| `5669` | `move_cursor` | row `DL`, column `CX` |
| `57fb` | `print_inline` | already named |
| `5815` | `exec_script` | already named |
| `596c` | `decode_script_byte` | already named |
| `5fa0` | `start_two_player_link` | one-player clears `[0xa209]`; two-player starts the pump |
| `5fe3` | `int01_resume` | `CALL [0xa209]` when that word is nonzero |
| `6820` | `int1c_timer` | already labeled in the listing |
| `684b` | `int03_tick` | decrements the wait counters |
| `688e` | `sound_tick` | |
| `6903` | `clock_tick` | |
| `6980` | `open_score_file` | |
| `6bc5` | `show_statistics` | "TREK RECORD" |
| `6c8c` | `save_settings` | |
| `6c9d` | `load_settings` | |
| `6cae` | `print_score_row` | |
| `6d27` | `write_score_file` | |
| `6d60` | `instructions` | forced until Esc |

## Still open

- Who writes the formation link at ship `+32`. The command walkers are known; the setup is not.
- How mine stock moves from the base (`+06` starts at 20) onto a ship. Spawn stores ship `+06 = 0`.
- Planet type low nibbles. `0x07`, `0x0E`, and the 32 bytes at `CS:42BD` are stored and compared later (`1000:3d24`, `1000:31e1`) and are not named. `1000:4312`, which fills one extra `0x3B` record, is not read.
- `1000:39bf` (seek steering, 1131 bytes) and the other draw calls `1000:4c17`, `1000:50a9`, `1000:511b`.
- Callers of `1000:2ed4`, so the score word can be tied to damage dealt rather than only to the add routine.
- `89D8` beyond bit 0, and what writes `89DC`.
- Ship bytes `+16`, `+20`, `+2C`. `+22`, `+29`, `+2A`, and `+34` are only partly named.
- `[0x0005]`. Arrays with stride `0x19` and `0x50`.
- The modem handshake `1000:59a0`, and the 4-byte baud records at `DS:3976`.
- The 512-byte `TREK28.SCO` layout past the 20-byte settings copy and the 10-byte result rows.
