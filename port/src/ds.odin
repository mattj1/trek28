package trek

// DS_Segment is the game data segment, one field per known DS offset.
// Startup sets DS to CS+0x0AC7. Later bare [0xNNNN] operands are offsets into
// this segment. The COM image contributes DS bytes 0000 through 4BCF (file
// offset 0xAC70). Startup clears the rest.
//
// Machine still keeps DS as a raw [DS_SIZE]u8 for the image copy and for a
// read at a runtime offset. A word at DS:FFFF wraps onto DS:0000, which a
// field access cannot do. Ship procedures take a Ship_Record. That is the
// element of ships and of extra_records. Word fields are little-endian, the
// same byte order the 8086 uses. A pad_XXXX array is the unknown run that
// starts at that offset. When a byte in a pad gets a known width, replace
// that slice with a named field and keep the asserts in step.
//
// The fields come from bare DS operands and the arrays those operands index.
// CS:[0], CS:[2], and CS:[4] are the load segment, the fatal-exit vector,
// and the saved PSP segment. ES accesses of 0000:0070 and the other low
// vectors are the interrupt table.

#assert(ODIN_ENDIAN == .Little)

// One 0x3B record. DI points at one of these in 1000:239b and in the ship
// update. extra_records uses the same size, and 1000:37ac walks both.
Ship_Record :: struct #packed {
	// +00. Bit 7 alive. Spawn stores 0x80.
	flags: u8,
	// +01. X. Movement masks with 0x3FFF.
	x: u16,
	// +03. Y. Same mask.
	y: u16,
	// +05. Galaxy level. 1000:23c4 returns 0xFFFE when two levels differ.
	plane: u8,
	// +06. Mines carried. Spawn stores 0.
	mines: u8,
	// +07. Torpedoes carried.
	torpedoes: u8,
	// +08. Energy word.
	energy: u16,
	// +0A. Heading. High nibble desired, low nibble actual.
	heading: u8,
	// +0B. Impulse. High nibble desired, low nibble actual.
	impulse: u8,
	// +0C. Pending energy charge. 1000:239b adds AX and saturates at 0xFFFF.
	pending_charge: u16,
	// +0E. Damage. 1000:239b adds AX >> 10 here. The byte wraps.
	damage: u8,
	// +0F. Invisibility charge.
	invisibility: u8,
	// +10. Ticks until the next impulse step. 1000:21af clears it when the nibbles match.
	impulse_wait: u8,
	// +11. Seek type. Low 5 bits index seek_letters.
	seek: u8,
	// +12. Seek distance.
	seek_distance: u16,
	// +14. Warp timer.
	warp: u8,
	// +15. Weapons cooldown.
	weapons_cooldown: u8,
	// +16. 1000:2b7a stores 0. Later tests read bits. Role is open.
	byte_16: u8,
	// +17. Own side, copied from the base.
	own_side: u8,
	// +18. Team tag.
	team: u8,
	// +19. Shot in flight. 0 means none.
	shot: u8,
	// +1A. Shot X.
	shot_x: u16,
	// +1C. Shot Y.
	shot_y: u16,
	// +1E. Shot galaxy level.
	shot_level: u8,
	// +1F. Shot heading word. The byte at +20 is the high half. 1000:37fb writes that byte on its own.
	shot_heading: u16,
	// +21. No direct operand.
	pad_21: [1]u8,
	// +22. Get-mine toggle. Drop-mine clears it.
	get_mine: u8,
	// +23. 1000:6428 stores AL and 1000:6487 decrements it. Role is open.
	byte_23: u8,
	// +24. 1000:643d calls this word. 1000:6692 stores 0x64B1.
	word_24: u16,
	// +26. 1000:6435 stores AX and 1000:646d compares it. Role is open.
	word_26: u16,
	// +28. 1000:2b7e stores 0. Later tests read bits. Role is open.
	byte_28: u8,
	// +29. F toggles bit 1. Spawn stores 1.
	byte_29: u8,
	// +2A. Spawn stores 0. Get-mine checks it nonzero. Damage >= 20 clears it.
	byte_2a: u8,
	// +2B. Fire-control side. F5 increments it and masks with 3.
	fire_control: u8,
	// +2C. Spawn stores 0. No other direct operand.
	pad_2c: [1]u8,
	// +2D. Homing X.
	homing_x: u16,
	// +2F. Homing Y.
	homing_y: u16,
	// +31. Homing level. Spawn copies plane here.
	homing_level: u8,
	// +32. Formation link. Spawn stores 0. Who writes a nonzero link is open.
	formation: u16,
	// +34. Spawn stores 0. Compared with 0 later. Not named.
	byte_34: u8,
	// +35. Through +3A. No direct operand.
	pad_35: [6]u8,
}

