package trek

// Procedures 1000:666c through 1000:a93e.
// 1000:a800 is in draw.odin.
// The assembly is the listing. The body is empty until the procedure is translated.
// A notes line is a name already supported by the annotation notes.

// @proc 1000:666c
// listing: FUN_1000_666c
// status: unread
// 1000:666c  FUN_1000_666c:
// 1000:666c      88 44 14                 MOV byte ptr [SI + 0x14],AL
// 1000:666f      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
// 1000:6672      24 0f                    AND AL,0xf
// 1000:6674      0c b0                    OR AL,0xb0
// 1000:6676      88 44 0b                 MOV byte ptr [SI + 0xb],AL
// 1000:6679      c3                       RET
// 1000:667a      81 7c 08 10 27           CMP word ptr [SI + 0x8],0x2710
// 1000:667f      72 0c                    JC 0x1000:668d
// 1000:6681      80 7c 07 02              CMP byte ptr [SI + 0x7],0x2
// 1000:6685      72 06                    JC 0x1000:668d
// 1000:6687      80 7c 2a 03              CMP byte ptr [SI + 0x2a],0x3
// 1000:668b      73 0a                    JNC 0x1000:6697
// 1000:668d  LAB_1000_668d:
// 1000:668d      c7 44 24 b1 64           MOV word ptr [SI + 0x24],0x64b1
// 1000:6692      c6 44 11 00              MOV byte ptr [SI + 0x11],0x0
// 1000:6696      c3                       RET
// 1000:6697  LAB_1000_6697:
// 1000:6697      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
// 1000:669a      24 1f                    AND AL,0x1f
// 1000:669c      75 60                    JNZ 0x1000:66fe
// 1000:669e      f7 44 08 01 00           TEST word ptr [SI + 0x8],0x1
// 1000:66a3      b0 06                    MOV AL,0x6
// 1000:66a5      75 02                    JNZ 0x1000:66a9
// 1000:66a7      b0 07                    MOV AL,0x7
// 1000:66a9  LAB_1000_66a9:
// 1000:66a9      80 3e 74 a2 01           CMP byte ptr [0xa274],0x1
// 1000:66ae      74 0b                    JZ 0x1000:66bb
// 1000:66b0      b0 06                    MOV AL,0x6
// 1000:66b2      80 3e 74 a2 02           CMP byte ptr [0xa274],0x2
// 1000:66b7      74 02                    JZ 0x1000:66bb
// 1000:66b9      b0 07                    MOV AL,0x7
// 1000:66bb  LAB_1000_66bb:
// 1000:66bb      f6 06 12 00 02           TEST byte ptr [0x12],0x2
// 1000:66c0      74 33                    JZ 0x1000:66f5
// 1000:66c2      8a 26 74 a2              MOV AH,byte ptr [0xa274]
// 1000:66c6      3a 64 05                 CMP AH,byte ptr [SI + 0x5]
// 1000:66c9      75 05                    JNZ 0x1000:66d0
// 1000:66cb      b0 0c                    MOV AL,0xc
// 1000:66cd      eb 26                    JMP 0x1000:66f5
// 1000:66d0  LAB_1000_66d0:
// 1000:66d0      50                       PUSH AX
// 1000:66d1      a0 74 a2                 MOV AL,[0xa274]
// 1000:66d4      50                       PUSH AX
// 1000:66d5      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
// 1000:66d8      a2 74 a2                 MOV [0xa274],AL
// 1000:66db      e8 f0 b7                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:66e6  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
// 1000:66e6  LAB_1000_66e6:
// 1000:66e6      58                       POP AX
// 1000:66e7      a2 74 a2                 MOV [0xa274],AL
// 1000:66ea      58                       POP AX
// 1000:66eb      8a 64 18                 MOV AH,byte ptr [SI + 0x18]
// 1000:66ee      3a 67 0c                 CMP AH,byte ptr [BX + 0xc]
// 1000:66f1      75 02                    JNZ 0x1000:66f5
// 1000:66f3      b0 0c                    MOV AL,0xc
// 1000:66f5  LAB_1000_66f5:
// 1000:66f5      88 44 11                 MOV byte ptr [SI + 0x11],AL
// 1000:66f8  LAB_1000_66f8:
// 1000:66f8      b0 05                    MOV AL,0x5
// 1000:66fa      e8 6f ff                 CALL 0x1000:666c
// 1000:66fd      c3                       RET
// 1000:66fe  LAB_1000_66fe:
// 1000:66fe      f6 44 11 80              TEST byte ptr [SI + 0x11],0x80
// 1000:6702      75 f4                    JNZ 0x1000:66f8
// 1000:6704      81 7c 12 40 1f           CMP word ptr [SI + 0x12],0x1f40
// 1000:6709      72 ed                    JC 0x1000:66f8
// 1000:670b      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
// 1000:670e      24 1f                    AND AL,0x1f
// 1000:6710      3c 0c                    CMP AL,0xc
// 1000:6712      75 03                    JNZ 0x1000:6717
// 1000:6714      e9 76 ff                 JMP 0x1000:668d
// 1000:6717  LAB_1000_6717:
// 1000:6717      3c 06                    CMP AL,0x6
// 1000:6719      b0 06                    MOV AL,0x6
// 1000:671b      75 02                    JNZ 0x1000:671f
// 1000:671d      b0 07                    MOV AL,0x7
// 1000:671f  LAB_1000_671f:
// 1000:671f      eb d4                    JMP 0x1000:66f5
fun_666c :: proc() {
}

// @proc 1000:6721
// listing: FUN_1000_6721
// status: unread
// 1000:6721  FUN_1000_6721:
// 1000:6721      f6 44 16 04              TEST byte ptr [SI + 0x16],0x4
// 1000:6725      74 12                    JZ 0x1000:6739
// 1000:6727      80 7c 2a 03              CMP byte ptr [SI + 0x2a],0x3
// 1000:672b      77 0c                    JA 0x1000:6739
// 1000:672d      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
// 1000:6730      24 0f                    AND AL,0xf
// 1000:6732      3c 03                    CMP AL,0x3
// 1000:6734      76 03                    JBE 0x1000:6739
// 1000:6736      fe 4c 0b                 DEC byte ptr [SI + 0xb]
// 1000:6739  LAB_1000_6739:
// 1000:6739      c3                       RET
fun_6721 :: proc() {
}

// @proc 1000:673a
// listing: FUN_1000_673a
// status: unread
// 1000:673a  FUN_1000_673a:
// 1000:673a      bb 00 00                 MOV BX,0x0
// 1000:673d      f6 44 16 42              TEST byte ptr [SI + 0x16],0x42
// 1000:6741      74 1b                    JZ 0x1000:675e
// 1000:6743      f6 44 16 40              TEST byte ptr [SI + 0x16],0x40
// 1000:6747      74 0b                    JZ 0x1000:6754
// 1000:6749      81 7c 08 f4 01           CMP word ptr [SI + 0x8],0x1f4
// 1000:674e      77 04                    JA 0x1000:6754
// 1000:6750      b3 5a                    MOV BL,0x5a
// 1000:6752      f9                       STC
// 1000:6753      c3                       RET
// 1000:6754  LAB_1000_6754:
// 1000:6754      81 7c 08 58 1b           CMP word ptr [SI + 0x8],0x1b58
// 1000:6759      77 03                    JA 0x1000:675e
// 1000:675b      eb 2b                    JMP 0x1000:6788
// 1000:675e  LAB_1000_675e:
// 1000:675e      80 7c 07 00              CMP byte ptr [SI + 0x7],0x0
// 1000:6762      74 2a                    JZ 0x1000:678e
// 1000:6764      f6 44 19 ff              TEST byte ptr [SI + 0x19],0xff
// 1000:6768      75 1e                    JNZ 0x1000:6788
// 1000:676a      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
// 1000:676d      24 1f                    AND AL,0x1f
// 1000:676f      3c 06                    CMP AL,0x6
// 1000:6771      75 07                    JNZ 0x1000:677a
// 1000:6773      81 7c 12 a0 0f           CMP word ptr [SI + 0x12],0xfa0
// 1000:6778      72 06                    JC 0x1000:6780
// 1000:677a  LAB_1000_677a:
// 1000:677a      f6 44 16 63              TEST byte ptr [SI + 0x16],0x63
// 1000:677e      74 0e                    JZ 0x1000:678e
// 1000:6780  LAB_1000_6780:
// 1000:6780      f6 44 15 ff              TEST byte ptr [SI + 0x15],0xff
// 1000:6784      75 02                    JNZ 0x1000:6788
// 1000:6786      b3 20                    MOV BL,0x20
// 1000:6788  LAB_1000_6788:
// 1000:6788      e8 62 00                 CALL 0x1000:67ed
// 1000:678b      eb 1b                    JMP 0x1000:67a8
// 1000:678e  LAB_1000_678e:
// 1000:678e      f6 44 19 ff              TEST byte ptr [SI + 0x19],0xff
// 1000:6792      75 f4                    JNZ 0x1000:6788
// 1000:6794      f6 44 16 50              TEST byte ptr [SI + 0x16],0x50
// 1000:6798      74 0b                    JZ 0x1000:67a5
// 1000:679a      f6 44 15 ff              TEST byte ptr [SI + 0x15],0xff
// 1000:679e      75 e8                    JNZ 0x1000:6788
// 1000:67a0      b3 50                    MOV BL,0x50
// 1000:67a2      eb 04                    JMP 0x1000:67a8
// 1000:67a5  LAB_1000_67a5:
// 1000:67a5      80 24 cf                 AND byte ptr [SI],0xcf
// 1000:67a8  LAB_1000_67a8:
// 1000:67a8      ba 50 00                 MOV DX,0x50
// 1000:67ab      b4 03                    MOV AH,0x3
// 1000:67ad      80 4c 29 02              OR byte ptr [SI + 0x29],0x2
// 1000:67b1      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
// 1000:67b4      3c 02                    CMP AL,0x2
// 1000:67b6      74 1d                    JZ 0x1000:67d5
// 1000:67b8      3c 03                    CMP AL,0x3
// 1000:67ba      74 19                    JZ 0x1000:67d5
// 1000:67bc      3c 0a                    CMP AL,0xa
// 1000:67be      74 15                    JZ 0x1000:67d5
// 1000:67c0      3c 0b                    CMP AL,0xb
// 1000:67c2      74 11                    JZ 0x1000:67d5
// 1000:67c4      80 64 29 fd              AND byte ptr [SI + 0x29],0xfd
// 1000:67c8      3c 09                    CMP AL,0x9
// 1000:67ca      74 09                    JZ 0x1000:67d5
// 1000:67cc      3c 06                    CMP AL,0x6
// 1000:67ce      75 17                    JNZ 0x1000:67e7
// 1000:67d0      ba fa 00                 MOV DX,0xfa
// 1000:67d3      b4 0f                    MOV AH,0xf
// 1000:67d5  LAB_1000_67d5:
// 1000:67d5      84 26 d2 89              TEST byte ptr [0x89d2],AH
// 1000:67d9      75 0c                    JNZ 0x1000:67e7
// 1000:67db      39 54 12                 CMP word ptr [SI + 0x12],DX
// 1000:67de      77 07                    JA 0x1000:67e7
// 1000:67e0      80 fb 00                 CMP BL,0x0
// 1000:67e3      75 02                    JNZ 0x1000:67e7
// 1000:67e5      b3 4d                    MOV BL,0x4d
// 1000:67e7  LAB_1000_67e7:
// 1000:67e7      23 db                    AND BX,BX
// 1000:67e9      74 01                    JZ 0x1000:67ec
// 1000:67eb      f9                       STC
// 1000:67ec  LAB_1000_67ec:
// 1000:67ec      c3                       RET
fun_673a :: proc() {
}

// @proc 1000:67ed
// listing: FUN_1000_67ed
// status: unread
// 1000:67ed  FUN_1000_67ed:
// 1000:67ed      80 7c 0f 01              CMP byte ptr [SI + 0xf],0x1
// 1000:67f1      72 03                    JC 0x1000:67f6
// 1000:67f3      80 0c 10                 OR byte ptr [SI],0x10
// 1000:67f6  LAB_1000_67f6:
// 1000:67f6      81 7d 08 30 75           CMP word ptr [DI + 0x8],0x7530
// 1000:67fb      77 03                    JA 0x1000:6800
// 1000:67fd      80 0c 20                 OR byte ptr [SI],0x20
// 1000:6800  LAB_1000_6800:
// 1000:6800      c3                       RET
fun_67ed :: proc() {
}

