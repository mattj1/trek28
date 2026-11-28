package trek

import "core:fmt"
import "core:os"

main :: proc() {
	m := new(Machine)
	defer free(m)
	load_embedded(m)

	letters := string(m.ds[0x110:][:20])
	fmt.println("Trek 2.8 port")
	fmt.printfln("Image %d bytes, DS seek letters %q", m.cs_len, letters)
	fmt.println("Run `odin test src` for the translated procedures.")

	if len(os.args) > 1 && os.args[1] == "-quit" {
		h: Host
		host_quit(&h, "stopped")
		fmt.println(h.quit_msg)
	}
}
