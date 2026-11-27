import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.address.SegmentedAddress;
import ghidra.program.model.listing.Instruction;
import ghidra.program.model.symbol.Reference;

public class ProbeDis extends GhidraScript {
    @Override
    public void run() throws Exception {
        Address entry = toAddr("0ff0:0100");
        println("disassemble from " + entry + " seg=" + Integer.toHexString(((SegmentedAddress)entry).getSegment()));
        disassemble(entry);
        Instruction ins = getInstructionAt(entry);
        println("ins at entry obj " + ins);
        // walk a few instructions in linear order near the start
        Address a = entry;
        for (int i = 0; i < 25 && a != null; i++) {
            Instruction in = getInstructionContaining(a);
            if (in == null) {
                println("no ins at " + a);
                break;
            }
            SegmentedAddress sa = (SegmentedAddress) in.getAddress();
            println(String.format("%s seg=%s off=%s  %s",
                sa, Integer.toHexString(sa.getSegment()), Integer.toHexString(sa.getSegmentOffset()), in));
            Reference[] refs = in.getReferencesFrom();
            for (Reference r : refs) {
                Address to = r.getToAddress();
                String extra = "";
                if (to instanceof SegmentedAddress) {
                    SegmentedAddress st = (SegmentedAddress) to;
                    extra = " seg=" + Integer.toHexString(st.getSegment()) + " off=" + Integer.toHexString(st.getSegmentOffset());
                }
                println("    ref " + r.getReferenceType() + " -> " + to + extra + " lin=" + Long.toHexString(to.getOffset()));
            }
            a = in.getMaxAddress().next();
        }
        // also show if 1000:0018 has an instruction
        Instruction real = getInstructionAt(toAddr("1000:0018"));
        println("ins at 1000:0018 " + real);
        Instruction wrong = getInstructionAt(toAddr("1010:0018"));
        println("ins at 1010:0018 " + wrong);
    }
}