// @proc 1000:6801
// listing: FUN_1000_6801
// status: unread
// 1000:6801  FUN_1000_6801:
// 1000:6801      e8 21 ca                 CALL 0x1000:3225
// 1000:6804      51                       PUSH CX
// 1000:6805      b4 80                    MOV AH,0x80
// 1000:6807      8a 0e 74 a2              MOV CL,byte ptr [0xa274]
// 1000:680b      d2 ec                    SHR AH,CL
// 1000:680d      59                       POP CX
// 1000:680e      32 c0                    XOR AL,AL
// 1000:6810  LAB_1000_6810:
// 1000:6810      84 25                    TEST byte ptr [DI],AH
// 1000:6812      74 02                    JZ 0x1000:6816
// 1000:6814      fe c0                    INC AL
// 1000:6816  LAB_1000_6816:
// 1000:6816      83 c7 0b                 ADD DI,0xb
// 1000:6819      e2 f5                    LOOP 0x1000:6810
// 1000:681b      c3                       RET
// 1000:6820 int1c_timer is represented as its own procedure.
// 1000:684b int03_break is represented as its own procedure.
fun_6801 :: proc() {
}

// @proc 1000:6820
// listing: int1c_timer
// status: unread
// Named entry in the listing. Ghidra did not give it a function header.
// 1000:6820  int1c_timer:
// 1000:6820      fc                       CLD
// 1000:6821      50                       PUSH AX
// 1000:6822      53                       PUSH BX
// 1000:6823      51                       PUSH CX
// 1000:6824      52                       PUSH DX
// 1000:6825      56                       PUSH SI
// 1000:6826      57                       PUSH DI
// 1000:6827      55                       PUSH BP
// 1000:6828      1e                       PUSH DS
// 1000:6829      06                       PUSH ES
// 1000:682a      2e a1 00 00              MOV AX,CS:[0x0]
// 1000:682e      8e d8                    MOV DS,AX
// 1000:6830      8e c0                    MOV ES,AX
// 1000:6832      cc                       INT3
// 1000:6833      cd 01                    INT 0x1
// 1000:6835      e8 56 00                 CALL 0x1000:688e
// 1000:6838      e8 0e de                 CALL 0x1000:4649
// 1000:683b      e8 c5 00                 CALL 0x1000:6903
// 1000:683e      e8 2c 00                 CALL 0x1000:686d
// 1000:6841      07                       POP ES
// 1000:6842      1f                       POP DS
// 1000:6843      5d                       POP BP
// 1000:6844      5f                       POP DI
// 1000:6845      5e                       POP SI
// 1000:6846      5a                       POP DX
// 1000:6847      59                       POP CX
// 1000:6848      5b                       POP BX
// 1000:6849      58                       POP AX
// 1000:684a      cf                       IRET
int1c_timer :: proc() {
}

// @proc 1000:684b
// listing: int03_break
// notes: int03_tick
// status: unread
// Named entry in the listing. Ghidra did not give it a function header.
// 1000:684b  int03_break:
// 1000:684b      83 3e 55 a2 00           CMP word ptr [0xa255],0x0
// 1000:6850      74 04                    JZ 0x1000:6856
// 1000:6852      ff 0e 55 a2              DEC word ptr [0xa255]
// 1000:6856  LAB_1000_6856:
// 1000:6856      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
// 1000:685b      74 04                    JZ 0x1000:6861
// 1000:685d      fe 0e 54 a2              DEC byte ptr [0xa254]
// 1000:6861  LAB_1000_6861:
// 1000:6861      83 3e 57 a2 00           CMP word ptr [0xa257],0x0
// 1000:6866      74 04                    JZ 0x1000:686c
// 1000:6868      ff 0e 57 a2              DEC word ptr [0xa257]
// 1000:686c  LAB_1000_686c:
// 1000:686c      cf                       IRET
int03_break :: proc() {
}

// @proc 1000:686d
// listing: FUN_1000_686d
// status: unread
// 1000:686d  FUN_1000_686d:
// 1000:686d      06                       PUSH ES
// 1000:686e      bb 00 00                 MOV BX,0x0
// 1000:6871      8e c3                    MOV ES,BX
// 1000:6873      26 a0 17 04              MOV AL,ES:[0x417]
// 1000:6877      07                       POP ES
// 1000:6878      24 08                    AND AL,0x8
// 1000:687a      74 0c                    JZ 0x1000:6888
// 1000:687c      80 3e 66 a2 00           CMP byte ptr [0xa266],0x0
// 1000:6881      74 04                    JZ 0x1000:6887
// 1000:6883      fe 0e 66 a2              DEC byte ptr [0xa266]
// 1000:6887  LAB_1000_6887:
// 1000:6887      c3                       RET
// 1000:6888  LAB_1000_6888:
// 1000:6888      c6 06 66 a2 0c           MOV byte ptr [0xa266],0xc
// 1000:688d      c3                       RET
fun_686d :: proc() {
}

// @proc 1000:688e
// listing: FUN_1000_688e
// notes: sound_tick
// status: unread
// 1000:688e  FUN_1000_688e:
// 1000:688e      83 3e 5a a2 00           CMP word ptr [0xa25a],0x0
// 1000:6893      74 0a                    JZ 0x1000:689f
// 1000:6895      b8 00 03                 MOV AX,0x300
// 1000:6898      ff 0e 5a a2              DEC word ptr [0xa25a]
// 1000:689c      eb 49                    JMP 0x1000:68e7
// 1000:689f  LAB_1000_689f:
// 1000:689f      83 3e 62 a2 00           CMP word ptr [0xa262],0x0
// 1000:68a4      74 1c                    JZ 0x1000:68c2
// 1000:68a6      8b 1e 62 a2              MOV BX,word ptr [0xa262]
// 1000:68aa      8b 07                    MOV AX,word ptr [BX]
// 1000:68ac      83 06 62 a2 02           ADD word ptr [0xa262],0x2
// 1000:68b1      3d ff ff                 CMP AX,0xffff
// 1000:68b4      75 09                    JNZ 0x1000:68bf
// 1000:68b6      c7 06 62 a2 00 00        MOV word ptr [0xa262],0x0
// 1000:68bc      eb 3e                    JMP 0x1000:68fc
// 1000:68bf  LAB_1000_68bf:
// 1000:68bf      eb 26                    JMP 0x1000:68e7
// 1000:68c2  LAB_1000_68c2:
// 1000:68c2      83 3e 5c a2 00           CMP word ptr [0xa25c],0x0
// 1000:68c7      74 0a                    JZ 0x1000:68d3
// 1000:68c9      ff 0e 5c a2              DEC word ptr [0xa25c]
// 1000:68cd      b8 00 06                 MOV AX,0x600
// 1000:68d0      eb 15                    JMP 0x1000:68e7
// 1000:68d3  LAB_1000_68d3:
// 1000:68d3      83 3e 5e a2 00           CMP word ptr [0xa25e],0x0
// 1000:68d8      74 0a                    JZ 0x1000:68e4
// 1000:68da      ff 0e 5e a2              DEC word ptr [0xa25e]
// 1000:68de      b8 00 60                 MOV AX,0x6000
// 1000:68e1      eb 04                    JMP 0x1000:68e7
// 1000:68e4  LAB_1000_68e4:
// 1000:68e4      eb 16                    JMP 0x1000:68fc
// 1000:68e7  LAB_1000_68e7:
// 1000:68e7      e6 42                    OUT 0x42,AL
// 1000:68e9      8a c4                    MOV AL,AH
// 1000:68eb      eb 00                    JMP 0x1000:68ed
// 1000:68ed  LAB_1000_68ed:
// 1000:68ed      e6 42                    OUT 0x42,AL
// 1000:68ef      eb 00                    JMP 0x1000:68f1
// 1000:68f1  LAB_1000_68f1:
// 1000:68f1      e4 61                    IN AL,0x61
// 1000:68f3      24 fc                    AND AL,0xfc
// 1000:68f5      0a 06 14 00              OR AL,byte ptr [0x14]
// 1000:68f9      e6 61                    OUT 0x61,AL
// 1000:68fb      c3                       RET
// 1000:68fc  LAB_1000_68fc:
// 1000:68fc      e4 61                    IN AL,0x61
// 1000:68fe      24 fc                    AND AL,0xfc
// 1000:6900      e6 61                    OUT 0x61,AL
// 1000:6902      c3                       RET
fun_688e :: proc() {
}

// @proc 1000:6903
// listing: FUN_1000_6903
// notes: clock_tick
// status: unread
// 1000:6903  FUN_1000_6903:
// 1000:6903      f6 06 6c a2 80           TEST byte ptr [0xa26c],0x80
// 1000:6908      75 6d                    JNZ 0x1000:6977
// 1000:690a      80 3e 03 a2 01           CMP byte ptr [0xa203],0x1
// 1000:690f      75 66                    JNZ 0x1000:6977
// 1000:6911      fe 0e 04 a2              DEC byte ptr [0xa204]
// 1000:6915      75 60                    JNZ 0x1000:6977
// 1000:6917      c6 06 04 a2 12           MOV byte ptr [0xa204],0x12
// 1000:691c      fe 0e 05 a2              DEC byte ptr [0xa205]
// 1000:6920      75 09                    JNZ 0x1000:692b
// 1000:6922      fe 06 04 a2              INC byte ptr [0xa204]
// 1000:6926      c6 06 05 a2 05           MOV byte ptr [0xa205],0x5
// 1000:692b  LAB_1000_692b:
// 1000:692b      f6 06 12 00 01           TEST byte ptr [0x12],0x1
// 1000:6930      74 21                    JZ 0x1000:6953
// 1000:6932      fe 0e 06 a2              DEC byte ptr [0xa206]
// 1000:6936      79 3f                    JNS 0x1000:6977
// 1000:6938      c6 06 06 a2 3b           MOV byte ptr [0xa206],0x3b
// 1000:693d      fe 0e 07 a2              DEC byte ptr [0xa207]
// 1000:6941      79 34                    JNS 0x1000:6977
// 1000:6943      c6 06 07 a2 00           MOV byte ptr [0xa207],0x0
// 1000:6948      c6 06 06 a2 00           MOV byte ptr [0xa206],0x0
// 1000:694d      c6 06 03 a2 00           MOV byte ptr [0xa203],0x0
// 1000:6952      c3                       RET
// 1000:6953  LAB_1000_6953:
// 1000:6953      fe 06 06 a2              INC byte ptr [0xa206]
// 1000:6957      80 3e 06 a2 3c           CMP byte ptr [0xa206],0x3c
// 1000:695c      72 19                    JC 0x1000:6977
// 1000:695e      c6 06 06 a2 00           MOV byte ptr [0xa206],0x0
// 1000:6963      fe 06 07 a2              INC byte ptr [0xa207]
// 1000:6967      80 3e 07 a2 3c           CMP byte ptr [0xa207],0x3c
// 1000:696c      72 09                    JC 0x1000:6977
// 1000:696e      c6 06 07 a2 00           MOV byte ptr [0xa207],0x0
// 1000:6973      fe 06 08 a2              INC byte ptr [0xa208]
// 1000:6977  LAB_1000_6977:
// 1000:6977      c3                       RET
fun_6903 :: proc() {
}

