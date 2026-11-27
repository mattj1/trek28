// Rebuild the TREK28 listing around routines that pop their return address and
// read the bytes that follow the CALL. A normal disassembler falls into that
// inline data and loses the rest of the game. This script walks real control
// flow, keeps each payload as data, and continues at the computed resume.
//
//   1000:57fb print_inline   encoded screen script (cipher, 04/05 have operands)
//   1000:0e70 print_encoded  same cipher, one byte per command, 00 ends
//   1000:5554 print_cstr     raw bytes, 00 ends, 01-03 set an attribute
//   1000:1ece pick_ptr       4 near words, index ([A274] & 3), resume at +8

import java.io.BufferedWriter;
import java.io.File;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayDeque;
import java.util.HashSet;
import java.util.Set;

import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.data.ArrayDataType;
import ghidra.program.model.data.ByteDataType;
import ghidra.program.model.lang.InstructionPrototype;
import ghidra.program.model.lang.ProgramProcessorContext;
import ghidra.program.model.listing.Instruction;
import ghidra.program.model.mem.DumbMemBufferImpl;
import ghidra.program.model.mem.MemBuffer;
import ghidra.program.model.symbol.FlowType;
import ghidra.program.model.symbol.SourceType;

public class RebuildFlow extends GhidraScript {

    private static final int IMAGE = 0xF840;
    private static final int PRINT_INLINE = 0x57fb;
    private static final int PRINT_ENCODED = 0x0e70;
    private static final int PRINT_CSTR = 0x5554;
    private static final int PICK_PTR = 0x1ece;
    private static final int BASE = 0x10000;

    private byte[] image;
    /** Bytes that belong to an inline payload. Never disassemble them. */
    private boolean[] scriptByte;

