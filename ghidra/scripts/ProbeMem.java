import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.mem.MemoryBlock;

public class ProbeMem extends GhidraScript {
    @Override
    public void run() throws Exception {
        for (MemoryBlock b : currentProgram.getMemory().getBlocks()) {
            println(String.format("BLOCK %s %s - %s size=%d init=%s startLin=%x endLin=%x",
                b.getName(), b.getStart(), b.getEnd(), b.getSize(), b.isInitialized(),
                b.getStart().getOffset(), b.getEnd().getOffset()));
        }
        String[] addrs = {"1000:f83f","1000:f840","1000:ffff","2000:0000","2000:0001","1fff:0010","2532:0000","3000:0000","a000:0000"};
        for (String s : addrs) {
            Address a = toAddr(s);
            MemoryBlock b = currentProgram.getMemory().getBlock(a);
            println(s + " -> " + a + " lin=" + Long.toHexString(a.getOffset())
                + " block=" + (b == null ? "none" : b.getName()));
        }
    }
}
