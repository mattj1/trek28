// Export the TREK28 disassembly, strings, interrupt calls, and decompilation.

import java.io.BufferedWriter;
import java.io.File;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

import ghidra.app.decompiler.DecompInterface;
import ghidra.app.decompiler.DecompileOptions;
import ghidra.app.decompiler.DecompileResults;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.listing.Data;
import ghidra.program.model.listing.DataIterator;
import ghidra.program.model.listing.Function;
import ghidra.program.model.listing.FunctionIterator;
import ghidra.program.model.listing.Instruction;
import ghidra.program.model.listing.InstructionIterator;
import ghidra.program.model.mem.MemoryBlock;
import ghidra.program.model.symbol.Symbol;

public class ExportTrek extends GhidraScript {

    private static final File OUT_DIR = new File("/root/trek/disassembly");

    @Override
    public void run() throws Exception {
        if (!OUT_DIR.isDirectory() && !OUT_DIR.mkdirs()) {
            throw new Exception("cannot create " + OUT_DIR);
        }

        long instructions = currentProgram.getListing().getNumInstructions();
        int functions = currentProgram.getFunctionManager().getFunctionCount();
        println("exporting instructions=" + instructions + " functions=" + functions);

        writeStats(instructions, functions);
        writeListing();
        println("listing written");
        int strings = writeStrings();
        println("strings written " + strings);
        int interrupts = writeInterrupts();
        println("interrupts written " + interrupts);
        writeFunctions();
        println("functions written");
        writeDecompiled();
        println("decompilation written");
    }

    private void writeStats(long instructions, int functions) throws Exception {
        File file = new File(OUT_DIR, "stats.txt");
        try (BufferedWriter w = writer(file)) {
            w.write("program: TREK28.COM\n");
            w.write("language: " + currentProgram.getLanguageID() + "\n");
            w.write("compiler: " + currentProgram.getCompilerSpec().getCompilerSpecID() + "\n");
            w.write("image base: " + currentProgram.getImageBase() + "\n");
            w.write("instructions: " + instructions + "\n");
            w.write("functions: " + functions + "\n");
            w.write("blocks:\n");
            for (MemoryBlock block : currentProgram.getMemory().getBlocks()) {
                w.write("  " + block.getName() + " " + block.getStart() + " - " + block.getEnd()
                    + " size=" + block.getSize()
                    + (block.isInitialized() ? " initialized" : " uninitialized") + "\n");
            }
        }
    }

    private void writeListing() throws Exception {
        File file = new File(OUT_DIR, "TREK28.asm");
        try (BufferedWriter w = writer(file)) {
            w.write("; TREK28.COM disassembly\n");
            w.write("; Ghidra 12.2, processor x86:LE:16:Real Mode\n");
            w.write("; Load address 1000:0000 == DOS PSP 0FF0:0100. Entry is 1000:0018 (start).\n");
            w.write("; DS is initially 0FF0 (PSP). Startup relocates DS to 1AC7 and SS to 2532.\n");
            w.write("\n");
            InstructionIterator it = currentProgram.getListing().getInstructions(true);
            while (it.hasNext()) {
                Instruction ins = it.next();
                Address addr = ins.getAddress();
                Function fn = getFunctionAt(addr);
                if (fn != null) {
                    w.write("\n; ------------------------------------------------------------\n");
                    w.write(addr + "  " + fn.getName() + ":\n");
                }
                else {
                    Symbol sym = currentProgram.getSymbolTable().getPrimarySymbol(addr);
                    if (sym != null) {
                        w.write(addr + "  " + sym.getName() + ":\n");
                    }
                }
                w.write(String.format("%-14s %-24s %s\n", addr, hexBytes(ins), ins));
                String eol = getEOLComment(addr);
                if (eol != null && !eol.isEmpty()) {
                    w.write("                ; " + eol.replace("\n", " ") + "\n");
                }
            }
        }
    }

    private int writeStrings() throws Exception {
        File file = new File(OUT_DIR, "strings.txt");
        int count = 0;
        try (BufferedWriter w = writer(file)) {
            DataIterator it = currentProgram.getListing().getDefinedData(true);
            while (it.hasNext()) {
                Data data = it.next();
                if (!data.hasStringValue()) {
                    continue;
                }
                Object value = data.getValue();
                w.write(data.getAddress() + "\t" + (value == null ? "" : value.toString()) + "\n");
                count++;
            }
        }
        return count;
    }