// @proc 1000:6980
// listing: FUN_1000_6980
// notes: open_score_file
// status: unread
// 1000:6980  FUN_1000_6980:
// 1000:6980      c6 06 73 a2 00           MOV byte ptr [0xa273],0x0
// 1000:6985      f6 06 a9 a4 01           TEST byte ptr [0xa4a9],0x1
// 1000:698a      74 01                    JZ 0x1000:698d
// 1000:698c      c3                       RET
// 1000:698d  LAB_1000_698d:
// 1000:698d      b8 00 00                 MOV AX,0x0
// 1000:6990      8e c0                    MOV ES,AX
// 1000:6992      26 c7 06 90 00 0c 6a     MOV word ptr ES:[0x90],0x6a0c
// 1000:6999      26 8c 0e 92 00           MOV word ptr ES:[0x92],CS
// 1000:699e      8c d8                    MOV AX,DS
// 1000:69a0      8e c0                    MOV ES,AX
// 1000:69a2      ba a0 39                 MOV DX,0x39a0
// 1000:69a5      b8 02 3d                 MOV AX,0x3d02
// 1000:69a8      cd 21                    INT 0x21
// 1000:69aa      73 21                    JNC 0x1000:69cd
// 1000:69ac      ba a0 39                 MOV DX,0x39a0
// 1000:69af      b8 00 3c                 MOV AX,0x3c00
// 1000:69b2      b9 00 00                 MOV CX,0x0
// 1000:69b5      cd 21                    INT 0x21
// 1000:69b7      72 33                    JC 0x1000:69ec
// 1000:69b9      a3 ab a4                 MOV [0xa4ab],AX
// 1000:69bc      e8 8d 03                 CALL 0x1000:6d4c
// 1000:69bf      bf ad a4                 MOV DI,0xa4ad
// 1000:69c2      b9 00 02                 MOV CX,0x200
// 1000:69c5      b8 00 00                 MOV AX,0x0
// 1000:69c8      f3 aa                    STOSB.REP ES:DI
// 1000:69ca      e9 bf 02                 JMP 0x1000:6c8c
// 1000:69cd  LAB_1000_69cd:
// 1000:69cd      a3 ab a4                 MOV [0xa4ab],AX
// 1000:69d0      8b 1e ab a4              MOV BX,word ptr [0xa4ab]
// 1000:69d4      ba ad a4                 MOV DX,0xa4ad
// 1000:69d7      b9 00 02                 MOV CX,0x200
// 1000:69da      b4 3f                    MOV AH,0x3f
// 1000:69dc      cd 21                    INT 0x21
// 1000:69de      72 0c                    JC 0x1000:69ec
// 1000:69e0      80 3e 73 a2 00           CMP byte ptr [0xa273],0x0
// 1000:69e5      75 05                    JNZ 0x1000:69ec
// 1000:69e7      3d 00 02                 CMP AX,0x200
// 1000:69ea      74 06                    JZ 0x1000:69f2
// 1000:69ec  LAB_1000_69ec:
// 1000:69ec      c6 06 73 a2 01           MOV byte ptr [0xa273],0x1
// 1000:69f1      c3                       RET
// 1000:69f2  LAB_1000_69f2:
// 1000:69f2      80 0e a9 a4 01           OR byte ptr [0xa4a9],0x1
// 1000:69f7      bf ad a4                 MOV DI,0xa4ad
// 1000:69fa      8b 05                    MOV AX,word ptr [DI]
// 1000:69fc      3d 00 00                 CMP AX,0x0
// 1000:69ff      74 05                    JZ 0x1000:6a06
// 1000:6a01      c6 06 72 a2 01           MOV byte ptr [0xa272],0x1
// 1000:6a06  LAB_1000_6a06:
// 1000:6a06      e8 43 03                 CALL 0x1000:6d4c
// 1000:6a09      e9 91 02                 JMP 0x1000:6c9d
// 1000:6a0c int24_criterr is represented as its own procedure.
fun_6980 :: proc() {
}

// @proc 1000:6a0c
// listing: int24_criterr
// status: unread
// Named entry in the listing. Ghidra did not give it a function header.
// 1000:6a0c  int24_criterr:
// 1000:6a0c      fb                       STI
// 1000:6a0d      1e                       PUSH DS
// 1000:6a0e      06                       PUSH ES
// 1000:6a0f      53                       PUSH BX
// 1000:6a10      51                       PUSH CX
// 1000:6a11      52                       PUSH DX
// 1000:6a12      2e a1 00 00              MOV AX,CS:[0x0]
// 1000:6a16      8e d8                    MOV DS,AX
// 1000:6a18      8e c0                    MOV ES,AX
// 1000:6a1a      57                       PUSH DI
// 1000:6a1b      e8 dd ed                 CALL 0x1000:57fb
//                 ; inline script -> 1000:6a27  <c2><clear>    
// 1000:6a27  LAB_1000_6a27:
// 1000:6a27      58                       POP AX
// 1000:6a28      3c 00                    CMP AL,0x0
// 1000:6a2a      75 1e                    JNZ 0x1000:6a4a
// 1000:6a2c      e8 cc ed                 CALL 0x1000:57fb
//                 ; inline script -> 1000:6a47  <c2>WRITE PROTECTED DISK
// 1000:6a47  LAB_1000_6a47:
// 1000:6a47      eb 16                    JMP 0x1000:6a5f
// 1000:6a4a  LAB_1000_6a4a:
// 1000:6a4a      e8 ae ed                 CALL 0x1000:57fb
//                 ; inline script -> 1000:6a5f  <c2>DISK NOT READY
// 1000:6a5f  LAB_1000_6a5f:
// 1000:6a5f      e8 99 ed                 CALL 0x1000:57fb
//                 ; inline script -> 1000:6a99  <c2>  PLEASE CORRECT, THEN  HIT R TO RETRY OR Q TO QUIT
// 1000:6a99  LAB_1000_6a99:
// 1000:6a99      e8 a9 a0                 CALL 0x1000:0b45
// 1000:6a9c      75 fb                    JNZ 0x1000:6a99
// 1000:6a9e  LAB_1000_6a9e:
// 1000:6a9e      e8 a4 a0                 CALL 0x1000:0b45
// 1000:6aa1      74 fb                    JZ 0x1000:6a9e
// 1000:6aa3      3c 06                    CMP AL,0x6
// 1000:6aa5      75 02                    JNZ 0x1000:6aa9
// 1000:6aa7      eb f5                    JMP 0x1000:6a9e
// 1000:6aa9  LAB_1000_6aa9:
// 1000:6aa9      24 df                    AND AL,0xdf
// 1000:6aab      3c 51                    CMP AL,0x51
// 1000:6aad      74 0d                    JZ 0x1000:6abc
// 1000:6aaf      3c 52                    CMP AL,0x52
// 1000:6ab1      75 eb                    JNZ 0x1000:6a9e
// 1000:6ab3      5a                       POP DX
// 1000:6ab4      59                       POP CX
// 1000:6ab5      5b                       POP BX
// 1000:6ab6      07                       POP ES
// 1000:6ab7      1f                       POP DS
// 1000:6ab8      b8 01 00                 MOV AX,0x1
// 1000:6abb      cf                       IRET
// 1000:6abc  LAB_1000_6abc:
// 1000:6abc      83 c4 1c                 ADD SP,0x1c
// 1000:6abf      c6 06 73 a2 01           MOV byte ptr [0xa273],0x1
// 1000:6ac4      5d                       POP BP
// 1000:6ac5      1f                       POP DS
// 1000:6ac6      07                       POP ES
// 1000:6ac7      b8 99 99                 MOV AX,0x9999
// 1000:6aca      cf                       IRET
int24_criterr :: proc() {
}

// @proc 1000:6acb
// listing: FUN_1000_6acb
// status: unread
// 1000:6acb  FUN_1000_6acb:
// 1000:6acb      bb ad a4                 MOV BX,0xa4ad
// 1000:6ace      ff 07                    INC word ptr [BX]
// 1000:6ad0      83 2e 57 a2 64           SUB word ptr [0xa257],0x64
// 1000:6ad5      e8 45 00                 CALL 0x1000:6b1d
// 1000:6ad8      50                       PUSH AX
// 1000:6ad9      b9 24 00                 MOV CX,0x24
// 1000:6adc      bf c3 a4                 MOV DI,0xa4c3
// 1000:6adf  LAB_1000_6adf:
// 1000:6adf      be a3 a4                 MOV SI,0xa4a3
// 1000:6ae2      80 3d 00                 CMP byte ptr [DI],0x0
// 1000:6ae5      74 25                    JZ 0x1000:6b0c
// 1000:6ae7      51                       PUSH CX
// 1000:6ae8      b9 06 00                 MOV CX,0x6
// 1000:6aeb      57                       PUSH DI
// 1000:6aec      f3 a6                    CMPSB.REPE ES:DI,SI
// 1000:6aee      5f                       POP DI
// 1000:6aef      59                       POP CX
// 1000:6af0      74 07                    JZ 0x1000:6af9
// 1000:6af2      83 c7 0a                 ADD DI,0xa
// 1000:6af5      e2 e8                    LOOP 0x1000:6adf
// 1000:6af7      58                       POP AX
// 1000:6af8      c3                       RET
// 1000:6af9  LAB_1000_6af9:
// 1000:6af9      58                       POP AX
// 1000:6afa      a8 01                    TEST AL,0x1
// 1000:6afc      74 03                    JZ 0x1000:6b01
// 1000:6afe      ff 45 06                 INC word ptr [DI + 0x6]
// 1000:6b01  LAB_1000_6b01:
// 1000:6b01      a8 02                    TEST AL,0x2
// 1000:6b03      74 03                    JZ 0x1000:6b08
// 1000:6b05      ff 45 08                 INC word ptr [DI + 0x8]
// 1000:6b08  LAB_1000_6b08:
// 1000:6b08      e8 1c 02                 CALL 0x1000:6d27
// 1000:6b0b      c3                       RET
// 1000:6b0c  LAB_1000_6b0c:
// 1000:6b0c      57                       PUSH DI
// 1000:6b0d      b9 06 00                 MOV CX,0x6
// 1000:6b10      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:6b12      b9 04 00                 MOV CX,0x4
// 1000:6b15      32 c0                    XOR AL,AL
// 1000:6b17      f3 aa                    STOSB.REP ES:DI
// 1000:6b19      5f                       POP DI
// 1000:6b1a      eb dd                    JMP 0x1000:6af9
fun_6acb :: proc() {
}