    @Override
    public void run() throws Exception {
        image = new byte[IMAGE];
        currentProgram.getMemory().getBytes(addr(0), image);
        if ((image[0] & 0xff) != 0xEB || (image[1] & 0xff) != 0x02) {
            throw new Exception("IMAGE is not the TREK28 stub at 1000:0000");
        }
        scriptByte = new boolean[IMAGE];

        // Drop the earlier linear fall-through disassembly. Memory blocks stay.
        clearListing(addr(0), addr(IMAGE - 1));
        removeFunctionAt(toAddr("0000:0018"));
        clearListing(toAddr("0000:0018"));

        ArrayDeque<Integer> work = new ArrayDeque<>();
        Set<Integer> queued = new HashSet<>();
        // 5eea is installed as INT 0Bh or INT 0Ch (COM2/COM1) by FUN_1000_5dd6.
        int[] seeds2 = {
            0x0000, 0x0018,
            0x5fe3, 0x6820, 0x684b, 0x6a0c, 0x5eea,
            0x6d60, 0x6bc5, 0x04cd, 0x05c0, 0x0d70, 0x0575, 0x03fa, 0x0428
        };
        for (int seed : seeds2) {
            add(work, queued, seed);
        }
        seedKeyTable(work, queued);
        // CALL word ptr CS:[SI] at 1000:6e51 walks this near-pointer table.
        int table = 0x6ead;
        int tableCount = 0;
        while (table + 1 < IMAGE) {
            int ptr = u16(table);
            if (ptr == 0) {
                break;
            }
            add(work, queued, ptr);
            table += 2;
            tableCount++;
        }
        println("seeded " + tableCount + " handlers from 1000:6ead");

        int created = 0;
        int scripts = 0;
        int encoded = 0;
        int cstrs = 0;
        int ptrs = 0;
        int conflicts = 0;
        int bad = 0;
        File outDir = new File("/root/trek/disassembly");
        if (!outDir.isDirectory()) {
            outDir.mkdirs();
        }
        try (BufferedWriter scriptLog = new BufferedWriter(new OutputStreamWriter(
            Files.newOutputStream(new File(outDir, "scripts.txt").toPath()),
            StandardCharsets.UTF_8))) {
            scriptLog.write("call\tresume\ttext\n");

            while (!work.isEmpty()) {
                if (monitor.isCancelled()) {
                    break;
                }
                int off = work.remove();
                if (off < 0 || off >= IMAGE || scriptByte[off]) {
                    continue;
                }
                Address at = addr(off);
                if (getInstructionContaining(at) != null || getDataContaining(at) != null) {
                    continue;
                }
                Instruction ins;
                try {
                    ProgramProcessorContext ctx =
                        new ProgramProcessorContext(currentProgram.getProgramContext(), at);
                    MemBuffer buf = new DumbMemBufferImpl(currentProgram.getMemory(), at);
                    InstructionPrototype proto =
                        currentProgram.getLanguage().parse(buf, ctx, false);
                    ins = currentProgram.getListing().createInstruction(at, proto, buf, ctx, 0);
                }
                catch (Exception e) {
                    bad++;
                    if (bad <= 15) {
                        println("stop at " + at + " : " + e.getMessage());
                    }
                    continue;
                }
                created++;
                seedStoredCallback(work, queued, ins);

                int target = callTarget(ins);
                if (target == PRINT_INLINE || target == PRINT_ENCODED || target == PRINT_CSTR
                    || target == PICK_PTR) {
                    int resume = placePayload(off, ins, target, scriptLog);
                    if (resume < 0) {
                        conflicts++;
                    }
                    else {
                        if (target == PRINT_INLINE) {
                            scripts++;
                        }
                        else if (target == PRINT_ENCODED) {
                            encoded++;
                        }
                        else if (target == PRINT_CSTR) {
                            cstrs++;
                        }
                        else {
                            ptrs++;
                        }
                        add(work, queued, resume);
                    }
                    add(work, queued, target);
                    continue;
                }

                // The startup IRET's computed target aliases the middle of startup.
                if (off != 0x000f) {
                    Address fall = ins.getDefaultFallThrough();
                    FlowType flow = ins.getFlowType();
                    if (flow.hasFallthrough() && fall != null) {
                        add(work, queued, fileOff(fall));
                    }
                    for (Address dest : ins.getFlows()) {
                        add(work, queued, fileOff(dest));
                    }
                    // INT3 and INT 1 are breakpoints whose handlers IRET.
                    // Ghidra does not give them a fallthrough.
                    if (returnsFromInterrupt(ins)) {
                        add(work, queued, off + ins.getLength());
                    }
                }
            }
            println("created " + created + " instructions, screen " + scripts
                + ", encoded " + encoded + ", cstr " + cstrs + ", ptrs " + ptrs
                + ", conflicts " + conflicts + ", undecoded " + bad);
        }

        createLabel(addr(0x0018), "start", true, SourceType.USER_DEFINED);
        createLabel(addr(PRINT_INLINE), "print_inline", true, SourceType.USER_DEFINED);
        createLabel(addr(PRINT_ENCODED), "print_encoded", true, SourceType.USER_DEFINED);
        createLabel(addr(PRINT_CSTR), "print_cstr", true, SourceType.USER_DEFINED);
        createLabel(addr(PICK_PTR), "pick_ptr", true, SourceType.USER_DEFINED);
        createLabel(addr(0x5815), "exec_script", true, SourceType.USER_DEFINED);
        createLabel(addr(0x596c), "decode_script_byte", true, SourceType.USER_DEFINED);
        createLabel(addr(0x54b0), "blit_screen", true, SourceType.USER_DEFINED);
        createLabel(addr(0x6820), "int1c_timer", true, SourceType.USER_DEFINED);
        createLabel(addr(0x5eea), "serial_isr", true, SourceType.USER_DEFINED);
        createLabel(addr(0x5fe3), "int01_trap", true, SourceType.USER_DEFINED);
        createLabel(addr(0x684b), "int03_break", true, SourceType.USER_DEFINED);
        createLabel(addr(0x6a0c), "int24_criterr", true, SourceType.USER_DEFINED);
        addEntryPoint(addr(0x0018));
        setPlateComment(addr(PRINT_INLINE),
            "Pops the return address and executes an encoded screen script that\n" +
            "follows the CALL. The first word is a key. Each later byte is\n" +
            "decoded as plain = byte - key, key = key - plain.\n" +
            "00 and FF end the script. Bytes above 10h are characters.\n" +
            "04 and 05 consume 6 and 4 raw operand bytes. Execution resumes\n" +
            "at the byte after the terminator (fallthrough is overridden).");
        setPlateComment(addr(PRINT_ENCODED),
            "Pops the return address and prints an encoded string that follows\n" +
            "the CALL. Uses the same key and cipher as print_inline. 00 ends\n" +
            "the string. 01-03 set an attribute. Every other plain byte is one\n" +
            "character. Execution resumes at the next byte (jmp bx).");
        setPlateComment(addr(PRINT_CSTR),
            "Pops the return address and prints the raw bytes that follow the\n" +
            "CALL. 00 ends the string. 01-03 set an attribute. Any other byte\n" +
            "is a character. Execution resumes after the 00.");
        setPlateComment(addr(PICK_PTR),
            "Pops the return address. The next 8 bytes are four near pointers.\n" +
            "([A274] & 3) selects one, returned in BX. Execution resumes at\n" +
            "return address + 8.");

        println("analyzing");
        analyzeAll(currentProgram);
        // A bogus far target landed in the uninitialized RAM block above the image.
        java.util.List<ghidra.program.model.listing.Function> outside = new java.util.ArrayList<>();
        ghidra.program.model.listing.FunctionIterator funcs =
            currentProgram.getFunctionManager().getFunctions(true);
        while (funcs.hasNext()) {
            ghidra.program.model.listing.Function fn = funcs.next();
            if (fileOff(fn.getEntryPoint()) < 0) {
                outside.add(fn);
            }
        }
        for (ghidra.program.model.listing.Function fn : outside) {
            println("removing off-image function " + fn.getEntryPoint() + " " + fn.getName());
            removeFunction(fn);
            clearListing(fn.getEntryPoint());
        }
        println("functions " + currentProgram.getFunctionManager().getFunctionCount()
            + " instructions " + currentProgram.getListing().getNumInstructions());
    }