#assert(offset_of(Ship_Record, flags) == 0x00)
#assert(offset_of(Ship_Record, x) == 0x01)
#assert(offset_of(Ship_Record, y) == 0x03)
#assert(offset_of(Ship_Record, plane) == 0x05)
#assert(offset_of(Ship_Record, mines) == 0x06)
#assert(offset_of(Ship_Record, torpedoes) == 0x07)
#assert(offset_of(Ship_Record, energy) == 0x08)
#assert(offset_of(Ship_Record, heading) == 0x0A)
#assert(offset_of(Ship_Record, impulse) == 0x0B)
#assert(offset_of(Ship_Record, pending_charge) == 0x0C)
#assert(offset_of(Ship_Record, damage) == 0x0E)
#assert(offset_of(Ship_Record, invisibility) == 0x0F)
#assert(offset_of(Ship_Record, impulse_wait) == 0x10)
#assert(offset_of(Ship_Record, seek) == 0x11)
#assert(offset_of(Ship_Record, seek_distance) == 0x12)
#assert(offset_of(Ship_Record, warp) == 0x14)
#assert(offset_of(Ship_Record, weapons_cooldown) == 0x15)
#assert(offset_of(Ship_Record, byte_16) == 0x16)
#assert(offset_of(Ship_Record, own_side) == 0x17)
#assert(offset_of(Ship_Record, team) == 0x18)
#assert(offset_of(Ship_Record, shot) == 0x19)
#assert(offset_of(Ship_Record, shot_x) == 0x1A)
#assert(offset_of(Ship_Record, shot_y) == 0x1C)
#assert(offset_of(Ship_Record, shot_level) == 0x1E)
#assert(offset_of(Ship_Record, shot_heading) == 0x1F)
#assert(offset_of(Ship_Record, pad_21) == 0x21)
#assert(offset_of(Ship_Record, get_mine) == 0x22)
#assert(offset_of(Ship_Record, byte_23) == 0x23)
#assert(offset_of(Ship_Record, word_24) == 0x24)
#assert(offset_of(Ship_Record, word_26) == 0x26)
#assert(offset_of(Ship_Record, byte_28) == 0x28)
#assert(offset_of(Ship_Record, byte_29) == 0x29)
#assert(offset_of(Ship_Record, byte_2a) == 0x2A)
#assert(offset_of(Ship_Record, fire_control) == 0x2B)
#assert(offset_of(Ship_Record, pad_2c) == 0x2C)
#assert(offset_of(Ship_Record, homing_x) == 0x2D)
#assert(offset_of(Ship_Record, homing_y) == 0x2F)
#assert(offset_of(Ship_Record, homing_level) == 0x31)
#assert(offset_of(Ship_Record, formation) == 0x32)
#assert(offset_of(Ship_Record, byte_34) == 0x34)
#assert(offset_of(Ship_Record, pad_35) == 0x35)
#assert(size_of(Ship_Record) == 0x3B)