// @proc 1000:6b1d
// listing: FUN_1000_6b1d
// status: unread
// 1000:6b1d  FUN_1000_6b1d:
// 1000:6b1d      80 3e 31 a2 6d           CMP byte ptr [0xa231],0x6d
// 1000:6b22      75 38                    JNZ 0x1000:6b5c
// 1000:6b24      8b 1e e6 89              MOV BX,word ptr [0x89e6]
// 1000:6b28      80 3e 3c a2 6d           CMP byte ptr [0xa23c],0x6d
// 1000:6b2d      b6 31                    MOV DH,0x31
// 1000:6b2f      75 1f                    JNZ 0x1000:6b50
// 1000:6b31      3b 1e e8 89              CMP BX,word ptr [0x89e8]
// 1000:6b35      73 04                    JNC 0x1000:6b3b
// 1000:6b37      8b 1e e8 89              MOV BX,word ptr [0x89e8]
// 1000:6b3b  LAB_1000_6b3b:
// 1000:6b3b      fe c6                    INC DH
// 1000:6b3d      80 3e 47 a2 6d           CMP byte ptr [0xa247],0x6d
// 1000:6b42      75 0c                    JNZ 0x1000:6b50
// 1000:6b44      fe c6                    INC DH
// 1000:6b46      3b 1e ea 89              CMP BX,word ptr [0x89ea]
// 1000:6b4a      73 04                    JNC 0x1000:6b50
// 1000:6b4c      8b 1e ec 89              MOV BX,word ptr [0x89ec]
// 1000:6b50  LAB_1000_6b50:
// 1000:6b50      a1 e4 89                 MOV AX,[0x89e4]
// 1000:6b53      3b c3                    CMP AX,BX
// 1000:6b55      b7 6d                    MOV BH,0x6d
// 1000:6b57      b5 65                    MOV CH,0x65
// 1000:6b59      eb 14                    JMP 0x1000:6b6f
// 1000:6b5c  LAB_1000_6b5c:
// 1000:6b5c      8a 3e 31 a2              MOV BH,byte ptr [0xa231]
// 1000:6b60      8a 2e 32 a2              MOV CH,byte ptr [0xa232]
// 1000:6b64      8a 36 33 a2              MOV DH,byte ptr [0xa233]
// 1000:6b68      a1 e4 89                 MOV AX,[0x89e4]
// 1000:6b6b      3b 06 e6 89              CMP AX,word ptr [0x89e6]
// 1000:6b6f  LAB_1000_6b6f:
// 1000:6b6f      b4 01                    MOV AH,0x1
// 1000:6b71      77 06                    JA 0x1000:6b79
// 1000:6b73      b4 02                    MOV AH,0x2
// 1000:6b75      72 02                    JC 0x1000:6b79
// 1000:6b77      fe c4                    INC AH
// 1000:6b79  LAB_1000_6b79:
// 1000:6b79      8a c4                    MOV AL,AH
// 1000:6b7b      be 26 a2                 MOV SI,0xa226
// 1000:6b7e      8a 1c                    MOV BL,byte ptr [SI]
// 1000:6b80      8a 4c 01                 MOV CL,byte ptr [SI + 0x1]
// 1000:6b83      8a 54 02                 MOV DL,byte ptr [SI + 0x2]
// 1000:6b86      3a df                    CMP BL,BH
// 1000:6b88      77 12                    JA 0x1000:6b9c
// 1000:6b8a      72 23                    JC 0x1000:6baf
// 1000:6b8c      3a cd                    CMP CL,CH
// 1000:6b8e      77 0c                    JA 0x1000:6b9c
// 1000:6b90      72 1d                    JC 0x1000:6baf
// 1000:6b92      3a d6                    CMP DL,DH
// 1000:6b94      77 06                    JA 0x1000:6b9c
// 1000:6b96      72 17                    JC 0x1000:6baf
// 1000:6b98      f9                       STC
// 1000:6b99      eb 14                    JMP 0x1000:6baf
// 1000:6b9c  LAB_1000_6b9c:
// 1000:6b9c      8a e0                    MOV AH,AL
// 1000:6b9e      24 01                    AND AL,0x1
// 1000:6ba0      80 e4 02                 AND AH,0x2
// 1000:6ba3      d0 e0                    SHL AL,0x1
// 1000:6ba5      d0 ec                    SHR AH,0x1
// 1000:6ba7      0a c4                    OR AL,AH
// 1000:6ba9      86 df                    XCHG BH,BL
// 1000:6bab      86 cd                    XCHG CH,CL
// 1000:6bad      86 d6                    XCHG DH,DL
// 1000:6baf  LAB_1000_6baf:
// 1000:6baf      bf a3 a4                 MOV DI,0xa4a3
// 1000:6bb2      88 1d                    MOV byte ptr [DI],BL
// 1000:6bb4      88 4d 01                 MOV byte ptr [DI + 0x1],CL
// 1000:6bb7      88 55 02                 MOV byte ptr [DI + 0x2],DL
// 1000:6bba      88 7d 03                 MOV byte ptr [DI + 0x3],BH
// 1000:6bbd      88 6d 04                 MOV byte ptr [DI + 0x4],CH
// 1000:6bc0      88 75 05                 MOV byte ptr [DI + 0x5],DH
// 1000:6bc3      f8                       CLC
// 1000:6bc4      c3                       RET
fun_6b1d :: proc() {
}

// @proc 1000:6bc5
// listing: FUN_1000_6bc5
// notes: show_statistics
// status: unread
// 1000:6bc5  FUN_1000_6bc5:
// 1000:6bc5      e8 33 ec                 CALL 0x1000:57fb
//                 ; inline script -> 1000:6be8  <c3><clear>    TREK RECORD  <c1>(# GAMES 
// 1000:6be8  LAB_1000_6be8:
// 1000:6be8      bb ad a4                 MOV BX,0xa4ad
// 1000:6beb      8b 07                    MOV AX,word ptr [BX]
// 1000:6bed      e8 25 e8                 CALL 0x1000:5415
// 1000:6bf0      e8 08 ec                 CALL 0x1000:57fb
//                 ; inline script -> 1000:6bfb  <c1>)   
// 1000:6bfb  LAB_1000_6bfb:
// 1000:6bfb      be c3 a4                 MOV SI,0xa4c3
// 1000:6bfe      b9 12 00                 MOV CX,0x12
// 1000:6c01  LAB_1000_6c01:
// 1000:6c01      51                       PUSH CX
// 1000:6c02      e8 a9 00                 CALL 0x1000:6cae
// 1000:6c05      e8 f3 eb                 CALL 0x1000:57fb
//                 ; inline script -> 1000:6c0f  <c1>  
// 1000:6c0f  LAB_1000_6c0f:
// 1000:6c0f      e8 9c 00                 CALL 0x1000:6cae
// 1000:6c12      e8 e6 eb                 CALL 0x1000:57fb
//                 ; inline script -> 1000:6c1b  <c1>  
// 1000:6c1b  LAB_1000_6c1b:
// 1000:6c1b      59                       POP CX
// 1000:6c1c      e2 e3                    LOOP 0x1000:6c01
// 1000:6c1e      e8 da eb                 CALL 0x1000:57fb
//                 ; inline script -> 1000:6c46  <c3><box>    HIT Esc FOR PRIMARY MENU
// 1000:6c46  LAB_1000_6c46:
// 1000:6c46      e8 fc 9e                 CALL 0x1000:0b45
// 1000:6c49      74 fb                    JZ 0x1000:6c46
// 1000:6c4b      3c 06                    CMP AL,0x6
// 1000:6c4d      74 3a                    JZ 0x1000:6c89
// 1000:6c4f      24 df                    AND AL,0xdf
// 1000:6c51      3c 5a                    CMP AL,0x5a
// 1000:6c53      75 f1                    JNZ 0x1000:6c46
// 1000:6c55  LAB_1000_6c55:
// 1000:6c55      e8 ed 9e                 CALL 0x1000:0b45
// 1000:6c58      74 fb                    JZ 0x1000:6c55
// 1000:6c5a      3c 06                    CMP AL,0x6
// 1000:6c5c      74 2b                    JZ 0x1000:6c89
// 1000:6c5e      24 df                    AND AL,0xdf
// 1000:6c60      3c 41                    CMP AL,0x41
// 1000:6c62      75 e2                    JNZ 0x1000:6c46
// 1000:6c64  LAB_1000_6c64:
// 1000:6c64      e8 de 9e                 CALL 0x1000:0b45
// 1000:6c67      74 fb                    JZ 0x1000:6c64
// 1000:6c69      3c 06                    CMP AL,0x6
// 1000:6c6b      74 1c                    JZ 0x1000:6c89
// 1000:6c6d      24 df                    AND AL,0xdf
// 1000:6c6f      3c 50                    CMP AL,0x50
// 1000:6c71      75 d3                    JNZ 0x1000:6c46
// 1000:6c73      bf ad a4                 MOV DI,0xa4ad
// 1000:6c76      33 c0                    XOR AX,AX
// 1000:6c78      ab                       STOSW ES:DI
// 1000:6c79      83 c7 0e                 ADD DI,0xe
// 1000:6c7c      b9 68 01                 MOV CX,0x168
// 1000:6c7f      b0 00                    MOV AL,0x0
// 1000:6c81      f3 aa                    STOSB.REP ES:DI
// 1000:6c83      e8 a1 00                 CALL 0x1000:6d27
// 1000:6c86      e9 dd 94                 JMP 0x1000:0166
// 1000:6c89  LAB_1000_6c89:
// 1000:6c89      e9 39 ff                 JMP 0x1000:6bc5
fun_6bc5 :: proc() {
}

// @proc 1000:6c8c
// listing: FUN_1000_6c8c
// notes: save_settings
// status: unread
// 1000:6c8c  FUN_1000_6c8c:
// 1000:6c8c      bf af a4                 MOV DI,0xa4af
// 1000:6c8f      be 07 00                 MOV SI,0x7
// 1000:6c92      b9 14 00                 MOV CX,0x14
// 1000:6c95      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:6c97      e8 8d 00                 CALL 0x1000:6d27
// 1000:6c9a      e9 c9 94                 JMP 0x1000:0166
fun_6c8c :: proc() {
}

// @proc 1000:6c9d
// listing: FUN_1000_6c9d
// notes: load_settings
// status: unread
// 1000:6c9d  FUN_1000_6c9d:
// 1000:6c9d      be af a4                 MOV SI,0xa4af
// 1000:6ca0      bf 07 00                 MOV DI,0x7
// 1000:6ca3      b9 14 00                 MOV CX,0x14
// 1000:6ca6      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:6ca8      c6 06 67 a2 05           MOV byte ptr [0xa267],0x5
// 1000:6cad      c3                       RET
fun_6c9d :: proc() {
}

// @proc 1000:6cae
// listing: FUN_1000_6cae
// notes: print_score_row
// status: unread
// 1000:6cae  FUN_1000_6cae:
// 1000:6cae      8a 04                    MOV AL,byte ptr [SI]
// 1000:6cb0      22 c0                    AND AL,AL
// 1000:6cb2      74 41                    JZ 0x1000:6cf5
// 1000:6cb4      e8 58 00                 CALL 0x1000:6d0f
// 1000:6cb7      8a 44 01                 MOV AL,byte ptr [SI + 0x1]
// 1000:6cba      e8 52 00                 CALL 0x1000:6d0f
// 1000:6cbd      8a 44 02                 MOV AL,byte ptr [SI + 0x2]
// 1000:6cc0      e8 4c 00                 CALL 0x1000:6d0f
// 1000:6cc3      8b 44 06                 MOV AX,word ptr [SI + 0x6]
// 1000:6cc6      56                       PUSH SI
// 1000:6cc7      e8 4b e7                 CALL 0x1000:5415
// 1000:6cca      e8 2e eb                 CALL 0x1000:57fb
//                 ; inline script -> 1000:6cd5  <c1> vs 
// 1000:6cd5  LAB_1000_6cd5:
// 1000:6cd5      5e                       POP SI
// 1000:6cd6      8a 44 03                 MOV AL,byte ptr [SI + 0x3]
// 1000:6cd9      e8 33 00                 CALL 0x1000:6d0f
// 1000:6cdc      8a 44 04                 MOV AL,byte ptr [SI + 0x4]
// 1000:6cdf      e8 2d 00                 CALL 0x1000:6d0f
// 1000:6ce2      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
// 1000:6ce5      e8 27 00                 CALL 0x1000:6d0f
// 1000:6ce8      8b 44 08                 MOV AX,word ptr [SI + 0x8]
// 1000:6ceb      56                       PUSH SI
// 1000:6cec      e8 26 e7                 CALL 0x1000:5415
// 1000:6cef      5e                       POP SI
// 1000:6cf0      83 c6 0a                 ADD SI,0xa
// 1000:6cf3      f8                       CLC
// 1000:6cf4      c3                       RET
// 1000:6cf5  LAB_1000_6cf5:
// 1000:6cf5      e8 03 eb                 CALL 0x1000:57fb
//                 ; inline script -> 1000:6d0e  <c1>                  
// 1000:6d0e  LAB_1000_6d0e:
// 1000:6d0e      c3                       RET
fun_6cae :: proc() {
}

// @proc 1000:6d0f
// listing: FUN_1000_6d0f
// status: unread
// 1000:6d0f  FUN_1000_6d0f:
// 1000:6d0f      56                       PUSH SI
// 1000:6d10      b4 01                    MOV AH,0x1
// 1000:6d12      e8 66 e8                 CALL 0x1000:557b
// 1000:6d15      5e                       POP SI
// 1000:6d16      c3                       RET
fun_6d0f :: proc() {
}

// @proc 1000:6d17
// listing: FUN_1000_6d17
// status: unread
// 1000:6d17  FUN_1000_6d17:
// 1000:6d17      c7 06 55 a2 b4 00        MOV word ptr [0xa255],0xb4
// 1000:6d1d  LAB_1000_6d1d:
// 1000:6d1d      83 3e 55 a2 00           CMP word ptr [0xa255],0x0
// 1000:6d22      75 f9                    JNZ 0x1000:6d1d
// 1000:6d24      e9 6f 97                 JMP 0x1000:0496
fun_6d17 :: proc() {
}