    /**
     * Command dispatch at 1000:18ad. Records are (key byte, near pointer) and a
     * 00 byte ends the table. BX is aimed at 1000:18c4 or at 1000:1909, which
     * is the middle of the same table.
     */
    private void seedKeyTable(ArrayDeque<Integer> work, Set<Integer> queued) throws Exception {
        int start = 0x18c4;
        int p = start;
        int n = 0;
        while (p < IMAGE && image[p] != 0) {
            if (p + 2 >= IMAGE) {
                break;
            }
            add(work, queued, u16(p + 1));
            p += 3;
            n++;
        }
        if (p < IMAGE && image[p] == 0) {
            p++;
        }
        for (int i = start; i < p; i++) {
            scriptByte[i] = true;
        }
        createData(addr(start), new ArrayDataType(ByteDataType.dataType, p - start, 1));
        println("seeded " + n + " command handlers from 1000:18c4");
    }

    /** mov word ptr [SI+0x24], imm16 stores the next tactical-AI routine. */
    private void seedStoredCallback(ArrayDeque<Integer> work, Set<Integer> queued, Instruction ins) {
        byte[] bytes;
        try {
            bytes = ins.getBytes();
        }
        catch (Exception e) {
            return;
        }
        for (int i = 0; i + 4 < bytes.length; i++) {
            if ((bytes[i] & 0xff) == 0xC7 && (bytes[i + 1] & 0xff) == 0x44
                && (bytes[i + 2] & 0xff) == 0x24) {
                int imm = (bytes[i + 3] & 0xff) | ((bytes[i + 4] & 0xff) << 8);
                add(work, queued, imm);
            }
        }
    }

    private boolean returnsFromInterrupt(Instruction ins) {
        byte[] bytes;
        try {
            bytes = ins.getBytes();
        }
        catch (Exception e) {
            return false;
        }
        int i = 0;
        while (i < bytes.length) {
            int b = bytes[i] & 0xff;
            if (b == 0x26 || b == 0x2e || b == 0x36 || b == 0x3e || b == 0xf0 || b == 0xf2
                || b == 0xf3) {
                i++;
                continue;
            }
            break;
        }
        if (i >= bytes.length) {
            return false;
        }
        int op = bytes[i] & 0xff;
        if (op == 0xCC) {
            return true;
        }
        return op == 0xCD && i + 1 < bytes.length
            && ((bytes[i + 1] & 0xff) == 0x01 || (bytes[i + 1] & 0xff) == 0x03);
    }