    private int writeInterrupts() throws Exception {
        File file = new File(OUT_DIR, "interrupts.txt");
        int count = 0;
        try (BufferedWriter w = writer(file)) {
            w.write("address\tinstruction\n");
            InstructionIterator it = currentProgram.getListing().getInstructions(true);
            while (it.hasNext()) {
                Instruction ins = it.next();
                String mnem = ins.getMnemonicString();
                if (!mnem.equalsIgnoreCase("INT")) {
                    continue;
                }
                w.write(ins.getAddress() + "\t" + ins + "\n");
                count++;
            }
        }
        return count;
    }

    private void writeFunctions() throws Exception {
        File file = new File(OUT_DIR, "functions.txt");
        try (BufferedWriter w = writer(file)) {
            w.write("address\tsize\txrefs\tname\n");
            FunctionIterator it = currentProgram.getFunctionManager().getFunctions(true);
            while (it.hasNext()) {
                Function fn = it.next();
                int xrefs = currentProgram.getReferenceManager().getReferenceCountTo(fn.getEntryPoint());
                long size = fn.getBody().getNumAddresses();
                w.write(fn.getEntryPoint() + "\t" + size + "\t" + xrefs + "\t" + fn.getName() + "\n");
            }
        }
    }

    private void writeDecompiled() throws Exception {
        File file = new File(OUT_DIR, "decompiled.c");
        DecompInterface decomp = new DecompInterface();
        try (BufferedWriter w = writer(file)) {
            w.write("/* Decompiled by Ghidra 12.2 from TREK28.COM (x86 real mode).\n");
            w.write(" * 16-bit DOS code. Types, segment overrides, and calling convention\n");
            w.write(" * are inferred. INT instructions stay as inline intrinsics or calls.\n");
            w.write(" */\n\n");
            DecompileOptions options = new DecompileOptions();
            decomp.setOptions(options);
            decomp.toggleCCode(true);
            decomp.toggleSyntaxTree(false);
            decomp.setSimplificationStyle("decompile");
            if (!decomp.openProgram(currentProgram)) {
                w.write("/* decompiler failed to open: " + decomp.getLastMessage() + " */\n");
                println("decompiler open failed: " + decomp.getLastMessage());
                return;
            }
            List<Function> functions = new ArrayList<>();
            FunctionIterator it = currentProgram.getFunctionManager().getFunctions(true);
            while (it.hasNext()) {
                functions.add(it.next());
            }
            int n = 0;
            for (Function fn : functions) {
                if (monitor.isCancelled()) {
                    break;
                }
                n++;
                if (n % 25 == 0) {
                    println("decompiled " + n + "/" + functions.size());
                }
                w.write("/* " + fn.getEntryPoint() + " " + fn.getName() + " */\n");
                try {
                    DecompileResults res = decomp.decompileFunction(fn, 8, monitor);
                    if (res != null && res.decompileCompleted() && res.getDecompiledFunction() != null) {
                        w.write(res.getDecompiledFunction().getC());
                        w.write("\n");
                    }
                    else {
                        String err = res == null ? "null result" : res.getErrorMessage();
                        w.write("/* decompile failed: " + err + " */\n\n");
                    }
                }
                catch (Exception e) {
                    w.write("/* decompile exception: " + e.getMessage() + " */\n\n");
                }
            }
            println("decompiled functions attempted " + n);
        }
        finally {
            decomp.dispose();
        }
    }

    private static BufferedWriter writer(File file) throws Exception {
        return new BufferedWriter(new OutputStreamWriter(
            Files.newOutputStream(file.toPath()), StandardCharsets.UTF_8));
    }

    private static String hexBytes(Instruction ins) throws Exception {
        byte[] bytes = ins.getBytes();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < bytes.length; i++) {
            if (i > 0) {
                sb.append(' ');
            }
            sb.append(String.format("%02x", bytes[i] & 0xff));
        }
        return sb.toString();
    }
}
