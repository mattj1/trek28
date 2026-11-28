package trek

// The edge between the game and the machine. The simulation writes an
// offscreen frame and asks for keys. Pixels, the speaker, the score file,
// and quitting are filled in here later. Nothing in this file is a
// translation of a game procedure.

MAX_FRAME :: 0x4000
SCORE_SIZE :: 512
KEY_QUEUE :: 16

Host :: struct {
	frame:           [MAX_FRAME]u8,
	frame_len:       int,
	palette:         u8,
	color_select:    u8,
	speaker_divisor: u16,
	speaker_on:      bool,
	score:           [SCORE_SIZE]u8,
	score_len:       int,
	keys:            [KEY_QUEUE]u8,
	key_head:        int,
	key_tail:        int,
	quit:            bool,
	quit_msg:        string,
}

// 1000:54b0 copies the offscreen frame to CGA memory. The host keeps the bytes.
host_blit :: proc(h: ^Host, frame: []u8) {
	n := min(len(frame), MAX_FRAME)
	copy(h.frame[:n], frame[:n])
	h.frame_len = n
}

// INT 10h AH=0Bh BH=1, the palette bit from DS:0015.
host_set_palette :: proc(h: ^Host, palette_bit: u8) {
	h.palette = palette_bit
}

// Port 0x3D9. 1000:4649 writes it on the timer tick.
host_color_select :: proc(h: ^Host, value: u8) {
	h.color_select = value
}

// Ports 0x42 and 0x61. divisor is the 8253 channel 2 count. on is the speaker gate.
host_speaker :: proc(h: ^Host, divisor: u16, on: bool) {
	h.speaker_divisor = divisor
	h.speaker_on = on
}

// 1000:0b45. pressed is the zero flag inverted: no key means pressed == false and key == 0.
// A returned key uses the game's encoding: ASCII in the low byte, or scan|0x80 when there is no ASCII.
host_poll_key :: proc(h: ^Host) -> (key: u8, pressed: bool) {
	if h.key_head == h.key_tail {
		return 0, false
	}
	key = h.keys[h.key_head]
	h.key_head = (h.key_head + 1) % KEY_QUEUE
	return key, true
}

host_push_key :: proc(h: ^Host, key: u8) -> bool {
	next := (h.key_tail + 1) % KEY_QUEUE
	if next == h.key_head do return false
	h.keys[h.key_tail] = key
	h.key_tail = next
	return true
}

host_score_read :: proc(h: ^Host, buf: []u8) -> int {
	n := min(len(buf), h.score_len)
	copy(buf[:n], h.score[:n])
	return n
}

host_score_write :: proc(h: ^Host, buf: []u8) -> bool {
	n := min(len(buf), SCORE_SIZE)
	copy(h.score[:n], buf[:n])
	h.score_len = n
	return true
}

// Far jump through CS:[0002]. The original vector is zero.
host_quit :: proc(h: ^Host, msg: string) {
	h.quit = true
	h.quit_msg = msg
}