    private int placePayload(int callOff, Instruction call, int target, BufferedWriter log)
        throws Exception {
        int start = callOff + call.getLength();
        int resume;
        String shown;
        String tag;
        if (target == PRINT_INLINE) {
            resume = simulate(start);
            shown = oneLine(decodeText(start));
            tag = "inline script";
        }
        else if (target == PRINT_ENCODED) {
            resume = encodedEnd(start);
            shown = oneLine(decodeEncoded(start));
            tag = "encoded string";
        }
        else if (target == PRINT_CSTR) {
            resume = cstrEnd(start);
            shown = oneLine(decodeCstr(start));
            tag = "cstring";
        }
        else {
            resume = start + 8;
            if (resume > IMAGE) {
                resume = -1;
            }
            shown = ptrText(start);
            tag = "ptr table";
        }
        if (resume < 0 || resume <= start || resume > IMAGE) {
            println(tag + " at " + hex(callOff) + " did not terminate");
            return -1;
        }
        log.write(hex(callOff) + "\t" + hex(resume) + "\t" + shown + "\n");
        setEOLComment(call.getAddress(), tag + " -> " + hex(resume) + "  " + shown);
        return definePayload(call, start, resume);
    }

    /** Mark [start, resume) as data and point the call at resume. */
    private int definePayload(Instruction call, int start, int resume) throws Exception {
        Address from = addr(start);
        Address to = addr(resume - 1);
        // An earlier path may have claimed these bytes. The payload is authoritative.
        clearListing(from, to);
        for (int i = start; i < resume; i++) {
            scriptByte[i] = true;
        }
        try {
            createData(from, new ArrayDataType(ByteDataType.dataType, resume - start, 1));
        }
        catch (Exception e) {
            println("data at " + hex(start) + " failed: " + e.getMessage());
            return -1;
        }
        call.setFallThrough(addr(resume));
        return resume;
    }

    private static String oneLine(String text) {
        String shown = text.replace('\n', ' ').replace('\r', ' ');
        if (shown.length() > 160) {
            shown = shown.substring(0, 160);
        }
        return shown;
    }

    private String ptrText(int start) {
        StringBuilder sb = new StringBuilder("[ptr]");
        for (int i = 0; i < 4; i++) {
            int at = start + i * 2;
            if (at + 1 >= IMAGE) {
                break;
            }
            sb.append(' ').append(hex(u16(at)));
        }
        return sb.toString();
    }

    /** Raw print_cstr payload. Returns the file offset just past the 00. */
    private int cstrEnd(int start) {
        int p = start;
        while (p < IMAGE && p - start < 400) {
            if (image[p] == 0) {
                return p + 1;
            }
            p++;
        }
        return -1;
    }

    private String decodeCstr(int start) {
        StringBuilder sb = new StringBuilder();
        int p = start;
        while (p < IMAGE && p - start < 400) {
            int plain = image[p] & 0xff;
            p++;
            if (plain == 0) {
                break;
            }
            appendPlain(sb, plain);
        }
        return sb.toString();
    }

    /**
     * print_encoded payload. Same key as a screen script, but each decoded
     * byte is one command and only 00 ends it.
     */
    private int encodedEnd(int start) {
        if (start < 0 || start + 2 >= IMAGE) {
            return -1;
        }
        int bx = start;
        int key = ((bx + u16(bx)) & 0xffff) & 0xff;
        bx = start + 2;
        int steps = 0;
        while (steps++ < 8000 && bx < IMAGE) {
            int plain = (image[bx] - key) & 0xff;
            key = (key - plain) & 0xff;
            bx++;
            if (plain == 0) {
                return bx;
            }
        }
        return -1;
    }

    private String decodeEncoded(int start) {
        if (start < 0 || start + 2 >= IMAGE) {
            return "";
        }
        int bx = start;
        int key = ((bx + u16(bx)) & 0xffff) & 0xff;
        bx = start + 2;
        StringBuilder sb = new StringBuilder();
        int steps = 0;
        while (steps++ < 8000 && bx < IMAGE) {
            int plain = (image[bx] - key) & 0xff;
            key = (key - plain) & 0xff;
            bx++;
            if (plain == 0) {
                break;
            }
            appendPlain(sb, plain);
        }
        return sb.toString();
    }

