import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;

public class ProbeAlias extends GhidraScript {
    @Override
    public void run() throws Exception {
        String[][] pairs = {
            {"1000:0018", "0ff0:0118"},
            {"1000:0000", "0ff0:0100"},
            {"1010:0018", "1000:0118"},
            {"1ac7:0000", "1000:ac70"},
            {"2532:0000", "1000:0000"}
        };
        for (String[] p : pairs) {
            Address a = toAddr(p[0]);
            Address b = toAddr(p[1]);
            println(p[0] + " off=" + Long.toHexString(a.getOffset())
                + "  " + p[1] + " off=" + Long.toHexString(b.getOffset())
                + "  equal=" + a.equals(b) + " cmp=" + a.compareTo(b));
        }
        // what offset lives in the block for linear 0x10018
        Address img = toAddr("1000:0000");
        println("image start offset " + Long.toHexString(img.getOffset()));
        try {
            byte[] buf = new byte[4];
            currentProgram.getMemory().getBytes(toAddr("1000:0018"), buf);
            println(String.format("bytes at 1000:0018 %02x %02x %02x %02x", buf[0], buf[1], buf[2], buf[3]));
        } catch (Exception e) {
            println("read 1000:0018 failed " + e);
        }
        try {
            byte[] buf = new byte[4];
            currentProgram.getMemory().getBytes(toAddr("0ff0:0118"), buf);
            println(String.format("bytes at 0ff0:0118 %02x %02x %02x %02x", buf[0], buf[1], buf[2], buf[3]));
        } catch (Exception e) {
            println("read 0ff0:0118 failed " + e);
        }
    }
}