DS_Segment :: struct #packed {
	// 0000. 1000:13a5 stores 0x50. Multi-plane subtracts ((players + computers) * 8) - 6.
	objects_per_level: u8,
	// 0001. How many 0x3B records at extra_records to build. 1000:13aa stores 4, then multi-plane adds players + computers. The image byte is 0x06. 1000:37ac walks all 8 slots.
	extra_record_count: u8,
	// 0002. How many planet levels 1000:3fd1 fills. 1 on a single plane, otherwise players + computers.
	galaxy_levels: u8,
	// 0003. Set when baud or COM changes. 1000:0d60 calls 5dd6 while it is set, then clears it.
	serial_dirty: u8,
	// 0004. Image 0. The PSP segment lives at CS:[4], which is a different segment.
	pad_0004: [1]u8,
	// 0005. 1000:58e9 stores 0x50 and 1000:58f2 stores 0x35. 1000:551d and 1000:5531 compare DI with it. The image word is 0x0035. Role is still open.
	word_0005: u16,
	// 0007. Three letters. A leading space means none have been entered. First three bytes of the 20-byte settings record (0007 through 001A).
	initials: [3]u8,
	// 000A. 1 or 2. Forced back to 1 when no COM port has a UART base.
	player_count: u8,
	// 000B. 0..7 into baud_name and baud_timing.
	baud_index: u8,
	// 000C. 0..3. 1000:0585 keeps the first nonzero UART base from BIOS 0040:0000.
	com_index: u8,
	// 000D. 0 slow, 1 medium, 2 fast, 3 maximum. Frame delay loaded into frame_delay is 9, 8, 7, 6.
	playing_speed: u8,
	// 000E. 0 acoustic coupler. Nonzero is a smart modem.
	link_type: u8,
	// 000F. Same 0..3 names as playing_speed. One-player setup.
	computer_speed: u8,
	// 0010. 1 expert, 2 normal, 3 novice, 4 beginner. Enter cycles 4, 3, 2, 1, 4.
	player_handicap: u8,
	// 0011. Same scale as player_handicap.
	computer_handicap: u8,
	// 0012. Bit 0 timed game. Bit 1 multi-plane. Bits 0-1 cycle together. Bits 2-3 computer count: 00, 04, 0C.
	mode_bits: u8,
	// 0013. One-player. Stored 0..2, displayed as 1..3.
	computer_bases: u8,
	// 0014. ORed into port 0x61 bits 0-1. 3 is sound on, 0 is off. Ctrl-S does XOR 3.
	speaker: u8,
	// 0015. Bit 0. Ctrl-P flips it and calls INT 10h AH=0Bh BH=1.
	palette: u8,
	// 0016. CS offset of the glyph table. Image is 0x28CD (Trek font). Ctrl-F swaps with 0x311D (IBM font). The high byte is DS:0017.
	font_pointer: u16,
	// 0018. 0018 through 001A. The 20-byte score-file copy is 0007 through 001A. These three bytes are the part of that record with no identified role.
	settings_tail: [3]u8,
	// 001B. Zeros in the image between the settings record and dos_required.
	pad_001b: [7]u8,
	// 0022. ASC string "Requires DOS 2.0 or Higher." plus CR LF and a NUL. 1000:012d prints it.
	dos_required: [30]u8,
	// 0040. ASC string "Not Enough Memory" plus CR LF and a NUL. 1000:011c prints it.
	not_enough_memory: [20]u8,
	// 0054. Sprite and script bytes before the menu words. 1000:0346, 1000:0707, and 1000:0a2b load BX=0x008E and call 580c, which reads ES:[BX]. The length of that run is open. The named sprite tables begin in pad_012a.
	pad_0054: [61]u8,
	// 0091. Highlight column. 1000:03b8 and 1000:05d7 store AX from the CS menu-row table.
	menu_column: u16,
	// 0093. Highlight row. Stored with menu_column from the same table.
	menu_row: u16,
	// 0095. Between menu_row and area_cursor_0. No operand names this byte.
	pad_0095: [1]u8,
	// 0096. Terminal cursor, column then row. 1000:0dd1 and 1000:0dd6 clear the two bytes. 1000:0e91 takes BX=0x96.
	area_cursor_0: [2]u8,
	// 0098. Between the two area cursors.
	pad_0098: [3]u8,
	// 009B. Second terminal cursor, column then row. 1000:0dbd clears it. 1000:0d91 takes BX=0x9b.
	area_cursor_1: [2]u8,
	// 009D. Between area_cursor_1 and send_cursor.
	pad_009d: [3]u8,
	// 00A0. Send-area cursor, column then row. 1000:0dc7 clears it. 1000:0da7 takes BX=0xa0.
	send_cursor: [2]u8,
	// 00A2. Image bytes 09 00 14. No operand names them.
	pad_00a2: [3]u8,
	// 00A5. 1000:0b5f jumps through this word. Startup stores 0x00B5, then 0x00D1, then 0x0166. Menus store 0x0166 so Esc redraws the primary menu. The same word is the restart point after an error exit.
	jump_target: u16,
	// 00A7. UART I/O base from BIOS 0040:0000. 1000:0973 reads the high byte at 00A8.
	uart_base: u16,
	// 00A9. Eight 5-byte names, each ended by FF: 110, 150, 300, 600, 1200, 2400, 4800, 9600. 1000:0c73 takes BX=0xa9.
	baud_name: [8][5]u8,
	// 00D1. Byte count 1000:00c0, 1000:00d8, and 1000:3fd8 clear at rng_seed. The image word is 0x1810.
	clear_length: u16,
	// 00D3. Zeros in the image between clear_length and countdown_00e0.
	pad_00d3: [13]u8,
	// 00E0. 1000:197b decrements it each frame. At zero it calls 1a4d (scroll message_queue). If the first queued byte is still nonzero, 1000:1992 stores 0x14 back.
	countdown_00e0: u8,
	// 00E1. Read pointer into key_ring. 1000:150e stores 0x00E5. 1000:176e wraps when the pointer reaches 0x00ED.
	key_read: u16,
	// 00E3. Write pointer into key_ring. Initialized to 0x00E5 with key_read. Same wrap at 0x00ED.
	key_write: u16,
	// 00E5. Bytes 00E5 through 00EC. The pointer compares against 00ED and reloads 00E5.
	key_ring: [8]u8,
	// 00ED. 1000:122a clears it. Key 0x86 stores 1 (1000:1e8c). 1000:15d2 treats 1 as game over.
	clock_expired: u8,
	// 00EE. Word list 1000:2bfe points sound_list at. 1000:688e reads a word and steps the pointer by 2 until it reads 0xFFFF. The image's first 0xFFFF is the fifth word.
	sound_divisors: [5]u16,
	// 00F8. The image continues as word groups that also end in 0xFFFF, at 00F8 and again at 0100. Nothing in the listing points sound_list at them.
	pad_00f8: [24]u8,
	// 0110. Image text " *EMDIBSRTXQGHm 1234". 1000:4b8a reads [BX + 0x110] with the seek type masked by 0x1F.
	seek_letters: [20]u8,
	// 0124. Four spaces in the image, immediately after seek_letters. A seek index past 19 would read these, then status_row. The identified letter table is the 20 bytes at 0110.
	pad_0124: [4]u8,
	// 0128. 1000:4a42 zeros it, 1000:4a59 passes it as DX to 5669 (the row), and 1000:4ab1 adds 8.
	status_row: u16,
	// 012A. Graphics through the byte before serial_count. Lengths are still open, so they stay in this pad. Starts named from the drawing calls: 0133 (1000:5685), impulse background 04D3, heading background 0727, impulse nibbles 0D3B and 0E2B (stride 0x14, capped at 11), heading hands 0F1B (stride 0x1C) and 10D3, torpedo icons 128B and 129D, mine icon 18A3, bars 1D1B and 1D41. 1000:4c60 also takes SI=0x133B.
	pad_012a: [14406]u8,
	// 3970. Bytes waiting in serial_ring. 1000:5e96 compares it with 0. 1000:5f87 zeros it.
	serial_count: u16,
	// 3972. Write pointer into serial_ring. 1000:5f81 stores 0xA370.
	serial_write: u16,
	// 3974. Read pointer into serial_ring. 1000:5f7b stores 0xA370. 1000:5ea7 wraps it from 0xA470 back to 0xA370.
	serial_read: u16,
	// 3976. 1000:5fbd indexes (baud_index & 7) * 4. The pump reads bytes +2 and +3 of the selected record.
	baud_timing: [8][4]u8,
	// 3996. Between baud_timing and score_filename.
	pad_3996: [10]u8,
	// 39A0. ASCZ "TREK28.SCO". 1000:69a2 passes DX=0x39a0 to INT 21h.
	score_filename: [11]u8,
	// 39AB. Zeros after the filename NUL, before byte_39b0.
	pad_39ab: [5]u8,
	// 39B0. 1000:6d68 copies mode_bits here. 1000:6e59 reads it back. Further role is open.
	byte_39b0: u8,
	// 39B1. 1000:6d6b stores 2. Further role is open.
	byte_39b1: u8,
	// 39B2. 1000:a538 loads BX=0x39B2 and calls 580c, which reads ES:[BX]. These three bytes sit between byte_39b1 and hotspot_x.
	pad_39b2: [3]u8,
	// 39B5. Instruction-page box X. 1000:99bd stores 0x4E, and the script pages store it again.
	hotspot_x: u16,
	// 39B7. Instruction-page box Y. Paired with hotspot_x.
	hotspot_y: u16,
	// 39B9. Between hotspot_y and computer_id_byte.
	pad_39b9: [7]u8,
	// 39C0. 1000:1241 copies this into each computer id record, after the three name bytes.
	computer_id_byte: u8,
	// 39C1. 1000:5458 clears 0x2370 words from here (through 80A0). The blit at 1000:54b9 reads from 3F05, 0x64 rows, source stride 0xA8. 1000:5670 builds frame_cursor as row * 0x54 + column + 0x3F01. 1000:54e5 enters the sprite drawer with BX=0x3F37, and 1000:54ea enters it with BX=0x39C1. 1000:549f fills a row at 8051, inside this block.
	offscreen: [0x46E0]u8,
	// 80A1. Between the cleared offscreen block and rng_seed. No absolute DS operand in the listing falls here.
	pad_80a1: [2351]u8,
	// 89D0. Startup stores the INT 1Ah tick with the bytes swapped. Incremented on key polls and menu idle. Universe id is this word. 1000:437a mixes it. 1000:3fd1 preserves it across the clear of clear_length bytes at this address. 1000:a831 also writes the low byte.
	rng_seed: u16,
	// 89D2. 1000:157a increments the word once per frame. Bit tests read the low byte. During universe build the low byte counts bases placed, and build zeros the word before returning.
	frame_count: u16,
	// 89D4. One byte per side. Low 2 bits are the selected ship. Bit 0x10 is base view. 1000:1ec1 returns 0x89D4 + side. Universe build writes (random & 3) | 0x50.
	side_flags: [4]u8,
	// 89D8. One byte per side. Key 0x85 ORs bit 0. 1000:1f83 and 1000:205b compare the byte with 1, and 1000:2055 then zeros that ship's energy. The other bits are open.
	side_89d8: [4]u8,
	// 89DC. One byte per side. 1000:1fa8 stores the sum of the walk's living ships and the base's ships remaining. 1000:4b65 prints it after '#' on the score line. Instructions stores 0x0A in the first two bytes.
	side_89dc: [4]u8,
	// 89E0. 0 while that side is still in. Nonzero selects the end text. 1000:16f0 compares the word at 89E0, and 1000:16f7 stores 0x0303 at 89E2. Those are paired byte writes.
	side_end: [4]u8,
	// 89E4. One word per side. 1000:2ed4 adds round(AX / 100). 1000:6b24 through 1000:6b46 read the words while ranking computer sides.
	side_score: [4]u16,
	// 89EC. 40 bytes per side. 1000:1890 indexes side * 0x28. A nonempty line selects the second key table. 1000:6b4c also reads the word at this address while ranking computer scores.
	message_line: [4][0x28]u8,
	// 8A8C. Eight records, same 0x3B size as a ship. 1000:37ac walks these 8 and then the 16 ships, and that walk ends at bases. extra_record_count says how many 1000:4312 fills.
	extra_records: [8]Ship_Record,
	// 8C64. Side, then ship. 1000:2a0c uses 8C64 + ((side shifted left 2 as a byte) | (ship & 3)) * 0x3B. A side of 4 or more can address past these 16 records.
	ships: [4][4]Ship_Record,
	// 9014. One 14-byte base per side. +01 and +03 position, +05 plane, +06 mine stock, +07 torpedo stock, +08 energy, +0A ships remaining, +0D alive.
	bases: [4][0x0E]u8,
	// 904C. 20 slots of 8 bytes per side. Stride between sides is 0xA0. +00 lifetime, +01 and +03 position, +05 plane, +06 owner, +07 team.
	mines: [4][20][8]u8,
	// 92CC. Level bases 92CC, 963C, 99AC, 9D1C. Stride 0x370 is 0x50 records of 11 bytes. Level 3 and above use the fourth array. +01 and +03 position, +05 level, +06 lifetime, +07 phase, +08 orbit kind.
	planets: [4][0x50][11]u8,
	// A08C. 48 wrecks of 7 bytes. 1000:2002 fills lifetime 0xC8, X, Y, plane, and team. 1000:202f ages one when (frame_count & 7) == 4.
	debris: [48][7]u8,
	// A1DC. Between debris and pic_mask. No absolute DS operand falls here.
	pad_a1dc: [36]u8,
	// A200. 1000:0069 saves port 0x21 here.
	pic_mask: u8,
	// A201. 1000:598e ORs AX into this word inside the script decoder. Role beyond that mix is open.
	word_a201: u16,
	// A203. 1 while the clock runs. A timed game clears it at 0:00.
	clock_enable: u8,
	// A204. Counts 18 timer ticks. 1000:151a stores 0x12. Every fifth second the clock stretches it by one tick.
	clock_ticks: u8,
	// A205. Counts 5 of the clock_ticks cycles. 1000:151f stores 5.
	clock_fifths: u8,
	// A206. Long game counts up. Timed game counts down.
	clock_seconds: u8,
	// A207. Timed game starts at 0x1E (30).
	clock_minutes: u8,
	// A208. Long game counts up through this byte.
	clock_hours: u8,
	// A209. Resume offset for the modem pump. One-player stores 0. INT 1 at 1000:5fe3 calls it when it is nonzero. The word is A209 and A20A.
	link_resume: u16,
	// A20B. Between link_resume and byte_a20c. No operand names this byte.
	pad_a20b: [1]u8,
	// A20C. 1000:1575 stores 0x80 each frame. The pump compares it with 0x80 and also stores 0 and 1.
	byte_a20c: u8,
	// A20D. Up to four keys drained from key_ring. 1000:15be copies these four bytes to the first command_queue slot.
	key_packet: [4]u8,
	// A211. 1000:1998 compares it with CR (0x0D), BS (0x08), space, and 0x7E. Separate from the four key_packet bytes.
	message_char: u8,
	// A212. Five bytes per side. 1000:15c4 copies four key bytes into the first slot and then stores 1 in the fifth. 1000:183c steps BX by 5 across four sides. Play clears all 20 bytes.
	command_queue: [4][5]u8,
	// A226. Eleven bytes per side. Bytes 0-2 are the letters. A leading 0 means the side is unused. Byte 4 is the handicap 1000:23b3 returns. Computers are built as 'm', 'e', '0'+n.
	ids: [4][11]u8,
	// A252. ids ends at A252. wait_byte is A254. No operand names these two bytes.
	pad_a252: [2]u8,
	// A254. INT 3 at 1000:684b decrements it when nonzero. 1000:5a26 also stores 0x36, and the pump copies byte_a481 here.
	wait_byte: u8,
	// A255. INT 3 decrements it when nonzero. Menus and universe setup wait on it. Universe build loads 0xA2.
	wait_word: u16,
	// A257. Frame pacing. INT 3 decrements it. Speed 0..3 reloads 9, 8, 7, 6.
	frame_delay: u16,
	// A259. 1000:17f3 increments it when AL is 0x03. At 2 it injects key 0x85. Otherwise 1000:1809 stores 0.
	ctrl_c_count: u8,
	// A25A. Countdown. While nonzero, 1000:688e programs the timer with divisor 0x0300. 1000:1a97 stores AX here only for the local side.
	sound_beep: u16,
	// A25C. Countdown. Divisor 0x0600 in the same tick routine.
	sound_mid: u16,
	// A25E. Countdown. Divisor 0x6000 in the same tick routine. The word occupies A25E and A25F.
	sound_long: u16,
	// A260. Between sound_long and sound_list. No operand names these two bytes.
	pad_a260: [2]u8,
	// A262. Pointer to a divisor list ended by 0xFFFF. 1000:2bfe stores 0x00EE (sound_divisors). 1000:688e steps it by 2.
	sound_list: u16,
	// A264. print_inline stores 1 and 1000:580c stores 2 before exec_script. The decoder compares it with 1 and with 2, then clears it.
	script_flag: u8,
	// A265. 1000:5988 stores AL, then subtracts this byte from AL and subtracts AL from this byte.
	script_decode: u8,
	// A266. 1000:686d reloads 0x0C when Alt is up (BIOS 0040:0017 bit 3) and decrements it while Alt is down.
	alt_guard: u8,
	// A267. Primary menu row, wrapped 0..7. Startup stores 0. Load-settings stores 5.
	menu_index: u8,
	// A268. Between menu_index and pause_mask. No operand names these four bytes.
	pad_a268: [4]u8,
	// A26C. Bits 0-3, one per ship slot. Bit 7 freezes the clock and the simulation. 1000:1aa7 toggles 1 << ship. 1000:16fe ORs 0x8F when pause_delay hits 0.
	pause_mask: u8,
	// A26D. 1000:16fe counts it down. 1000:1ad3 stores 7 when it is 0 during the pause toggle.
	pause_delay: u8,
	// A26E. 1000:048e stores 1 on the abort-screen path. 1000:049b clears it at the start of quit, before the INT 1Ch restore.
	byte_a26e: u8,
	// A26F. 0 or 1. The modem handshake assigns it. Local-only writes test (current_side XOR local_side) & 3.
	local_side: u8,
	// A270. Keys 1, 2, 3, 4 store 2, 4, 6, 7. HUD: at most 2 is short, at most 4 is med, at most 6 is long, otherwise map. Startup stores 7.
	scanner: u8,
	// A271. 1000:017a stores 0. Instructions at 1000:6d94 stores 1. Universe build returns before planets when this is 1. 1000:4530 also tests it.
	demo_flag: u8,
	// A272. Until this is 1, a menu handler other than quit is forced to the instructions. Esc in the key poll sets it.
	instructions_seen: u8,
	// A273. 1000:6980 clears it. A short or failed score-file read stores 1 (1000:69ec, 1000:6abf).
	score_fault: u8,
	// A274. Side being updated, 0..3.
	current_side: u8,
	// A275. Between current_side and saved_int1c_offset.
	pad_a275: [5]u8,
	// A27A. Previous INT 1Ch offset. Startup exchanges IVT 0000:0070 with 0x6820 and stores the old offset. Quit writes it back.
	saved_int1c_offset: u16,
	// A27C. Previous INT 1Ch segment, from the same exchange at IVT 0000:0072.
	saved_int1c_segment: u16,
	// A27E. Between saved_int1c_segment and byte_a280.
	pad_a27e: [2]u8,
	// A280. 1000:22a2 uses it while walking planets. 1000:22a8 stores 0, and 1000:22b7 compares it with 1. The rest of the scan is open.
	byte_a280: u8,
	// A281. 1000:3e88 stores AL. 1000:3ec1 and 1000:3f09 store CH. Role is open.
	byte_a281: u8,
	// A282. Starts at 0. After each side it becomes the next side index, or 0x20 when the next id begins with 'm'. Copied to base +0C and ship +18.
	team_tag: u8,
	// A283. 1000:2a26 subtracts X, calls 2b36, and stores the word here.
	delta_x: u16,
	// A285. Same sequence for Y.
	delta_y: u16,
	// A287. 1000:2a5f stores the absolute value of delta_x.
	abs_delta_x: u16,
	// A289. 1000:2a4f stores the absolute value of delta_y.
	abs_delta_y: u16,
	// A28B. Scanner window. Map mode (scanner == 7) stores 0. Otherwise the viewed X minus the scanner span.
	view_min_x: u16,
	// A28D. Map mode stores 0x3FFF. Otherwise viewed X plus the span, minus 1.
	view_max_x: u16,
	// A28F. Same window on Y. Map mode stores 0.
	view_min_y: u16,
	// A291. Map mode stores 0x3FFF.
	view_max_y: u16,
	// A293. Write position in offscreen. 1000:5669 stores row * 0x54 + column + 0x3F01.
	frame_cursor: u16,
	// A295. 1000:1f1c zeros it and counts ships that stay alive through that side's walk. The tail adds the base's ships remaining and stores the sum in side_89dc.
	byte_a295: u8,
	// A296. 1000:4bda reads it into BL and 1000:4bec writes BL back. Role is open.
	byte_a296: u8,
	// A297. 1000:458d stores SI and 1000:45c3 reads it back. Role is open.
	word_a297: u16,
	// A299. 1000:4649 decrements it and ORs 0x04 on odd values while palette bit 0 is clear, then writes port 0x3D9. The scanner stores (damage << 2) into the high bits.
	blink: u8,
	// A29A. Between blink and draw_color.
	pad_a29a: [1]u8,
	// A29B. Print color 1..3. 1000:5554 stores 1..3 here when the inline string asks for a color.
	draw_color: u8,
	// A29C. 1000:2d77 stores 0. 1000:2dba ORs 1 and 1000:2dd4 ORs 2. Role is open.
	byte_a29c: u8,
	// A29D. Between byte_a29c and message_queue.
	pad_a29d: [1]u8,
	// A29E. Four lines of 0x28 bytes, ending at setup_cursor. 1000:1a06 scans for a 0 first byte, stepping 0x28. 1000:1a4d scrolls by moving 0x78 bytes down and clearing the last line. 1000:50e4 prints from the first line. countdown_00e0 tests the first byte.
	message_queue: [4][0x28]u8,
	// A33E. Setup menu row. 1000:05c0 clears it.
	setup_cursor: u8,
	// A33F. Between setup_cursor and byte_a340.
	pad_a33f: [1]u8,
	// A340. 1000:0d7e stores 0xFF. Terminal routines exchange it with AL and compare (1000:0fa3, 1000:1034, 1000:10cd, 1000:115e). Role is open.
	byte_a340: u8,
	// A341. Handler offset from the CS menu table. 1000:037e compares it with 0x0496. 1000:038c jumps through it.
	menu_handler: u16,
	// A343. 1000:0065 saves SP. The jump_target restart and the frame loop reload SP from here.
	saved_sp: u16,
	// A345. Between saved_sp and word_a350.
	pad_a345: [11]u8,
	// A350. 1000:1859 stores SI and 1000:186c reads it back. Role is open.
	word_a350: u16,
	// A352. Between word_a350 and byte_a360.
	pad_a352: [14]u8,
	// A360. 1000:4580 stores AH and 1000:4703 reads it into AL. Role is open.
	byte_a360: u8,
	// A361. Between byte_a360 and serial_ring.
	pad_a361: [15]u8,
	// A370. 256 bytes. serial_read and serial_write run from 0xA370 and wrap when they reach 0xA470.
	serial_ring: [0x100]u8,
	// A470. Link sequence byte. 1000:5fae zeros it. 1000:6120 and 1000:629e increment it. The ring wraps at this address, so the ring bytes stop at the byte before it.
	byte_a470: u8,
	// A471. 1000:601d zeros it. The pump sends the low byte (1000:6081) and the high byte (1000:608f) as two link bytes. 1000:62dd and 1000:62e4 update the word.
	word_a471: u16,
	// A473. 1000:617f stores 0 and 1000:6195 stores 1. The pump subtracts it from byte_a470.
	byte_a473: u8,
	// A474. 1000:6002 and 1000:61fa copy the four key_packet bytes here, then the pump sends them one byte at a time.
	link_keys: [4]u8,
	// A478. 1000:60df through 1000:60fa store four received bytes.
	link_recv: [4]u8,
	// A47C. 1000:6128 copies the four link_recv bytes here.
	link_recv_copy: [4]u8,
	// A480. 1000:6103 stores one more received byte. 1000:611a compares it with local_side.
	byte_a480: u8,
	// A481. Timing byte. 1000:5fcf copies a baud_timing byte here, and 1000:5fdb stores 0x1E on the other path. 1000:6097 copies it to wait_byte.
	byte_a481: u8,
	// A482. The other timing byte from baud_timing. 1000:609d copies it over byte_a481 after a packet.
	byte_a482: u8,
	// A483. 1000:5a65, 1000:5b2f, and 1000:5b9a read or write it. Role in the handshake is open.
	byte_a483: u8,
	// A484. 1000:5a76 and 1000:5b3c store DX. 1000:5b84 compares AX with it. Role is open.
	word_a484: u16,
	// A486. 1000:59d5 tests bit 0. 1000:5d00 increments it. Role is open.
	byte_a486: u8,
	// A487. Between byte_a486 and byte_a490.
	pad_a487: [9]u8,
	// A490. 1000:63f4 zeros it, 1000:640d increments it, 1000:644f tests it. Role is open.
	byte_a490: u8,
	// A491. Between byte_a490 and score_names.
	pad_a491: [18]u8,
	// A4A3. 1000:6baf stores two 3-letter ids here (the bytes just compared). 1000:6adf reads them back with SI=0xA4A3.
	score_names: [6]u8,
	// A4A9. 1000:6985 tests bit 0. 1000:69f2 sets bit 0. A short read on this path also sets score_fault.
	score_file_flag: u8,
	// A4AA. Between score_file_flag and score_handle.
	pad_a4aa: [1]u8,
	// A4AB. DOS handle from open or create. 1000:6d4c passes it to AH=3Eh close.
	score_handle: u16,
	// A4AD. 512-byte TREK28.SCO image. 1000:6be8 prints the leading word as the game count. Settings are copied to offset 2 (A4AF), 20 bytes. 1000:6bfb walks CX=0x12 rows from A4C3. A row on screen is 10 bytes: 3 initials, 3 opponent initials, two score words.
	score_file: [0x200]u8,
	// A6AD. Above the score file. Startup zeros from the end of the COM image through the stack. The bytes stay in the map so the segment is 64K.
	pad_a6ad: [22867]u8,
}