// @proc 1000:6d27
// listing: FUN_1000_6d27
// notes: write_score_file
// status: unread
// 1000:6d27  FUN_1000_6d27:
// 1000:6d27      ba a0 39                 MOV DX,0x39a0
// 1000:6d2a      b8 02 3d                 MOV AX,0x3d02
// 1000:6d2d      cd 21                    INT 0x21
// 1000:6d2f      a3 ab a4                 MOV [0xa4ab],AX
// 1000:6d32      8b d8                    MOV BX,AX
// 1000:6d34      ba ad a4                 MOV DX,0xa4ad
// 1000:6d37      b9 00 02                 MOV CX,0x200
// 1000:6d3a      b4 40                    MOV AH,0x40
// 1000:6d3c      cd 21                    INT 0x21
// 1000:6d3e      8b 1e ab a4              MOV BX,word ptr [0xa4ab]
// 1000:6d42      ba ad a4                 MOV DX,0xa4ad
// 1000:6d45      b9 00 00                 MOV CX,0x0
// 1000:6d48      b4 40                    MOV AH,0x40
// 1000:6d4a      cd 21                    INT 0x21
fun_6d27 :: proc() {
}

// @proc 1000:6d4c
// listing: FUN_1000_6d4c
// status: unread
// 1000:6d4c  FUN_1000_6d4c:
// 1000:6d4c      8b 1e ab a4              MOV BX,word ptr [0xa4ab]
// 1000:6d50      b4 3e                    MOV AH,0x3e
// 1000:6d52      cd 21                    INT 0x21
// 1000:6d54      c3                       RET
// 1000:6d60      2e 8e 1e 00 00           MOV DS,word ptr CS:[0x0]
// 1000:6d65      a0 12 00                 MOV AL,[0x12]
// 1000:6d68      a2 b0 39                 MOV [0x39b0],AL
// 1000:6d6b      c6 06 b1 39 02           MOV byte ptr [0x39b1],0x2
// 1000:6d70      c6 06 08 a2 00           MOV byte ptr [0xa208],0x0
// 1000:6d75      c6 06 07 a2 00           MOV byte ptr [0xa207],0x0
// 1000:6d7a      c6 06 06 a2 00           MOV byte ptr [0xa206],0x0
// 1000:6d7f      c6 06 03 a2 01           MOV byte ptr [0xa203],0x1
// 1000:6d84      c6 06 74 a2 00           MOV byte ptr [0xa274],0x0
// 1000:6d89      c6 06 70 a2 01           MOV byte ptr [0xa270],0x1
// 1000:6d8e      c7 06 d0 89 00 00        MOV word ptr [0x89d0],0x0
// 1000:6d94      c6 06 71 a2 01           MOV byte ptr [0xa271],0x1
// 1000:6d99      c6 06 31 a2 6d           MOV byte ptr [0xa231],0x6d
// 1000:6d9e      c6 06 32 a2 65           MOV byte ptr [0xa232],0x65
// 1000:6da3      c6 06 33 a2 31           MOV byte ptr [0xa233],0x31
// 1000:6da8      c6 06 35 a2 01           MOV byte ptr [0xa235],0x1
// 1000:6dad      c6 06 26 a2 43           MOV byte ptr [0xa226],0x43
// 1000:6db2      c6 06 27 a2 42           MOV byte ptr [0xa227],0x42
// 1000:6db7      c6 06 28 a2 4d           MOV byte ptr [0xa228],0x4d
// 1000:6dbc      c6 06 2a a2 01           MOV byte ptr [0xa22a],0x1
// 1000:6dc1      e8 0d d2                 CALL 0x1000:3fd1
// 1000:6dc4      c6 06 dc 89 0a           MOV byte ptr [0x89dc],0xa
// 1000:6dc9      c6 06 dd 89 0a           MOV byte ptr [0x89dd],0xa
// 1000:6dce      c6 06 74 a2 00           MOV byte ptr [0xa274],0x0
// 1000:6dd3      b1 00                    MOV CL,0x0
// 1000:6dd5      bf 64 8c                 MOV DI,0x8c64
// 1000:6dd8  LAB_1000_6dd8:
// 1000:6dd8      51                       PUSH CX
// 1000:6dd9      e8 7d d6                 CALL 0x1000:4459
// 1000:6ddc      59                       POP CX
// 1000:6ddd      fe c1                    INC CL
// 1000:6ddf      83 c7 3b                 ADD DI,0x3b
// 1000:6de2      80 f9 04                 CMP CL,0x4
// 1000:6de5      72 f1                    JC 0x1000:6dd8
// 1000:6de7      c6 06 74 a2 01           MOV byte ptr [0xa274],0x1
// 1000:6dec      b1 00                    MOV CL,0x0
// 1000:6dee  LAB_1000_6dee:
// 1000:6dee      51                       PUSH CX
// 1000:6def      e8 67 d6                 CALL 0x1000:4459
// 1000:6df2      59                       POP CX
// 1000:6df3      fe c1                    INC CL
// 1000:6df5      80 f9 04                 CMP CL,0x4
// 1000:6df8      72 f4                    JC 0x1000:6dee
// 1000:6dfa      c6 06 74 a2 00           MOV byte ptr [0xa274],0x0
// 1000:6dff      b9 0a 00                 MOV CX,0xa
// 1000:6e02  LAB_1000_6e02:
// 1000:6e02      51                       PUSH CX
// 1000:6e03      e8 a6 c9                 CALL 0x1000:37ac
// 1000:6e06      59                       POP CX
// 1000:6e07      e2 f9                    LOOP 0x1000:6e02
// 1000:6e09      c6 06 6f a2 00           MOV byte ptr [0xa26f],0x0
// 1000:6e0e      c6 06 d4 89 40           MOV byte ptr [0x89d4],0x40
// 1000:6e13      be 64 8c                 MOV SI,0x8c64
// 1000:6e16      c6 44 0a 20              MOV byte ptr [SI + 0xa],0x20
// 1000:6e1a      c6 44 0b 20              MOV byte ptr [SI + 0xb],0x20
// 1000:6e1e      c6 44 06 05              MOV byte ptr [SI + 0x6],0x5
// 1000:6e22      c6 44 07 0a              MOV byte ptr [SI + 0x7],0xa
// 1000:6e26      c6 44 0f 0a              MOV byte ptr [SI + 0xf],0xa
// 1000:6e2a      80 0c 35                 OR byte ptr [SI],0x35
// 1000:6e2d      c6 44 2a 0a              MOV byte ptr [SI + 0x2a],0xa
// 1000:6e31      c6 44 11 81              MOV byte ptr [SI + 0x11],0x81
// 1000:6e35      c7 44 12 a2 02           MOV word ptr [SI + 0x12],0x2a2
// 1000:6e3a      c6 44 16 08              MOV byte ptr [SI + 0x16],0x8
// 1000:6e3e      b9 07 00                 MOV CX,0x7
// 1000:6e41  LAB_1000_6e41:
// 1000:6e41      83 c6 3b                 ADD SI,0x3b
// 1000:6e44      80 0c 04                 OR byte ptr [SI],0x4
// 1000:6e47      e2 f8                    LOOP 0x1000:6e41
// 1000:6e49      be ad 6e                 MOV SI,0x6ead
// 1000:6e4c  LAB_1000_6e4c:
// 1000:6e4c      56                       PUSH SI
// 1000:6e4d      fe 06 d2 89              INC byte ptr [0x89d2]
// 1000:6e51      2e ff 14                 CALL word ptr CS:[SI]
// 1000:6e54      73 03                    JNC 0x1000:6e59
// 1000:6e56      58                       POP AX
// 1000:6e57      eb f3                    JMP 0x1000:6e4c
// 1000:6e59  LAB_1000_6e59:
// 1000:6e59      a0 b0 39                 MOV AL,[0x39b0]
// 1000:6e5c      a2 12 00                 MOV [0x12],AL
// 1000:6e5f      e8 e3 9c                 CALL 0x1000:0b45
// 1000:6e62      c6 06 6c a2 00           MOV byte ptr [0xa26c],0x0
// 1000:6e67      8a 26 b1 39              MOV AH,byte ptr [0x39b1]
// 1000:6e6b      88 26 12 00              MOV byte ptr [0x12],AH
// 1000:6e6f      5e                       POP SI
// 1000:6e70      74 da                    JZ 0x1000:6e4c
// 1000:6e72      3c 06                    CMP AL,0x6
// 1000:6e74      74 d6                    JZ 0x1000:6e4c
// 1000:6e76      3c c9                    CMP AL,0xc9
// 1000:6e78      74 08                    JZ 0x1000:6e82
// 1000:6e7a      3c 2d                    CMP AL,0x2d
// 1000:6e7c      74 04                    JZ 0x1000:6e82
// 1000:6e7e      3c c8                    CMP AL,0xc8
// 1000:6e80      75 0b                    JNZ 0x1000:6e8d
// 1000:6e82  LAB_1000_6e82:
// 1000:6e82      81 fe ad 6e              CMP SI,0x6ead
// 1000:6e86      74 1d                    JZ 0x1000:6ea5
// 1000:6e88      83 ee 02                 SUB SI,0x2
// 1000:6e8b      eb bf                    JMP 0x1000:6e4c
// 1000:6e8d  LAB_1000_6e8d:
// 1000:6e8d      3c d1                    CMP AL,0xd1
// 1000:6e8f      74 08                    JZ 0x1000:6e99
// 1000:6e91      3c 2b                    CMP AL,0x2b
// 1000:6e93      74 04                    JZ 0x1000:6e99
// 1000:6e95      3c d0                    CMP AL,0xd0
// 1000:6e97      75 0c                    JNZ 0x1000:6ea5
// 1000:6e99  LAB_1000_6e99:
// 1000:6e99      2e 83 7c 02 00           CMP word ptr CS:[SI + 0x2],0x0
// 1000:6e9e      74 05                    JZ 0x1000:6ea5
// 1000:6ea0      83 c6 02                 ADD SI,0x2
// 1000:6ea3      eb a7                    JMP 0x1000:6e4c
// 1000:6ea5  LAB_1000_6ea5:
// 1000:6ea5      56                       PUSH SI
// 1000:6ea6      e8 56 ea                 CALL 0x1000:58ff
// 1000:6ea9      5e                       POP SI
// 1000:6eaa      eb a0                    JMP 0x1000:6e4c
fun_6d4c :: proc() {
}

// @proc 1000:6f19
// listing: FUN_1000_6f19
// status: unread
// 1000:6f19  FUN_1000_6f19:
// 1000:6f19      c6 06 d4 89 40           MOV byte ptr [0x89d4],0x40
// 1000:6f1e      c6 06 b1 39 02           MOV byte ptr [0x39b1],0x2
// 1000:6f23      e8 d5 e8                 CALL 0x1000:57fb
//                 ; inline script -> 1000:6fb7  <c3><clear>                INSTRUCTIONS   <c1>    USE PgUp AND PgDn KEYS TO SCAN.       PRINT FILE "TREKCMDS" TO GET A      SUMMARY OF ALL THE COMMANDS.  
// 1000:6fb7  LAB_1000_6fb7:
// 1000:6fb7      80 3e 72 a2 01           CMP byte ptr [0xa272],0x1
// 1000:6fbc      75 09                    JNZ 0x1000:6fc7
// 1000:6fbe      e8 3a e8                 CALL 0x1000:57fb
//                 ; inline script -> 1000:6fc5  <c3>
// 1000:6fc5  LAB_1000_6fc5:
// 1000:6fc5      f8                       CLC
// 1000:6fc6      c3                       RET
// 1000:6fc7  LAB_1000_6fc7:
// 1000:6fc7      e8 31 e8                 CALL 0x1000:57fb
//                 ; inline script -> 1000:7077  <c2>SINCE THIS IS YOUR FIRST TIME,  IT IS A REQUIREMENT THAT YOU  READ ALL THE INSTRUCTIONS VERY  CAREFULLY.  THE GAME WILL NOT  START UNTIL I AM SURE YOU KNOW 
// 1000:7077  LAB_1000_7077:
// 1000:7077      f8                       CLC
// 1000:7078      c3                       RET
fun_6f19 :: proc() {
}

