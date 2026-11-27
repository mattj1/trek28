// Prepare TREK28.COM for 16-bit real-mode analysis.
// DOS loads a .COM at PSP:0100 with CS=DS=ES=SS=PSP. The image in this
// program is placed at 1000:0000, the same linear address as PSP 0FF0:0100.
// The startup stub adds 0x10 to CS and IRETs to offset 0x0018, which is
// 1000:0018 after that rebase.

import java.math.BigInteger;

import ghidra.app.cmd.disassemble.DisassembleCommand;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.address.AddressSet;
import ghidra.program.model.lang.Register;
import ghidra.program.model.listing.Instruction;
import ghidra.program.model.mem.Memory;
import ghidra.program.model.mem.MemoryBlock;
import ghidra.program.model.symbol.RefType;
import ghidra.program.model.symbol.Reference;
import ghidra.program.model.symbol.SourceType;

public class PrepareTrek extends GhidraScript {

    @Override
    public void run() throws Exception {
        Memory memory = currentProgram.getMemory();
        Address image = toAddr("1000:0000");
        Address entry = toAddr("1000:0018");
        Address stub = toAddr("1000:0000");
        Address iretAt = toAddr("1000:000f");

        // setImageBase relocates every block. The loader already placed the
        // file at 1000:0000, and a later setImageBase call slid it to 2000:0000.
        // Put the bytes back. Do not call setImageBase.
        MemoryBlock imageBlock = memory.getBlock("IMAGE");
        if (imageBlock == null) {
            throw new Exception("IMAGE block is missing");
        }
        println("IMAGE currently " + imageBlock.getStart() + " lin="
            + Long.toHexString(imageBlock.getStart().getOffset())
            + " imageBase=" + currentProgram.getImageBase());
        if (imageBlock.getStart().getOffset() != 0x10000L) {
            MemoryBlock tail = memory.getBlock("RAM_TAIL");
            if (tail != null) {
                memory.removeBlock(tail, monitor);
                println("removed RAM_TAIL");
            }
            memory.moveBlock(imageBlock, image, monitor);
            println("moved IMAGE to " + imageBlock.getStart());
        }
        byte[] sig = new byte[2];
        memory.getBytes(image, sig);
        if ((sig[0] & 0xff) != 0xEB || (sig[1] & 0xff) != 0x02) {
            throw new Exception(String.format(
                "expected COM stub EB 02 at 1000:0000, found %02x %02x", sig[0], sig[1]));
        }

        if (memory.getBlock("PSP") == null) {
            MemoryBlock psp = memory.createInitializedBlock("PSP", toAddr("0ff0:0000"), 0x100,
                (byte) 0, monitor, false);
            // INT 20h at PSP+0, and the top-of-allocation paragraph at PSP+2.
            // RAM is mapped through A000:0000, so the paragraph value is A000h.
            psp.putByte(toAddr("0ff0:0000"), (byte) 0xCD);
            psp.putByte(toAddr("0ff0:0001"), (byte) 0x20);
            psp.putByte(toAddr("0ff0:0002"), (byte) 0x00);
            psp.putByte(toAddr("0ff0:0003"), (byte) 0xA0);
            println("created PSP at 0ff0:0000");
        }

        // One block per 64K segment. A block that crosses a segment boundary
        // is rejected, and real-mode aliases make a long block look like it
        // overlaps the image.
        if (memory.getBlock("RAM_2000") == null) {
            if (memory.getBlock("RAM_TAIL") == null) {
                memory.createUninitializedBlock("RAM_TAIL", toAddr("1000:f840"), 0x7C0L, false);
                println("created RAM_TAIL at 1000:f840");
            }
            for (int seg = 0x2000; seg <= 0x9000; seg += 0x1000) {
                String name = String.format("RAM_%04X", seg);
                Address start = toAddr(String.format("%04x:0000", seg));
                memory.createUninitializedBlock(name, start, 0x10000L, false);
                println("created " + name + " at " + start);
            }
        }

        if (memory.getBlock("VIDEO_A000") == null) {
            memory.createUninitializedBlock("VIDEO_A000", toAddr("a000:0000"), 0x10000L, false);
            memory.createUninitializedBlock("VIDEO_B000", toAddr("b000:0000"), 0x10000L, false);
            println("created VIDEO a000 and b000");
        }
        if (memory.getBlock("IVT") == null) {
            memory.createUninitializedBlock("IVT", toAddr("0000:0000"), 0x400L, false);
        }
        if (memory.getBlock("BDA") == null) {
            memory.createUninitializedBlock("BDA", toAddr("0040:0000"), 0x100L, false);
        }

        setPlateComment(stub,
            "TREK 2.8 COM startup stub.\n" +
            "DOS loads this file at PSP:0100. With PSP segment 0FF0 that is the\n" +
            "linear address mapped here as 1000:0000.\n" +
            "The stub executes MOV AX,CS / ADD AX,10h / IRET to offset 0018,\n" +
            "switching CS so that CS:0000 is the first byte of the file.\n" +
            "Ghidra normalizes segmented addresses, so that landing site is 1000:0018.\n" +
            "The IRET operand computed from CS=1000 (1010:0018) aliases 1000:0118,\n" +
            "which is the middle of startup, not the entry. The reference is\n" +
            "replaced with a jump to 1000:0018.");

        setPlateComment(entry,
            "Relocated program entry (start).\n" +
            "Incoming DS/ES/SS are still the DOS PSP segment 0FF0.\n" +
            "Startup then sets DS = CS+0AC7h = 1AC7h (file offset AC70h) and\n" +
            "SS:SP = (CS+1532h):0200, a stack in the RAM block past the image.\n" +
            "PSP:0002 supplies the top paragraph of the allocation (A000h).");

        ProgramContextSeed(entry);

        // Drop any data the earlier strings pass laid down over the image.
        clearListing(image, toAddr("1000:f83f"));

        AddressSet stubSet = new AddressSet(stub, toAddr("1000:0017"));
        DisassembleCommand stubCmd = new DisassembleCommand(stub, stubSet, true);
        stubCmd.applyTo(currentProgram, monitor);
        println("stub disassembled: " + stubCmd.getDisassembledAddressSet());

        Instruction iret = getInstructionAt(iretAt);
        if (iret == null) {
            println("WARNING: IRET not found at " + iretAt);
        }
        else {
            for (Reference ref : currentProgram.getReferenceManager().getReferencesFrom(iretAt)) {
                currentProgram.getReferenceManager().delete(ref);
            }
            currentProgram.getReferenceManager().addMemoryReference(iretAt, entry,
                RefType.UNCONDITIONAL_JUMP, SourceType.USER_DEFINED, 0);
            setEOLComment(iretAt,
                "IRET to relocated CS:0018, modeled as 1000:0018. Bytes are unchanged.");
        }

        disassemble(entry);
        createLabel(entry, "start", true, SourceType.USER_DEFINED);
        addEntryPoint(entry);
        if (getFunctionAt(entry) == null) {
            createFunction(entry, "start");
        }
        println("entry instructions now " + currentProgram.getListing().getNumInstructions());
    }

    private void ProgramContextSeed(Address entry) {
        setTracked(entry, "DS", 0x0FF0);
        setTracked(entry, "ES", 0x0FF0);
        setTracked(entry, "SS", 0x0FF0);
    }

    private void setTracked(Address at, String name, long value) {
        Register reg = currentProgram.getLanguage().getRegister(name);
        if (reg == null) {
            println("no register " + name);
            return;
        }
        try {
            currentProgram.getProgramContext().setValue(reg, at, at, BigInteger.valueOf(value));
            println("set " + name + " at " + at + " = " + Long.toHexString(value));
        }
        catch (Exception e) {
            println("could not set " + name + ": " + e.getMessage());
        }
    }
}