    private static void appendPlain(StringBuilder sb, int plain) {
        if (plain == 0x0a) {
            sb.append('\n');
        }
        else if (plain == 0x0d) {
            sb.append('\r');
        }
        else if (plain >= 0x20 && plain < 0x7f) {
            sb.append((char) plain);
        }
        else if (plain <= 3) {
            sb.append("<c").append(plain).append('>');
        }
        else {
            sb.append(String.format("<%02x>", plain));
        }
    }

    /** Return the file offset just past the script, or -1. */
    private int simulate(int start) {
        if (start < 0 || start + 2 >= IMAGE) {
            return -1;
        }
        int bx = start;
        int sum = (bx + u16(bx)) & 0xffff;
        int key = sum & 0xff;
        bx = start + 2;
        int steps = 0;
        while (steps++ < 8000 && bx < IMAGE) {
            int raw = image[bx] & 0xff;
            int plain = (raw - key) & 0xff;
            key = (key - plain) & 0xff;
            bx++;
            if (plain == 0x00 || plain == 0xff) {
                return bx;
            }
            if (plain > 0x10 || plain <= 3) {
                continue;
            }
            if (plain == 4) {
                bx += 6;
                continue;
            }
            if (plain == 5) {
                bx += 4;
                continue;
            }
        }
        return -1;
    }

    private String decodeText(int start) {
        if (start < 0 || start + 2 >= IMAGE) {
            return "";
        }
        int bx = start;
        int sum = (bx + u16(bx)) & 0xffff;
        int key = sum & 0xff;
        bx = start + 2;
        StringBuilder sb = new StringBuilder();
        int steps = 0;
        while (steps++ < 8000 && bx < IMAGE) {
            int raw = image[bx] & 0xff;
            int plain = (raw - key) & 0xff;
            key = (key - plain) & 0xff;
            bx++;
            if (plain == 0x00 || plain == 0xff) {
                break;
            }
            if (plain == 0x0a) {
                sb.append('\n');
            }
            else if (plain == 0x0d) {
                sb.append('\r');
            }
            else if (plain >= 0x20 && plain < 0x7f) {
                sb.append((char) plain);
            }
            else if (plain == 4) {
                sb.append("<pic>");
                bx += 6;
            }
            else if (plain == 5) {
                sb.append("<box>");
                bx += 4;
            }
            else if (plain <= 3) {
                sb.append("<c").append(plain).append('>');
            }
            else if (plain == 0x0b) {
                sb.append("<clear>");
            }
            else if (plain == 0x0c) {
                sb.append("<home>");
            }
        }
        return sb.toString();
    }

    private int callTarget(Instruction ins) {
        if (!ins.getMnemonicString().equalsIgnoreCase("CALL")) {
            return -1;
        }
        byte[] bytes;
        try {
            bytes = ins.getBytes();
        }
        catch (Exception e) {
            return -1;
        }
        int i = 0;
        while (i < bytes.length) {
            int b = bytes[i] & 0xff;
            if (b == 0x26 || b == 0x2e || b == 0x36 || b == 0x3e || b == 0xf0 || b == 0xf2
                || b == 0xf3) {
                i++;
                continue;
            }
            break;
        }
        if (i + 2 >= bytes.length || (bytes[i] & 0xff) != 0xE8) {
            return -1;
        }
        int rel = (bytes[i + 1] & 0xff) | ((bytes[i + 2] & 0xff) << 8);
        if (rel >= 0x8000) {
            rel -= 0x10000;
        }
        int next = fileOff(ins.getAddress()) + ins.getLength();
        return next + rel;
    }

    private int u16(int off) {
        return (image[off] & 0xff) | ((image[off + 1] & 0xff) << 8);
    }

    private void add(ArrayDeque<Integer> work, Set<Integer> queued, int off) {
        if (off < 0 || off >= IMAGE) {
            return;
        }
        if (scriptByte[off]) {
            return;
        }
        if (queued.add(off)) {
            work.add(off);
        }
    }

    private Address addr(int fileOff) {
        return toAddr(String.format("1000:%04x", fileOff));
    }

    private int fileOff(Address address) {
        if (address == null) {
            return -1;
        }
        long off = address.getOffset() - BASE;
        if (off < 0 || off >= IMAGE) {
            return -1;
        }
        return (int) off;
    }

    private static String hex(int off) {
        return String.format("1000:%04x", off);
    }
}
