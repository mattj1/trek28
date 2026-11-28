package trek

// The COM image is compiled in from the disassembly tree. CS is that image,
// loaded at 1000:0000. DS is a 64K segment. Startup copies the initialized
// bytes at file offset 0xAC70 to DS:0000 and leaves the rest zero.

DS_SIZE :: 0x10000
COM_SIZE :: 0xF840
DS_INIT_FILE :: 0xAC70

@(private)
EMBEDDED_COM :: #load("../../TREK28.COM")

Machine :: struct {
	cs:     [COM_SIZE]u8,
	cs_len: int,
	ds:     [DS_SIZE]u8,
}

load_embedded :: proc(m: ^Machine) {
	load_com(m, transmute([]u8)EMBEDDED_COM)
}

load_com :: proc(m: ^Machine, com: []u8) {
	n := min(len(com), COM_SIZE)
	copy(m.cs[:n], com[:n])
	m.cs_len = n
	for i in 0 ..< DS_SIZE {
		m.ds[i] = 0
	}
	if n > DS_INIT_FILE {
		init_n := n - DS_INIT_FILE
		copy(m.ds[:init_n], com[DS_INIT_FILE:][:init_n])
	}
}

read_u8 :: proc(mem: ^[$N]u8, off: u16) -> u8 {
	return mem[off]
}

read_u16 :: proc(mem: ^[$N]u8, off: u16) -> u16 {
	lo := mem[off]
	hi := mem[add16(off, 1)]
	return u16(lo) | u16(hi) << 8
}

write_u8 :: proc(mem: ^[$N]u8, off: u16, v: u8) {
	mem[off] = v
}

write_u16 :: proc(mem: ^[$N]u8, off: u16, v: u16) {
	mem[off] = u8(v)
	mem[add16(off, 1)] = u8(v >> 8)
}