// @proc 1000:7079
// listing: FUN_1000_7079
// status: unread
// 1000:7079  FUN_1000_7079:
// 1000:7079      e8 7f e7                 CALL 0x1000:57fb
//                 ; inline script -> 1000:738b  <c2><clear>              GAME HISTORY   <c1>     TREK ORIGINATED ABOUT SIX YEARS  AGO AS A Z80 BASED, HARDWARE INDEPENDENT  GAME.  THE ORIGINAL GOAL WAS TO DESI
// 1000:738b  LAB_1000_738b:
// 1000:738b      f8                       CLC
// 1000:738c      c3                       RET
// 1000:738d      e8 6b e4                 CALL 0x1000:57fb
//                 ; inline script -> 1000:75aa  <c2><clear>              GAME UPDATES   <c1>    IF YOU WOULD LIKE TO RECEIVE THE  LATEST LEVEL OF TREK, PLEASE SEND $10.00  WITH YOUR NAME, ADDRESS, (AND PHONE 
// 1000:75aa  LAB_1000_75aa:
// 1000:75aa      f8                       CLC
// 1000:75ab      c3                       RET
// 1000:75ac      e8 4c e2                 CALL 0x1000:57fb
//                 ; inline script -> 1000:7741  <c2><clear>         UPDATE HISTORY   <c1>TREK23 - OCT 30,1985           INITIAL PUBLIC RELEASE  TREK24 - NOT RELEASED TO PUBLIC  TREK25 - AUG 10,1986           
// 1000:7741  LAB_1000_7741:
// 1000:7741      f8                       CLC
// 1000:7742      c3                       RET
// 1000:7743      e8 b5 e0                 CALL 0x1000:57fb
//                 ; inline script -> 1000:79c1  <c2><clear>            GAME DESCRIPTION   <c1>  EACH PLAYER STARTS WITH A STARBASE AND  UP TO TWELVE STARSHIPS, DEPENDING ON THE  HANDICAP LEVEL SELECTED.  EACH
// 1000:79c1  LAB_1000_79c1:
// 1000:79c1      f8                       CLC
// 1000:79c2      c3                       RET
// 1000:79c3      e8 35 de                 CALL 0x1000:57fb
//                 ; inline script -> 1000:7b7b  <c3><clear>            SHIPS AND BASES      <c1>   YOUR STARSHIPS    <c2>  ENEMY STARSHIPS      <c1>   YOUR STARBASE     <c2>  ENEMY STARBASE  <c3>-------------
// 1000:7b7b  LAB_1000_7b7b:
// 1000:7b7b      a0 d2 89                 MOV AL,[0x89d2]
// 1000:7b7e      24 03                    AND AL,0x3
// 1000:7b80      75 17                    JNZ 0x1000:7b99
// 1000:7b82      e8 76 dc                 CALL 0x1000:57fb
//                 ; inline script -> 1000:7b97  <c3><pic><pic>
// 1000:7b97  LAB_1000_7b97:
// 1000:7b97      f8                       CLC
// 1000:7b98      c3                       RET
// 1000:7b99  LAB_1000_7b99:
// 1000:7b99      fe c8                    DEC AL
// 1000:7b9b      75 17                    JNZ 0x1000:7bb4
// 1000:7b9d      e8 5b dc                 CALL 0x1000:57fb
//                 ; inline script -> 1000:7bb2  <c3><pic><pic>
// 1000:7bb2  LAB_1000_7bb2:
// 1000:7bb2      f8                       CLC
// 1000:7bb3      c3                       RET
// 1000:7bb4  LAB_1000_7bb4:
// 1000:7bb4      fe c8                    DEC AL
// 1000:7bb6      75 17                    JNZ 0x1000:7bcf
// 1000:7bb8      e8 40 dc                 CALL 0x1000:57fb
//                 ; inline script -> 1000:7bcd  <c3><pic><pic>
// 1000:7bcd  LAB_1000_7bcd:
// 1000:7bcd      f8                       CLC
// 1000:7bce      c3                       RET
// 1000:7bcf  LAB_1000_7bcf:
// 1000:7bcf      e8 29 dc                 CALL 0x1000:57fb
//                 ; inline script -> 1000:7be4  <c3><pic><pic>
// 1000:7be4  LAB_1000_7be4:
// 1000:7be4      f8                       CLC
// 1000:7be5      c3                       RET
// 1000:7be6      e8 12 dc                 CALL 0x1000:57fb
//                 ; inline script -> 1000:7dd9  <c3><clear>                PLANETS   <c1>       ENERGY (UP TO 15,000 UNITS)          TORPEDO (UP TO 10 TORPEDOES)          DOCK (TRANSPORTS SHIP TO BASE)       
// 1000:7dd9  LAB_1000_7dd9:
// 1000:7dd9      f8                       CLC
// 1000:7dda      c3                       RET
// 1000:7ddb      e8 1d da                 CALL 0x1000:57fb
//                 ; inline script -> 1000:7feb  <c3><clear>                 FLAGS   <c1>EACH SHIP GETS ONE FLAG TO MARK ONE  PLANET.  ONCE A PLANET IS FLAGGED, IT  CAN ONLY BE USED BY YOU.  IT IS STILL  VISIB
// 1000:7feb  LAB_1000_7feb:
// 1000:7feb      f8                       CLC
// 1000:7fec      c3                       RET
// 1000:7fed      e8 0b d8                 CALL 0x1000:57fb
//                 ; inline script -> 1000:8294  <c3><clear>                STARS   <c1>       NORMAL STAR (DRAINS SHIP ENERGY,              BEST TO AVOID IF POSSIBLE)         NOVA STAR (READY TO EXPLODE,     
// 1000:8294  LAB_1000_8294:
// 1000:8294      f8                       CLC
// 1000:8295      c3                       RET
// 1000:8296      e8 62 d5                 CALL 0x1000:57fb
//                 ; inline script -> 1000:8594  <c3><clear>    OTHER SIGHTS YOU WILL ENCOUNTER   <c1>      DEAD SHIP (HARMLESS TO            YOUR OTHER SHIPS)        DEAD SHIP (CONTAINING ENEMY MINES         
// 1000:8594  LAB_1000_8594:
// 1000:8594      a0 d2 89                 MOV AL,[0x89d2]
// 1000:8597      d0 e8                    SHR AL,0x1
// 1000:8599      24 07                    AND AL,0x7
// 1000:859b      75 33                    JNZ 0x1000:85d0
// 1000:859d      e8 5b d2                 CALL 0x1000:57fb
//                 ; inline script -> 1000:85ce  <c3><pic><pic><pic><pic><pic><pic>
// 1000:85ce  LAB_1000_85ce:
// 1000:85ce      f8                       CLC
// 1000:85cf      c3                       RET
// 1000:85d0  LAB_1000_85d0:
// 1000:85d0      fe c8                    DEC AL
// 1000:85d2      75 33                    JNZ 0x1000:8607
// 1000:85d4      e8 24 d2                 CALL 0x1000:57fb
//                 ; inline script -> 1000:8605  <c3><pic><pic><pic><pic><pic><pic>
// 1000:8605  LAB_1000_8605:
// 1000:8605      f8                       CLC
// 1000:8606      c3                       RET
// 1000:8607  LAB_1000_8607:
// 1000:8607      fe c8                    DEC AL
// 1000:8609      75 33                    JNZ 0x1000:863e
// 1000:860b      e8 ed d1                 CALL 0x1000:57fb
//                 ; inline script -> 1000:863c  <c3><pic><pic><pic><pic><pic><pic>
// 1000:863c  LAB_1000_863c:
// 1000:863c      f8                       CLC
// 1000:863d      c3                       RET
// 1000:863e  LAB_1000_863e:
// 1000:863e      fe c8                    DEC AL
// 1000:8640      75 33                    JNZ 0x1000:8675
// 1000:8642      e8 b6 d1                 CALL 0x1000:57fb
//                 ; inline script -> 1000:8673  <c3><pic><pic><pic><pic><pic><pic>
// 1000:8673  LAB_1000_8673:
// 1000:8673      f8                       CLC
// 1000:8674      c3                       RET
// 1000:8675  LAB_1000_8675:
// 1000:8675      fe c8                    DEC AL
// 1000:8677      75 33                    JNZ 0x1000:86ac
// 1000:8679      e8 7f d1                 CALL 0x1000:57fb
//                 ; inline script -> 1000:86aa  <c3><pic><pic><pic><pic><pic><pic>
// 1000:86aa  LAB_1000_86aa:
// 1000:86aa      f8                       CLC
// 1000:86ab      c3                       RET
// 1000:86ac  LAB_1000_86ac:
// 1000:86ac      fe c8                    DEC AL
// 1000:86ae      75 33                    JNZ 0x1000:86e3
// 1000:86b0      e8 48 d1                 CALL 0x1000:57fb
//                 ; inline script -> 1000:86e1  <c3><pic><pic><pic><pic><pic><pic>
// 1000:86e1  LAB_1000_86e1:
// 1000:86e1      f8                       CLC
// 1000:86e2      c3                       RET
// 1000:86e3  LAB_1000_86e3:
// 1000:86e3      fe c8                    DEC AL
// 1000:86e5      75 33                    JNZ 0x1000:871a
// 1000:86e7      e8 11 d1                 CALL 0x1000:57fb
//                 ; inline script -> 1000:8718  <c3><pic><pic><pic><pic><pic><pic>
// 1000:8718  LAB_1000_8718:
// 1000:8718      f8                       CLC
// 1000:8719      c3                       RET
// 1000:871a  LAB_1000_871a:
// 1000:871a      e8 de d0                 CALL 0x1000:57fb
//                 ; inline script -> 1000:874b  <c3><pic><pic><pic><pic><pic><pic>
// 1000:874b  LAB_1000_874b:
// 1000:874b      f8                       CLC
// 1000:874c      c3                       RET
// 1000:874d      e8 ab d0                 CALL 0x1000:57fb
//                 ; inline script -> 1000:89aa  <c3><clear>      SHIP AND VIEW SELECTION KEYS      KEY              FUNCTION  <c2>    F1<c1>      SELECT SHIP 1  <c2>    F2<c1>        "     "   2  <c2>    F3<c
// 1000:89aa  LAB_1000_89aa:
// 1000:89aa      f8                       CLC
// 1000:89ab      c3                       RET
// 1000:89ac      e8 4c ce                 CALL 0x1000:57fb
//                 ; inline script -> 1000:8b00  <c3><clear>           SHIP MOVEMENT KEYS       KEY          FUNCTION  <c2> +  or <c3><c1>  INCREASE IMPULSE SPEED .1  <c2> -  or <c3><c1>  DECREASE IMPULSE SPEE
// 1000:8b00  LAB_1000_8b00:
// 1000:8b00      f8                       CLC
// 1000:8b01      c3                       RET
// 1000:8b02      e8 f6 cc                 CALL 0x1000:57fb
//                 ; inline script -> 1000:8c49  <c3><clear>              WEAPONS KEYS     KEY          FUNCTION  <c2>Space<c1>  FIRE PHOTON TORPEDO  <c2>  C  <c1>  CANCEL PHOTON TORPEDO  <c2>  P  <c1>  FIRE F
// 1000:8c49  LAB_1000_8c49:
// 1000:8c49      f8                       CLC
// 1000:8c4a      c3                       RET
// 1000:8c4b      e8 ad cb                 CALL 0x1000:57fb
//                 ; inline script -> 1000:8e74  <c3><clear>            SCAN RANGE KEYS    KEY                FUNCTION  <c2> 1  <c1>  SCAN 400 BY  400  (SHORT RANGE)  <c2> 2  <c1>   "  1600 BY 1600  (MEDIUM RA
// 1000:8e74  LAB_1000_8e74:
// 1000:8e74      f8                       CLC
// 1000:8e75      c3                       RET
// 1000:8e76      e8 82 c9                 CALL 0x1000:57fb
//                 ; inline script -> 1000:90e8  <c3><clear>             AUXILLARY KEYS       KEY          FUNCTION  <c2>    G <c1>  GET PREVIOUSLY DROPPED MINE  <c3>           (ALLOWS YOU TO PICK UP ONE      
// 1000:90e8  LAB_1000_90e8:
// 1000:90e8      f8                       CLC
// 1000:90e9      c3                       RET
// 1000:90ea      e8 0e c7                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9320  <c3><clear>     COMPUTER MODE KEYS   <c1> KEY            FUNCTION  ALT-A        SEEK ALL  ALT-B        SEEK ENEMY BASE  ALT-C        RESET AUTO SEEK  ALT-D     
// 1000:9320  LAB_1000_9320:
// 1000:9320      f8                       CLC
// 1000:9321      c3                       RET
// 1000:9322      e8 d6 c4                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9512  <c3><clear>             MESSAGE SYSTEM   <c1>   MESSAGES MAY BE SENT TO YOUR OPPONENT  WHILE PLAYING THE GAME.  THE TAB KEY  (OVER THE Ctrl KEY) IS USED TO ENTE
// 1000:9512  LAB_1000_9512:
// 1000:9512      f8                       CLC
// 1000:9513      c3                       RET
// 1000:9514      e8 e4 c2                 CALL 0x1000:57fb
//                 ; inline script -> 1000:96c8  <c3><clear>           BUILDING A BASE   <c1>   THE MINI-BASES SCATTERED THROUGHOUT  THE UNIVERSE (IN YOUR PLANE) CAN BE  CONVERTED INTO A NEW BASE.  YOU MUST FI
// 1000:96c8  LAB_1000_96c8:
// 1000:96c8      f8                       CLC
// 1000:96c9      c3                       RET
// 1000:96ca      e8 2e c1                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9935  <c3><clear>             SCORING SYSTEM   <c1>   SCORES ARE BASED ON THE AMOUNT OF  DAMAGE YOU INFLICT ON YOUR ENEMIES AND  THE AMOUNT OF ENERGY YOU HAVE LEFT AT
// 1000:9935  LAB_1000_9935:
// 1000:9935      f8                       CLC
// 1000:9936      c3                       RET
// 1000:9937      e8 c1 be                 CALL 0x1000:57fb
//                 ; inline script -> 1000:99b8  <c1><clear>  HIT Esc TO PAUSE GAME.   AFTER 3 SECONDS PAUSE   MESSAGE WILL APPEAR.   BOTH PLAYERS MUST THEN   HIT Esc TO CONTINUE.  
// 1000:99b8  LAB_1000_99b8:
// 1000:99b8      c6 06 6c a2 80           MOV byte ptr [0xa26c],0x80
// 1000:99bd      c7 06 b5 39 4e 00        MOV word ptr [0x39b5],0x4e
// 1000:99c3      c7 06 b7 39 82 00        MOV word ptr [0x39b7],0x82
// 1000:99c9      e9 62 0b                 JMP 0x1000:a52e
// 1000:99cc      e8 2c be                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9a19  <c1><clear>     DIRECTION METER   GREEN HAND -> DESIRED   RED HAND   -> ACTUAL  
// 1000:9a19  LAB_1000_9a19:
// 1000:9a19      c7 06 b5 39 c8 00        MOV word ptr [0x39b5],0xc8
// 1000:9a1f      c7 06 b7 39 16 00        MOV word ptr [0x39b7],0x16
// 1000:9a25      e9 06 0b                 JMP 0x1000:a52e
// 1000:9a28      e8 d0 bd                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9a73  <c1><clear>     IMPULSE METER   GREEN HAND -> DESIRED   RED HAND   -> ACTUAL  
// 1000:9a73  LAB_1000_9a73:
// 1000:9a73      c7 06 b5 39 ec 00        MOV word ptr [0x39b5],0xec
// 1000:9a79      c7 06 b7 39 16 00        MOV word ptr [0x39b7],0x16
// 1000:9a7f      e9 ac 0a                 JMP 0x1000:a52e
// 1000:9a82      e8 76 bd                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9a9f  <c1><clear>    NUMBER OF MINES  
// 1000:9a9f  LAB_1000_9a9f:
// 1000:9a9f      c7 06 b5 39 10 01        MOV word ptr [0x39b5],0x110
// 1000:9aa5      c7 06 b7 39 08 00        MOV word ptr [0x39b7],0x8
// 1000:9aab      e9 80 0a                 JMP 0x1000:a52e
// 1000:9aae      e8 4a bd                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9acd  <c1><clear>  NUMBER OF TORPEDOES  
// 1000:9acd  LAB_1000_9acd:
// 1000:9acd      c7 06 b5 39 12 01        MOV word ptr [0x39b5],0x112
// 1000:9ad3      c7 06 b7 39 16 00        MOV word ptr [0x39b7],0x16
// 1000:9ad9      e9 52 0a                 JMP 0x1000:a52e
// 1000:9adc      e8 1c bd                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9b61  <c1><clear>  FLAG STATUS     IF F(LAG) COMMAND     IS ACTIVE, IT WILL     BLINK INDICATING NEXT     PLANET IN RANGE WILL     BE FLAGGED.
// 1000:9b61  LAB_1000_9b61:
// 1000:9b61      c7 06 b5 39 d8 00        MOV word ptr [0x39b5],0xd8
// 1000:9b67      c7 06 b7 39 1d 00        MOV word ptr [0x39b7],0x1d
// 1000:9b6d      e9 be 09                 JMP 0x1000:a52e
// 1000:9b70      e8 88 bc                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9ba1  <c1><clear>    WARP METER   GREEN BAR -> TIME LEFT  
// 1000:9ba1  LAB_1000_9ba1:
// 1000:9ba1      c7 06 b5 39 c0 00        MOV word ptr [0x39b5],0xc0
// 1000:9ba7      c7 06 b7 39 26 00        MOV word ptr [0x39b7],0x26
// 1000:9bad      e9 7e 09                 JMP 0x1000:a52e
// 1000:9bb0      e8 48 bc                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9be1  <c1><clear>  INVISO METER   GREEN BAR -> TIME LEFT  
// 1000:9be1  LAB_1000_9be1:
// 1000:9be1      c7 06 b5 39 c0 00        MOV word ptr [0x39b5],0xc0
// 1000:9be7      c7 06 b7 39 30 00        MOV word ptr [0x39b7],0x30
// 1000:9bed      e9 3e 09                 JMP 0x1000:a52e
// 1000:9bf0      e8 08 bc                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9c56  <c1><clear>  CURRENT SHIP    ALWAYS APPEARS IN    CENTER OF SCREEN.    COMMANDS AFFECT    THIS SHIP ONLY.
// 1000:9c56  LAB_1000_9c56:
// 1000:9c56      c7 06 b5 39 e3 00        MOV word ptr [0x39b5],0xe3
// 1000:9c5c      c7 06 b7 39 3c 00        MOV word ptr [0x39b7],0x3c
// 1000:9c62      e9 c9 08                 JMP 0x1000:a52e
// 1000:9c65      e8 93 bb                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9ca6  <c1><clear>  COMPUTER STATUS   CURRENT SEEK OBJECT   AND DISTANCE.  
// 1000:9ca6  LAB_1000_9ca6:
// 1000:9ca6      c7 06 b5 39 fc 00        MOV word ptr [0x39b5],0xfc
// 1000:9cac      c7 06 b7 39 44 00        MOV word ptr [0x39b7],0x44
// 1000:9cb2      e9 79 08                 JMP 0x1000:a52e
// 1000:9cb5      e8 43 bb                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9d23  <c1><clear>  GALAXY LEVEL    IF PLAYING IN MULTI-    GALAXIES, CURRENT    LEVEL OF THIS SHIP    WILL BE INDICATED
// 1000:9d23  LAB_1000_9d23:
// 1000:9d23      c7 06 b5 39 e3 00        MOV word ptr [0x39b5],0xe3
// 1000:9d29      c7 06 b7 39 4c 00        MOV word ptr [0x39b7],0x4c
// 1000:9d2f      e9 fc 07                 JMP 0x1000:a52e
// 1000:9d32      e8 c6 ba                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9d6e  <c1><clear>  WEAPONS STATUS    READY  <c3>  FIRED    WAIT  <c2>  INOP
// 1000:9d6e  LAB_1000_9d6e:
// 1000:9d6e      c7 06 b5 39 00 01        MOV word ptr [0x39b5],0x100
// 1000:9d74      c7 06 b7 39 54 00        MOV word ptr [0x39b7],0x54
// 1000:9d7a      e9 b1 07                 JMP 0x1000:a52e
// 1000:9d7d      e8 7b ba                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9dad  <c1><clear>  SHIELDS STATUS    DOWN  <c3>  UP  <c2>  INOP
// 1000:9dad  LAB_1000_9dad:
// 1000:9dad      c7 06 b5 39 00 01        MOV word ptr [0x39b5],0x100
// 1000:9db3      c7 06 b7 39 5c 00        MOV word ptr [0x39b7],0x5c
// 1000:9db9      e9 72 07                 JMP 0x1000:a52e
// 1000:9dbc      e8 3c ba                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9df3  <c1><clear>  SCANNER STATUS    SHORT, MED, LONG,    OR MAP
// 1000:9df3  LAB_1000_9df3:
// 1000:9df3      c7 06 b5 39 00 01        MOV word ptr [0x39b5],0x100
// 1000:9df9      c7 06 b7 39 64 00        MOV word ptr [0x39b7],0x64
// 1000:9dff      e9 2c 07                 JMP 0x1000:a52e
// 1000:9e02      e8 f6 b9                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9e2d  <c1><clear>  COMPUTER STATUS    READY OR <c2>INOP
// 1000:9e2d  LAB_1000_9e2d:
// 1000:9e2d      c7 06 b5 39 00 01        MOV word ptr [0x39b5],0x100
// 1000:9e33      c7 06 b7 39 6c 00        MOV word ptr [0x39b7],0x6c
// 1000:9e39      e9 f2 06                 JMP 0x1000:a52e
// 1000:9e3c      e8 bc b9                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9ea7  <c1><clear>  FIRE CONTROL    INDICATES ENEMY    SELECTED BY F5 KEY.    * DESIGNATES ANY    ENEMY SHIP OR BASE.
// 1000:9ea7  LAB_1000_9ea7:
// 1000:9ea7      c7 06 b5 39 00 01        MOV word ptr [0x39b5],0x100
// 1000:9ead      c7 06 b7 39 74 00        MOV word ptr [0x39b7],0x74
// 1000:9eb3      e9 78 06                 JMP 0x1000:a52e
// 1000:9eb6      e8 42 b9                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9efd  <c1><clear>  YOUR BASE STATUS    CONDITION, ENERGY,    MINES AND TORPEDOES
// 1000:9efd  LAB_1000_9efd:
// 1000:9efd      c7 06 b5 39 b8 00        MOV word ptr [0x39b5],0xb8
// 1000:9f03      c7 06 b7 39 84 00        MOV word ptr [0x39b7],0x84
// 1000:9f09      e9 22 06                 JMP 0x1000:a52e
// 1000:9f0c      e8 ec b8                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9f2b  <c1><clear>  SUMMARY OF YOUR SHIPS
// 1000:9f2b  LAB_1000_9f2b:
// 1000:9f2b      c7 06 b5 39 b8 00        MOV word ptr [0x39b5],0xb8
// 1000:9f31      c7 06 b7 39 a8 00        MOV word ptr [0x39b7],0xa8
// 1000:9f37      e9 f4 05                 JMP 0x1000:a52e
// 1000:9f3a      e8 be b8                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9fbd  <c1><clear>  INVISO INDICATOR    IF ON, INVISIBLE.    IF OFF, VISIBLE.    IF BLINKING, SHIP     IS VISIBLE WHILE     WEAPON IS ACTIVE.
// 1000:9fbd  LAB_1000_9fbd:
// 1000:9fbd      c7 06 b5 39 c4 00        MOV word ptr [0x39b5],0xc4
// 1000:9fc3      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
// 1000:9fc9      e9 62 05                 JMP 0x1000:a52e
// 1000:9fcc      e8 2c b8                 CALL 0x1000:57fb
//                 ; inline script -> 1000:9fe3  <c1><clear>  ENERGY STATUS
// 1000:9fe3  LAB_1000_9fe3:
// 1000:9fe3      c7 06 b5 39 d4 00        MOV word ptr [0x39b5],0xd4
// 1000:9fe9      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
// 1000:9fef      e9 3c 05                 JMP 0x1000:a52e
// 1000:9ff2      e8 06 b8                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a028  <c1><clear>  RED CHECK INDICATES   PREVIOUS SEEK COMPLETE
// 1000:a028  LAB_1000_a028:
// 1000:a028      c7 06 b5 39 f2 00        MOV word ptr [0x39b5],0xf2
// 1000:a02e      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
// 1000:a034      e9 f7 04                 JMP 0x1000:a52e
// 1000:a037      e8 c1 b7                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a07e  <c1><clear>  COMPUTER INDICATOR   SHOWS OBJECT THAT   COMPUTER IS SEEKING.
// 1000:a07e  LAB_1000_a07e:
// 1000:a07e      c7 06 b5 39 fc 00        MOV word ptr [0x39b5],0xfc
// 1000:a084      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
// 1000:a08a      e9 a1 04                 JMP 0x1000:a52e
// 1000:a08d      e8 6b b7                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a118  <c1><clear>  CONDITION OF SHIP   GREEN-NO SHIP IN AREA   YELLOW-SHIP SPOTTED   ORANGE-SHIP IN RANGE   RED-SHIP VERY CLOSE       OR MUCH DAMAGE
// 1000:a118  LAB_1000_a118:
// 1000:a118      c7 06 b5 39 04 01        MOV word ptr [0x39b5],0x104
// 1000:a11e      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
// 1000:a124      e9 07 04                 JMP 0x1000:a52e
// 1000:a127      e8 d1 b6                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a141  <c1><clear>  DOCKED INDICATOR
// 1000:a141  LAB_1000_a141:
// 1000:a141      c7 06 b5 39 0c 01        MOV word ptr [0x39b5],0x10c
// 1000:a147      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
// 1000:a14d      e9 de 03                 JMP 0x1000:a52e
// 1000:a150      e8 a8 b6                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a1ef  <c1><clear>  WARNING INDICATOR    <c2>T<c1>=TORPEDO CLOSE    <c2>M<c1>=MINE CLOSE    <c2>R<c1>=ROGUE SHIP    <c2>H<c1>=HUM IN AREA    <c2>P<c1>=PHASER CLOSE    
// 1000:a1ef  LAB_1000_a1ef:
// 1000:a1ef      c7 06 b5 39 14 01        MOV word ptr [0x39b5],0x114
// 1000:a1f5      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
// 1000:a1fb      e9 30 03                 JMP 0x1000:a52e
// 1000:a1fe      e8 fa b5                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a251  <c1><clear>  MINE SWEEP INDICATOR    (WHEN BLINKING,    GET MINE COMMAND IS    ACTIVE)
// 1000:a251  LAB_1000_a251:
// 1000:a251      c7 06 b5 39 1c 01        MOV word ptr [0x39b5],0x11c
// 1000:a257      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
// 1000:a25d      e9 ce 02                 JMP 0x1000:a52e
// 1000:a260      e8 98 b5                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a2e4  <c1><clear>  MINE SWEEP INDICATOR   COLOR INDICATES NUMBER   OF MINES THAT SWEEP WILL   DESTROY.  <c2>   M = 1-3  <c3>   M = 4-6  <c1>   M = > 6
// 1000:a2e4  LAB_1000_a2e4:
// 1000:a2e4      c7 06 b5 39 1c 01        MOV word ptr [0x39b5],0x11c
// 1000:a2ea      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
// 1000:a2f0      e9 3b 02                 JMP 0x1000:a52e
// 1000:a2f3      e8 05 b5                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a313  <c1><clear>  SUPER SHIELD INDICATOR
// 1000:a313  LAB_1000_a313:
// 1000:a313      c7 06 b5 39 24 01        MOV word ptr [0x39b5],0x124
// 1000:a319      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
// 1000:a31f      e9 0c 02                 JMP 0x1000:a52e
// 1000:a322      e8 d6 b4                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a35c  <c1><clear>  SOUND ENABLED INDICATOR    Ctrl-S TOGGLES ON/OFF
// 1000:a35c  LAB_1000_a35c:
// 1000:a35c      c7 06 b5 39 d7 00        MOV word ptr [0x39b5],0xd7
// 1000:a362      c7 06 b7 39 03 00        MOV word ptr [0x39b7],0x3
// 1000:a368      c6 06 d4 89 40           MOV byte ptr [0x89d4],0x40
// 1000:a36d      e9 be 01                 JMP 0x1000:a52e
// 1000:a370      e8 88 b4                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a3fe  <c1><clear>  Ctrl-F  TOGGLES BETWEEN    TREK AND IBM CHARACTER    FONTS.   Ctrl-P  SELECTS COLORS    RED-GREEN-YELLOW or    MAGENTA-CYAN-WHITE.  
// 1000:a3fe  LAB_1000_a3fe:
// 1000:a3fe      e8 2f a1                 CALL 0x1000:4530
// 1000:a401      e8 f7 b3                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a408  <c3>
// 1000:a408  LAB_1000_a408:
// 1000:a408      f8                       CLC
// 1000:a409      c3                       RET
// 1000:a40a      e8 ee b3                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a458  <c1><clear>  BASE VIEW   PLAYER'S ID, SCORE,   TOTAL ENERGY AND   NUMBER OF SHIPS
// 1000:a458  LAB_1000_a458:
// 1000:a458      c7 06 b5 39 b8 00        MOV word ptr [0x39b5],0xb8
// 1000:a45e      c7 06 b7 39 1e 00        MOV word ptr [0x39b7],0x1e
// 1000:a464      c6 06 d4 89 50           MOV byte ptr [0x89d4],0x50
// 1000:a469      e9 c2 00                 JMP 0x1000:a52e
// 1000:a46c      e8 8c b3                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a4b6  <c1><clear>  GAME TIMER-LONG GAME   HOURS:MINS:SECS   SINCE BEGINNING OF GAME
// 1000:a4b6  LAB_1000_a4b6:
// 1000:a4b6      c6 06 b1 39 02           MOV byte ptr [0x39b1],0x2
// 1000:a4bb      c7 06 b5 39 d4 00        MOV word ptr [0x39b5],0xd4
// 1000:a4c1      c7 06 b7 39 be 00        MOV word ptr [0x39b7],0xbe
// 1000:a4c7      eb 65                    JMP 0x1000:a52e
// 1000:a4ca      e8 2e b3                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a50e  <c1><clear>  GAME TIMER-TIMED GAME   MINS:SECS   LEFT UNTIL END OF GAME
// 1000:a50e  LAB_1000_a50e:
// 1000:a50e      c6 06 b1 39 03           MOV byte ptr [0x39b1],0x3
// 1000:a513      c7 06 b5 39 e0 00        MOV word ptr [0x39b5],0xe0
// 1000:a519      c7 06 b7 39 be 00        MOV word ptr [0x39b7],0xbe
// 1000:a51f      80 3e 07 a2 00           CMP byte ptr [0xa207],0x0
// 1000:a524      75 05                    JNZ 0x1000:a52b
// 1000:a526      c6 06 07 a2 1e           MOV byte ptr [0xa207],0x1e
// 1000:a52b  LAB_1000_a52b:
// 1000:a52b      eb 01                    JMP 0x1000:a52e
// 1000:a52e  LAB_1000_a52e:
// 1000:a52e      e8 ff 9f                 CALL 0x1000:4530
// 1000:a531      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
// 1000:a536      75 06                    JNZ 0x1000:a53e
// 1000:a538      bb b2 39                 MOV BX,0x39b2
// 1000:a53b      e8 ce b2                 CALL 0x1000:580c
// 1000:a53e  LAB_1000_a53e:
// 1000:a53e      e8 ba b2                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a545  <c3>
// 1000:a545  LAB_1000_a545:
// 1000:a545      f8                       CLC
// 1000:a546      c3                       RET
// 1000:a547      c6 06 72 a2 01           MOV byte ptr [0xa272],0x1
// 1000:a54c      e8 ac b2                 CALL 0x1000:57fb
//                 ; inline script -> 1000:a727  <c1><clear>      THAT CONCLUDES THE INSTRUCTIONS.    NEXT TIME THE GAME STARTS, HIT Esc KEY  TO RETURN TO THE PRIMARY MENU FROM ANY  POINT IN THE INSTRUCTIONS. 
// 1000:a727  LAB_1000_a727:
// 1000:a727      f8                       CLC
// 1000:a728      c3                       RET
fun_7079 :: proc() {
}

