import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.address.AddressFactory;
import ghidra.program.model.mem.MemoryBlock;

public class ProbeLoad extends GhidraScript {
    @Override
    public void run() throws Exception {
        AddressFactory af = currentProgram.getAddressFactory();
        println("IMAGE_BASE " + currentProgram.getImageBase());
        println("LANG " + currentProgram.getLanguageID());
        println("SPACES:");
        for (var s : af.getAddressSpaces()) {
            println("  space " + s.getName() + " size=" + s.getSize() + " type=" + s.getType());
        }
        println("BLOCKS:");
        for (MemoryBlock b : currentProgram.getMemory().getBlocks()) {
            println("  " + b.getName() + " " + b.getStart() + " - " + b.getEnd()
                + " size=" + b.getSize() + " init=" + b.isInitialized());
        }
        String[] trials = {
            "1000:0000", "1000:0018", "ram:1000:0000", "ram:10000",
            "10000", "ff0:0000", "1ac7:0000", "2532:0000"
        };
        for (String t : trials) {
            Address a = af.getAddress(t);
            println("PARSE [" + t + "] -> " + a);
        }
        byte[] buf = new byte[32];
        int n = currentProgram.getMemory().getBytes(currentProgram.getImageBase(), buf);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) sb.append(String.format("%02x ", buf[i]));
        println("FIRST " + sb);
    }
}
