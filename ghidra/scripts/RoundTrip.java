// Reassemble every instruction from its listing text and rebuild TREK28.COM.
// Bytes that the disassembler left as data are kept as data. An instruction
// counts only when the assembler emits the original bytes.

import java.io.File;
import java.nio.file.Files;
import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import ghidra.app.plugin.assembler.Assembler;
import ghidra.app.plugin.assembler.Assemblers;
import ghidra.app.plugin.assembler.sleigh.sem.AssemblyResolution;
import ghidra.app.plugin.assembler.sleigh.sem.AssemblyResolutionResults;
import ghidra.app.plugin.assembler.sleigh.sem.AssemblyResolvedPatterns;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.listing.Instruction;
import ghidra.program.model.listing.InstructionIterator;

public class RoundTrip extends GhidraScript {

    private static final int IMAGE = 0xF840;
    private static final int BASE = 0x10000;
    /** Listing prints code targets as 0x1000:0018. The assembler wants the linear address. */
    private static final Pattern SEG = Pattern.compile("0x([0-9a-fA-F]+):([0-9a-fA-F]+)");

    @Override
    public void run() throws Exception {
        byte[] original = new byte[IMAGE];
        currentProgram.getMemory().getBytes(addr(0), original);
        if ((original[0] & 0xff) != 0xEB || (original[1] & 0xff) != 0x02) {
            throw new Exception("IMAGE is not the TREK28 stub at 1000:0000");
        }

        Assembler assembler = Assemblers.getAssembler(currentProgram);
        byte[] rebuilt = new byte[IMAGE];
        boolean[] placed = new boolean[IMAGE];
        int matched = 0;
        int matchedAlt = 0;
        int failed = 0;
        int overlap = 0;

        InstructionIterator it = currentProgram.getListing().getInstructions(addr(0), true);
        while (it.hasNext()) {
            if (monitor.isCancelled()) {
                break;
            }
            Instruction ins = it.next();
            int off = fileOff(ins.getAddress());
            if (off < 0) {
                continue;
            }
            byte[] want = ins.getBytes();
            if (!same(original, off, want)) {
                failed++;
                if (failed <= 20) {
                    println("listing bytes differ from file at " + hex(off));
                }
                continue;
            }
            String text = linearTargets(ins.toString());
            byte[] got = assemble(assembler, ins.getAddress(), text);
            boolean alt = false;
            if (got == null || !Arrays.equals(got, want)) {
                byte[] other = resolve(assembler, ins.getAddress(), text, want);
                if (other != null) {
                    got = other;
                    alt = true;
                }
            }
            if (got == null || !Arrays.equals(got, want)) {
                failed++;
                if (failed <= 25) {
                    println("fail " + hex(off) + " " + text
                        + " file " + hexBytes(want)
                        + " asm " + (got == null ? "-" : hexBytes(got)));
                }
                continue;
            }
            for (int i = 0; i < got.length; i++) {
                if (placed[off + i]) {
                    overlap++;
                    if (overlap <= 10) {
                        println("overlap at " + hex(off + i));
                    }
                }
                placed[off + i] = true;
                rebuilt[off + i] = got[i];
            }
            if (alt) {
                matchedAlt++;
            }
            else {
                matched++;
            }
        }

        int data = 0;
        for (int i = 0; i < IMAGE; i++) {
            if (!placed[i]) {
                rebuilt[i] = original[i];
                data++;
            }
        }

        File out = new File("/root/trek/disassembly/TREK28.rebuilt.com");
        Files.write(out.toPath(), rebuilt);
        int diffs = 0;
        int first = -1;
        for (int i = 0; i < IMAGE; i++) {
            if (rebuilt[i] != original[i]) {
                if (first < 0) {
                    first = i;
                }
                diffs++;
            }
        }
        println("matched " + matched + " alt " + matchedAlt + " failed " + failed
            + " overlap " + overlap + " dataBytes " + data);
        println("diffs " + diffs + (first < 0 ? "" : " first " + hex(first)));
        println("wrote " + out + " identical " + (diffs == 0 && failed == 0 && overlap == 0));
    }

    /** 0x1000:0018 -> 0x10018, which is the same byte in this image. */
    private static String linearTargets(String text) {
        Matcher matcher = SEG.matcher(text);
        StringBuffer sb = new StringBuffer();
        while (matcher.find()) {
            int seg = Integer.parseInt(matcher.group(1), 16);
            int off = Integer.parseInt(matcher.group(2), 16);
            long linear = ((long) seg << 4) + (off & 0xffff);
            matcher.appendReplacement(sb, "0x" + Long.toHexString(linear));
        }
        matcher.appendTail(sb);
        return sb.toString();
    }

    private byte[] assemble(Assembler assembler, Address at, String text) {
        try {
            return assembler.assembleLine(at, text);
        }
        catch (Exception e) {
            return null;
        }
    }

    /** Pick the encoding of this listing line that matches the file bytes. */
    private byte[] resolve(Assembler assembler, Address at, String text, byte[] want) {
        AssemblyResolutionResults results;
        try {
            results = assembler.resolveLine(at, text);
        }
        catch (Exception e) {
            return null;
        }
        for (AssemblyResolution resolution : results) {
            if (!(resolution instanceof AssemblyResolvedPatterns)) {
                continue;
            }
            AssemblyResolvedPatterns patterns = (AssemblyResolvedPatterns) resolution;
            if (patterns.isError() || patterns.isBackfill() || patterns.hasBackfills()) {
                continue;
            }
            byte[] vals = patterns.getInstruction().getVals();
            if (Arrays.equals(vals, want)) {
                return vals;
            }
            if (patterns.getInstruction().countPossibleVals() > 32) {
                continue;
            }
            for (byte[] possible : patterns.possibleInsVals(patterns.getInstruction())) {
                if (Arrays.equals(possible, want)) {
                    return possible;
                }
            }
        }
        return null;
    }

    private static boolean same(byte[] image, int off, byte[] bytes) {
        if (off < 0 || off + bytes.length > image.length) {
            return false;
        }
        for (int i = 0; i < bytes.length; i++) {
            if (image[off + i] != bytes[i]) {
                return false;
            }
        }
        return true;
    }

    private Address addr(int fileOff) {
        return toAddr(String.format("1000:%04x", fileOff));
    }

    private static int fileOff(Address address) {
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

    private static String hexBytes(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            if (sb.length() > 0) {
                sb.append(' ');
            }
            sb.append(String.format("%02x", b & 0xff));
        }
        return sb.toString();
    }
}
