import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.SegmentedAddress;

public class ProbeSeg extends GhidraScript {
    @Override
    public void run() throws Exception {
        String[] ts = {"1000:0000","0ff0:0100","1000:0018","0ff0:0118","1010:0018","0ff0:0000","1ac7:0000"};
        for (String t : ts) {
            SegmentedAddress a = (SegmentedAddress) toAddr(t);
            println(t + " -> " + a.toString()
                + " seg=" + Integer.toHexString(a.getSegment())
                + " off=" + Integer.toHexString(a.getSegmentOffset())
                + " lin=" + Long.toHexString(a.getOffset()));
        }
        SegmentedAddress start = (SegmentedAddress) currentProgram.getMemory().getBlock("IMAGE").getStart();
        println("BLOCK start " + start + " seg=" + Integer.toHexString(start.getSegment())
            + " off=" + Integer.toHexString(start.getSegmentOffset()));
    }
}