// Layout lock for this file. A resized field has to update its offset here.
#assert(offset_of(DS_Segment, objects_per_level) == 0x0000)
#assert(offset_of(DS_Segment, extra_record_count) == 0x0001)
#assert(offset_of(DS_Segment, galaxy_levels) == 0x0002)
#assert(offset_of(DS_Segment, serial_dirty) == 0x0003)
#assert(offset_of(DS_Segment, pad_0004) == 0x0004)
#assert(offset_of(DS_Segment, word_0005) == 0x0005)
#assert(offset_of(DS_Segment, initials) == 0x0007)
#assert(offset_of(DS_Segment, player_count) == 0x000A)
#assert(offset_of(DS_Segment, baud_index) == 0x000B)
#assert(offset_of(DS_Segment, com_index) == 0x000C)
#assert(offset_of(DS_Segment, playing_speed) == 0x000D)
#assert(offset_of(DS_Segment, link_type) == 0x000E)
#assert(offset_of(DS_Segment, computer_speed) == 0x000F)
#assert(offset_of(DS_Segment, player_handicap) == 0x0010)
#assert(offset_of(DS_Segment, computer_handicap) == 0x0011)
#assert(offset_of(DS_Segment, mode_bits) == 0x0012)
#assert(offset_of(DS_Segment, computer_bases) == 0x0013)
#assert(offset_of(DS_Segment, speaker) == 0x0014)
#assert(offset_of(DS_Segment, palette) == 0x0015)
#assert(offset_of(DS_Segment, font_pointer) == 0x0016)
#assert(offset_of(DS_Segment, settings_tail) == 0x0018)
#assert(offset_of(DS_Segment, pad_001b) == 0x001B)
#assert(offset_of(DS_Segment, dos_required) == 0x0022)
#assert(offset_of(DS_Segment, not_enough_memory) == 0x0040)
#assert(offset_of(DS_Segment, pad_0054) == 0x0054)
#assert(offset_of(DS_Segment, menu_column) == 0x0091)
#assert(offset_of(DS_Segment, menu_row) == 0x0093)
#assert(offset_of(DS_Segment, pad_0095) == 0x0095)
#assert(offset_of(DS_Segment, area_cursor_0) == 0x0096)
#assert(offset_of(DS_Segment, pad_0098) == 0x0098)
#assert(offset_of(DS_Segment, area_cursor_1) == 0x009B)
#assert(offset_of(DS_Segment, pad_009d) == 0x009D)
#assert(offset_of(DS_Segment, send_cursor) == 0x00A0)
#assert(offset_of(DS_Segment, pad_00a2) == 0x00A2)
#assert(offset_of(DS_Segment, jump_target) == 0x00A5)
#assert(offset_of(DS_Segment, uart_base) == 0x00A7)
#assert(offset_of(DS_Segment, baud_name) == 0x00A9)
#assert(offset_of(DS_Segment, clear_length) == 0x00D1)
#assert(offset_of(DS_Segment, pad_00d3) == 0x00D3)
#assert(offset_of(DS_Segment, countdown_00e0) == 0x00E0)
#assert(offset_of(DS_Segment, key_read) == 0x00E1)
#assert(offset_of(DS_Segment, key_write) == 0x00E3)
#assert(offset_of(DS_Segment, key_ring) == 0x00E5)
#assert(offset_of(DS_Segment, clock_expired) == 0x00ED)
#assert(offset_of(DS_Segment, sound_divisors) == 0x00EE)
#assert(offset_of(DS_Segment, pad_00f8) == 0x00F8)
#assert(offset_of(DS_Segment, seek_letters) == 0x0110)
#assert(offset_of(DS_Segment, pad_0124) == 0x0124)
#assert(offset_of(DS_Segment, status_row) == 0x0128)
#assert(offset_of(DS_Segment, pad_012a) == 0x012A)
#assert(offset_of(DS_Segment, serial_count) == 0x3970)
#assert(offset_of(DS_Segment, serial_write) == 0x3972)
#assert(offset_of(DS_Segment, serial_read) == 0x3974)
#assert(offset_of(DS_Segment, baud_timing) == 0x3976)
#assert(offset_of(DS_Segment, pad_3996) == 0x3996)
#assert(offset_of(DS_Segment, score_filename) == 0x39A0)
#assert(offset_of(DS_Segment, pad_39ab) == 0x39AB)
#assert(offset_of(DS_Segment, byte_39b0) == 0x39B0)
#assert(offset_of(DS_Segment, byte_39b1) == 0x39B1)
#assert(offset_of(DS_Segment, pad_39b2) == 0x39B2)
#assert(offset_of(DS_Segment, hotspot_x) == 0x39B5)
#assert(offset_of(DS_Segment, hotspot_y) == 0x39B7)
#assert(offset_of(DS_Segment, pad_39b9) == 0x39B9)
#assert(offset_of(DS_Segment, computer_id_byte) == 0x39C0)
#assert(offset_of(DS_Segment, offscreen) == 0x39C1)
#assert(offset_of(DS_Segment, pad_80a1) == 0x80A1)
#assert(offset_of(DS_Segment, rng_seed) == 0x89D0)
#assert(offset_of(DS_Segment, frame_count) == 0x89D2)
#assert(offset_of(DS_Segment, side_flags) == 0x89D4)
#assert(offset_of(DS_Segment, side_89d8) == 0x89D8)
#assert(offset_of(DS_Segment, side_89dc) == 0x89DC)
#assert(offset_of(DS_Segment, side_end) == 0x89E0)
#assert(offset_of(DS_Segment, side_score) == 0x89E4)
#assert(offset_of(DS_Segment, message_line) == 0x89EC)
#assert(offset_of(DS_Segment, extra_records) == 0x8A8C)
#assert(offset_of(DS_Segment, ships) == 0x8C64)
#assert(offset_of(DS_Segment, ships) + offset_of(Ship_Record, pending_charge) == 0x8C70)
#assert(offset_of(DS_Segment, extra_records) + offset_of(Ship_Record, pending_charge) == 0x8A98)
#assert(offset_of(DS_Segment, bases) == 0x9014)
#assert(offset_of(DS_Segment, mines) == 0x904C)
#assert(offset_of(DS_Segment, planets) == 0x92CC)
#assert(offset_of(DS_Segment, debris) == 0xA08C)
#assert(offset_of(DS_Segment, pad_a1dc) == 0xA1DC)
#assert(offset_of(DS_Segment, pic_mask) == 0xA200)
#assert(offset_of(DS_Segment, word_a201) == 0xA201)
#assert(offset_of(DS_Segment, clock_enable) == 0xA203)
#assert(offset_of(DS_Segment, clock_ticks) == 0xA204)
#assert(offset_of(DS_Segment, clock_fifths) == 0xA205)
#assert(offset_of(DS_Segment, clock_seconds) == 0xA206)
#assert(offset_of(DS_Segment, clock_minutes) == 0xA207)
#assert(offset_of(DS_Segment, clock_hours) == 0xA208)
#assert(offset_of(DS_Segment, link_resume) == 0xA209)
#assert(offset_of(DS_Segment, pad_a20b) == 0xA20B)
#assert(offset_of(DS_Segment, byte_a20c) == 0xA20C)
#assert(offset_of(DS_Segment, key_packet) == 0xA20D)
#assert(offset_of(DS_Segment, message_char) == 0xA211)
#assert(offset_of(DS_Segment, command_queue) == 0xA212)
#assert(offset_of(DS_Segment, ids) == 0xA226)
#assert(offset_of(DS_Segment, pad_a252) == 0xA252)
#assert(offset_of(DS_Segment, wait_byte) == 0xA254)
#assert(offset_of(DS_Segment, wait_word) == 0xA255)
#assert(offset_of(DS_Segment, frame_delay) == 0xA257)
#assert(offset_of(DS_Segment, ctrl_c_count) == 0xA259)
#assert(offset_of(DS_Segment, sound_beep) == 0xA25A)
#assert(offset_of(DS_Segment, sound_mid) == 0xA25C)
#assert(offset_of(DS_Segment, sound_long) == 0xA25E)
#assert(offset_of(DS_Segment, pad_a260) == 0xA260)
#assert(offset_of(DS_Segment, sound_list) == 0xA262)
#assert(offset_of(DS_Segment, script_flag) == 0xA264)
#assert(offset_of(DS_Segment, script_decode) == 0xA265)
#assert(offset_of(DS_Segment, alt_guard) == 0xA266)
#assert(offset_of(DS_Segment, menu_index) == 0xA267)
#assert(offset_of(DS_Segment, pad_a268) == 0xA268)
#assert(offset_of(DS_Segment, pause_mask) == 0xA26C)
#assert(offset_of(DS_Segment, pause_delay) == 0xA26D)
#assert(offset_of(DS_Segment, byte_a26e) == 0xA26E)
#assert(offset_of(DS_Segment, local_side) == 0xA26F)
#assert(offset_of(DS_Segment, scanner) == 0xA270)
#assert(offset_of(DS_Segment, demo_flag) == 0xA271)
#assert(offset_of(DS_Segment, instructions_seen) == 0xA272)
#assert(offset_of(DS_Segment, score_fault) == 0xA273)
#assert(offset_of(DS_Segment, current_side) == 0xA274)
#assert(offset_of(DS_Segment, pad_a275) == 0xA275)
#assert(offset_of(DS_Segment, saved_int1c_offset) == 0xA27A)
#assert(offset_of(DS_Segment, saved_int1c_segment) == 0xA27C)
#assert(offset_of(DS_Segment, pad_a27e) == 0xA27E)
#assert(offset_of(DS_Segment, byte_a280) == 0xA280)
#assert(offset_of(DS_Segment, byte_a281) == 0xA281)
#assert(offset_of(DS_Segment, team_tag) == 0xA282)
#assert(offset_of(DS_Segment, delta_x) == 0xA283)
#assert(offset_of(DS_Segment, delta_y) == 0xA285)
#assert(offset_of(DS_Segment, abs_delta_x) == 0xA287)
#assert(offset_of(DS_Segment, abs_delta_y) == 0xA289)
#assert(offset_of(DS_Segment, view_min_x) == 0xA28B)
#assert(offset_of(DS_Segment, view_max_x) == 0xA28D)
#assert(offset_of(DS_Segment, view_min_y) == 0xA28F)
#assert(offset_of(DS_Segment, view_max_y) == 0xA291)
#assert(offset_of(DS_Segment, frame_cursor) == 0xA293)
#assert(offset_of(DS_Segment, byte_a295) == 0xA295)
#assert(offset_of(DS_Segment, byte_a296) == 0xA296)
#assert(offset_of(DS_Segment, word_a297) == 0xA297)
#assert(offset_of(DS_Segment, blink) == 0xA299)
#assert(offset_of(DS_Segment, pad_a29a) == 0xA29A)
#assert(offset_of(DS_Segment, draw_color) == 0xA29B)
#assert(offset_of(DS_Segment, byte_a29c) == 0xA29C)
#assert(offset_of(DS_Segment, pad_a29d) == 0xA29D)
#assert(offset_of(DS_Segment, message_queue) == 0xA29E)
#assert(offset_of(DS_Segment, setup_cursor) == 0xA33E)
#assert(offset_of(DS_Segment, pad_a33f) == 0xA33F)
#assert(offset_of(DS_Segment, byte_a340) == 0xA340)
#assert(offset_of(DS_Segment, menu_handler) == 0xA341)
#assert(offset_of(DS_Segment, saved_sp) == 0xA343)
#assert(offset_of(DS_Segment, pad_a345) == 0xA345)
#assert(offset_of(DS_Segment, word_a350) == 0xA350)
#assert(offset_of(DS_Segment, pad_a352) == 0xA352)
#assert(offset_of(DS_Segment, byte_a360) == 0xA360)
#assert(offset_of(DS_Segment, pad_a361) == 0xA361)
#assert(offset_of(DS_Segment, serial_ring) == 0xA370)
#assert(offset_of(DS_Segment, byte_a470) == 0xA470)
#assert(offset_of(DS_Segment, word_a471) == 0xA471)
#assert(offset_of(DS_Segment, byte_a473) == 0xA473)
#assert(offset_of(DS_Segment, link_keys) == 0xA474)
#assert(offset_of(DS_Segment, link_recv) == 0xA478)
#assert(offset_of(DS_Segment, link_recv_copy) == 0xA47C)
#assert(offset_of(DS_Segment, byte_a480) == 0xA480)
#assert(offset_of(DS_Segment, byte_a481) == 0xA481)
#assert(offset_of(DS_Segment, byte_a482) == 0xA482)
#assert(offset_of(DS_Segment, byte_a483) == 0xA483)
#assert(offset_of(DS_Segment, word_a484) == 0xA484)
#assert(offset_of(DS_Segment, byte_a486) == 0xA486)
#assert(offset_of(DS_Segment, pad_a487) == 0xA487)
#assert(offset_of(DS_Segment, byte_a490) == 0xA490)
#assert(offset_of(DS_Segment, pad_a491) == 0xA491)
#assert(offset_of(DS_Segment, score_names) == 0xA4A3)
#assert(offset_of(DS_Segment, score_file_flag) == 0xA4A9)
#assert(offset_of(DS_Segment, pad_a4aa) == 0xA4AA)
#assert(offset_of(DS_Segment, score_handle) == 0xA4AB)
#assert(offset_of(DS_Segment, score_file) == 0xA4AD)
#assert(offset_of(DS_Segment, pad_a6ad) == 0xA6AD)
#assert(size_of(DS_Segment) == 0x10000)