// 1000:a800 is in draw.odin.

// @proc 1000:a874
// listing: FUN_1000_a874
// status: unread
// 1000:a874  FUN_1000_a874:
// 1000:a874      bf 8a 16                 MOV DI,0x168a
// 1000:a877      bb d5 a8                 MOV BX,0xa8d5
// 1000:a87a      e8 1c 00                 CALL 0x1000:a899
// 1000:a87d      bf 08 19                 MOV DI,0x1908
// 1000:a880      bb f9 a8                 MOV BX,0xa8f9
// 1000:a883      e8 13 00                 CALL 0x1000:a899
// 1000:a886      bf 95 1b                 MOV DI,0x1b95
// 1000:a889      bb 20 a9                 MOV BX,0xa920
// 1000:a88c      e8 0a 00                 CALL 0x1000:a899
// 1000:a88f      bf 07 1e                 MOV DI,0x1e07
// 1000:a892      bb 3a a9                 MOV BX,0xa93a
// 1000:a895      e8 01 00                 CALL 0x1000:a899
// 1000:a898      c3                       RET
fun_a874 :: proc() {
}

// @proc 1000:a899
// listing: FUN_1000_a899
// status: unread
// 1000:a899  FUN_1000_a899:
// 1000:a899      c6 06 64 a2 01           MOV byte ptr [0xa264],0x1
// 1000:a89e  LAB_1000_a89e:
// 1000:a89e      2e 8a 07                 MOV AL,byte ptr CS:[BX]
// 1000:a8a1      e8 c8 b0                 CALL 0x1000:596c
// 1000:a8a4      43                       INC BX
// 1000:a8a5      22 c0                    AND AL,AL
// 1000:a8a7      74 27                    JZ 0x1000:a8d0
// 1000:a8a9      3c 04                    CMP AL,0x4
// 1000:a8ab      72 f1                    JC 0x1000:a89e
// 1000:a8ad      57                       PUSH DI
// 1000:a8ae      8b 36 16 00              MOV SI,word ptr [0x16]
// 1000:a8b2      b9 04 00                 MOV CX,0x4
// 1000:a8b5      32 e4                    XOR AH,AH
// 1000:a8b7      d3 e0                    SHL AX,CL
// 1000:a8b9      03 f0                    ADD SI,AX
// 1000:a8bb  LAB_1000_a8bb:
// 1000:a8bb      ad                       LODSW SI
// 1000:a8bc      26 89 05                 MOV word ptr ES:[DI],AX
// 1000:a8bf      ad                       LODSW SI
// 1000:a8c0      26 89 85 00 20           MOV word ptr ES:[DI + 0x2000],AX
// 1000:a8c5      83 c7 50                 ADD DI,0x50
// 1000:a8c8      e2 f1                    LOOP 0x1000:a8bb
// 1000:a8ca      5f                       POP DI
// 1000:a8cb      83 c7 02                 ADD DI,0x2
// 1000:a8ce      eb ce                    JMP 0x1000:a89e
// 1000:a8d0  LAB_1000_a8d0:
// 1000:a8d0      c3                       RET
fun_a899 :: proc() {
}

// @proc 1000:a93e
// listing: FUN_1000_a93e
// status: unread
// 1000:a93e  FUN_1000_a93e:
// 1000:a93e      e8 ba ae                 CALL 0x1000:57fb
//                 ; inline script -> 1000:ac29  <c3><clear>           TREK 2.8   AUGUST 1,1987<c1>       A LIMITED LICENSE IS GRANTED TO ALL  USERS OF THIS PROGRAM TO MAKE COPIES OR  DISTRIBUTE ELECTRONICALLY
// 1000:ac29  LAB_1000_ac29:
// 1000:ac29      c7 06 55 a2 48 00        MOV word ptr [0xa255],0x48
// 1000:ac2f  LAB_1000_ac2f:
// 1000:ac2f      83 3e 55 a2 00           CMP word ptr [0xa255],0x0
// 1000:ac34      75 f9                    JNZ 0x1000:ac2f
// 1000:ac36      c3                       RET
fun_a93e :: proc() {
}

