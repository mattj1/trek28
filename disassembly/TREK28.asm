; TREK28.COM disassembly
; Ghidra 12.2, processor x86:LE:16:Real Mode
; Load address 1000:0000 == DOS PSP 0FF0:0100. Entry is 1000:0018 (start).
; DS is initially 0FF0 (PSP). Startup relocates DS to 1AC7 and SS to 2532.

1000:0000  LAB_1000_0000:
1000:0000      eb 02                    JMP 0x1000:0004
1000:0004  LAB_1000_0004:
1000:0004      8c c8                    MOV AX,CS
1000:0006  LAB_1000_0006:
1000:0006      05 10 00                 ADD AX,0x10
1000:0009      9c                       PUSHF
1000:000a      50                       PUSH AX
1000:000b      b8 18 00                 MOV AX,0x18
1000:000e      50                       PUSH AX
1000:000f      cf                       IRET
                ; IRET to relocated CS:0018, modeled as 1000:0018. Bytes are unchanged.

; ------------------------------------------------------------
1000:0018  start:
1000:0018      2e 8c 1e 04 00           MOV word ptr CS:[0x4],DS
1000:001d      2e c7 06 02 00 00 00     MOV word ptr CS:[0x2],0x0
1000:0024      8b 2e 02 00              MOV BP,word ptr [0x2]
1000:0028      b8 c7 0a                 MOV AX,0xac7
1000:002b      8c cb                    MOV BX,CS
1000:002d      03 c3                    ADD AX,BX
1000:002f      2e a3 00 00              MOV CS:[0x0],AX
1000:0033      8e d8                    MOV DS,AX
1000:0035      b8 32 15                 MOV AX,0x1532
1000:0038      03 c3                    ADD AX,BX
1000:003a      8e d0                    MOV SS,AX
1000:003c      bc 00 02                 MOV SP,0x200
1000:003f      e8 d1 00                 CALL 0x1000:0113
1000:0042      8c cb                    MOV BX,CS
1000:0044      b1 04                    MOV CL,0x4
1000:0046      2e a1 10 00              MOV AX,CS:[0x10]
1000:004a      d3 e8                    SHR AX,CL
1000:004c      03 d8                    ADD BX,AX
1000:004e      8e c3                    MOV ES,BX
1000:0050      8c d0                    MOV AX,SS
1000:0052      2b c3                    SUB AX,BX
1000:0054      d3 e0                    SHL AX,CL
1000:0056      8b c8                    MOV CX,AX
1000:0058      32 c0                    XOR AL,AL
1000:005a      33 ff                    XOR DI,DI
1000:005c      f3 aa                    STOSB.REP ES:DI
1000:005e      fa                       CLI
1000:005f      8b cc                    MOV CX,SP
1000:0061      f3 aa                    STOSB.REP ES:DI
1000:0063      e4 21                    IN AL,0x21
1000:0065      89 26 43 a3              MOV word ptr [0xa343],SP
1000:0069      a2 00 a2                 MOV [0xa200],AL
1000:006c      b8 00 00                 MOV AX,0x0
1000:006f      8e c0                    MOV ES,AX
1000:0071      b8 20 68                 MOV AX,0x6820
1000:0074      26 87 06 70 00           XCHG word ptr ES:[0x70],AX
1000:0079      a3 7a a2                 MOV [0xa27a],AX
1000:007c      8c c8                    MOV AX,CS
1000:007e      26 87 06 72 00           XCHG word ptr ES:[0x72],AX
1000:0083      a3 7c a2                 MOV [0xa27c],AX
1000:0086      b8 e3 5f                 MOV AX,0x5fe3
1000:0089      26 a3 04 00              MOV ES:[0x4],AX
1000:008d      26 8c 0e 06 00           MOV word ptr ES:[0x6],CS
1000:0092      b8 4b 68                 MOV AX,0x684b
1000:0095      26 a3 0c 00              MOV ES:[0xc],AX
1000:0099      26 8c 0e 0e 00           MOV word ptr ES:[0xe],CS
1000:009e      fb                       STI
1000:009f      2e 8e 06 00 00           MOV ES,word ptr CS:[0x0]
1000:00a4      b8 04 00                 MOV AX,0x4
1000:00a7      cd 10                    INT 0x10
1000:00a9      e8 03 0b                 CALL 0x1000:0baf
1000:00ac      c7 06 a5 00 b5 00        MOV word ptr [0xa5],0xb5
1000:00b2      e8 4b a7                 CALL 0x1000:a800
1000:00b5      8b 26 43 a3              MOV SP,word ptr [0xa343]
1000:00b9      8c d8                    MOV AX,DS
1000:00bb      8e c0                    MOV ES,AX
1000:00bd      bf d0 89                 MOV DI,0x89d0
1000:00c0      8b 0e d1 00              MOV CX,word ptr [0xd1]
1000:00c4      32 c0                    XOR AL,AL
1000:00c6      f3 aa                    STOSB.REP ES:DI
1000:00c8      c7 06 a5 00 d1 00        MOV word ptr [0xa5],0xd1
1000:00ce      e8 6d a8                 CALL 0x1000:a93e
1000:00d1      8b 26 43 a3              MOV SP,word ptr [0xa343]
1000:00d5      bf d0 89                 MOV DI,0x89d0
1000:00d8      8b 0e d1 00              MOV CX,word ptr [0xd1]
1000:00dc      32 c0                    XOR AL,AL
1000:00de      f3 aa                    STOSB.REP ES:DI
1000:00e0      b4 00                    MOV AH,0x0
1000:00e2      cd 1a                    INT 0x1a
1000:00e4      86 d6                    XCHG DH,DL
1000:00e6      89 16 d0 89              MOV word ptr [0x89d0],DX
1000:00ea      c6 06 70 a2 07           MOV byte ptr [0xa270],0x7
1000:00ef      e8 93 04                 CALL 0x1000:0585
1000:00f2      c6 06 67 a2 00           MOV byte ptr [0xa267],0x0
1000:00f7      c7 06 a5 00 66 01        MOV word ptr [0xa5],0x166
1000:00fd      b9 d0 07                 MOV CX,0x7d0
1000:0100  LAB_1000_0100:
1000:0100      51                       PUSH CX
1000:0101      b9 96 19                 MOV CX,0x1996
1000:0104  LAB_1000_0104:
1000:0104      e2 fe                    LOOP 0x1000:0104
1000:0106      ff 06 d0 89              INC word ptr [0x89d0]
1000:010a      e8 38 0a                 CALL 0x1000:0b45
1000:010d      59                       POP CX
1000:010e      e2 f0                    LOOP 0x1000:0100
1000:0110      eb 54                    JMP 0x1000:0166

; ------------------------------------------------------------
1000:0113  FUN_1000_0113:
1000:0113      8c d0                    MOV AX,SS
1000:0115      05 32 00                 ADD AX,0x32
1000:0118      3b c5                    CMP AX,BP
1000:011a      72 06                    JC 0x1000:0122
1000:011c      be 40 00                 MOV SI,0x40
1000:011f      eb 2a                    JMP 0x1000:014b
1000:0122  LAB_1000_0122:
1000:0122      b4 30                    MOV AH,0x30
1000:0124      cd 21                    INT 0x21
1000:0126      86 c4                    XCHG AH,AL
1000:0128      3d 00 02                 CMP AX,0x200
1000:012b      73 06                    JNC 0x1000:0133
1000:012d      be 22 00                 MOV SI,0x22
1000:0130      eb 19                    JMP 0x1000:014b
1000:0133  LAB_1000_0133:
1000:0133      b4 00                    MOV AH,0x0
1000:0135      cd 11                    INT 0x11
1000:0137      25 30 00                 AND AX,0x30
1000:013a      3d 30 00                 CMP AX,0x30
1000:013d      75 0b                    JNZ 0x1000:014a
1000:013f      b8 40 00                 MOV AX,0x40
1000:0142      8e c0                    MOV ES,AX
1000:0144      26 80 26 10 00 ef        AND byte ptr ES:[0x10],0xef
1000:014a  LAB_1000_014a:
1000:014a      c3                       RET
1000:014b  LAB_1000_014b:
1000:014b      e8 0a 00                 CALL 0x1000:0158
1000:014e      2e 8e 1e 04 00           MOV DS,word ptr CS:[0x4]
1000:0153      2e ff 2e 02 00           JMPF CS:[0x2]

; ------------------------------------------------------------
1000:0158  FUN_1000_0158:
1000:0158      ac                       LODSB SI
1000:0159      3c 00                    CMP AL,0x0
1000:015b      74 08                    JZ 0x1000:0165
1000:015d      b4 02                    MOV AH,0x2
1000:015f      8a d0                    MOV DL,AL
1000:0161      cd 21                    INT 0x21
1000:0163      eb f3                    JMP 0x1000:0158
1000:0165  LAB_1000_0165:
1000:0165      c3                       RET

; ------------------------------------------------------------
1000:0166  FUN_1000_0166:
1000:0166      c7 06 09 a2 00 00        MOV word ptr [0xa209],0x0
1000:016c      8b 26 43 a3              MOV SP,word ptr [0xa343]
1000:0170      b0 ff                    MOV AL,0xff
1000:0172      e6 21                    OUT 0x21,AL
1000:0174      e8 05 0b                 CALL 0x1000:0c7c
1000:0177      e8 06 68                 CALL 0x1000:6980
1000:017a      c6 06 71 a2 00           MOV byte ptr [0xa271],0x0
1000:017f      e8 11 02                 CALL 0x1000:0393
1000:0182      e8 76 56                 CALL 0x1000:57fb
                ; inline script -> 1000:01af  <c3><clear>      PRIMARY MENU    <c1>  INSTRUCTIONS
1000:01af  LAB_1000_01af:
1000:01af      80 3e 72 a2 01           CMP byte ptr [0xa272],0x1
1000:01b4      74 19                    JZ 0x1000:01cf
1000:01b6      e8 42 56                 CALL 0x1000:57fb
                ; inline script -> 1000:01cf  <c2>(REQUIRED READING)
1000:01cf  LAB_1000_01cf:
1000:01cf      e8 29 56                 CALL 0x1000:57fb
                ; inline script -> 1000:01f0  <c1>     DISPLAY STATISTICS   
1000:01f0  LAB_1000_01f0:
1000:01f0      80 3e 07 00 20           CMP byte ptr [0x7],0x20
1000:01f5      75 20                    JNZ 0x1000:0217
1000:01f7      e8 01 56                 CALL 0x1000:57fb
                ; inline script -> 1000:0214  <c1>  ENTER YOUR INITIALS 
1000:0214  LAB_1000_0214:
1000:0214      eb 2b                    JMP 0x1000:0241
1000:0217  LAB_1000_0217:
1000:0217      e8 e1 55                 CALL 0x1000:57fb
                ; inline script -> 1000:0236  <c1>  CHANGE YOUR INITIALS (
1000:0236  LAB_1000_0236:
1000:0236      e8 29 03                 CALL 0x1000:0562
1000:0239      e8 bf 55                 CALL 0x1000:57fb
                ; inline script -> 1000:0241  <c1>)
1000:0241  LAB_1000_0241:
1000:0241      e8 b7 55                 CALL 0x1000:57fb
                ; inline script -> 1000:0259  <c1>     SETUP GAME (
1000:0259  LAB_1000_0259:
1000:0259      80 3e 0a 00 01           CMP byte ptr [0xa],0x1
1000:025e      75 4a                    JNZ 0x1000:02aa
1000:0260      e8 98 55                 CALL 0x1000:57fb
                ; inline script -> 1000:026e  <c1>1 Plyr,
1000:026e  LAB_1000_026e:
1000:026e      a0 0f 00                 MOV AL,[0xf]
1000:0271      e8 7b 05                 CALL 0x1000:07ef
1000:0274      b0 2c                    MOV AL,0x2c
1000:0276      e8 fe 52                 CALL 0x1000:5577
1000:0279      a0 13 00                 MOV AL,[0x13]
1000:027c      22 c0                    AND AL,AL
1000:027e      75 12                    JNZ 0x1000:0292
1000:0280      e8 78 55                 CALL 0x1000:57fb
                ; inline script -> 1000:028f  <c1>1 Enemy)
1000:028f  LAB_1000_028f:
1000:028f      eb 62                    JMP 0x1000:02f3
1000:0292  LAB_1000_0292:
1000:0292      04 31                    ADD AL,0x31
1000:0294      e8 e0 52                 CALL 0x1000:5577
1000:0297      e8 61 55                 CALL 0x1000:57fb
                ; inline script -> 1000:02a7  <c1> Enemies)
1000:02a7  LAB_1000_02a7:
1000:02a7      eb 4a                    JMP 0x1000:02f3
1000:02aa  LAB_1000_02aa:
1000:02aa      e8 4e 55                 CALL 0x1000:57fb
                ; inline script -> 1000:02b8  <c1>2 Plyr,
1000:02b8  LAB_1000_02b8:
1000:02b8      e8 af 09                 CALL 0x1000:0c6a
1000:02bb      e8 3d 55                 CALL 0x1000:57fb
                ; inline script -> 1000:02cb  <c1> BAUD,COM
1000:02cb  LAB_1000_02cb:
1000:02cb      a0 0c 00                 MOV AL,[0xc]
1000:02ce      04 31                    ADD AL,0x31
1000:02d0      e8 a4 52                 CALL 0x1000:5577
1000:02d3      a0 0e 00                 MOV AL,[0xe]
1000:02d6      22 c0                    AND AL,AL
1000:02d8      75 0e                    JNZ 0x1000:02e8
1000:02da      e8 1e 55                 CALL 0x1000:57fb
                ; inline script -> 1000:02e5  <c1>,AC)
1000:02e5  LAB_1000_02e5:
1000:02e5      eb 0c                    JMP 0x1000:02f3
1000:02e8  LAB_1000_02e8:
1000:02e8      e8 10 55                 CALL 0x1000:57fb
                ; inline script -> 1000:02f3  <c1>,SM)
1000:02f3  LAB_1000_02f3:
1000:02f3      e8 05 55                 CALL 0x1000:57fb
                ; inline script -> 1000:0346  <c1>     ENTER TERMINAL MODE     PLAY GAME     SAVE DEFAULTS TO DISK     QUIT   
1000:0346  LAB_1000_0346:
1000:0346      bb 8e 00                 MOV BX,0x8e
1000:0349      e8 c0 54                 CALL 0x1000:580c
1000:034c      32 c0                    XOR AL,AL
1000:034e      e8 9d 08                 CALL 0x1000:0bee
1000:0351  LAB_1000_0351:
1000:0351      ff 06 d0 89              INC word ptr [0x89d0]
1000:0355      e8 ed 07                 CALL 0x1000:0b45
1000:0358      74 f7                    JZ 0x1000:0351
1000:035a      3c 06                    CMP AL,0x6
1000:035c      74 32                    JZ 0x1000:0390
1000:035e      e8 a6 07                 CALL 0x1000:0b07
1000:0361      75 07                    JNZ 0x1000:036a
1000:0363      fe 06 67 a2              INC byte ptr [0xa267]
1000:0367      e9 fc fd                 JMP 0x1000:0166
1000:036a  LAB_1000_036a:
1000:036a      e8 a1 07                 CALL 0x1000:0b0e
1000:036d      75 04                    JNZ 0x1000:0373
1000:036f      fe 0e 67 a2              DEC byte ptr [0xa267]
1000:0373  LAB_1000_0373:
1000:0373      3c 0d                    CMP AL,0xd
1000:0375      75 19                    JNZ 0x1000:0390
1000:0377      80 3e 72 a2 01           CMP byte ptr [0xa272],0x1
1000:037c      74 0e                    JZ 0x1000:038c
1000:037e      81 3e 41 a3 96 04        CMP word ptr [0xa341],0x496
1000:0384      74 06                    JZ 0x1000:038c
1000:0386      c7 06 41 a3 60 6d        MOV word ptr [0xa341],0x6d60
1000:038c  LAB_1000_038c:
1000:038c      ff 26 41 a3              JMP word ptr [0xa341]
1000:0390  LAB_1000_0390:
1000:0390      e9 d3 fd                 JMP 0x1000:0166

; ------------------------------------------------------------
1000:0393  FUN_1000_0393:
1000:0393      80 3e 67 a2 08           CMP byte ptr [0xa267],0x8
1000:0398      72 0f                    JC 0x1000:03a9
1000:039a      75 08                    JNZ 0x1000:03a4
1000:039c      c6 06 67 a2 00           MOV byte ptr [0xa267],0x0
1000:03a1      eb 06                    JMP 0x1000:03a9
1000:03a4  LAB_1000_03a4:
1000:03a4      c6 06 67 a2 07           MOV byte ptr [0xa267],0x7
1000:03a9  LAB_1000_03a9:
1000:03a9      a0 67 a2                 MOV AL,[0xa267]
1000:03ac      b4 06                    MOV AH,0x6
1000:03ae      f6 e4                    MUL AH
1000:03b0      be ca 03                 MOV SI,0x3ca
1000:03b3      03 f0                    ADD SI,AX
1000:03b5      2e 8b 04                 MOV AX,word ptr CS:[SI]
1000:03b8      a3 91 00                 MOV [0x91],AX
1000:03bb      2e 8b 44 02              MOV AX,word ptr CS:[SI + 0x2]
1000:03bf      a3 93 00                 MOV [0x93],AX
1000:03c2      2e 8b 44 04              MOV AX,word ptr CS:[SI + 0x4]
1000:03c6      a3 41 a3                 MOV [0xa341],AX
1000:03c9      c3                       RET
1000:03fa      e8 fe 53                 CALL 0x1000:57fb
                ; inline script -> 1000:0425  <c3><box> ** SAVING DEFAULTS TO DISK ** 
1000:0425  LAB_1000_0425:
1000:0425      e9 64 68                 JMP 0x1000:6c8c
1000:0428      e8 d0 53                 CALL 0x1000:57fb
                ; inline script -> 1000:0489  <c3><clear>     READY TO ABORT TREK.   HIT Esc TO CONTINUE PLAYING or  HIT ANY OTHER KEY TO REBOOT  
1000:0489  LAB_1000_0489:
1000:0489      e8 b9 06                 CALL 0x1000:0b45
1000:048c      74 fb                    JZ 0x1000:0489
1000:048e      c6 06 6e a2 01           MOV byte ptr [0xa26e],0x1
1000:0493      eb 0b                    JMP 0x1000:04a0

; ------------------------------------------------------------
1000:0496  FUN_1000_0496:
1000:0496      2e 8e 1e 00 00           MOV DS,word ptr CS:[0x0]
1000:049b      c6 06 6e a2 00           MOV byte ptr [0xa26e],0x0
1000:04a0  LAB_1000_04a0:
1000:04a0      e8 dc 59                 CALL 0x1000:5e7f
1000:04a3      b8 00 00                 MOV AX,0x0
1000:04a6      8e c0                    MOV ES,AX
1000:04a8      a1 7a a2                 MOV AX,[0xa27a]
1000:04ab      26 a3 70 00              MOV ES:[0x70],AX
1000:04af      a1 7c a2                 MOV AX,[0xa27c]
1000:04b2      26 a3 72 00              MOV ES:[0x72],AX
1000:04b6      2e a1 00 00              MOV AX,CS:[0x0]
1000:04ba      8e d8                    MOV DS,AX
1000:04bc      8e c0                    MOV ES,AX
1000:04be      b8 03 00                 MOV AX,0x3
1000:04c1      cd 10                    INT 0x10
1000:04c3      2e 8e 1e 04 00           MOV DS,word ptr CS:[0x4]
1000:04c8      2e ff 2e 02 00           JMPF CS:[0x2]

; ------------------------------------------------------------
1000:04cd  FUN_1000_04cd:
1000:04cd      be 07 00                 MOV SI,0x7
1000:04d0  LAB_1000_04d0:
1000:04d0      56                       PUSH SI
1000:04d1      e8 27 53                 CALL 0x1000:57fb
                ; inline script -> 1000:04ef  <c3><clear>CURRENT INITIALS ARE: 
1000:04ef  LAB_1000_04ef:
1000:04ef      e8 70 00                 CALL 0x1000:0562
1000:04f2      e8 06 53                 CALL 0x1000:57fb
                ; inline script -> 1000:051d  <c3>   Hit Esc to return to primary menu
1000:051d  LAB_1000_051d:
1000:051d      5e                       POP SI
1000:051e  LAB_1000_051e:
1000:051e      ff 06 d0 89              INC word ptr [0x89d0]
1000:0522      e8 20 06                 CALL 0x1000:0b45
1000:0525      74 f7                    JZ 0x1000:051e
1000:0527      3c 06                    CMP AL,0x6
1000:0529      74 a5                    JZ 0x1000:04d0
1000:052b      3c 0d                    CMP AL,0xd
1000:052d      74 30                    JZ 0x1000:055f
1000:052f      3c 08                    CMP AL,0x8
1000:0531      75 09                    JNZ 0x1000:053c
1000:0533      81 fe 07 00              CMP SI,0x7
1000:0537      74 e5                    JZ 0x1000:051e
1000:0539      4e                       DEC SI
1000:053a      eb e2                    JMP 0x1000:051e
1000:053c  LAB_1000_053c:
1000:053c      81 fe 07 00              CMP SI,0x7
1000:0540      74 04                    JZ 0x1000:0546
1000:0542      3c 20                    CMP AL,0x20
1000:0544      74 0a                    JZ 0x1000:0550
1000:0546  LAB_1000_0546:
1000:0546      24 df                    AND AL,0xdf
1000:0548      3c 41                    CMP AL,0x41
1000:054a      72 d2                    JC 0x1000:051e
1000:054c      3c 5a                    CMP AL,0x5a
1000:054e      77 ce                    JA 0x1000:051e
1000:0550  LAB_1000_0550:
1000:0550      88 04                    MOV byte ptr [SI],AL
1000:0552      46                       INC SI
1000:0553      81 fe 0a 00              CMP SI,0xa
1000:0557      72 03                    JC 0x1000:055c
1000:0559      e9 71 ff                 JMP 0x1000:04cd
1000:055c  LAB_1000_055c:
1000:055c      e9 71 ff                 JMP 0x1000:04d0
1000:055f  LAB_1000_055f:
1000:055f      e9 04 fc                 JMP 0x1000:0166

; ------------------------------------------------------------
1000:0562  FUN_1000_0562:
1000:0562      a0 07 00                 MOV AL,[0x7]
1000:0565      e8 0f 50                 CALL 0x1000:5577
1000:0568      a0 08 00                 MOV AL,[0x8]
1000:056b      e8 09 50                 CALL 0x1000:5577
1000:056e      a0 09 00                 MOV AL,[0x9]
1000:0571      e8 03 50                 CALL 0x1000:5577
1000:0574      c3                       RET
1000:0575      80 3e 07 00 20           CMP byte ptr [0x7],0x20
1000:057a      75 03                    JNZ 0x1000:057f
1000:057c      e9 4e ff                 JMP 0x1000:04cd
1000:057f  LAB_1000_057f:
1000:057f      e8 de 07                 CALL 0x1000:0d60
1000:0582      e9 ee 0e                 JMP 0x1000:1473

; ------------------------------------------------------------
1000:0585  FUN_1000_0585:
1000:0585      06                       PUSH ES
1000:0586      33 c0                    XOR AX,AX
1000:0588      8e c0                    MOV ES,AX
1000:058a      b9 04 00                 MOV CX,0x4
1000:058d  LAB_1000_058d:
1000:058d      80 26 0c 00 03           AND byte ptr [0xc],0x3
1000:0592      8a 1e 0c 00              MOV BL,byte ptr [0xc]
1000:0596      32 ff                    XOR BH,BH
1000:0598      d1 e3                    SHL BX,0x1
1000:059a      26 8b 87 00 04           MOV AX,word ptr ES:[BX + 0x400]
1000:059f      3d 00 00                 CMP AX,0x0
1000:05a2      75 12                    JNZ 0x1000:05b6
1000:05a4      fe 06 0c 00              INC byte ptr [0xc]
1000:05a8      80 26 0c 00 03           AND byte ptr [0xc],0x3
1000:05ad      e2 de                    LOOP 0x1000:058d
1000:05af      07                       POP ES
1000:05b0      c6 06 0a 00 01           MOV byte ptr [0xa],0x1
1000:05b5      c3                       RET
1000:05b6  LAB_1000_05b6:
1000:05b6      07                       POP ES
1000:05b7      a3 a7 00                 MOV [0xa7],AX
1000:05ba      c6 06 03 00 01           MOV byte ptr [0x3],0x1
1000:05bf      c3                       RET
1000:05c0      c6 06 3e a3 00           MOV byte ptr [0xa33e],0x0
1000:05c5  LAB_1000_05c5:
1000:05c5      e8 bd ff                 CALL 0x1000:0585
1000:05c8      a0 3e a3                 MOV AL,[0xa33e]
1000:05cb      b4 06                    MOV AH,0x6
1000:05cd      f6 e4                    MUL AH
1000:05cf      be ca 03                 MOV SI,0x3ca
1000:05d2      03 f0                    ADD SI,AX
1000:05d4      2e 8b 04                 MOV AX,word ptr CS:[SI]
1000:05d7      a3 91 00                 MOV [0x91],AX
1000:05da      2e 8b 44 02              MOV AX,word ptr CS:[SI + 0x2]
1000:05de      a3 93 00                 MOV [0x93],AX
1000:05e1      e8 17 52                 CALL 0x1000:57fb
                ; inline script -> 1000:0602  <c3><clear>          SETUP MENU    <c1>
1000:0602  LAB_1000_0602:
1000:0602      80 3e 0a 00 01           CMP byte ptr [0xa],0x1
1000:0607      74 03                    JZ 0x1000:060c
1000:0609      e9 bc 02                 JMP 0x1000:08c8
1000:060c  LAB_1000_060c:
1000:060c      e8 ec 51                 CALL 0x1000:57fb
                ; inline script -> 1000:0641  <c1>  ONE PLAYER (PRACTICE MODE)     GAME MODE IS 
1000:0641  LAB_1000_0641:
1000:0641      e8 ec 01                 CALL 0x1000:0830
1000:0644      e8 b4 51                 CALL 0x1000:57fb
                ; inline script -> 1000:0663  <c1>     PLAYER HANDICAP IS 
1000:0663  LAB_1000_0663:
1000:0663      a0 10 00                 MOV AL,[0x10]
1000:0666      e8 19 02                 CALL 0x1000:0882
1000:0669      e8 8f 51                 CALL 0x1000:57fb
                ; inline script -> 1000:068a  <c1>     COMPUTER HANDICAP IS 
1000:068a  LAB_1000_068a:
1000:068a      a0 11 00                 MOV AL,[0x11]
1000:068d      e8 f2 01                 CALL 0x1000:0882
1000:0690      e8 68 51                 CALL 0x1000:57fb
                ; inline script -> 1000:06ae  <c1>     COMPUTER SPEED IS 
1000:06ae  LAB_1000_06ae:
1000:06ae      a0 0f 00                 MOV AL,[0xf]
1000:06b1      e8 3b 01                 CALL 0x1000:07ef
1000:06b4      e8 44 51                 CALL 0x1000:57fb
                ; inline script -> 1000:06dc  <c1>     NUMBER OF COMPUTER BASES IS 
1000:06dc  LAB_1000_06dc:
1000:06dc      a0 13 00                 MOV AL,[0x13]
1000:06df      04 31                    ADD AL,0x31
1000:06e1      e8 93 4e                 CALL 0x1000:5577
1000:06e4      e8 14 51                 CALL 0x1000:57fb
                ; inline script -> 1000:0701  <c1>     PLAYING SPEED IS 
1000:0701  LAB_1000_0701:
1000:0701      a0 0d 00                 MOV AL,[0xd]
1000:0704      e8 e8 00                 CALL 0x1000:07ef
1000:0707      bb 8e 00                 MOV BX,0x8e
1000:070a      e8 ff 50                 CALL 0x1000:580c
1000:070d      e8 ae 04                 CALL 0x1000:0bbe
1000:0710  LAB_1000_0710:
1000:0710      ff 06 d0 89              INC word ptr [0x89d0]
1000:0714      e8 2e 04                 CALL 0x1000:0b45
1000:0717      74 f7                    JZ 0x1000:0710
1000:0719      3c 06                    CMP AL,0x6
1000:071b      74 15                    JZ 0x1000:0732
1000:071d      e8 e7 03                 CALL 0x1000:0b07
1000:0720      75 13                    JNZ 0x1000:0735
1000:0722      fe 06 3e a3              INC byte ptr [0xa33e]
1000:0726      80 3e 3e a3 07           CMP byte ptr [0xa33e],0x7
1000:072b      72 05                    JC 0x1000:0732
1000:072d      c6 06 3e a3 00           MOV byte ptr [0xa33e],0x0
1000:0732  LAB_1000_0732:
1000:0732      e9 90 fe                 JMP 0x1000:05c5
1000:0735  LAB_1000_0735:
1000:0735      e8 d6 03                 CALL 0x1000:0b0e
1000:0738      75 10                    JNZ 0x1000:074a
1000:073a      fe 0e 3e a3              DEC byte ptr [0xa33e]
1000:073e      80 3e 3e a3 ff           CMP byte ptr [0xa33e],0xff
1000:0743      75 05                    JNZ 0x1000:074a
1000:0745      c6 06 3e a3 06           MOV byte ptr [0xa33e],0x6
1000:074a  LAB_1000_074a:
1000:074a      3c 0d                    CMP AL,0xd
1000:074c      75 41                    JNZ 0x1000:078f
1000:074e      80 3e 3e a3 00           CMP byte ptr [0xa33e],0x0
1000:0753      75 0b                    JNZ 0x1000:0760
1000:0755      e8 bd 03                 CALL 0x1000:0b15
1000:0758      c6 06 3e a3 00           MOV byte ptr [0xa33e],0x0
1000:075d      eb 62                    JMP 0x1000:07c1
1000:0760  LAB_1000_0760:
1000:0760      80 3e 3e a3 01           CMP byte ptr [0xa33e],0x1
1000:0765      75 13                    JNZ 0x1000:077a
1000:0767      a0 12 00                 MOV AL,[0x12]
1000:076a      80 26 12 00 fc           AND byte ptr [0x12],0xfc
1000:076f      fe c0                    INC AL
1000:0771      24 03                    AND AL,0x3
1000:0773      08 06 12 00              OR byte ptr [0x12],AL
1000:0777      eb 48                    JMP 0x1000:07c1
1000:077a  LAB_1000_077a:
1000:077a      80 3e 3e a3 02           CMP byte ptr [0xa33e],0x2
1000:077f      75 11                    JNZ 0x1000:0792
1000:0781      80 2e 10 00 02           SUB byte ptr [0x10],0x2
1000:0786      80 26 10 00 03           AND byte ptr [0x10],0x3
1000:078b      fe 06 10 00              INC byte ptr [0x10]
1000:078f  LAB_1000_078f:
1000:078f      eb 30                    JMP 0x1000:07c1
1000:0792  LAB_1000_0792:
1000:0792      80 3e 3e a3 03           CMP byte ptr [0xa33e],0x3
1000:0797      75 11                    JNZ 0x1000:07aa
1000:0799      80 2e 11 00 02           SUB byte ptr [0x11],0x2
1000:079e      80 26 11 00 03           AND byte ptr [0x11],0x3
1000:07a3      fe 06 11 00              INC byte ptr [0x11]
1000:07a7      eb 18                    JMP 0x1000:07c1
1000:07aa  LAB_1000_07aa:
1000:07aa      80 3e 3e a3 04           CMP byte ptr [0xa33e],0x4
1000:07af      75 13                    JNZ 0x1000:07c4
1000:07b1      fe 06 0f 00              INC byte ptr [0xf]
1000:07b5      80 3e 0f 00 04           CMP byte ptr [0xf],0x4
1000:07ba      72 05                    JC 0x1000:07c1
1000:07bc      c6 06 0f 00 00           MOV byte ptr [0xf],0x0
1000:07c1  LAB_1000_07c1:
1000:07c1      e9 01 fe                 JMP 0x1000:05c5
1000:07c4  LAB_1000_07c4:
1000:07c4      80 3e 3e a3 05           CMP byte ptr [0xa33e],0x5
1000:07c9      75 12                    JNZ 0x1000:07dd
1000:07cb      fe 06 13 00              INC byte ptr [0x13]
1000:07cf      80 3e 13 00 03           CMP byte ptr [0x13],0x3
1000:07d4      72 eb                    JC 0x1000:07c1
1000:07d6      c6 06 13 00 00           MOV byte ptr [0x13],0x0
1000:07db      eb e4                    JMP 0x1000:07c1
1000:07dd  LAB_1000_07dd:
1000:07dd      fe 06 0d 00              INC byte ptr [0xd]
1000:07e1      80 3e 0d 00 04           CMP byte ptr [0xd],0x4
1000:07e6      72 d9                    JC 0x1000:07c1
1000:07e8      c6 06 0d 00 00           MOV byte ptr [0xd],0x0
1000:07ed      eb d2                    JMP 0x1000:07c1

; ------------------------------------------------------------
1000:07ef  FUN_1000_07ef:
1000:07ef      22 c0                    AND AL,AL
1000:07f1      75 0c                    JNZ 0x1000:07ff
1000:07f3      e8 05 50                 CALL 0x1000:57fb
                ; inline script -> 1000:07fe  <c1>SLOW
1000:07fe  LAB_1000_07fe:
1000:07fe      c3                       RET
1000:07ff  LAB_1000_07ff:
1000:07ff      fe c8                    DEC AL
1000:0801      75 0e                    JNZ 0x1000:0811
1000:0803      e8 f5 4f                 CALL 0x1000:57fb
                ; inline script -> 1000:0810  <c1>MEDIUM
1000:0810  LAB_1000_0810:
1000:0810      c3                       RET
1000:0811  LAB_1000_0811:
1000:0811      fe c8                    DEC AL
1000:0813      75 0c                    JNZ 0x1000:0821
1000:0815      e8 e3 4f                 CALL 0x1000:57fb
                ; inline script -> 1000:0820  <c1>FAST
1000:0820  LAB_1000_0820:
1000:0820      c3                       RET
1000:0821  LAB_1000_0821:
1000:0821      e8 d7 4f                 CALL 0x1000:57fb
                ; inline script -> 1000:082f  <c1>MAXIMUM
1000:082f  LAB_1000_082f:
1000:082f      c3                       RET

; ------------------------------------------------------------
1000:0830  FUN_1000_0830:
1000:0830      a0 12 00                 MOV AL,[0x12]
1000:0833      24 01                    AND AL,0x1
1000:0835      75 0f                    JNZ 0x1000:0846
1000:0837      e8 c1 4f                 CALL 0x1000:57fb
                ; inline script -> 1000:0844  <c1>LONG, 
1000:0844  LAB_1000_0844:
1000:0844      eb 0e                    JMP 0x1000:0854
1000:0846  LAB_1000_0846:
1000:0846      e8 b2 4f                 CALL 0x1000:57fb
                ; inline script -> 1000:0854  <c1>TIMED, 
1000:0854  LAB_1000_0854:
1000:0854      a0 12 00                 MOV AL,[0x12]
1000:0857      24 02                    AND AL,0x2
1000:0859      75 14                    JNZ 0x1000:086f
1000:085b      e8 9d 4f                 CALL 0x1000:57fb
                ; inline script -> 1000:086e  <c1>SINGLE-PLANE
1000:086e  LAB_1000_086e:
1000:086e      c3                       RET
1000:086f  LAB_1000_086f:
1000:086f      e8 89 4f                 CALL 0x1000:57fb
                ; inline script -> 1000:0881  <c1>MULTI-PLANE
1000:0881  LAB_1000_0881:
1000:0881      c3                       RET

; ------------------------------------------------------------
1000:0882  FUN_1000_0882:
1000:0882      fe c8                    DEC AL
1000:0884      75 0e                    JNZ 0x1000:0894
1000:0886      e8 72 4f                 CALL 0x1000:57fb
                ; inline script -> 1000:0893  <c1>EXPERT
1000:0893  LAB_1000_0893:
1000:0893      c3                       RET
1000:0894  LAB_1000_0894:
1000:0894      fe c8                    DEC AL
1000:0896      75 0e                    JNZ 0x1000:08a6
1000:0898      e8 60 4f                 CALL 0x1000:57fb
                ; inline script -> 1000:08a5  <c1>NORMAL
1000:08a5  LAB_1000_08a5:
1000:08a5      c3                       RET
1000:08a6  LAB_1000_08a6:
1000:08a6      fe c8                    DEC AL
1000:08a8      75 0e                    JNZ 0x1000:08b8
1000:08aa      e8 4e 4f                 CALL 0x1000:57fb
                ; inline script -> 1000:08b7  <c1>NOVICE
1000:08b7  LAB_1000_08b7:
1000:08b7      c3                       RET
1000:08b8  LAB_1000_08b8:
1000:08b8      e8 40 4f                 CALL 0x1000:57fb
                ; inline script -> 1000:08c7  <c1>BEGINNER
1000:08c7  LAB_1000_08c7:
1000:08c7      c3                       RET

; ------------------------------------------------------------
1000:08c8  FUN_1000_08c8:
1000:08c8      e8 30 4f                 CALL 0x1000:57fb
                ; inline script -> 1000:08fa  <c1>  TWO PLAYER (MODEM MODE)     GAME MODE IS 
1000:08fa  LAB_1000_08fa:
1000:08fa      e8 33 ff                 CALL 0x1000:0830
1000:08fd      e8 fb 4e                 CALL 0x1000:57fb
                ; inline script -> 1000:0907  <c1>   
1000:0907  LAB_1000_0907:
1000:0907      e8 f1 4e                 CALL 0x1000:57fb
                ; inline script -> 1000:0923  <c1>  PLAYER HANDICAP IS 
1000:0923  LAB_1000_0923:
1000:0923      a0 10 00                 MOV AL,[0x10]
1000:0926      e8 59 ff                 CALL 0x1000:0882
1000:0929      e8 cf 4e                 CALL 0x1000:57fb
                ; inline script -> 1000:0942  <c1>     BAUD RATE IS 
1000:0942  LAB_1000_0942:
1000:0942      e8 25 03                 CALL 0x1000:0c6a
1000:0945      e8 b3 4e                 CALL 0x1000:57fb
                ; inline script -> 1000:0961  <c1>     COMM PORT IS COM
1000:0961  LAB_1000_0961:
1000:0961      a0 0c 00                 MOV AL,[0xc]
1000:0964      04 31                    ADD AL,0x31
1000:0966      e8 0e 4c                 CALL 0x1000:5577
1000:0969      e8 8f 4e                 CALL 0x1000:57fb
                ; inline script -> 1000:0973  <c1>: (
1000:0973  LAB_1000_0973:
1000:0973      a0 a8 00                 MOV AL,[0xa8]
1000:0976      e8 d9 02                 CALL 0x1000:0c52
1000:0979      a0 a7 00                 MOV AL,[0xa7]
1000:097c      e8 d3 02                 CALL 0x1000:0c52
1000:097f      e8 79 4e                 CALL 0x1000:57fb
                ; inline script -> 1000:099b  <c1>H)     CONNECTION IS 
1000:099b  LAB_1000_099b:
1000:099b      a0 0e 00                 MOV AL,[0xe]
1000:099e      22 c0                    AND AL,AL
1000:09a0      75 1a                    JNZ 0x1000:09bc
1000:09a2      e8 56 4e                 CALL 0x1000:57fb
                ; inline script -> 1000:09b9  <c1>ACOUSTIC COUPLER
1000:09b9  LAB_1000_09b9:
1000:09b9      eb 13                    JMP 0x1000:09ce
1000:09bc  LAB_1000_09bc:
1000:09bc      e8 3c 4e                 CALL 0x1000:57fb
                ; inline script -> 1000:09ce  <c1>SMART MODEM
1000:09ce  LAB_1000_09ce:
1000:09ce      e8 2a 4e                 CALL 0x1000:57fb
                ; inline script -> 1000:09f1  <c1>     NUMBER OF COMPUTERS IS 
1000:09f1  LAB_1000_09f1:
1000:09f1      f6 06 12 00 0c           TEST byte ptr [0x12],0xc
1000:09f6      b0 30                    MOV AL,0x30
1000:09f8      74 0b                    JZ 0x1000:0a05
1000:09fa      fe c0                    INC AL
1000:09fc      f6 06 12 00 08           TEST byte ptr [0x12],0x8
1000:0a01      74 02                    JZ 0x1000:0a05
1000:0a03      fe c0                    INC AL
1000:0a05  LAB_1000_0a05:
1000:0a05      e8 6f 4b                 CALL 0x1000:5577
1000:0a08      e8 f0 4d                 CALL 0x1000:57fb
                ; inline script -> 1000:0a25  <c1>     PLAYING SPEED IS 
1000:0a25  LAB_1000_0a25:
1000:0a25      a0 0d 00                 MOV AL,[0xd]
1000:0a28      e8 c4 fd                 CALL 0x1000:07ef
1000:0a2b      bb 8e 00                 MOV BX,0x8e
1000:0a2e      e8 db 4d                 CALL 0x1000:580c
1000:0a31      e8 8a 01                 CALL 0x1000:0bbe
1000:0a34  LAB_1000_0a34:
1000:0a34      ff 06 d0 89              INC word ptr [0x89d0]
1000:0a38      e8 0a 01                 CALL 0x1000:0b45
1000:0a3b      74 f7                    JZ 0x1000:0a34
1000:0a3d      3c 06                    CMP AL,0x6
1000:0a3f      74 3f                    JZ 0x1000:0a80
1000:0a41      b3 08                    MOV BL,0x8
1000:0a43      e8 c1 00                 CALL 0x1000:0b07
1000:0a46      75 0f                    JNZ 0x1000:0a57
1000:0a48      fe 06 3e a3              INC byte ptr [0xa33e]
1000:0a4c      38 1e 3e a3              CMP byte ptr [0xa33e],BL
1000:0a50      72 05                    JC 0x1000:0a57
1000:0a52      c6 06 3e a3 00           MOV byte ptr [0xa33e],0x0
1000:0a57  LAB_1000_0a57:
1000:0a57      e8 b4 00                 CALL 0x1000:0b0e
1000:0a5a      75 11                    JNZ 0x1000:0a6d
1000:0a5c      fe 0e 3e a3              DEC byte ptr [0xa33e]
1000:0a60      80 3e 3e a3 ff           CMP byte ptr [0xa33e],0xff
1000:0a65      75 06                    JNZ 0x1000:0a6d
1000:0a67      fe cb                    DEC BL
1000:0a69      88 1e 3e a3              MOV byte ptr [0xa33e],BL
1000:0a6d  LAB_1000_0a6d:
1000:0a6d      3c 0d                    CMP AL,0xd
1000:0a6f      75 0f                    JNZ 0x1000:0a80
1000:0a71      a0 3e a3                 MOV AL,[0xa33e]
1000:0a74      22 c0                    AND AL,AL
1000:0a76      75 0b                    JNZ 0x1000:0a83
1000:0a78      e8 9a 00                 CALL 0x1000:0b15
1000:0a7b      c6 06 3e a3 00           MOV byte ptr [0xa33e],0x0
1000:0a80  LAB_1000_0a80:
1000:0a80      e9 42 fb                 JMP 0x1000:05c5
1000:0a83  LAB_1000_0a83:
1000:0a83      fe c8                    DEC AL
1000:0a85      75 13                    JNZ 0x1000:0a9a
1000:0a87      a0 12 00                 MOV AL,[0x12]
1000:0a8a      80 26 12 00 fc           AND byte ptr [0x12],0xfc
1000:0a8f      fe c0                    INC AL
1000:0a91      24 03                    AND AL,0x3
1000:0a93      08 06 12 00              OR byte ptr [0x12],AL
1000:0a97      e9 2b fb                 JMP 0x1000:05c5
1000:0a9a  LAB_1000_0a9a:
1000:0a9a      fe c8                    DEC AL
1000:0a9c      75 14                    JNZ 0x1000:0ab2
1000:0a9e      fe 0e 10 00              DEC byte ptr [0x10]
1000:0aa2      fe 0e 10 00              DEC byte ptr [0x10]
1000:0aa6      80 26 10 00 03           AND byte ptr [0x10],0x3
1000:0aab      fe 06 10 00              INC byte ptr [0x10]
1000:0aaf      eb 41                    JMP 0x1000:0af2
1000:0ab2  LAB_1000_0ab2:
1000:0ab2      fe c8                    DEC AL
1000:0ab4      75 11                    JNZ 0x1000:0ac7
1000:0ab6      c6 06 03 00 01           MOV byte ptr [0x3],0x1
1000:0abb      fe 06 0b 00              INC byte ptr [0xb]
1000:0abf      80 26 0b 00 07           AND byte ptr [0xb],0x7
1000:0ac4      eb 2c                    JMP 0x1000:0af2
1000:0ac7  LAB_1000_0ac7:
1000:0ac7      fe c8                    DEC AL
1000:0ac9      75 0f                    JNZ 0x1000:0ada
1000:0acb      c6 06 03 00 01           MOV byte ptr [0x3],0x1
1000:0ad0      fe 06 0c 00              INC byte ptr [0xc]
1000:0ad4      e8 ae fa                 CALL 0x1000:0585
1000:0ad7      eb 19                    JMP 0x1000:0af2
1000:0ada  LAB_1000_0ada:
1000:0ada      fe c8                    DEC AL
1000:0adc      75 0d                    JNZ 0x1000:0aeb
1000:0ade      80 26 0e 00 01           AND byte ptr [0xe],0x1
1000:0ae3      80 36 0e 00 01           XOR byte ptr [0xe],0x1
1000:0ae8      eb 08                    JMP 0x1000:0af2
1000:0aeb  LAB_1000_0aeb:
1000:0aeb      fe c8                    DEC AL
1000:0aed      75 06                    JNZ 0x1000:0af5
1000:0aef      e8 36 00                 CALL 0x1000:0b28
1000:0af2  LAB_1000_0af2:
1000:0af2      e9 d0 fa                 JMP 0x1000:05c5
1000:0af5  LAB_1000_0af5:
1000:0af5      fe 06 0d 00              INC byte ptr [0xd]
1000:0af9      80 3e 0d 00 04           CMP byte ptr [0xd],0x4
1000:0afe      72 f2                    JC 0x1000:0af2
1000:0b00      c6 06 0d 00 00           MOV byte ptr [0xd],0x0
1000:0b05      eb eb                    JMP 0x1000:0af2

; ------------------------------------------------------------
1000:0b07  FUN_1000_0b07:
1000:0b07      3c 2b                    CMP AL,0x2b
1000:0b09      74 02                    JZ 0x1000:0b0d
1000:0b0b      3c d0                    CMP AL,0xd0
1000:0b0d  LAB_1000_0b0d:
1000:0b0d      c3                       RET

; ------------------------------------------------------------
1000:0b0e  FUN_1000_0b0e:
1000:0b0e      3c 2d                    CMP AL,0x2d
1000:0b10      74 02                    JZ 0x1000:0b14
1000:0b12      3c c8                    CMP AL,0xc8
1000:0b14  LAB_1000_0b14:
1000:0b14      c3                       RET

; ------------------------------------------------------------
1000:0b15  FUN_1000_0b15:
1000:0b15      80 3e 0a 00 01           CMP byte ptr [0xa],0x1
1000:0b1a      74 06                    JZ 0x1000:0b22
1000:0b1c      c6 06 0a 00 01           MOV byte ptr [0xa],0x1
1000:0b21      c3                       RET
1000:0b22  LAB_1000_0b22:
1000:0b22      c6 06 0a 00 02           MOV byte ptr [0xa],0x2
1000:0b27      c3                       RET

; ------------------------------------------------------------
1000:0b28  FUN_1000_0b28:
1000:0b28      a0 12 00                 MOV AL,[0x12]
1000:0b2b      24 0c                    AND AL,0xc
1000:0b2d      75 06                    JNZ 0x1000:0b35
1000:0b2f      80 0e 12 00 04           OR byte ptr [0x12],0x4
1000:0b34      c3                       RET
1000:0b35  LAB_1000_0b35:
1000:0b35      3c 04                    CMP AL,0x4
1000:0b37      75 06                    JNZ 0x1000:0b3f
1000:0b39      80 0e 12 00 08           OR byte ptr [0x12],0x8
1000:0b3e      c3                       RET
1000:0b3f  LAB_1000_0b3f:
1000:0b3f      80 26 12 00 f3           AND byte ptr [0x12],0xf3
1000:0b44      c3                       RET

; ------------------------------------------------------------
1000:0b45  FUN_1000_0b45:
1000:0b45      b4 01                    MOV AH,0x1
1000:0b47      cd 16                    INT 0x16
1000:0b49      b0 00                    MOV AL,0x0
1000:0b4b      74 61                    JZ 0x1000:0bae
1000:0b4d      b4 00                    MOV AH,0x0
1000:0b4f      cd 16                    INT 0x16
1000:0b51      3c 1b                    CMP AL,0x1b
1000:0b53      75 0e                    JNZ 0x1000:0b63
1000:0b55      c6 06 72 a2 01           MOV byte ptr [0xa272],0x1
1000:0b5a      c6 06 6c a2 00           MOV byte ptr [0xa26c],0x0
1000:0b5f      ff 26 a5 00              JMP word ptr [0xa5]
1000:0b63  LAB_1000_0b63:
1000:0b63      80 fc 52                 CMP AH,0x52
1000:0b66      74 09                    JZ 0x1000:0b71
1000:0b68      80 fc 53                 CMP AH,0x53
1000:0b6b      74 04                    JZ 0x1000:0b71
1000:0b6d      3c 00                    CMP AL,0x0
1000:0b6f      75 05                    JNZ 0x1000:0b76
1000:0b71  LAB_1000_0b71:
1000:0b71      80 cc 80                 OR AH,0x80
1000:0b74      8a c4                    MOV AL,AH
1000:0b76  LAB_1000_0b76:
1000:0b76      3c 13                    CMP AL,0x13
1000:0b78      75 07                    JNZ 0x1000:0b81
1000:0b7a      80 36 14 00 03           XOR byte ptr [0x14],0x3
1000:0b7f      eb c4                    JMP 0x1000:0b45
1000:0b81  LAB_1000_0b81:
1000:0b81      3c 04                    CMP AL,0x4
1000:0b83      75 00                    JNZ 0x1000:0b85
1000:0b85  LAB_1000_0b85:
1000:0b85      3c 06                    CMP AL,0x6
1000:0b87      75 17                    JNZ 0x1000:0ba0
1000:0b89      81 3e 16 00 cd 28        CMP word ptr [0x16],0x28cd
1000:0b8f      c7 06 16 00 cd 28        MOV word ptr [0x16],0x28cd
1000:0b95      75 06                    JNZ 0x1000:0b9d
1000:0b97      c7 06 16 00 1d 31        MOV word ptr [0x16],0x311d
1000:0b9d  LAB_1000_0b9d:
1000:0b9d      22 c0                    AND AL,AL
1000:0b9f      c3                       RET
1000:0ba0  LAB_1000_0ba0:
1000:0ba0      3c 10                    CMP AL,0x10
1000:0ba2      75 0a                    JNZ 0x1000:0bae
1000:0ba4      80 36 15 00 01           XOR byte ptr [0x15],0x1
1000:0ba9      e8 03 00                 CALL 0x1000:0baf
1000:0bac      eb 97                    JMP 0x1000:0b45
1000:0bae  LAB_1000_0bae:
1000:0bae      c3                       RET

; ------------------------------------------------------------
1000:0baf  FUN_1000_0baf:
1000:0baf      50                       PUSH AX
1000:0bb0      53                       PUSH BX
1000:0bb1      b4 0b                    MOV AH,0xb
1000:0bb3      8a 1e 15 00              MOV BL,byte ptr [0x15]
1000:0bb7      b7 01                    MOV BH,0x1
1000:0bb9      cd 10                    INT 0x10
1000:0bbb      5b                       POP BX
1000:0bbc      58                       POP AX
1000:0bbd      c3                       RET

; ------------------------------------------------------------
1000:0bbe  FUN_1000_0bbe:
1000:0bbe      e8 3a 4c                 CALL 0x1000:57fb
                ; inline script -> 1000:0bec  <c1><box>Hit Esc to return to primary menu.
1000:0bec  LAB_1000_0bec:
1000:0bec      b0 01                    MOV AL,0x1

; ------------------------------------------------------------
1000:0bee  FUN_1000_0bee:
1000:0bee      50                       PUSH AX
1000:0bef      e8 09 4c                 CALL 0x1000:57fb
                ; inline script -> 1000:0c17  <c1><box><c3><c1> or <c3><c1> to select,    to 
1000:0c17  LAB_1000_0c17:
1000:0c17      58                       POP AX
1000:0c18      22 c0                    AND AL,AL
1000:0c1a      75 12                    JNZ 0x1000:0c2e
1000:0c1c      e8 dc 4b                 CALL 0x1000:57fb
                ; inline script -> 1000:0c2b  <c1>execute.
1000:0c2b  LAB_1000_0c2b:
1000:0c2b      eb 10                    JMP 0x1000:0c3d
1000:0c2e  LAB_1000_0c2e:
1000:0c2e      e8 ca 4b                 CALL 0x1000:57fb
                ; inline script -> 1000:0c3d  <c1>change. 
1000:0c3d  LAB_1000_0c3d:
1000:0c3d      e8 bb 4b                 CALL 0x1000:57fb
                ; inline script -> 1000:0c4b  <c1><pic>
1000:0c4b  LAB_1000_0c4b:
1000:0c4b      c3                       RET

; ------------------------------------------------------------
1000:0c4c  FUN_1000_0c4c:
1000:0c4c      fa                       CLI
1000:0c4d      e8 2b 53                 CALL 0x1000:5f7b
1000:0c50      fb                       STI
1000:0c51      c3                       RET

; ------------------------------------------------------------
1000:0c52  FUN_1000_0c52:
1000:0c52      50                       PUSH AX
1000:0c53      d0 e8                    SHR AL,0x1
1000:0c55      d0 e8                    SHR AL,0x1
1000:0c57      d0 e8                    SHR AL,0x1
1000:0c59      d0 e8                    SHR AL,0x1
1000:0c5b      e8 01 00                 CALL 0x1000:0c5f
1000:0c5e      58                       POP AX

; ------------------------------------------------------------
1000:0c5f  thunk_FUN_1000_5577:
1000:0c5f      24 0f                    AND AL,0xf
1000:0c61      04 90                    ADD AL,0x90
1000:0c63      27                       DAA
1000:0c64      14 40                    ADC AL,0x40
1000:0c66      27                       DAA
1000:0c67      e9 0d 49                 JMP 0x1000:5577

; ------------------------------------------------------------
1000:0c6a  FUN_1000_0c6a:
1000:0c6a      a0 0b 00                 MOV AL,[0xb]
1000:0c6d      24 07                    AND AL,0x7
1000:0c6f      b4 05                    MOV AH,0x5
1000:0c71      f6 e4                    MUL AH
1000:0c73      bb a9 00                 MOV BX,0xa9
1000:0c76      03 d8                    ADD BX,AX
1000:0c78      e8 91 4b                 CALL 0x1000:580c
1000:0c7b      c3                       RET

; ------------------------------------------------------------
1000:0c7c  FUN_1000_0c7c:
1000:0c7c      be 06 00                 MOV SI,0x6
1000:0c7f      b9 66 ac                 MOV CX,0xac66
1000:0c82      2b ce                    SUB CX,SI
1000:0c84      d1 e9                    SHR CX,0x1
1000:0c86      33 c0                    XOR AX,AX
1000:0c88  LAB_1000_0c88:
1000:0c88      2e 03 04                 ADD AX,word ptr CS:[SI]
1000:0c8b      83 c6 02                 ADD SI,0x2
1000:0c8e      e2 f8                    LOOP 0x1000:0c88
1000:0c90      23 c0                    AND AX,AX
1000:0c92      75 06                    JNZ 0x1000:0c9a
1000:0c94      a0 00 a2                 MOV AL,[0xa200]
1000:0c97      e6 21                    OUT 0x21,AL
1000:0c99      c3                       RET
1000:0c9a  LAB_1000_0c9a:
1000:0c9a      fa                       CLI
1000:0c9b      b0 ff                    MOV AL,0xff
1000:0c9d      e6 21                    OUT 0x21,AL
1000:0c9f      e8 59 4b                 CALL 0x1000:57fb
                ; inline script -> 1000:0d5d  <c2><clear>    Program Corrupted!!  Due To Unauthorized Modification.  Can Not Continue.   Obtain A New Copy By Sending $10.00 To:      Carl McLawhorn     700 M
1000:0d5d  LAB_1000_0d5d:
1000:0d5d      e9 b7 5f                 JMP 0x1000:6d17

; ------------------------------------------------------------
1000:0d60  FUN_1000_0d60:
1000:0d60      80 3e 03 00 00           CMP byte ptr [0x3],0x0
1000:0d65      74 03                    JZ 0x1000:0d6a
1000:0d67      e8 6c 50                 CALL 0x1000:5dd6
1000:0d6a  LAB_1000_0d6a:
1000:0d6a      c6 06 03 00 00           MOV byte ptr [0x3],0x0
1000:0d6f      c3                       RET
1000:0d70      e8 88 4a                 CALL 0x1000:57fb
                ; inline script -> 1000:0d7b  <c3><clear>   
1000:0d7b  LAB_1000_0d7b:
1000:0d7b      e8 e2 ff                 CALL 0x1000:0d60
1000:0d7e      c6 06 40 a3 ff           MOV byte ptr [0xa340],0xff
1000:0d83      e8 c6 fe                 CALL 0x1000:0c4c
1000:0d86      e8 34 00                 CALL 0x1000:0dbd
1000:0d89  LAB_1000_0d89:
1000:0d89      e8 f9 01                 CALL 0x1000:0f85
1000:0d8c      e8 fd 50                 CALL 0x1000:5e8c
1000:0d8f      72 06                    JC 0x1000:0d97
1000:0d91      bb 9b 00                 MOV BX,0x9b
1000:0d94      e8 fa 00                 CALL 0x1000:0e91
1000:0d97  LAB_1000_0d97:
1000:0d97      e8 ab fd                 CALL 0x1000:0b45
1000:0d9a      74 ed                    JZ 0x1000:0d89
1000:0d9c      3c 0d                    CMP AL,0xd
1000:0d9e      75 12                    JNZ 0x1000:0db2
1000:0da0      e8 34 51                 CALL 0x1000:5ed7
1000:0da3      b0 0d                    MOV AL,0xd
1000:0da5      72 0b                    JC 0x1000:0db2
1000:0da7      bb a0 00                 MOV BX,0xa0
1000:0daa      e8 e4 00                 CALL 0x1000:0e91
1000:0dad      e8 08 51                 CALL 0x1000:5eb8
1000:0db0      b0 0a                    MOV AL,0xa
1000:0db2  LAB_1000_0db2:
1000:0db2      bb a0 00                 MOV BX,0xa0
1000:0db5      e8 d9 00                 CALL 0x1000:0e91
1000:0db8      e8 fd 50                 CALL 0x1000:5eb8
1000:0dbb      eb cc                    JMP 0x1000:0d89

; ------------------------------------------------------------
1000:0dbd  FUN_1000_0dbd:
1000:0dbd      c6 06 9b 00 00           MOV byte ptr [0x9b],0x0
1000:0dc2      c6 06 9c 00 00           MOV byte ptr [0x9c],0x0
1000:0dc7      c6 06 a0 00 00           MOV byte ptr [0xa0],0x0
1000:0dcc      c6 06 a1 00 00           MOV byte ptr [0xa1],0x0
1000:0dd1      c6 06 96 00 00           MOV byte ptr [0x96],0x0
1000:0dd6      c6 06 97 00 00           MOV byte ptr [0x97],0x0
1000:0ddb      bf 00 00                 MOV DI,0x0
1000:0dde      b9 c8 00                 MOV CX,0xc8
1000:0de1  LAB_1000_0de1:
1000:0de1      b0 20                    MOV AL,0x20
1000:0de3      bb 96 00                 MOV BX,0x96
1000:0de6      e8 a8 00                 CALL 0x1000:0e91
1000:0de9      e2 f6                    LOOP 0x1000:0de1
1000:0deb      e8 82 00                 CALL 0x1000:0e70
                ; encoded string -> 1000:0e1a  <c1>------------- RECEIVE AREA -------------
1000:0e1a  LAB_1000_0e1a:
1000:0e1a      b9 68 01                 MOV CX,0x168
1000:0e1d  LAB_1000_0e1d:
1000:0e1d      b0 20                    MOV AL,0x20
1000:0e1f      bb 96 00                 MOV BX,0x96
1000:0e22      e8 6c 00                 CALL 0x1000:0e91
1000:0e25      e2 f6                    LOOP 0x1000:0e1d
1000:0e27      e8 46 00                 CALL 0x1000:0e70
                ; encoded string -> 1000:0e56  <c1>--------------- SEND AREA --------------
1000:0e56  LAB_1000_0e56:
1000:0e56      b9 68 01                 MOV CX,0x168
1000:0e59  LAB_1000_0e59:
1000:0e59      b0 20                    MOV AL,0x20
1000:0e5b      bb 96 00                 MOV BX,0x96
1000:0e5e      e8 30 00                 CALL 0x1000:0e91
1000:0e61      e2 f6                    LOOP 0x1000:0e59
1000:0e63      bb a0 00                 MOV BX,0xa0
1000:0e66      e8 f3 00                 CALL 0x1000:0f5c
1000:0e69      bb 9b 00                 MOV BX,0x9b
1000:0e6c      e8 ed 00                 CALL 0x1000:0f5c
1000:0e6f      c3                       RET

; ------------------------------------------------------------
1000:0e70  print_encoded:
1000:0e70      5b                       POP BX
1000:0e71      c6 06 64 a2 01           MOV byte ptr [0xa264],0x1
1000:0e76  LAB_1000_0e76:
1000:0e76      2e 8a 07                 MOV AL,byte ptr CS:[BX]
1000:0e79      e8 f0 4a                 CALL 0x1000:596c
1000:0e7c      43                       INC BX
1000:0e7d      22 c0                    AND AL,AL
1000:0e7f      74 0e                    JZ 0x1000:0e8f
1000:0e81      3c 04                    CMP AL,0x4
1000:0e83      72 f1                    JC 0x1000:0e76
1000:0e85      53                       PUSH BX
1000:0e86      bb 96 00                 MOV BX,0x96
1000:0e89      e8 05 00                 CALL 0x1000:0e91
1000:0e8c      5b                       POP BX
1000:0e8d      eb e7                    JMP 0x1000:0e76
1000:0e8f  LAB_1000_0e8f:
1000:0e8f      ff e3                    JMP BX

; ------------------------------------------------------------
1000:0e91  FUN_1000_0e91:
1000:0e91      e8 c8 00                 CALL 0x1000:0f5c
1000:0e94      e8 a9 00                 CALL 0x1000:0f40
1000:0e97      3c 0d                    CMP AL,0xd
1000:0e99      75 06                    JNZ 0x1000:0ea1
1000:0e9b      c6 07 00                 MOV byte ptr [BX],0x0
1000:0e9e      eb 57                    JMP 0x1000:0ef7
1000:0ea1  LAB_1000_0ea1:
1000:0ea1      3c 0a                    CMP AL,0xa
1000:0ea3      75 06                    JNZ 0x1000:0eab
1000:0ea5      fe 47 01                 INC byte ptr [BX + 0x1]
1000:0ea8      eb 3a                    JMP 0x1000:0ee4
1000:0eab  LAB_1000_0eab:
1000:0eab      3c 07                    CMP AL,0x7
1000:0ead      75 09                    JNZ 0x1000:0eb8
1000:0eaf      c7 06 5a a2 04 00        MOV word ptr [0xa25a],0x4
1000:0eb5      eb 40                    JMP 0x1000:0ef7
1000:0eb8  LAB_1000_0eb8:
1000:0eb8      3c 08                    CMP AL,0x8
1000:0eba      75 14                    JNZ 0x1000:0ed0
1000:0ebc      80 3f 00                 CMP byte ptr [BX],0x0
1000:0ebf      74 36                    JZ 0x1000:0ef7
1000:0ec1      fe 0f                    DEC byte ptr [BX]
1000:0ec3      83 ef 02                 SUB DI,0x2
1000:0ec6      b0 20                    MOV AL,0x20
1000:0ec8      e8 20 03                 CALL 0x1000:11eb
1000:0ecb      b0 08                    MOV AL,0x8
1000:0ecd      eb 28                    JMP 0x1000:0ef7
1000:0ed0  LAB_1000_0ed0:
1000:0ed0      3c 20                    CMP AL,0x20
1000:0ed2      72 23                    JC 0x1000:0ef7
1000:0ed4      e8 14 03                 CALL 0x1000:11eb
1000:0ed7      fe 07                    INC byte ptr [BX]
1000:0ed9      80 3f 28                 CMP byte ptr [BX],0x28
1000:0edc      72 06                    JC 0x1000:0ee4
1000:0ede      c6 07 00                 MOV byte ptr [BX],0x0
1000:0ee1      fe 47 01                 INC byte ptr [BX + 0x1]
1000:0ee4  LAB_1000_0ee4:
1000:0ee4      8a 67 01                 MOV AH,byte ptr [BX + 0x1]
1000:0ee7      3a 67 02                 CMP AH,byte ptr [BX + 0x2]
1000:0eea      72 0b                    JC 0x1000:0ef7
1000:0eec      8a 67 02                 MOV AH,byte ptr [BX + 0x2]
1000:0eef      fe cc                    DEC AH
1000:0ef1      88 67 01                 MOV byte ptr [BX + 0x1],AH
1000:0ef4      e8 04 00                 CALL 0x1000:0efb
1000:0ef7  LAB_1000_0ef7:
1000:0ef7      e8 62 00                 CALL 0x1000:0f5c
1000:0efa      c3                       RET

; ------------------------------------------------------------
1000:0efb  FUN_1000_0efb:
1000:0efb      50                       PUSH AX
1000:0efc      1e                       PUSH DS
1000:0efd      06                       PUSH ES
1000:0efe      57                       PUSH DI
1000:0eff      56                       PUSH SI
1000:0f00      53                       PUSH BX
1000:0f01      51                       PUSH CX
1000:0f02      8b 7f 03                 MOV DI,word ptr [BX + 0x3]
1000:0f05      57                       PUSH DI
1000:0f06      b8 00 b8                 MOV AX,0xb800
1000:0f09      8e d8                    MOV DS,AX
1000:0f0b      8e c0                    MOV ES,AX
1000:0f0d      8b f7                    MOV SI,DI
1000:0f0f      81 c6 40 01              ADD SI,0x140
1000:0f13      b9 00 05                 MOV CX,0x500
1000:0f16      f3 a5                    MOVSW.REP ES:DI,SI
1000:0f18      b8 00 00                 MOV AX,0x0
1000:0f1b      b9 a0 00                 MOV CX,0xa0
1000:0f1e      f3 ab                    STOSW.REP ES:DI
1000:0f20      5f                       POP DI
1000:0f21      81 c7 00 20              ADD DI,0x2000
1000:0f25      8b f7                    MOV SI,DI
1000:0f27      81 c6 40 01              ADD SI,0x140
1000:0f2b      b9 00 05                 MOV CX,0x500
1000:0f2e      f3 a5                    MOVSW.REP ES:DI,SI
1000:0f30      b8 00 00                 MOV AX,0x0
1000:0f33      b9 a0 00                 MOV CX,0xa0
1000:0f36      f3 ab                    STOSW.REP ES:DI
1000:0f38      59                       POP CX
1000:0f39      5b                       POP BX
1000:0f3a      5e                       POP SI
1000:0f3b      5f                       POP DI
1000:0f3c      07                       POP ES
1000:0f3d      1f                       POP DS
1000:0f3e      58                       POP AX
1000:0f3f      c3                       RET

; ------------------------------------------------------------
1000:0f40  FUN_1000_0f40:
1000:0f40      50                       PUSH AX
1000:0f41      51                       PUSH CX
1000:0f42      8a 47 01                 MOV AL,byte ptr [BX + 0x1]
1000:0f45      32 e4                    XOR AH,AH
1000:0f47      b9 40 01                 MOV CX,0x140
1000:0f4a      f7 e1                    MUL CX
1000:0f4c      8b 7f 03                 MOV DI,word ptr [BX + 0x3]
1000:0f4f      03 f8                    ADD DI,AX
1000:0f51      8a 07                    MOV AL,byte ptr [BX]
1000:0f53      32 e4                    XOR AH,AH
1000:0f55      d1 e0                    SHL AX,0x1
1000:0f57      03 f8                    ADD DI,AX
1000:0f59      59                       POP CX
1000:0f5a      58                       POP AX
1000:0f5b      c3                       RET

; ------------------------------------------------------------
1000:0f5c  FUN_1000_0f5c:
1000:0f5c      81 fb 96 00              CMP BX,0x96
1000:0f60      74 22                    JZ 0x1000:0f84
1000:0f62      50                       PUSH AX
1000:0f63      06                       PUSH ES
1000:0f64      51                       PUSH CX
1000:0f65      e8 d8 ff                 CALL 0x1000:0f40
1000:0f68      b8 00 b8                 MOV AX,0xb800
1000:0f6b      8e c0                    MOV ES,AX
1000:0f6d      b9 04 00                 MOV CX,0x4
1000:0f70  LAB_1000_0f70:
1000:0f70      26 81 35 55 55           XOR word ptr ES:[DI],0x5555
1000:0f75      26 81 b5 00 20 55 55     XOR word ptr ES:[DI + 0x2000],0x5555
1000:0f7c      83 c7 50                 ADD DI,0x50
1000:0f7f      e2 ef                    LOOP 0x1000:0f70
1000:0f81      59                       POP CX
1000:0f82      07                       POP ES
1000:0f83      58                       POP AX
1000:0f84  LAB_1000_0f84:
1000:0f84      c3                       RET

; ------------------------------------------------------------
1000:0f85  FUN_1000_0f85:
1000:0f85      c6 06 96 00 00           MOV byte ptr [0x96],0x0
1000:0f8a      c6 06 97 00 00           MOV byte ptr [0x97],0x0
1000:0f8f      80 3e 0e 00 00           CMP byte ptr [0xe],0x0
1000:0f94      74 03                    JZ 0x1000:0f99
1000:0f96      e9 2a 01                 JMP 0x1000:10c3
1000:0f99  LAB_1000_0f99:
1000:0f99      e8 3b 4f                 CALL 0x1000:5ed7
1000:0f9c      72 03                    JC 0x1000:0fa1
1000:0f9e      e9 91 00                 JMP 0x1000:1032
1000:0fa1  LAB_1000_0fa1:
1000:0fa1      b0 01                    MOV AL,0x1
1000:0fa3      86 06 40 a3              XCHG byte ptr [0xa340],AL
1000:0fa7      3a 06 40 a3              CMP AL,byte ptr [0xa340]
1000:0fab      75 03                    JNZ 0x1000:0fb0
1000:0fad      e9 3a 02                 JMP 0x1000:11ea
1000:0fb0  LAB_1000_0fb0:
1000:0fb0      e8 bd fe                 CALL 0x1000:0e70
                ; encoded string -> 1000:102f  <c1>IN TERMINAL MODE, NO CARRIER.           ESTABLISH LINK AND PLACE HANDSET        IN COUPLER. Esc TO EXIT.                
1000:102f  LAB_1000_102f:
1000:102f      e9 b8 01                 JMP 0x1000:11ea
1000:1032  LAB_1000_1032:
1000:1032      b0 00                    MOV AL,0x0
1000:1034      86 06 40 a3              XCHG byte ptr [0xa340],AL
1000:1038      3a 06 40 a3              CMP AL,byte ptr [0xa340]
1000:103c      75 03                    JNZ 0x1000:1041
1000:103e      e9 a9 01                 JMP 0x1000:11ea
1000:1041  LAB_1000_1041:
1000:1041      e8 2c fe                 CALL 0x1000:0e70
                ; encoded string -> 1000:10c0  <c1>IN TERMINAL MODE, CARRIER PRESENT       TO TALK, REMOVE HANDSET OR USE KEYBOARD TO SEND MESSAGE. Esc TO EXIT.           
1000:10c0  LAB_1000_10c0:
1000:10c0      e9 27 01                 JMP 0x1000:11ea
1000:10c3  LAB_1000_10c3:
1000:10c3      e8 11 4e                 CALL 0x1000:5ed7
1000:10c6      72 03                    JC 0x1000:10cb
1000:10c8      e9 91 00                 JMP 0x1000:115c
1000:10cb  LAB_1000_10cb:
1000:10cb      b0 01                    MOV AL,0x1
1000:10cd      86 06 40 a3              XCHG byte ptr [0xa340],AL
1000:10d1      3a 06 40 a3              CMP AL,byte ptr [0xa340]
1000:10d5      75 03                    JNZ 0x1000:10da
1000:10d7      e9 10 01                 JMP 0x1000:11ea
1000:10da  LAB_1000_10da:
1000:10da      e8 93 fd                 CALL 0x1000:0e70
                ; encoded string -> 1000:1159  <c1>IN TERMINAL MODE, NO CARRIER.           TYPE ATDT<number> TO ORIGINATE CALL OR       ATA TO ANSWER. Esc TO EXIT.        
1000:1159  LAB_1000_1159:
1000:1159      e9 8e 00                 JMP 0x1000:11ea
1000:115c  LAB_1000_115c:
1000:115c      b0 00                    MOV AL,0x0
1000:115e      86 06 40 a3              XCHG byte ptr [0xa340],AL
1000:1162      3a 06 40 a3              CMP AL,byte ptr [0xa340]
1000:1166      75 03                    JNZ 0x1000:116b
1000:1168      e9 7f 00                 JMP 0x1000:11ea
1000:116b  LAB_1000_116b:
1000:116b      e8 02 fd                 CALL 0x1000:0e70
                ; encoded string -> 1000:11ea  <c1>IN TERMINAL MODE, CARRIER PRESENT       TYPE +++ , THEN ATH TO DROP CARRIER,    PICK UP PHONE TO TALK. Esc TO EXIT.     
1000:11ea  LAB_1000_11ea:
1000:11ea      c3                       RET

; ------------------------------------------------------------
1000:11eb  FUN_1000_11eb:
1000:11eb      50                       PUSH AX
1000:11ec      06                       PUSH ES
1000:11ed      56                       PUSH SI
1000:11ee      57                       PUSH DI
1000:11ef      51                       PUSH CX
1000:11f0      b9 00 b8                 MOV CX,0xb800
1000:11f3      8e c1                    MOV ES,CX
1000:11f5      8b 36 16 00              MOV SI,word ptr [0x16]
1000:11f9      b9 04 00                 MOV CX,0x4
1000:11fc      25 7f 00                 AND AX,0x7f
1000:11ff      d3 e0                    SHL AX,CL
1000:1201      03 f0                    ADD SI,AX
1000:1203  LAB_1000_1203:
1000:1203      ad                       LODSW SI
1000:1204      26 89 05                 MOV word ptr ES:[DI],AX
1000:1207      ad                       LODSW SI
1000:1208      26 89 85 00 20           MOV word ptr ES:[DI + 0x2000],AX
1000:120d      83 c7 50                 ADD DI,0x50
1000:1210      e2 f1                    LOOP 0x1000:1203
1000:1212      59                       POP CX
1000:1213      5f                       POP DI
1000:1214      5e                       POP SI
1000:1215      07                       POP ES
1000:1216      58                       POP AX
1000:1217      c3                       RET

; ------------------------------------------------------------
1000:1220  FUN_1000_1220:
1000:1220      bf 26 a2                 MOV DI,0xa226
1000:1223      b9 2c 00                 MOV CX,0x2c
1000:1226      32 c0                    XOR AL,AL
1000:1228      f3 aa                    STOSB.REP ES:DI
1000:122a      c6 06 ed 00 00           MOV byte ptr [0xed],0x0
1000:122f      80 3e 0a 00 01           CMP byte ptr [0xa],0x1
1000:1234      75 25                    JNZ 0x1000:125b
1000:1236      be 07 00                 MOV SI,0x7
1000:1239      bf 26 a2                 MOV DI,0xa226
1000:123c      b9 03 00                 MOV CX,0x3
1000:123f      f3 a4                    MOVSB.REP ES:DI,SI
1000:1241      a0 c0 39                 MOV AL,[0x39c0]
1000:1244      aa                       STOSB ES:DI
1000:1245      a0 10 00                 MOV AL,[0x10]
1000:1248      aa                       STOSB ES:DI
1000:1249      b9 06 00                 MOV CX,0x6
1000:124c      b0 00                    MOV AL,0x0
1000:124e      f3 aa                    STOSB.REP ES:DI
1000:1250      b0 01                    MOV AL,0x1
1000:1252      8a 26 13 00              MOV AH,byte ptr [0x13]
1000:1256      fe c4                    INC AH
1000:1258      eb 04                    JMP 0x1000:125e
1000:125b  LAB_1000_125b:
1000:125b      e8 42 47                 CALL 0x1000:59a0
1000:125e  LAB_1000_125e:
1000:125e      50                       PUSH AX
1000:125f      f6 06 12 00 01           TEST byte ptr [0x12],0x1
1000:1264      75 28                    JNZ 0x1000:128e
1000:1266      e8 92 45                 CALL 0x1000:57fb
                ; inline script -> 1000:128b  <c3><clear>         PLAYING LONG GAME   
1000:128b  LAB_1000_128b:
1000:128b      eb 27                    JMP 0x1000:12b4
1000:128e  LAB_1000_128e:
1000:128e      e8 6a 45                 CALL 0x1000:57fb
                ; inline script -> 1000:12b4  <c3><clear>         PLAYING TIMED GAME   
1000:12b4  LAB_1000_12b4:
1000:12b4      f6 06 12 00 02           TEST byte ptr [0x12],0x2
1000:12b9      74 27                    JZ 0x1000:12e2
1000:12bb      e8 3d 45                 CALL 0x1000:57fb
                ; inline script -> 1000:12df  <c3>         IN MULTI-GALAXIES   
1000:12df  LAB_1000_12df:
1000:12df      eb 23                    JMP 0x1000:1304
1000:12e2  LAB_1000_12e2:
1000:12e2      e8 16 45                 CALL 0x1000:57fb
                ; inline script -> 1000:1304  <c3>           IN ONE GALAXY   
1000:1304  LAB_1000_1304:
1000:1304      58                       POP AX
1000:1305      50                       PUSH AX
1000:1306      3c 02                    CMP AL,0x2
1000:1308      72 5d                    JC 0x1000:1367
1000:130a      22 e4                    AND AH,AH
1000:130c      75 0f                    JNZ 0x1000:131d
1000:130e      e8 ea 44                 CALL 0x1000:57fb
                ; inline script -> 1000:131d  <c3>        
1000:131d  LAB_1000_131d:
1000:131d      e8 db 44                 CALL 0x1000:57fb
                ; inline script -> 1000:1330  <c3>    AGAINST 
1000:1330  LAB_1000_1330:
1000:1330      58                       POP AX
1000:1331      50                       PUSH AX
1000:1332      fe c8                    DEC AL
1000:1334      e8 d7 00                 CALL 0x1000:140e
1000:1337      e8 c1 44                 CALL 0x1000:57fb
                ; inline script -> 1000:1344  <c3> HUMAN
1000:1344  LAB_1000_1344:
1000:1344      58                       POP AX
1000:1345      50                       PUSH AX
1000:1346      3c 02                    CMP AL,0x2
1000:1348      76 08                    JBE 0x1000:1352
1000:134a      e8 ae 44                 CALL 0x1000:57fb
                ; inline script -> 1000:1352  <c3>S
1000:1352  LAB_1000_1352:
1000:1352      58                       POP AX
1000:1353      50                       PUSH AX
1000:1354      22 e4                    AND AH,AH
1000:1356      74 4c                    JZ 0x1000:13a4
1000:1358      e8 a0 44                 CALL 0x1000:57fb
                ; inline script -> 1000:1364  <c3> AND 
1000:1364  LAB_1000_1364:
1000:1364      eb 18                    JMP 0x1000:137e
1000:1367  LAB_1000_1367:
1000:1367      e8 91 44                 CALL 0x1000:57fb
                ; inline script -> 1000:137e  <c3>        AGAINST 
1000:137e  LAB_1000_137e:
1000:137e      58                       POP AX
1000:137f      50                       PUSH AX
1000:1380      8a c4                    MOV AL,AH
1000:1382      e8 89 00                 CALL 0x1000:140e
1000:1385      e8 73 44                 CALL 0x1000:57fb
                ; inline script -> 1000:1395  <c3> COMPUTER
1000:1395  LAB_1000_1395:
1000:1395      58                       POP AX
1000:1396      50                       PUSH AX
1000:1397      80 fc 01                 CMP AH,0x1
1000:139a      74 08                    JZ 0x1000:13a4
1000:139c      e8 5c 44                 CALL 0x1000:57fb
                ; inline script -> 1000:13a4  <c3>S
1000:13a4  LAB_1000_13a4:
1000:13a4      58                       POP AX
1000:13a5      c6 06 00 00 50           MOV byte ptr [0x0],0x50
1000:13aa      c6 06 01 00 04           MOV byte ptr [0x1],0x4
1000:13af      b3 01                    MOV BL,0x1
1000:13b1      f6 06 12 00 02           TEST byte ptr [0x12],0x2
1000:13b6      74 17                    JZ 0x1000:13cf
1000:13b8      8a d8                    MOV BL,AL
1000:13ba      02 dc                    ADD BL,AH
1000:13bc      00 1e 01 00              ADD byte ptr [0x1],BL
1000:13c0      8a fb                    MOV BH,BL
1000:13c2      d0 e7                    SHL BH,0x1
1000:13c4      d0 e7                    SHL BH,0x1
1000:13c6      d0 e7                    SHL BH,0x1
1000:13c8      80 ef 06                 SUB BH,0x6
1000:13cb      28 3e 00 00              SUB byte ptr [0x0],BH
1000:13cf  LAB_1000_13cf:
1000:13cf      88 1e 02 00              MOV byte ptr [0x2],BL
1000:13d3      b3 01                    MOV BL,0x1
1000:13d5      3c 01                    CMP AL,0x1
1000:13d7      75 04                    JNZ 0x1000:13dd
1000:13d9      8a 1e 11 00              MOV BL,byte ptr [0x11]
1000:13dd  LAB_1000_13dd:
1000:13dd      bf 26 a2                 MOV DI,0xa226
1000:13e0      8a cc                    MOV CL,AH
1000:13e2      32 ed                    XOR CH,CH
1000:13e4      e3 27                    JCXZ 0x1000:140d
1000:13e6  LAB_1000_13e6:
1000:13e6      83 c7 0b                 ADD DI,0xb
1000:13e9      fe c8                    DEC AL
1000:13eb      75 f9                    JNZ 0x1000:13e6
1000:13ed      32 ed                    XOR CH,CH
1000:13ef      b4 30                    MOV AH,0x30
1000:13f1  LAB_1000_13f1:
1000:13f1      b0 6d                    MOV AL,0x6d
1000:13f3      aa                       STOSB ES:DI
1000:13f4      b0 65                    MOV AL,0x65
1000:13f6      aa                       STOSB ES:DI
1000:13f7      8a c4                    MOV AL,AH
1000:13f9      aa                       STOSB ES:DI
1000:13fa      a0 c0 39                 MOV AL,[0x39c0]
1000:13fd      aa                       STOSB ES:DI
1000:13fe      8a c3                    MOV AL,BL
1000:1400      aa                       STOSB ES:DI
1000:1401      b0 00                    MOV AL,0x0
1000:1403      aa                       STOSB ES:DI
1000:1404      aa                       STOSB ES:DI
1000:1405      aa                       STOSB ES:DI
1000:1406      aa                       STOSB ES:DI
1000:1407      aa                       STOSB ES:DI
1000:1408      aa                       STOSB ES:DI
1000:1409      fe c4                    INC AH
1000:140b      e2 e4                    LOOP 0x1000:13f1
1000:140d  LAB_1000_140d:
1000:140d      c3                       RET

; ------------------------------------------------------------
1000:140e  FUN_1000_140e:
1000:140e      3c 01                    CMP AL,0x1
1000:1410      75 0b                    JNZ 0x1000:141d
1000:1412      e8 e6 43                 CALL 0x1000:57fb
                ; inline script -> 1000:141c  <c3>ONE
1000:141c  LAB_1000_141c:
1000:141c      c3                       RET
1000:141d  LAB_1000_141d:
1000:141d      3c 02                    CMP AL,0x2
1000:141f      75 0b                    JNZ 0x1000:142c
1000:1421      e8 d7 43                 CALL 0x1000:57fb
                ; inline script -> 1000:142b  <c3>TWO
1000:142b  LAB_1000_142b:
1000:142b      c3                       RET
1000:142c  LAB_1000_142c:
1000:142c      3c 03                    CMP AL,0x3
1000:142e      75 0d                    JNZ 0x1000:143d
1000:1430      e8 c8 43                 CALL 0x1000:57fb
                ; inline script -> 1000:143c  <c3>THREE
1000:143c  LAB_1000_143c:
1000:143c      c3                       RET
1000:143d  LAB_1000_143d:
1000:143d      e8 bb 43                 CALL 0x1000:57fb
                ; inline script -> 1000:1448  <c3>FOUR
1000:1448  LAB_1000_1448:
1000:1448      c3                       RET

; ------------------------------------------------------------
1000:1449  FUN_1000_1449:
1000:1449      b9 04 00                 MOV CX,0x4
1000:144c  LAB_1000_144c:
1000:144c      33 d2                    XOR DX,DX
1000:144e      bb 0a 00                 MOV BX,0xa
1000:1451      f7 f3                    DIV BX
1000:1453      52                       PUSH DX
1000:1454      e2 f6                    LOOP 0x1000:144c
1000:1456      b9 04 00                 MOV CX,0x4
1000:1459  LAB_1000_1459:
1000:1459      58                       POP AX
1000:145a      50                       PUSH AX
1000:145b      3c 00                    CMP AL,0x0
1000:145d      75 09                    JNZ 0x1000:1468
1000:145f      58                       POP AX
1000:1460      e2 f7                    LOOP 0x1000:1459
1000:1462      b0 30                    MOV AL,0x30
1000:1464      e8 10 41                 CALL 0x1000:5577
1000:1467      c3                       RET
1000:1468  LAB_1000_1468:
1000:1468      58                       POP AX
1000:1469      04 30                    ADD AL,0x30
1000:146b      51                       PUSH CX
1000:146c      e8 08 41                 CALL 0x1000:5577
1000:146f      59                       POP CX
1000:1470      e2 f6                    LOOP 0x1000:1468
1000:1472      c3                       RET

; ------------------------------------------------------------
1000:1473  FUN_1000_1473:
1000:1473      c6 06 70 a2 07           MOV byte ptr [0xa270],0x7
1000:1478      c6 06 6f a2 00           MOV byte ptr [0xa26f],0x0
1000:147d      e8 a0 fd                 CALL 0x1000:1220
1000:1480      c7 06 55 a2 a2 00        MOV word ptr [0xa255],0xa2
1000:1486      e8 72 43                 CALL 0x1000:57fb
                ; inline script -> 1000:14ac  <c3>          SETTING UP UNIVERSE #
1000:14ac  LAB_1000_14ac:
1000:14ac      a1 d0 89                 MOV AX,[0x89d0]
1000:14af      33 d2                    XOR DX,DX
1000:14b1      bb 1a 00                 MOV BX,0x1a
1000:14b4      f7 f3                    DIV BX
1000:14b6      50                       PUSH AX
1000:14b7      8b c2                    MOV AX,DX
1000:14b9      04 41                    ADD AL,0x41
1000:14bb      e8 b9 40                 CALL 0x1000:5577
1000:14be      b0 2d                    MOV AL,0x2d
1000:14c0      e8 b4 40                 CALL 0x1000:5577
1000:14c3      58                       POP AX
1000:14c4      e8 82 ff                 CALL 0x1000:1449
1000:14c7      e8 31 43                 CALL 0x1000:57fb
                ; inline script -> 1000:14ef  <c3>             ** PLEASE STANDBY **
1000:14ef  LAB_1000_14ef:
1000:14ef      e8 df 2a                 CALL 0x1000:3fd1
1000:14f2  LAB_1000_14f2:
1000:14f2      83 3e 55 a2 00           CMP word ptr [0xa255],0x0
1000:14f7      75 f9                    JNZ 0x1000:14f2
1000:14f9      e8 a4 4a                 CALL 0x1000:5fa0
1000:14fc      8b 26 43 a3              MOV SP,word ptr [0xa343]
1000:1500      fa                       CLI
1000:1501      bb 7c 0c                 MOV BX,0xc7c
1000:1504      bf 12 a2                 MOV DI,0xa212
1000:1507      b9 14 00                 MOV CX,0x14
1000:150a      b0 00                    MOV AL,0x0
1000:150c      f3 aa                    STOSB.REP ES:DI
1000:150e      c7 06 e1 00 e5 00        MOV word ptr [0xe1],0xe5
1000:1514      c7 06 e3 00 e5 00        MOV word ptr [0xe3],0xe5
1000:151a      c6 06 04 a2 12           MOV byte ptr [0xa204],0x12
1000:151f      c6 06 05 a2 05           MOV byte ptr [0xa205],0x5
1000:1524      c6 06 06 a2 00           MOV byte ptr [0xa206],0x0
1000:1529      c6 06 07 a2 00           MOV byte ptr [0xa207],0x0
1000:152e      c6 06 08 a2 00           MOV byte ptr [0xa208],0x0
1000:1533      f6 06 12 00 01           TEST byte ptr [0x12],0x1
1000:1538      74 05                    JZ 0x1000:153f
1000:153a      c6 06 07 a2 1e           MOV byte ptr [0xa207],0x1e
1000:153f  LAB_1000_153f:
1000:153f      fb                       STI
1000:1540      ff d3                    CALL BX
1000:1542      c6 06 03 a2 01           MOV byte ptr [0xa203],0x1
1000:1547      c7 06 57 a2 00 00        MOV word ptr [0xa257],0x0
1000:154d  LAB_1000_154d:
1000:154d      83 3e 57 a2 00           CMP word ptr [0xa257],0x0
1000:1552      75 f9                    JNZ 0x1000:154d
1000:1554      8a 26 0d 00              MOV AH,byte ptr [0xd]
1000:1558      80 e4 03                 AND AH,0x3
1000:155b      b0 09                    MOV AL,0x9
1000:155d      74 10                    JZ 0x1000:156f
1000:155f      b0 08                    MOV AL,0x8
1000:1561      fe cc                    DEC AH
1000:1563      74 0a                    JZ 0x1000:156f
1000:1565      b0 07                    MOV AL,0x7
1000:1567      fe cc                    DEC AH
1000:1569      74 04                    JZ 0x1000:156f
1000:156b      32 e4                    XOR AH,AH
1000:156d      b0 06                    MOV AL,0x6
1000:156f  LAB_1000_156f:
1000:156f      a3 57 a2                 MOV [0xa257],AX
1000:1572      e8 e4 01                 CALL 0x1000:1759
1000:1575      c6 06 0c a2 80           MOV byte ptr [0xa20c],0x80
1000:157a      ff 06 d2 89              INC word ptr [0x89d2]
1000:157e      e8 b6 02                 CALL 0x1000:1837
1000:1581      f6 06 6c a2 80           TEST byte ptr [0xa26c],0x80
1000:1586      75 15                    JNZ 0x1000:159d
1000:1588      e8 5b 09                 CALL 0x1000:1ee6
1000:158b      e8 1e 22                 CALL 0x1000:37ac
1000:158e      e8 fe 01                 CALL 0x1000:178f
1000:1591      e8 e0 15                 CALL 0x1000:2b74
1000:1594      e8 dd 23                 CALL 0x1000:3974
1000:1597      e8 f5 01                 CALL 0x1000:178f
1000:159a      e8 be 15                 CALL 0x1000:2b5b
1000:159d  LAB_1000_159d:
1000:159d      e8 ef 01                 CALL 0x1000:178f
1000:15a0      e8 8d 2f                 CALL 0x1000:4530
1000:15a3      e8 e9 01                 CALL 0x1000:178f
1000:15a6      e8 d2 03                 CALL 0x1000:197b
1000:15a9      e8 26 00                 CALL 0x1000:15d2
1000:15ac      e8 4f 01                 CALL 0x1000:16fe
1000:15af      e8 02 00                 CALL 0x1000:15b4
1000:15b2      eb 99                    JMP 0x1000:154d

; ------------------------------------------------------------
1000:15b4  FUN_1000_15b4:
1000:15b4      80 3e 0a 00 01           CMP byte ptr [0xa],0x1
1000:15b9      75 11                    JNZ 0x1000:15cc
1000:15bb      bf 12 a2                 MOV DI,0xa212
1000:15be      be 0d a2                 MOV SI,0xa20d
1000:15c1      b9 04 00                 MOV CX,0x4
1000:15c4      f3 a4                    MOVSB.REP ES:DI,SI
1000:15c6      b0 01                    MOV AL,0x1
1000:15c8      aa                       STOSB ES:DI
1000:15c9      eb 04                    JMP 0x1000:15cf
1000:15cc  LAB_1000_15cc:
1000:15cc      e8 53 47                 CALL 0x1000:5d22
1000:15cf  LAB_1000_15cf:
1000:15cf      e9 3e 4d                 JMP 0x1000:6310

; ------------------------------------------------------------
1000:15d2  FUN_1000_15d2:
1000:15d2      80 3e ed 00 01           CMP byte ptr [0xed],0x1
1000:15d7      74 4e                    JZ 0x1000:1627
1000:15d9      e8 0d 01                 CALL 0x1000:16e9
1000:15dc      b9 04 00                 MOV CX,0x4
1000:15df      bb e0 89                 MOV BX,0x89e0
1000:15e2      b0 00                    MOV AL,0x0
1000:15e4  LAB_1000_15e4:
1000:15e4      80 3f 00                 CMP byte ptr [BX],0x0
1000:15e7      75 02                    JNZ 0x1000:15eb
1000:15e9      fe c0                    INC AL
1000:15eb  LAB_1000_15eb:
1000:15eb      43                       INC BX
1000:15ec      e2 f6                    LOOP 0x1000:15e4
1000:15ee      3c 00                    CMP AL,0x0
1000:15f0      75 11                    JNZ 0x1000:1603
1000:15f2      bb e0 89                 MOV BX,0x89e0
1000:15f5      b9 04 00                 MOV CX,0x4
1000:15f8  LAB_1000_15f8:
1000:15f8      f6 07 80                 TEST byte ptr [BX],0x80
1000:15fb      75 03                    JNZ 0x1000:1600
1000:15fd      c6 07 04                 MOV byte ptr [BX],0x4
1000:1600  LAB_1000_1600:
1000:1600      43                       INC BX
1000:1601      e2 f5                    LOOP 0x1000:15f8
1000:1603  LAB_1000_1603:
1000:1603      3c 01                    CMP AL,0x1
1000:1605      74 20                    JZ 0x1000:1627
1000:1607      bb e0 89                 MOV BX,0x89e0
1000:160a      b9 04 00                 MOV CX,0x4
1000:160d  LAB_1000_160d:
1000:160d      80 3f 00                 CMP byte ptr [BX],0x0
1000:1610      74 03                    JZ 0x1000:1615
1000:1612      80 0f 80                 OR byte ptr [BX],0x80
1000:1615  LAB_1000_1615:
1000:1615      43                       INC BX
1000:1616      e2 f5                    LOOP 0x1000:160d
1000:1618      8a 1e 6f a2              MOV BL,byte ptr [0xa26f]
1000:161c      32 ff                    XOR BH,BH
1000:161e      8a 87 e0 89              MOV AL,byte ptr [BX + 0x89e0]
1000:1622      3c 00                    CMP AL,0x0
1000:1624      75 01                    JNZ 0x1000:1627
1000:1626      c3                       RET
1000:1627  LAB_1000_1627:
1000:1627      8a 1e 6f a2              MOV BL,byte ptr [0xa26f]
1000:162b      88 1e 74 a2              MOV byte ptr [0xa274],BL
1000:162f      e8 46 05                 CALL 0x1000:1b78
1000:1632      c7 06 09 a2 00 00        MOV word ptr [0xa209],0x0
1000:1638      c6 06 70 a2 04           MOV byte ptr [0xa270],0x4
1000:163d      e8 56 00                 CALL 0x1000:1696
1000:1640      e8 ed 2e                 CALL 0x1000:4530
1000:1643      e8 bc 3a                 CALL 0x1000:5102
1000:1646      e8 82 54                 CALL 0x1000:6acb
1000:1649      c7 06 55 a2 24 00        MOV word ptr [0xa255],0x24
1000:164f  LAB_1000_164f:
1000:164f      83 3e 55 a2 00           CMP word ptr [0xa255],0x0
1000:1654      75 f9                    JNZ 0x1000:164f
1000:1656      e8 a2 41                 CALL 0x1000:57fb
                ; inline script -> 1000:1675  <c3><box>HIT Esc TO CONTINUE
1000:1675  LAB_1000_1675:
1000:1675      c7 06 55 a2 68 01        MOV word ptr [0xa255],0x168
1000:167b  LAB_1000_167b:
1000:167b      b4 01                    MOV AH,0x1
1000:167d      cd 16                    INT 0x16
1000:167f      74 08                    JZ 0x1000:1689
1000:1681      b4 00                    MOV AH,0x0
1000:1683      cd 16                    INT 0x16
1000:1685      3c 1b                    CMP AL,0x1b
1000:1687      74 07                    JZ 0x1000:1690
1000:1689  LAB_1000_1689:
1000:1689      83 3e 55 a2 00           CMP word ptr [0xa255],0x0
1000:168e      75 eb                    JNZ 0x1000:167b
1000:1690  LAB_1000_1690:
1000:1690      e8 c3 95                 CALL 0x1000:ac56
1000:1693      e9 2f 55                 JMP 0x1000:6bc5

; ------------------------------------------------------------
1000:1696  FUN_1000_1696:
1000:1696      be 64 8c                 MOV SI,0x8c64
1000:1699      bf 14 90                 MOV DI,0x9014
1000:169c      bb e4 89                 MOV BX,0x89e4
1000:169f      b9 04 00                 MOV CX,0x4
1000:16a2  LAB_1000_16a2:
1000:16a2      51                       PUSH CX
1000:16a3      b9 04 00                 MOV CX,0x4
1000:16a6      ba 00 00                 MOV DX,0x0
1000:16a9  LAB_1000_16a9:
1000:16a9      f6 04 80                 TEST byte ptr [SI],0x80
1000:16ac      74 16                    JZ 0x1000:16c4
1000:16ae      51                       PUSH CX
1000:16af      52                       PUSH DX
1000:16b0      b9 64 00                 MOV CX,0x64
1000:16b3      8b 44 08                 MOV AX,word ptr [SI + 0x8]
1000:16b6      33 d2                    XOR DX,DX
1000:16b8      f7 f1                    DIV CX
1000:16ba      83 fa 32                 CMP DX,0x32
1000:16bd      72 01                    JC 0x1000:16c0
1000:16bf      40                       INC AX
1000:16c0  LAB_1000_16c0:
1000:16c0      5a                       POP DX
1000:16c1      59                       POP CX
1000:16c2      03 d0                    ADD DX,AX
1000:16c4  LAB_1000_16c4:
1000:16c4      83 c6 3b                 ADD SI,0x3b
1000:16c7      e2 e0                    LOOP 0x1000:16a9
1000:16c9      8b 45 08                 MOV AX,word ptr [DI + 0x8]
1000:16cc      52                       PUSH DX
1000:16cd      33 d2                    XOR DX,DX
1000:16cf      b9 0a 00                 MOV CX,0xa
1000:16d2      f7 f1                    DIV CX
1000:16d4      83 fa 05                 CMP DX,0x5
1000:16d7      5a                       POP DX
1000:16d8      72 01                    JC 0x1000:16db
1000:16da      40                       INC AX
1000:16db  LAB_1000_16db:
1000:16db      03 c2                    ADD AX,DX
1000:16dd      01 07                    ADD word ptr [BX],AX
1000:16df      83 c3 02                 ADD BX,0x2
1000:16e2      83 c7 0e                 ADD DI,0xe
1000:16e5      59                       POP CX
1000:16e6      e2 ba                    LOOP 0x1000:16a2
1000:16e8      c3                       RET

; ------------------------------------------------------------
1000:16e9  FUN_1000_16e9:
1000:16e9      80 3e 0a 00 02           CMP byte ptr [0xa],0x2
1000:16ee      75 0d                    JNZ 0x1000:16fd
1000:16f0      83 3e e0 89 00           CMP word ptr [0x89e0],0x0
1000:16f5      74 06                    JZ 0x1000:16fd
1000:16f7      c7 06 e2 89 03 03        MOV word ptr [0x89e2],0x303
1000:16fd  LAB_1000_16fd:
1000:16fd      c3                       RET

; ------------------------------------------------------------
1000:16fe  FUN_1000_16fe:
1000:16fe      f6 06 6c a2 ff           TEST byte ptr [0xa26c],0xff
1000:1703      75 06                    JNZ 0x1000:170b
1000:1705      c6 06 6d a2 00           MOV byte ptr [0xa26d],0x0
1000:170a      c3                       RET
1000:170b  LAB_1000_170b:
1000:170b      f6 06 6c a2 80           TEST byte ptr [0xa26c],0x80
1000:1710      75 12                    JNZ 0x1000:1724
1000:1712      80 3e 6d a2 00           CMP byte ptr [0xa26d],0x0
1000:1717      75 06                    JNZ 0x1000:171f
1000:1719      80 0e 6c a2 8f           OR byte ptr [0xa26c],0x8f
1000:171e      c3                       RET
1000:171f  LAB_1000_171f:
1000:171f      fe 0e 6d a2              DEC byte ptr [0xa26d]
1000:1723      c3                       RET
1000:1724  LAB_1000_1724:
1000:1724      bb e0 89                 MOV BX,0x89e0
1000:1727      bf 26 a2                 MOV DI,0xa226
1000:172a      b9 00 00                 MOV CX,0x0
1000:172d  LAB_1000_172d:
1000:172d      80 3f 00                 CMP byte ptr [BX],0x0
1000:1730      75 05                    JNZ 0x1000:1737
1000:1732      80 3d 6d                 CMP byte ptr [DI],0x6d
1000:1735      75 0a                    JNZ 0x1000:1741
1000:1737  LAB_1000_1737:
1000:1737      b0 01                    MOV AL,0x1
1000:1739      d2 e0                    SHL AL,CL
1000:173b      f6 d0                    NOT AL
1000:173d      20 06 6c a2              AND byte ptr [0xa26c],AL
1000:1741  LAB_1000_1741:
1000:1741      fe c1                    INC CL
1000:1743      43                       INC BX
1000:1744      83 c7 0b                 ADD DI,0xb
1000:1747      80 f9 04                 CMP CL,0x4
1000:174a      72 e1                    JC 0x1000:172d
1000:174c      f6 06 6c a2 0f           TEST byte ptr [0xa26c],0xf
1000:1751      75 05                    JNZ 0x1000:1758
1000:1753      c6 06 6c a2 00           MOV byte ptr [0xa26c],0x0
1000:1758  LAB_1000_1758:
1000:1758      c3                       RET

; ------------------------------------------------------------
1000:1759  FUN_1000_1759:
1000:1759      bf 0d a2                 MOV DI,0xa20d
1000:175c      b9 04 00                 MOV CX,0x4
1000:175f  LAB_1000_175f:
1000:175f      8b 1e e1 00              MOV BX,word ptr [0xe1]
1000:1763      3b 1e e3 00              CMP BX,word ptr [0xe3]
1000:1767      b0 00                    MOV AL,0x0
1000:1769      74 18                    JZ 0x1000:1783
1000:176b      8a 07                    MOV AL,byte ptr [BX]
1000:176d      43                       INC BX
1000:176e      81 fb ed 00              CMP BX,0xed
1000:1772      75 03                    JNZ 0x1000:1777
1000:1774      bb e5 00                 MOV BX,0xe5
1000:1777  LAB_1000_1777:
1000:1777      89 1e e1 00              MOV word ptr [0xe1],BX
1000:177b      22 c0                    AND AL,AL
1000:177d      74 04                    JZ 0x1000:1783
1000:177f      aa                       STOSB ES:DI
1000:1780      e2 dd                    LOOP 0x1000:175f
1000:1782      c3                       RET
1000:1783  LAB_1000_1783:
1000:1783      80 3e 03 a2 00           CMP byte ptr [0xa203],0x0
1000:1788      75 02                    JNZ 0x1000:178c
1000:178a      b0 86                    MOV AL,0x86
1000:178c  LAB_1000_178c:
1000:178c      f3 aa                    STOSB.REP ES:DI
1000:178e      c3                       RET

; ------------------------------------------------------------
1000:178f  FUN_1000_178f:
1000:178f      e8 2f 00                 CALL 0x1000:17c1
1000:1792      22 c0                    AND AL,AL
1000:1794      75 01                    JNZ 0x1000:1797
1000:1796      c3                       RET
1000:1797  LAB_1000_1797:
1000:1797      53                       PUSH BX
1000:1798      56                       PUSH SI
1000:1799      8b 1e e3 00              MOV BX,word ptr [0xe3]
1000:179d      8b f3                    MOV SI,BX
1000:179f      43                       INC BX
1000:17a0      81 fb ed 00              CMP BX,0xed
1000:17a4      75 03                    JNZ 0x1000:17a9
1000:17a6      bb e5 00                 MOV BX,0xe5
1000:17a9  LAB_1000_17a9:
1000:17a9      3b 1e e1 00              CMP BX,word ptr [0xe1]
1000:17ad      74 0a                    JZ 0x1000:17b9
1000:17af      89 1e e3 00              MOV word ptr [0xe3],BX
1000:17b3      88 04                    MOV byte ptr [SI],AL
1000:17b5  LAB_1000_17b5:
1000:17b5      5e                       POP SI
1000:17b6      5b                       POP BX
1000:17b7      eb d6                    JMP 0x1000:178f
1000:17b9  LAB_1000_17b9:
1000:17b9      c7 06 5a a2 02 00        MOV word ptr [0xa25a],0x2
1000:17bf      eb f4                    JMP 0x1000:17b5

; ------------------------------------------------------------
1000:17c1  FUN_1000_17c1:
1000:17c1      b4 01                    MOV AH,0x1
1000:17c3      cd 16                    INT 0x16
1000:17c5      b0 00                    MOV AL,0x0
1000:17c7      74 6d                    JZ 0x1000:1836
1000:17c9      b4 00                    MOV AH,0x0
1000:17cb      cd 16                    INT 0x16
1000:17cd      80 fc 52                 CMP AH,0x52
1000:17d0      74 09                    JZ 0x1000:17db
1000:17d2      80 fc 53                 CMP AH,0x53
1000:17d5      74 04                    JZ 0x1000:17db
1000:17d7      3c 00                    CMP AL,0x0
1000:17d9      75 05                    JNZ 0x1000:17e0
1000:17db  LAB_1000_17db:
1000:17db      80 cc 80                 OR AH,0x80
1000:17de      8a c4                    MOV AL,AH
1000:17e0  LAB_1000_17e0:
1000:17e0      3c 86                    CMP AL,0x86
1000:17e2      74 dd                    JZ 0x1000:17c1
1000:17e4      3c 13                    CMP AL,0x13
1000:17e6      75 07                    JNZ 0x1000:17ef
1000:17e8      80 36 14 00 03           XOR byte ptr [0x14],0x3
1000:17ed      eb d2                    JMP 0x1000:17c1
1000:17ef  LAB_1000_17ef:
1000:17ef      3c 03                    CMP AL,0x3
1000:17f1      75 10                    JNZ 0x1000:1803
1000:17f3      fe 06 59 a2              INC byte ptr [0xa259]
1000:17f7      80 3e 59 a2 02           CMP byte ptr [0xa259],0x2
1000:17fc      75 c3                    JNZ 0x1000:17c1
1000:17fe      b0 85                    MOV AL,0x85
1000:1800      eb 34                    JMP 0x1000:1836
1000:1803  LAB_1000_1803:
1000:1803      3c 04                    CMP AL,0x4
1000:1805      75 02                    JNZ 0x1000:1809
1000:1807      eb b8                    JMP 0x1000:17c1
1000:1809  LAB_1000_1809:
1000:1809      c6 06 59 a2 00           MOV byte ptr [0xa259],0x0
1000:180e      3c 06                    CMP AL,0x6
1000:1810      75 16                    JNZ 0x1000:1828
1000:1812      81 3e 16 00 cd 28        CMP word ptr [0x16],0x28cd
1000:1818      c7 06 16 00 cd 28        MOV word ptr [0x16],0x28cd
1000:181e      75 06                    JNZ 0x1000:1826
1000:1820      c7 06 16 00 1d 31        MOV word ptr [0x16],0x311d
1000:1826  LAB_1000_1826:
1000:1826      eb 99                    JMP 0x1000:17c1
1000:1828  LAB_1000_1828:
1000:1828      3c 10                    CMP AL,0x10
1000:182a      75 0a                    JNZ 0x1000:1836
1000:182c      80 36 15 00 01           XOR byte ptr [0x15],0x1
1000:1831      e8 7b f3                 CALL 0x1000:0baf
1000:1834      eb 8b                    JMP 0x1000:17c1
1000:1836  LAB_1000_1836:
1000:1836      c3                       RET

; ------------------------------------------------------------
1000:1837  FUN_1000_1837:
1000:1837      c6 06 74 a2 00           MOV byte ptr [0xa274],0x0
1000:183c      bb 12 a2                 MOV BX,0xa212
1000:183f  LAB_1000_183f:
1000:183f      53                       PUSH BX
1000:1840      e8 7e 06                 CALL 0x1000:1ec1
1000:1843      8a 07                    MOV AL,byte ptr [BX]
1000:1845      a8 10                    TEST AL,0x10
1000:1847      75 0b                    JNZ 0x1000:1854
1000:1849      e8 c0 11                 CALL 0x1000:2a0c
1000:184c      f6 04 ff                 TEST byte ptr [SI],0xff
1000:184f      75 03                    JNZ 0x1000:1854
1000:1851      e8 24 03                 CALL 0x1000:1b78
1000:1854  LAB_1000_1854:
1000:1854      b9 04 00                 MOV CX,0x4
1000:1857      5b                       POP BX
1000:1858      53                       PUSH BX
1000:1859      89 36 50 a3              MOV word ptr [0xa350],SI
1000:185d  LAB_1000_185d:
1000:185d      8a 07                    MOV AL,byte ptr [BX]
1000:185f      43                       INC BX
1000:1860      22 c0                    AND AL,AL
1000:1862      74 10                    JZ 0x1000:1874
1000:1864      a2 11 a2                 MOV [0xa211],AL
1000:1867      53                       PUSH BX
1000:1868      51                       PUSH CX
1000:1869      e8 18 00                 CALL 0x1000:1884
1000:186c      8b 36 50 a3              MOV SI,word ptr [0xa350]
1000:1870      59                       POP CX
1000:1871      5b                       POP BX
1000:1872      e2 e9                    LOOP 0x1000:185d
1000:1874  LAB_1000_1874:
1000:1874      5b                       POP BX
1000:1875      83 c3 05                 ADD BX,0x5
1000:1878      fe 06 74 a2              INC byte ptr [0xa274]
1000:187c      80 3e 74 a2 04           CMP byte ptr [0xa274],0x4
1000:1881      72 bc                    JC 0x1000:183f
1000:1883      c3                       RET

; ------------------------------------------------------------
1000:1884  FUN_1000_1884:
1000:1884      a0 74 a2                 MOV AL,[0xa274]
1000:1887      32 e4                    XOR AH,AH
1000:1889      bf 28 00                 MOV DI,0x28
1000:188c      f7 e7                    MUL DI
1000:188e      8b f8                    MOV DI,AX
1000:1890      81 c7 ec 89              ADD DI,0x89ec
1000:1894      80 3d 00                 CMP byte ptr [DI],0x0
1000:1897      74 0b                    JZ 0x1000:18a4
1000:1899      56                       PUSH SI
1000:189a      e8 fb 00                 CALL 0x1000:1998
1000:189d      5e                       POP SI
1000:189e      bb 09 19                 MOV BX,0x1909
1000:18a1      72 0a                    JC 0x1000:18ad
1000:18a3      c3                       RET
1000:18a4  LAB_1000_18a4:
1000:18a4      bb c4 18                 MOV BX,0x18c4
1000:18a7      a0 11 a2                 MOV AL,[0xa211]
1000:18aa      e8 c3 00                 CALL 0x1000:1970
1000:18ad  LAB_1000_18ad:
1000:18ad      2e 8a 27                 MOV AH,byte ptr CS:[BX]
1000:18b0      22 e4                    AND AH,AH
1000:18b2      74 0d                    JZ 0x1000:18c1
1000:18b4      3a c4                    CMP AL,AH
1000:18b6      74 05                    JZ 0x1000:18bd
1000:18b8      83 c3 03                 ADD BX,0x3
1000:18bb      eb f0                    JMP 0x1000:18ad
1000:18bd  LAB_1000_18bd:
1000:18bd      2e ff 67 01              JMP word ptr CS:[BX + 0x1]
1000:18c1  LAB_1000_18c1:
1000:18c1      e9 a4 01                 JMP 0x1000:1a68

; ------------------------------------------------------------
1000:1970  FUN_1000_1970:
1000:1970      3c 61                    CMP AL,0x61
1000:1972      72 06                    JC 0x1000:197a
1000:1974      3c 7a                    CMP AL,0x7a
1000:1976      77 02                    JA 0x1000:197a
1000:1978      24 5f                    AND AL,0x5f
1000:197a  LAB_1000_197a:
1000:197a      c3                       RET

; ------------------------------------------------------------
1000:197b  FUN_1000_197b:
1000:197b      80 3e e0 00 00           CMP byte ptr [0xe0],0x0
1000:1980      74 15                    JZ 0x1000:1997
1000:1982      fe 0e e0 00              DEC byte ptr [0xe0]
1000:1986      75 0f                    JNZ 0x1000:1997
1000:1988      e8 c2 00                 CALL 0x1000:1a4d
1000:198b      80 3e 9e a2 00           CMP byte ptr [0xa29e],0x0
1000:1990      74 05                    JZ 0x1000:1997
1000:1992      c6 06 e0 00 14           MOV byte ptr [0xe0],0x14
1000:1997  LAB_1000_1997:
1000:1997      c3                       RET

; ------------------------------------------------------------
1000:1998  FUN_1000_1998:
1000:1998      a0 11 a2                 MOV AL,[0xa211]
1000:199b      3c 0d                    CMP AL,0xd
1000:199d      74 37                    JZ 0x1000:19d6
1000:199f      3c 08                    CMP AL,0x8
1000:19a1      74 21                    JZ 0x1000:19c4
1000:19a3      3c 20                    CMP AL,0x20
1000:19a5      72 1b                    JC 0x1000:19c2
1000:19a7      3c 7e                    CMP AL,0x7e
1000:19a9      77 17                    JA 0x1000:19c2
1000:19ab      8a 5d 01                 MOV BL,byte ptr [DI + 0x1]
1000:19ae      32 ff                    XOR BH,BH
1000:19b0      88 41 02                 MOV byte ptr [BX + DI + 0x2],AL
1000:19b3      c6 41 03 00              MOV byte ptr [BX + DI + 0x3],0x0
1000:19b7      fe 45 01                 INC byte ptr [DI + 0x1]
1000:19ba      80 7d 01 16              CMP byte ptr [DI + 0x1],0x16
1000:19be      73 16                    JNC 0x1000:19d6
1000:19c0      f8                       CLC
1000:19c1      c3                       RET
1000:19c2  LAB_1000_19c2:
1000:19c2      f9                       STC
1000:19c3      c3                       RET
1000:19c4  LAB_1000_19c4:
1000:19c4      47                       INC DI
1000:19c5      8a 1d                    MOV BL,byte ptr [DI]
1000:19c7      32 ff                    XOR BH,BH
1000:19c9      80 3d 00                 CMP byte ptr [DI],0x0
1000:19cc      74 06                    JZ 0x1000:19d4
1000:19ce      c6 41 01 00              MOV byte ptr [BX + DI + 0x1],0x0
1000:19d2      fe 0d                    DEC byte ptr [DI]
1000:19d4  LAB_1000_19d4:
1000:19d4      f8                       CLC
1000:19d5      c3                       RET
1000:19d6  LAB_1000_19d6:
1000:19d6      57                       PUSH DI
1000:19d7      47                       INC DI
1000:19d8      8a 0d                    MOV CL,byte ptr [DI]
1000:19da      81 e1 ff 00              AND CX,0xff
1000:19de      74 63                    JZ 0x1000:1a43
1000:19e0      8a 45 02                 MOV AL,byte ptr [DI + 0x2]
1000:19e3      3c 3a                    CMP AL,0x3a
1000:19e5      75 16                    JNZ 0x1000:19fd
1000:19e7      8a 45 01                 MOV AL,byte ptr [DI + 0x1]
1000:19ea      2c 41                    SUB AL,0x41
1000:19ec      3a 06 6f a2              CMP AL,byte ptr [0xa26f]
1000:19f0      75 51                    JNZ 0x1000:1a43
1000:19f2      83 e9 02                 SUB CX,0x2
1000:19f5      76 4c                    JBE 0x1000:1a43
1000:19f7      83 c7 02                 ADD DI,0x2
1000:19fa      eb 0a                    JMP 0x1000:1a06
1000:19fd  LAB_1000_19fd:
1000:19fd      a0 74 a2                 MOV AL,[0xa274]
1000:1a00      3a 06 6f a2              CMP AL,byte ptr [0xa26f]
1000:1a04      74 3d                    JZ 0x1000:1a43
1000:1a06  LAB_1000_1a06:
1000:1a06      be 9e a2                 MOV SI,0xa29e
1000:1a09      b0 04                    MOV AL,0x4
1000:1a0b  LAB_1000_1a0b:
1000:1a0b      80 3c 00                 CMP byte ptr [SI],0x0
1000:1a0e      74 0c                    JZ 0x1000:1a1c
1000:1a10      83 c6 28                 ADD SI,0x28
1000:1a13      fe c8                    DEC AL
1000:1a15      75 f4                    JNZ 0x1000:1a0b
1000:1a17      e8 33 00                 CALL 0x1000:1a4d
1000:1a1a      eb ea                    JMP 0x1000:1a06
1000:1a1c  LAB_1000_1a1c:
1000:1a1c      47                       INC DI
1000:1a1d      87 f7                    XCHG DI,SI
1000:1a1f      b0 01                    MOV AL,0x1
1000:1a21      aa                       STOSB ES:DI
1000:1a22      f3 a4                    MOVSB.REP ES:DI,SI
1000:1a24      80 3e 0a 00 02           CMP byte ptr [0xa],0x2
1000:1a29      76 09                    JBE 0x1000:1a34
1000:1a2b      b0 2c                    MOV AL,0x2c
1000:1a2d      aa                       STOSB ES:DI
1000:1a2e      a0 74 a2                 MOV AL,[0xa274]
1000:1a31      04 41                    ADD AL,0x41
1000:1a33      aa                       STOSB ES:DI
1000:1a34  LAB_1000_1a34:
1000:1a34      b0 00                    MOV AL,0x0
1000:1a36      aa                       STOSB ES:DI
1000:1a37      80 3e e0 00 00           CMP byte ptr [0xe0],0x0
1000:1a3c      75 05                    JNZ 0x1000:1a43
1000:1a3e      c6 06 e0 00 14           MOV byte ptr [0xe0],0x14
1000:1a43  LAB_1000_1a43:
1000:1a43      5f                       POP DI
1000:1a44      b0 00                    MOV AL,0x0
1000:1a46      b9 28 00                 MOV CX,0x28
1000:1a49      f3 aa                    STOSB.REP ES:DI
1000:1a4b      f8                       CLC
1000:1a4c      c3                       RET

; ------------------------------------------------------------
1000:1a4d  FUN_1000_1a4d:
1000:1a4d      57                       PUSH DI
1000:1a4e      56                       PUSH SI
1000:1a4f      51                       PUSH CX
1000:1a50      bf 9e a2                 MOV DI,0xa29e
1000:1a53      8b f7                    MOV SI,DI
1000:1a55      83 c6 28                 ADD SI,0x28
1000:1a58      b9 78 00                 MOV CX,0x78
1000:1a5b      f3 a4                    MOVSB.REP ES:DI,SI
1000:1a5d      b9 28 00                 MOV CX,0x28
1000:1a60      b0 00                    MOV AL,0x0
1000:1a62      f3 aa                    STOSB.REP ES:DI
1000:1a64      59                       POP CX
1000:1a65      5e                       POP SI
1000:1a66      5f                       POP DI
1000:1a67      c3                       RET

; ------------------------------------------------------------
1000:1a68  FUN_1000_1a68:
1000:1a68      b8 01 00                 MOV AX,0x1
1000:1a6b      bb 5a a2                 MOV BX,0xa25a
1000:1a6e      eb 27                    JMP 0x1000:1a97
1000:1a71      80 25 01                 AND byte ptr [DI],0x1
1000:1a74      80 35 01                 XOR byte ptr [DI],0x1
1000:1a77      c3                       RET
1000:1a78      b0 02                    MOV AL,0x2
1000:1a7a      eb 0a                    JMP 0x1000:1a86
1000:1a7c      b0 04                    MOV AL,0x4
1000:1a7e      eb 06                    JMP 0x1000:1a86
1000:1a80      b0 06                    MOV AL,0x6
1000:1a82      eb 02                    JMP 0x1000:1a86
1000:1a84      b0 07                    MOV AL,0x7
1000:1a86  LAB_1000_1a86:
1000:1a86      8a 26 74 a2              MOV AH,byte ptr [0xa274]
1000:1a8a      32 26 6f a2              XOR AH,byte ptr [0xa26f]
1000:1a8e      80 e4 03                 AND AH,0x3
1000:1a91      75 03                    JNZ 0x1000:1a96
1000:1a93      a2 70 a2                 MOV [0xa270],AL
1000:1a96  LAB_1000_1a96:
1000:1a96      c3                       RET

; ------------------------------------------------------------
1000:1a97  FUN_1000_1a97:
1000:1a97      50                       PUSH AX
1000:1a98      a0 74 a2                 MOV AL,[0xa274]
1000:1a9b      32 06 6f a2              XOR AL,byte ptr [0xa26f]
1000:1a9f      24 03                    AND AL,0x3
1000:1aa1      58                       POP AX
1000:1aa2      75 02                    JNZ 0x1000:1aa6
1000:1aa4      89 07                    MOV word ptr [BX],AX
1000:1aa6  LAB_1000_1aa6:
1000:1aa6      c3                       RET
1000:1aa7      b0 01                    MOV AL,0x1
1000:1aa9      8a 0e 74 a2              MOV CL,byte ptr [0xa274]
1000:1aad      d2 e0                    SHL AL,CL
1000:1aaf      84 06 6c a2              TEST byte ptr [0xa26c],AL
1000:1ab3      74 0c                    JZ 0x1000:1ac1
1000:1ab5      f6 06 6c a2 80           TEST byte ptr [0xa26c],0x80
1000:1aba      74 1c                    JZ 0x1000:1ad8
1000:1abc      30 06 6c a2              XOR byte ptr [0xa26c],AL
1000:1ac0      c3                       RET
1000:1ac1  LAB_1000_1ac1:
1000:1ac1      f6 06 6c a2 80           TEST byte ptr [0xa26c],0x80
1000:1ac6      75 10                    JNZ 0x1000:1ad8
1000:1ac8      30 06 6c a2              XOR byte ptr [0xa26c],AL
1000:1acc      80 3e 6d a2 00           CMP byte ptr [0xa26d],0x0
1000:1ad1      75 05                    JNZ 0x1000:1ad8
1000:1ad3      c6 06 6d a2 07           MOV byte ptr [0xa26d],0x7
1000:1ad8  LAB_1000_1ad8:
1000:1ad8      c3                       RET
1000:1ad9      b0 00                    MOV AL,0x0
1000:1adb      eb 0a                    JMP 0x1000:1ae7
1000:1add  LAB_1000_1add:
1000:1add      b0 01                    MOV AL,0x1
1000:1adf      eb 06                    JMP 0x1000:1ae7
1000:1ae1      b0 02                    MOV AL,0x2
1000:1ae3      eb 02                    JMP 0x1000:1ae7
1000:1ae5      b0 03                    MOV AL,0x3
1000:1ae7  LAB_1000_1ae7:
1000:1ae7      50                       PUSH AX
1000:1ae8      e8 21 0f                 CALL 0x1000:2a0c
1000:1aeb      74 0e                    JZ 0x1000:1afb
1000:1aed      89 36 50 a3              MOV word ptr [0xa350],SI
1000:1af1      e8 cd 03                 CALL 0x1000:1ec1
1000:1af4      80 27 e8                 AND byte ptr [BX],0xe8
1000:1af7      58                       POP AX
1000:1af8      08 07                    OR byte ptr [BX],AL
1000:1afa      c3                       RET
1000:1afb  LAB_1000_1afb:
1000:1afb      58                       POP AX
1000:1afc      c3                       RET
1000:1afd      b0 00                    MOV AL,0x0
1000:1aff      eb 46                    JMP 0x1000:1b47
1000:1b01      b0 01                    MOV AL,0x1
1000:1b03      eb 42                    JMP 0x1000:1b47
1000:1b05      b0 02                    MOV AL,0x2
1000:1b07      eb 3e                    JMP 0x1000:1b47
1000:1b09      b0 03                    MOV AL,0x3
1000:1b0b      eb 3a                    JMP 0x1000:1b47
1000:1b0d      b0 04                    MOV AL,0x4
1000:1b0f      eb 36                    JMP 0x1000:1b47
1000:1b11      b0 05                    MOV AL,0x5
1000:1b13      eb 32                    JMP 0x1000:1b47
1000:1b15      b0 06                    MOV AL,0x6
1000:1b17      eb 2e                    JMP 0x1000:1b47
1000:1b19      b0 07                    MOV AL,0x7
1000:1b1b      eb 2a                    JMP 0x1000:1b47
1000:1b1d      b0 08                    MOV AL,0x8
1000:1b1f      eb 26                    JMP 0x1000:1b47
1000:1b21      b0 09                    MOV AL,0x9
1000:1b23      eb 22                    JMP 0x1000:1b47
1000:1b25      b0 0a                    MOV AL,0xa
1000:1b27      eb 1e                    JMP 0x1000:1b47
1000:1b29      b0 0b                    MOV AL,0xb
1000:1b2b      eb 1a                    JMP 0x1000:1b47
1000:1b2d      b0 0c                    MOV AL,0xc
1000:1b2f      eb 16                    JMP 0x1000:1b47
1000:1b31      b0 0d                    MOV AL,0xd
1000:1b33      eb 12                    JMP 0x1000:1b47
1000:1b35      b0 0e                    MOV AL,0xe
1000:1b37      eb 0e                    JMP 0x1000:1b47
1000:1b39      b0 10                    MOV AL,0x10
1000:1b3b      eb 0a                    JMP 0x1000:1b47
1000:1b3d      b0 11                    MOV AL,0x11
1000:1b3f      eb 06                    JMP 0x1000:1b47
1000:1b41      b0 12                    MOV AL,0x12
1000:1b43      eb 02                    JMP 0x1000:1b47
1000:1b45      b0 13                    MOV AL,0x13
1000:1b47  LAB_1000_1b47:
1000:1b47      e8 48 03                 CALL 0x1000:1e92
1000:1b4a      88 44 11                 MOV byte ptr [SI + 0x11],AL
1000:1b4d      a8 10                    TEST AL,0x10
1000:1b4f      74 18                    JZ 0x1000:1b69
1000:1b51      b9 05 00                 MOV CX,0x5
1000:1b54  LAB_1000_1b54:
1000:1b54      56                       PUSH SI
1000:1b55      e8 b4 0e                 CALL 0x1000:2a0c
1000:1b58      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
1000:1b5b      5e                       POP SI
1000:1b5c      a8 10                    TEST AL,0x10
1000:1b5e      74 09                    JZ 0x1000:1b69
1000:1b60      e2 f2                    LOOP 0x1000:1b54
1000:1b62      c6 44 11 00              MOV byte ptr [SI + 0x11],0x0
1000:1b66      e9 ff fe                 JMP 0x1000:1a68
1000:1b69  LAB_1000_1b69:
1000:1b69      80 7c 0b 50              CMP byte ptr [SI + 0xb],0x50
1000:1b6d      77 08                    JA 0x1000:1b77
1000:1b6f      80 64 0b 0f              AND byte ptr [SI + 0xb],0xf
1000:1b73      80 4c 0b 50              OR byte ptr [SI + 0xb],0x50
1000:1b77  LAB_1000_1b77:
1000:1b77      c3                       RET

; ------------------------------------------------------------
1000:1b78  FUN_1000_1b78:
1000:1b78      e8 46 03                 CALL 0x1000:1ec1
1000:1b7b      80 0f 10                 OR byte ptr [BX],0x10
1000:1b7e      c3                       RET
1000:1b7f      e8 10 03                 CALL 0x1000:1e92
1000:1b82      e8 49 03                 CALL 0x1000:1ece
                ; ptr table -> 1000:1b8d  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
1000:1b8d  LAB_1000_1b8d:
1000:1b8d      8a 47 05                 MOV AL,byte ptr [BX + 0x5]
1000:1b90      3a 44 17                 CMP AL,byte ptr [SI + 0x17]
1000:1b93      75 0f                    JNZ 0x1000:1ba4
1000:1b95      88 44 31                 MOV byte ptr [SI + 0x31],AL
1000:1b98      8b 44 01                 MOV AX,word ptr [SI + 0x1]
1000:1b9b      89 44 2d                 MOV word ptr [SI + 0x2d],AX
1000:1b9e      8b 44 03                 MOV AX,word ptr [SI + 0x3]
1000:1ba1      89 44 2f                 MOV word ptr [SI + 0x2f],AX
1000:1ba4  LAB_1000_1ba4:
1000:1ba4      c3                       RET
1000:1ba5      e8 ea 02                 CALL 0x1000:1e92
1000:1ba8      fe 44 2b                 INC byte ptr [SI + 0x2b]
1000:1bab      80 64 2b 03              AND byte ptr [SI + 0x2b],0x3
1000:1baf      c3                       RET
1000:1bb0      e8 0e 03                 CALL 0x1000:1ec1
1000:1bb3      80 07 40                 ADD byte ptr [BX],0x40
1000:1bb6      c3                       RET
1000:1bb7  LAB_1000_1bb7:
1000:1bb7      e8 d8 02                 CALL 0x1000:1e92
1000:1bba      80 0c 20                 OR byte ptr [SI],0x20
1000:1bbd      8b 74 32                 MOV SI,word ptr [SI + 0x32]
1000:1bc0      23 f6                    AND SI,SI
1000:1bc2      75 f3                    JNZ 0x1000:1bb7
1000:1bc4      c3                       RET
1000:1bc5  LAB_1000_1bc5:
1000:1bc5      e8 ca 02                 CALL 0x1000:1e92
1000:1bc8      80 24 df                 AND byte ptr [SI],0xdf
1000:1bcb      8b 74 32                 MOV SI,word ptr [SI + 0x32]
1000:1bce      23 f6                    AND SI,SI
1000:1bd0      75 f3                    JNZ 0x1000:1bc5
1000:1bd2      c3                       RET
1000:1bd3      e8 bc 02                 CALL 0x1000:1e92
1000:1bd6      c6 44 11 00              MOV byte ptr [SI + 0x11],0x0
1000:1bda      80 44 0a 10              ADD byte ptr [SI + 0xa],0x10
1000:1bde      c3                       RET
1000:1bdf      e8 b0 02                 CALL 0x1000:1e92
1000:1be2      c6 44 11 00              MOV byte ptr [SI + 0x11],0x0
1000:1be6      80 6c 0a 10              SUB byte ptr [SI + 0xa],0x10
1000:1bea      c3                       RET
1000:1beb      e8 a4 02                 CALL 0x1000:1e92
1000:1bee      80 64 11 7f              AND byte ptr [SI + 0x11],0x7f
1000:1bf2      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
1000:1bf5      24 f0                    AND AL,0xf0
1000:1bf7      3c a0                    CMP AL,0xa0
1000:1bf9      73 04                    JNC 0x1000:1bff
1000:1bfb      80 44 0b 10              ADD byte ptr [SI + 0xb],0x10
1000:1bff  LAB_1000_1bff:
1000:1bff      c3                       RET
1000:1c00      e8 8f 02                 CALL 0x1000:1e92
1000:1c03      80 64 11 7f              AND byte ptr [SI + 0x11],0x7f
1000:1c07      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
1000:1c0a      24 f0                    AND AL,0xf0
1000:1c0c      74 08                    JZ 0x1000:1c16
1000:1c0e      80 6c 0b 10              SUB byte ptr [SI + 0xb],0x10
1000:1c12      c6 44 14 00              MOV byte ptr [SI + 0x14],0x0
1000:1c16  LAB_1000_1c16:
1000:1c16      c3                       RET
1000:1c17  LAB_1000_1c17:
1000:1c17      e8 78 02                 CALL 0x1000:1e92
1000:1c1a      8a 44 19                 MOV AL,byte ptr [SI + 0x19]
1000:1c1d      22 c0                    AND AL,AL
1000:1c1f      78 0a                    JS 0x1000:1c2b
1000:1c21      74 08                    JZ 0x1000:1c2b
1000:1c23      3c 04                    CMP AL,0x4
1000:1c25      72 04                    JC 0x1000:1c2b
1000:1c27      c6 44 19 03              MOV byte ptr [SI + 0x19],0x3
1000:1c2b  LAB_1000_1c2b:
1000:1c2b      8b 74 32                 MOV SI,word ptr [SI + 0x32]
1000:1c2e      23 f6                    AND SI,SI
1000:1c30      75 e5                    JNZ 0x1000:1c17
1000:1c32      c3                       RET
1000:1c33  LAB_1000_1c33:
1000:1c33      e8 5c 02                 CALL 0x1000:1e92
1000:1c36      e8 08 00                 CALL 0x1000:1c41
1000:1c39      8b 74 32                 MOV SI,word ptr [SI + 0x32]
1000:1c3c      23 f6                    AND SI,SI
1000:1c3e      75 f3                    JNZ 0x1000:1c33
1000:1c40      c3                       RET

; ------------------------------------------------------------
1000:1c41  FUN_1000_1c41:
1000:1c41      f6 44 15 ff              TEST byte ptr [SI + 0x15],0xff
1000:1c45      75 4e                    JNZ 0x1000:1c95
1000:1c47      8a 44 19                 MOV AL,byte ptr [SI + 0x19]
1000:1c4a      22 c0                    AND AL,AL
1000:1c4c      75 47                    JNZ 0x1000:1c95
1000:1c4e      8b 44 0a                 MOV AX,word ptr [SI + 0xa]
1000:1c51      25 0f 0f                 AND AX,0xf0f
1000:1c54      f6 04 04                 TEST byte ptr [SI],0x4
1000:1c57      74 04                    JZ 0x1000:1c5d
1000:1c59      b4 18                    MOV AH,0x18
1000:1c5b      eb 11                    JMP 0x1000:1c6e
1000:1c5d  LAB_1000_1c5d:
1000:1c5d      80 c4 09                 ADD AH,0x9
1000:1c60      80 fc 13                 CMP AH,0x13
1000:1c63      72 09                    JC 0x1000:1c6e
1000:1c65      f6 44 14 ff              TEST byte ptr [SI + 0x14],0xff
1000:1c69      74 03                    JZ 0x1000:1c6e
1000:1c6b      80 c4 07                 ADD AH,0x7
1000:1c6e  LAB_1000_1c6e:
1000:1c6e      89 44 1f                 MOV word ptr [SI + 0x1f],AX
1000:1c71      f6 44 07 ff              TEST byte ptr [SI + 0x7],0xff
1000:1c75      74 1e                    JZ 0x1000:1c95
1000:1c77      fe 4c 07                 DEC byte ptr [SI + 0x7]
1000:1c7a      c6 44 19 26              MOV byte ptr [SI + 0x19],0x26
1000:1c7e      c6 44 15 06              MOV byte ptr [SI + 0x15],0x6
1000:1c82      8b 44 01                 MOV AX,word ptr [SI + 0x1]
1000:1c85      89 44 1a                 MOV word ptr [SI + 0x1a],AX
1000:1c88      8b 44 03                 MOV AX,word ptr [SI + 0x3]
1000:1c8b      89 44 1c                 MOV word ptr [SI + 0x1c],AX
1000:1c8e      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
1000:1c91      88 44 1e                 MOV byte ptr [SI + 0x1e],AL
1000:1c94      c3                       RET
1000:1c95  LAB_1000_1c95:
1000:1c95      b8 04 00                 MOV AX,0x4
1000:1c98      bb 5a a2                 MOV BX,0xa25a
1000:1c9b      e8 f9 fd                 CALL 0x1000:1a97
1000:1c9e      c3                       RET
1000:1c9f      e8 f0 01                 CALL 0x1000:1e92
1000:1ca2      80 7c 2a 00              CMP byte ptr [SI + 0x2a],0x0
1000:1ca6      74 04                    JZ 0x1000:1cac
1000:1ca8      80 74 22 01              XOR byte ptr [SI + 0x22],0x1
1000:1cac  LAB_1000_1cac:
1000:1cac      c3                       RET
1000:1cad      e8 e2 01                 CALL 0x1000:1e92
1000:1cb0      80 74 29 02              XOR byte ptr [SI + 0x29],0x2
1000:1cb4      c3                       RET
1000:1cb5  LAB_1000_1cb5:
1000:1cb5      e8 da 01                 CALL 0x1000:1e92
1000:1cb8      e8 08 00                 CALL 0x1000:1cc3
1000:1cbb      8b 74 32                 MOV SI,word ptr [SI + 0x32]
1000:1cbe      23 f6                    AND SI,SI
1000:1cc0      75 f3                    JNZ 0x1000:1cb5
1000:1cc2      c3                       RET

; ------------------------------------------------------------
1000:1cc3  FUN_1000_1cc3:
1000:1cc3      80 7c 0f 01              CMP byte ptr [SI + 0xf],0x1
1000:1cc7      72 03                    JC 0x1000:1ccc
1000:1cc9      80 0c 10                 OR byte ptr [SI],0x10
1000:1ccc  LAB_1000_1ccc:
1000:1ccc      c3                       RET
1000:1ccd  LAB_1000_1ccd:
1000:1ccd      e8 c2 01                 CALL 0x1000:1e92
1000:1cd0      e8 08 00                 CALL 0x1000:1cdb
1000:1cd3      8b 74 32                 MOV SI,word ptr [SI + 0x32]
1000:1cd6      23 f6                    AND SI,SI
1000:1cd8      75 f3                    JNZ 0x1000:1ccd
1000:1cda      c3                       RET

; ------------------------------------------------------------
1000:1cdb  FUN_1000_1cdb:
1000:1cdb      80 64 11 7f              AND byte ptr [SI + 0x11],0x7f
1000:1cdf      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
1000:1ce2      24 0f                    AND AL,0xf
1000:1ce4      f6 04 44                 TEST byte ptr [SI],0x44
1000:1ce7      74 02                    JZ 0x1000:1ceb
1000:1ce9      b0 0b                    MOV AL,0xb
1000:1ceb  LAB_1000_1ceb:
1000:1ceb      0c b0                    OR AL,0xb0
1000:1ced      88 44 0b                 MOV byte ptr [SI + 0xb],AL
1000:1cf0      8a 44 14                 MOV AL,byte ptr [SI + 0x14]
1000:1cf3      3c 5a                    CMP AL,0x5a
1000:1cf5      77 05                    JA 0x1000:1cfc
1000:1cf7      80 44 14 0a              ADD byte ptr [SI + 0x14],0xa
1000:1cfb      c3                       RET
1000:1cfc  LAB_1000_1cfc:
1000:1cfc      c6 44 14 64              MOV byte ptr [SI + 0x14],0x64
1000:1d00      c3                       RET
1000:1d01  LAB_1000_1d01:
1000:1d01      e8 8e 01                 CALL 0x1000:1e92
1000:1d04      e8 08 00                 CALL 0x1000:1d0f
1000:1d07      8b 74 32                 MOV SI,word ptr [SI + 0x32]
1000:1d0a      23 f6                    AND SI,SI
1000:1d0c      75 f3                    JNZ 0x1000:1d01
1000:1d0e      c3                       RET

; ------------------------------------------------------------
1000:1d0f  FUN_1000_1d0f:
1000:1d0f      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
1000:1d12      25 0f 00                 AND AX,0xf
1000:1d15      3d 0a 00                 CMP AX,0xa
1000:1d18      76 03                    JBE 0x1000:1d1d
1000:1d1a      b8 14 00                 MOV AX,0x14
1000:1d1d  LAB_1000_1d1d:
1000:1d1d      b1 05                    MOV CL,0x5
1000:1d1f      d3 e0                    SHL AX,CL
1000:1d21      c6 44 14 00              MOV byte ptr [SI + 0x14],0x0
1000:1d25      c6 44 0b 00              MOV byte ptr [SI + 0xb],0x0
1000:1d29      8b fe                    MOV DI,SI
1000:1d2b      e8 6d 06                 CALL 0x1000:239b
1000:1d2e      c3                       RET
1000:1d2f  LAB_1000_1d2f:
1000:1d2f      e8 60 01                 CALL 0x1000:1e92
1000:1d32      c6 44 22 00              MOV byte ptr [SI + 0x22],0x0
1000:1d36      80 7c 15 14              CMP byte ptr [SI + 0x15],0x14
1000:1d3a      77 17                    JA 0x1000:1d53
1000:1d3c      e8 8f 01                 CALL 0x1000:1ece
                ; ptr table -> 1000:1d47  [ptr] 1000:904c 1000:90ec 1000:918c 1000:922c
1000:1d47  LAB_1000_1d47:
1000:1d47      8b fb                    MOV DI,BX
1000:1d49      87 fe                    XCHG SI,DI
1000:1d4b      80 7d 06 00              CMP byte ptr [DI + 0x6],0x0
1000:1d4f      75 13                    JNZ 0x1000:1d64
1000:1d51      87 fe                    XCHG SI,DI
1000:1d53  LAB_1000_1d53:
1000:1d53      8b 74 32                 MOV SI,word ptr [SI + 0x32]
1000:1d56      23 f6                    AND SI,SI
1000:1d58      75 d5                    JNZ 0x1000:1d2f
1000:1d5a      b8 04 00                 MOV AX,0x4
1000:1d5d      bb 5a a2                 MOV BX,0xa25a
1000:1d60      e8 34 fd                 CALL 0x1000:1a97
1000:1d63      c3                       RET

; ------------------------------------------------------------
1000:1d64  FUN_1000_1d64:
1000:1d64      b9 14 00                 MOV CX,0x14
1000:1d67  LAB_1000_1d67:
1000:1d67      80 3c 00                 CMP byte ptr [SI],0x0
1000:1d6a      74 06                    JZ 0x1000:1d72
1000:1d6c      83 c6 08                 ADD SI,0x8
1000:1d6f      e2 f6                    LOOP 0x1000:1d67
1000:1d71      c3                       RET
1000:1d72  LAB_1000_1d72:
1000:1d72      fe 4d 06                 DEC byte ptr [DI + 0x6]
1000:1d75      c6 04 fa                 MOV byte ptr [SI],0xfa
1000:1d78      8b 45 01                 MOV AX,word ptr [DI + 0x1]
1000:1d7b      89 44 01                 MOV word ptr [SI + 0x1],AX
1000:1d7e      8b 45 03                 MOV AX,word ptr [DI + 0x3]
1000:1d81      89 44 03                 MOV word ptr [SI + 0x3],AX
1000:1d84      8a 45 05                 MOV AL,byte ptr [DI + 0x5]
1000:1d87      88 44 05                 MOV byte ptr [SI + 0x5],AL
1000:1d8a      8a 45 18                 MOV AL,byte ptr [DI + 0x18]
1000:1d8d      88 44 07                 MOV byte ptr [SI + 0x7],AL
1000:1d90      8a 45 17                 MOV AL,byte ptr [DI + 0x17]
1000:1d93      88 44 06                 MOV byte ptr [SI + 0x6],AL
1000:1d96      c3                       RET
1000:1d97  LAB_1000_1d97:
1000:1d97      e8 f8 00                 CALL 0x1000:1e92
1000:1d9a      e8 08 00                 CALL 0x1000:1da5
1000:1d9d      8b 74 32                 MOV SI,word ptr [SI + 0x32]
1000:1da0      23 f6                    AND SI,SI
1000:1da2      75 f3                    JNZ 0x1000:1d97
1000:1da4      c3                       RET

; ------------------------------------------------------------
1000:1da5  FUN_1000_1da5:
1000:1da5      f6 44 15 ff              TEST byte ptr [SI + 0x15],0xff
1000:1da9      75 43                    JNZ 0x1000:1dee
1000:1dab      f6 44 19 80              TEST byte ptr [SI + 0x19],0x80
1000:1daf      75 3d                    JNZ 0x1000:1dee
1000:1db1      b8 c8 00                 MOV AX,0xc8
1000:1db4      8b fe                    MOV DI,SI
1000:1db6      e8 e2 05                 CALL 0x1000:239b
1000:1db9      8b 44 0a                 MOV AX,word ptr [SI + 0xa]
1000:1dbc      25 0f 0f                 AND AX,0xf0f
1000:1dbf      80 c4 09                 ADD AH,0x9
1000:1dc2      80 fc 13                 CMP AH,0x13
1000:1dc5      72 09                    JC 0x1000:1dd0
1000:1dc7      f6 44 14 ff              TEST byte ptr [SI + 0x14],0xff
1000:1dcb      74 03                    JZ 0x1000:1dd0
1000:1dcd      80 c4 07                 ADD AH,0x7
1000:1dd0  LAB_1000_1dd0:
1000:1dd0      89 44 1f                 MOV word ptr [SI + 0x1f],AX
1000:1dd3      c6 44 19 8c              MOV byte ptr [SI + 0x19],0x8c
1000:1dd7      c6 44 15 0c              MOV byte ptr [SI + 0x15],0xc
1000:1ddb      8b 44 01                 MOV AX,word ptr [SI + 0x1]
1000:1dde      89 44 1a                 MOV word ptr [SI + 0x1a],AX
1000:1de1      8b 44 03                 MOV AX,word ptr [SI + 0x3]
1000:1de4      89 44 1c                 MOV word ptr [SI + 0x1c],AX
1000:1de7      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
1000:1dea      88 44 1e                 MOV byte ptr [SI + 0x1e],AL
1000:1ded      c3                       RET
1000:1dee  LAB_1000_1dee:
1000:1dee      b8 04 00                 MOV AX,0x4
1000:1df1      bb 5a a2                 MOV BX,0xa25a
1000:1df4      e8 a0 fc                 CALL 0x1000:1a97
1000:1df7      c3                       RET
1000:1df8  LAB_1000_1df8:
1000:1df8      e8 97 00                 CALL 0x1000:1e92
1000:1dfb      e8 08 00                 CALL 0x1000:1e06
1000:1dfe      8b 74 32                 MOV SI,word ptr [SI + 0x32]
1000:1e01      23 f6                    AND SI,SI
1000:1e03      75 f3                    JNZ 0x1000:1df8
1000:1e05      c3                       RET

; ------------------------------------------------------------
1000:1e06  FUN_1000_1e06:
1000:1e06      f6 44 15 ff              TEST byte ptr [SI + 0x15],0xff
1000:1e0a      75 3e                    JNZ 0x1000:1e4a
1000:1e0c      f6 44 19 80              TEST byte ptr [SI + 0x19],0x80
1000:1e10      75 38                    JNZ 0x1000:1e4a
1000:1e12      b8 64 00                 MOV AX,0x64
1000:1e15      8b fe                    MOV DI,SI
1000:1e17      e8 81 05                 CALL 0x1000:239b
1000:1e1a      8b 44 0a                 MOV AX,word ptr [SI + 0xa]
1000:1e1d      80 e4 0f                 AND AH,0xf
1000:1e20      80 ec 09                 SUB AH,0x9
1000:1e23      79 04                    JNS 0x1000:1e29
1000:1e25      f6 dc                    NEG AH
1000:1e27      34 08                    XOR AL,0x8
1000:1e29  LAB_1000_1e29:
1000:1e29      25 0f 0f                 AND AX,0xf0f
1000:1e2c      89 44 1f                 MOV word ptr [SI + 0x1f],AX
1000:1e2f      c6 44 19 ca              MOV byte ptr [SI + 0x19],0xca
1000:1e33      c6 44 15 0a              MOV byte ptr [SI + 0x15],0xa
1000:1e37      8b 44 01                 MOV AX,word ptr [SI + 0x1]
1000:1e3a      89 44 1a                 MOV word ptr [SI + 0x1a],AX
1000:1e3d      8b 44 03                 MOV AX,word ptr [SI + 0x3]
1000:1e40      89 44 1c                 MOV word ptr [SI + 0x1c],AX
1000:1e43      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
1000:1e46      88 44 1e                 MOV byte ptr [SI + 0x1e],AL
1000:1e49      c3                       RET
1000:1e4a  LAB_1000_1e4a:
1000:1e4a      b8 04 00                 MOV AX,0x4
1000:1e4d      bb 5a a2                 MOV BX,0xa25a
1000:1e50      e8 44 fc                 CALL 0x1000:1a97
1000:1e53      c3                       RET
1000:1e54  LAB_1000_1e54:
1000:1e54      e8 3b 00                 CALL 0x1000:1e92
1000:1e57      80 24 ef                 AND byte ptr [SI],0xef
1000:1e5a      8b 74 32                 MOV SI,word ptr [SI + 0x32]
1000:1e5d      23 f6                    AND SI,SI
1000:1e5f      75 f3                    JNZ 0x1000:1e54
1000:1e61      c3                       RET
1000:1e62      e8 2d 00                 CALL 0x1000:1e92
1000:1e65      8b 44 08                 MOV AX,word ptr [SI + 0x8]
1000:1e68      3d 88 13                 CMP AX,0x1388
1000:1e6b      72 0a                    JC 0x1000:1e77
1000:1e6d      b8 04 00                 MOV AX,0x4
1000:1e70      bb 5a a2                 MOV BX,0xa25a
1000:1e73      e8 21 fc                 CALL 0x1000:1a97
1000:1e76      c3                       RET
1000:1e77  LAB_1000_1e77:
1000:1e77      c7 44 0c 50 c3           MOV word ptr [SI + 0xc],0xc350
1000:1e7c      c3                       RET
1000:1e7d      e8 4e 00                 CALL 0x1000:1ece
                ; ptr table -> 1000:1e88  [ptr] 1000:89d8 1000:89d9 1000:89da 1000:89db
1000:1e88  LAB_1000_1e88:
1000:1e88      80 0f 01                 OR byte ptr [BX],0x1
1000:1e8b      c3                       RET
1000:1e8c      c6 06 ed 00 01           MOV byte ptr [0xed],0x1
1000:1e91      c3                       RET

; ------------------------------------------------------------
1000:1e92  FUN_1000_1e92:
1000:1e92      f6 04 80                 TEST byte ptr [SI],0x80
1000:1e95      74 1f                    JZ 0x1000:1eb6
1000:1e97      f6 06 6c a2 80           TEST byte ptr [0xa26c],0x80
1000:1e9c      75 18                    JNZ 0x1000:1eb6
1000:1e9e      51                       PUSH CX
1000:1e9f      8a 0e 74 a2              MOV CL,byte ptr [0xa274]
1000:1ea3      b5 01                    MOV CH,0x1
1000:1ea5      d2 e5                    SHL CH,CL
1000:1ea7      22 2e 6c a2              AND CH,byte ptr [0xa26c]
1000:1eab      59                       POP CX
1000:1eac      75 08                    JNZ 0x1000:1eb6
1000:1eae      e8 10 00                 CALL 0x1000:1ec1
1000:1eb1      f6 07 10                 TEST byte ptr [BX],0x10
1000:1eb4      74 0a                    JZ 0x1000:1ec0
1000:1eb6  LAB_1000_1eb6:
1000:1eb6      b8 06 00                 MOV AX,0x6
1000:1eb9      bb 5a a2                 MOV BX,0xa25a
1000:1ebc      e8 d8 fb                 CALL 0x1000:1a97
1000:1ebf      5b                       POP BX
1000:1ec0  LAB_1000_1ec0:
1000:1ec0      c3                       RET

; ------------------------------------------------------------
1000:1ec1  FUN_1000_1ec1:
1000:1ec1      8a 1e 74 a2              MOV BL,byte ptr [0xa274]
1000:1ec5      81 e3 03 00              AND BX,0x3
1000:1ec9      81 c3 d4 89              ADD BX,0x89d4
1000:1ecd      c3                       RET

; ------------------------------------------------------------
1000:1ece  pick_ptr:
1000:1ece      5b                       POP BX
1000:1ecf      83 c3 08                 ADD BX,0x8
1000:1ed2      53                       PUSH BX
1000:1ed3      50                       PUSH AX
1000:1ed4      83 eb 08                 SUB BX,0x8
1000:1ed7      a0 74 a2                 MOV AL,[0xa274]
1000:1eda      25 03 00                 AND AX,0x3
1000:1edd      d1 e0                    SHL AX,0x1
1000:1edf      03 d8                    ADD BX,AX
1000:1ee1      58                       POP AX
1000:1ee2      2e 8b 1f                 MOV BX,word ptr CS:[BX]
1000:1ee5      c3                       RET

; ------------------------------------------------------------
1000:1ee6  FUN_1000_1ee6:
1000:1ee6      e8 b9 03                 CALL 0x1000:22a2
1000:1ee9      e8 43 01                 CALL 0x1000:202f
1000:1eec      e8 54 04                 CALL 0x1000:2343
1000:1eef      bf 64 8c                 MOV DI,0x8c64
1000:1ef2      c6 06 74 a2 00           MOV byte ptr [0xa274],0x0
1000:1ef7      e8 22 00                 CALL 0x1000:1f1c
1000:1efa      bf 50 8d                 MOV DI,0x8d50
1000:1efd      c6 06 74 a2 01           MOV byte ptr [0xa274],0x1
1000:1f02      e8 17 00                 CALL 0x1000:1f1c
1000:1f05      bf 3c 8e                 MOV DI,0x8e3c
1000:1f08      c6 06 74 a2 02           MOV byte ptr [0xa274],0x2
1000:1f0d      e8 0c 00                 CALL 0x1000:1f1c
1000:1f10      bf 28 8f                 MOV DI,0x8f28
1000:1f13      c6 06 74 a2 03           MOV byte ptr [0xa274],0x3
1000:1f18      e8 01 00                 CALL 0x1000:1f1c
1000:1f1b      c3                       RET

; ------------------------------------------------------------
1000:1f1c  FUN_1000_1f1c:
1000:1f1c      b1 00                    MOV CL,0x0
1000:1f1e      c6 06 95 a2 00           MOV byte ptr [0xa295],0x0
1000:1f23  LAB_1000_1f23:
1000:1f23      fe 06 95 a2              INC byte ptr [0xa295]
1000:1f27      51                       PUSH CX
1000:1f28      f6 05 80                 TEST byte ptr [DI],0x80
1000:1f2b      74 14                    JZ 0x1000:1f41
1000:1f2d      e8 25 01                 CALL 0x1000:2055
1000:1f30      e8 58 02                 CALL 0x1000:218b
1000:1f33      e8 36 03                 CALL 0x1000:226c
1000:1f36      e8 aa 01                 CALL 0x1000:20e3
1000:1f39      e8 ce 01                 CALL 0x1000:210a
1000:1f3c      f6 05 80                 TEST byte ptr [DI],0x80
1000:1f3f      75 1d                    JNZ 0x1000:1f5e
1000:1f41  LAB_1000_1f41:
1000:1f41      fe 0e 95 a2              DEC byte ptr [0xa295]
1000:1f45      f6 05 ff                 TEST byte ptr [DI],0xff
1000:1f48      75 0d                    JNZ 0x1000:1f57
1000:1f4a      59                       POP CX
1000:1f4b      51                       PUSH CX
1000:1f4c      e8 0a 25                 CALL 0x1000:4459
1000:1f4f      72 0d                    JC 0x1000:1f5e
1000:1f51      fe 06 95 a2              INC byte ptr [0xa295]
1000:1f55      eb 07                    JMP 0x1000:1f5e
1000:1f57  LAB_1000_1f57:
1000:1f57      fe 0d                    DEC byte ptr [DI]
1000:1f59      75 03                    JNZ 0x1000:1f5e
1000:1f5b      e8 a4 00                 CALL 0x1000:2002
1000:1f5e  LAB_1000_1f5e:
1000:1f5e      83 c7 3b                 ADD DI,0x3b
1000:1f61      59                       POP CX
1000:1f62      fe c1                    INC CL
1000:1f64      80 f9 04                 CMP CL,0x4
1000:1f67      72 ba                    JC 0x1000:1f23
1000:1f69      e8 62 ff                 CALL 0x1000:1ece
                ; ptr table -> 1000:1f74  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
1000:1f74  LAB_1000_1f74:
1000:1f74      8b f3                    MOV SI,BX
1000:1f76      8a 1e 74 a2              MOV BL,byte ptr [0xa274]
1000:1f7a      b7 00                    MOV BH,0x0
1000:1f7c      80 bf e0 89 00           CMP byte ptr [BX + 0x89e0],0x0
1000:1f81      75 7e                    JNZ 0x1000:2001
1000:1f83      80 bf d8 89 01           CMP byte ptr [BX + 0x89d8],0x1
1000:1f88      75 05                    JNZ 0x1000:1f8f
1000:1f8a      b0 03                    MOV AL,0x3
1000:1f8c      eb 26                    JMP 0x1000:1fb4
1000:1f8f  LAB_1000_1f8f:
1000:1f8f      83 7c 08 00              CMP word ptr [SI + 0x8],0x0
1000:1f93      75 0d                    JNZ 0x1000:1fa2
1000:1f95      c6 44 0a 00              MOV byte ptr [SI + 0xa],0x0
1000:1f99      80 7c 0d 00              CMP byte ptr [SI + 0xd],0x0
1000:1f9d      74 03                    JZ 0x1000:1fa2
1000:1f9f      fe 4c 0d                 DEC byte ptr [SI + 0xd]
1000:1fa2  LAB_1000_1fa2:
1000:1fa2      a0 95 a2                 MOV AL,[0xa295]
1000:1fa5      02 44 0a                 ADD AL,byte ptr [SI + 0xa]
1000:1fa8      88 87 dc 89              MOV byte ptr [BX + 0x89dc],AL
1000:1fac      3c 00                    CMP AL,0x0
1000:1fae      b0 01                    MOV AL,0x1
1000:1fb0      74 02                    JZ 0x1000:1fb4
1000:1fb2      b0 00                    MOV AL,0x0
1000:1fb4  LAB_1000_1fb4:
1000:1fb4      88 87 e0 89              MOV byte ptr [BX + 0x89e0],AL
1000:1fb8      3c 00                    CMP AL,0x0
1000:1fba      74 45                    JZ 0x1000:2001
1000:1fbc      c6 44 0a 00              MOV byte ptr [SI + 0xa],0x0
1000:1fc0      c7 44 08 00 00           MOV word ptr [SI + 0x8],0x0
1000:1fc5      c6 44 0d 00              MOV byte ptr [SI + 0xd],0x0
1000:1fc9      e8 02 ff                 CALL 0x1000:1ece
                ; ptr table -> 1000:1fd4  [ptr] 1000:8c64 1000:8d50 1000:8e3c 1000:8f28
1000:1fd4  LAB_1000_1fd4:
1000:1fd4      b9 04 00                 MOV CX,0x4
1000:1fd7  LAB_1000_1fd7:
1000:1fd7      f6 07 80                 TEST byte ptr [BX],0x80
1000:1fda      74 03                    JZ 0x1000:1fdf
1000:1fdc      c6 07 00                 MOV byte ptr [BX],0x0
1000:1fdf  LAB_1000_1fdf:
1000:1fdf      83 c3 3b                 ADD BX,0x3b
1000:1fe2      e2 f3                    LOOP 0x1000:1fd7
1000:1fe4      e8 e7 fe                 CALL 0x1000:1ece
                ; ptr table -> 1000:1fef  [ptr] 1000:a226 1000:a231 1000:a23c 1000:a247
1000:1fef  LAB_1000_1fef:
1000:1fef      c6 47 05 00              MOV byte ptr [BX + 0x5],0x0
1000:1ff3      8a 1e 74 a2              MOV BL,byte ptr [0xa274]
1000:1ff7      32 ff                    XOR BH,BH
1000:1ff9      d1 e3                    SHL BX,0x1
1000:1ffb      c7 87 e4 89 00 00        MOV word ptr [BX + 0x89e4],0x0
1000:2001  LAB_1000_2001:
1000:2001      c3                       RET

; ------------------------------------------------------------
1000:2002  FUN_1000_2002:
1000:2002      be 8c a0                 MOV SI,0xa08c
1000:2005      b9 30 00                 MOV CX,0x30
1000:2008  LAB_1000_2008:
1000:2008      80 3c 00                 CMP byte ptr [SI],0x0
1000:200b      74 06                    JZ 0x1000:2013
1000:200d      83 c6 07                 ADD SI,0x7
1000:2010      e2 f6                    LOOP 0x1000:2008
1000:2012      c3                       RET
1000:2013  LAB_1000_2013:
1000:2013      c6 04 c8                 MOV byte ptr [SI],0xc8
1000:2016      8b 45 01                 MOV AX,word ptr [DI + 0x1]
1000:2019      89 44 01                 MOV word ptr [SI + 0x1],AX
1000:201c      8b 45 03                 MOV AX,word ptr [DI + 0x3]
1000:201f      89 44 03                 MOV word ptr [SI + 0x3],AX
1000:2022      8a 45 18                 MOV AL,byte ptr [DI + 0x18]
1000:2025      88 44 06                 MOV byte ptr [SI + 0x6],AL
1000:2028      8a 45 05                 MOV AL,byte ptr [DI + 0x5]
1000:202b      88 44 05                 MOV byte ptr [SI + 0x5],AL
1000:202e      c3                       RET

; ------------------------------------------------------------
1000:202f  FUN_1000_202f:
1000:202f      a0 d2 89                 MOV AL,[0x89d2]
1000:2032      24 07                    AND AL,0x7
1000:2034      3c 04                    CMP AL,0x4
1000:2036      74 01                    JZ 0x1000:2039
1000:2038      c3                       RET
1000:2039  LAB_1000_2039:
1000:2039      be 8c a0                 MOV SI,0xa08c
1000:203c      b9 30 00                 MOV CX,0x30
1000:203f  LAB_1000_203f:
1000:203f      80 3c 00                 CMP byte ptr [SI],0x0
1000:2042      74 0b                    JZ 0x1000:204f
1000:2044      fe 0c                    DEC byte ptr [SI]
1000:2046      75 07                    JNZ 0x1000:204f
1000:2048      56                       PUSH SI
1000:2049      51                       PUSH CX
1000:204a      e8 ea 8b                 CALL 0x1000:ac37
1000:204d      59                       POP CX
1000:204e      5e                       POP SI
1000:204f  LAB_1000_204f:
1000:204f      83 c6 07                 ADD SI,0x7
1000:2052      e2 eb                    LOOP 0x1000:203f
1000:2054      c3                       RET

; ------------------------------------------------------------
1000:2055  FUN_1000_2055:
1000:2055      8a 1e 74 a2              MOV BL,byte ptr [0xa274]
1000:2059      b7 00                    MOV BH,0x0
1000:205b      80 bf d8 89 01           CMP byte ptr [BX + 0x89d8],0x1
1000:2060      75 06                    JNZ 0x1000:2068
1000:2062      c7 45 08 00 00           MOV word ptr [DI + 0x8],0x0
1000:2067      c3                       RET
1000:2068  LAB_1000_2068:
1000:2068      f6 45 15 ff              TEST byte ptr [DI + 0x15],0xff
1000:206c      74 03                    JZ 0x1000:2071
1000:206e      fe 4d 15                 DEC byte ptr [DI + 0x15]
1000:2071  LAB_1000_2071:
1000:2071      81 7d 08 d0 07           CMP word ptr [DI + 0x8],0x7d0
1000:2076      77 04                    JA 0x1000:207c
1000:2078      c6 45 14 00              MOV byte ptr [DI + 0x14],0x0
1000:207c  LAB_1000_207c:
1000:207c      f6 06 d2 89 03           TEST byte ptr [0x89d2],0x3
1000:2081      75 5f                    JNZ 0x1000:20e2
1000:2083      ba 00 00                 MOV DX,0x0
1000:2086      8a 45 0b                 MOV AL,byte ptr [DI + 0xb]
1000:2089      24 0f                    AND AL,0xf
1000:208b      74 14                    JZ 0x1000:20a1
1000:208d      b2 05                    MOV DL,0x5
1000:208f      3c 04                    CMP AL,0x4
1000:2091      72 0e                    JC 0x1000:20a1
1000:2093      b2 0a                    MOV DL,0xa
1000:2095      3c 08                    CMP AL,0x8
1000:2097      72 08                    JC 0x1000:20a1
1000:2099      b2 0f                    MOV DL,0xf
1000:209b      3c 0b                    CMP AL,0xb
1000:209d      72 02                    JC 0x1000:20a1
1000:209f      b2 0a                    MOV DL,0xa
1000:20a1  LAB_1000_20a1:
1000:20a1      81 7d 08 e8 03           CMP word ptr [DI + 0x8],0x3e8
1000:20a6      77 02                    JA 0x1000:20aa
1000:20a8      d1 ea                    SHR DX,0x1
1000:20aa  LAB_1000_20aa:
1000:20aa      8b c2                    MOV AX,DX
1000:20ac      f6 05 20                 TEST byte ptr [DI],0x20
1000:20af      74 0e                    JZ 0x1000:20bf
1000:20b1      52                       PUSH DX
1000:20b2      b9 4b 00                 MOV CX,0x4b
1000:20b5      8b 45 08                 MOV AX,word ptr [DI + 0x8]
1000:20b8      33 d2                    XOR DX,DX
1000:20ba      f7 f1                    DIV CX
1000:20bc      5a                       POP DX
1000:20bd      03 c2                    ADD AX,DX
1000:20bf  LAB_1000_20bf:
1000:20bf      e8 d9 02                 CALL 0x1000:239b
1000:20c2      f6 06 d2 89 03           TEST byte ptr [0x89d2],0x3
1000:20c7      75 19                    JNZ 0x1000:20e2
1000:20c9      f6 06 d2 89 04           TEST byte ptr [0x89d2],0x4
1000:20ce      75 09                    JNZ 0x1000:20d9
1000:20d0      8a 45 0b                 MOV AL,byte ptr [DI + 0xb]
1000:20d3      24 0f                    AND AL,0xf
1000:20d5      3c 02                    CMP AL,0x2
1000:20d7      77 09                    JA 0x1000:20e2
1000:20d9  LAB_1000_20d9:
1000:20d9      f6 45 0e ff              TEST byte ptr [DI + 0xe],0xff
1000:20dd      74 03                    JZ 0x1000:20e2
1000:20df      fe 4d 0e                 DEC byte ptr [DI + 0xe]
1000:20e2  LAB_1000_20e2:
1000:20e2      c3                       RET

; ------------------------------------------------------------
1000:20e3  FUN_1000_20e3:
1000:20e3      8a 45 0e                 MOV AL,byte ptr [DI + 0xe]
1000:20e6      3c 08                    CMP AL,0x8
1000:20e8      72 1f                    JC 0x1000:2109
1000:20ea      80 25 cf                 AND byte ptr [DI],0xcf
1000:20ed      3c 0c                    CMP AL,0xc
1000:20ef      72 18                    JC 0x1000:2109
1000:20f1      c6 45 11 00              MOV byte ptr [DI + 0x11],0x0
1000:20f5      3c 10                    CMP AL,0x10
1000:20f7      72 10                    JC 0x1000:2109
1000:20f9      c6 45 15 18              MOV byte ptr [DI + 0x15],0x18
1000:20fd      3c 14                    CMP AL,0x14
1000:20ff      72 08                    JC 0x1000:2109
1000:2101      c6 45 2a 00              MOV byte ptr [DI + 0x2a],0x0
1000:2105      c6 45 22 00              MOV byte ptr [DI + 0x22],0x0
1000:2109  LAB_1000_2109:
1000:2109      c3                       RET

; ------------------------------------------------------------
1000:210a  FUN_1000_210a:
1000:210a      e8 a6 02                 CALL 0x1000:23b3
1000:210d      3c 03                    CMP AL,0x3
1000:210f      8b 45 0c                 MOV AX,word ptr [DI + 0xc]
1000:2112      72 02                    JC 0x1000:2116
1000:2114      d1 e8                    SHR AX,0x1
1000:2116  LAB_1000_2116:
1000:2116      8b 5d 08                 MOV BX,word ptr [DI + 0x8]
1000:2119      f6 05 44                 TEST byte ptr [DI],0x44
1000:211c      74 20                    JZ 0x1000:213e
1000:211e      d1 e8                    SHR AX,0x1
1000:2120      d1 e8                    SHR AX,0x1
1000:2122      3d 40 1f                 CMP AX,0x1f40
1000:2125      72 04                    JC 0x1000:212b
1000:2127      d1 e8                    SHR AX,0x1
1000:2129      d1 e8                    SHR AX,0x1
1000:212b  LAB_1000_212b:
1000:212b      81 fb 10 27              CMP BX,0x2710
1000:212f      72 54                    JC 0x1000:2185
1000:2131      2b d8                    SUB BX,AX
1000:2133      81 fb 10 27              CMP BX,0x2710
1000:2137      77 19                    JA 0x1000:2152
1000:2139      bb 10 27                 MOV BX,0x2710
1000:213c      eb 14                    JMP 0x1000:2152
1000:213e  LAB_1000_213e:
1000:213e      f6 06 d2 89 03           TEST byte ptr [0x89d2],0x3
1000:2143      75 09                    JNZ 0x1000:214e
1000:2145      81 fb b8 88              CMP BX,0x88b8
1000:2149      77 03                    JA 0x1000:214e
1000:214b      83 c3 0a                 ADD BX,0xa
1000:214e  LAB_1000_214e:
1000:214e      2b d8                    SUB BX,AX
1000:2150      76 0e                    JBE 0x1000:2160
1000:2152  LAB_1000_2152:
1000:2152      89 5d 08                 MOV word ptr [DI + 0x8],BX
1000:2155      81 fb c8 00              CMP BX,0xc8
1000:2159      77 2a                    JA 0x1000:2185
1000:215b      80 25 ef                 AND byte ptr [DI],0xef
1000:215e      eb 25                    JMP 0x1000:2185
1000:2160  LAB_1000_2160:
1000:2160      e8 6b fd                 CALL 0x1000:1ece
                ; ptr table -> 1000:216b  [ptr] 1000:904c 1000:90ec 1000:918c 1000:922c
1000:216b  LAB_1000_216b:
1000:216b      8b f3                    MOV SI,BX
1000:216d      f6 45 06 ff              TEST byte ptr [DI + 0x6],0xff
1000:2171      74 05                    JZ 0x1000:2178
1000:2173      e8 ee fb                 CALL 0x1000:1d64
1000:2176      eb e8                    JMP 0x1000:2160
1000:2178  LAB_1000_2178:
1000:2178      81 7d 0c 50 c3           CMP word ptr [DI + 0xc],0xc350
1000:217d      b0 08                    MOV AL,0x8
1000:217f      72 02                    JC 0x1000:2183
1000:2181      b0 0c                    MOV AL,0xc
1000:2183  LAB_1000_2183:
1000:2183      88 05                    MOV byte ptr [DI],AL
1000:2185  LAB_1000_2185:
1000:2185      c7 45 0c 00 00           MOV word ptr [DI + 0xc],0x0
1000:218a      c3                       RET

; ------------------------------------------------------------
1000:218b  FUN_1000_218b:
1000:218b      e8 90 00                 CALL 0x1000:221e
1000:218e      80 7d 14 00              CMP byte ptr [DI + 0x14],0x0
1000:2192      75 0a                    JNZ 0x1000:219e
1000:2194      80 7d 0b b0              CMP byte ptr [DI + 0xb],0xb0
1000:2198      72 04                    JC 0x1000:219e
1000:219a      80 6d 0b 10              SUB byte ptr [DI + 0xb],0x10
1000:219e  LAB_1000_219e:
1000:219e      8a 45 0b                 MOV AL,byte ptr [DI + 0xb]
1000:21a1      8a f8                    MOV BH,AL
1000:21a3      80 e7 f0                 AND BH,0xf0
1000:21a6      e8 06 00                 CALL 0x1000:21af
1000:21a9      0a df                    OR BL,BH
1000:21ab      88 5d 0b                 MOV byte ptr [DI + 0xb],BL
1000:21ae      c3                       RET

; ------------------------------------------------------------
1000:21af  FUN_1000_21af:
1000:21af      8a e0                    MOV AH,AL
1000:21b1      80 e4 0f                 AND AH,0xf
1000:21b4      8a dc                    MOV BL,AH
1000:21b6      d0 e8                    SHR AL,0x1
1000:21b8      d0 e8                    SHR AL,0x1
1000:21ba      d0 e8                    SHR AL,0x1
1000:21bc      d0 e8                    SHR AL,0x1
1000:21be      24 0f                    AND AL,0xf
1000:21c0      3a c4                    CMP AL,AH
1000:21c2      75 05                    JNZ 0x1000:21c9
1000:21c4      c6 45 10 00              MOV byte ptr [DI + 0x10],0x0
1000:21c8      c3                       RET
1000:21c9  LAB_1000_21c9:
1000:21c9      f6 45 10 ff              TEST byte ptr [DI + 0x10],0xff
1000:21cd      74 3b                    JZ 0x1000:220a
1000:21cf      fe 4d 10                 DEC byte ptr [DI + 0x10]
1000:21d2      74 17                    JZ 0x1000:21eb
1000:21d4      2a c4                    SUB AL,AH
1000:21d6      79 02                    JNS 0x1000:21da
1000:21d8      f6 d8                    NEG AL
1000:21da  LAB_1000_21da:
1000:21da      b4 0c                    MOV AH,0xc
1000:21dc      2a e0                    SUB AH,AL
1000:21de      3a 65 10                 CMP AH,byte ptr [DI + 0x10]
1000:21e1      77 07                    JA 0x1000:21ea
1000:21e3      d0 ec                    SHR AH,0x1
1000:21e5      fe c4                    INC AH
1000:21e7      88 65 10                 MOV byte ptr [DI + 0x10],AH
1000:21ea  LAB_1000_21ea:
1000:21ea      c3                       RET
1000:21eb  LAB_1000_21eb:
1000:21eb      2a c4                    SUB AL,AH
1000:21ed      78 04                    JS 0x1000:21f3
1000:21ef      fe c3                    INC BL
1000:21f1      eb 04                    JMP 0x1000:21f7
1000:21f3  LAB_1000_21f3:
1000:21f3      fe cb                    DEC BL
1000:21f5      f6 d8                    NEG AL
1000:21f7  LAB_1000_21f7:
1000:21f7      b4 0c                    MOV AH,0xc
1000:21f9      2a e0                    SUB AH,AL
1000:21fb      d0 ec                    SHR AH,0x1
1000:21fd      fe c4                    INC AH
1000:21ff      88 65 10                 MOV byte ptr [DI + 0x10],AH
1000:2202      02 c0                    ADD AL,AL
1000:2204      b4 00                    MOV AH,0x0
1000:2206      e8 92 01                 CALL 0x1000:239b
1000:2209      c3                       RET
1000:220a  LAB_1000_220a:
1000:220a      2a c4                    SUB AL,AH
1000:220c      79 02                    JNS 0x1000:2210
1000:220e      f6 d8                    NEG AL
1000:2210  LAB_1000_2210:
1000:2210      b4 0c                    MOV AH,0xc
1000:2212      2a e0                    SUB AH,AL
1000:2214      d0 ec                    SHR AH,0x1
1000:2216      d0 ec                    SHR AH,0x1
1000:2218      fe c4                    INC AH
1000:221a      88 65 10                 MOV byte ptr [DI + 0x10],AH
1000:221d      c3                       RET

; ------------------------------------------------------------
1000:221e  FUN_1000_221e:
1000:221e      8a 45 0a                 MOV AL,byte ptr [DI + 0xa]
1000:2221      d0 e8                    SHR AL,0x1
1000:2223      d0 e8                    SHR AL,0x1
1000:2225      d0 e8                    SHR AL,0x1
1000:2227      d0 e8                    SHR AL,0x1
1000:2229      8a e8                    MOV CH,AL
1000:222b      8a 4d 0a                 MOV CL,byte ptr [DI + 0xa]
1000:222e      80 65 0a f0              AND byte ptr [DI + 0xa],0xf0
1000:2232      80 e1 0f                 AND CL,0xf
1000:2235      f6 45 11 1f              TEST byte ptr [DI + 0x11],0x1f
1000:2239      74 09                    JZ 0x1000:2244
1000:223b      81 7d 12 fa 00           CMP word ptr [DI + 0x12],0xfa
1000:2240      77 02                    JA 0x1000:2244
1000:2242      8a cd                    MOV CL,CH
1000:2244  LAB_1000_2244:
1000:2244      2a e9                    SUB CH,CL
1000:2246      74 1d                    JZ 0x1000:2265
1000:2248      79 03                    JNS 0x1000:224d
1000:224a      80 c5 10                 ADD CH,0x10
1000:224d  LAB_1000_224d:
1000:224d      fe c1                    INC CL
1000:224f      80 fd 04                 CMP CH,0x4
1000:2252      76 11                    JBE 0x1000:2265
1000:2254      fe c1                    INC CL
1000:2256      80 fd 08                 CMP CH,0x8
1000:2259      76 0a                    JBE 0x1000:2265
1000:225b      80 e9 04                 SUB CL,0x4
1000:225e      80 fd 0b                 CMP CH,0xb
1000:2261      76 02                    JBE 0x1000:2265
1000:2263      fe c1                    INC CL
1000:2265  LAB_1000_2265:
1000:2265      80 e1 0f                 AND CL,0xf
1000:2268      08 4d 0a                 OR byte ptr [DI + 0xa],CL
1000:226b      c3                       RET

; ------------------------------------------------------------
1000:226c  FUN_1000_226c:
1000:226c      a0 d2 89                 MOV AL,[0x89d2]
1000:226f      24 01                    AND AL,0x1
1000:2271      75 2e                    JNZ 0x1000:22a1
1000:2273      f6 45 19 ff              TEST byte ptr [DI + 0x19],0xff
1000:2277      75 28                    JNZ 0x1000:22a1
1000:2279      f6 05 10                 TEST byte ptr [DI],0x10
1000:227c      74 23                    JZ 0x1000:22a1
1000:227e      f6 05 44                 TEST byte ptr [DI],0x44
1000:2281      75 1e                    JNZ 0x1000:22a1
1000:2283      8a 45 0f                 MOV AL,byte ptr [DI + 0xf]
1000:2286      22 c0                    AND AL,AL
1000:2288      74 13                    JZ 0x1000:229d
1000:228a      e8 26 01                 CALL 0x1000:23b3
1000:228d      3c 04                    CMP AL,0x4
1000:228f      72 07                    JC 0x1000:2298
1000:2291      f6 06 d2 89 03           TEST byte ptr [0x89d2],0x3
1000:2296      74 09                    JZ 0x1000:22a1
1000:2298  LAB_1000_2298:
1000:2298      fe 4d 0f                 DEC byte ptr [DI + 0xf]
1000:229b      75 04                    JNZ 0x1000:22a1
1000:229d  LAB_1000_229d:
1000:229d      80 25 ef                 AND byte ptr [DI],0xef
1000:22a0      c3                       RET
1000:22a1  LAB_1000_22a1:
1000:22a1      c3                       RET

; ------------------------------------------------------------
1000:22a2  FUN_1000_22a2:
1000:22a2      b0 00                    MOV AL,0x0
1000:22a4  LAB_1000_22a4:
1000:22a4      50                       PUSH AX
1000:22a5      e8 80 0f                 CALL 0x1000:3228
1000:22a8      c6 06 80 a2 00           MOV byte ptr [0xa280],0x0
1000:22ad  LAB_1000_22ad:
1000:22ad      8a 05                    MOV AL,byte ptr [DI]
1000:22af      24 0f                    AND AL,0xf
1000:22b1      74 23                    JZ 0x1000:22d6
1000:22b3      3c 0a                    CMP AL,0xa
1000:22b5      77 07                    JA 0x1000:22be
1000:22b7      80 3e 80 a2 01           CMP byte ptr [0xa280],0x1
1000:22bc      74 34                    JZ 0x1000:22f2
1000:22be  LAB_1000_22be:
1000:22be      a0 d2 89                 MOV AL,[0x89d2]
1000:22c1      02 c1                    ADD AL,CL
1000:22c3      24 07                    AND AL,0x7
1000:22c5      75 3a                    JNZ 0x1000:2301
1000:22c7      e8 e7 20                 CALL 0x1000:43b1
1000:22ca      f6 45 06 ff              TEST byte ptr [DI + 0x6],0xff
1000:22ce      74 31                    JZ 0x1000:2301
1000:22d0      fe 4d 06                 DEC byte ptr [DI + 0x6]
1000:22d3      eb 2c                    JMP 0x1000:2301
1000:22d6  LAB_1000_22d6:
1000:22d6      c6 06 80 a2 00           MOV byte ptr [0xa280],0x0
1000:22db      a0 d2 89                 MOV AL,[0x89d2]
1000:22de      24 7f                    AND AL,0x7f
1000:22e0      75 1f                    JNZ 0x1000:2301
1000:22e2      f6 45 06 ff              TEST byte ptr [DI + 0x6],0xff
1000:22e6      74 19                    JZ 0x1000:2301
1000:22e8      fe 4d 06                 DEC byte ptr [DI + 0x6]
1000:22eb      75 14                    JNZ 0x1000:2301
1000:22ed      c6 06 80 a2 01           MOV byte ptr [0xa280],0x1
1000:22f2  LAB_1000_22f2:
1000:22f2      e8 85 20                 CALL 0x1000:437a
1000:22f5      24 0f                    AND AL,0xf
1000:22f7      75 05                    JNZ 0x1000:22fe
1000:22f9      e8 14 00                 CALL 0x1000:2310
1000:22fc      eb 03                    JMP 0x1000:2301
1000:22fe  LAB_1000_22fe:
1000:22fe      80 0d 0f                 OR byte ptr [DI],0xf
1000:2301  LAB_1000_2301:
1000:2301      83 c7 0b                 ADD DI,0xb
1000:2304      e2 a7                    LOOP 0x1000:22ad
1000:2306      58                       POP AX
1000:2307      fe c0                    INC AL
1000:2309      3a 06 02 00              CMP AL,byte ptr [0x2]
1000:230d      72 95                    JC 0x1000:22a4
1000:230f      c3                       RET

; ------------------------------------------------------------
1000:2310  FUN_1000_2310:
1000:2310      57                       PUSH DI
1000:2311      87 fe                    XCHG SI,DI
1000:2313  LAB_1000_2313:
1000:2313      e8 85 1f                 CALL 0x1000:429b
1000:2316      89 44 01                 MOV word ptr [SI + 0x1],AX
1000:2319      e8 7f 1f                 CALL 0x1000:429b
1000:231c      89 44 03                 MOV word ptr [SI + 0x3],AX
1000:231f      bd e8 03                 MOV BP,0x3e8
1000:2322      ba 58 1b                 MOV DX,0x1b58
1000:2325      e8 ef 1e                 CALL 0x1000:4217
1000:2328      72 e9                    JC 0x1000:2313
1000:232a      b0 0e                    MOV AL,0xe
1000:232c      e8 c1 1e                 CALL 0x1000:41f0
1000:232f      88 04                    MOV byte ptr [SI],AL
1000:2331      c6 44 07 00              MOV byte ptr [SI + 0x7],0x0
1000:2335      c6 44 08 00              MOV byte ptr [SI + 0x8],0x0
1000:2339      c6 44 06 00              MOV byte ptr [SI + 0x6],0x0
1000:233d      c6 44 0a ff              MOV byte ptr [SI + 0xa],0xff
1000:2341      5f                       POP DI
1000:2342      c3                       RET

; ------------------------------------------------------------
1000:2343  FUN_1000_2343:
1000:2343      be 14 90                 MOV SI,0x9014
1000:2346      bf 4c 90                 MOV DI,0x904c
1000:2349      b9 04 00                 MOV CX,0x4
1000:234c  LAB_1000_234c:
1000:234c      51                       PUSH CX
1000:234d      b9 14 00                 MOV CX,0x14
1000:2350  LAB_1000_2350:
1000:2350      8a 05                    MOV AL,byte ptr [DI]
1000:2352      22 c0                    AND AL,AL
1000:2354      74 19                    JZ 0x1000:236f
1000:2356      fe c8                    DEC AL
1000:2358      74 0f                    JZ 0x1000:2369
1000:235a      fe c8                    DEC AL
1000:235c      74 07                    JZ 0x1000:2365
1000:235e      f6 06 d2 89 07           TEST byte ptr [0x89d2],0x7
1000:2363      75 0a                    JNZ 0x1000:236f
1000:2365  LAB_1000_2365:
1000:2365      fe 0d                    DEC byte ptr [DI]
1000:2367      eb 06                    JMP 0x1000:236f
1000:2369  LAB_1000_2369:
1000:2369      c6 05 00                 MOV byte ptr [DI],0x0
1000:236c      fe 44 06                 INC byte ptr [SI + 0x6]
1000:236f  LAB_1000_236f:
1000:236f      83 c7 08                 ADD DI,0x8
1000:2372      e2 dc                    LOOP 0x1000:2350
1000:2374      59                       POP CX
1000:2375      83 c6 0e                 ADD SI,0xe
1000:2378      e2 d2                    LOOP 0x1000:234c
1000:237a      c3                       RET

; ------------------------------------------------------------
1000:237b  FUN_1000_237b:
1000:237b      80 7d 34 00              CMP byte ptr [DI + 0x34],0x0
1000:237f      74 04                    JZ 0x1000:2385
1000:2381      d1 e8                    SHR AX,0x1
1000:2383      d1 e8                    SHR AX,0x1
1000:2385  LAB_1000_2385:
1000:2385      f6 05 20                 TEST byte ptr [DI],0x20
1000:2388      74 11                    JZ 0x1000:239b
1000:238a      f6 45 19 80              TEST byte ptr [DI + 0x19],0x80
1000:238e      75 0b                    JNZ 0x1000:239b
1000:2390      52                       PUSH DX
1000:2391      33 d2                    XOR DX,DX
1000:2393      51                       PUSH CX
1000:2394      b9 03 00                 MOV CX,0x3
1000:2397      f7 f1                    DIV CX
1000:2399      59                       POP CX
1000:239a      5a                       POP DX

; ------------------------------------------------------------
1000:239b  FUN_1000_239b:
1000:239b      01 45 0c                 ADD word ptr [DI + 0xc],AX
1000:239e      73 05                    JNC 0x1000:23a5
1000:23a0      c7 45 0c ff ff           MOV word ptr [DI + 0xc],0xffff
1000:23a5  LAB_1000_23a5:
1000:23a5      50                       PUSH AX
1000:23a6      d1 e8                    SHR AX,0x1
1000:23a8      d1 e8                    SHR AX,0x1
1000:23aa      22 e4                    AND AH,AH
1000:23ac      74 03                    JZ 0x1000:23b1
1000:23ae      00 65 0e                 ADD byte ptr [DI + 0xe],AH
1000:23b1  LAB_1000_23b1:
1000:23b1      58                       POP AX
1000:23b2      c3                       RET

; ------------------------------------------------------------
1000:23b3  FUN_1000_23b3:
1000:23b3      53                       PUSH BX
1000:23b4      e8 17 fb                 CALL 0x1000:1ece
                ; ptr table -> 1000:23bf  [ptr] 1000:a226 1000:a231 1000:a23c 1000:a247
1000:23bf  LAB_1000_23bf:
1000:23bf      8a 47 04                 MOV AL,byte ptr [BX + 0x4]
1000:23c2      5b                       POP BX
1000:23c3      c3                       RET

; ------------------------------------------------------------
1000:23c4  FUN_1000_23c4:
1000:23c4      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
1000:23c7      3a 45 05                 CMP AL,byte ptr [DI + 0x5]
1000:23ca      75 49                    JNZ 0x1000:2415

; ------------------------------------------------------------
1000:23cc  FUN_1000_23cc:
1000:23cc      8b 44 01                 MOV AX,word ptr [SI + 0x1]
1000:23cf      2b 45 01                 SUB AX,word ptr [DI + 0x1]
1000:23d2      79 02                    JNS 0x1000:23d6
1000:23d4      f7 d8                    NEG AX
1000:23d6  LAB_1000_23d6:
1000:23d6      80 fc 20                 CMP AH,0x20
1000:23d9      72 05                    JC 0x1000:23e0
1000:23db      2d 00 40                 SUB AX,0x4000
1000:23de      f7 d8                    NEG AX
1000:23e0  LAB_1000_23e0:
1000:23e0      d3 e8                    SHR AX,CL
1000:23e2      22 e4                    AND AH,AH
1000:23e4      75 2a                    JNZ 0x1000:2410
1000:23e6      f6 e0                    MUL AL
1000:23e8      92                       XCHG AX,DX
1000:23e9      8b 44 03                 MOV AX,word ptr [SI + 0x3]
1000:23ec      2b 45 03                 SUB AX,word ptr [DI + 0x3]
1000:23ef      79 02                    JNS 0x1000:23f3
1000:23f1      f7 d8                    NEG AX
1000:23f3  LAB_1000_23f3:
1000:23f3      80 fc 20                 CMP AH,0x20
1000:23f6      72 05                    JC 0x1000:23fd
1000:23f8      2d 00 40                 SUB AX,0x4000
1000:23fb      f7 d8                    NEG AX
1000:23fd  LAB_1000_23fd:
1000:23fd      d3 e8                    SHR AX,CL
1000:23ff      22 e4                    AND AH,AH
1000:2401      75 0d                    JNZ 0x1000:2410
1000:2403      f6 e0                    MUL AL
1000:2405      03 c2                    ADD AX,DX
1000:2407      72 07                    JC 0x1000:2410
1000:2409      e8 64 00                 CALL 0x1000:2470
1000:240c      d3 e0                    SHL AX,CL
1000:240e      f8                       CLC
1000:240f      c3                       RET
1000:2410  LAB_1000_2410:
1000:2410      b8 ff ff                 MOV AX,0xffff
1000:2413      f9                       STC
1000:2414      c3                       RET
1000:2415  LAB_1000_2415:
1000:2415      b8 fe ff                 MOV AX,0xfffe
1000:2418      f9                       STC
1000:2419      c3                       RET

; ------------------------------------------------------------
1000:241a  FUN_1000_241a:
1000:241a      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
1000:241d      3a 45 05                 CMP AL,byte ptr [DI + 0x5]
1000:2420      75 49                    JNZ 0x1000:246b
1000:2422      8b 44 01                 MOV AX,word ptr [SI + 0x1]
1000:2425      2b 45 01                 SUB AX,word ptr [DI + 0x1]
1000:2428      79 02                    JNS 0x1000:242c
1000:242a      f7 d8                    NEG AX
1000:242c  LAB_1000_242c:
1000:242c      80 fc 20                 CMP AH,0x20
1000:242f      72 05                    JC 0x1000:2436
1000:2431      2d 00 40                 SUB AX,0x4000
1000:2434      f7 d8                    NEG AX
1000:2436  LAB_1000_2436:
1000:2436      d3 e8                    SHR AX,CL
1000:2438      22 e4                    AND AH,AH
1000:243a      75 2a                    JNZ 0x1000:2466
1000:243c      f6 e0                    MUL AL
1000:243e      92                       XCHG AX,DX
1000:243f      8b 44 03                 MOV AX,word ptr [SI + 0x3]
1000:2442      2b 45 03                 SUB AX,word ptr [DI + 0x3]
1000:2445      79 02                    JNS 0x1000:2449
1000:2447      f7 d8                    NEG AX
1000:2449  LAB_1000_2449:
1000:2449      80 fc 20                 CMP AH,0x20
1000:244c      72 05                    JC 0x1000:2453
1000:244e      2d 00 40                 SUB AX,0x4000
1000:2451      f7 d8                    NEG AX
1000:2453  LAB_1000_2453:
1000:2453      d3 e8                    SHR AX,CL
1000:2455      22 e4                    AND AH,AH
1000:2457      75 0d                    JNZ 0x1000:2466
1000:2459      f6 e0                    MUL AL
1000:245b      03 c2                    ADD AX,DX
1000:245d      72 07                    JC 0x1000:2466
1000:245f      e8 0e 00                 CALL 0x1000:2470
1000:2462      d3 e0                    SHL AX,CL
1000:2464      f8                       CLC
1000:2465      c3                       RET
1000:2466  LAB_1000_2466:
1000:2466      b8 ff ff                 MOV AX,0xffff
1000:2469      f9                       STC
1000:246a      c3                       RET
1000:246b  LAB_1000_246b:
1000:246b      b8 fe ff                 MOV AX,0xfffe
1000:246e      f9                       STC
1000:246f      c3                       RET

; ------------------------------------------------------------
1000:2470  FUN_1000_2470:
1000:2470      3d 00 80                 CMP AX,0x8000
1000:2473      73 29                    JNC 0x1000:249e
1000:2475      3d 00 40                 CMP AX,0x4000
1000:2478      73 2f                    JNC 0x1000:24a9
1000:247a      3d 00 20                 CMP AX,0x2000
1000:247d      73 37                    JNC 0x1000:24b6
1000:247f      3d 00 10                 CMP AX,0x1000
1000:2482      73 41                    JNC 0x1000:24c5
1000:2484      3d 00 08                 CMP AX,0x800
1000:2487      73 4d                    JNC 0x1000:24d6
1000:2489      3d 00 04                 CMP AX,0x400
1000:248c      73 59                    JNC 0x1000:24e7
1000:248e      3d 00 02                 CMP AX,0x200
1000:2491      73 63                    JNC 0x1000:24f6
1000:2493      3d 00 01                 CMP AX,0x100
1000:2496      73 6b                    JNC 0x1000:2503
1000:2498      bb 0d 25                 MOV BX,0x250d
1000:249b      2e d7                    XLAT CS:BX
1000:249d      c3                       RET
1000:249e  LAB_1000_249e:
1000:249e      25 00 7f                 AND AX,0x7f00
1000:24a1      86 c4                    XCHG AH,AL
1000:24a3      bb 8c 29                 MOV BX,0x298c
1000:24a6      2e d7                    XLAT CS:BX
1000:24a8      c3                       RET
1000:24a9  LAB_1000_24a9:
1000:24a9      25 80 3f                 AND AX,0x3f80
1000:24ac      d1 e0                    SHL AX,0x1
1000:24ae      86 c4                    XCHG AH,AL
1000:24b0      bb 0d 29                 MOV BX,0x290d
1000:24b3      2e d7                    XLAT CS:BX
1000:24b5      c3                       RET
1000:24b6  LAB_1000_24b6:
1000:24b6      25 c0 1f                 AND AX,0x1fc0
1000:24b9      d1 e0                    SHL AX,0x1
1000:24bb      d1 e0                    SHL AX,0x1
1000:24bd      86 c4                    XCHG AH,AL
1000:24bf      bb 8d 28                 MOV BX,0x288d
1000:24c2      2e d7                    XLAT CS:BX
1000:24c4      c3                       RET
1000:24c5  LAB_1000_24c5:
1000:24c5      25 e0 0f                 AND AX,0xfe0
1000:24c8      d1 e0                    SHL AX,0x1
1000:24ca      d1 e0                    SHL AX,0x1
1000:24cc      d1 e0                    SHL AX,0x1
1000:24ce      86 c4                    XCHG AH,AL
1000:24d0      bb 0d 28                 MOV BX,0x280d
1000:24d3      2e d7                    XLAT CS:BX
1000:24d5      c3                       RET
1000:24d6  LAB_1000_24d6:
1000:24d6      80 e4 07                 AND AH,0x7
1000:24d9      d1 e8                    SHR AX,0x1
1000:24db      d1 e8                    SHR AX,0x1
1000:24dd      d1 e8                    SHR AX,0x1
1000:24df      d1 e8                    SHR AX,0x1
1000:24e1      bb 8d 27                 MOV BX,0x278d
1000:24e4      2e d7                    XLAT CS:BX
1000:24e6      c3                       RET
1000:24e7  LAB_1000_24e7:
1000:24e7      80 e4 03                 AND AH,0x3
1000:24ea      d1 e8                    SHR AX,0x1
1000:24ec      d1 e8                    SHR AX,0x1
1000:24ee      d1 e8                    SHR AX,0x1
1000:24f0      bb 0d 27                 MOV BX,0x270d
1000:24f3      2e d7                    XLAT CS:BX
1000:24f5      c3                       RET
1000:24f6  LAB_1000_24f6:
1000:24f6      80 e4 01                 AND AH,0x1
1000:24f9      d1 e8                    SHR AX,0x1
1000:24fb      d1 e8                    SHR AX,0x1
1000:24fd      bb 8d 26                 MOV BX,0x268d
1000:2500      2e d7                    XLAT CS:BX
1000:2502      c3                       RET
1000:2503  LAB_1000_2503:
1000:2503      32 e4                    XOR AH,AH
1000:2505      d1 e8                    SHR AX,0x1
1000:2507      bb 0d 26                 MOV BX,0x260d
1000:250a      2e d7                    XLAT CS:BX
1000:250c      c3                       RET

; ------------------------------------------------------------
1000:2a0c  FUN_1000_2a0c:
1000:2a0c      24 03                    AND AL,0x3
1000:2a0e      8a 26 74 a2              MOV AH,byte ptr [0xa274]
1000:2a12      d0 e4                    SHL AH,0x1
1000:2a14      d0 e4                    SHL AH,0x1
1000:2a16      0a c4                    OR AL,AH
1000:2a18      b4 3b                    MOV AH,0x3b
1000:2a1a      f6 e4                    MUL AH
1000:2a1c      be 64 8c                 MOV SI,0x8c64
1000:2a1f      03 f0                    ADD SI,AX
1000:2a21      8a 04                    MOV AL,byte ptr [SI]
1000:2a23      24 80                    AND AL,0x80
1000:2a25      c3                       RET

; ------------------------------------------------------------
1000:2a26  FUN_1000_2a26:
1000:2a26      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
1000:2a29      3a 45 05                 CMP AL,byte ptr [DI + 0x5]
1000:2a2c      74 04                    JZ 0x1000:2a32
1000:2a2e      b8 ff ff                 MOV AX,0xffff
1000:2a31      c3                       RET
1000:2a32  LAB_1000_2a32:
1000:2a32      8b 5c 01                 MOV BX,word ptr [SI + 0x1]
1000:2a35      2b 5d 01                 SUB BX,word ptr [DI + 0x1]
1000:2a38      e8 fb 00                 CALL 0x1000:2b36
1000:2a3b      89 1e 83 a2              MOV word ptr [0xa283],BX
1000:2a3f      8b 5c 03                 MOV BX,word ptr [SI + 0x3]
1000:2a42      2b 5d 03                 SUB BX,word ptr [DI + 0x3]
1000:2a45      e8 ee 00                 CALL 0x1000:2b36
1000:2a48      89 1e 85 a2              MOV word ptr [0xa285],BX
1000:2a4c      e8 03 01                 CALL 0x1000:2b52
1000:2a4f      89 1e 89 a2              MOV word ptr [0xa289],BX
1000:2a53      b8 0a 00                 MOV AX,0xa
1000:2a56      f7 e3                    MUL BX
1000:2a58      8b 1e 83 a2              MOV BX,word ptr [0xa283]
1000:2a5c      e8 f3 00                 CALL 0x1000:2b52
1000:2a5f      89 1e 87 a2              MOV word ptr [0xa287],BX
1000:2a63      85 db                    TEST BX,BX
1000:2a65      75 0f                    JNZ 0x1000:2a76
1000:2a67  LAB_1000_2a67:
1000:2a67      b5 00                    MOV CH,0x0
1000:2a69      f7 06 85 a2 00 80        TEST word ptr [0xa285],0x8000
1000:2a6f      75 02                    JNZ 0x1000:2a73
1000:2a71      b5 08                    MOV CH,0x8
1000:2a73  LAB_1000_2a73:
1000:2a73      e9 9b 00                 JMP 0x1000:2b11
1000:2a76  LAB_1000_2a76:
1000:2a76      83 fa 00                 CMP DX,0x0
1000:2a79      74 05                    JZ 0x1000:2a80
1000:2a7b      83 fb 0a                 CMP BX,0xa
1000:2a7e      72 e7                    JC 0x1000:2a67
1000:2a80  LAB_1000_2a80:
1000:2a80      f7 f3                    DIV BX
1000:2a82      3d 02 00                 CMP AX,0x2
1000:2a85      77 0e                    JA 0x1000:2a95
1000:2a87      f7 06 83 a2 00 80        TEST word ptr [0xa283],0x8000
1000:2a8d      b5 04                    MOV CH,0x4
1000:2a8f      75 02                    JNZ 0x1000:2a93
1000:2a91      b5 0c                    MOV CH,0xc
1000:2a93  LAB_1000_2a93:
1000:2a93      eb 7c                    JMP 0x1000:2b11
1000:2a95  LAB_1000_2a95:
1000:2a95      3d 07 00                 CMP AX,0x7
1000:2a98      77 24                    JA 0x1000:2abe
1000:2a9a      f7 06 83 a2 00 80        TEST word ptr [0xa283],0x8000
1000:2aa0      75 0e                    JNZ 0x1000:2ab0
1000:2aa2      f7 06 85 a2 00 80        TEST word ptr [0xa285],0x8000
1000:2aa8      b5 0d                    MOV CH,0xd
1000:2aaa      75 10                    JNZ 0x1000:2abc
1000:2aac      b5 0b                    MOV CH,0xb
1000:2aae      eb 0c                    JMP 0x1000:2abc
1000:2ab0  LAB_1000_2ab0:
1000:2ab0      f7 06 85 a2 00 80        TEST word ptr [0xa285],0x8000
1000:2ab6      b5 03                    MOV CH,0x3
1000:2ab8      75 02                    JNZ 0x1000:2abc
1000:2aba      b5 05                    MOV CH,0x5
1000:2abc  LAB_1000_2abc:
1000:2abc      eb 53                    JMP 0x1000:2b11
1000:2abe  LAB_1000_2abe:
1000:2abe      3d 0f 00                 CMP AX,0xf
1000:2ac1      77 24                    JA 0x1000:2ae7
1000:2ac3      f7 06 83 a2 00 80        TEST word ptr [0xa283],0x8000
1000:2ac9      75 0e                    JNZ 0x1000:2ad9
1000:2acb      f7 06 85 a2 00 80        TEST word ptr [0xa285],0x8000
1000:2ad1      b5 0e                    MOV CH,0xe
1000:2ad3      75 10                    JNZ 0x1000:2ae5
1000:2ad5      b5 0a                    MOV CH,0xa
1000:2ad7      eb 0c                    JMP 0x1000:2ae5
1000:2ad9  LAB_1000_2ad9:
1000:2ad9      f7 06 85 a2 00 80        TEST word ptr [0xa285],0x8000
1000:2adf      b5 02                    MOV CH,0x2
1000:2ae1      75 02                    JNZ 0x1000:2ae5
1000:2ae3      b5 06                    MOV CH,0x6
1000:2ae5  LAB_1000_2ae5:
1000:2ae5      eb 2a                    JMP 0x1000:2b11
1000:2ae7  LAB_1000_2ae7:
1000:2ae7      3d 32 00                 CMP AX,0x32
1000:2aea      72 03                    JC 0x1000:2aef
1000:2aec      e9 78 ff                 JMP 0x1000:2a67
1000:2aef  LAB_1000_2aef:
1000:2aef      f7 06 83 a2 00 80        TEST word ptr [0xa283],0x8000
1000:2af5      75 0e                    JNZ 0x1000:2b05
1000:2af7      f7 06 85 a2 00 80        TEST word ptr [0xa285],0x8000
1000:2afd      b5 0f                    MOV CH,0xf
1000:2aff      75 10                    JNZ 0x1000:2b11
1000:2b01      b5 09                    MOV CH,0x9
1000:2b03      eb 0c                    JMP 0x1000:2b11
1000:2b05  LAB_1000_2b05:
1000:2b05      f7 06 85 a2 00 80        TEST word ptr [0xa285],0x8000
1000:2b0b      b5 01                    MOV CH,0x1
1000:2b0d      75 02                    JNZ 0x1000:2b11
1000:2b0f      b5 07                    MOV CH,0x7
1000:2b11  LAB_1000_2b11:
1000:2b11      b1 00                    MOV CL,0x0
1000:2b13      a1 87 a2                 MOV AX,[0xa287]
1000:2b16      3b 06 89 a2              CMP AX,word ptr [0xa289]
1000:2b1a      77 03                    JA 0x1000:2b1f
1000:2b1c      a1 89 a2                 MOV AX,[0xa289]
1000:2b1f  LAB_1000_2b1f:
1000:2b1f      84 e4                    TEST AH,AH
1000:2b21      74 06                    JZ 0x1000:2b29
1000:2b23      fe c1                    INC CL
1000:2b25      d1 e8                    SHR AX,0x1
1000:2b27      eb f6                    JMP 0x1000:2b1f
1000:2b29  LAB_1000_2b29:
1000:2b29      e8 ee f8                 CALL 0x1000:241a
1000:2b2c      3d ff ff                 CMP AX,0xffff
1000:2b2f      75 04                    JNZ 0x1000:2b35
1000:2b31      fe c1                    INC CL
1000:2b33      eb f4                    JMP 0x1000:2b29
1000:2b35  LAB_1000_2b35:
1000:2b35      c3                       RET

; ------------------------------------------------------------
1000:2b36  FUN_1000_2b36:
1000:2b36      78 0b                    JS 0x1000:2b43
1000:2b38      81 fb 00 20              CMP BX,0x2000
1000:2b3c      72 13                    JC 0x1000:2b51
1000:2b3e      81 eb 00 40              SUB BX,0x4000
1000:2b42      c3                       RET
1000:2b43  LAB_1000_2b43:
1000:2b43      f7 db                    NEG BX
1000:2b45      81 fb 00 20              CMP BX,0x2000
1000:2b49      72 04                    JC 0x1000:2b4f
1000:2b4b      81 eb 00 40              SUB BX,0x4000
1000:2b4f  LAB_1000_2b4f:
1000:2b4f      f7 db                    NEG BX
1000:2b51  LAB_1000_2b51:
1000:2b51      c3                       RET

; ------------------------------------------------------------
1000:2b52  FUN_1000_2b52:
1000:2b52      f7 c3 00 80              TEST BX,0x8000
1000:2b56      74 02                    JZ 0x1000:2b5a
1000:2b58      f7 db                    NEG BX
1000:2b5a  LAB_1000_2b5a:
1000:2b5a      c3                       RET

; ------------------------------------------------------------
1000:2b5b  FUN_1000_2b5b:
1000:2b5b      e8 c0 00                 CALL 0x1000:2c1e
1000:2b5e      e8 92 03                 CALL 0x1000:2ef3
1000:2b61      e8 9e 02                 CALL 0x1000:2e02
1000:2b64      e8 fe 03                 CALL 0x1000:2f65
1000:2b67      e8 86 06                 CALL 0x1000:31f0
1000:2b6a      e8 7f 05                 CALL 0x1000:30ec
1000:2b6d      e8 37 00                 CALL 0x1000:2ba7
1000:2b70      e8 42 0b                 CALL 0x1000:36b5
1000:2b73      c3                       RET

; ------------------------------------------------------------
1000:2b74  FUN_1000_2b74:
1000:2b74      b9 10 00                 MOV CX,0x10
1000:2b77      be 64 8c                 MOV SI,0x8c64
1000:2b7a  LAB_1000_2b7a:
1000:2b7a      c6 44 16 00              MOV byte ptr [SI + 0x16],0x0
1000:2b7e      c6 44 28 00              MOV byte ptr [SI + 0x28],0x0
1000:2b82      c7 44 32 00 00           MOV word ptr [SI + 0x32],0x0
1000:2b87      c6 44 34 00              MOV byte ptr [SI + 0x34],0x0
1000:2b8b      f6 04 80                 TEST byte ptr [SI],0x80
1000:2b8e      74 03                    JZ 0x1000:2b93
1000:2b90      80 24 fc                 AND byte ptr [SI],0xfc
1000:2b93  LAB_1000_2b93:
1000:2b93      83 c6 3b                 ADD SI,0x3b
1000:2b96      e2 e2                    LOOP 0x1000:2b7a
1000:2b98      b9 04 00                 MOV CX,0x4
1000:2b9b      be 14 90                 MOV SI,0x9014
1000:2b9e  LAB_1000_2b9e:
1000:2b9e      80 24 f8                 AND byte ptr [SI],0xf8
1000:2ba1      83 c6 0e                 ADD SI,0xe
1000:2ba4      e2 f8                    LOOP 0x1000:2b9e
1000:2ba6      c3                       RET

; ------------------------------------------------------------
1000:2ba7  FUN_1000_2ba7:
1000:2ba7      be 14 90                 MOV SI,0x9014
1000:2baa      b9 04 00                 MOV CX,0x4
1000:2bad  LAB_1000_2bad:
1000:2bad      51                       PUSH CX
1000:2bae      bf 64 8c                 MOV DI,0x8c64
1000:2bb1      b9 10 00                 MOV CX,0x10
1000:2bb4  LAB_1000_2bb4:
1000:2bb4      f6 05 80                 TEST byte ptr [DI],0x80
1000:2bb7      74 23                    JZ 0x1000:2bdc
1000:2bb9      8a 45 18                 MOV AL,byte ptr [DI + 0x18]
1000:2bbc      3a 44 0c                 CMP AL,byte ptr [SI + 0xc]
1000:2bbf      74 1b                    JZ 0x1000:2bdc
1000:2bc1      f6 45 19 ff              TEST byte ptr [DI + 0x19],0xff
1000:2bc5      74 15                    JZ 0x1000:2bdc
1000:2bc7      80 7c 0d 00              CMP byte ptr [SI + 0xd],0x0
1000:2bcb      74 0f                    JZ 0x1000:2bdc
1000:2bcd      57                       PUSH DI
1000:2bce      51                       PUSH CX
1000:2bcf      83 c7 19                 ADD DI,0x19
1000:2bd2      b1 01                    MOV CL,0x1
1000:2bd4      e8 ed f7                 CALL 0x1000:23c4
1000:2bd7      59                       POP CX
1000:2bd8      5f                       POP DI
1000:2bd9      e8 0c 00                 CALL 0x1000:2be8
1000:2bdc  LAB_1000_2bdc:
1000:2bdc      83 c7 3b                 ADD DI,0x3b
1000:2bdf      e2 d3                    LOOP 0x1000:2bb4
1000:2be1      59                       POP CX
1000:2be2      83 c6 0e                 ADD SI,0xe
1000:2be5      e2 c6                    LOOP 0x1000:2bad
1000:2be7      c3                       RET

; ------------------------------------------------------------
1000:2be8  FUN_1000_2be8:
1000:2be8      3d a0 00                 CMP AX,0xa0
1000:2beb      77 30                    JA 0x1000:2c1d
1000:2bed      80 0c 80                 OR byte ptr [SI],0x80
1000:2bf0      80 7d 19 04              CMP byte ptr [DI + 0x19],0x4
1000:2bf4      72 27                    JC 0x1000:2c1d
1000:2bf6      a0 6f a2                 MOV AL,[0xa26f]
1000:2bf9      3a 44 0b                 CMP AL,byte ptr [SI + 0xb]
1000:2bfc      75 06                    JNZ 0x1000:2c04
1000:2bfe      c7 06 62 a2 ee 00        MOV word ptr [0xa262],0xee
1000:2c04  LAB_1000_2c04:
1000:2c04      8a 5d 17                 MOV BL,byte ptr [DI + 0x17]
1000:2c07      b8 88 13                 MOV AX,0x1388
1000:2c0a      e8 c7 02                 CALL 0x1000:2ed4
1000:2c0d      c6 45 19 03              MOV byte ptr [DI + 0x19],0x3
1000:2c11      81 6c 08 f4 01           SUB word ptr [SI + 0x8],0x1f4
1000:2c16      79 05                    JNS 0x1000:2c1d
1000:2c18      c7 44 08 00 00           MOV word ptr [SI + 0x8],0x0
1000:2c1d  LAB_1000_2c1d:
1000:2c1d      c3                       RET

; ------------------------------------------------------------
1000:2c1e  FUN_1000_2c1e:
1000:2c1e      bf 64 8c                 MOV DI,0x8c64
1000:2c21      b9 10 00                 MOV CX,0x10
1000:2c24  LAB_1000_2c24:
1000:2c24      f6 05 ff                 TEST byte ptr [DI],0xff
1000:2c27      74 3e                    JZ 0x1000:2c67
1000:2c29      80 25 fb                 AND byte ptr [DI],0xfb
1000:2c2c      51                       PUSH CX
1000:2c2d      be 14 90                 MOV SI,0x9014
1000:2c30      b9 04 00                 MOV CX,0x4
1000:2c33  LAB_1000_2c33:
1000:2c33      80 7c 0d 00              CMP byte ptr [SI + 0xd],0x0
1000:2c37      74 1d                    JZ 0x1000:2c56
1000:2c39      51                       PUSH CX
1000:2c3a      8a 4d 18                 MOV CL,byte ptr [DI + 0x18]
1000:2c3d      3a 4c 0c                 CMP CL,byte ptr [SI + 0xc]
1000:2c40      74 0b                    JZ 0x1000:2c4d
1000:2c42      b1 04                    MOV CL,0x4
1000:2c44      e8 7d f7                 CALL 0x1000:23c4
1000:2c47      e8 23 00                 CALL 0x1000:2c6d
1000:2c4a      eb 09                    JMP 0x1000:2c55
1000:2c4d  LAB_1000_2c4d:
1000:2c4d      b1 00                    MOV CL,0x0
1000:2c4f      e8 72 f7                 CALL 0x1000:23c4
1000:2c52      e8 a5 00                 CALL 0x1000:2cfa
1000:2c55  LAB_1000_2c55:
1000:2c55      59                       POP CX
1000:2c56  LAB_1000_2c56:
1000:2c56      83 c6 0e                 ADD SI,0xe
1000:2c59      e2 d8                    LOOP 0x1000:2c33
1000:2c5b      8a 05                    MOV AL,byte ptr [DI]
1000:2c5d      24 84                    AND AL,0x84
1000:2c5f      3c 84                    CMP AL,0x84
1000:2c61      74 03                    JZ 0x1000:2c66
1000:2c63      80 25 bf                 AND byte ptr [DI],0xbf
1000:2c66  LAB_1000_2c66:
1000:2c66      59                       POP CX
1000:2c67  LAB_1000_2c67:
1000:2c67      83 c7 3b                 ADD DI,0x3b
1000:2c6a      e2 b8                    LOOP 0x1000:2c24
1000:2c6c      c3                       RET

; ------------------------------------------------------------
1000:2c6d  FUN_1000_2c6d:
1000:2c6d      3d d0 07                 CMP AX,0x7d0
1000:2c70      72 02                    JC 0x1000:2c74
1000:2c72      f8                       CLC
1000:2c73      c3                       RET
1000:2c74  LAB_1000_2c74:
1000:2c74      80 3d 0c                 CMP byte ptr [DI],0xc
1000:2c77      77 2f                    JA 0x1000:2ca8
1000:2c79      3d e8 03                 CMP AX,0x3e8
1000:2c7c      77 7a                    JA 0x1000:2cf8
1000:2c7e      8a 1d                    MOV BL,byte ptr [DI]
1000:2c80      32 ff                    XOR BH,BH
1000:2c82      83 eb 02                 SUB BX,0x2
1000:2c85      72 71                    JC 0x1000:2cf8
1000:2c87      d1 e3                    SHL BX,0x1
1000:2c89      d1 e3                    SHL BX,0x1
1000:2c8b      d1 e3                    SHL BX,0x1
1000:2c8d      3d 2c 01                 CMP AX,0x12c
1000:2c90      72 09                    JC 0x1000:2c9b
1000:2c92      d1 eb                    SHR BX,0x1
1000:2c94      3d f4 01                 CMP AX,0x1f4
1000:2c97      72 02                    JC 0x1000:2c9b
1000:2c99      d1 eb                    SHR BX,0x1
1000:2c9b  LAB_1000_2c9b:
1000:2c9b      29 5c 08                 SUB word ptr [SI + 0x8],BX
1000:2c9e      79 58                    JNS 0x1000:2cf8
1000:2ca0      c7 44 08 00 00           MOV word ptr [SI + 0x8],0x0
1000:2ca5      eb 51                    JMP 0x1000:2cf8
1000:2ca8  LAB_1000_2ca8:
1000:2ca8      80 4d 16 01              OR byte ptr [DI + 0x16],0x1
1000:2cac      80 0c 01                 OR byte ptr [SI],0x1
1000:2caf      3d dc 05                 CMP AX,0x5dc
1000:2cb2      77 44                    JA 0x1000:2cf8
1000:2cb4      80 0c 02                 OR byte ptr [SI],0x2
1000:2cb7      3d ee 02                 CMP AX,0x2ee
1000:2cba      77 3c                    JA 0x1000:2cf8
1000:2cbc      80 0c 04                 OR byte ptr [SI],0x4
1000:2cbf      3d fa 00                 CMP AX,0xfa
1000:2cc2      73 34                    JNC 0x1000:2cf8
1000:2cc4      bb 2c 01                 MOV BX,0x12c
1000:2cc7      2b d8                    SUB BX,AX
1000:2cc9      8b c3                    MOV AX,BX
1000:2ccb      d1 e0                    SHL AX,0x1
1000:2ccd      80 7c 0d 04              CMP byte ptr [SI + 0xd],0x4
1000:2cd1      74 02                    JZ 0x1000:2cd5
1000:2cd3      d1 e0                    SHL AX,0x1
1000:2cd5  LAB_1000_2cd5:
1000:2cd5      3d 96 00                 CMP AX,0x96
1000:2cd8      72 1b                    JC 0x1000:2cf5
1000:2cda      c6 45 15 10              MOV byte ptr [DI + 0x15],0x10
1000:2cde      8a 5d 17                 MOV BL,byte ptr [DI + 0x17]
1000:2ce1      b8 e8 03                 MOV AX,0x3e8
1000:2ce4      e8 ed 01                 CALL 0x1000:2ed4
1000:2ce7      b8 f4 01                 MOV AX,0x1f4
1000:2cea      83 6c 08 64              SUB word ptr [SI + 0x8],0x64
1000:2cee      79 05                    JNS 0x1000:2cf5
1000:2cf0      c7 44 08 00 00           MOV word ptr [SI + 0x8],0x0
1000:2cf5  LAB_1000_2cf5:
1000:2cf5      e8 83 f6                 CALL 0x1000:237b
1000:2cf8  LAB_1000_2cf8:
1000:2cf8      f9                       STC
1000:2cf9      c3                       RET

; ------------------------------------------------------------
1000:2cfa  FUN_1000_2cfa:
1000:2cfa      f6 05 80                 TEST byte ptr [DI],0x80
1000:2cfd      74 6f                    JZ 0x1000:2d6e
1000:2cff      80 7c 0d 04              CMP byte ptr [SI + 0xd],0x4
1000:2d03      74 0d                    JZ 0x1000:2d12
1000:2d05      3d fa 00                 CMP AX,0xfa
1000:2d08      77 64                    JA 0x1000:2d6e
1000:2d0a      c7 45 0c 50 c3           MOV word ptr [DI + 0xc],0xc350
1000:2d0f      eb 5d                    JMP 0x1000:2d6e
1000:2d12  LAB_1000_2d12:
1000:2d12      3d a0 00                 CMP AX,0xa0
1000:2d15      77 57                    JA 0x1000:2d6e
1000:2d17      83 7d 32 00              CMP word ptr [DI + 0x32],0x0
1000:2d1b      74 05                    JZ 0x1000:2d22
1000:2d1d      3d 5f 00                 CMP AX,0x5f
1000:2d20      77 4c                    JA 0x1000:2d6e
1000:2d22  LAB_1000_2d22:
1000:2d22      80 0d 04                 OR byte ptr [DI],0x4
1000:2d25      8a 55 11                 MOV DL,byte ptr [DI + 0x11]
1000:2d28      80 e2 1f                 AND DL,0x1f
1000:2d2b      80 fa 04                 CMP DL,0x4
1000:2d2e      75 06                    JNZ 0x1000:2d36
1000:2d30      b2 00                    MOV DL,0x0
1000:2d32      c6 45 11 80              MOV byte ptr [DI + 0x11],0x80
1000:2d36  LAB_1000_2d36:
1000:2d36      f6 05 40                 TEST byte ptr [DI],0x40
1000:2d39      75 27                    JNZ 0x1000:2d62
1000:2d3b      3d 3c 00                 CMP AX,0x3c
1000:2d3e      72 18                    JC 0x1000:2d58
1000:2d40      80 0d 40                 OR byte ptr [DI],0x40
1000:2d43      22 d2                    AND DL,DL
1000:2d45      75 1b                    JNZ 0x1000:2d62
1000:2d47      c6 45 0b 00              MOV byte ptr [DI + 0xb],0x0
1000:2d4b      c6 45 11 07              MOV byte ptr [DI + 0x11],0x7
1000:2d4f      8a 45 17                 MOV AL,byte ptr [DI + 0x17]
1000:2d52      88 45 2b                 MOV byte ptr [DI + 0x2b],AL
1000:2d55      eb 0b                    JMP 0x1000:2d62
1000:2d58  LAB_1000_2d58:
1000:2d58      f6 45 0b ff              TEST byte ptr [DI + 0xb],0xff
1000:2d5c      75 04                    JNZ 0x1000:2d62
1000:2d5e      c6 45 0b 11              MOV byte ptr [DI + 0xb],0x11
1000:2d62  LAB_1000_2d62:
1000:2d62      c6 45 0e 00              MOV byte ptr [DI + 0xe],0x0
1000:2d66      80 24 7f                 AND byte ptr [SI],0x7f
1000:2d69      e8 04 00                 CALL 0x1000:2d70
1000:2d6c      f9                       STC
1000:2d6d      c3                       RET
1000:2d6e  LAB_1000_2d6e:
1000:2d6e      f8                       CLC
1000:2d6f      c3                       RET

; ------------------------------------------------------------
1000:2d70  FUN_1000_2d70:
1000:2d70      a0 d2 89                 MOV AL,[0x89d2]
1000:2d73      24 07                    AND AL,0x7
1000:2d75      75 7e                    JNZ 0x1000:2df5
1000:2d77      c6 06 9c a2 00           MOV byte ptr [0xa29c],0x0
1000:2d7c      81 7d 08 10 27           CMP word ptr [DI + 0x8],0x2710
1000:2d81      77 11                    JA 0x1000:2d94
1000:2d83      83 7c 08 64              CMP word ptr [SI + 0x8],0x64
1000:2d87      76 0b                    JBE 0x1000:2d94
1000:2d89      83 6c 08 32              SUB word ptr [SI + 0x8],0x32
1000:2d8d      81 45 08 f4 01           ADD word ptr [DI + 0x8],0x1f4
1000:2d92      eb 2b                    JMP 0x1000:2dbf
1000:2d94  LAB_1000_2d94:
1000:2d94      81 7d 08 98 3a           CMP word ptr [DI + 0x8],0x3a98
1000:2d99      72 1f                    JC 0x1000:2dba
1000:2d9b      81 7c 08 20 4e           CMP word ptr [SI + 0x8],0x4e20
1000:2da0      73 18                    JNC 0x1000:2dba
1000:2da2      83 7c 08 19              CMP word ptr [SI + 0x8],0x19
1000:2da6      72 12                    JC 0x1000:2dba
1000:2da8      83 44 08 64              ADD word ptr [SI + 0x8],0x64
1000:2dac      81 6d 08 e8 03           SUB word ptr [DI + 0x8],0x3e8
1000:2db1      80 7c 07 63              CMP byte ptr [SI + 0x7],0x63
1000:2db5      77 03                    JA 0x1000:2dba
1000:2db7      fe 44 07                 INC byte ptr [SI + 0x7]
1000:2dba  LAB_1000_2dba:
1000:2dba      80 0e 9c a2 01           OR byte ptr [0xa29c],0x1
1000:2dbf  LAB_1000_2dbf:
1000:2dbf      80 7d 07 0a              CMP byte ptr [DI + 0x7],0xa
1000:2dc3      73 0f                    JNC 0x1000:2dd4
1000:2dc5      f6 44 07 ff              TEST byte ptr [SI + 0x7],0xff
1000:2dc9      74 09                    JZ 0x1000:2dd4
1000:2dcb      fe 4c 07                 DEC byte ptr [SI + 0x7]
1000:2dce      fe 45 07                 INC byte ptr [DI + 0x7]
1000:2dd1      eb 06                    JMP 0x1000:2dd9
1000:2dd4  LAB_1000_2dd4:
1000:2dd4      80 0e 9c a2 02           OR byte ptr [0xa29c],0x2
1000:2dd9  LAB_1000_2dd9:
1000:2dd9      f6 06 d2 89 08           TEST byte ptr [0x89d2],0x8
1000:2dde      75 1a                    JNZ 0x1000:2dfa
1000:2de0      80 7d 06 05              CMP byte ptr [DI + 0x6],0x5
1000:2de4      73 0f                    JNC 0x1000:2df5
1000:2de6      80 7c 06 00              CMP byte ptr [SI + 0x6],0x0
1000:2dea      74 09                    JZ 0x1000:2df5
1000:2dec      fe 4c 06                 DEC byte ptr [SI + 0x6]
1000:2def      fe 45 06                 INC byte ptr [DI + 0x6]
1000:2df2      eb 06                    JMP 0x1000:2dfa
1000:2df5  LAB_1000_2df5:
1000:2df5      80 0e 9c a2 04           OR byte ptr [0xa29c],0x4
1000:2dfa  LAB_1000_2dfa:
1000:2dfa      80 3e 9c a2 07           CMP byte ptr [0xa29c],0x7
1000:2dff      75 00                    JNZ 0x1000:2e01
1000:2e01  LAB_1000_2e01:
1000:2e01      c3                       RET

; ------------------------------------------------------------
1000:2e02  FUN_1000_2e02:
1000:2e02      be 64 8c                 MOV SI,0x8c64
1000:2e05      b9 10 00                 MOV CX,0x10
1000:2e08  LAB_1000_2e08:
1000:2e08      f6 44 19 ff              TEST byte ptr [SI + 0x19],0xff
1000:2e0c      74 29                    JZ 0x1000:2e37
1000:2e0e      bf 64 8c                 MOV DI,0x8c64
1000:2e11      51                       PUSH CX
1000:2e12      b9 10 00                 MOV CX,0x10
1000:2e15  LAB_1000_2e15:
1000:2e15      f6 05 80                 TEST byte ptr [DI],0x80
1000:2e18      74 17                    JZ 0x1000:2e31
1000:2e1a      3b f7                    CMP SI,DI
1000:2e1c      74 13                    JZ 0x1000:2e31
1000:2e1e      80 7d 34 00              CMP byte ptr [DI + 0x34],0x0
1000:2e22      74 08                    JZ 0x1000:2e2c
1000:2e24      8a 45 18                 MOV AL,byte ptr [DI + 0x18]
1000:2e27      3a 44 18                 CMP AL,byte ptr [SI + 0x18]
1000:2e2a      74 05                    JZ 0x1000:2e31
1000:2e2c  LAB_1000_2e2c:
1000:2e2c      51                       PUSH CX
1000:2e2d      e8 0d 00                 CALL 0x1000:2e3d
1000:2e30      59                       POP CX
1000:2e31  LAB_1000_2e31:
1000:2e31      83 c7 3b                 ADD DI,0x3b
1000:2e34      e2 df                    LOOP 0x1000:2e15
1000:2e36      59                       POP CX
1000:2e37  LAB_1000_2e37:
1000:2e37      83 c6 3b                 ADD SI,0x3b
1000:2e3a      e2 cc                    LOOP 0x1000:2e08
1000:2e3c      c3                       RET

; ------------------------------------------------------------
1000:2e3d  FUN_1000_2e3d:
1000:2e3d      f6 05 44                 TEST byte ptr [DI],0x44
1000:2e40      74 09                    JZ 0x1000:2e4b
1000:2e42      8a 45 18                 MOV AL,byte ptr [DI + 0x18]
1000:2e45      3a 44 18                 CMP AL,byte ptr [SI + 0x18]
1000:2e48      75 01                    JNZ 0x1000:2e4b
1000:2e4a      c3                       RET
1000:2e4b  LAB_1000_2e4b:
1000:2e4b      56                       PUSH SI
1000:2e4c      83 c6 19                 ADD SI,0x19
1000:2e4f      b1 02                    MOV CL,0x2
1000:2e51      e8 70 f5                 CALL 0x1000:23c4
1000:2e54      5e                       POP SI
1000:2e55      f6 44 19 80              TEST byte ptr [SI + 0x19],0x80
1000:2e59      74 31                    JZ 0x1000:2e8c
1000:2e5b      3d 58 02                 CMP AX,0x258
1000:2e5e      77 73                    JA 0x1000:2ed3
1000:2e60      80 4d 16 20              OR byte ptr [DI + 0x16],0x20
1000:2e64      3d c2 01                 CMP AX,0x1c2
1000:2e67      77 6a                    JA 0x1000:2ed3
1000:2e69      ba ea 01                 MOV DX,0x1ea
1000:2e6c      2b d0                    SUB DX,AX
1000:2e6e      8b c2                    MOV AX,DX
1000:2e70      d1 e0                    SHL AX,0x1
1000:2e72      03 d0                    ADD DX,AX
1000:2e74      03 d0                    ADD DX,AX
1000:2e76      f6 44 19 40              TEST byte ptr [SI + 0x19],0x40
1000:2e7a      74 05                    JZ 0x1000:2e81
1000:2e7c      03 d0                    ADD DX,AX
1000:2e7e      83 c2 19                 ADD DX,0x19
1000:2e81  LAB_1000_2e81:
1000:2e81      8a 44 19                 MOV AL,byte ptr [SI + 0x19]
1000:2e84      24 0f                    AND AL,0xf
1000:2e86      2c 04                    SUB AL,0x4
1000:2e88      78 49                    JS 0x1000:2ed3
1000:2e8a      eb 3c                    JMP 0x1000:2ec8
1000:2e8c  LAB_1000_2e8c:
1000:2e8c      3d 58 02                 CMP AX,0x258
1000:2e8f      77 42                    JA 0x1000:2ed3
1000:2e91      8a 55 18                 MOV DL,byte ptr [DI + 0x18]
1000:2e94      3a 54 18                 CMP DL,byte ptr [SI + 0x18]
1000:2e97      74 04                    JZ 0x1000:2e9d
1000:2e99      80 4d 16 02              OR byte ptr [DI + 0x16],0x2
1000:2e9d  LAB_1000_2e9d:
1000:2e9d      3d 8c 00                 CMP AX,0x8c
1000:2ea0      77 31                    JA 0x1000:2ed3
1000:2ea2      ba c8 00                 MOV DX,0xc8
1000:2ea5      2b d0                    SUB DX,AX
1000:2ea7      d1 e2                    SHL DX,0x1
1000:2ea9      d1 e2                    SHL DX,0x1
1000:2eab      d1 e2                    SHL DX,0x1
1000:2ead      81 c2 96 00              ADD DX,0x96
1000:2eb1      8a 44 19                 MOV AL,byte ptr [SI + 0x19]
1000:2eb4      3c 04                    CMP AL,0x4
1000:2eb6      72 0c                    JC 0x1000:2ec4
1000:2eb8      f6 05 44                 TEST byte ptr [DI],0x44
1000:2ebb      75 16                    JNZ 0x1000:2ed3
1000:2ebd      c6 44 19 03              MOV byte ptr [SI + 0x19],0x3
1000:2ec1      ba 41 00                 MOV DX,0x41
1000:2ec4  LAB_1000_2ec4:
1000:2ec4      f7 e2                    MUL DX
1000:2ec6      8b d0                    MOV DX,AX
1000:2ec8  LAB_1000_2ec8:
1000:2ec8      8b c2                    MOV AX,DX
1000:2eca      e8 ae f4                 CALL 0x1000:237b
1000:2ecd      8a 5c 17                 MOV BL,byte ptr [SI + 0x17]
1000:2ed0      e8 01 00                 CALL 0x1000:2ed4
1000:2ed3  LAB_1000_2ed3:
1000:2ed3      c3                       RET

; ------------------------------------------------------------
1000:2ed4  FUN_1000_2ed4:
1000:2ed4      32 ff                    XOR BH,BH
1000:2ed6      83 fb 04                 CMP BX,0x4
1000:2ed9      73 17                    JNC 0x1000:2ef2
1000:2edb      d1 e3                    SHL BX,0x1
1000:2edd      52                       PUSH DX
1000:2ede      53                       PUSH BX
1000:2edf      33 d2                    XOR DX,DX
1000:2ee1      bb 64 00                 MOV BX,0x64
1000:2ee4      f7 f3                    DIV BX
1000:2ee6      83 fa 32                 CMP DX,0x32
1000:2ee9      72 01                    JC 0x1000:2eec
1000:2eeb      40                       INC AX
1000:2eec  LAB_1000_2eec:
1000:2eec      5b                       POP BX
1000:2eed      5a                       POP DX
1000:2eee      01 87 e4 89              ADD word ptr [BX + 0x89e4],AX
1000:2ef2  LAB_1000_2ef2:
1000:2ef2      c3                       RET

; ------------------------------------------------------------
1000:2ef3  FUN_1000_2ef3:
1000:2ef3      be 64 8c                 MOV SI,0x8c64
1000:2ef6      bf 50 8d                 MOV DI,0x8d50
1000:2ef9      b9 0c 00                 MOV CX,0xc
1000:2efc  LAB_1000_2efc:
1000:2efc      51                       PUSH CX
1000:2efd      57                       PUSH DI
1000:2efe      56                       PUSH SI
1000:2eff  LAB_1000_2eff:
1000:2eff      51                       PUSH CX
1000:2f00      56                       PUSH SI
1000:2f01      b9 04 00                 MOV CX,0x4
1000:2f04  LAB_1000_2f04:
1000:2f04      e8 1d 00                 CALL 0x1000:2f24
1000:2f07      83 c6 3b                 ADD SI,0x3b
1000:2f0a      e2 f8                    LOOP 0x1000:2f04
1000:2f0c      5e                       POP SI
1000:2f0d      59                       POP CX
1000:2f0e      83 c7 3b                 ADD DI,0x3b
1000:2f11      e2 ec                    LOOP 0x1000:2eff
1000:2f13      5e                       POP SI
1000:2f14      5f                       POP DI
1000:2f15      59                       POP CX
1000:2f16      81 c6 ec 00              ADD SI,0xec
1000:2f1a      81 c7 ec 00              ADD DI,0xec
1000:2f1e      83 e9 04                 SUB CX,0x4
1000:2f21      75 d9                    JNZ 0x1000:2efc
1000:2f23      c3                       RET

; ------------------------------------------------------------
1000:2f24  FUN_1000_2f24:
1000:2f24      8a 44 19                 MOV AL,byte ptr [SI + 0x19]
1000:2f27      3c 03                    CMP AL,0x3
1000:2f29      72 39                    JC 0x1000:2f64
1000:2f2b      3c 80                    CMP AL,0x80
1000:2f2d      73 35                    JNC 0x1000:2f64
1000:2f2f      8a 45 19                 MOV AL,byte ptr [DI + 0x19]
1000:2f32      3c 03                    CMP AL,0x3
1000:2f34      72 2e                    JC 0x1000:2f64
1000:2f36      3c 80                    CMP AL,0x80
1000:2f38      73 2a                    JNC 0x1000:2f64
1000:2f3a      51                       PUSH CX
1000:2f3b      56                       PUSH SI
1000:2f3c      57                       PUSH DI
1000:2f3d      83 c6 19                 ADD SI,0x19
1000:2f40      83 c7 19                 ADD DI,0x19
1000:2f43      b1 01                    MOV CL,0x1
1000:2f45      e8 7c f4                 CALL 0x1000:23c4
1000:2f48      5f                       POP DI
1000:2f49      5e                       POP SI
1000:2f4a      59                       POP CX
1000:2f4b      3d 5a 00                 CMP AX,0x5a
1000:2f4e      77 14                    JA 0x1000:2f64
1000:2f50      80 7c 19 04              CMP byte ptr [SI + 0x19],0x4
1000:2f54      72 04                    JC 0x1000:2f5a
1000:2f56      c6 44 19 03              MOV byte ptr [SI + 0x19],0x3
1000:2f5a  LAB_1000_2f5a:
1000:2f5a      80 7d 19 04              CMP byte ptr [DI + 0x19],0x4
1000:2f5e      72 04                    JC 0x1000:2f64
1000:2f60      c6 45 19 03              MOV byte ptr [DI + 0x19],0x3
1000:2f64  LAB_1000_2f64:
1000:2f64      c3                       RET

; ------------------------------------------------------------
1000:2f65  FUN_1000_2f65:
1000:2f65      be 64 8c                 MOV SI,0x8c64
1000:2f68      bf 50 8d                 MOV DI,0x8d50
1000:2f6b      b9 0c 00                 MOV CX,0xc
1000:2f6e  LAB_1000_2f6e:
1000:2f6e      51                       PUSH CX
1000:2f6f      57                       PUSH DI
1000:2f70      56                       PUSH SI
1000:2f71  LAB_1000_2f71:
1000:2f71      f6 05 ff                 TEST byte ptr [DI],0xff
1000:2f74      74 11                    JZ 0x1000:2f87
1000:2f76      51                       PUSH CX
1000:2f77      56                       PUSH SI
1000:2f78      b9 04 00                 MOV CX,0x4
1000:2f7b  LAB_1000_2f7b:
1000:2f7b      51                       PUSH CX
1000:2f7c      e8 1e 00                 CALL 0x1000:2f9d
1000:2f7f      59                       POP CX
1000:2f80      83 c6 3b                 ADD SI,0x3b
1000:2f83      e2 f6                    LOOP 0x1000:2f7b
1000:2f85      5e                       POP SI
1000:2f86      59                       POP CX
1000:2f87  LAB_1000_2f87:
1000:2f87      83 c7 3b                 ADD DI,0x3b
1000:2f8a      e2 e5                    LOOP 0x1000:2f71
1000:2f8c      5e                       POP SI
1000:2f8d      5f                       POP DI
1000:2f8e      59                       POP CX
1000:2f8f      81 c6 ec 00              ADD SI,0xec
1000:2f93      81 c7 ec 00              ADD DI,0xec
1000:2f97      83 e9 04                 SUB CX,0x4
1000:2f9a      75 d2                    JNZ 0x1000:2f6e
1000:2f9c      c3                       RET

; ------------------------------------------------------------
1000:2f9d  FUN_1000_2f9d:
1000:2f9d      f6 04 ff                 TEST byte ptr [SI],0xff
1000:2fa0      75 01                    JNZ 0x1000:2fa3
1000:2fa2  LAB_1000_2fa2:
1000:2fa2      c3                       RET
1000:2fa3  LAB_1000_2fa3:
1000:2fa3      51                       PUSH CX
1000:2fa4      b1 03                    MOV CL,0x3
1000:2fa6      e8 1b f4                 CALL 0x1000:23c4
1000:2fa9      59                       POP CX
1000:2faa      3d d0 07                 CMP AX,0x7d0
1000:2fad      77 f3                    JA 0x1000:2fa2
1000:2faf      8a 5d 18                 MOV BL,byte ptr [DI + 0x18]
1000:2fb2      3a 5c 18                 CMP BL,byte ptr [SI + 0x18]
1000:2fb5      75 27                    JNZ 0x1000:2fde
1000:2fb7      3d 2c 01                 CMP AX,0x12c
1000:2fba      77 e6                    JA 0x1000:2fa2
1000:2fbc      80 fb 20                 CMP BL,0x20
1000:2fbf      75 e1                    JNZ 0x1000:2fa2
1000:2fc1      f6 05 44                 TEST byte ptr [DI],0x44
1000:2fc4      75 dc                    JNZ 0x1000:2fa2
1000:2fc6      c6 45 15 02              MOV byte ptr [DI + 0x15],0x2
1000:2fca      c6 44 15 02              MOV byte ptr [SI + 0x15],0x2
1000:2fce      8a 45 0b                 MOV AL,byte ptr [DI + 0xb]
1000:2fd1      24 0f                    AND AL,0xf
1000:2fd3      3c 06                    CMP AL,0x6
1000:2fd5      76 cb                    JBE 0x1000:2fa2
1000:2fd7      fe 4d 0b                 DEC byte ptr [DI + 0xb]
1000:2fda      fe 4d 0b                 DEC byte ptr [DI + 0xb]
1000:2fdd      c3                       RET
1000:2fde  LAB_1000_2fde:
1000:2fde      50                       PUSH AX
1000:2fdf      e8 84 00                 CALL 0x1000:3066
1000:2fe2      ba d0 07                 MOV DX,0x7d0
1000:2fe5      81 7d 08 40 9c           CMP word ptr [DI + 0x8],0x9c40
1000:2fea      77 0d                    JA 0x1000:2ff9
1000:2fec      f6 44 19 f0              TEST byte ptr [SI + 0x19],0xf0
1000:2ff0      75 07                    JNZ 0x1000:2ff9
1000:2ff2      f6 04 10                 TEST byte ptr [SI],0x10
1000:2ff5      74 02                    JZ 0x1000:2ff9
1000:2ff7      d1 ea                    SHR DX,0x1
1000:2ff9  LAB_1000_2ff9:
1000:2ff9      3b c2                    CMP AX,DX
1000:2ffb      77 26                    JA 0x1000:3023
1000:2ffd      80 4d 16 40              OR byte ptr [DI + 0x16],0x40
1000:3001      8a 1d                    MOV BL,byte ptr [DI]
1000:3003      80 e3 fc                 AND BL,0xfc
1000:3006      79 1b                    JNS 0x1000:3023
1000:3008      80 cb 01                 OR BL,0x1
1000:300b      d1 ea                    SHR DX,0x1
1000:300d      3b c2                    CMP AX,DX
1000:300f      77 0a                    JA 0x1000:301b
1000:3011      fe c3                    INC BL
1000:3013      d1 ea                    SHR DX,0x1
1000:3015      3b c2                    CMP AX,DX
1000:3017      77 02                    JA 0x1000:301b
1000:3019      fe c3                    INC BL
1000:301b  LAB_1000_301b:
1000:301b      8a 05                    MOV AL,byte ptr [DI]
1000:301d      3a c3                    CMP AL,BL
1000:301f      73 02                    JNC 0x1000:3023
1000:3021      88 1d                    MOV byte ptr [DI],BL
1000:3023  LAB_1000_3023:
1000:3023      58                       POP AX
1000:3024      ba d0 07                 MOV DX,0x7d0
1000:3027      81 7c 08 40 9c           CMP word ptr [SI + 0x8],0x9c40
1000:302c      77 0d                    JA 0x1000:303b
1000:302e      f6 45 19 f0              TEST byte ptr [DI + 0x19],0xf0
1000:3032      75 07                    JNZ 0x1000:303b
1000:3034      f6 05 10                 TEST byte ptr [DI],0x10
1000:3037      74 02                    JZ 0x1000:303b
1000:3039      d1 ea                    SHR DX,0x1
1000:303b  LAB_1000_303b:
1000:303b      3b c2                    CMP AX,DX
1000:303d      77 26                    JA 0x1000:3065
1000:303f      80 4c 16 40              OR byte ptr [SI + 0x16],0x40
1000:3043      8a 1c                    MOV BL,byte ptr [SI]
1000:3045      80 e3 fc                 AND BL,0xfc
1000:3048      79 1b                    JNS 0x1000:3065
1000:304a      80 cb 01                 OR BL,0x1
1000:304d      d1 ea                    SHR DX,0x1
1000:304f      3b c2                    CMP AX,DX
1000:3051      77 0a                    JA 0x1000:305d
1000:3053      fe c3                    INC BL
1000:3055      d1 ea                    SHR DX,0x1
1000:3057      3b c2                    CMP AX,DX
1000:3059      77 02                    JA 0x1000:305d
1000:305b      fe c3                    INC BL
1000:305d  LAB_1000_305d:
1000:305d      8a 04                    MOV AL,byte ptr [SI]
1000:305f      3a c3                    CMP AL,BL
1000:3061      73 02                    JNC 0x1000:3065
1000:3063      88 1c                    MOV byte ptr [SI],BL
1000:3065  LAB_1000_3065:
1000:3065      c3                       RET

; ------------------------------------------------------------
1000:3066  FUN_1000_3066:
1000:3066      50                       PUSH AX
1000:3067      05 02 00                 ADD AX,0x2
1000:306a      3d c4 09                 CMP AX,0x9c4
1000:306d      77 33                    JA 0x1000:30a2
1000:306f      e8 32 00                 CALL 0x1000:30a4
1000:3072      87 f7                    XCHG DI,SI
1000:3074      e8 2d 00                 CALL 0x1000:30a4
1000:3077      87 f7                    XCHG DI,SI
1000:3079      3d 78 00                 CMP AX,0x78
1000:307c      77 24                    JA 0x1000:30a2
1000:307e      80 45 15 02              ADD byte ptr [DI + 0x15],0x2
1000:3082      80 44 15 02              ADD byte ptr [SI + 0x15],0x2
1000:3086      8b 45 08                 MOV AX,word ptr [DI + 0x8]
1000:3089      d1 e8                    SHR AX,0x1
1000:308b      d1 e8                    SHR AX,0x1
1000:308d      d1 e8                    SHR AX,0x1
1000:308f      e8 e9 f2                 CALL 0x1000:237b
1000:3092      87 f7                    XCHG DI,SI
1000:3094      8b 45 08                 MOV AX,word ptr [DI + 0x8]
1000:3097      d1 e8                    SHR AX,0x1
1000:3099      d1 e8                    SHR AX,0x1
1000:309b      d1 e8                    SHR AX,0x1
1000:309d      e8 db f2                 CALL 0x1000:237b
1000:30a0      87 f7                    XCHG DI,SI
1000:30a2  LAB_1000_30a2:
1000:30a2      58                       POP AX
1000:30a3      c3                       RET

; ------------------------------------------------------------
1000:30a4  FUN_1000_30a4:
1000:30a4      8a 1c                    MOV BL,byte ptr [SI]
1000:30a6      80 fb 0c                 CMP BL,0xc
1000:30a9      77 26                    JA 0x1000:30d1
1000:30ab      32 ff                    XOR BH,BH
1000:30ad      d1 e3                    SHL BX,0x1
1000:30af      2e 8b 8f d2 30           MOV CX,word ptr CS:[BX + 0x30d2]
1000:30b4      e3 1b                    JCXZ 0x1000:30d1
1000:30b6      52                       PUSH DX
1000:30b7      50                       PUSH AX
1000:30b8      50                       PUSH AX
1000:30b9      bb 32 00                 MOV BX,0x32
1000:30bc      f7 e3                    MUL BX
1000:30be      e8 af f3                 CALL 0x1000:2470
1000:30c1      f7 e1                    MUL CX
1000:30c3      5b                       POP BX
1000:30c4      f7 f3                    DIV BX
1000:30c6      e8 b2 f2                 CALL 0x1000:237b
1000:30c9      8a 5c 17                 MOV BL,byte ptr [SI + 0x17]
1000:30cc      e8 05 fe                 CALL 0x1000:2ed4
1000:30cf      58                       POP AX
1000:30d0      5a                       POP DX
1000:30d1  LAB_1000_30d1:
1000:30d1      c3                       RET

; ------------------------------------------------------------
1000:30ec  FUN_1000_30ec:
1000:30ec      b9 04 00                 MOV CX,0x4
1000:30ef      bf 64 8c                 MOV DI,0x8c64
1000:30f2  LAB_1000_30f2:
1000:30f2      51                       PUSH CX
1000:30f3      b9 04 00                 MOV CX,0x4
1000:30f6  LAB_1000_30f6:
1000:30f6      f6 05 80                 TEST byte ptr [DI],0x80
1000:30f9      74 05                    JZ 0x1000:3100
1000:30fb      51                       PUSH CX
1000:30fc      e8 0a 00                 CALL 0x1000:3109
1000:30ff      59                       POP CX
1000:3100  LAB_1000_3100:
1000:3100      83 c7 3b                 ADD DI,0x3b
1000:3103      e2 f1                    LOOP 0x1000:30f6
1000:3105      59                       POP CX
1000:3106      e2 ea                    LOOP 0x1000:30f2
1000:3108      c3                       RET

; ------------------------------------------------------------
1000:3109  FUN_1000_3109:
1000:3109      c6 06 82 a2 00           MOV byte ptr [0xa282],0x0
1000:310e      be 4c 90                 MOV SI,0x904c
1000:3111  LAB_1000_3111:
1000:3111      56                       PUSH SI
1000:3112      b9 14 00                 MOV CX,0x14
1000:3115  LAB_1000_3115:
1000:3115      51                       PUSH CX
1000:3116      80 3c 00                 CMP byte ptr [SI],0x0
1000:3119      74 0f                    JZ 0x1000:312a
1000:311b      f6 05 80                 TEST byte ptr [DI],0x80
1000:311e      74 0a                    JZ 0x1000:312a
1000:3120      b1 02                    MOV CL,0x2
1000:3122      e8 9f f2                 CALL 0x1000:23c4
1000:3125      3d 58 02                 CMP AX,0x258
1000:3128      72 03                    JC 0x1000:312d
1000:312a  LAB_1000_312a:
1000:312a      e9 83 00                 JMP 0x1000:31b0
1000:312d  LAB_1000_312d:
1000:312d      8a 5c 07                 MOV BL,byte ptr [SI + 0x7]
1000:3130      3a 5d 18                 CMP BL,byte ptr [DI + 0x18]
1000:3133      75 2d                    JNZ 0x1000:3162
1000:3135      3d 64 00                 CMP AX,0x64
1000:3138      77 79                    JA 0x1000:31b3
1000:313a      8a 5c 06                 MOV BL,byte ptr [SI + 0x6]
1000:313d      3a 5d 17                 CMP BL,byte ptr [DI + 0x17]
1000:3140      75 71                    JNZ 0x1000:31b3
1000:3142      80 7d 2a 00              CMP byte ptr [DI + 0x2a],0x0
1000:3146      74 6b                    JZ 0x1000:31b3
1000:3148      f6 45 22 01              TEST byte ptr [DI + 0x22],0x1
1000:314c      74 65                    JZ 0x1000:31b3
1000:314e      80 7d 06 05              CMP byte ptr [DI + 0x6],0x5
1000:3152      72 06                    JC 0x1000:315a
1000:3154      c6 45 22 00              MOV byte ptr [DI + 0x22],0x0
1000:3158      eb 59                    JMP 0x1000:31b3
1000:315a  LAB_1000_315a:
1000:315a      c6 04 00                 MOV byte ptr [SI],0x0
1000:315d      fe 45 06                 INC byte ptr [DI + 0x6]
1000:3160      eb 51                    JMP 0x1000:31b3
1000:3162  LAB_1000_3162:
1000:3162      80 4d 16 04              OR byte ptr [DI + 0x16],0x4
1000:3166      3d 04 01                 CMP AX,0x104
1000:3169      77 45                    JA 0x1000:31b0
1000:316b      80 3c 02                 CMP byte ptr [SI],0x2
1000:316e      76 03                    JBE 0x1000:3173
1000:3170      c6 04 02                 MOV byte ptr [SI],0x2
1000:3173  LAB_1000_3173:
1000:3173      f6 05 44                 TEST byte ptr [DI],0x44
1000:3176      75 1a                    JNZ 0x1000:3192
1000:3178      80 3c 01                 CMP byte ptr [SI],0x1
1000:317b      75 15                    JNZ 0x1000:3192
1000:317d      fe 4d 2a                 DEC byte ptr [DI + 0x2a]
1000:3180      79 10                    JNS 0x1000:3192
1000:3182      c6 45 2a 00              MOV byte ptr [DI + 0x2a],0x0
1000:3186      b8 88 13                 MOV AX,0x1388
1000:3189      e8 ef f1                 CALL 0x1000:237b
1000:318c      8a 5c 06                 MOV BL,byte ptr [SI + 0x6]
1000:318f      e8 42 fd                 CALL 0x1000:2ed4
1000:3192  LAB_1000_3192:
1000:3192      8a 45 0b                 MOV AL,byte ptr [DI + 0xb]
1000:3195      25 0f 00                 AND AX,0xf
1000:3198      3d 0a 00                 CMP AX,0xa
1000:319b      76 03                    JBE 0x1000:31a0
1000:319d      b8 14 00                 MOV AX,0x14
1000:31a0  LAB_1000_31a0:
1000:31a0      b1 06                    MOV CL,0x6
1000:31a2      d3 e0                    SHL AX,CL
1000:31a4      05 c8 00                 ADD AX,0xc8
1000:31a7      e8 d1 f1                 CALL 0x1000:237b
1000:31aa      8a 5c 06                 MOV BL,byte ptr [SI + 0x6]
1000:31ad      e8 24 fd                 CALL 0x1000:2ed4
1000:31b0  LAB_1000_31b0:
1000:31b0      e8 1e 00                 CALL 0x1000:31d1
1000:31b3  LAB_1000_31b3:
1000:31b3      83 c6 08                 ADD SI,0x8
1000:31b6      59                       POP CX
1000:31b7      49                       DEC CX
1000:31b8      74 03                    JZ 0x1000:31bd
1000:31ba      e9 58 ff                 JMP 0x1000:3115
1000:31bd  LAB_1000_31bd:
1000:31bd      5e                       POP SI
1000:31be      81 c6 a0 00              ADD SI,0xa0
1000:31c2      fe 06 82 a2              INC byte ptr [0xa282]
1000:31c6      80 3e 82 a2 04           CMP byte ptr [0xa282],0x4
1000:31cb      73 03                    JNC 0x1000:31d0
1000:31cd      e9 41 ff                 JMP 0x1000:3111
1000:31d0  LAB_1000_31d0:
1000:31d0      c3                       RET

; ------------------------------------------------------------
1000:31d1  FUN_1000_31d1:
1000:31d1      f6 45 11 1f              TEST byte ptr [DI + 0x11],0x1f
1000:31d5      75 18                    JNZ 0x1000:31ef
1000:31d7      f6 45 16 04              TEST byte ptr [DI + 0x16],0x4
1000:31db      74 12                    JZ 0x1000:31ef
1000:31dd      80 7d 2a 02              CMP byte ptr [DI + 0x2a],0x2
1000:31e1      76 0c                    JBE 0x1000:31ef
1000:31e3      8a 45 0b                 MOV AL,byte ptr [DI + 0xb]
1000:31e6      24 0f                    AND AL,0xf
1000:31e8      3c 06                    CMP AL,0x6
1000:31ea      76 03                    JBE 0x1000:31ef
1000:31ec      fe 4d 0b                 DEC byte ptr [DI + 0xb]
1000:31ef  LAB_1000_31ef:
1000:31ef      c3                       RET

; ------------------------------------------------------------
1000:31f0  FUN_1000_31f0:
1000:31f0      b9 04 00                 MOV CX,0x4
1000:31f3      bf 64 8c                 MOV DI,0x8c64
1000:31f6      bd 14 90                 MOV BP,0x9014
1000:31f9      c6 06 82 a2 80           MOV byte ptr [0xa282],0x80
1000:31fe      c6 06 74 a2 00           MOV byte ptr [0xa274],0x0
1000:3203  LAB_1000_3203:
1000:3203      51                       PUSH CX
1000:3204      b9 04 00                 MOV CX,0x4
1000:3207  LAB_1000_3207:
1000:3207      f6 05 80                 TEST byte ptr [DI],0x80
1000:320a      74 05                    JZ 0x1000:3211
1000:320c      51                       PUSH CX
1000:320d      e8 37 00                 CALL 0x1000:3247
1000:3210      59                       POP CX
1000:3211  LAB_1000_3211:
1000:3211      83 c7 3b                 ADD DI,0x3b
1000:3214      e2 f1                    LOOP 0x1000:3207
1000:3216      59                       POP CX
1000:3217      83 c5 0e                 ADD BP,0xe
1000:321a      d0 2e 82 a2              SHR byte ptr [0xa282],0x1
1000:321e      fe 06 74 a2              INC byte ptr [0xa274]
1000:3222      e2 df                    LOOP 0x1000:3203
1000:3224      c3                       RET

; ------------------------------------------------------------
1000:3225  FUN_1000_3225:
1000:3225      8a 44 05                 MOV AL,byte ptr [SI + 0x5]

; ------------------------------------------------------------
1000:3228  FUN_1000_3228:
1000:3228      bf cc 92                 MOV DI,0x92cc
1000:322b      22 c0                    AND AL,AL
1000:322d      74 11                    JZ 0x1000:3240
1000:322f      bf 3c 96                 MOV DI,0x963c
1000:3232      fe c8                    DEC AL
1000:3234      74 0a                    JZ 0x1000:3240
1000:3236      bf ac 99                 MOV DI,0x99ac
1000:3239      fe c8                    DEC AL
1000:323b      74 03                    JZ 0x1000:3240
1000:323d      bf 1c 9d                 MOV DI,0x9d1c
1000:3240  LAB_1000_3240:
1000:3240      8a 0e 00 00              MOV CL,byte ptr [0x0]
1000:3244      32 ed                    XOR CH,CH
1000:3246      c3                       RET

; ------------------------------------------------------------
1000:3247  FUN_1000_3247:
1000:3247      87 f7                    XCHG DI,SI
1000:3249      e8 d9 ff                 CALL 0x1000:3225
1000:324c      87 f7                    XCHG DI,SI
1000:324e      d1 e9                    SHR CX,0x1
1000:3250      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
1000:3255      75 03                    JNZ 0x1000:325a
1000:3257      83 c6 0b                 ADD SI,0xb
1000:325a  LAB_1000_325a:
1000:325a      51                       PUSH CX
1000:325b      b1 04                    MOV CL,0x4
1000:325d      e8 64 f1                 CALL 0x1000:23c4
1000:3260      50                       PUSH AX
1000:3261      3d 90 01                 CMP AX,0x190
1000:3264      77 64                    JA 0x1000:32ca
1000:3266      8a 1e 82 a2              MOV BL,byte ptr [0xa282]
1000:326a      08 1c                    OR byte ptr [SI],BL
1000:326c      3d fa 00                 CMP AX,0xfa
1000:326f      77 59                    JA 0x1000:32ca
1000:3271      8a 1c                    MOV BL,byte ptr [SI]
1000:3273      81 e3 0f 00              AND BX,0xf
1000:3277      74 4a                    JZ 0x1000:32c3
1000:3279      80 fb 0e                 CMP BL,0xe
1000:327c      74 05                    JZ 0x1000:3283
1000:327e      80 fb 0d                 CMP BL,0xd
1000:3281      77 40                    JA 0x1000:32c3
1000:3283  LAB_1000_3283:
1000:3283      3d 46 00                 CMP AX,0x46
1000:3286      77 42                    JA 0x1000:32ca
1000:3288      8a 45 11                 MOV AL,byte ptr [DI + 0x11]
1000:328b      24 1f                    AND AL,0x1f
1000:328d      3c 01                    CMP AL,0x1
1000:328f      74 39                    JZ 0x1000:32ca
1000:3291      87 f7                    XCHG DI,SI
1000:3293      e8 c1 0c                 CALL 0x1000:3f57
1000:3296      87 f7                    XCHG DI,SI
1000:3298      75 30                    JNZ 0x1000:32ca
1000:329a      80 7d 29 03              CMP byte ptr [DI + 0x29],0x3
1000:329e      75 23                    JNZ 0x1000:32c3
1000:32a0      8a 04                    MOV AL,byte ptr [SI]
1000:32a2      24 0f                    AND AL,0xf
1000:32a4      3c 0a                    CMP AL,0xa
1000:32a6      72 11                    JC 0x1000:32b9
1000:32a8      3c 0d                    CMP AL,0xd
1000:32aa      76 17                    JBE 0x1000:32c3
1000:32ac      3c 0e                    CMP AL,0xe
1000:32ae      75 09                    JNZ 0x1000:32b9
1000:32b0      3e 8a 46 05              MOV AL,byte ptr DS:[BP + 0x5]
1000:32b4      3a 44 05                 CMP AL,byte ptr [SI + 0x5]
1000:32b7      75 0a                    JNZ 0x1000:32c3
1000:32b9  LAB_1000_32b9:
1000:32b9      c6 45 29 00              MOV byte ptr [DI + 0x29],0x0
1000:32bd      8a 45 18                 MOV AL,byte ptr [DI + 0x18]
1000:32c0      88 44 0a                 MOV byte ptr [SI + 0xa],AL
1000:32c3  LAB_1000_32c3:
1000:32c3      03 db                    ADD BX,BX
1000:32c5      2e ff 97 1b 33           CALL word ptr CS:[BX + 0x331b]
1000:32ca  LAB_1000_32ca:
1000:32ca      87 f7                    XCHG DI,SI
1000:32cc      e8 88 0c                 CALL 0x1000:3f57
1000:32cf      87 f7                    XCHG DI,SI
1000:32d1      58                       POP AX
1000:32d2      75 03                    JNZ 0x1000:32d7
1000:32d4      e8 0e 00                 CALL 0x1000:32e5
1000:32d7  LAB_1000_32d7:
1000:32d7      83 c6 0b                 ADD SI,0xb
1000:32da      83 c6 0b                 ADD SI,0xb
1000:32dd      59                       POP CX
1000:32de      49                       DEC CX
1000:32df      74 03                    JZ 0x1000:32e4
1000:32e1      e9 76 ff                 JMP 0x1000:325a
1000:32e4  LAB_1000_32e4:
1000:32e4      c3                       RET

; ------------------------------------------------------------
1000:32e5  FUN_1000_32e5:
1000:32e5      3d a0 0f                 CMP AX,0xfa0
1000:32e8      77 20                    JA 0x1000:330a
1000:32ea      8a 1e 82 a2              MOV BL,byte ptr [0xa282]
1000:32ee      22 1c                    AND BL,byte ptr [SI]
1000:32f0      75 05                    JNZ 0x1000:32f7
1000:32f2      80 4d 28 10              OR byte ptr [DI + 0x28],0x10
1000:32f6      c3                       RET
1000:32f7  LAB_1000_32f7:
1000:32f7      3d b8 0b                 CMP AX,0xbb8
1000:32fa      77 0e                    JA 0x1000:330a
1000:32fc      8a 1c                    MOV BL,byte ptr [SI]
1000:32fe      81 e3 0f 00              AND BX,0xf
1000:3302      2e 8a 87 0b 33           MOV AL,byte ptr CS:[BX + 0x330b]
1000:3307      08 45 28                 OR byte ptr [DI + 0x28],AL
1000:330a  LAB_1000_330a:
1000:330a      c3                       RET

; ------------------------------------------------------------
1000:36b5  FUN_1000_36b5:
1000:36b5      be 8c 8a                 MOV SI,0x8a8c
1000:36b8      8a 0e 01 00              MOV CL,byte ptr [0x1]
1000:36bc      32 ed                    XOR CH,CH
1000:36be  LAB_1000_36be:
1000:36be      ff 4c 08                 DEC word ptr [SI + 0x8]
1000:36c1      75 03                    JNZ 0x1000:36c6
1000:36c3      e8 4c 0c                 CALL 0x1000:4312
1000:36c6  LAB_1000_36c6:
1000:36c6      56                       PUSH SI
1000:36c7      51                       PUSH CX
1000:36c8      bb 80 3e                 MOV BX,0x3e80
1000:36cb      b9 10 00                 MOV CX,0x10
1000:36ce      bf 64 8c                 MOV DI,0x8c64
1000:36d1  LAB_1000_36d1:
1000:36d1      51                       PUSH CX
1000:36d2      8a 05                    MOV AL,byte ptr [DI]
1000:36d4      a8 80                    TEST AL,0x80
1000:36d6      74 1b                    JZ 0x1000:36f3
1000:36d8      a8 44                    TEST AL,0x44
1000:36da      75 17                    JNZ 0x1000:36f3
1000:36dc      8a 0c                    MOV CL,byte ptr [SI]
1000:36de      80 e1 03                 AND CL,0x3
1000:36e1      80 f9 02                 CMP CL,0x2
1000:36e4      75 10                    JNZ 0x1000:36f6
1000:36e6      81 7d 08 b8 0b           CMP word ptr [DI + 0x8],0xbb8
1000:36eb      76 13                    JBE 0x1000:3700
1000:36ed      80 7d 0e 09              CMP byte ptr [DI + 0xe],0x9
1000:36f1      73 0d                    JNC 0x1000:3700
1000:36f3  LAB_1000_36f3:
1000:36f3      e9 90 00                 JMP 0x1000:3786
1000:36f6  LAB_1000_36f6:
1000:36f6      f6 45 19 f0              TEST byte ptr [DI + 0x19],0xf0
1000:36fa      75 04                    JNZ 0x1000:3700
1000:36fc      a8 10                    TEST AL,0x10
1000:36fe      75 f3                    JNZ 0x1000:36f3
1000:3700  LAB_1000_3700:
1000:3700      e8 b0 08                 CALL 0x1000:3fb3
1000:3703      3d 5e 01                 CMP AX,0x15e
1000:3706      77 eb                    JA 0x1000:36f3
1000:3708      8a 0c                    MOV CL,byte ptr [SI]
1000:370a      80 e1 03                 AND CL,0x3
1000:370d      80 f9 00                 CMP CL,0x0
1000:3710      75 33                    JNZ 0x1000:3745
1000:3712      80 4d 16 10              OR byte ptr [DI + 0x16],0x10
1000:3716      f6 45 19 80              TEST byte ptr [DI + 0x19],0x80
1000:371a      74 0a                    JZ 0x1000:3726
1000:371c      83 7c 08 15              CMP word ptr [SI + 0x8],0x15
1000:3720      72 1b                    JC 0x1000:373d
1000:3722      83 6c 08 14              SUB word ptr [SI + 0x8],0x14
1000:3726  LAB_1000_3726:
1000:3726      3d 64 00                 CMP AX,0x64
1000:3729      77 5b                    JA 0x1000:3786
1000:372b      52                       PUSH DX
1000:372c      b9 3c 00                 MOV CX,0x3c
1000:372f      8b 45 08                 MOV AX,word ptr [DI + 0x8]
1000:3732      33 d2                    XOR DX,DX
1000:3734      f7 f1                    DIV CX
1000:3736      e8 42 ec                 CALL 0x1000:237b
1000:3739      5a                       POP DX
1000:373a      eb 1b                    JMP 0x1000:3757
1000:373d  LAB_1000_373d:
1000:373d      c7 44 08 01 00           MOV word ptr [SI + 0x8],0x1
1000:3742      eb 42                    JMP 0x1000:3786
1000:3745  LAB_1000_3745:
1000:3745      80 f9 01                 CMP CL,0x1
1000:3748      75 1a                    JNZ 0x1000:3764
1000:374a      80 4d 16 08              OR byte ptr [DI + 0x16],0x8
1000:374e      3d 55 00                 CMP AX,0x55
1000:3751      77 33                    JA 0x1000:3786
1000:3753      80 45 15 02              ADD byte ptr [DI + 0x15],0x2
1000:3757  LAB_1000_3757:
1000:3757      83 7c 08 04              CMP word ptr [SI + 0x8],0x4
1000:375b      76 29                    JBE 0x1000:3786
1000:375d      83 6c 08 03              SUB word ptr [SI + 0x8],0x3
1000:3761      eb 23                    JMP 0x1000:3786
1000:3764  LAB_1000_3764:
1000:3764      3d 64 00                 CMP AX,0x64
1000:3767      77 1d                    JA 0x1000:3786
1000:3769      c7 45 08 b8 88           MOV word ptr [DI + 0x8],0x88b8
1000:376e      c6 45 07 14              MOV byte ptr [DI + 0x7],0x14
1000:3772      c6 45 0f 63              MOV byte ptr [DI + 0xf],0x63
1000:3776      c6 45 2a 08              MOV byte ptr [DI + 0x2a],0x8
1000:377a      c6 45 0e 00              MOV byte ptr [DI + 0xe],0x0
1000:377e      e8 20 00                 CALL 0x1000:37a1
1000:3781      c7 44 08 01 00           MOV word ptr [SI + 0x8],0x1
1000:3786  LAB_1000_3786:
1000:3786      83 c7 3b                 ADD DI,0x3b
1000:3789      59                       POP CX
1000:378a      49                       DEC CX
1000:378b      74 03                    JZ 0x1000:3790
1000:378d      e9 41 ff                 JMP 0x1000:36d1
1000:3790  LAB_1000_3790:
1000:3790      8b fe                    MOV DI,SI
1000:3792      e8 89 ea                 CALL 0x1000:221e
1000:3795      59                       POP CX
1000:3796      5e                       POP SI
1000:3797      83 c6 3b                 ADD SI,0x3b
1000:379a      49                       DEC CX
1000:379b      74 03                    JZ 0x1000:37a0
1000:379d      e9 1e ff                 JMP 0x1000:36be
1000:37a0  LAB_1000_37a0:
1000:37a0      c3                       RET

; ------------------------------------------------------------
1000:37a1  FUN_1000_37a1:
1000:37a1      80 7d 15 0c              CMP byte ptr [DI + 0x15],0xc
1000:37a5      76 04                    JBE 0x1000:37ab
1000:37a7      c6 45 15 0c              MOV byte ptr [DI + 0x15],0xc
1000:37ab  LAB_1000_37ab:
1000:37ab      c3                       RET

; ------------------------------------------------------------
1000:37ac  FUN_1000_37ac:
1000:37ac      bf 8c 8a                 MOV DI,0x8a8c
1000:37af      b1 08                    MOV CL,0x8
1000:37b1      80 c1 10                 ADD CL,0x10
1000:37b4      32 ed                    XOR CH,CH
1000:37b6  LAB_1000_37b6:
1000:37b6      51                       PUSH CX
1000:37b7      f6 05 80                 TEST byte ptr [DI],0x80
1000:37ba      74 30                    JZ 0x1000:37ec
1000:37bc      8b 45 0a                 MOV AX,word ptr [DI + 0xa]
1000:37bf      80 e4 0f                 AND AH,0xf
1000:37c2      80 fc 0b                 CMP AH,0xb
1000:37c5      72 1b                    JC 0x1000:37e2
1000:37c7      f6 45 14 ff              TEST byte ptr [DI + 0x14],0xff
1000:37cb      74 15                    JZ 0x1000:37e2
1000:37cd      81 7d 08 d0 07           CMP word ptr [DI + 0x8],0x7d0
1000:37d2      72 0e                    JC 0x1000:37e2
1000:37d4      fe 4d 14                 DEC byte ptr [DI + 0x14]
1000:37d7      50                       PUSH AX
1000:37d8      b8 64 00                 MOV AX,0x64
1000:37db      e8 bd eb                 CALL 0x1000:239b
1000:37de      58                       POP AX
1000:37df      80 c4 09                 ADD AH,0x9
1000:37e2  LAB_1000_37e2:
1000:37e2      80 e4 1f                 AND AH,0x1f
1000:37e5      74 05                    JZ 0x1000:37ec
1000:37e7      24 0f                    AND AL,0xf
1000:37e9      e8 3e 00                 CALL 0x1000:382a
1000:37ec  LAB_1000_37ec:
1000:37ec      8a 45 19                 MOV AL,byte ptr [DI + 0x19]
1000:37ef      a8 ff                    TEST AL,0xff
1000:37f1      74 30                    JZ 0x1000:3823
1000:37f3      3c 04                    CMP AL,0x4
1000:37f5      73 07                    JNC 0x1000:37fe
1000:37f7      02 c0                    ADD AL,AL
1000:37f9      02 c0                    ADD AL,AL
1000:37fb      88 45 20                 MOV byte ptr [DI + 0x20],AL
1000:37fe  LAB_1000_37fe:
1000:37fe      8b 45 1f                 MOV AX,word ptr [DI + 0x1f]
1000:3801      25 0f 1f                 AND AX,0x1f0f
1000:3804      80 fc 00                 CMP AH,0x0
1000:3807      74 08                    JZ 0x1000:3811
1000:3809      57                       PUSH DI
1000:380a      83 c7 19                 ADD DI,0x19
1000:380d      e8 1a 00                 CALL 0x1000:382a
1000:3810      5f                       POP DI
1000:3811  LAB_1000_3811:
1000:3811      fe 4d 19                 DEC byte ptr [DI + 0x19]
1000:3814      8a 45 19                 MOV AL,byte ptr [DI + 0x19]
1000:3817      3c 80                    CMP AL,0x80
1000:3819      74 04                    JZ 0x1000:381f
1000:381b      3c c0                    CMP AL,0xc0
1000:381d      75 04                    JNZ 0x1000:3823
1000:381f  LAB_1000_381f:
1000:381f      c6 45 19 00              MOV byte ptr [DI + 0x19],0x0
1000:3823  LAB_1000_3823:
1000:3823      83 c7 3b                 ADD DI,0x3b
1000:3826      59                       POP CX
1000:3827      e2 8d                    LOOP 0x1000:37b6
1000:3829      c3                       RET

; ------------------------------------------------------------
1000:382a  FUN_1000_382a:
1000:382a      52                       PUSH DX
1000:382b      51                       PUSH CX
1000:382c      fe cc                    DEC AH
1000:382e      8a dc                    MOV BL,AH
1000:3830      32 ff                    XOR BH,BH
1000:3832      03 db                    ADD BX,BX
1000:3834      03 db                    ADD BX,BX
1000:3836      03 db                    ADD BX,BX
1000:3838      81 c3 7c 38              ADD BX,0x387c
1000:383c      8a d0                    MOV DL,AL
1000:383e      81 e2 03 00              AND DX,0x3
1000:3842      03 d2                    ADD DX,DX
1000:3844      03 da                    ADD BX,DX
1000:3846      8a d0                    MOV DL,AL
1000:3848      2e 8b 07                 MOV AX,word ptr CS:[BX]
1000:384b      8a cc                    MOV CL,AH
1000:384d      32 e4                    XOR AH,AH
1000:384f      32 ed                    XOR CH,CH
1000:3851      80 e2 0c                 AND DL,0xc
1000:3854      74 13                    JZ 0x1000:3869
1000:3856      91                       XCHG AX,CX
1000:3857      f7 d9                    NEG CX
1000:3859      80 fa 04                 CMP DL,0x4
1000:385c      74 0b                    JZ 0x1000:3869
1000:385e      91                       XCHG AX,CX
1000:385f      f7 d9                    NEG CX
1000:3861      80 fa 08                 CMP DL,0x8
1000:3864      74 03                    JZ 0x1000:3869
1000:3866      91                       XCHG AX,CX
1000:3867      f7 d9                    NEG CX
1000:3869  LAB_1000_3869:
1000:3869      01 45 01                 ADD word ptr [DI + 0x1],AX
1000:386c      81 65 01 ff 3f           AND word ptr [DI + 0x1],0x3fff
1000:3871      01 4d 03                 ADD word ptr [DI + 0x3],CX
1000:3874      81 65 03 ff 3f           AND word ptr [DI + 0x3],0x3fff
1000:3879      59                       POP CX
1000:387a      5a                       POP DX
1000:387b      c3                       RET

; ------------------------------------------------------------
1000:3974  FUN_1000_3974:
1000:3974      b0 00                    MOV AL,0x0
1000:3976      b4 80                    MOV AH,0x80
1000:3978      e8 16 00                 CALL 0x1000:3991
1000:397b      b0 01                    MOV AL,0x1
1000:397d      b4 40                    MOV AH,0x40
1000:397f      e8 0f 00                 CALL 0x1000:3991
1000:3982      b0 02                    MOV AL,0x2
1000:3984      b4 20                    MOV AH,0x20
1000:3986      e8 08 00                 CALL 0x1000:3991
1000:3989      b0 03                    MOV AL,0x3
1000:398b      b4 10                    MOV AH,0x10
1000:398d      e8 01 00                 CALL 0x1000:3991
1000:3990      c3                       RET

; ------------------------------------------------------------
1000:3991  FUN_1000_3991:
1000:3991      a2 74 a2                 MOV [0xa274],AL
1000:3994      b0 00                    MOV AL,0x0
1000:3996  LAB_1000_3996:
1000:3996      50                       PUSH AX
1000:3997      e8 72 f0                 CALL 0x1000:2a0c
1000:399a      58                       POP AX
1000:399b      50                       PUSH AX
1000:399c      80 7c 19 04              CMP byte ptr [SI + 0x19],0x4
1000:39a0      72 0b                    JC 0x1000:39ad
1000:39a2      80 7c 19 80              CMP byte ptr [SI + 0x19],0x80
1000:39a6      73 05                    JNC 0x1000:39ad
1000:39a8      e8 da 04                 CALL 0x1000:3e85
1000:39ab      58                       POP AX
1000:39ac      50                       PUSH AX
1000:39ad  LAB_1000_39ad:
1000:39ad      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
1000:39b0      24 1f                    AND AL,0x1f
1000:39b2      74 03                    JZ 0x1000:39b7
1000:39b4      e8 08 00                 CALL 0x1000:39bf
1000:39b7  LAB_1000_39b7:
1000:39b7      58                       POP AX
1000:39b8      fe c0                    INC AL
1000:39ba      3c 04                    CMP AL,0x4
1000:39bc      72 d8                    JC 0x1000:3996
1000:39be      c3                       RET

; ------------------------------------------------------------
1000:39bf  FUN_1000_39bf:
1000:39bf      c7 44 12 ff ff           MOV word ptr [SI + 0x12],0xffff
1000:39c4      3c 01                    CMP AL,0x1
1000:39c6      75 3b                    JNZ 0x1000:3a03
1000:39c8      e8 5a f8                 CALL 0x1000:3225
1000:39cb      bb 40 9c                 MOV BX,0x9c40
1000:39ce  LAB_1000_39ce:
1000:39ce      51                       PUSH CX
1000:39cf      50                       PUSH AX
1000:39d0      22 25                    AND AH,byte ptr [DI]
1000:39d2      75 1d                    JNZ 0x1000:39f1
1000:39d4      81 fb 40 9c              CMP BX,0x9c40
1000:39d8      75 01                    JNZ 0x1000:39db
1000:39da      4b                       DEC BX
1000:39db  LAB_1000_39db:
1000:39db      53                       PUSH BX
1000:39dc      e8 47 f0                 CALL 0x1000:2a26
1000:39df      5b                       POP BX
1000:39e0      3b c3                    CMP AX,BX
1000:39e2      77 0d                    JA 0x1000:39f1
1000:39e4      3d 0f 27                 CMP AX,0x270f
1000:39e7      77 08                    JA 0x1000:39f1
1000:39e9      89 44 12                 MOV word ptr [SI + 0x12],AX
1000:39ec      8b d8                    MOV BX,AX
1000:39ee      e8 d0 05                 CALL 0x1000:3fc1
1000:39f1  LAB_1000_39f1:
1000:39f1      58                       POP AX
1000:39f2      59                       POP CX
1000:39f3      83 c7 0b                 ADD DI,0xb
1000:39f6      e2 d6                    LOOP 0x1000:39ce
1000:39f8      81 fb 40 9c              CMP BX,0x9c40
1000:39fc      75 04                    JNZ 0x1000:3a02
1000:39fe      c6 44 11 80              MOV byte ptr [SI + 0x11],0x80
1000:3a02  LAB_1000_3a02:
1000:3a02      c3                       RET
1000:3a03  LAB_1000_3a03:
1000:3a03      3c 02                    CMP AL,0x2
1000:3a05      75 24                    JNZ 0x1000:3a2b
1000:3a07      e8 1b f8                 CALL 0x1000:3225
1000:3a0a      bb 80 3e                 MOV BX,0x3e80
1000:3a0d  LAB_1000_3a0d:
1000:3a0d      51                       PUSH CX
1000:3a0e      50                       PUSH AX
1000:3a0f      22 25                    AND AH,byte ptr [DI]
1000:3a11      74 10                    JZ 0x1000:3a23
1000:3a13      8a 05                    MOV AL,byte ptr [DI]
1000:3a15      24 0f                    AND AL,0xf
1000:3a17      3c 02                    CMP AL,0x2
1000:3a19      75 08                    JNZ 0x1000:3a23
1000:3a1b      e8 39 05                 CALL 0x1000:3f57
1000:3a1e      75 03                    JNZ 0x1000:3a23
1000:3a20      e8 47 05                 CALL 0x1000:3f6a
1000:3a23  LAB_1000_3a23:
1000:3a23      58                       POP AX
1000:3a24      59                       POP CX
1000:3a25      83 c7 0b                 ADD DI,0xb
1000:3a28      e2 e3                    LOOP 0x1000:3a0d
1000:3a2a      c3                       RET
1000:3a2b  LAB_1000_3a2b:
1000:3a2b      3c 03                    CMP AL,0x3
1000:3a2d      75 24                    JNZ 0x1000:3a53
1000:3a2f      e8 f3 f7                 CALL 0x1000:3225
1000:3a32      bb 80 3e                 MOV BX,0x3e80
1000:3a35  LAB_1000_3a35:
1000:3a35      51                       PUSH CX
1000:3a36      50                       PUSH AX
1000:3a37      22 25                    AND AH,byte ptr [DI]
1000:3a39      74 10                    JZ 0x1000:3a4b
1000:3a3b      8a 05                    MOV AL,byte ptr [DI]
1000:3a3d      24 0f                    AND AL,0xf
1000:3a3f      3c 03                    CMP AL,0x3
1000:3a41      75 08                    JNZ 0x1000:3a4b
1000:3a43      e8 11 05                 CALL 0x1000:3f57
1000:3a46      75 03                    JNZ 0x1000:3a4b
1000:3a48      e8 1f 05                 CALL 0x1000:3f6a
1000:3a4b  LAB_1000_3a4b:
1000:3a4b      58                       POP AX
1000:3a4c      59                       POP CX
1000:3a4d      83 c7 0b                 ADD DI,0xb
1000:3a50      e2 e3                    LOOP 0x1000:3a35
1000:3a52      c3                       RET
1000:3a53  LAB_1000_3a53:
1000:3a53      3c 04                    CMP AL,0x4
1000:3a55      75 4e                    JNZ 0x1000:3aa5
1000:3a57      50                       PUSH AX
1000:3a58      e8 73 e4                 CALL 0x1000:1ece
                ; ptr table -> 1000:3a63  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
1000:3a63  LAB_1000_3a63:
1000:3a63      58                       POP AX
1000:3a64      83 7f 08 00              CMP word ptr [BX + 0x8],0x0
1000:3a68      75 05                    JNZ 0x1000:3a6f
1000:3a6a      c6 44 11 80              MOV byte ptr [SI + 0x11],0x80
1000:3a6e      c3                       RET
1000:3a6f  LAB_1000_3a6f:
1000:3a6f      50                       PUSH AX
1000:3a70      8b fb                    MOV DI,BX
1000:3a72      e8 b1 ef                 CALL 0x1000:2a26
1000:3a75      89 44 12                 MOV word ptr [SI + 0x12],AX
1000:3a78      8b d8                    MOV BX,AX
1000:3a7a      81 fb 80 3e              CMP BX,0x3e80
1000:3a7e      77 03                    JA 0x1000:3a83
1000:3a80      e8 3e 05                 CALL 0x1000:3fc1
1000:3a83  LAB_1000_3a83:
1000:3a83      e8 9f f7                 CALL 0x1000:3225
1000:3a86      58                       POP AX
1000:3a87  LAB_1000_3a87:
1000:3a87      51                       PUSH CX
1000:3a88      50                       PUSH AX
1000:3a89      22 25                    AND AH,byte ptr [DI]
1000:3a8b      74 10                    JZ 0x1000:3a9d
1000:3a8d      8a 05                    MOV AL,byte ptr [DI]
1000:3a8f      24 0f                    AND AL,0xf
1000:3a91      3c 04                    CMP AL,0x4
1000:3a93      75 08                    JNZ 0x1000:3a9d
1000:3a95      e8 bf 04                 CALL 0x1000:3f57
1000:3a98      75 03                    JNZ 0x1000:3a9d
1000:3a9a      e8 cd 04                 CALL 0x1000:3f6a
1000:3a9d  LAB_1000_3a9d:
1000:3a9d      58                       POP AX
1000:3a9e      59                       POP CX
1000:3a9f      83 c7 0b                 ADD DI,0xb
1000:3aa2      e2 e3                    LOOP 0x1000:3a87
1000:3aa4      c3                       RET
1000:3aa5  LAB_1000_3aa5:
1000:3aa5      3c 05                    CMP AL,0x5
1000:3aa7      75 24                    JNZ 0x1000:3acd
1000:3aa9      e8 79 f7                 CALL 0x1000:3225
1000:3aac      bb 80 3e                 MOV BX,0x3e80
1000:3aaf  LAB_1000_3aaf:
1000:3aaf      51                       PUSH CX
1000:3ab0      50                       PUSH AX
1000:3ab1      22 25                    AND AH,byte ptr [DI]
1000:3ab3      74 10                    JZ 0x1000:3ac5
1000:3ab5      8a 05                    MOV AL,byte ptr [DI]
1000:3ab7      24 0f                    AND AL,0xf
1000:3ab9      3c 01                    CMP AL,0x1
1000:3abb      75 08                    JNZ 0x1000:3ac5
1000:3abd      e8 97 04                 CALL 0x1000:3f57
1000:3ac0      75 03                    JNZ 0x1000:3ac5
1000:3ac2      e8 a5 04                 CALL 0x1000:3f6a
1000:3ac5  LAB_1000_3ac5:
1000:3ac5      58                       POP AX
1000:3ac6      59                       POP CX
1000:3ac7      83 c7 0b                 ADD DI,0xb
1000:3aca      e2 e3                    LOOP 0x1000:3aaf
1000:3acc      c3                       RET
1000:3acd  LAB_1000_3acd:
1000:3acd      3c 06                    CMP AL,0x6
1000:3acf      75 68                    JNZ 0x1000:3b39
1000:3ad1      bf 14 90                 MOV DI,0x9014
1000:3ad4      b9 04 00                 MOV CX,0x4
1000:3ad7      bb 80 3e                 MOV BX,0x3e80
1000:3ada      80 64 11 3f              AND byte ptr [SI + 0x11],0x3f
1000:3ade  LAB_1000_3ade:
1000:3ade      8a 44 18                 MOV AL,byte ptr [SI + 0x18]
1000:3ae1      38 45 0c                 CMP byte ptr [DI + 0xc],AL
1000:3ae4      74 4d                    JZ 0x1000:3b33
1000:3ae6      83 7d 08 00              CMP word ptr [DI + 0x8],0x0
1000:3aea      74 47                    JZ 0x1000:3b33
1000:3aec      8a 44 2b                 MOV AL,byte ptr [SI + 0x2b]
1000:3aef      3a 44 17                 CMP AL,byte ptr [SI + 0x17]
1000:3af2      74 05                    JZ 0x1000:3af9
1000:3af4      3a 45 0b                 CMP AL,byte ptr [DI + 0xb]
1000:3af7      75 3a                    JNZ 0x1000:3b33
1000:3af9  LAB_1000_3af9:
1000:3af9      51                       PUSH CX
1000:3afa      53                       PUSH BX
1000:3afb      e8 28 ef                 CALL 0x1000:2a26
1000:3afe      5b                       POP BX
1000:3aff      3b c3                    CMP AX,BX
1000:3b01      77 2f                    JA 0x1000:3b32
1000:3b03      89 44 12                 MOV word ptr [SI + 0x12],AX
1000:3b06      8b d8                    MOV BX,AX
1000:3b08      e8 1f 03                 CALL 0x1000:3e2a
1000:3b0b      3d 84 03                 CMP AX,0x384
1000:3b0e      77 1c                    JA 0x1000:3b2c
1000:3b10      80 4c 11 c0              OR byte ptr [SI + 0x11],0xc0
1000:3b14      3d bc 02                 CMP AX,0x2bc
1000:3b17      77 13                    JA 0x1000:3b2c
1000:3b19      80 c5 04                 ADD CH,0x4
1000:3b1c      3d f4 01                 CMP AX,0x1f4
1000:3b1f      77 0b                    JA 0x1000:3b2c
1000:3b21      80 c5 02                 ADD CH,0x2
1000:3b24      3d db 01                 CMP AX,0x1db
1000:3b27      77 03                    JA 0x1000:3b2c
1000:3b29      80 c5 01                 ADD CH,0x1
1000:3b2c  LAB_1000_3b2c:
1000:3b2c      80 e5 0f                 AND CH,0xf
1000:3b2f      e8 8f 04                 CALL 0x1000:3fc1
1000:3b32  LAB_1000_3b32:
1000:3b32      59                       POP CX
1000:3b33  LAB_1000_3b33:
1000:3b33      83 c7 0e                 ADD DI,0xe
1000:3b36      e2 a6                    LOOP 0x1000:3ade
1000:3b38      c3                       RET
1000:3b39  LAB_1000_3b39:
1000:3b39      3c 07                    CMP AL,0x7
1000:3b3b      74 03                    JZ 0x1000:3b40
1000:3b3d      e9 94 00                 JMP 0x1000:3bd4
1000:3b40  LAB_1000_3b40:
1000:3b40      bf 64 8c                 MOV DI,0x8c64
1000:3b43      b9 10 00                 MOV CX,0x10
1000:3b46      bb 4c 1d                 MOV BX,0x1d4c
1000:3b49      80 64 11 3f              AND byte ptr [SI + 0x11],0x3f
1000:3b4d  LAB_1000_3b4d:
1000:3b4d      8a 44 18                 MOV AL,byte ptr [SI + 0x18]
1000:3b50      38 45 18                 CMP byte ptr [DI + 0x18],AL
1000:3b53      74 75                    JZ 0x1000:3bca
1000:3b55      f6 05 80                 TEST byte ptr [DI],0x80
1000:3b58      74 70                    JZ 0x1000:3bca
1000:3b5a      f6 05 44                 TEST byte ptr [DI],0x44
1000:3b5d      75 6b                    JNZ 0x1000:3bca
1000:3b5f      81 7c 08 40 9c           CMP word ptr [SI + 0x8],0x9c40
1000:3b64      77 0b                    JA 0x1000:3b71
1000:3b66      f6 05 10                 TEST byte ptr [DI],0x10
1000:3b69      74 06                    JZ 0x1000:3b71
1000:3b6b      f6 45 19 f0              TEST byte ptr [DI + 0x19],0xf0
1000:3b6f      74 59                    JZ 0x1000:3bca
1000:3b71  LAB_1000_3b71:
1000:3b71      8a 44 2b                 MOV AL,byte ptr [SI + 0x2b]
1000:3b74      3a 44 17                 CMP AL,byte ptr [SI + 0x17]
1000:3b77      74 05                    JZ 0x1000:3b7e
1000:3b79      3a 45 17                 CMP AL,byte ptr [DI + 0x17]
1000:3b7c      75 4c                    JNZ 0x1000:3bca
1000:3b7e  LAB_1000_3b7e:
1000:3b7e      51                       PUSH CX
1000:3b7f      53                       PUSH BX
1000:3b80      e8 a3 ee                 CALL 0x1000:2a26
1000:3b83      5b                       POP BX
1000:3b84      3b c3                    CMP AX,BX
1000:3b86      77 41                    JA 0x1000:3bc9
1000:3b88      89 44 12                 MOV word ptr [SI + 0x12],AX
1000:3b8b      8b d8                    MOV BX,AX
1000:3b8d      3d 84 03                 CMP AX,0x384
1000:3b90      77 31                    JA 0x1000:3bc3
1000:3b92      80 4c 11 c0              OR byte ptr [SI + 0x11],0xc0
1000:3b96      3d 90 01                 CMP AX,0x190
1000:3b99      77 28                    JA 0x1000:3bc3
1000:3b9b      8a 4c 0b                 MOV CL,byte ptr [SI + 0xb]
1000:3b9e      d0 e9                    SHR CL,0x1
1000:3ba0      d0 e9                    SHR CL,0x1
1000:3ba2      d0 e9                    SHR CL,0x1
1000:3ba4      d0 e9                    SHR CL,0x1
1000:3ba6  LAB_1000_3ba6:
1000:3ba6      80 e1 0f                 AND CL,0xf
1000:3ba9      74 0a                    JZ 0x1000:3bb5
1000:3bab      fe c9                    DEC CL
1000:3bad      05 32 00                 ADD AX,0x32
1000:3bb0      3d 90 01                 CMP AX,0x190
1000:3bb3      72 f1                    JC 0x1000:3ba6
1000:3bb5  LAB_1000_3bb5:
1000:3bb5      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
1000:3bb8      3a c1                    CMP AL,CL
1000:3bba      72 07                    JC 0x1000:3bc3
1000:3bbc      80 64 0b f0              AND byte ptr [SI + 0xb],0xf0
1000:3bc0      08 4c 0b                 OR byte ptr [SI + 0xb],CL
1000:3bc3  LAB_1000_3bc3:
1000:3bc3      80 e5 0f                 AND CH,0xf
1000:3bc6      e8 f8 03                 CALL 0x1000:3fc1
1000:3bc9  LAB_1000_3bc9:
1000:3bc9      59                       POP CX
1000:3bca  LAB_1000_3bca:
1000:3bca      83 c7 3b                 ADD DI,0x3b
1000:3bcd      49                       DEC CX
1000:3bce      74 03                    JZ 0x1000:3bd3
1000:3bd0      e9 7a ff                 JMP 0x1000:3b4d
1000:3bd3  LAB_1000_3bd3:
1000:3bd3      c3                       RET
1000:3bd4  LAB_1000_3bd4:
1000:3bd4      3c 08                    CMP AL,0x8
1000:3bd6      75 4f                    JNZ 0x1000:3c27
1000:3bd8      bf 64 8c                 MOV DI,0x8c64
1000:3bdb      b9 10 00                 MOV CX,0x10
1000:3bde      bb 70 17                 MOV BX,0x1770
1000:3be1  LAB_1000_3be1:
1000:3be1      8a 44 18                 MOV AL,byte ptr [SI + 0x18]
1000:3be4      38 45 18                 CMP byte ptr [DI + 0x18],AL
1000:3be7      74 38                    JZ 0x1000:3c21
1000:3be9      f6 05 80                 TEST byte ptr [DI],0x80
1000:3bec      74 33                    JZ 0x1000:3c21
1000:3bee      51                       PUSH CX
1000:3bef      81 7c 08 40 9c           CMP word ptr [SI + 0x8],0x9c40
1000:3bf4      77 0b                    JA 0x1000:3c01
1000:3bf6      f6 45 19 f0              TEST byte ptr [DI + 0x19],0xf0
1000:3bfa      75 05                    JNZ 0x1000:3c01
1000:3bfc      f6 05 10                 TEST byte ptr [DI],0x10
1000:3bff      75 1f                    JNZ 0x1000:3c20
1000:3c01  LAB_1000_3c01:
1000:3c01      53                       PUSH BX
1000:3c02      e8 21 ee                 CALL 0x1000:2a26
1000:3c05      5b                       POP BX
1000:3c06      3b c3                    CMP AX,BX
1000:3c08      77 16                    JA 0x1000:3c20
1000:3c0a      89 44 12                 MOV word ptr [SI + 0x12],AX
1000:3c0d      8b d8                    MOV BX,AX
1000:3c0f      8b 44 01                 MOV AX,word ptr [SI + 0x1]
1000:3c12      8a c4                    MOV AL,AH
1000:3c14      24 07                    AND AL,0x7
1000:3c16      04 04                    ADD AL,0x4
1000:3c18      02 e8                    ADD CH,AL
1000:3c1a      80 e5 0f                 AND CH,0xf
1000:3c1d      e8 a1 03                 CALL 0x1000:3fc1
1000:3c20  LAB_1000_3c20:
1000:3c20      59                       POP CX
1000:3c21  LAB_1000_3c21:
1000:3c21      83 c7 3b                 ADD DI,0x3b
1000:3c24      e2 bb                    LOOP 0x1000:3be1
1000:3c26      c3                       RET
1000:3c27  LAB_1000_3c27:
1000:3c27      3c 09                    CMP AL,0x9
1000:3c29      75 24                    JNZ 0x1000:3c4f
1000:3c2b      e8 f7 f5                 CALL 0x1000:3225
1000:3c2e      bb 80 3e                 MOV BX,0x3e80
1000:3c31  LAB_1000_3c31:
1000:3c31      51                       PUSH CX
1000:3c32      50                       PUSH AX
1000:3c33      22 25                    AND AH,byte ptr [DI]
1000:3c35      74 10                    JZ 0x1000:3c47
1000:3c37      8a 05                    MOV AL,byte ptr [DI]
1000:3c39      24 0f                    AND AL,0xf
1000:3c3b      3c 05                    CMP AL,0x5
1000:3c3d      75 08                    JNZ 0x1000:3c47
1000:3c3f      e8 15 03                 CALL 0x1000:3f57
1000:3c42      75 03                    JNZ 0x1000:3c47
1000:3c44      e8 23 03                 CALL 0x1000:3f6a
1000:3c47  LAB_1000_3c47:
1000:3c47      58                       POP AX
1000:3c48      59                       POP CX
1000:3c49      83 c7 0b                 ADD DI,0xb
1000:3c4c      e2 e3                    LOOP 0x1000:3c31
1000:3c4e      c3                       RET
1000:3c4f  LAB_1000_3c4f:
1000:3c4f      3c 0a                    CMP AL,0xa
1000:3c51      75 24                    JNZ 0x1000:3c77
1000:3c53      e8 cf f5                 CALL 0x1000:3225
1000:3c56      bb 80 3e                 MOV BX,0x3e80
1000:3c59  LAB_1000_3c59:
1000:3c59      51                       PUSH CX
1000:3c5a      50                       PUSH AX
1000:3c5b      22 25                    AND AH,byte ptr [DI]
1000:3c5d      74 10                    JZ 0x1000:3c6f
1000:3c5f      8a 05                    MOV AL,byte ptr [DI]
1000:3c61      24 0f                    AND AL,0xf
1000:3c63      3c 06                    CMP AL,0x6
1000:3c65      75 08                    JNZ 0x1000:3c6f
1000:3c67      e8 ed 02                 CALL 0x1000:3f57
1000:3c6a      75 03                    JNZ 0x1000:3c6f
1000:3c6c      e8 fb 02                 CALL 0x1000:3f6a
1000:3c6f  LAB_1000_3c6f:
1000:3c6f      58                       POP AX
1000:3c70      59                       POP CX
1000:3c71      83 c7 0b                 ADD DI,0xb
1000:3c74      e2 e3                    LOOP 0x1000:3c59
1000:3c76      c3                       RET
1000:3c77  LAB_1000_3c77:
1000:3c77      3c 0b                    CMP AL,0xb
1000:3c79      75 2b                    JNZ 0x1000:3ca6
1000:3c7b      e8 a7 f5                 CALL 0x1000:3225
1000:3c7e      bb 20 4e                 MOV BX,0x4e20
1000:3c81      81 7c 08 b8 0b           CMP word ptr [SI + 0x8],0xbb8
1000:3c86      77 1d                    JA 0x1000:3ca5
1000:3c88  LAB_1000_3c88:
1000:3c88      51                       PUSH CX
1000:3c89      50                       PUSH AX
1000:3c8a      22 25                    AND AH,byte ptr [DI]
1000:3c8c      74 10                    JZ 0x1000:3c9e
1000:3c8e      8a 05                    MOV AL,byte ptr [DI]
1000:3c90      24 0f                    AND AL,0xf
1000:3c92      3c 07                    CMP AL,0x7
1000:3c94      75 08                    JNZ 0x1000:3c9e
1000:3c96      e8 be 02                 CALL 0x1000:3f57
1000:3c99      75 03                    JNZ 0x1000:3c9e
1000:3c9b      e8 cc 02                 CALL 0x1000:3f6a
1000:3c9e  LAB_1000_3c9e:
1000:3c9e      58                       POP AX
1000:3c9f      59                       POP CX
1000:3ca0      83 c7 0b                 ADD DI,0xb
1000:3ca3      e2 e3                    LOOP 0x1000:3c88
1000:3ca5  LAB_1000_3ca5:
1000:3ca5      c3                       RET
1000:3ca6  LAB_1000_3ca6:
1000:3ca6      3c 0c                    CMP AL,0xc
1000:3ca8      75 53                    JNZ 0x1000:3cfd
1000:3caa      bb 80 3e                 MOV BX,0x3e80
1000:3cad      e8 75 f5                 CALL 0x1000:3225
1000:3cb0  LAB_1000_3cb0:
1000:3cb0      51                       PUSH CX
1000:3cb1      50                       PUSH AX
1000:3cb2      22 25                    AND AH,byte ptr [DI]
1000:3cb4      74 3f                    JZ 0x1000:3cf5
1000:3cb6      e8 9e 02                 CALL 0x1000:3f57
1000:3cb9      75 3a                    JNZ 0x1000:3cf5
1000:3cbb      8a 05                    MOV AL,byte ptr [DI]
1000:3cbd      24 0f                    AND AL,0xf
1000:3cbf      2c 0a                    SUB AL,0xa
1000:3cc1      72 32                    JC 0x1000:3cf5
1000:3cc3      3c 03                    CMP AL,0x3
1000:3cc5      77 2e                    JA 0x1000:3cf5
1000:3cc7      50                       PUSH AX
1000:3cc8      8a 44 2b                 MOV AL,byte ptr [SI + 0x2b]
1000:3ccb      3a 44 17                 CMP AL,byte ptr [SI + 0x17]
1000:3cce      58                       POP AX
1000:3ccf      74 05                    JZ 0x1000:3cd6
1000:3cd1      3a 44 2b                 CMP AL,byte ptr [SI + 0x2b]
1000:3cd4      75 1f                    JNZ 0x1000:3cf5
1000:3cd6  LAB_1000_3cd6:
1000:3cd6      86 06 74 a2              XCHG byte ptr [0xa274],AL
1000:3cda      50                       PUSH AX
1000:3cdb      53                       PUSH BX
1000:3cdc      e8 ef e1                 CALL 0x1000:1ece
                ; ptr table -> 1000:3ce7  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
1000:3ce7  LAB_1000_3ce7:
1000:3ce7      83 7f 08 00              CMP word ptr [BX + 0x8],0x0
1000:3ceb      5b                       POP BX
1000:3cec      58                       POP AX
1000:3ced      a2 74 a2                 MOV [0xa274],AL
1000:3cf0      74 03                    JZ 0x1000:3cf5
1000:3cf2      e8 75 02                 CALL 0x1000:3f6a
1000:3cf5  LAB_1000_3cf5:
1000:3cf5      58                       POP AX
1000:3cf6      59                       POP CX
1000:3cf7      83 c7 0b                 ADD DI,0xb
1000:3cfa      e2 b4                    LOOP 0x1000:3cb0
1000:3cfc      c3                       RET
1000:3cfd  LAB_1000_3cfd:
1000:3cfd      3c 0d                    CMP AL,0xd
1000:3cff      75 23                    JNZ 0x1000:3d24
1000:3d01      8b fe                    MOV DI,SI
1000:3d03      83 c7 2c                 ADD DI,0x2c
1000:3d06      e8 1d ed                 CALL 0x1000:2a26
1000:3d09      83 fb f0                 CMP BX,-0x10
1000:3d0c      77 11                    JA 0x1000:3d1f
1000:3d0e      89 44 12                 MOV word ptr [SI + 0x12],AX
1000:3d11      8b d8                    MOV BX,AX
1000:3d13      e8 ab 02                 CALL 0x1000:3fc1
1000:3d16      83 fb 28                 CMP BX,0x28
1000:3d19      77 08                    JA 0x1000:3d23
1000:3d1b      c6 44 0b 00              MOV byte ptr [SI + 0xb],0x0
1000:3d1f  LAB_1000_3d1f:
1000:3d1f      c6 44 11 80              MOV byte ptr [SI + 0x11],0x80
1000:3d23  LAB_1000_3d23:
1000:3d23      c3                       RET
1000:3d24  LAB_1000_3d24:
1000:3d24      3c 0e                    CMP AL,0xe
1000:3d26      75 24                    JNZ 0x1000:3d4c
1000:3d28      e8 fa f4                 CALL 0x1000:3225
1000:3d2b      bb 20 4e                 MOV BX,0x4e20
1000:3d2e  LAB_1000_3d2e:
1000:3d2e      51                       PUSH CX
1000:3d2f      50                       PUSH AX
1000:3d30      22 25                    AND AH,byte ptr [DI]
1000:3d32      74 10                    JZ 0x1000:3d44
1000:3d34      8a 05                    MOV AL,byte ptr [DI]
1000:3d36      24 0f                    AND AL,0xf
1000:3d38      3c 0e                    CMP AL,0xe
1000:3d3a      75 08                    JNZ 0x1000:3d44
1000:3d3c      e8 18 02                 CALL 0x1000:3f57
1000:3d3f      75 03                    JNZ 0x1000:3d44
1000:3d41      e8 26 02                 CALL 0x1000:3f6a
1000:3d44  LAB_1000_3d44:
1000:3d44      58                       POP AX
1000:3d45      59                       POP CX
1000:3d46      83 c7 0b                 ADD DI,0xb
1000:3d49      e2 e3                    LOOP 0x1000:3d2e
1000:3d4b      c3                       RET
1000:3d4c  LAB_1000_3d4c:
1000:3d4c      a8 10                    TEST AL,0x10
1000:3d4e      75 01                    JNZ 0x1000:3d51
1000:3d50      c3                       RET
1000:3d51  LAB_1000_3d51:
1000:3d51      e8 7a e1                 CALL 0x1000:1ece
                ; ptr table -> 1000:3d5c  [ptr] 1000:8c64 1000:8d50 1000:8e3c 1000:8f28
1000:3d5c  LAB_1000_3d5c:
1000:3d5c      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
1000:3d5f      24 03                    AND AL,0x3
1000:3d61      74 07                    JZ 0x1000:3d6a
1000:3d63  LAB_1000_3d63:
1000:3d63      83 c3 3b                 ADD BX,0x3b
1000:3d66      fe c8                    DEC AL
1000:3d68      75 f9                    JNZ 0x1000:3d63
1000:3d6a  LAB_1000_3d6a:
1000:3d6a      8b fb                    MOV DI,BX
1000:3d6c      f6 05 80                 TEST byte ptr [DI],0x80
1000:3d6f      75 05                    JNZ 0x1000:3d76
1000:3d71      c6 44 11 80              MOV byte ptr [SI + 0x11],0x80
1000:3d75      c3                       RET
1000:3d76  LAB_1000_3d76:
1000:3d76      e8 ad ec                 CALL 0x1000:2a26
1000:3d79      89 44 12                 MOV word ptr [SI + 0x12],AX
1000:3d7c      8b d8                    MOV BX,AX
1000:3d7e      e8 40 02                 CALL 0x1000:3fc1
1000:3d81      81 fb fa 00              CMP BX,0xfa
1000:3d85      76 01                    JBE 0x1000:3d88
1000:3d87      c3                       RET
1000:3d88  LAB_1000_3d88:
1000:3d88      b1 04                    MOV CL,0x4
1000:3d8a      c6 44 34 01              MOV byte ptr [SI + 0x34],0x1
1000:3d8e      c6 45 34 01              MOV byte ptr [DI + 0x34],0x1
1000:3d92      56                       PUSH SI
1000:3d93      57                       PUSH DI
1000:3d94      87 f7                    XCHG DI,SI
1000:3d96      8b 44 01                 MOV AX,word ptr [SI + 0x1]
1000:3d99      89 45 01                 MOV word ptr [DI + 0x1],AX
1000:3d9c      8b 44 03                 MOV AX,word ptr [SI + 0x3]
1000:3d9f      89 45 03                 MOV word ptr [DI + 0x3],AX
1000:3da2      8a 44 14                 MOV AL,byte ptr [SI + 0x14]
1000:3da5      88 45 14                 MOV byte ptr [DI + 0x14],AL
1000:3da8      8b 44 0a                 MOV AX,word ptr [SI + 0xa]
1000:3dab      89 45 0a                 MOV word ptr [DI + 0xa],AX
1000:3dae      8b de                    MOV BX,SI
1000:3db0      83 7f 32 00              CMP word ptr [BX + 0x32],0x0
1000:3db4      74 12                    JZ 0x1000:3dc8
1000:3db6      8b 5f 32                 MOV BX,word ptr [BX + 0x32]
1000:3db9      80 c1 08                 ADD CL,0x8
1000:3dbc      83 7f 32 00              CMP word ptr [BX + 0x32],0x0
1000:3dc0      74 06                    JZ 0x1000:3dc8
1000:3dc2      8b 5f 32                 MOV BX,word ptr [BX + 0x32]
1000:3dc5      80 e9 04                 SUB CL,0x4
1000:3dc8  LAB_1000_3dc8:
1000:3dc8      89 7f 32                 MOV word ptr [BX + 0x32],DI
1000:3dcb      c7 45 32 00 00           MOV word ptr [DI + 0x32],0x0
1000:3dd0      02 c1                    ADD AL,CL
1000:3dd2      b4 0b                    MOV AH,0xb
1000:3dd4      e8 53 fa                 CALL 0x1000:382a
1000:3dd7      8b 44 08                 MOV AX,word ptr [SI + 0x8]
1000:3dda      3b 45 08                 CMP AX,word ptr [DI + 0x8]
1000:3ddd      77 02                    JA 0x1000:3de1
1000:3ddf      87 f7                    XCHG DI,SI
1000:3de1  LAB_1000_3de1:
1000:3de1      8b 44 08                 MOV AX,word ptr [SI + 0x8]
1000:3de4      2b 45 08                 SUB AX,word ptr [DI + 0x8]
1000:3de7      d1 e8                    SHR AX,0x1
1000:3de9      d1 e8                    SHR AX,0x1
1000:3deb      d1 e8                    SHR AX,0x1
1000:3ded      d1 e8                    SHR AX,0x1
1000:3def      29 44 08                 SUB word ptr [SI + 0x8],AX
1000:3df2      01 45 08                 ADD word ptr [DI + 0x8],AX
1000:3df5      8a 44 07                 MOV AL,byte ptr [SI + 0x7]
1000:3df8      3a 45 07                 CMP AL,byte ptr [DI + 0x7]
1000:3dfb      77 02                    JA 0x1000:3dff
1000:3dfd      87 f7                    XCHG DI,SI
1000:3dff  LAB_1000_3dff:
1000:3dff      8a 44 07                 MOV AL,byte ptr [SI + 0x7]
1000:3e02      2a 45 07                 SUB AL,byte ptr [DI + 0x7]
1000:3e05      3c 02                    CMP AL,0x2
1000:3e07      72 06                    JC 0x1000:3e0f
1000:3e09      fe 4c 07                 DEC byte ptr [SI + 0x7]
1000:3e0c      fe 45 07                 INC byte ptr [DI + 0x7]
1000:3e0f  LAB_1000_3e0f:
1000:3e0f      8a 44 0f                 MOV AL,byte ptr [SI + 0xf]
1000:3e12      3a 45 0f                 CMP AL,byte ptr [DI + 0xf]
1000:3e15      77 02                    JA 0x1000:3e19
1000:3e17      87 f7                    XCHG DI,SI
1000:3e19  LAB_1000_3e19:
1000:3e19      8a 44 0f                 MOV AL,byte ptr [SI + 0xf]
1000:3e1c      2a 45 0f                 SUB AL,byte ptr [DI + 0xf]
1000:3e1f      d0 e8                    SHR AL,0x1
1000:3e21      28 44 0f                 SUB byte ptr [SI + 0xf],AL
1000:3e24      00 45 0f                 ADD byte ptr [DI + 0xf],AL
1000:3e27      5f                       POP DI
1000:3e28      5e                       POP SI
1000:3e29      c3                       RET

; ------------------------------------------------------------
1000:3e2a  FUN_1000_3e2a:
1000:3e2a      81 7c 08 a8 61           CMP word ptr [SI + 0x8],0x61a8
1000:3e2f      77 53                    JA 0x1000:3e84
1000:3e31      3d 2c 01                 CMP AX,0x12c
1000:3e34      72 4e                    JC 0x1000:3e84
1000:3e36      2d 2c 01                 SUB AX,0x12c
1000:3e39      81 7c 08 20 4e           CMP word ptr [SI + 0x8],0x4e20
1000:3e3e      77 44                    JA 0x1000:3e84
1000:3e40      3d 2c 01                 CMP AX,0x12c
1000:3e43      72 3f                    JC 0x1000:3e84
1000:3e45      2d 2c 01                 SUB AX,0x12c
1000:3e48      81 7c 08 98 3a           CMP word ptr [SI + 0x8],0x3a98
1000:3e4d      77 35                    JA 0x1000:3e84
1000:3e4f      3d 2c 01                 CMP AX,0x12c
1000:3e52      72 30                    JC 0x1000:3e84
1000:3e54      2d 2c 01                 SUB AX,0x12c
1000:3e57      81 7c 08 10 27           CMP word ptr [SI + 0x8],0x2710
1000:3e5c      77 26                    JA 0x1000:3e84
1000:3e5e      3d 2c 01                 CMP AX,0x12c
1000:3e61      72 21                    JC 0x1000:3e84
1000:3e63      2d 2c 01                 SUB AX,0x12c
1000:3e66      81 7c 08 4c 1d           CMP word ptr [SI + 0x8],0x1d4c
1000:3e6b      77 17                    JA 0x1000:3e84
1000:3e6d      3d 2c 01                 CMP AX,0x12c
1000:3e70      72 12                    JC 0x1000:3e84
1000:3e72      2d 2c 01                 SUB AX,0x12c
1000:3e75      81 7c 08 a0 0f           CMP word ptr [SI + 0x8],0xfa0
1000:3e7a      77 08                    JA 0x1000:3e84
1000:3e7c      3d 2c 01                 CMP AX,0x12c
1000:3e7f      72 03                    JC 0x1000:3e84
1000:3e81      2d 2c 01                 SUB AX,0x12c
1000:3e84  LAB_1000_3e84:
1000:3e84      c3                       RET

; ------------------------------------------------------------
1000:3e85  FUN_1000_3e85:
1000:3e85      8a 44 1f                 MOV AL,byte ptr [SI + 0x1f]
1000:3e88      a2 81 a2                 MOV [0xa281],AL
1000:3e8b      b9 04 00                 MOV CX,0x4
1000:3e8e      bf 14 90                 MOV DI,0x9014
1000:3e91      56                       PUSH SI
1000:3e92      bb b8 0b                 MOV BX,0xbb8
1000:3e95  LAB_1000_3e95:
1000:3e95      83 7d 08 00              CMP word ptr [DI + 0x8],0x0
1000:3e99      74 2b                    JZ 0x1000:3ec6
1000:3e9b      8a 44 18                 MOV AL,byte ptr [SI + 0x18]
1000:3e9e      38 45 0c                 CMP byte ptr [DI + 0xc],AL
1000:3ea1      74 23                    JZ 0x1000:3ec6
1000:3ea3      8a 44 2b                 MOV AL,byte ptr [SI + 0x2b]
1000:3ea6      3a 44 17                 CMP AL,byte ptr [SI + 0x17]
1000:3ea9      74 05                    JZ 0x1000:3eb0
1000:3eab      3a 45 0b                 CMP AL,byte ptr [DI + 0xb]
1000:3eae      75 16                    JNZ 0x1000:3ec6
1000:3eb0  LAB_1000_3eb0:
1000:3eb0      51                       PUSH CX
1000:3eb1      56                       PUSH SI
1000:3eb2      83 c6 19                 ADD SI,0x19
1000:3eb5      53                       PUSH BX
1000:3eb6      e8 6d eb                 CALL 0x1000:2a26
1000:3eb9      5b                       POP BX
1000:3eba      5e                       POP SI
1000:3ebb      3b c3                    CMP AX,BX
1000:3ebd      77 06                    JA 0x1000:3ec5
1000:3ebf      8b d8                    MOV BX,AX
1000:3ec1      88 2e 81 a2              MOV byte ptr [0xa281],CH
1000:3ec5  LAB_1000_3ec5:
1000:3ec5      59                       POP CX
1000:3ec6  LAB_1000_3ec6:
1000:3ec6      83 c7 0e                 ADD DI,0xe
1000:3ec9      e2 ca                    LOOP 0x1000:3e95
1000:3ecb      5e                       POP SI
1000:3ecc      bf 64 8c                 MOV DI,0x8c64
1000:3ecf      b9 10 00                 MOV CX,0x10
1000:3ed2  LAB_1000_3ed2:
1000:3ed2      8a 44 18                 MOV AL,byte ptr [SI + 0x18]
1000:3ed5      38 45 18                 CMP byte ptr [DI + 0x18],AL
1000:3ed8      74 34                    JZ 0x1000:3f0e
1000:3eda      f6 05 80                 TEST byte ptr [DI],0x80
1000:3edd      74 2f                    JZ 0x1000:3f0e
1000:3edf      f6 05 10                 TEST byte ptr [DI],0x10
1000:3ee2      74 07                    JZ 0x1000:3eeb
1000:3ee4      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
1000:3ee9      75 23                    JNZ 0x1000:3f0e
1000:3eeb  LAB_1000_3eeb:
1000:3eeb      8a 44 2b                 MOV AL,byte ptr [SI + 0x2b]
1000:3eee      3a 44 17                 CMP AL,byte ptr [SI + 0x17]
1000:3ef1      74 05                    JZ 0x1000:3ef8
1000:3ef3      3a 45 17                 CMP AL,byte ptr [DI + 0x17]
1000:3ef6      75 16                    JNZ 0x1000:3f0e
1000:3ef8  LAB_1000_3ef8:
1000:3ef8      51                       PUSH CX
1000:3ef9      56                       PUSH SI
1000:3efa      83 c6 19                 ADD SI,0x19
1000:3efd      53                       PUSH BX
1000:3efe      e8 25 eb                 CALL 0x1000:2a26
1000:3f01      5b                       POP BX
1000:3f02      5e                       POP SI
1000:3f03      3b c3                    CMP AX,BX
1000:3f05      77 06                    JA 0x1000:3f0d
1000:3f07      8b d8                    MOV BX,AX
1000:3f09      88 2e 81 a2              MOV byte ptr [0xa281],CH
1000:3f0d  LAB_1000_3f0d:
1000:3f0d      59                       POP CX
1000:3f0e  LAB_1000_3f0e:
1000:3f0e      83 c7 3b                 ADD DI,0x3b
1000:3f11      e2 bf                    LOOP 0x1000:3ed2
1000:3f13      f6 44 19 44              TEST byte ptr [SI + 0x19],0x44
1000:3f17      74 04                    JZ 0x1000:3f1d
1000:3f19      d1 eb                    SHR BX,0x1
1000:3f1b      d1 eb                    SHR BX,0x1
1000:3f1d  LAB_1000_3f1d:
1000:3f1d      8a 2e 81 a2              MOV CH,byte ptr [0xa281]
1000:3f21      8a 4c 1f                 MOV CL,byte ptr [SI + 0x1f]
1000:3f24      81 fb 90 01              CMP BX,0x190
1000:3f28      77 02                    JA 0x1000:3f2c
1000:3f2a      8a cd                    MOV CL,CH
1000:3f2c  LAB_1000_3f2c:
1000:3f2c      80 e1 0f                 AND CL,0xf
1000:3f2f      2a e9                    SUB CH,CL
1000:3f31      74 1d                    JZ 0x1000:3f50
1000:3f33      79 03                    JNS 0x1000:3f38
1000:3f35      80 c5 10                 ADD CH,0x10
1000:3f38  LAB_1000_3f38:
1000:3f38      fe c1                    INC CL
1000:3f3a      80 fd 04                 CMP CH,0x4
1000:3f3d      76 11                    JBE 0x1000:3f50
1000:3f3f      fe c1                    INC CL
1000:3f41      80 fd 08                 CMP CH,0x8
1000:3f44      76 0a                    JBE 0x1000:3f50
1000:3f46      80 e9 04                 SUB CL,0x4
1000:3f49      80 fd 0b                 CMP CH,0xb
1000:3f4c      76 02                    JBE 0x1000:3f50
1000:3f4e      fe c1                    INC CL
1000:3f50  LAB_1000_3f50:
1000:3f50      80 e1 0f                 AND CL,0xf
1000:3f53      88 4c 1f                 MOV byte ptr [SI + 0x1f],CL
1000:3f56      c3                       RET

; ------------------------------------------------------------
1000:3f57  FUN_1000_3f57:
1000:3f57      f6 45 06 ff              TEST byte ptr [DI + 0x6],0xff
1000:3f5b      75 0c                    JNZ 0x1000:3f69
1000:3f5d      80 7d 0a ff              CMP byte ptr [DI + 0xa],0xff
1000:3f61      74 06                    JZ 0x1000:3f69
1000:3f63      8a 44 18                 MOV AL,byte ptr [SI + 0x18]
1000:3f66      3a 45 0a                 CMP AL,byte ptr [DI + 0xa]
1000:3f69  LAB_1000_3f69:
1000:3f69      c3                       RET

; ------------------------------------------------------------
1000:3f6a  FUN_1000_3f6a:
1000:3f6a      53                       PUSH BX
1000:3f6b      e8 b8 ea                 CALL 0x1000:2a26
1000:3f6e      5b                       POP BX
1000:3f6f      3b c3                    CMP AX,BX
1000:3f71      73 3f                    JNC 0x1000:3fb2
1000:3f73      89 44 12                 MOV word ptr [SI + 0x12],AX
1000:3f76      8b d8                    MOV BX,AX
1000:3f78      3d c8 00                 CMP AX,0xc8
1000:3f7b      77 2d                    JA 0x1000:3faa
1000:3f7d      c6 44 14 00              MOV byte ptr [SI + 0x14],0x0
1000:3f81      b4 05                    MOV AH,0x5
1000:3f83      3c 96                    CMP AL,0x96
1000:3f85      77 1a                    JA 0x1000:3fa1
1000:3f87      fe cc                    DEC AH
1000:3f89      3c 6e                    CMP AL,0x6e
1000:3f8b      77 14                    JA 0x1000:3fa1
1000:3f8d      fe cc                    DEC AH
1000:3f8f      3c 55                    CMP AL,0x55
1000:3f91      77 0e                    JA 0x1000:3fa1
1000:3f93      fe cc                    DEC AH
1000:3f95      3c 3c                    CMP AL,0x3c
1000:3f97      77 08                    JA 0x1000:3fa1
1000:3f99      fe cc                    DEC AH
1000:3f9b      3c 28                    CMP AL,0x28
1000:3f9d      77 02                    JA 0x1000:3fa1
1000:3f9f      fe cc                    DEC AH
1000:3fa1  LAB_1000_3fa1:
1000:3fa1      80 64 0b f0              AND byte ptr [SI + 0xb],0xf0
1000:3fa5      08 64 0b                 OR byte ptr [SI + 0xb],AH
1000:3fa8      32 e4                    XOR AH,AH
1000:3faa  LAB_1000_3faa:
1000:3faa      80 e5 0f                 AND CH,0xf
1000:3fad      3d 0a 00                 CMP AX,0xa
1000:3fb0      77 0f                    JA 0x1000:3fc1
1000:3fb2  LAB_1000_3fb2:
1000:3fb2      c3                       RET

; ------------------------------------------------------------
1000:3fb3  FUN_1000_3fb3:
1000:3fb3      53                       PUSH BX
1000:3fb4      e8 6f ea                 CALL 0x1000:2a26
1000:3fb7      5b                       POP BX
1000:3fb8      3b c3                    CMP AX,BX
1000:3fba      77 14                    JA 0x1000:3fd0
1000:3fbc      89 44 12                 MOV word ptr [SI + 0x12],AX
1000:3fbf      8b d8                    MOV BX,AX

; ------------------------------------------------------------
1000:3fc1  FUN_1000_3fc1:
1000:3fc1      02 ed                    ADD CH,CH
1000:3fc3      02 ed                    ADD CH,CH
1000:3fc5      02 ed                    ADD CH,CH
1000:3fc7      02 ed                    ADD CH,CH
1000:3fc9      80 64 0a 0f              AND byte ptr [SI + 0xa],0xf
1000:3fcd      08 6c 0a                 OR byte ptr [SI + 0xa],CH
1000:3fd0  LAB_1000_3fd0:
1000:3fd0      c3                       RET

; ------------------------------------------------------------
1000:3fd1  FUN_1000_3fd1:
1000:3fd1      ff 36 d0 89              PUSH word ptr [0x89d0]
1000:3fd5      bf d0 89                 MOV DI,0x89d0
1000:3fd8      8b 0e d1 00              MOV CX,word ptr [0xd1]
1000:3fdc      b0 00                    MOV AL,0x0
1000:3fde      f3 aa                    STOSB.REP ES:DI
1000:3fe0      8f 06 d0 89              POP word ptr [0x89d0]
1000:3fe4      c6 06 74 a2 00           MOV byte ptr [0xa274],0x0
1000:3fe9      c6 06 82 a2 00           MOV byte ptr [0xa282],0x0
1000:3fee  LAB_1000_3fee:
1000:3fee      e8 dd de                 CALL 0x1000:1ece
                ; ptr table -> 1000:3ff9  [ptr] 1000:a226 1000:a231 1000:a23c 1000:a247
1000:3ff9  LAB_1000_3ff9:
1000:3ff9      8a 07                    MOV AL,byte ptr [BX]
1000:3ffb      50                       PUSH AX
1000:3ffc      e8 cf de                 CALL 0x1000:1ece
                ; ptr table -> 1000:4007  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
1000:4007  LAB_1000_4007:
1000:4007      8b f3                    MOV SI,BX
1000:4009      58                       POP AX
1000:400a      22 c0                    AND AL,AL
1000:400c      74 36                    JZ 0x1000:4044
1000:400e      e8 6c 02                 CALL 0x1000:427d
1000:4011      fe 06 d2 89              INC byte ptr [0x89d2]
1000:4015      bd 7c 15                 MOV BP,0x157c
1000:4018      ba d0 07                 MOV DX,0x7d0
1000:401b      e8 f9 01                 CALL 0x1000:4217
1000:401e      72 ce                    JC 0x1000:3fee
1000:4020      e8 90 e3                 CALL 0x1000:23b3
1000:4023      c7 44 08 a8 61           MOV word ptr [SI + 0x8],0x61a8
1000:4028      c6 44 07 af              MOV byte ptr [SI + 0x7],0xaf
1000:402c      3c 03                    CMP AL,0x3
1000:402e      73 09                    JNC 0x1000:4039
1000:4030      c7 44 08 20 4e           MOV word ptr [SI + 0x8],0x4e20
1000:4035      c6 44 07 7d              MOV byte ptr [SI + 0x7],0x7d
1000:4039  LAB_1000_4039:
1000:4039      c6 44 06 14              MOV byte ptr [SI + 0x6],0x14
1000:403d      d0 e0                    SHL AL,0x1
1000:403f      04 04                    ADD AL,0x4
1000:4041      88 44 0a                 MOV byte ptr [SI + 0xa],AL
1000:4044  LAB_1000_4044:
1000:4044      a0 82 a2                 MOV AL,[0xa282]
1000:4047      88 44 0c                 MOV byte ptr [SI + 0xc],AL
1000:404a      a0 74 a2                 MOV AL,[0xa274]
1000:404d      88 44 0b                 MOV byte ptr [SI + 0xb],AL
1000:4050      c6 44 0d 04              MOV byte ptr [SI + 0xd],0x4
1000:4054      f6 06 12 00 02           TEST byte ptr [0x12],0x2
1000:4059      74 03                    JZ 0x1000:405e
1000:405b      88 44 05                 MOV byte ptr [SI + 0x5],AL
1000:405e  LAB_1000_405e:
1000:405e      e8 6d de                 CALL 0x1000:1ece
                ; ptr table -> 1000:4069  [ptr] 1000:904c 1000:90ec 1000:918c 1000:922c
1000:4069  LAB_1000_4069:
1000:4069      8b fb                    MOV DI,BX
1000:406b      b9 14 00                 MOV CX,0x14
1000:406e      a0 82 a2                 MOV AL,[0xa282]
1000:4071      8a 26 74 a2              MOV AH,byte ptr [0xa274]
1000:4075  LAB_1000_4075:
1000:4075      c6 05 00                 MOV byte ptr [DI],0x0
1000:4078      88 65 06                 MOV byte ptr [DI + 0x6],AH
1000:407b      88 45 07                 MOV byte ptr [DI + 0x7],AL
1000:407e      83 c7 08                 ADD DI,0x8
1000:4081      e2 f2                    LOOP 0x1000:4075
1000:4083      fe 06 74 a2              INC byte ptr [0xa274]
1000:4087      80 3e 74 a2 04           CMP byte ptr [0xa274],0x4
1000:408c      73 1e                    JNC 0x1000:40ac
1000:408e      e8 3d de                 CALL 0x1000:1ece
                ; ptr table -> 1000:4099  [ptr] 1000:a226 1000:a231 1000:a23c 1000:a247
1000:4099  LAB_1000_4099:
1000:4099      8a 26 74 a2              MOV AH,byte ptr [0xa274]
1000:409d      8a 07                    MOV AL,byte ptr [BX]
1000:409f      3c 6d                    CMP AL,0x6d
1000:40a1      75 02                    JNZ 0x1000:40a5
1000:40a3      b4 20                    MOV AH,0x20
1000:40a5  LAB_1000_40a5:
1000:40a5      88 26 82 a2              MOV byte ptr [0xa282],AH
1000:40a9      e9 42 ff                 JMP 0x1000:3fee
1000:40ac  LAB_1000_40ac:
1000:40ac      80 3e 71 a2 01           CMP byte ptr [0xa271],0x1
1000:40b1      75 01                    JNZ 0x1000:40b4
1000:40b3      c3                       RET
1000:40b4  LAB_1000_40b4:
1000:40b4      b0 00                    MOV AL,0x0
1000:40b6  LAB_1000_40b6:
1000:40b6      50                       PUSH AX
1000:40b7      e8 6e f1                 CALL 0x1000:3228
1000:40ba      8b f7                    MOV SI,DI
1000:40bc      b9 00 00                 MOV CX,0x0
1000:40bf  LAB_1000_40bf:
1000:40bf      58                       POP AX
1000:40c0      50                       PUSH AX
1000:40c1      88 44 05                 MOV byte ptr [SI + 0x5],AL
1000:40c4      51                       PUSH CX
1000:40c5  LAB_1000_40c5:
1000:40c5      e8 32 01                 CALL 0x1000:41fa
1000:40c8      f6 06 12 00 02           TEST byte ptr [0x12],0x2
1000:40cd      74 0c                    JZ 0x1000:40db
1000:40cf      3d b8 0b                 CMP AX,0xbb8
1000:40d2      77 07                    JA 0x1000:40db
1000:40d4      59                       POP CX
1000:40d5      51                       PUSH CX
1000:40d6      83 f9 06                 CMP CX,0x6
1000:40d9      72 ea                    JC 0x1000:40c5
1000:40db  LAB_1000_40db:
1000:40db      59                       POP CX
1000:40dc      51                       PUSH CX
1000:40dd      b0 07                    MOV AL,0x7
1000:40df      e3 27                    JCXZ 0x1000:4108
1000:40e1      b0 0e                    MOV AL,0xe
1000:40e3      83 f9 02                 CMP CX,0x2
1000:40e6      76 20                    JBE 0x1000:4108
1000:40e8      f6 06 12 00 02           TEST byte ptr [0x12],0x2
1000:40ed      74 05                    JZ 0x1000:40f4
1000:40ef      e8 eb 01                 CALL 0x1000:42dd
1000:40f2      72 14                    JC 0x1000:4108
1000:40f4  LAB_1000_40f4:
1000:40f4      e8 83 02                 CALL 0x1000:437a
1000:40f7      24 1f                    AND AL,0x1f
1000:40f9      3c 0f                    CMP AL,0xf
1000:40fb      8a d0                    MOV DL,AL
1000:40fd      74 09                    JZ 0x1000:4108
1000:40ff      b2 00                    MOV DL,0x0
1000:4101      24 03                    AND AL,0x3
1000:4103      74 03                    JZ 0x1000:4108
1000:4105      e8 a4 01                 CALL 0x1000:42ac
1000:4108  LAB_1000_4108:
1000:4108      e8 e5 00                 CALL 0x1000:41f0
1000:410b      88 04                    MOV byte ptr [SI],AL
1000:410d      c6 44 07 00              MOV byte ptr [SI + 0x7],0x0
1000:4111      c6 44 08 00              MOV byte ptr [SI + 0x8],0x0
1000:4115      c6 44 06 00              MOV byte ptr [SI + 0x6],0x0
1000:4119      c6 44 0a ff              MOV byte ptr [SI + 0xa],0xff
1000:411d      24 0f                    AND AL,0xf
1000:411f      74 03                    JZ 0x1000:4124
1000:4121      e9 89 00                 JMP 0x1000:41ad
1000:4124  LAB_1000_4124:
1000:4124      8b fe                    MOV DI,SI
1000:4126      e8 51 02                 CALL 0x1000:437a
1000:4129      25 03 00                 AND AX,0x3
1000:412c      ba 00 00                 MOV DX,0x0
1000:412f      74 0f                    JZ 0x1000:4140
1000:4131      b2 01                    MOV DL,0x1
1000:4133      fe c8                    DEC AL
1000:4135      74 09                    JZ 0x1000:4140
1000:4137      b2 02                    MOV DL,0x2
1000:4139      fe c8                    DEC AL
1000:413b      74 03                    JZ 0x1000:4140
1000:413d      ba 01 02                 MOV DX,0x201
1000:4140  LAB_1000_4140:
1000:4140      e8 37 02                 CALL 0x1000:437a
1000:4143      3c fa                    CMP AL,0xfa
1000:4145      77 f9                    JA 0x1000:4140
1000:4147      3c 28                    CMP AL,0x28
1000:4149      72 f5                    JC 0x1000:4140
1000:414b      88 44 06                 MOV byte ptr [SI + 0x6],AL
1000:414e  LAB_1000_414e:
1000:414e      59                       POP CX
1000:414f      80 fa 00                 CMP DL,0x0
1000:4152      74 56                    JZ 0x1000:41aa
1000:4154      41                       INC CX
1000:4155      3a 0e 00 00              CMP CL,byte ptr [0x0]
1000:4159      74 60                    JZ 0x1000:41bb
1000:415b      51                       PUSH CX
1000:415c      83 c7 0b                 ADD DI,0xb
1000:415f      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
1000:4162      88 45 05                 MOV byte ptr [DI + 0x5],AL
1000:4165      8b 44 01                 MOV AX,word ptr [SI + 0x1]
1000:4168      89 45 01                 MOV word ptr [DI + 0x1],AX
1000:416b      8b 44 03                 MOV AX,word ptr [SI + 0x3]
1000:416e      05 c8 00                 ADD AX,0xc8
1000:4171      80 fa 01                 CMP DL,0x1
1000:4174      74 03                    JZ 0x1000:4179
1000:4176      05 c8 00                 ADD AX,0xc8
1000:4179  LAB_1000_4179:
1000:4179      89 45 03                 MOV word ptr [DI + 0x3],AX
1000:417c      c6 45 06 00              MOV byte ptr [DI + 0x6],0x0
1000:4180      c6 45 07 00              MOV byte ptr [DI + 0x7],0x0
1000:4184      88 55 08                 MOV byte ptr [DI + 0x8],DL
1000:4187      c6 45 0a ff              MOV byte ptr [DI + 0xa],0xff
1000:418b  LAB_1000_418b:
1000:418b      e8 1e 01                 CALL 0x1000:42ac
1000:418e      3c 0e                    CMP AL,0xe
1000:4190      74 f9                    JZ 0x1000:418b
1000:4192      e8 5b 00                 CALL 0x1000:41f0
1000:4195      88 05                    MOV byte ptr [DI],AL
1000:4197      e8 e0 01                 CALL 0x1000:437a
1000:419a      25 3f 00                 AND AX,0x3f
1000:419d      8b c8                    MOV CX,AX
1000:419f  LAB_1000_419f:
1000:419f      e8 0f 02                 CALL 0x1000:43b1
1000:41a2      e2 fb                    LOOP 0x1000:419f
1000:41a4      8a d6                    MOV DL,DH
1000:41a6      b6 00                    MOV DH,0x0
1000:41a8      eb a4                    JMP 0x1000:414e
1000:41aa  LAB_1000_41aa:
1000:41aa      51                       PUSH CX
1000:41ab      8b f7                    MOV SI,DI
1000:41ad  LAB_1000_41ad:
1000:41ad      59                       POP CX
1000:41ae      83 c6 0b                 ADD SI,0xb
1000:41b1      41                       INC CX
1000:41b2      3a 0e 00 00              CMP CL,byte ptr [0x0]
1000:41b6      74 03                    JZ 0x1000:41bb
1000:41b8      e9 04 ff                 JMP 0x1000:40bf
1000:41bb  LAB_1000_41bb:
1000:41bb      58                       POP AX
1000:41bc      fe c0                    INC AL
1000:41be      3a 06 02 00              CMP AL,byte ptr [0x2]
1000:41c2      73 03                    JNC 0x1000:41c7
1000:41c4      e9 ef fe                 JMP 0x1000:40b6
1000:41c7  LAB_1000_41c7:
1000:41c7      be 8c 8a                 MOV SI,0x8a8c
1000:41ca      8a 0e 01 00              MOV CL,byte ptr [0x1]
1000:41ce      32 ed                    XOR CH,CH
1000:41d0  LAB_1000_41d0:
1000:41d0      e8 3f 01                 CALL 0x1000:4312
1000:41d3      83 c6 3b                 ADD SI,0x3b
1000:41d6      e2 f8                    LOOP 0x1000:41d0
1000:41d8      bb d4 89                 MOV BX,0x89d4
1000:41db      b9 04 00                 MOV CX,0x4
1000:41de  LAB_1000_41de:
1000:41de      e8 99 01                 CALL 0x1000:437a
1000:41e1      24 03                    AND AL,0x3
1000:41e3      0c 50                    OR AL,0x50
1000:41e5      88 07                    MOV byte ptr [BX],AL
1000:41e7      43                       INC BX
1000:41e8      e2 f4                    LOOP 0x1000:41de
1000:41ea      c6 06 d2 89 00           MOV byte ptr [0x89d2],0x0
1000:41ef      c3                       RET

; ------------------------------------------------------------
1000:41f0  FUN_1000_41f0:
1000:41f0      f6 06 12 00 01           TEST byte ptr [0x12],0x1
1000:41f5      74 02                    JZ 0x1000:41f9
1000:41f7      0c f0                    OR AL,0xf0
1000:41f9  LAB_1000_41f9:
1000:41f9      c3                       RET

; ------------------------------------------------------------
1000:41fa  FUN_1000_41fa:
1000:41fa      e8 9e 00                 CALL 0x1000:429b
1000:41fd      89 44 01                 MOV word ptr [SI + 0x1],AX
1000:4200      e8 98 00                 CALL 0x1000:429b
1000:4203      89 44 03                 MOV word ptr [SI + 0x3],AX
1000:4206      e8 52 00                 CALL 0x1000:425b
1000:4209      72 ef                    JC 0x1000:41fa
1000:420b      bd e8 03                 MOV BP,0x3e8
1000:420e      ba 70 17                 MOV DX,0x1770
1000:4211      e8 03 00                 CALL 0x1000:4217
1000:4214      72 e4                    JC 0x1000:41fa
1000:4216      c3                       RET

; ------------------------------------------------------------
1000:4217  FUN_1000_4217:
1000:4217      51                       PUSH CX
1000:4218      f6 06 12 00 02           TEST byte ptr [0x12],0x2
1000:421d      74 19                    JZ 0x1000:4238
1000:421f      bf 00 01                 MOV DI,0x100
1000:4222      b1 05                    MOV CL,0x5
1000:4224      52                       PUSH DX
1000:4225      e8 a4 e1                 CALL 0x1000:23cc
1000:4228      5a                       POP DX
1000:4229      3b c2                    CMP AX,DX
1000:422b      f5                       CMC
1000:422c      72 2b                    JC 0x1000:4259
1000:422e      81 fd 7c 15              CMP BP,0x157c
1000:4232      f8                       CLC
1000:4233      75 03                    JNZ 0x1000:4238
1000:4235      bd f4 01                 MOV BP,0x1f4
1000:4238  LAB_1000_4238:
1000:4238      bf 14 90                 MOV DI,0x9014
1000:423b      b9 04 00                 MOV CX,0x4
1000:423e  LAB_1000_423e:
1000:423e      3b f7                    CMP SI,DI
1000:4240      74 11                    JZ 0x1000:4253
1000:4242      83 7d 08 00              CMP word ptr [DI + 0x8],0x0
1000:4246      74 0b                    JZ 0x1000:4253
1000:4248      51                       PUSH CX
1000:4249      b1 04                    MOV CL,0x4
1000:424b      e8 7e e1                 CALL 0x1000:23cc
1000:424e      59                       POP CX
1000:424f      3b c5                    CMP AX,BP
1000:4251      72 06                    JC 0x1000:4259
1000:4253  LAB_1000_4253:
1000:4253      83 c7 0e                 ADD DI,0xe
1000:4256      e2 e6                    LOOP 0x1000:423e
1000:4258      f8                       CLC
1000:4259  LAB_1000_4259:
1000:4259      59                       POP CX
1000:425a      c3                       RET

; ------------------------------------------------------------
1000:425b  FUN_1000_425b:
1000:425b      51                       PUSH CX
1000:425c      e8 c6 ef                 CALL 0x1000:3225
1000:425f  LAB_1000_425f:
1000:425f      83 7d 01 00              CMP word ptr [DI + 0x1],0x0
1000:4263      74 10                    JZ 0x1000:4275
1000:4265      3b f7                    CMP SI,DI
1000:4267      74 0c                    JZ 0x1000:4275
1000:4269      51                       PUSH CX
1000:426a      b1 02                    MOV CL,0x2
1000:426c      e8 55 e1                 CALL 0x1000:23c4
1000:426f      59                       POP CX
1000:4270      3d 8a 02                 CMP AX,0x28a
1000:4273      72 06                    JC 0x1000:427b
1000:4275  LAB_1000_4275:
1000:4275      83 c7 0b                 ADD DI,0xb
1000:4278      e2 e5                    LOOP 0x1000:425f
1000:427a      f8                       CLC
1000:427b  LAB_1000_427b:
1000:427b      59                       POP CX
1000:427c      c3                       RET

; ------------------------------------------------------------
1000:427d  FUN_1000_427d:
1000:427d      e8 0a 00                 CALL 0x1000:428a
1000:4280      89 44 01                 MOV word ptr [SI + 0x1],AX
1000:4283      e8 04 00                 CALL 0x1000:428a
1000:4286      89 44 03                 MOV word ptr [SI + 0x3],AX
1000:4289      c3                       RET

; ------------------------------------------------------------
1000:428a  FUN_1000_428a:
1000:428a      e8 ed 00                 CALL 0x1000:437a
1000:428d      25 ff 3f                 AND AX,0x3fff
1000:4290      3d dc 05                 CMP AX,0x5dc
1000:4293      72 f5                    JC 0x1000:428a
1000:4295      3d 24 3a                 CMP AX,0x3a24
1000:4298      77 f0                    JA 0x1000:428a
1000:429a      c3                       RET

; ------------------------------------------------------------
1000:429b  FUN_1000_429b:
1000:429b      e8 dc 00                 CALL 0x1000:437a
1000:429e      25 ff 3f                 AND AX,0x3fff
1000:42a1      3d f4 01                 CMP AX,0x1f4
1000:42a4      72 f5                    JC 0x1000:429b
1000:42a6      3d 0c 3e                 CMP AX,0x3e0c
1000:42a9      77 f0                    JA 0x1000:429b
1000:42ab      c3                       RET

; ------------------------------------------------------------
1000:42ac  FUN_1000_42ac:
1000:42ac      e8 cb 00                 CALL 0x1000:437a
1000:42af      53                       PUSH BX
1000:42b0      25 1f 00                 AND AX,0x1f
1000:42b3      bb bd 42                 MOV BX,0x42bd
1000:42b6      03 d8                    ADD BX,AX
1000:42b8      2e 8a 07                 MOV AL,byte ptr CS:[BX]
1000:42bb      5b                       POP BX
1000:42bc      c3                       RET

; ------------------------------------------------------------
1000:42dd  FUN_1000_42dd:
1000:42dd      83 e9 03                 SUB CX,0x3
1000:42e0      8b d9                    MOV BX,CX
1000:42e2      83 fb 06                 CMP BX,0x6
1000:42e5      73 1d                    JNC 0x1000:4304
1000:42e7      81 e3 06 00              AND BX,0x6
1000:42eb      d1 e3                    SHL BX,0x1
1000:42ed      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
1000:42f0      25 03 00                 AND AX,0x3
1000:42f3      03 d8                    ADD BX,AX
1000:42f5      2e 8a 87 06 43           MOV AL,byte ptr CS:[BX + 0x4306]
1000:42fa      3a 06 02 00              CMP AL,byte ptr [0x2]
1000:42fe      73 04                    JNC 0x1000:4304
1000:4300      04 0a                    ADD AL,0xa
1000:4302      f9                       STC
1000:4303      c3                       RET
1000:4304  LAB_1000_4304:
1000:4304      f8                       CLC
1000:4305      c3                       RET

; ------------------------------------------------------------
1000:4312  FUN_1000_4312:
1000:4312      e8 65 00                 CALL 0x1000:437a
1000:4315      24 07                    AND AL,0x7
1000:4317      b0 02                    MOV AL,0x2
1000:4319      74 05                    JZ 0x1000:4320
1000:431b      e8 5c 00                 CALL 0x1000:437a
1000:431e      24 01                    AND AL,0x1
1000:4320  LAB_1000_4320:
1000:4320      0c 80                    OR AL,0x80
1000:4322      88 04                    MOV byte ptr [SI],AL
1000:4324  LAB_1000_4324:
1000:4324      e8 53 00                 CALL 0x1000:437a
1000:4327      25 ff 3f                 AND AX,0x3fff
1000:432a      89 44 01                 MOV word ptr [SI + 0x1],AX
1000:432d      e8 4a 00                 CALL 0x1000:437a
1000:4330      25 ff 3f                 AND AX,0x3fff
1000:4333      89 44 03                 MOV word ptr [SI + 0x3],AX
1000:4336      bd 32 00                 MOV BP,0x32
1000:4339      ba 88 13                 MOV DX,0x1388
1000:433c      e8 d8 fe                 CALL 0x1000:4217
1000:433f      72 e3                    JC 0x1000:4324
1000:4341      e8 36 00                 CALL 0x1000:437a
1000:4344      88 44 0a                 MOV byte ptr [SI + 0xa],AL
1000:4347      e8 30 00                 CALL 0x1000:437a
1000:434a      24 07                    AND AL,0x7
1000:434c      04 05                    ADD AL,0x5
1000:434e      80 3c 82                 CMP byte ptr [SI],0x82
1000:4351      75 02                    JNZ 0x1000:4355
1000:4353      04 05                    ADD AL,0x5
1000:4355  LAB_1000_4355:
1000:4355      88 44 0b                 MOV byte ptr [SI + 0xb],AL
1000:4358      e8 1f 00                 CALL 0x1000:437a
1000:435b      25 ff 00                 AND AX,0xff
1000:435e      05 64 00                 ADD AX,0x64
1000:4361      89 44 08                 MOV word ptr [SI + 0x8],AX
1000:4364      f6 06 12 00 02           TEST byte ptr [0x12],0x2
1000:4369      74 0e                    JZ 0x1000:4379
1000:436b  LAB_1000_436b:
1000:436b      e8 0c 00                 CALL 0x1000:437a
1000:436e      24 03                    AND AL,0x3
1000:4370      3a 06 02 00              CMP AL,byte ptr [0x2]
1000:4374      73 f5                    JNC 0x1000:436b
1000:4376      88 44 05                 MOV byte ptr [SI + 0x5],AL
1000:4379  LAB_1000_4379:
1000:4379      c3                       RET

; ------------------------------------------------------------
1000:437a  FUN_1000_437a:
1000:437a      a0 d2 89                 MOV AL,[0x89d2]
1000:437d      34 a5                    XOR AL,0xa5
1000:437f      52                       PUSH DX
1000:4380      53                       PUSH BX
1000:4381      8b 1e d0 89              MOV BX,word ptr [0x89d0]
1000:4385      33 d2                    XOR DX,DX
1000:4387      32 c7                    XOR AL,BH
1000:4389      7a 03                    JP 0x1000:438e
1000:438b      b2 02                    MOV DL,0x2
1000:438d      f9                       STC
1000:438e  LAB_1000_438e:
1000:438e      d0 d8                    RCR AL,0x1
1000:4390      8a f0                    MOV DH,AL
1000:4392      d0 da                    RCR DL,0x1
1000:4394      8a e2                    MOV AH,DL
1000:4396      d0 d8                    RCR AL,0x1
1000:4398      d0 da                    RCR DL,0x1
1000:439a      32 c6                    XOR AL,DH
1000:439c      8a f0                    MOV DH,AL
1000:439e      8a c2                    MOV AL,DL
1000:43a0      32 c4                    XOR AL,AH
1000:43a2      32 c3                    XOR AL,BL
1000:43a4      8a f8                    MOV BH,AL
1000:43a6      8a de                    MOV BL,DH
1000:43a8      89 1e d0 89              MOV word ptr [0x89d0],BX
1000:43ac      8b c3                    MOV AX,BX
1000:43ae      5b                       POP BX
1000:43af      5a                       POP DX
1000:43b0      c3                       RET

; ------------------------------------------------------------
1000:43b1  FUN_1000_43b1:
1000:43b1      56                       PUSH SI
1000:43b2      53                       PUSH BX
1000:43b3      51                       PUSH CX
1000:43b4      52                       PUSH DX
1000:43b5      8a 45 08                 MOV AL,byte ptr [DI + 0x8]
1000:43b8      22 c0                    AND AL,AL
1000:43ba      74 38                    JZ 0x1000:43f4
1000:43bc      bb f9 43                 MOV BX,0x43f9
1000:43bf      b2 08                    MOV DL,0x8
1000:43c1      b1 1f                    MOV CL,0x1f
1000:43c3      fe c8                    DEC AL
1000:43c5      74 07                    JZ 0x1000:43ce
1000:43c7      bb 19 44                 MOV BX,0x4419
1000:43ca      b2 10                    MOV DL,0x10
1000:43cc      b1 3f                    MOV CL,0x3f
1000:43ce  LAB_1000_43ce:
1000:43ce      8a 45 07                 MOV AL,byte ptr [DI + 0x7]
1000:43d1      fe 45 07                 INC byte ptr [DI + 0x7]
1000:43d4      8a e8                    MOV CH,AL
1000:43d6      22 c1                    AND AL,CL
1000:43d8      32 e4                    XOR AH,AH
1000:43da      8b f0                    MOV SI,AX
1000:43dc      2e 8a 00                 MOV AL,byte ptr CS:[BX + SI]
1000:43df      98                       CBW
1000:43e0      01 45 01                 ADD word ptr [DI + 0x1],AX
1000:43e3      8a c5                    MOV AL,CH
1000:43e5      02 c2                    ADD AL,DL
1000:43e7      22 c1                    AND AL,CL
1000:43e9      32 e4                    XOR AH,AH
1000:43eb      8b f0                    MOV SI,AX
1000:43ed      2e 8a 00                 MOV AL,byte ptr CS:[BX + SI]
1000:43f0      98                       CBW
1000:43f1      01 45 03                 ADD word ptr [DI + 0x3],AX
1000:43f4  LAB_1000_43f4:
1000:43f4      5a                       POP DX
1000:43f5      59                       POP CX
1000:43f6      5b                       POP BX
1000:43f7      5e                       POP SI
1000:43f8      c3                       RET

; ------------------------------------------------------------
1000:4459  FUN_1000_4459:
1000:4459      c7 45 32 00 00           MOV word ptr [DI + 0x32],0x0
1000:445e      c6 45 34 00              MOV byte ptr [DI + 0x34],0x0
1000:4462      c6 45 11 00              MOV byte ptr [DI + 0x11],0x0
1000:4466      e8 65 da                 CALL 0x1000:1ece
                ; ptr table -> 1000:4471  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
1000:4471  LAB_1000_4471:
1000:4471      8b f3                    MOV SI,BX
1000:4473      80 7c 0a 00              CMP byte ptr [SI + 0xa],0x0
1000:4477      75 02                    JNZ 0x1000:447b
1000:4479      f9                       STC
1000:447a      c3                       RET
1000:447b  LAB_1000_447b:
1000:447b      81 7c 08 c8 00           CMP word ptr [SI + 0x8],0xc8
1000:4480      77 02                    JA 0x1000:4484
1000:4482      f9                       STC
1000:4483      c3                       RET
1000:4484  LAB_1000_4484:
1000:4484      fe 4c 0a                 DEC byte ptr [SI + 0xa]
1000:4487      83 6c 08 64              SUB word ptr [SI + 0x8],0x64
1000:448b      57                       PUSH DI
1000:448c      51                       PUSH CX
1000:448d      32 c0                    XOR AL,AL
1000:448f      b9 3b 00                 MOV CX,0x3b
1000:4492      f3 aa                    STOSB.REP ES:DI
1000:4494      59                       POP CX
1000:4495      5f                       POP DI
1000:4496      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
1000:4499      88 45 17                 MOV byte ptr [DI + 0x17],AL
1000:449c      88 45 2b                 MOV byte ptr [DI + 0x2b],AL
1000:449f      8a 44 0c                 MOV AL,byte ptr [SI + 0xc]
1000:44a2      88 45 18                 MOV byte ptr [DI + 0x18],AL
1000:44a5      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
1000:44a8      88 45 05                 MOV byte ptr [DI + 0x5],AL
1000:44ab      88 45 31                 MOV byte ptr [DI + 0x31],AL
1000:44ae      c6 05 80                 MOV byte ptr [DI],0x80
1000:44b1      c6 45 2c 00              MOV byte ptr [DI + 0x2c],0x0
1000:44b5      8b 44 01                 MOV AX,word ptr [SI + 0x1]
1000:44b8      89 45 01                 MOV word ptr [DI + 0x1],AX
1000:44bb      89 45 2d                 MOV word ptr [DI + 0x2d],AX
1000:44be      8b 44 03                 MOV AX,word ptr [SI + 0x3]
1000:44c1      89 45 03                 MOV word ptr [DI + 0x3],AX
1000:44c4      89 45 2f                 MOV word ptr [DI + 0x2f],AX
1000:44c7      c6 45 06 00              MOV byte ptr [DI + 0x6],0x0
1000:44cb      c6 45 2a 00              MOV byte ptr [DI + 0x2a],0x0
1000:44cf      e8 e1 de                 CALL 0x1000:23b3
1000:44d2      c6 45 07 05              MOV byte ptr [DI + 0x7],0x5
1000:44d6      c7 45 08 4c 1d           MOV word ptr [DI + 0x8],0x1d4c
1000:44db      c6 45 0f 63              MOV byte ptr [DI + 0xf],0x63
1000:44df      3c 04                    CMP AL,0x4
1000:44e1      74 25                    JZ 0x1000:4508
1000:44e3      f6 06 12 00 01           TEST byte ptr [0x12],0x1
1000:44e8      75 1e                    JNZ 0x1000:4508
1000:44ea      c6 45 07 02              MOV byte ptr [DI + 0x7],0x2
1000:44ee      c7 45 08 b8 0b           MOV word ptr [DI + 0x8],0xbb8
1000:44f3      c6 45 0f 32              MOV byte ptr [DI + 0xf],0x32
1000:44f7      3c 03                    CMP AL,0x3
1000:44f9      74 0d                    JZ 0x1000:4508
1000:44fb      c6 45 07 00              MOV byte ptr [DI + 0x7],0x0
1000:44ff      c7 45 08 e8 03           MOV word ptr [DI + 0x8],0x3e8
1000:4504      c6 45 0f 14              MOV byte ptr [DI + 0xf],0x14
1000:4508  LAB_1000_4508:
1000:4508      8a c1                    MOV AL,CL
1000:450a      02 c0                    ADD AL,AL
1000:450c      02 c0                    ADD AL,AL
1000:450e      02 c0                    ADD AL,AL
1000:4510      02 c0                    ADD AL,AL
1000:4512      02 c1                    ADD AL,CL
1000:4514      02 c0                    ADD AL,AL
1000:4516      02 c0                    ADD AL,AL
1000:4518      88 45 0a                 MOV byte ptr [DI + 0xa],AL
1000:451b      c6 45 0b 11              MOV byte ptr [DI + 0xb],0x11
1000:451f      c6 45 29 01              MOV byte ptr [DI + 0x29],0x1
1000:4523      f8                       CLC
1000:4524      c3                       RET

; ------------------------------------------------------------
1000:4530  FUN_1000_4530:
1000:4530      80 3e 71 a2 01           CMP byte ptr [0xa271],0x1
1000:4535      74 03                    JZ 0x1000:453a
1000:4537      e8 16 0f                 CALL 0x1000:5450
1000:453a  LAB_1000_453a:
1000:453a      a0 6f a2                 MOV AL,[0xa26f]
1000:453d      a2 74 a2                 MOV [0xa274],AL
1000:4540      e8 19 0e                 CALL 0x1000:535c
1000:4543      8a 07                    MOV AL,byte ptr [BX]
1000:4545      f6 07 10                 TEST byte ptr [BX],0x10
1000:4548      74 40                    JZ 0x1000:458a
1000:454a      c6 06 99 a2 00           MOV byte ptr [0xa299],0x0
1000:454f      e8 7c d9                 CALL 0x1000:1ece
                ; ptr table -> 1000:455a  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
1000:455a  LAB_1000_455a:
1000:455a      b4 10                    MOV AH,0x10
1000:455c      b0 00                    MOV AL,0x0
1000:455e      80 7f 0d 00              CMP byte ptr [BX + 0xd],0x0
1000:4562      74 1c                    JZ 0x1000:4580
1000:4564      8a 67 05                 MOV AH,byte ptr [BX + 0x5]
1000:4567      8a 1f                    MOV BL,byte ptr [BX]
1000:4569      b0 00                    MOV AL,0x0
1000:456b      80 e3 07                 AND BL,0x7
1000:456e      74 10                    JZ 0x1000:4580
1000:4570      b0 03                    MOV AL,0x3
1000:4572      80 fb 04                 CMP BL,0x4
1000:4575      73 09                    JNC 0x1000:4580
1000:4577      b0 02                    MOV AL,0x2
1000:4579      80 fb 02                 CMP BL,0x2
1000:457c      73 02                    JNC 0x1000:4580
1000:457e      b0 01                    MOV AL,0x1
1000:4580  LAB_1000_4580:
1000:4580      88 26 60 a3              MOV byte ptr [0xa360],AH
1000:4584      e8 dd 0e                 CALL 0x1000:5464
1000:4587      eb 7e                    JMP 0x1000:4607
1000:458a  LAB_1000_458a:
1000:458a      e8 7f e4                 CALL 0x1000:2a0c
1000:458d      89 36 97 a2              MOV word ptr [0xa297],SI
1000:4591      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
1000:4594      a2 60 a3                 MOV [0xa360],AL
1000:4597      8a 04                    MOV AL,byte ptr [SI]
1000:4599      e8 c8 0e                 CALL 0x1000:5464
1000:459c      8a 44 0e                 MOV AL,byte ptr [SI + 0xe]
1000:459f      d0 e0                    SHL AL,0x1
1000:45a1      d0 e0                    SHL AL,0x1
1000:45a3      fa                       CLI
1000:45a4      80 26 99 a2 03           AND byte ptr [0xa299],0x3
1000:45a9      08 06 99 a2              OR byte ptr [0xa299],AL
1000:45ad      fb                       STI
1000:45ae      24 f0                    AND AL,0xf0
1000:45b0      75 0b                    JNZ 0x1000:45bd
1000:45b2      80 3e 66 a2 00           CMP byte ptr [0xa266],0x0
1000:45b7      eb 04                    JMP 0x1000:45bd
1000:45bd  LAB_1000_45bd:
1000:45bd      8a 44 0a                 MOV AL,byte ptr [SI + 0xa]
1000:45c0      e8 4e 11                 CALL 0x1000:5711
1000:45c3      8b 36 97 a2              MOV SI,word ptr [0xa297]
1000:45c7      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
1000:45ca      e8 e3 10                 CALL 0x1000:56b0
1000:45cd      8b 36 97 a2              MOV SI,word ptr [0xa297]
1000:45d1      8a 44 06                 MOV AL,byte ptr [SI + 0x6]
1000:45d4      e8 87 11                 CALL 0x1000:575e
1000:45d7      8b 36 97 a2              MOV SI,word ptr [0xa297]
1000:45db      8a 44 07                 MOV AL,byte ptr [SI + 0x7]
1000:45de      e8 97 11                 CALL 0x1000:5778
1000:45e1      8b 36 97 a2              MOV SI,word ptr [0xa297]
1000:45e5      8a 44 14                 MOV AL,byte ptr [SI + 0x14]
1000:45e8      ba 22 00                 MOV DX,0x22
1000:45eb      be 41 1d                 MOV SI,0x1d41
1000:45ee      e8 be 11                 CALL 0x1000:57af
1000:45f1      8b 36 97 a2              MOV SI,word ptr [0xa297]
1000:45f5      8a 44 0f                 MOV AL,byte ptr [SI + 0xf]
1000:45f8      ba 2c 00                 MOV DX,0x2c
1000:45fb      be 1b 1d                 MOV SI,0x1d1b
1000:45fe      e8 ae 11                 CALL 0x1000:57af
1000:4601      e8 88 10                 CALL 0x1000:568c
1000:4604      e8 71 10                 CALL 0x1000:5678
1000:4607  LAB_1000_4607:
1000:4607      e8 65 00                 CALL 0x1000:466f
1000:460a      e8 0a 06                 CALL 0x1000:4c17
1000:460d      e8 99 0a                 CALL 0x1000:50a9
1000:4610      e8 08 0b                 CALL 0x1000:511b
1000:4613      e8 9a 0e                 CALL 0x1000:54b0
1000:4616      c3                       RET

; ------------------------------------------------------------
1000:4649  FUN_1000_4649:
1000:4649      52                       PUSH DX
1000:464a      51                       PUSH CX
1000:464b      a0 15 00                 MOV AL,[0x15]
1000:464e      24 01                    AND AL,0x1
1000:4650      75 1a                    JNZ 0x1000:466c
1000:4652      b0 10                    MOV AL,0x10
1000:4654      80 3e 99 a2 00           CMP byte ptr [0xa299],0x0
1000:4659      74 0d                    JZ 0x1000:4668
1000:465b      fe 0e 99 a2              DEC byte ptr [0xa299]
1000:465f      f6 06 99 a2 01           TEST byte ptr [0xa299],0x1
1000:4664      74 02                    JZ 0x1000:4668
1000:4666      0c 04                    OR AL,0x4
1000:4668  LAB_1000_4668:
1000:4668      ba d9 03                 MOV DX,0x3d9
1000:466b      ee                       OUT DX,AL
1000:466c  LAB_1000_466c:
1000:466c      59                       POP CX
1000:466d      5a                       POP DX
1000:466e      c3                       RET

; ------------------------------------------------------------
1000:466f  FUN_1000_466f:
1000:466f      e8 ea 0c                 CALL 0x1000:535c
1000:4672      f6 07 10                 TEST byte ptr [BX],0x10
1000:4675      74 03                    JZ 0x1000:467a
1000:4677      e9 db 01                 JMP 0x1000:4855
1000:467a  LAB_1000_467a:
1000:467a      b9 36 00                 MOV CX,0x36
1000:467d      ba 38 00                 MOV DX,0x38
1000:4680      e8 e6 0f                 CALL 0x1000:5669
1000:4683      e8 ce 0e                 CALL 0x1000:5554
                ; cstring -> 1000:468d  <c1>Ship 
1000:468d  LAB_1000_468d:
1000:468d      e8 cc 0c                 CALL 0x1000:535c
1000:4690      8a 07                    MOV AL,byte ptr [BX]
1000:4692      24 03                    AND AL,0x3
1000:4694      fe c0                    INC AL
1000:4696      04 30                    ADD AL,0x30
1000:4698      32 e4                    XOR AH,AH
1000:469a      e8 de 0e                 CALL 0x1000:557b
1000:469d      e8 b4 0e                 CALL 0x1000:5554
                ; cstring -> 1000:46a4   E=
1000:46a4  LAB_1000_46a4:
1000:46a4      e8 b5 0c                 CALL 0x1000:535c
1000:46a7      8a 07                    MOV AL,byte ptr [BX]
1000:46a9      e8 60 e3                 CALL 0x1000:2a0c
1000:46ac      8b 44 08                 MOV AX,word ptr [SI + 0x8]
1000:46af      e8 5c 0d                 CALL 0x1000:540e
1000:46b2      b9 36 00                 MOV CX,0x36
1000:46b5      ba 40 00                 MOV DX,0x40
1000:46b8      e8 ae 0f                 CALL 0x1000:5669
1000:46bb      8a 64 11                 MOV AH,byte ptr [SI + 0x11]
1000:46be      80 e4 1f                 AND AH,0x1f
1000:46c1      75 03                    JNZ 0x1000:46c6
1000:46c3      eb 20                    JMP 0x1000:46e5
1000:46c6  LAB_1000_46c6:
1000:46c6      e8 8b 0e                 CALL 0x1000:5554
                ; cstring -> 1000:46d2  Seeking 
1000:46d2  LAB_1000_46d2:
1000:46d2      e8 ae 04                 CALL 0x1000:4b83
1000:46d5      e8 7c 0e                 CALL 0x1000:5554
                ; cstring -> 1000:46da   
1000:46da  LAB_1000_46da:
1000:46da      8b 44 12                 MOV AX,word ptr [SI + 0x12]
1000:46dd      3d 0f 27                 CMP AX,0x270f
1000:46e0      77 03                    JA 0x1000:46e5
1000:46e2      e8 30 0d                 CALL 0x1000:5415
1000:46e5  LAB_1000_46e5:
1000:46e5      f6 06 12 00 02           TEST byte ptr [0x12],0x2
1000:46ea      74 1f                    JZ 0x1000:470b
1000:46ec      b9 36 00                 MOV CX,0x36
1000:46ef      ba 48 00                 MOV DX,0x48
1000:46f2      e8 74 0f                 CALL 0x1000:5669
1000:46f5      e8 5c 0e                 CALL 0x1000:5554
                ; cstring -> 1000:4703  <c1>  Level  
1000:4703  LAB_1000_4703:
1000:4703      a0 60 a3                 MOV AL,[0xa360]
1000:4706      04 41                    ADD AL,0x41
1000:4708      e8 6c 0e                 CALL 0x1000:5577
1000:470b  LAB_1000_470b:
1000:470b      b9 36 00                 MOV CX,0x36
1000:470e      ba 50 00                 MOV DX,0x50
1000:4711      e8 55 0f                 CALL 0x1000:5669
1000:4714      e8 3d 0e                 CALL 0x1000:5554
                ; cstring -> 1000:4722  <c1>Weapons  
1000:4722  LAB_1000_4722:
1000:4722      80 7c 15 00              CMP byte ptr [SI + 0x15],0x0
1000:4726      74 22                    JZ 0x1000:474a
1000:4728      80 7c 15 0c              CMP byte ptr [SI + 0x15],0xc
1000:472c      76 0b                    JBE 0x1000:4739
1000:472e      e8 23 0e                 CALL 0x1000:5554
                ; cstring -> 1000:4737  <c2>INOP
1000:4737  LAB_1000_4737:
1000:4737      eb 2d                    JMP 0x1000:4766
1000:4739  LAB_1000_4739:
1000:4739      f6 44 19 ff              TEST byte ptr [SI + 0x19],0xff
1000:473d      75 11                    JNZ 0x1000:4750
1000:473f      e8 12 0e                 CALL 0x1000:5554
                ; cstring -> 1000:4748  <c3>Wait
1000:4748  LAB_1000_4748:
1000:4748      eb 1c                    JMP 0x1000:4766
1000:474a  LAB_1000_474a:
1000:474a      f6 44 19 ff              TEST byte ptr [SI + 0x19],0xff
1000:474e      74 0c                    JZ 0x1000:475c
1000:4750  LAB_1000_4750:
1000:4750      e8 01 0e                 CALL 0x1000:5554
                ; cstring -> 1000:475a  <c3>Fired
1000:475a  LAB_1000_475a:
1000:475a      eb 0a                    JMP 0x1000:4766
1000:475c  LAB_1000_475c:
1000:475c      e8 f5 0d                 CALL 0x1000:5554
                ; cstring -> 1000:4766  <c1>Ready
1000:4766  LAB_1000_4766:
1000:4766      b9 36 00                 MOV CX,0x36
1000:4769      ba 58 00                 MOV DX,0x58
1000:476c      e8 fa 0e                 CALL 0x1000:5669
1000:476f      e8 e2 0d                 CALL 0x1000:5554
                ; cstring -> 1000:477d  <c1>Shields  
1000:477d  LAB_1000_477d:
1000:477d      80 7c 0e 08              CMP byte ptr [SI + 0xe],0x8
1000:4781      72 0b                    JC 0x1000:478e
1000:4783      e8 ce 0d                 CALL 0x1000:5554
                ; cstring -> 1000:478c  <c2>INOP
1000:478c  LAB_1000_478c:
1000:478c      eb 1b                    JMP 0x1000:47a9
1000:478e  LAB_1000_478e:
1000:478e      f6 04 20                 TEST byte ptr [SI],0x20
1000:4791      74 0c                    JZ 0x1000:479f
1000:4793      e8 be 0d                 CALL 0x1000:5554
                ; cstring -> 1000:479d  <c3>Up   
1000:479d  LAB_1000_479d:
1000:479d      eb 0a                    JMP 0x1000:47a9
1000:479f  LAB_1000_479f:
1000:479f      e8 b2 0d                 CALL 0x1000:5554
                ; cstring -> 1000:47a9  <c1>Down 
1000:47a9  LAB_1000_47a9:
1000:47a9      b9 36 00                 MOV CX,0x36
1000:47ac      ba 60 00                 MOV DX,0x60
1000:47af      e8 b7 0e                 CALL 0x1000:5669
1000:47b2      e8 9f 0d                 CALL 0x1000:5554
                ; cstring -> 1000:47c0  <c1>Scanner  
1000:47c0  LAB_1000_47c0:
1000:47c0      80 3e 70 a2 02           CMP byte ptr [0xa270],0x2
1000:47c5      77 0b                    JA 0x1000:47d2
1000:47c7      e8 8a 0d                 CALL 0x1000:5554
                ; cstring -> 1000:47d0  Short
1000:47d0  LAB_1000_47d0:
1000:47d0      eb 28                    JMP 0x1000:47fa
1000:47d2  LAB_1000_47d2:
1000:47d2      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
1000:47d7      77 09                    JA 0x1000:47e2
1000:47d9      e8 78 0d                 CALL 0x1000:5554
                ; cstring -> 1000:47e0  Med
1000:47e0  LAB_1000_47e0:
1000:47e0      eb 18                    JMP 0x1000:47fa
1000:47e2  LAB_1000_47e2:
1000:47e2      80 3e 70 a2 06           CMP byte ptr [0xa270],0x6
1000:47e7      77 0a                    JA 0x1000:47f3
1000:47e9      e8 68 0d                 CALL 0x1000:5554
                ; cstring -> 1000:47f1  Long
1000:47f1  LAB_1000_47f1:
1000:47f1      eb 07                    JMP 0x1000:47fa
1000:47f3  LAB_1000_47f3:
1000:47f3      e8 5e 0d                 CALL 0x1000:5554
                ; cstring -> 1000:47fa  Map
1000:47fa  LAB_1000_47fa:
1000:47fa      b9 36 00                 MOV CX,0x36
1000:47fd      ba 68 00                 MOV DX,0x68
1000:4800      e8 66 0e                 CALL 0x1000:5669
1000:4803      e8 4e 0d                 CALL 0x1000:5554
                ; cstring -> 1000:4811  <c1>Computer 
1000:4811  LAB_1000_4811:
1000:4811      80 7c 0e 0c              CMP byte ptr [SI + 0xe],0xc
1000:4815      73 0b                    JNC 0x1000:4822
1000:4817      e8 3a 0d                 CALL 0x1000:5554
                ; cstring -> 1000:4820  Ready
1000:4820  LAB_1000_4820:
1000:4820      eb 09                    JMP 0x1000:482b
1000:4822  LAB_1000_4822:
1000:4822      e8 2f 0d                 CALL 0x1000:5554
                ; cstring -> 1000:482b  <c2>INOP
1000:482b  LAB_1000_482b:
1000:482b      b9 36 00                 MOV CX,0x36
1000:482e      ba 70 00                 MOV DX,0x70
1000:4831      e8 35 0e                 CALL 0x1000:5669
1000:4834      e8 1d 0d                 CALL 0x1000:5554
                ; cstring -> 1000:4842  <c1>Fire Ctl 
1000:4842  LAB_1000_4842:
1000:4842      8a 44 2b                 MOV AL,byte ptr [SI + 0x2b]
1000:4845      3a 44 17                 CMP AL,byte ptr [SI + 0x17]
1000:4848      74 06                    JZ 0x1000:4850
1000:484a      24 03                    AND AL,0x3
1000:484c      04 41                    ADD AL,0x41
1000:484e      eb 02                    JMP 0x1000:4852
1000:4850  LAB_1000_4850:
1000:4850      b0 2a                    MOV AL,0x2a
1000:4852  LAB_1000_4852:
1000:4852      e8 22 0d                 CALL 0x1000:5577
1000:4855  LAB_1000_4855:
1000:4855      b9 36 00                 MOV CX,0x36
1000:4858      ba 80 00                 MOV DX,0x80
1000:485b      e8 0b 0e                 CALL 0x1000:5669
1000:485e      e8 6d d6                 CALL 0x1000:1ece
                ; ptr table -> 1000:4869  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
1000:4869  LAB_1000_4869:
1000:4869      80 7f 0d 00              CMP byte ptr [BX + 0xd],0x0
1000:486d      75 15                    JNZ 0x1000:4884
1000:486f      e8 e2 0c                 CALL 0x1000:5554
                ; cstring -> 1000:4881  <c1>   BASE DEAD!
1000:4881  LAB_1000_4881:
1000:4881      e9 89 00                 JMP 0x1000:490d
1000:4884  LAB_1000_4884:
1000:4884      8a 07                    MOV AL,byte ptr [BX]
1000:4886      a8 80                    TEST AL,0x80
1000:4888      74 09                    JZ 0x1000:4893
1000:488a      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
1000:488f      74 2b                    JZ 0x1000:48bc
1000:4891      eb 1e                    JMP 0x1000:48b1
1000:4893  LAB_1000_4893:
1000:4893      24 07                    AND AL,0x7
1000:4895      75 0b                    JNZ 0x1000:48a2
1000:4897      e8 ba 0c                 CALL 0x1000:5554
                ; cstring -> 1000:48a0  <c1>Base
1000:48a0  LAB_1000_48a0:
1000:48a0      eb 23                    JMP 0x1000:48c5
1000:48a2  LAB_1000_48a2:
1000:48a2      3c 01                    CMP AL,0x1
1000:48a4      75 0b                    JNZ 0x1000:48b1
1000:48a6      e8 ab 0c                 CALL 0x1000:5554
                ; cstring -> 1000:48af  <c3>Base
1000:48af  LAB_1000_48af:
1000:48af      eb 14                    JMP 0x1000:48c5
1000:48b1  LAB_1000_48b1:
1000:48b1      e8 a0 0c                 CALL 0x1000:5554
                ; cstring -> 1000:48ba  <c2>Base
1000:48ba  LAB_1000_48ba:
1000:48ba      eb 09                    JMP 0x1000:48c5
1000:48bc  LAB_1000_48bc:
1000:48bc      e8 95 0c                 CALL 0x1000:5554
                ; cstring -> 1000:48c5  <c1>    
1000:48c5  LAB_1000_48c5:
1000:48c5      e8 8c 0c                 CALL 0x1000:5554
                ; cstring -> 1000:48ce  <c1>  E=
1000:48ce  LAB_1000_48ce:
1000:48ce      e8 fd d5                 CALL 0x1000:1ece
                ; ptr table -> 1000:48d9  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
1000:48d9  LAB_1000_48d9:
1000:48d9      8b f3                    MOV SI,BX
1000:48db      8b 44 08                 MOV AX,word ptr [SI + 0x8]
1000:48de      e8 2d 0b                 CALL 0x1000:540e
1000:48e1      e8 70 0c                 CALL 0x1000:5554
                ; cstring -> 1000:48e6  0
1000:48e6  LAB_1000_48e6:
1000:48e6      b9 36 00                 MOV CX,0x36
1000:48e9      ba 88 00                 MOV DX,0x88
1000:48ec      e8 7a 0d                 CALL 0x1000:5669
1000:48ef      e8 62 0c                 CALL 0x1000:5554
                ; cstring -> 1000:48f5  T=
1000:48f5  LAB_1000_48f5:
1000:48f5      8a 44 07                 MOV AL,byte ptr [SI + 0x7]
1000:48f8      b3 20                    MOV BL,0x20
1000:48fa      e8 1f 0b                 CALL 0x1000:541c
1000:48fd      e8 54 0c                 CALL 0x1000:5554
                ; cstring -> 1000:4905    M=
1000:4905  LAB_1000_4905:
1000:4905      8a 44 06                 MOV AL,byte ptr [SI + 0x6]
1000:4908      b3 20                    MOV BL,0x20
1000:490a      e8 16 0b                 CALL 0x1000:5423
1000:490d  LAB_1000_490d:
1000:490d      e8 4c 0a                 CALL 0x1000:535c
1000:4910      f6 07 10                 TEST byte ptr [BX],0x10
1000:4913      74 03                    JZ 0x1000:4918
1000:4915      e8 27 01                 CALL 0x1000:4a3f
1000:4918  LAB_1000_4918:
1000:4918      e8 53 00                 CALL 0x1000:496e
1000:491b      e8 01 00                 CALL 0x1000:491f
1000:491e      c3                       RET

; ------------------------------------------------------------
1000:491f  FUN_1000_491f:
1000:491f      c6 06 9b a2 03           MOV byte ptr [0xa29b],0x3
1000:4924      f6 06 12 00 01           TEST byte ptr [0x12],0x1
1000:4929      74 17                    JZ 0x1000:4942
1000:492b      b9 40 00                 MOV CX,0x40
1000:492e      ba bb 00                 MOV DX,0xbb
1000:4931      e8 35 0d                 CALL 0x1000:5669
1000:4934      80 3e 07 a2 00           CMP byte ptr [0xa207],0x0
1000:4939      75 1d                    JNZ 0x1000:4958
1000:493b      c6 06 9b a2 02           MOV byte ptr [0xa29b],0x2
1000:4940      eb 16                    JMP 0x1000:4958
1000:4942  LAB_1000_4942:
1000:4942      b9 3c 00                 MOV CX,0x3c
1000:4945      ba bb 00                 MOV DX,0xbb
1000:4948      e8 1e 0d                 CALL 0x1000:5669
1000:494b      a0 08 a2                 MOV AL,[0xa208]
1000:494e      b3 30                    MOV BL,0x30
1000:4950      e8 d0 0a                 CALL 0x1000:5423
1000:4953      e8 fe 0b                 CALL 0x1000:5554
                ; cstring -> 1000:4958  :
1000:4958  LAB_1000_4958:
1000:4958      a0 07 a2                 MOV AL,[0xa207]
1000:495b      b3 30                    MOV BL,0x30
1000:495d      e8 c3 0a                 CALL 0x1000:5423
1000:4960      e8 f1 0b                 CALL 0x1000:5554
                ; cstring -> 1000:4965  :
1000:4965  LAB_1000_4965:
1000:4965      a0 06 a2                 MOV AL,[0xa206]
1000:4968      b3 30                    MOV BL,0x30
1000:496a      e8 b6 0a                 CALL 0x1000:5423
1000:496d      c3                       RET

; ------------------------------------------------------------
1000:496e  FUN_1000_496e:
1000:496e      e8 5d d5                 CALL 0x1000:1ece
                ; ptr table -> 1000:4979  [ptr] 1000:8c64 1000:8d50 1000:8e3c 1000:8f28
1000:4979  LAB_1000_4979:
1000:4979      8b f3                    MOV SI,BX
1000:497b      b0 00                    MOV AL,0x0
1000:497d  LAB_1000_497d:
1000:497d      f6 04 80                 TEST byte ptr [SI],0x80
1000:4980      75 03                    JNZ 0x1000:4985
1000:4982      e9 a7 00                 JMP 0x1000:4a2c
1000:4985  LAB_1000_4985:
1000:4985      50                       PUSH AX
1000:4986      b9 36 00                 MOV CX,0x36
1000:4989      02 c0                    ADD AL,AL
1000:498b      02 c0                    ADD AL,AL
1000:498d      02 c0                    ADD AL,AL
1000:498f      8a d0                    MOV DL,AL
1000:4991      32 f6                    XOR DH,DH
1000:4993      81 c2 98 00              ADD DX,0x98
1000:4997      e8 cf 0c                 CALL 0x1000:5669
1000:499a      f6 44 0e ff              TEST byte ptr [SI + 0xe],0xff
1000:499e      74 0c                    JZ 0x1000:49ac
1000:49a0      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
1000:49a5      74 05                    JZ 0x1000:49ac
1000:49a7      b8 20 00                 MOV AX,0x20
1000:49aa      eb 06                    JMP 0x1000:49b2
1000:49ac  LAB_1000_49ac:
1000:49ac      58                       POP AX
1000:49ad      50                       PUSH AX
1000:49ae      04 31                    ADD AL,0x31
1000:49b0      32 e4                    XOR AH,AH
1000:49b2  LAB_1000_49b2:
1000:49b2      e8 c6 0b                 CALL 0x1000:557b
1000:49b5      f6 04 10                 TEST byte ptr [SI],0x10
1000:49b8      b8 20 00                 MOV AX,0x20
1000:49bb      74 10                    JZ 0x1000:49cd
1000:49bd      f6 44 19 f0              TEST byte ptr [SI + 0x19],0xf0
1000:49c1      74 07                    JZ 0x1000:49ca
1000:49c3      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
1000:49c8      75 03                    JNZ 0x1000:49cd
1000:49ca  LAB_1000_49ca:
1000:49ca      b8 1f 00                 MOV AX,0x1f
1000:49cd  LAB_1000_49cd:
1000:49cd      e8 ab 0b                 CALL 0x1000:557b
1000:49d0      c6 06 9b a2 01           MOV byte ptr [0xa29b],0x1
1000:49d5      8b 44 08                 MOV AX,word ptr [SI + 0x8]
1000:49d8      e8 33 0a                 CALL 0x1000:540e
1000:49db      f6 44 11 80              TEST byte ptr [SI + 0x11],0x80
1000:49df      b8 1e 02                 MOV AX,0x21e
1000:49e2      75 03                    JNZ 0x1000:49e7
1000:49e4      b8 20 00                 MOV AX,0x20
1000:49e7  LAB_1000_49e7:
1000:49e7      e8 91 0b                 CALL 0x1000:557b
1000:49ea      e8 96 01                 CALL 0x1000:4b83
1000:49ed      e8 a3 01                 CALL 0x1000:4b93
1000:49f0      80 7c 2a 00              CMP byte ptr [SI + 0x2a],0x0
1000:49f4      b8 20 00                 MOV AX,0x20
1000:49f7      74 21                    JZ 0x1000:4a1a
1000:49f9      b0 4d                    MOV AL,0x4d
1000:49fb      80 7c 2a 06              CMP byte ptr [SI + 0x2a],0x6
1000:49ff      77 0a                    JA 0x1000:4a0b
1000:4a01      b4 03                    MOV AH,0x3
1000:4a03      80 7c 2a 03              CMP byte ptr [SI + 0x2a],0x3
1000:4a07      77 02                    JA 0x1000:4a0b
1000:4a09      b4 02                    MOV AH,0x2
1000:4a0b  LAB_1000_4a0b:
1000:4a0b      80 7c 22 00              CMP byte ptr [SI + 0x22],0x0
1000:4a0f      74 09                    JZ 0x1000:4a1a
1000:4a11      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
1000:4a16      74 02                    JZ 0x1000:4a1a
1000:4a18      b0 20                    MOV AL,0x20
1000:4a1a  LAB_1000_4a1a:
1000:4a1a      e8 5e 0b                 CALL 0x1000:557b
1000:4a1d      f6 04 20                 TEST byte ptr [SI],0x20
1000:4a20      b8 53 00                 MOV AX,0x53
1000:4a23      75 03                    JNZ 0x1000:4a28
1000:4a25      b8 20 00                 MOV AX,0x20
1000:4a28  LAB_1000_4a28:
1000:4a28      e8 50 0b                 CALL 0x1000:557b
1000:4a2b      58                       POP AX
1000:4a2c  LAB_1000_4a2c:
1000:4a2c      fe c0                    INC AL
1000:4a2e      83 c6 3b                 ADD SI,0x3b
1000:4a31      3c 04                    CMP AL,0x4
1000:4a33      74 03                    JZ 0x1000:4a38
1000:4a35      e9 45 ff                 JMP 0x1000:497d
1000:4a38  LAB_1000_4a38:
1000:4a38      c3                       RET

; ------------------------------------------------------------
1000:4a3f  FUN_1000_4a3f:
1000:4a3f      b8 00 00                 MOV AX,0x0
1000:4a42      c7 06 28 01 00 00        MOV word ptr [0x128],0x0
1000:4a48  LAB_1000_4a48:
1000:4a48      50                       PUSH AX
1000:4a49      3a 06 74 a2              CMP AL,byte ptr [0xa274]
1000:4a4d      b0 01                    MOV AL,0x1
1000:4a4f      74 02                    JZ 0x1000:4a53
1000:4a51      b0 02                    MOV AL,0x2
1000:4a53  LAB_1000_4a53:
1000:4a53      a2 9b a2                 MOV [0xa29b],AL
1000:4a56      b9 3a 00                 MOV CX,0x3a
1000:4a59      8b 16 28 01              MOV DX,word ptr [0x128]
1000:4a5d      e8 09 0c                 CALL 0x1000:5669
1000:4a60      58                       POP AX
1000:4a61      50                       PUSH AX
1000:4a62      b4 0b                    MOV AH,0xb
1000:4a64      f6 e4                    MUL AH
1000:4a66      be 26 a2                 MOV SI,0xa226
1000:4a69      03 f0                    ADD SI,AX
1000:4a6b      8a 04                    MOV AL,byte ptr [SI]
1000:4a6d      22 c0                    AND AL,AL
1000:4a6f      75 02                    JNZ 0x1000:4a73
1000:4a71      58                       POP AX
1000:4a72      c3                       RET
1000:4a73  LAB_1000_4a73:
1000:4a73      58                       POP AX
1000:4a74      50                       PUSH AX
1000:4a75      56                       PUSH SI
1000:4a76      04 41                    ADD AL,0x41
1000:4a78      e8 fc 0a                 CALL 0x1000:5577
1000:4a7b      b0 3d                    MOV AL,0x3d
1000:4a7d      e8 f7 0a                 CALL 0x1000:5577
1000:4a80      5e                       POP SI
1000:4a81      b9 03 00                 MOV CX,0x3
1000:4a84  LAB_1000_4a84:
1000:4a84      ac                       LODSB SI
1000:4a85      e8 ef 0a                 CALL 0x1000:5577
1000:4a88      e2 fa                    LOOP 0x1000:4a84
1000:4a8a      b0 20                    MOV AL,0x20
1000:4a8c      e8 e8 0a                 CALL 0x1000:5577
1000:4a8f      5b                       POP BX
1000:4a90      53                       PUSH BX
1000:4a91      8a 87 e0 89              MOV AL,byte ptr [BX + 0x89e0]
1000:4a95      50                       PUSH AX
1000:4a96      22 c0                    AND AL,AL
1000:4a98      74 0b                    JZ 0x1000:4aa5
1000:4a9a      e8 b7 0a                 CALL 0x1000:5554
                ; cstring -> 1000:4aa3  (OUT)
1000:4aa3  LAB_1000_4aa3:
1000:4aa3      eb 09                    JMP 0x1000:4aae
1000:4aa5  LAB_1000_4aa5:
1000:4aa5      d1 e3                    SHL BX,0x1
1000:4aa7      8b 87 e4 89              MOV AX,word ptr [BX + 0x89e4]
1000:4aab      e8 60 09                 CALL 0x1000:540e
1000:4aae  LAB_1000_4aae:
1000:4aae      b9 36 00                 MOV CX,0x36
1000:4ab1      83 06 28 01 08           ADD word ptr [0x128],0x8
1000:4ab6      8b 16 28 01              MOV DX,word ptr [0x128]
1000:4aba      e8 ac 0b                 CALL 0x1000:5669
1000:4abd      58                       POP AX
1000:4abe      22 c0                    AND AL,AL
1000:4ac0      74 56                    JZ 0x1000:4b18
1000:4ac2      24 0f                    AND AL,0xf
1000:4ac4      fe c8                    DEC AL
1000:4ac6      75 0f                    JNZ 0x1000:4ad7
1000:4ac8      e8 89 0a                 CALL 0x1000:5554
                ; cstring -> 1000:4ad4  NO SHIPS
1000:4ad4  LAB_1000_4ad4:
1000:4ad4      eb 3a                    JMP 0x1000:4b10
1000:4ad7  LAB_1000_4ad7:
1000:4ad7      fe c8                    DEC AL
1000:4ad9      75 0e                    JNZ 0x1000:4ae9
1000:4adb      e8 76 0a                 CALL 0x1000:5554
                ; cstring -> 1000:4ae6  NO BASE
1000:4ae6  LAB_1000_4ae6:
1000:4ae6      eb 28                    JMP 0x1000:4b10
1000:4ae9  LAB_1000_4ae9:
1000:4ae9      fe c8                    DEC AL
1000:4aeb      75 12                    JNZ 0x1000:4aff
1000:4aed      e8 64 0a                 CALL 0x1000:5554
                ; cstring -> 1000:4afc  SURRENDERED
1000:4afc  LAB_1000_4afc:
1000:4afc      eb 12                    JMP 0x1000:4b10
1000:4aff  LAB_1000_4aff:
1000:4aff      e8 52 0a                 CALL 0x1000:5554
                ; cstring -> 1000:4b10  **** TIE ****
1000:4b10  LAB_1000_4b10:
1000:4b10      83 06 28 01 08           ADD word ptr [0x128],0x8
1000:4b15      eb 57                    JMP 0x1000:4b6e
1000:4b18  LAB_1000_4b18:
1000:4b18      e8 39 0a                 CALL 0x1000:5554
                ; cstring -> 1000:4b1e  E=
1000:4b1e  LAB_1000_4b1e:
1000:4b1e      58                       POP AX
1000:4b1f      50                       PUSH AX
1000:4b20      b4 ec                    MOV AH,0xec
1000:4b22      f6 e4                    MUL AH
1000:4b24      be 64 8c                 MOV SI,0x8c64
1000:4b27      03 f0                    ADD SI,AX
1000:4b29      b9 04 00                 MOV CX,0x4
1000:4b2c      bb 00 00                 MOV BX,0x0
1000:4b2f  LAB_1000_4b2f:
1000:4b2f      f6 04 80                 TEST byte ptr [SI],0x80
1000:4b32      74 0f                    JZ 0x1000:4b43
1000:4b34      51                       PUSH CX
1000:4b35      b9 0a 00                 MOV CX,0xa
1000:4b38      8b 44 08                 MOV AX,word ptr [SI + 0x8]
1000:4b3b      ba 00 00                 MOV DX,0x0
1000:4b3e      f7 f1                    DIV CX
1000:4b40      59                       POP CX
1000:4b41      03 d8                    ADD BX,AX
1000:4b43  LAB_1000_4b43:
1000:4b43      83 c6 3b                 ADD SI,0x3b
1000:4b46      e2 e7                    LOOP 0x1000:4b2f
1000:4b48      58                       POP AX
1000:4b49      50                       PUSH AX
1000:4b4a      b4 0e                    MOV AH,0xe
1000:4b4c      f6 e4                    MUL AH
1000:4b4e      be 14 90                 MOV SI,0x9014
1000:4b51      03 f0                    ADD SI,AX
1000:4b53      03 5c 08                 ADD BX,word ptr [SI + 0x8]
1000:4b56      8b c3                    MOV AX,BX
1000:4b58      e8 b3 08                 CALL 0x1000:540e
1000:4b5b      e8 f6 09                 CALL 0x1000:5554
                ; cstring -> 1000:4b63  0 #=
1000:4b63  LAB_1000_4b63:
1000:4b63      5b                       POP BX
1000:4b64      53                       PUSH BX
1000:4b65      8a 87 dc 89              MOV AL,byte ptr [BX + 0x89dc]
1000:4b69      b3 20                    MOV BL,0x20
1000:4b6b      e8 b5 08                 CALL 0x1000:5423
1000:4b6e  LAB_1000_4b6e:
1000:4b6e      83 06 28 01 08           ADD word ptr [0x128],0x8
1000:4b73      83 06 28 01 08           ADD word ptr [0x128],0x8
1000:4b78      58                       POP AX
1000:4b79      fe c0                    INC AL
1000:4b7b      3c 04                    CMP AL,0x4
1000:4b7d      73 03                    JNC 0x1000:4b82
1000:4b7f      e9 c6 fe                 JMP 0x1000:4a48
1000:4b82  LAB_1000_4b82:
1000:4b82      c3                       RET

; ------------------------------------------------------------
1000:4b83  FUN_1000_4b83:
1000:4b83      8a 5c 11                 MOV BL,byte ptr [SI + 0x11]
1000:4b86      81 e3 1f 00              AND BX,0x1f
1000:4b8a      8a 87 10 01              MOV AL,byte ptr [BX + 0x110]
1000:4b8e      b4 00                    MOV AH,0x0
1000:4b90      e9 e8 09                 JMP 0x1000:557b

; ------------------------------------------------------------
1000:4b93  FUN_1000_4b93:
1000:4b93      8a 04                    MOV AL,byte ptr [SI]
1000:4b95      24 07                    AND AL,0x7
1000:4b97      8a c8                    MOV CL,AL
1000:4b99      8a 44 0e                 MOV AL,byte ptr [SI + 0xe]
1000:4b9c      22 c0                    AND AL,AL
1000:4b9e      74 0c                    JZ 0x1000:4bac
1000:4ba0      3c 05                    CMP AL,0x5
1000:4ba2      77 06                    JA 0x1000:4baa
1000:4ba4      8a c1                    MOV AL,CL
1000:4ba6      24 02                    AND AL,0x2
1000:4ba8      74 02                    JZ 0x1000:4bac
1000:4baa  LAB_1000_4baa:
1000:4baa      b0 03                    MOV AL,0x3
1000:4bac  LAB_1000_4bac:
1000:4bac      0a c1                    OR AL,CL
1000:4bae      8a c8                    MOV CL,AL
1000:4bb0      8a c1                    MOV AL,CL
1000:4bb2      24 03                    AND AL,0x3
1000:4bb4      bb 0f 4c                 MOV BX,0x4c0f
1000:4bb7      32 e4                    XOR AH,AH
1000:4bb9      03 d8                    ADD BX,AX
1000:4bbb      03 d8                    ADD BX,AX
1000:4bbd      2e 8b 07                 MOV AX,word ptr CS:[BX]
1000:4bc0      51                       PUSH CX
1000:4bc1      e8 b7 09                 CALL 0x1000:557b
1000:4bc4      59                       POP CX
1000:4bc5      80 e1 04                 AND CL,0x4
1000:4bc8      b8 20 00                 MOV AX,0x20
1000:4bcb      74 03                    JZ 0x1000:4bd0
1000:4bcd      b8 44 00                 MOV AX,0x44
1000:4bd0  LAB_1000_4bd0:
1000:4bd0      e8 a8 09                 CALL 0x1000:557b
1000:4bd3      8a 64 16                 MOV AH,byte ptr [SI + 0x16]
1000:4bd6      22 e4                    AND AH,AH
1000:4bd8      74 20                    JZ 0x1000:4bfa
1000:4bda      8a 1e 96 a2              MOV BL,byte ptr [0xa296]
1000:4bde  LAB_1000_4bde:
1000:4bde      80 c3 02                 ADD BL,0x2
1000:4be1      81 e3 0e 00              AND BX,0xe
1000:4be5      2e 84 a7 ff 4b           TEST byte ptr CS:[BX + 0x4bff],AH
1000:4bea      74 f2                    JZ 0x1000:4bde
1000:4bec      88 1e 96 a2              MOV byte ptr [0xa296],BL
1000:4bf0      b4 02                    MOV AH,0x2
1000:4bf2      2e 8a 87 00 4c           MOV AL,byte ptr CS:[BX + 0x4c00]
1000:4bf7      e9 81 09                 JMP 0x1000:557b
1000:4bfa  LAB_1000_4bfa:
1000:4bfa      b0 20                    MOV AL,0x20
1000:4bfc      e9 7c 09                 JMP 0x1000:557b

; ------------------------------------------------------------
1000:4c17  FUN_1000_4c17:
1000:4c17      e8 1c 06                 CALL 0x1000:5236
1000:4c1a      e8 09 04                 CALL 0x1000:5026
1000:4c1d      e8 63 01                 CALL 0x1000:4d83
1000:4c20      e8 83 02                 CALL 0x1000:4ea6
1000:4c23      e8 c5 00                 CALL 0x1000:4ceb
1000:4c26      e8 0a 00                 CALL 0x1000:4c33
1000:4c29      e8 be 02                 CALL 0x1000:4eea
1000:4c2c      e8 5f 03                 CALL 0x1000:4f8e
1000:4c2f      e8 26 04                 CALL 0x1000:5058
1000:4c32      c3                       RET

; ------------------------------------------------------------
1000:4c33  FUN_1000_4c33:
1000:4c33      bf 64 8c                 MOV DI,0x8c64
1000:4c36      b9 10 00                 MOV CX,0x10
1000:4c39  LAB_1000_4c39:
1000:4c39      8a 45 19                 MOV AL,byte ptr [DI + 0x19]
1000:4c3c      a8 ff                    TEST AL,0xff
1000:4c3e      74 3a                    JZ 0x1000:4c7a
1000:4c40      3c 04                    CMP AL,0x4
1000:4c42      72 10                    JC 0x1000:4c54
1000:4c44      a8 80                    TEST AL,0x80
1000:4c46      74 22                    JZ 0x1000:4c6a
1000:4c48      3c 84                    CMP AL,0x84
1000:4c4a      72 2e                    JC 0x1000:4c7a
1000:4c4c      bd 37 28                 MOV BP,0x2837
1000:4c4f      e8 2e 00                 CALL 0x1000:4c80
1000:4c52      eb 1c                    JMP 0x1000:4c70
1000:4c54  LAB_1000_4c54:
1000:4c54      bd 3f 28                 MOV BP,0x283f
1000:4c57      fe c8                    DEC AL
1000:4c59      be 73 13                 MOV SI,0x1373
1000:4c5c      74 12                    JZ 0x1000:4c70
1000:4c5e      fe c8                    DEC AL
1000:4c60      be 3b 13                 MOV SI,0x133b
1000:4c63      74 0b                    JZ 0x1000:4c70
1000:4c65      be 1d 13                 MOV SI,0x131d
1000:4c68      eb 06                    JMP 0x1000:4c70
1000:4c6a  LAB_1000_4c6a:
1000:4c6a      bd 3f 28                 MOV BP,0x283f
1000:4c6d      e8 56 00                 CALL 0x1000:4cc6
1000:4c70  LAB_1000_4c70:
1000:4c70      51                       PUSH CX
1000:4c71      57                       PUSH DI
1000:4c72      83 c7 19                 ADD DI,0x19
1000:4c75      e8 e7 06                 CALL 0x1000:535f
1000:4c78      5f                       POP DI
1000:4c79      59                       POP CX
1000:4c7a  LAB_1000_4c7a:
1000:4c7a      83 c7 3b                 ADD DI,0x3b
1000:4c7d      e2 ba                    LOOP 0x1000:4c39
1000:4c7f      c3                       RET

; ------------------------------------------------------------
1000:4c80  FUN_1000_4c80:
1000:4c80      b3 8c                    MOV BL,0x8c
1000:4c82      3a c3                    CMP AL,BL
1000:4c84      76 0a                    JBE 0x1000:4c90
1000:4c86      3c c4                    CMP AL,0xc4
1000:4c88      76 24                    JBE 0x1000:4cae
1000:4c8a      b3 c9                    MOV BL,0xc9
1000:4c8c      3a c3                    CMP AL,BL
1000:4c8e      77 1e                    JA 0x1000:4cae
1000:4c90  LAB_1000_4c90:
1000:4c90      2a d8                    SUB BL,AL
1000:4c92      32 ff                    XOR BH,BH
1000:4c94      80 3e 70 a2 02           CMP byte ptr [0xa270],0x2
1000:4c99      76 0b                    JBE 0x1000:4ca6
1000:4c9b      d1 eb                    SHR BX,0x1
1000:4c9d      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
1000:4ca2      76 02                    JBE 0x1000:4ca6
1000:4ca4      d1 eb                    SHR BX,0x1
1000:4ca6  LAB_1000_4ca6:
1000:4ca6      d1 e3                    SHL BX,0x1
1000:4ca8      2e 8b b7 b2 4c           MOV SI,word ptr CS:[BX + 0x4cb2]
1000:4cad      c3                       RET
1000:4cae  LAB_1000_4cae:
1000:4cae      be 37 28                 MOV SI,0x2837
1000:4cb1      c3                       RET

; ------------------------------------------------------------
1000:4cc6  FUN_1000_4cc6:
1000:4cc6      8a 45 17                 MOV AL,byte ptr [DI + 0x17]
1000:4cc9      3a 06 74 a2              CMP AL,byte ptr [0xa274]
1000:4ccd      74 0e                    JZ 0x1000:4cdd
1000:4ccf      be af 12                 MOV SI,0x12af
1000:4cd2      a0 d2 89                 MOV AL,[0x89d2]
1000:4cd5      24 01                    AND AL,0x1
1000:4cd7      74 11                    JZ 0x1000:4cea
1000:4cd9      be c5 12                 MOV SI,0x12c5
1000:4cdc      c3                       RET
1000:4cdd  LAB_1000_4cdd:
1000:4cdd      be f1 12                 MOV SI,0x12f1
1000:4ce0      a0 d2 89                 MOV AL,[0x89d2]
1000:4ce3      24 01                    AND AL,0x1
1000:4ce5      74 03                    JZ 0x1000:4cea
1000:4ce7      be db 12                 MOV SI,0x12db
1000:4cea  LAB_1000_4cea:
1000:4cea      c3                       RET

; ------------------------------------------------------------
1000:4ceb  FUN_1000_4ceb:
1000:4ceb      b0 00                    MOV AL,0x0
1000:4ced      bf 14 90                 MOV DI,0x9014
1000:4cf0  LAB_1000_4cf0:
1000:4cf0      50                       PUSH AX
1000:4cf1      8a 65 0d                 MOV AH,byte ptr [DI + 0xd]
1000:4cf4      22 e4                    AND AH,AH
1000:4cf6      74 7d                    JZ 0x1000:4d75
1000:4cf8      80 fc 04                 CMP AH,0x4
1000:4cfb      74 17                    JZ 0x1000:4d14
1000:4cfd      be 2d 26                 MOV SI,0x262d
1000:4d00      bd 21 28                 MOV BP,0x2821
1000:4d03      fe cc                    DEC AH
1000:4d05      74 2d                    JZ 0x1000:4d34
1000:4d07      be 71 26                 MOV SI,0x2671
1000:4d0a      fe cc                    DEC AH
1000:4d0c      74 26                    JZ 0x1000:4d34
1000:4d0e      be f3 26                 MOV SI,0x26f3
1000:4d11      eb 21                    JMP 0x1000:4d34
1000:4d14  LAB_1000_4d14:
1000:4d14      3a 06 74 a2              CMP AL,byte ptr [0xa274]
1000:4d18      75 20                    JNZ 0x1000:4d3a
1000:4d1a      bd 0b 1d                 MOV BP,0x1d0b
1000:4d1d      be 13 19                 MOV SI,0x1913
1000:4d20      80 3e 70 a2 02           CMP byte ptr [0xa270],0x2
1000:4d25      76 0d                    JBE 0x1000:4d34
1000:4d27      be 0b 1c                 MOV SI,0x1c0b
1000:4d2a      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
1000:4d2f      76 03                    JBE 0x1000:4d34
1000:4d31      be df 1c                 MOV SI,0x1cdf
1000:4d34  LAB_1000_4d34:
1000:4d34      e8 28 06                 CALL 0x1000:535f
1000:4d37      eb 3c                    JMP 0x1000:4d75
1000:4d3a  LAB_1000_4d3a:
1000:4d3a      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
1000:4d3f      77 24                    JA 0x1000:4d65
1000:4d41      bd 13 1d                 MOV BP,0x1d13
1000:4d44      be 8f 1a                 MOV SI,0x1a8f
1000:4d47      80 3e 70 a2 02           CMP byte ptr [0xa270],0x2
1000:4d4c      76 0d                    JBE 0x1000:4d5b
1000:4d4e      be 75 1c                 MOV SI,0x1c75
1000:4d51      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
1000:4d56      76 03                    JBE 0x1000:4d5b
1000:4d58      be f5 1c                 MOV SI,0x1cf5
1000:4d5b  LAB_1000_4d5b:
1000:4d5b      e8 01 06                 CALL 0x1000:535f
1000:4d5e      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
1000:4d63      74 10                    JZ 0x1000:4d75
1000:4d65  LAB_1000_4d65:
1000:4d65      58                       POP AX
1000:4d66      50                       PUSH AX
1000:4d67      b4 1e                    MOV AH,0x1e
1000:4d69      f6 e4                    MUL AH
1000:4d6b      be eb 01                 MOV SI,0x1eb
1000:4d6e      03 f0                    ADD SI,AX
1000:4d70      8b ee                    MOV BP,SI
1000:4d72      e8 ea 05                 CALL 0x1000:535f
1000:4d75  LAB_1000_4d75:
1000:4d75      83 c7 0e                 ADD DI,0xe
1000:4d78      58                       POP AX
1000:4d79      fe c0                    INC AL
1000:4d7b      3c 04                    CMP AL,0x4
1000:4d7d      73 03                    JNC 0x1000:4d82
1000:4d7f      e9 6e ff                 JMP 0x1000:4cf0
1000:4d82  LAB_1000_4d82:
1000:4d82      c3                       RET

; ------------------------------------------------------------
1000:4d83  FUN_1000_4d83:
1000:4d83      8b 36 97 a2              MOV SI,word ptr [0xa297]
1000:4d87      e8 9b e4                 CALL 0x1000:3225
1000:4d8a  LAB_1000_4d8a:
1000:4d8a      51                       PUSH CX
1000:4d8b      a0 74 a2                 MOV AL,[0xa274]
1000:4d8e      24 03                    AND AL,0x3
1000:4d90      b4 80                    MOV AH,0x80
1000:4d92      74 0e                    JZ 0x1000:4da2
1000:4d94      b4 40                    MOV AH,0x40
1000:4d96      fe c8                    DEC AL
1000:4d98      74 08                    JZ 0x1000:4da2
1000:4d9a      b4 20                    MOV AH,0x20
1000:4d9c      fe c8                    DEC AL
1000:4d9e      74 02                    JZ 0x1000:4da2
1000:4da0      b4 10                    MOV AH,0x10
1000:4da2  LAB_1000_4da2:
1000:4da2      22 25                    AND AH,byte ptr [DI]
1000:4da4      74 7f                    JZ 0x1000:4e25
1000:4da6      8a 05                    MOV AL,byte ptr [DI]
1000:4da8      24 0f                    AND AL,0xf
1000:4daa      75 21                    JNZ 0x1000:4dcd
1000:4dac      80 7d 06 06              CMP byte ptr [DI + 0x6],0x6
1000:4db0      77 09                    JA 0x1000:4dbb
1000:4db2      bd a7 20                 MOV BP,0x20a7
1000:4db5      be 6f 20                 MOV SI,0x206f
1000:4db8      eb 68                    JMP 0x1000:4e22
1000:4dbb  LAB_1000_4dbb:
1000:4dbb      bd 3f 28                 MOV BP,0x283f
1000:4dbe      be ff 1f                 MOV SI,0x1fff
1000:4dc1      80 7d 06 0c              CMP byte ptr [DI + 0x6],0xc
1000:4dc5      77 03                    JA 0x1000:4dca
1000:4dc7      be 37 20                 MOV SI,0x2037
1000:4dca  LAB_1000_4dca:
1000:4dca      eb 56                    JMP 0x1000:4e22
1000:4dcd  LAB_1000_4dcd:
1000:4dcd      3c 0f                    CMP AL,0xf
1000:4dcf      75 13                    JNZ 0x1000:4de4
1000:4dd1      bd 37 28                 MOV BP,0x2837
1000:4dd4      be 37 28                 MOV SI,0x2837
1000:4dd7      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
1000:4ddc      77 44                    JA 0x1000:4e22
1000:4dde      be 2d 24                 MOV SI,0x242d
1000:4de1      eb 3f                    JMP 0x1000:4e22
1000:4de4  LAB_1000_4de4:
1000:4de4      be 37 28                 MOV SI,0x2837
1000:4de7      bd 37 28                 MOV BP,0x2837
1000:4dea      f6 45 06 ff              TEST byte ptr [DI + 0x6],0xff
1000:4dee      75 32                    JNZ 0x1000:4e22
1000:4df0      25 0f 00                 AND AX,0xf
1000:4df3      bb 66 4e                 MOV BX,0x4e66
1000:4df6      03 d8                    ADD BX,AX
1000:4df8      03 d8                    ADD BX,AX
1000:4dfa      03 d8                    ADD BX,AX
1000:4dfc      03 d8                    ADD BX,AX
1000:4dfe      2e 8b 37                 MOV SI,word ptr CS:[BX]
1000:4e01      2e 8b 6f 02              MOV BP,word ptr CS:[BX + 0x2]
1000:4e05      e8 28 00                 CALL 0x1000:4e30
1000:4e08      e8 54 05                 CALL 0x1000:535f
1000:4e0b      80 7d 0a ff              CMP byte ptr [DI + 0xa],0xff
1000:4e0f      74 14                    JZ 0x1000:4e25
1000:4e11      a0 74 a2                 MOV AL,[0xa274]
1000:4e14      3a 45 0a                 CMP AL,byte ptr [DI + 0xa]
1000:4e17      be 0d 17                 MOV SI,0x170d
1000:4e1a      bd 37 28                 MOV BP,0x2837
1000:4e1d      75 03                    JNZ 0x1000:4e22
1000:4e1f      be b7 16                 MOV SI,0x16b7
1000:4e22  LAB_1000_4e22:
1000:4e22      e8 3a 05                 CALL 0x1000:535f
1000:4e25  LAB_1000_4e25:
1000:4e25      59                       POP CX
1000:4e26      83 c7 0b                 ADD DI,0xb
1000:4e29      49                       DEC CX
1000:4e2a      74 03                    JZ 0x1000:4e2f
1000:4e2c      e9 5b ff                 JMP 0x1000:4d8a
1000:4e2f  LAB_1000_4e2f:
1000:4e2f      c3                       RET

; ------------------------------------------------------------
1000:4e30  FUN_1000_4e30:
1000:4e30      83 fe 00                 CMP SI,0x0
1000:4e33      75 30                    JNZ 0x1000:4e65
1000:4e35      8a 45 09                 MOV AL,byte ptr [DI + 0x9]
1000:4e38      be 65 24                 MOV SI,0x2465
1000:4e3b      3c 0a                    CMP AL,0xa
1000:4e3d      72 26                    JC 0x1000:4e65
1000:4e3f      be 6d 24                 MOV SI,0x246d
1000:4e42      3c 19                    CMP AL,0x19
1000:4e44      72 1f                    JC 0x1000:4e65
1000:4e46      be 83 24                 MOV SI,0x2483
1000:4e49      3c 32                    CMP AL,0x32
1000:4e4b      72 18                    JC 0x1000:4e65
1000:4e4d      be a1 24                 MOV SI,0x24a1
1000:4e50      3c 4b                    CMP AL,0x4b
1000:4e52      72 11                    JC 0x1000:4e65
1000:4e54      be d9 24                 MOV SI,0x24d9
1000:4e57      3c 64                    CMP AL,0x64
1000:4e59      72 0a                    JC 0x1000:4e65
1000:4e5b      be 1d 25                 MOV SI,0x251d
1000:4e5e      3c 7d                    CMP AL,0x7d
1000:4e60      72 03                    JC 0x1000:4e65
1000:4e62      be 87 25                 MOV SI,0x2587
1000:4e65  LAB_1000_4e65:
1000:4e65      c3                       RET

; ------------------------------------------------------------
1000:4ea6  FUN_1000_4ea6:
1000:4ea6      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
1000:4eab      76 01                    JBE 0x1000:4eae
1000:4ead      c3                       RET
1000:4eae  LAB_1000_4eae:
1000:4eae      b0 00                    MOV AL,0x0
1000:4eb0      bf 4c 90                 MOV DI,0x904c
1000:4eb3  LAB_1000_4eb3:
1000:4eb3      b9 14 00                 MOV CX,0x14
1000:4eb6  LAB_1000_4eb6:
1000:4eb6      80 3d 00                 CMP byte ptr [DI],0x0
1000:4eb9      74 23                    JZ 0x1000:4ede
1000:4ebb      3a 06 74 a2              CMP AL,byte ptr [0xa274]
1000:4ebf      be a3 18                 MOV SI,0x18a3
1000:4ec2      74 03                    JZ 0x1000:4ec7
1000:4ec4      be c1 18                 MOV SI,0x18c1
1000:4ec7  LAB_1000_4ec7:
1000:4ec7      80 3d 02                 CMP byte ptr [DI],0x2
1000:4eca      77 08                    JA 0x1000:4ed4
1000:4ecc      be d7 18                 MOV SI,0x18d7
1000:4ecf      74 03                    JZ 0x1000:4ed4
1000:4ed1      be f5 18                 MOV SI,0x18f5
1000:4ed4  LAB_1000_4ed4:
1000:4ed4      50                       PUSH AX
1000:4ed5      51                       PUSH CX
1000:4ed6      bd 37 28                 MOV BP,0x2837
1000:4ed9      e8 83 04                 CALL 0x1000:535f
1000:4edc      59                       POP CX
1000:4edd      58                       POP AX
1000:4ede  LAB_1000_4ede:
1000:4ede      83 c7 08                 ADD DI,0x8
1000:4ee1      e2 d3                    LOOP 0x1000:4eb6
1000:4ee3      fe c0                    INC AL
1000:4ee5      3c 04                    CMP AL,0x4
1000:4ee7      72 ca                    JC 0x1000:4eb3
1000:4ee9      c3                       RET

; ------------------------------------------------------------
1000:4eea  FUN_1000_4eea:
1000:4eea      e8 e1 cf                 CALL 0x1000:1ece
                ; ptr table -> 1000:4ef5  [ptr] 1000:8c64 1000:8d50 1000:8e3c 1000:8f28
1000:4ef5  LAB_1000_4ef5:
1000:4ef5      8b fb                    MOV DI,BX
1000:4ef7      b9 00 00                 MOV CX,0x0
1000:4efa  LAB_1000_4efa:
1000:4efa      51                       PUSH CX
1000:4efb      be 37 28                 MOV SI,0x2837
1000:4efe      e8 dc 02                 CALL 0x1000:51dd
1000:4f01      74 60                    JZ 0x1000:4f63
1000:4f03      e8 56 04                 CALL 0x1000:535c
1000:4f06      8a 07                    MOV AL,byte ptr [BX]
1000:4f08      24 c0                    AND AL,0xc0
1000:4f0a      3c 40                    CMP AL,0x40
1000:4f0c      75 07                    JNZ 0x1000:4f15
1000:4f0e      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
1000:4f13      75 2e                    JNZ 0x1000:4f43
1000:4f15  LAB_1000_4f15:
1000:4f15      8a 55 0a                 MOV DL,byte ptr [DI + 0xa]
1000:4f18      b8 1e 00                 MOV AX,0x1e
1000:4f1b      80 e2 0f                 AND DL,0xf
1000:4f1e      f6 e2                    MUL DL
1000:4f20      be 7b 09                 MOV SI,0x97b
1000:4f23      03 f0                    ADD SI,AX
1000:4f25      bd 43 28                 MOV BP,0x2843
1000:4f28      e8 34 04                 CALL 0x1000:535f
1000:4f2b      e8 2e 04                 CALL 0x1000:535c
1000:4f2e      8a 07                    MOV AL,byte ptr [BX]
1000:4f30      24 c0                    AND AL,0xc0
1000:4f32      74 32                    JZ 0x1000:4f66
1000:4f34      3c 80                    CMP AL,0x80
1000:4f36      74 1b                    JZ 0x1000:4f53
1000:4f38      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
1000:4f3d      74 27                    JZ 0x1000:4f66
1000:4f3f      3c c0                    CMP AL,0xc0
1000:4f41      74 10                    JZ 0x1000:4f53
1000:4f43  LAB_1000_4f43:
1000:4f43      59                       POP CX
1000:4f44      51                       PUSH CX
1000:4f45      b0 0c                    MOV AL,0xc
1000:4f47      f6 e1                    MUL CL
1000:4f49      be 63 02                 MOV SI,0x263
1000:4f4c      03 f0                    ADD SI,AX
1000:4f4e      8b ee                    MOV BP,SI
1000:4f50      eb 11                    JMP 0x1000:4f63
1000:4f53  LAB_1000_4f53:
1000:4f53      80 3e 70 a2 07           CMP byte ptr [0xa270],0x7
1000:4f58      b0 00                    MOV AL,0x0
1000:4f5a      74 e7                    JZ 0x1000:4f43
1000:4f5c      58                       POP AX
1000:4f5d      50                       PUSH AX
1000:4f5e      e8 43 03                 CALL 0x1000:52a4
1000:4f61      eb 03                    JMP 0x1000:4f66
1000:4f63  LAB_1000_4f63:
1000:4f63      e8 f9 03                 CALL 0x1000:535f
1000:4f66  LAB_1000_4f66:
1000:4f66      8a 05                    MOV AL,byte ptr [DI]
1000:4f68      a8 80                    TEST AL,0x80
1000:4f6a      74 13                    JZ 0x1000:4f7f
1000:4f6c      a8 20                    TEST AL,0x20
1000:4f6e      74 0f                    JZ 0x1000:4f7f
1000:4f70      f6 45 19 80              TEST byte ptr [DI + 0x19],0x80
1000:4f74      75 09                    JNZ 0x1000:4f7f
1000:4f76      be 63 17                 MOV SI,0x1763
1000:4f79      bd 37 28                 MOV BP,0x2837
1000:4f7c      e8 e0 03                 CALL 0x1000:535f
1000:4f7f  LAB_1000_4f7f:
1000:4f7f      83 c7 3b                 ADD DI,0x3b
1000:4f82      59                       POP CX
1000:4f83      fe c1                    INC CL
1000:4f85      80 f9 04                 CMP CL,0x4
1000:4f88      74 03                    JZ 0x1000:4f8d
1000:4f8a      e9 6d ff                 JMP 0x1000:4efa
1000:4f8d  LAB_1000_4f8d:
1000:4f8d      c3                       RET

; ------------------------------------------------------------
1000:4f8e  FUN_1000_4f8e:
1000:4f8e      bf 64 8c                 MOV DI,0x8c64
1000:4f91      b9 10 00                 MOV CX,0x10
1000:4f94  LAB_1000_4f94:
1000:4f94      a0 74 a2                 MOV AL,[0xa274]
1000:4f97      3a 45 17                 CMP AL,byte ptr [DI + 0x17]
1000:4f9a      75 03                    JNZ 0x1000:4f9f
1000:4f9c      eb 7e                    JMP 0x1000:501c
1000:4f9f  LAB_1000_4f9f:
1000:4f9f      51                       PUSH CX
1000:4fa0      be 37 28                 MOV SI,0x2837
1000:4fa3      e8 37 02                 CALL 0x1000:51dd
1000:4fa6      74 57                    JZ 0x1000:4fff
1000:4fa8      80 3e 70 a2 07           CMP byte ptr [0xa270],0x7
1000:4fad      74 6c                    JZ 0x1000:501b
1000:4faf      f6 45 19 f0              TEST byte ptr [DI + 0x19],0xf0
1000:4fb3      75 06                    JNZ 0x1000:4fbb
1000:4fb5      8a 05                    MOV AL,byte ptr [DI]
1000:4fb7      a8 10                    TEST AL,0x10
1000:4fb9      75 60                    JNZ 0x1000:501b
1000:4fbb  LAB_1000_4fbb:
1000:4fbb      be 37 28                 MOV SI,0x2837
1000:4fbe      bd 37 28                 MOV BP,0x2837
1000:4fc1      81 7d 08 e8 03           CMP word ptr [DI + 0x8],0x3e8
1000:4fc6      77 07                    JA 0x1000:4fcf
1000:4fc8      f6 06 d2 89 02           TEST byte ptr [0x89d2],0x2
1000:4fcd      75 2d                    JNZ 0x1000:4ffc
1000:4fcf  LAB_1000_4fcf:
1000:4fcf      f6 05 44                 TEST byte ptr [DI],0x44
1000:4fd2      75 47                    JNZ 0x1000:501b
1000:4fd4      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
1000:4fd9      74 11                    JZ 0x1000:4fec
1000:4fdb      8a 55 17                 MOV DL,byte ptr [DI + 0x17]
1000:4fde      b0 0c                    MOV AL,0xc
1000:4fe0      f6 e2                    MUL DL
1000:4fe2      be bb 01                 MOV SI,0x1bb
1000:4fe5      03 f0                    ADD SI,AX
1000:4fe7      8b ee                    MOV BP,SI
1000:4fe9      eb 11                    JMP 0x1000:4ffc
1000:4fec  LAB_1000_4fec:
1000:4fec      8a 55 0a                 MOV DL,byte ptr [DI + 0xa]
1000:4fef      b8 1e 00                 MOV AX,0x1e
1000:4ff2      80 e2 0f                 AND DL,0xf
1000:4ff5      f6 e2                    MUL DL
1000:4ff7      be 5b 0b                 MOV SI,0xb5b
1000:4ffa      03 f0                    ADD SI,AX
1000:4ffc  LAB_1000_4ffc:
1000:4ffc      bd 3b 28                 MOV BP,0x283b
1000:4fff  LAB_1000_4fff:
1000:4fff      e8 5d 03                 CALL 0x1000:535f
1000:5002      8a 05                    MOV AL,byte ptr [DI]
1000:5004      a8 80                    TEST AL,0x80
1000:5006      74 13                    JZ 0x1000:501b
1000:5008      a8 20                    TEST AL,0x20
1000:500a      74 0f                    JZ 0x1000:501b
1000:500c      f6 45 19 80              TEST byte ptr [DI + 0x19],0x80
1000:5010      75 09                    JNZ 0x1000:501b
1000:5012      be 63 17                 MOV SI,0x1763
1000:5015      bd 37 28                 MOV BP,0x2837
1000:5018      e8 44 03                 CALL 0x1000:535f
1000:501b  LAB_1000_501b:
1000:501b      59                       POP CX
1000:501c  LAB_1000_501c:
1000:501c      83 c7 3b                 ADD DI,0x3b
1000:501f      49                       DEC CX
1000:5020      74 03                    JZ 0x1000:5025
1000:5022      e9 6f ff                 JMP 0x1000:4f94
1000:5025  LAB_1000_5025:
1000:5025      c3                       RET

; ------------------------------------------------------------
1000:5026  FUN_1000_5026:
1000:5026      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
1000:502b      77 2a                    JA 0x1000:5057
1000:502d      bf 8c a0                 MOV DI,0xa08c
1000:5030      b9 30 00                 MOV CX,0x30
1000:5033  LAB_1000_5033:
1000:5033      80 3d 00                 CMP byte ptr [DI],0x0
1000:5036      74 1a                    JZ 0x1000:5052
1000:5038      a0 d2 89                 MOV AL,[0x89d2]
1000:503b      d0 e8                    SHR AL,0x1
1000:503d      32 05                    XOR AL,byte ptr [DI]
1000:503f      be f3 17                 MOV SI,0x17f3
1000:5042      24 07                    AND AL,0x7
1000:5044      b4 16                    MOV AH,0x16
1000:5046      f6 e4                    MUL AH
1000:5048      03 f0                    ADD SI,AX
1000:504a      bd 37 28                 MOV BP,0x2837
1000:504d      51                       PUSH CX
1000:504e      e8 0e 03                 CALL 0x1000:535f
1000:5051      59                       POP CX
1000:5052  LAB_1000_5052:
1000:5052      83 c7 07                 ADD DI,0x7
1000:5055      e2 dc                    LOOP 0x1000:5033
1000:5057  LAB_1000_5057:
1000:5057      c3                       RET

; ------------------------------------------------------------
1000:5058  FUN_1000_5058:
1000:5058      bf 8c 8a                 MOV DI,0x8a8c
1000:505b      b9 00 00                 MOV CX,0x0
1000:505e  LAB_1000_505e:
1000:505e      51                       PUSH CX
1000:505f      be c3 02                 MOV SI,0x2c3
1000:5062      8a 05                    MOV AL,byte ptr [DI]
1000:5064      24 03                    AND AL,0x3
1000:5066      74 21                    JZ 0x1000:5089
1000:5068      fe c8                    DEC AL
1000:506a      be 73 03                 MOV SI,0x373
1000:506d      74 1a                    JZ 0x1000:5089
1000:506f      be 23 04                 MOV SI,0x423
1000:5072      8b 1e 97 a2              MOV BX,word ptr [0xa297]
1000:5076      81 7f 08 b8 0b           CMP word ptr [BX + 0x8],0xbb8
1000:507b      72 0c                    JC 0x1000:5089
1000:507d      80 7f 0e 14              CMP byte ptr [BX + 0xe],0x14
1000:5081      73 06                    JNC 0x1000:5089
1000:5083      be 37 28                 MOV SI,0x2837
1000:5086      eb 0e                    JMP 0x1000:5096
1000:5089  LAB_1000_5089:
1000:5089      a0 d2 89                 MOV AL,[0x89d2]
1000:508c      02 c1                    ADD AL,CL
1000:508e      24 03                    AND AL,0x3
1000:5090      b4 2c                    MOV AH,0x2c
1000:5092      f6 e4                    MUL AH
1000:5094      03 f0                    ADD SI,AX
1000:5096  LAB_1000_5096:
1000:5096      bd 37 28                 MOV BP,0x2837
1000:5099      e8 c3 02                 CALL 0x1000:535f
1000:509c      83 c7 3b                 ADD DI,0x3b
1000:509f      59                       POP CX
1000:50a0      fe c1                    INC CL
1000:50a2      3a 0e 01 00              CMP CL,byte ptr [0x1]
1000:50a6      75 b6                    JNZ 0x1000:505e
1000:50a8      c3                       RET

; ------------------------------------------------------------
1000:50a9  FUN_1000_50a9:
1000:50a9      a0 74 a2                 MOV AL,[0xa274]
1000:50ac      32 e4                    XOR AH,AH
1000:50ae      be 28 00                 MOV SI,0x28
1000:50b1      f7 e6                    MUL SI
1000:50b3      8b f0                    MOV SI,AX
1000:50b5      81 c6 ec 89              ADD SI,0x89ec
1000:50b9      ac                       LODSB SI
1000:50ba      3c 00                    CMP AL,0x0
1000:50bc      74 26                    JZ 0x1000:50e4
1000:50be      b9 08 00                 MOV CX,0x8
1000:50c1      ba b0 00                 MOV DX,0xb0
1000:50c4      e8 a2 05                 CALL 0x1000:5669
1000:50c7      ac                       LODSB SI
1000:50c8  LAB_1000_50c8:
1000:50c8      ac                       LODSB SI
1000:50c9      3c 00                    CMP AL,0x0
1000:50cb      74 07                    JZ 0x1000:50d4
1000:50cd      b4 01                    MOV AH,0x1
1000:50cf      e8 a9 04                 CALL 0x1000:557b
1000:50d2      eb f4                    JMP 0x1000:50c8
1000:50d4  LAB_1000_50d4:
1000:50d4      b0 7f                    MOV AL,0x7f
1000:50d6      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
1000:50db      74 02                    JZ 0x1000:50df
1000:50dd      b0 20                    MOV AL,0x20
1000:50df  LAB_1000_50df:
1000:50df      b4 01                    MOV AH,0x1
1000:50e1      e8 97 04                 CALL 0x1000:557b
1000:50e4  LAB_1000_50e4:
1000:50e4      be 9e a2                 MOV SI,0xa29e
1000:50e7      ac                       LODSB SI
1000:50e8      3c 00                    CMP AL,0x0
1000:50ea      74 15                    JZ 0x1000:5101
1000:50ec      b9 08 00                 MOV CX,0x8
1000:50ef      ba b8 00                 MOV DX,0xb8
1000:50f2      e8 74 05                 CALL 0x1000:5669
1000:50f5  LAB_1000_50f5:
1000:50f5      ac                       LODSB SI
1000:50f6      3c 00                    CMP AL,0x0
1000:50f8      74 07                    JZ 0x1000:5101
1000:50fa      b4 02                    MOV AH,0x2
1000:50fc      e8 7c 04                 CALL 0x1000:557b
1000:50ff      eb f4                    JMP 0x1000:50f5
1000:5101  LAB_1000_5101:
1000:5101      c3                       RET

; ------------------------------------------------------------
1000:5102  FUN_1000_5102:
1000:5102      e8 83 00                 CALL 0x1000:5188
1000:5105      e8 f3 06                 CALL 0x1000:57fb
                ; inline script -> 1000:511a  <c1><box>GAME OVER
1000:511a  LAB_1000_511a:
1000:511a      c3                       RET

; ------------------------------------------------------------
1000:511b  FUN_1000_511b:
1000:511b      f6 06 6c a2 ff           TEST byte ptr [0xa26c],0xff
1000:5120      75 01                    JNZ 0x1000:5123
1000:5122      c3                       RET
1000:5123  LAB_1000_5123:
1000:5123      f6 06 6c a2 80           TEST byte ptr [0xa26c],0x80
1000:5128      74 3e                    JZ 0x1000:5168
1000:512a      e8 5b 00                 CALL 0x1000:5188
1000:512d      e8 cb 06                 CALL 0x1000:57fb
                ; inline script -> 1000:5141  <c1><box> PAUSED 
1000:5141  LAB_1000_5141:
1000:5141      80 3e 71 a2 01           CMP byte ptr [0xa271],0x1
1000:5146      74 1f                    JZ 0x1000:5167
1000:5148      e8 b0 06                 CALL 0x1000:57fb
                ; inline script -> 1000:5167  <c3><box>HIT Esc TO CONTINUE
1000:5167  LAB_1000_5167:
1000:5167      c3                       RET
1000:5168  LAB_1000_5168:
1000:5168      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
1000:516d      74 18                    JZ 0x1000:5187
1000:516f      e8 16 00                 CALL 0x1000:5188
1000:5172      e8 86 06                 CALL 0x1000:57fb
                ; inline script -> 1000:5187  <c1><box> PAUSING 
1000:5187  LAB_1000_5187:
1000:5187      c3                       RET

; ------------------------------------------------------------
1000:5188  FUN_1000_5188:
1000:5188      e8 70 06                 CALL 0x1000:57fb
                ; inline script -> 1000:51dc  <c1><pic><pic><pic><pic><pic><pic><pic><pic><pic><pic><pic>
1000:51dc  LAB_1000_51dc:
1000:51dc      c3                       RET

; ------------------------------------------------------------
1000:51dd  FUN_1000_51dd:
1000:51dd      8a 05                    MOV AL,byte ptr [DI]
1000:51df      a8 80                    TEST AL,0x80
1000:51e1      75 52                    JNZ 0x1000:5235
1000:51e3      bd 37 28                 MOV BP,0x2837
1000:51e6      22 c0                    AND AL,AL
1000:51e8      74 49                    JZ 0x1000:5233
1000:51ea      be 2d 26                 MOV SI,0x262d
1000:51ed      bd 21 28                 MOV BP,0x2821
1000:51f0      fe c8                    DEC AL
1000:51f2      74 3f                    JZ 0x1000:5233
1000:51f4      fe c8                    DEC AL
1000:51f6      74 3b                    JZ 0x1000:5233
1000:51f8      be 0f 26                 MOV SI,0x260f
1000:51fb      fe c8                    DEC AL
1000:51fd      74 34                    JZ 0x1000:5233
1000:51ff      bd 19 28                 MOV BP,0x2819
1000:5202      fe c8                    DEC AL
1000:5204      74 2d                    JZ 0x1000:5233
1000:5206      be f9 25                 MOV SI,0x25f9
1000:5209      fe c8                    DEC AL
1000:520b      74 26                    JZ 0x1000:5233
1000:520d      fe c8                    DEC AL
1000:520f      74 22                    JZ 0x1000:5233
1000:5211      bd 15 28                 MOV BP,0x2815
1000:5214      be f1 25                 MOV SI,0x25f1
1000:5217      fe c8                    DEC AL
1000:5219      74 18                    JZ 0x1000:5233
1000:521b      fe c8                    DEC AL
1000:521d      74 14                    JZ 0x1000:5233
1000:521f      be 0f 26                 MOV SI,0x260f
1000:5222      bd 19 28                 MOV BP,0x2819
1000:5225      fe c8                    DEC AL
1000:5227      74 0a                    JZ 0x1000:5233
1000:5229      fe c8                    DEC AL
1000:522b      74 06                    JZ 0x1000:5233
1000:522d      bd a7 20                 MOV BP,0x20a7
1000:5230      be 6f 20                 MOV SI,0x206f
1000:5233  LAB_1000_5233:
1000:5233      32 c0                    XOR AL,AL
1000:5235  LAB_1000_5235:
1000:5235      c3                       RET

; ------------------------------------------------------------
1000:5236  FUN_1000_5236:
1000:5236      a0 70 a2                 MOV AL,[0xa270]
1000:5239      3c 07                    CMP AL,0x7
1000:523b      75 1c                    JNZ 0x1000:5259
1000:523d      be 2a 01                 MOV SI,0x12a
1000:5240      c7 06 8b a2 00 00        MOV word ptr [0xa28b],0x0
1000:5246      c7 06 8f a2 00 00        MOV word ptr [0xa28f],0x0
1000:524c      c7 06 8d a2 ff 3f        MOV word ptr [0xa28d],0x3fff
1000:5252      c7 06 91 a2 ff 3f        MOV word ptr [0xa291],0x3fff
1000:5258      c3                       RET
1000:5259  LAB_1000_5259:
1000:5259      e8 00 01                 CALL 0x1000:535c
1000:525c      f6 07 10                 TEST byte ptr [BX],0x10
1000:525f      74 10                    JZ 0x1000:5271
1000:5261      e8 6a cc                 CALL 0x1000:1ece
                ; ptr table -> 1000:526c  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
1000:526c  LAB_1000_526c:
1000:526c      8b f3                    MOV SI,BX
1000:526e      eb 06                    JMP 0x1000:5276
1000:5271  LAB_1000_5271:
1000:5271      8a 07                    MOV AL,byte ptr [BX]
1000:5273      e8 96 d7                 CALL 0x1000:2a0c
1000:5276  LAB_1000_5276:
1000:5276      8a 0e 70 a2              MOV CL,byte ptr [0xa270]
1000:527a      ba 64 00                 MOV DX,0x64
1000:527d      d3 e2                    SHL DX,CL
1000:527f      8b 5c 01                 MOV BX,word ptr [SI + 0x1]
1000:5282      2b da                    SUB BX,DX
1000:5284      89 1e 8b a2              MOV word ptr [0xa28b],BX
1000:5288      03 da                    ADD BX,DX
1000:528a      03 da                    ADD BX,DX
1000:528c      4b                       DEC BX
1000:528d      89 1e 8d a2              MOV word ptr [0xa28d],BX
1000:5291      8b 5c 03                 MOV BX,word ptr [SI + 0x3]
1000:5294      2b da                    SUB BX,DX
1000:5296      89 1e 8f a2              MOV word ptr [0xa28f],BX
1000:529a      03 da                    ADD BX,DX
1000:529c      03 da                    ADD BX,DX
1000:529e      4b                       DEC BX
1000:529f      89 1e 91 a2              MOV word ptr [0xa291],BX
1000:52a3      c3                       RET

; ------------------------------------------------------------
1000:52a4  FUN_1000_52a4:
1000:52a4      50                       PUSH AX
1000:52a5      be 61 01                 MOV SI,0x161
1000:52a8      8b ee                    MOV BP,SI
1000:52aa      e8 c1 00                 CALL 0x1000:536e
1000:52ad      58                       POP AX
1000:52ae      73 01                    JNC 0x1000:52b1
1000:52b0      c3                       RET
1000:52b1  LAB_1000_52b1:
1000:52b1      83 c6 02                 ADD SI,0x2
1000:52b4      51                       PUSH CX
1000:52b5      52                       PUSH DX
1000:52b6      b4 00                    MOV AH,0x0
1000:52b8      3c 06                    CMP AL,0x6
1000:52ba      73 0e                    JNC 0x1000:52ca
1000:52bc      fe c4                    INC AH
1000:52be      3c 02                    CMP AL,0x2
1000:52c0      72 08                    JC 0x1000:52ca
1000:52c2      fe c4                    INC AH
1000:52c4      3c 04                    CMP AL,0x4
1000:52c6      73 02                    JNC 0x1000:52ca
1000:52c8      fe c4                    INC AH
1000:52ca  LAB_1000_52ca:
1000:52ca      83 f9 14                 CMP CX,0x14
1000:52cd      72 21                    JC 0x1000:52f0
1000:52cf      81 f9 b4 00              CMP CX,0xb4
1000:52d3      72 36                    JC 0x1000:530b
1000:52d5      83 fa 14                 CMP DX,0x14
1000:52d8      73 05                    JNC 0x1000:52df
1000:52da      b4 02                    MOV AH,0x2
1000:52dc      eb 41                    JMP 0x1000:531f
1000:52df  LAB_1000_52df:
1000:52df      81 fa b4 00              CMP DX,0xb4
1000:52e3      73 06                    JNC 0x1000:52eb
1000:52e5      80 e4 02                 AND AH,0x2
1000:52e8      eb 35                    JMP 0x1000:531f
1000:52eb  LAB_1000_52eb:
1000:52eb      b4 00                    MOV AH,0x0
1000:52ed      eb 30                    JMP 0x1000:531f
1000:52f0  LAB_1000_52f0:
1000:52f0      83 fa 14                 CMP DX,0x14
1000:52f3      73 05                    JNC 0x1000:52fa
1000:52f5      b4 03                    MOV AH,0x3
1000:52f7      eb 26                    JMP 0x1000:531f
1000:52fa  LAB_1000_52fa:
1000:52fa      81 fa b4 00              CMP DX,0xb4
1000:52fe      73 06                    JNC 0x1000:5306
1000:5300      80 cc 01                 OR AH,0x1
1000:5303      eb 1a                    JMP 0x1000:531f
1000:5306  LAB_1000_5306:
1000:5306      b4 01                    MOV AH,0x1
1000:5308      eb 15                    JMP 0x1000:531f
1000:530b  LAB_1000_530b:
1000:530b      83 fa 14                 CMP DX,0x14
1000:530e      73 06                    JNC 0x1000:5316
1000:5310      80 cc 02                 OR AH,0x2
1000:5313      eb 0a                    JMP 0x1000:531f
1000:5316  LAB_1000_5316:
1000:5316      81 fa b4 00              CMP DX,0xb4
1000:531a      72 03                    JC 0x1000:531f
1000:531c      80 e4 01                 AND AH,0x1
1000:531f  LAB_1000_531f:
1000:531f      50                       PUSH AX
1000:5320      83 c1 03                 ADD CX,0x3
1000:5323      f6 c4 01                 TEST AH,0x1
1000:5326      74 06                    JZ 0x1000:532e
1000:5328      83 c6 16                 ADD SI,0x16
1000:532b      83 c1 0b                 ADD CX,0xb
1000:532e  LAB_1000_532e:
1000:532e      f6 c4 02                 TEST AH,0x2
1000:5331      74 06                    JZ 0x1000:5339
1000:5333      83 c6 2c                 ADD SI,0x2c
1000:5336      83 c2 0a                 ADD DX,0xa
1000:5339  LAB_1000_5339:
1000:5339      e8 ae 01                 CALL 0x1000:54ea
1000:533c      58                       POP AX
1000:533d      5a                       POP DX
1000:533e      59                       POP CX
1000:533f      be 63 02                 MOV SI,0x263
1000:5342      f6 c4 01                 TEST AH,0x1
1000:5345      74 03                    JZ 0x1000:534a
1000:5347      83 c1 14                 ADD CX,0x14
1000:534a  LAB_1000_534a:
1000:534a      f6 c4 02                 TEST AH,0x2
1000:534d      74 03                    JZ 0x1000:5352
1000:534f      83 c2 0a                 ADD DX,0xa
1000:5352  LAB_1000_5352:
1000:5352      b4 0c                    MOV AH,0xc
1000:5354      f6 e4                    MUL AH
1000:5356      03 f0                    ADD SI,AX
1000:5358      e8 8f 01                 CALL 0x1000:54ea
1000:535b      c3                       RET

; ------------------------------------------------------------
1000:535c  thunk_FUN_1000_1ec1:
1000:535c      e9 62 cb                 JMP 0x1000:1ec1

; ------------------------------------------------------------
1000:535f  FUN_1000_535f:
1000:535f      e8 0c 00                 CALL 0x1000:536e
1000:5362      72 09                    JC 0x1000:536d
1000:5364      81 fe 37 28              CMP SI,0x2837
1000:5368      74 03                    JZ 0x1000:536d
1000:536a      e8 7d 01                 CALL 0x1000:54ea
1000:536d  LAB_1000_536d:
1000:536d      c3                       RET

; ------------------------------------------------------------
1000:536e  FUN_1000_536e:
1000:536e      8a 45 05                 MOV AL,byte ptr [DI + 0x5]
1000:5371      3a 06 60 a3              CMP AL,byte ptr [0xa360]
1000:5375      f9                       STC
1000:5376      75 76                    JNZ 0x1000:53ee
1000:5378      8b 16 8b a2              MOV DX,word ptr [0xa28b]
1000:537c      8b 0e 8d a2              MOV CX,word ptr [0xa28d]
1000:5380      8b 5d 01                 MOV BX,word ptr [DI + 0x1]
1000:5383      e8 69 00                 CALL 0x1000:53ef
1000:5386      72 66                    JC 0x1000:53ee
1000:5388      8b 16 8f a2              MOV DX,word ptr [0xa28f]
1000:538c      8b 0e 91 a2              MOV CX,word ptr [0xa291]
1000:5390      8b 5d 03                 MOV BX,word ptr [DI + 0x3]
1000:5393      e8 59 00                 CALL 0x1000:53ef
1000:5396      72 56                    JC 0x1000:53ee
1000:5398      8b 16 91 a2              MOV DX,word ptr [0xa291]
1000:539c      2b 55 03                 SUB DX,word ptr [DI + 0x3]
1000:539f      8a 0e 70 a2              MOV CL,byte ptr [0xa270]
1000:53a3      80 f9 07                 CMP CL,0x7
1000:53a6      75 1a                    JNZ 0x1000:53c2
1000:53a8      b9 53 00                 MOV CX,0x53
1000:53ab      8b c2                    MOV AX,DX
1000:53ad      ba 00 00                 MOV DX,0x0
1000:53b0      f7 f1                    DIV CX
1000:53b2      50                       PUSH AX
1000:53b3      8b 45 01                 MOV AX,word ptr [DI + 0x1]
1000:53b6      ba 00 00                 MOV DX,0x0
1000:53b9      f7 f1                    DIV CX
1000:53bb      8b c8                    MOV CX,AX
1000:53bd      5a                       POP DX
1000:53be      8b f5                    MOV SI,BP
1000:53c0      eb 16                    JMP 0x1000:53d8
1000:53c2  LAB_1000_53c2:
1000:53c2      d3 ea                    SHR DX,CL
1000:53c4      8b 5d 01                 MOV BX,word ptr [DI + 0x1]
1000:53c7      2b 1e 8b a2              SUB BX,word ptr [0xa28b]
1000:53cb      d3 eb                    SHR BX,CL
1000:53cd      8b cb                    MOV CX,BX
1000:53cf      80 3e 70 a2 05           CMP byte ptr [0xa270],0x5
1000:53d4      72 02                    JC 0x1000:53d8
1000:53d6      8b f5                    MOV SI,BP
1000:53d8  LAB_1000_53d8:
1000:53d8      8a 04                    MOV AL,byte ptr [SI]
1000:53da      32 e4                    XOR AH,AH
1000:53dc      d1 e8                    SHR AX,0x1
1000:53de      83 c1 10                 ADD CX,0x10
1000:53e1      2b c8                    SUB CX,AX
1000:53e3      8a 44 01                 MOV AL,byte ptr [SI + 0x1]
1000:53e6      d1 e8                    SHR AX,0x1
1000:53e8      83 c2 10                 ADD DX,0x10
1000:53eb      2b d0                    SUB DX,AX
1000:53ed      f8                       CLC
1000:53ee  LAB_1000_53ee:
1000:53ee      c3                       RET

; ------------------------------------------------------------
1000:53ef  FUN_1000_53ef:
1000:53ef      8a c6                    MOV AL,DH
1000:53f1      32 c7                    XOR AL,BH
1000:53f3      78 06                    JS 0x1000:53fb
1000:53f5      3b da                    CMP BX,DX
1000:53f7      72 13                    JC 0x1000:540c
1000:53f9      eb 04                    JMP 0x1000:53ff
1000:53fb  LAB_1000_53fb:
1000:53fb      22 c6                    AND AL,DH
1000:53fd      79 0d                    JNS 0x1000:540c
1000:53ff  LAB_1000_53ff:
1000:53ff      8a c5                    MOV AL,CH
1000:5401      32 c7                    XOR AL,BH
1000:5403      78 03                    JS 0x1000:5408
1000:5405      3b cb                    CMP CX,BX
1000:5407      c3                       RET
1000:5408  LAB_1000_5408:
1000:5408      22 c7                    AND AL,BH
1000:540a      78 01                    JS 0x1000:540d
1000:540c  LAB_1000_540c:
1000:540c      f9                       STC
1000:540d  LAB_1000_540d:
1000:540d      c3                       RET

; ------------------------------------------------------------
1000:540e  FUN_1000_540e:
1000:540e      b9 05 00                 MOV CX,0x5
1000:5411      b3 20                    MOV BL,0x20
1000:5413      eb 13                    JMP 0x1000:5428

; ------------------------------------------------------------
1000:5415  FUN_1000_5415:
1000:5415      b9 04 00                 MOV CX,0x4
1000:5418      b3 20                    MOV BL,0x20
1000:541a      eb 0c                    JMP 0x1000:5428

; ------------------------------------------------------------
1000:541c  FUN_1000_541c:
1000:541c      b9 03 00                 MOV CX,0x3
1000:541f      32 e4                    XOR AH,AH
1000:5421      eb 05                    JMP 0x1000:5428

; ------------------------------------------------------------
1000:5423  FUN_1000_5423:
1000:5423      b9 02 00                 MOV CX,0x2
1000:5426      32 e4                    XOR AH,AH
1000:5428  LAB_1000_5428:
1000:5428      56                       PUSH SI
1000:5429      57                       PUSH DI
1000:542a      be 0a 00                 MOV SI,0xa
1000:542d      8b f9                    MOV DI,CX
1000:542f  LAB_1000_542f:
1000:542f      33 d2                    XOR DX,DX
1000:5431      f7 f6                    DIV SI
1000:5433      52                       PUSH DX
1000:5434      e2 f9                    LOOP 0x1000:542f
1000:5436      8b cf                    MOV CX,DI
1000:5438  LAB_1000_5438:
1000:5438      58                       POP AX
1000:5439      22 c0                    AND AL,AL
1000:543b      74 02                    JZ 0x1000:543f
1000:543d      b3 30                    MOV BL,0x30
1000:543f  LAB_1000_543f:
1000:543f      0a c3                    OR AL,BL
1000:5441      e8 33 01                 CALL 0x1000:5577
1000:5444      83 f9 02                 CMP CX,0x2
1000:5447      75 02                    JNZ 0x1000:544b
1000:5449      b3 30                    MOV BL,0x30
1000:544b  LAB_1000_544b:
1000:544b      e2 eb                    LOOP 0x1000:5438
1000:544d      5f                       POP DI
1000:544e      5e                       POP SI
1000:544f      c3                       RET

; ------------------------------------------------------------
1000:5450  FUN_1000_5450:
1000:5450      06                       PUSH ES
1000:5451      1e                       PUSH DS
1000:5452      07                       POP ES
1000:5453      b8 00 00                 MOV AX,0x0
1000:5456      51                       PUSH CX
1000:5457      57                       PUSH DI
1000:5458      bf c1 39                 MOV DI,0x39c1
1000:545b      b9 70 23                 MOV CX,0x2370
1000:545e      f3 ab                    STOSW.REP ES:DI
1000:5460      5f                       POP DI
1000:5461      59                       POP CX
1000:5462      07                       POP ES
1000:5463      c3                       RET

; ------------------------------------------------------------
1000:5464  FUN_1000_5464:
1000:5464      25 03 00                 AND AX,0x3
1000:5467      d1 e0                    SHL AX,0x1
1000:5469      bb a8 54                 MOV BX,0x54a8
1000:546c      03 d8                    ADD BX,AX
1000:546e      2e 8b 07                 MOV AX,word ptr CS:[BX]
1000:5471      bf 05 3f                 MOV DI,0x3f05
1000:5474      25 0f f0                 AND AX,0xf00f
1000:5477      b9 c8 00                 MOV CX,0xc8
1000:547a  LAB_1000_547a:
1000:547a      88 25                    MOV byte ptr [DI],AH
1000:547c      88 45 31                 MOV byte ptr [DI + 0x31],AL
1000:547f      83 c7 54                 ADD DI,0x54
1000:5482      e2 f6                    LOOP 0x1000:547a
1000:5484      bf 05 3f                 MOV DI,0x3f05
1000:5487      2e 8b 07                 MOV AX,word ptr CS:[BX]
1000:548a      b9 19 00                 MOV CX,0x19
1000:548d      f3 ab                    STOSW.REP ES:DI
1000:548f      bf 59 3f                 MOV DI,0x3f59
1000:5492      b9 19 00                 MOV CX,0x19
1000:5495      f3 ab                    STOSW.REP ES:DI
1000:5497      bf fd 7f                 MOV DI,0x7ffd
1000:549a      b9 19 00                 MOV CX,0x19
1000:549d      f3 ab                    STOSW.REP ES:DI
1000:549f      bf 51 80                 MOV DI,0x8051
1000:54a2      b9 19 00                 MOV CX,0x19
1000:54a5      f3 ab                    STOSW.REP ES:DI
1000:54a7      c3                       RET

; ------------------------------------------------------------
1000:54b0  blit_screen:
1000:54b0      51                       PUSH CX
1000:54b1      57                       PUSH DI
1000:54b2      56                       PUSH SI
1000:54b3      06                       PUSH ES
1000:54b4      b8 00 b8                 MOV AX,0xb800
1000:54b7      8e c0                    MOV ES,AX
1000:54b9      be 05 3f                 MOV SI,0x3f05
1000:54bc      bf 00 00                 MOV DI,0x0
1000:54bf      b9 64 00                 MOV CX,0x64
1000:54c2  LAB_1000_54c2:
1000:54c2      51                       PUSH CX
1000:54c3      57                       PUSH DI
1000:54c4      b9 28 00                 MOV CX,0x28
1000:54c7      f3 a5                    MOVSW.REP ES:DI,SI
1000:54c9      83 c6 04                 ADD SI,0x4
1000:54cc      5f                       POP DI
1000:54cd      81 cf 00 20              OR DI,0x2000
1000:54d1      b9 28 00                 MOV CX,0x28
1000:54d4      f3 a5                    MOVSW.REP ES:DI,SI
1000:54d6      83 c6 04                 ADD SI,0x4
1000:54d9      81 f7 00 20              XOR DI,0x2000
1000:54dd      59                       POP CX
1000:54de      e2 e2                    LOOP 0x1000:54c2
1000:54e0      07                       POP ES
1000:54e1      5e                       POP SI
1000:54e2      5f                       POP DI
1000:54e3      59                       POP CX
1000:54e4      c3                       RET

; ------------------------------------------------------------
1000:54e5  FUN_1000_54e5:
1000:54e5      bb 37 3f                 MOV BX,0x3f37
1000:54e8      eb 03                    JMP 0x1000:54ed

; ------------------------------------------------------------
1000:54ea  FUN_1000_54ea:
1000:54ea      bb c1 39                 MOV BX,0x39c1

; ------------------------------------------------------------
1000:54ed  FUN_1000_54ed:
1000:54ed      51                       PUSH CX
1000:54ee      52                       PUSH DX
1000:54ef      55                       PUSH BP
1000:54f0      56                       PUSH SI
1000:54f1      57                       PUSH DI
1000:54f2      32 c0                    XOR AL,AL
1000:54f4      d1 e9                    SHR CX,0x1
1000:54f6      d0 d8                    RCR AL,0x1
1000:54f8      d1 e9                    SHR CX,0x1
1000:54fa      d0 d0                    RCL AL,0x1
1000:54fc      d0 d0                    RCL AL,0x1
1000:54fe      8b e9                    MOV BP,CX
1000:5500      02 c0                    ADD AL,AL
1000:5502      8a c8                    MOV CL,AL
1000:5504      b5 08                    MOV CH,0x8
1000:5506      2a e8                    SUB CH,AL
1000:5508      b8 54 00                 MOV AX,0x54
1000:550b      f6 e2                    MUL DL
1000:550d      03 d8                    ADD BX,AX
1000:550f      8b 14                    MOV DX,word ptr [SI]
1000:5511      46                       INC SI
1000:5512      46                       INC SI
1000:5513  LAB_1000_5513:
1000:5513      8b fd                    MOV DI,BP
1000:5515      52                       PUSH DX
1000:5516  LAB_1000_5516:
1000:5516      8a 24                    MOV AH,byte ptr [SI]
1000:5518      46                       INC SI
1000:5519      b0 ff                    MOV AL,0xff
1000:551b      d3 c8                    ROR AX,CL
1000:551d      3b 3e 05 00              CMP DI,word ptr [0x5]
1000:5521      73 0e                    JNC 0x1000:5531
1000:5523      20 41 01                 AND byte ptr [BX + DI + 0x1],AL
1000:5526      8a 04                    MOV AL,byte ptr [SI]
1000:5528      86 cd                    XCHG CH,CL
1000:552a      d2 e0                    SHL AL,CL
1000:552c      86 cd                    XCHG CH,CL
1000:552e      08 41 01                 OR byte ptr [BX + DI + 0x1],AL
1000:5531  LAB_1000_5531:
1000:5531      3b 3e 05 00              CMP DI,word ptr [0x5]
1000:5535      77 08                    JA 0x1000:553f
1000:5537      20 21                    AND byte ptr [BX + DI],AH
1000:5539      8a 04                    MOV AL,byte ptr [SI]
1000:553b      d2 e8                    SHR AL,CL
1000:553d      08 01                    OR byte ptr [BX + DI],AL
1000:553f  LAB_1000_553f:
1000:553f      46                       INC SI
1000:5540      47                       INC DI
1000:5541      80 ea 04                 SUB DL,0x4
1000:5544      77 d0                    JA 0x1000:5516
1000:5546      83 c3 54                 ADD BX,0x54
1000:5549      5a                       POP DX
1000:554a      fe ce                    DEC DH
1000:554c      75 c5                    JNZ 0x1000:5513
1000:554e      5f                       POP DI
1000:554f      5e                       POP SI
1000:5550      5d                       POP BP
1000:5551      5a                       POP DX
1000:5552      59                       POP CX
1000:5553      c3                       RET

; ------------------------------------------------------------
1000:5554  print_cstr:
1000:5554      58                       POP AX
1000:5555      53                       PUSH BX
1000:5556      8b d8                    MOV BX,AX
1000:5558  LAB_1000_5558:
1000:5558      2e 8a 07                 MOV AL,byte ptr CS:[BX]
1000:555b      43                       INC BX
1000:555c      3c 00                    CMP AL,0x0
1000:555e      74 12                    JZ 0x1000:5572
1000:5560      3c 04                    CMP AL,0x4
1000:5562      73 05                    JNC 0x1000:5569
1000:5564      a2 9b a2                 MOV [0xa29b],AL
1000:5567      eb ef                    JMP 0x1000:5558
1000:5569  LAB_1000_5569:
1000:5569      8a 26 9b a2              MOV AH,byte ptr [0xa29b]
1000:556d      e8 0b 00                 CALL 0x1000:557b
1000:5570      eb e6                    JMP 0x1000:5558
1000:5572  LAB_1000_5572:
1000:5572      8b c3                    MOV AX,BX
1000:5574      5b                       POP BX
1000:5575      50                       PUSH AX
1000:5576      c3                       RET

; ------------------------------------------------------------
1000:5577  FUN_1000_5577:
1000:5577      8a 26 9b a2              MOV AH,byte ptr [0xa29b]

; ------------------------------------------------------------
1000:557b  FUN_1000_557b:
1000:557b      53                       PUSH BX
1000:557c      56                       PUSH SI
1000:557d      51                       PUSH CX
1000:557e      8b 1e 93 a2              MOV BX,word ptr [0xa293]
1000:5582      83 06 93 a2 02           ADD word ptr [0xa293],0x2
1000:5587      8b 36 16 00              MOV SI,word ptr [0x16]
1000:558b      b1 04                    MOV CL,0x4
1000:558d      3c 90                    CMP AL,0x90
1000:558f      72 03                    JC 0x1000:5594
1000:5591      e9 02 af                 JMP 0x1000:0496
1000:5594  LAB_1000_5594:
1000:5594      fe cc                    DEC AH
1000:5596      74 08                    JZ 0x1000:55a0
1000:5598      fe cc                    DEC AH
1000:559a      74 33                    JZ 0x1000:55cf
1000:559c      fe cc                    DEC AH
1000:559e      74 6c                    JZ 0x1000:560c
1000:55a0  LAB_1000_55a0:
1000:55a0      32 e4                    XOR AH,AH
1000:55a2      d3 e0                    SHL AX,CL
1000:55a4      03 f0                    ADD SI,AX
1000:55a6      ad                       LODSW SI
1000:55a7      89 07                    MOV word ptr [BX],AX
1000:55a9      ad                       LODSW SI
1000:55aa      89 47 54                 MOV word ptr [BX + 0x54],AX
1000:55ad      ad                       LODSW SI
1000:55ae      89 87 a8 00              MOV word ptr [BX + 0xa8],AX
1000:55b2      ad                       LODSW SI
1000:55b3      89 87 fc 00              MOV word ptr [BX + 0xfc],AX
1000:55b7      ad                       LODSW SI
1000:55b8      89 87 50 01              MOV word ptr [BX + 0x150],AX
1000:55bc      ad                       LODSW SI
1000:55bd      89 87 a4 01              MOV word ptr [BX + 0x1a4],AX
1000:55c1      ad                       LODSW SI
1000:55c2      89 87 f8 01              MOV word ptr [BX + 0x1f8],AX
1000:55c6      ad                       LODSW SI
1000:55c7      89 87 4c 02              MOV word ptr [BX + 0x24c],AX
1000:55cb      59                       POP CX
1000:55cc      5e                       POP SI
1000:55cd      5b                       POP BX
1000:55ce      c3                       RET
1000:55cf  LAB_1000_55cf:
1000:55cf      d3 e0                    SHL AX,CL
1000:55d1      03 f0                    ADD SI,AX
1000:55d3      ad                       LODSW SI
1000:55d4      d1 e0                    SHL AX,0x1
1000:55d6      89 07                    MOV word ptr [BX],AX
1000:55d8      ad                       LODSW SI
1000:55d9      d1 e0                    SHL AX,0x1
1000:55db      89 47 54                 MOV word ptr [BX + 0x54],AX
1000:55de      ad                       LODSW SI
1000:55df      d1 e0                    SHL AX,0x1
1000:55e1      89 87 a8 00              MOV word ptr [BX + 0xa8],AX
1000:55e5      ad                       LODSW SI
1000:55e6      d1 e0                    SHL AX,0x1
1000:55e8      89 87 fc 00              MOV word ptr [BX + 0xfc],AX
1000:55ec      ad                       LODSW SI
1000:55ed      d1 e0                    SHL AX,0x1
1000:55ef      89 87 50 01              MOV word ptr [BX + 0x150],AX
1000:55f3      ad                       LODSW SI
1000:55f4      d1 e0                    SHL AX,0x1
1000:55f6      89 87 a4 01              MOV word ptr [BX + 0x1a4],AX
1000:55fa      ad                       LODSW SI
1000:55fb      d1 e0                    SHL AX,0x1
1000:55fd      89 87 f8 01              MOV word ptr [BX + 0x1f8],AX
1000:5601      ad                       LODSW SI
1000:5602      d1 e0                    SHL AX,0x1
1000:5604      89 87 4c 02              MOV word ptr [BX + 0x24c],AX
1000:5608      59                       POP CX
1000:5609      5e                       POP SI
1000:560a      5b                       POP BX
1000:560b      c3                       RET
1000:560c  LAB_1000_560c:
1000:560c      d3 e0                    SHL AX,CL
1000:560e      03 f0                    ADD SI,AX
1000:5610      ad                       LODSW SI
1000:5611      8b c8                    MOV CX,AX
1000:5613      d1 e0                    SHL AX,0x1
1000:5615      0b c1                    OR AX,CX
1000:5617      89 07                    MOV word ptr [BX],AX
1000:5619      ad                       LODSW SI
1000:561a      8b c8                    MOV CX,AX
1000:561c      d1 e0                    SHL AX,0x1
1000:561e      0b c1                    OR AX,CX
1000:5620      89 47 54                 MOV word ptr [BX + 0x54],AX
1000:5623      ad                       LODSW SI
1000:5624      8b c8                    MOV CX,AX
1000:5626      d1 e0                    SHL AX,0x1
1000:5628      0b c1                    OR AX,CX
1000:562a      89 87 a8 00              MOV word ptr [BX + 0xa8],AX
1000:562e      ad                       LODSW SI
1000:562f      8b c8                    MOV CX,AX
1000:5631      d1 e0                    SHL AX,0x1
1000:5633      0b c1                    OR AX,CX
1000:5635      89 87 fc 00              MOV word ptr [BX + 0xfc],AX
1000:5639      ad                       LODSW SI
1000:563a      8b c8                    MOV CX,AX
1000:563c      d1 e0                    SHL AX,0x1
1000:563e      0b c1                    OR AX,CX
1000:5640      89 87 50 01              MOV word ptr [BX + 0x150],AX
1000:5644      ad                       LODSW SI
1000:5645      8b c8                    MOV CX,AX
1000:5647      d1 e0                    SHL AX,0x1
1000:5649      0b c1                    OR AX,CX
1000:564b      89 87 a4 01              MOV word ptr [BX + 0x1a4],AX
1000:564f      ad                       LODSW SI
1000:5650      8b c8                    MOV CX,AX
1000:5652      d1 e0                    SHL AX,0x1
1000:5654      0b c1                    OR AX,CX
1000:5656      89 87 f8 01              MOV word ptr [BX + 0x1f8],AX
1000:565a      ad                       LODSW SI
1000:565b      8b c8                    MOV CX,AX
1000:565d      d1 e0                    SHL AX,0x1
1000:565f      0b c1                    OR AX,CX
1000:5661      89 87 4c 02              MOV word ptr [BX + 0x24c],AX
1000:5665      59                       POP CX
1000:5666      5e                       POP SI
1000:5667      5b                       POP BX
1000:5668      c3                       RET

; ------------------------------------------------------------
1000:5669  FUN_1000_5669:
1000:5669      50                       PUSH AX
1000:566a      b0 54                    MOV AL,0x54
1000:566c      f6 e2                    MUL DL
1000:566e      03 c1                    ADD AX,CX
1000:5670      05 01 3f                 ADD AX,0x3f01
1000:5673      a3 93 a2                 MOV [0xa293],AX
1000:5676      58                       POP AX
1000:5677      c3                       RET

; ------------------------------------------------------------
1000:5678  FUN_1000_5678:
1000:5678      f6 06 14 00 03           TEST byte ptr [0x14],0x3
1000:567d      74 0c                    JZ 0x1000:568b
1000:567f      b9 21 00                 MOV CX,0x21
1000:5682      ba 00 00                 MOV DX,0x0
1000:5685      be 33 01                 MOV SI,0x133
1000:5688      e8 5a fe                 CALL 0x1000:54e5
1000:568b  LAB_1000_568b:
1000:568b      c3                       RET

; ------------------------------------------------------------
1000:568c  FUN_1000_568c:
1000:568c      8b 36 97 a2              MOV SI,word ptr [0xa297]
1000:5690      f6 44 29 01              TEST byte ptr [SI + 0x29],0x1
1000:5694      74 19                    JZ 0x1000:56af
1000:5696      f6 44 29 02              TEST byte ptr [SI + 0x29],0x2
1000:569a      74 07                    JZ 0x1000:56a3
1000:569c      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
1000:56a1      74 0c                    JZ 0x1000:56af
1000:56a3  LAB_1000_56a3:
1000:56a3      b9 1f 00                 MOV CX,0x1f
1000:56a6      ba 1a 00                 MOV DX,0x1a
1000:56a9      be 3f 01                 MOV SI,0x13f
1000:56ac      e8 36 fe                 CALL 0x1000:54e5
1000:56af  LAB_1000_56af:
1000:56af      c3                       RET

; ------------------------------------------------------------
1000:56b0  FUN_1000_56b0:
1000:56b0      50                       PUSH AX
1000:56b1      b9 24 00                 MOV CX,0x24
1000:56b4      ba 00 00                 MOV DX,0x0
1000:56b7      be d3 04                 MOV SI,0x4d3
1000:56ba      e8 28 fe                 CALL 0x1000:54e5
1000:56bd      5a                       POP DX
1000:56be      52                       PUSH DX
1000:56bf      80 e2 f0                 AND DL,0xf0
1000:56c2      d0 ea                    SHR DL,0x1
1000:56c4      d0 ea                    SHR DL,0x1
1000:56c6      d0 ea                    SHR DL,0x1
1000:56c8      d0 ea                    SHR DL,0x1
1000:56ca      80 fa 0b                 CMP DL,0xb
1000:56cd      72 02                    JC 0x1000:56d1
1000:56cf      b2 0b                    MOV DL,0xb
1000:56d1  LAB_1000_56d1:
1000:56d1      b8 14 00                 MOV AX,0x14
1000:56d4      f6 e2                    MUL DL
1000:56d6      be 3b 0d                 MOV SI,0xd3b
1000:56d9      03 f0                    ADD SI,AX
1000:56db      8a 0c                    MOV CL,byte ptr [SI]
1000:56dd      32 ed                    XOR CH,CH
1000:56df      83 c1 24                 ADD CX,0x24
1000:56e2      46                       INC SI
1000:56e3      8a 14                    MOV DL,byte ptr [SI]
1000:56e5      32 f6                    XOR DH,DH
1000:56e7      46                       INC SI
1000:56e8      e8 fa fd                 CALL 0x1000:54e5
1000:56eb      5a                       POP DX
1000:56ec      80 e2 0f                 AND DL,0xf
1000:56ef      80 fa 0b                 CMP DL,0xb
1000:56f2      72 02                    JC 0x1000:56f6
1000:56f4      b2 0b                    MOV DL,0xb
1000:56f6  LAB_1000_56f6:
1000:56f6      b8 14 00                 MOV AX,0x14
1000:56f9      f6 e2                    MUL DL
1000:56fb      be 2b 0e                 MOV SI,0xe2b
1000:56fe      03 f0                    ADD SI,AX
1000:5700      8a 0c                    MOV CL,byte ptr [SI]
1000:5702      32 ed                    XOR CH,CH
1000:5704      83 c1 24                 ADD CX,0x24
1000:5707      46                       INC SI
1000:5708      8a 14                    MOV DL,byte ptr [SI]
1000:570a      32 f6                    XOR DH,DH
1000:570c      46                       INC SI
1000:570d      e8 d5 fd                 CALL 0x1000:54e5
1000:5710      c3                       RET

; ------------------------------------------------------------
1000:5711  FUN_1000_5711:
1000:5711      50                       PUSH AX
1000:5712      b9 00 00                 MOV CX,0x0
1000:5715      ba 00 00                 MOV DX,0x0
1000:5718      be 27 07                 MOV SI,0x727
1000:571b      e8 c7 fd                 CALL 0x1000:54e5
1000:571e      5a                       POP DX
1000:571f      52                       PUSH DX
1000:5720      80 e2 f0                 AND DL,0xf0
1000:5723      d0 ea                    SHR DL,0x1
1000:5725      d0 ea                    SHR DL,0x1
1000:5727      d0 ea                    SHR DL,0x1
1000:5729      d0 ea                    SHR DL,0x1
1000:572b      b8 1c 00                 MOV AX,0x1c
1000:572e      f6 e2                    MUL DL
1000:5730      be 1b 0f                 MOV SI,0xf1b
1000:5733      03 f0                    ADD SI,AX
1000:5735      8a 0c                    MOV CL,byte ptr [SI]
1000:5737      32 ed                    XOR CH,CH
1000:5739      46                       INC SI
1000:573a      8a 14                    MOV DL,byte ptr [SI]
1000:573c      32 f6                    XOR DH,DH
1000:573e      46                       INC SI
1000:573f      e8 a3 fd                 CALL 0x1000:54e5
1000:5742      5a                       POP DX
1000:5743      80 e2 0f                 AND DL,0xf
1000:5746      b8 1c 00                 MOV AX,0x1c
1000:5749      f6 e2                    MUL DL
1000:574b      be d3 10                 MOV SI,0x10d3
1000:574e      03 f0                    ADD SI,AX
1000:5750      8a 0c                    MOV CL,byte ptr [SI]
1000:5752      32 ed                    XOR CH,CH
1000:5754      46                       INC SI
1000:5755      8a 14                    MOV DL,byte ptr [SI]
1000:5757      32 f6                    XOR DH,DH
1000:5759      46                       INC SI
1000:575a      e8 88 fd                 CALL 0x1000:54e5
1000:575d      c3                       RET

; ------------------------------------------------------------
1000:575e  FUN_1000_575e:
1000:575e      b9 4a 00                 MOV CX,0x4a
1000:5761      ba 00 00                 MOV DX,0x0
1000:5764  LAB_1000_5764:
1000:5764      3c 00                    CMP AL,0x0
1000:5766      74 0f                    JZ 0x1000:5777
1000:5768      50                       PUSH AX
1000:5769      be a3 18                 MOV SI,0x18a3
1000:576c      e8 76 fd                 CALL 0x1000:54e5
1000:576f      83 c1 08                 ADD CX,0x8
1000:5772      58                       POP AX
1000:5773      fe c8                    DEC AL
1000:5775      75 ed                    JNZ 0x1000:5764
1000:5777  LAB_1000_5777:
1000:5777      c3                       RET

; ------------------------------------------------------------
1000:5778  FUN_1000_5778:
1000:5778      50                       PUSH AX
1000:5779      3c 0b                    CMP AL,0xb
1000:577b      72 02                    JC 0x1000:577f
1000:577d      b0 09                    MOV AL,0x9
1000:577f  LAB_1000_577f:
1000:577f      b9 4b 00                 MOV CX,0x4b
1000:5782      ba 0c 00                 MOV DX,0xc
1000:5785  LAB_1000_5785:
1000:5785      3c 00                    CMP AL,0x0
1000:5787      74 1a                    JZ 0x1000:57a3
1000:5789      50                       PUSH AX
1000:578a      be 8b 12                 MOV SI,0x128b
1000:578d      e8 55 fd                 CALL 0x1000:54e5
1000:5790      58                       POP AX
1000:5791      83 c1 08                 ADD CX,0x8
1000:5794      83 f9 73                 CMP CX,0x73
1000:5797      75 06                    JNZ 0x1000:579f
1000:5799      83 c2 0b                 ADD DX,0xb
1000:579c      b9 4b 00                 MOV CX,0x4b
1000:579f  LAB_1000_579f:
1000:579f      fe c8                    DEC AL
1000:57a1      75 e2                    JNZ 0x1000:5785
1000:57a3  LAB_1000_57a3:
1000:57a3      58                       POP AX
1000:57a4      3c 0b                    CMP AL,0xb
1000:57a6      72 06                    JC 0x1000:57ae
1000:57a8      be 9d 12                 MOV SI,0x129d
1000:57ab      e8 37 fd                 CALL 0x1000:54e5
1000:57ae  LAB_1000_57ae:
1000:57ae      c3                       RET

; ------------------------------------------------------------
1000:57af  FUN_1000_57af:
1000:57af      50                       PUSH AX
1000:57b0      52                       PUSH DX
1000:57b1      b9 02 00                 MOV CX,0x2
1000:57b4      e8 2e fd                 CALL 0x1000:54e5
1000:57b7      5a                       POP DX
1000:57b8      58                       POP AX
1000:57b9      52                       PUSH DX
1000:57ba      83 c2 01                 ADD DX,0x1
1000:57bd      b9 0a 00                 MOV CX,0xa
1000:57c0  LAB_1000_57c0:
1000:57c0      22 c0                    AND AL,AL
1000:57c2      74 2c                    JZ 0x1000:57f0
1000:57c4      3c 04                    CMP AL,0x4
1000:57c6      72 07                    JC 0x1000:57cf
1000:57c8      2c 04                    SUB AL,0x4
1000:57ca      be 97 1d                 MOV SI,0x1d97
1000:57cd      eb 13                    JMP 0x1000:57e2
1000:57cf  LAB_1000_57cf:
1000:57cf      be 87 1d                 MOV SI,0x1d87
1000:57d2      3c 03                    CMP AL,0x3
1000:57d4      74 0a                    JZ 0x1000:57e0
1000:57d6      be 77 1d                 MOV SI,0x1d77
1000:57d9      3c 02                    CMP AL,0x2
1000:57db      74 03                    JZ 0x1000:57e0
1000:57dd      be 67 1d                 MOV SI,0x1d67
1000:57e0  LAB_1000_57e0:
1000:57e0      32 c0                    XOR AL,AL
1000:57e2  LAB_1000_57e2:
1000:57e2      50                       PUSH AX
1000:57e3      52                       PUSH DX
1000:57e4      51                       PUSH CX
1000:57e5      e8 fd fc                 CALL 0x1000:54e5
1000:57e8      59                       POP CX
1000:57e9      5a                       POP DX
1000:57ea      58                       POP AX
1000:57eb      83 c1 04                 ADD CX,0x4
1000:57ee      eb d0                    JMP 0x1000:57c0
1000:57f0  LAB_1000_57f0:
1000:57f0      5a                       POP DX
1000:57f1      b9 0a 00                 MOV CX,0xa
1000:57f4      be a7 1d                 MOV SI,0x1da7
1000:57f7      e8 eb fc                 CALL 0x1000:54e5
1000:57fa      c3                       RET

; ------------------------------------------------------------
1000:57fb  print_inline:
1000:57fb      c6 06 64 a2 01           MOV byte ptr [0xa264],0x1
1000:5800      5b                       POP BX
1000:5801      06                       PUSH ES
1000:5802      8c c8                    MOV AX,CS
1000:5804      8e c0                    MOV ES,AX
1000:5806      e8 0c 00                 CALL 0x1000:5815
1000:5809      07                       POP ES
1000:580a      53                       PUSH BX
1000:580b      c3                       RET

; ------------------------------------------------------------
1000:580c  FUN_1000_580c:
1000:580c      c6 06 64 a2 02           MOV byte ptr [0xa264],0x2
1000:5811      8c d8                    MOV AX,DS
1000:5813      8e c0                    MOV ES,AX

; ------------------------------------------------------------
1000:5815  exec_script:
1000:5815      26 8a 07                 MOV AL,byte ptr ES:[BX]
1000:5818      e8 51 01                 CALL 0x1000:596c
1000:581b      43                       INC BX
1000:581c      3c ff                    CMP AL,0xff
1000:581e      74 07                    JZ 0x1000:5827
1000:5820      3c 00                    CMP AL,0x0
1000:5822      75 08                    JNZ 0x1000:582c
1000:5824      e8 89 fc                 CALL 0x1000:54b0
1000:5827  LAB_1000_5827:
1000:5827      8c d8                    MOV AX,DS
1000:5829      8e c0                    MOV ES,AX
1000:582b      c3                       RET
1000:582c  LAB_1000_582c:
1000:582c      3c 10                    CMP AL,0x10
1000:582e      76 09                    JBE 0x1000:5839
1000:5830      8a 26 9b a2              MOV AH,byte ptr [0xa29b]
1000:5834      e8 44 fd                 CALL 0x1000:557b
1000:5837      eb dc                    JMP 0x1000:5815
1000:5839  LAB_1000_5839:
1000:5839      3c 03                    CMP AL,0x3
1000:583b      77 05                    JA 0x1000:5842
1000:583d      a2 9b a2                 MOV [0xa29b],AL
1000:5840      eb d3                    JMP 0x1000:5815
1000:5842  LAB_1000_5842:
1000:5842      3c 04                    CMP AL,0x4
1000:5844      75 03                    JNZ 0x1000:5849
1000:5846      e9 91 00                 JMP 0x1000:58da
1000:5849  LAB_1000_5849:
1000:5849      3c 05                    CMP AL,0x5
1000:584b      75 12                    JNZ 0x1000:585f
1000:584d      26 8b 0f                 MOV CX,word ptr ES:[BX]
1000:5850      83 c1 04                 ADD CX,0x4
1000:5853      26 8b 57 02              MOV DX,word ptr ES:[BX + 0x2]
1000:5857      83 c3 04                 ADD BX,0x4
1000:585a      e8 0c fe                 CALL 0x1000:5669
1000:585d      eb b6                    JMP 0x1000:5815
1000:585f  LAB_1000_585f:
1000:585f      3c 07                    CMP AL,0x7
1000:5861      75 05                    JNZ 0x1000:5868
1000:5863      e8 99 00                 CALL 0x1000:58ff
1000:5866      eb ad                    JMP 0x1000:5815
1000:5868  LAB_1000_5868:
1000:5868      3c 0d                    CMP AL,0xd
1000:586a      75 19                    JNZ 0x1000:5885
1000:586c      a1 93 a2                 MOV AX,[0xa293]
1000:586f      2d 05 3f                 SUB AX,0x3f05
1000:5872      b9 f4 02                 MOV CX,0x2f4
1000:5875      33 d2                    XOR DX,DX
1000:5877      f7 f1                    DIV CX
1000:5879      33 d2                    XOR DX,DX
1000:587b      f7 e1                    MUL CX
1000:587d      05 05 3f                 ADD AX,0x3f05
1000:5880      a3 93 a2                 MOV [0xa293],AX
1000:5883      eb 90                    JMP 0x1000:5815
1000:5885  LAB_1000_5885:
1000:5885      3c 0a                    CMP AL,0xa
1000:5887      75 31                    JNZ 0x1000:58ba
1000:5889      a1 93 a2                 MOV AX,[0xa293]
1000:588c      05 f4 02                 ADD AX,0x2f4
1000:588f      3d 05 7e                 CMP AX,0x7e05
1000:5892      73 06                    JNC 0x1000:589a
1000:5894      a3 93 a2                 MOV [0xa293],AX
1000:5897      e9 7b ff                 JMP 0x1000:5815
1000:589a  LAB_1000_589a:
1000:589a      06                       PUSH ES
1000:589b      56                       PUSH SI
1000:589c      57                       PUSH DI
1000:589d      8c d8                    MOV AX,DS
1000:589f      8e c0                    MOV ES,AX
1000:58a1      be f5 41                 MOV SI,0x41f5
1000:58a4      bf 01 3f                 MOV DI,0x3f01
1000:58a7      b9 02 1f                 MOV CX,0x1f02
1000:58aa      fc                       CLD
1000:58ab      f3 a5                    MOVSW.REP ES:DI,SI
1000:58ad      33 c0                    XOR AX,AX
1000:58af      b9 7a 01                 MOV CX,0x17a
1000:58b2      f3 ab                    STOSW.REP ES:DI
1000:58b4      5f                       POP DI
1000:58b5      5e                       POP SI
1000:58b6      07                       POP ES
1000:58b7      e9 5b ff                 JMP 0x1000:5815
1000:58ba  LAB_1000_58ba:
1000:58ba      3c 0b                    CMP AL,0xb
1000:58bc      75 0c                    JNZ 0x1000:58ca
1000:58be      e8 8f fb                 CALL 0x1000:5450
1000:58c1      c7 06 93 a2 05 3f        MOV word ptr [0xa293],0x3f05
1000:58c7      e9 4b ff                 JMP 0x1000:5815
1000:58ca  LAB_1000_58ca:
1000:58ca      3c 0c                    CMP AL,0xc
1000:58cc      75 09                    JNZ 0x1000:58d7
1000:58ce      c7 06 93 a2 05 3f        MOV word ptr [0xa293],0x3f05
1000:58d4      e9 3e ff                 JMP 0x1000:5815
1000:58d7  LAB_1000_58d7:
1000:58d7      e9 3b ff                 JMP 0x1000:5815
1000:58da  LAB_1000_58da:
1000:58da      53                       PUSH BX
1000:58db      26 8b 37                 MOV SI,word ptr ES:[BX]
1000:58de      26 8b 4f 02              MOV CX,word ptr ES:[BX + 0x2]
1000:58e2      26 8b 57 04              MOV DX,word ptr ES:[BX + 0x4]
1000:58e6      bb 05 3f                 MOV BX,0x3f05
1000:58e9      c7 06 05 00 50 00        MOV word ptr [0x5],0x50
1000:58ef      e8 fb fb                 CALL 0x1000:54ed
1000:58f2      c7 06 05 00 35 00        MOV word ptr [0x5],0x35
1000:58f8      5b                       POP BX
1000:58f9      83 c3 06                 ADD BX,0x6
1000:58fc      e9 16 ff                 JMP 0x1000:5815

; ------------------------------------------------------------
1000:58ff  FUN_1000_58ff:
1000:58ff      53                       PUSH BX
1000:5900      b8 04 00                 MOV AX,0x4
1000:5903      bb 5a a2                 MOV BX,0xa25a
1000:5906      e8 8e c1                 CALL 0x1000:1a97
1000:5909      5b                       POP BX
1000:590a      c3                       RET

; ------------------------------------------------------------
1000:596c  decode_script_byte:
1000:596c      80 3e 64 a2 02           CMP byte ptr [0xa264],0x2
1000:5971      74 2b                    JZ 0x1000:599e
1000:5973      80 3e 64 a2 01           CMP byte ptr [0xa264],0x1
1000:5978      75 1c                    JNZ 0x1000:5996
1000:597a      c6 06 64 a2 00           MOV byte ptr [0xa264],0x0
1000:597f      50                       PUSH AX
1000:5980      8b c3                    MOV AX,BX
1000:5982      2e 03 07                 ADD AX,word ptr CS:[BX]
1000:5985      83 c3 02                 ADD BX,0x2
1000:5988      a2 65 a2                 MOV [0xa265],AL
1000:598b      05 57 13                 ADD AX,0x1357
1000:598e      09 06 01 a2              OR word ptr [0xa201],AX
1000:5992      58                       POP AX
1000:5993      2e 8a 07                 MOV AL,byte ptr CS:[BX]
1000:5996  LAB_1000_5996:
1000:5996      2a 06 65 a2              SUB AL,byte ptr [0xa265]
1000:599a      28 06 65 a2              SUB byte ptr [0xa265],AL
1000:599e  LAB_1000_599e:
1000:599e      c3                       RET

; ------------------------------------------------------------
1000:59a0  FUN_1000_59a0:
1000:59a0      e8 58 fe                 CALL 0x1000:57fb
                ; inline script -> 1000:59c7  <c1><clear>  WAITING FOR FIRST RESPONSE.  
1000:59c7  LAB_1000_59c7:
1000:59c7      e8 31 03                 CALL 0x1000:5cfb
1000:59ca  LAB_1000_59ca:
1000:59ca      e8 7f b2                 CALL 0x1000:0c4c
1000:59cd      c6 06 6f a2 00           MOV byte ptr [0xa26f],0x0
1000:59d2      ba 5a 41                 MOV DX,0x415a
1000:59d5      f6 06 86 a4 01           TEST byte ptr [0xa486],0x1
1000:59da      74 07                    JZ 0x1000:59e3
1000:59dc      c6 06 6f a2 01           MOV byte ptr [0xa26f],0x1
1000:59e1      86 d6                    XCHG DH,DL
1000:59e3  LAB_1000_59e3:
1000:59e3      52                       PUSH DX
1000:59e4      e8 14 03                 CALL 0x1000:5cfb
1000:59e7      e8 5b b1                 CALL 0x1000:0b45
1000:59ea      5a                       POP DX
1000:59eb      52                       PUSH DX
1000:59ec      8a c6                    MOV AL,DH
1000:59ee      e8 c7 04                 CALL 0x1000:5eb8
1000:59f1      e8 98 04                 CALL 0x1000:5e8c
1000:59f4      5a                       POP DX
1000:59f5      72 ec                    JC 0x1000:59e3
1000:59f7      3a c2                    CMP AL,DL
1000:59f9      74 26                    JZ 0x1000:5a21
1000:59fb      3a c6                    CMP AL,DH
1000:59fd      74 07                    JZ 0x1000:5a06
1000:59ff      52                       PUSH DX
1000:5a00      e8 49 b2                 CALL 0x1000:0c4c
1000:5a03      5a                       POP DX
1000:5a04      eb dd                    JMP 0x1000:59e3
1000:5a06  LAB_1000_5a06:
1000:5a06      e8 f2 fd                 CALL 0x1000:57fb
                ; inline script -> 1000:5a1f  <c1>STILL TRYING....  
1000:5a1f  LAB_1000_5a1f:
1000:5a1f      eb a9                    JMP 0x1000:59ca
1000:5a21  LAB_1000_5a21:
1000:5a21      b0 a0                    MOV AL,0xa0
1000:5a23      e8 92 04                 CALL 0x1000:5eb8
1000:5a26      c6 06 54 a2 36           MOV byte ptr [0xa254],0x36
1000:5a2b  LAB_1000_5a2b:
1000:5a2b      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
1000:5a30      74 d4                    JZ 0x1000:5a06
1000:5a32      e8 10 b1                 CALL 0x1000:0b45
1000:5a35      e8 54 04                 CALL 0x1000:5e8c
1000:5a38      72 f1                    JC 0x1000:5a2b
1000:5a3a      3c a0                    CMP AL,0xa0
1000:5a3c      75 ed                    JNZ 0x1000:5a2b
1000:5a3e      a0 c0 39                 MOV AL,[0x39c0]
1000:5a41      e8 74 04                 CALL 0x1000:5eb8
1000:5a44  LAB_1000_5a44:
1000:5a44      e8 fe b0                 CALL 0x1000:0b45
1000:5a47      e8 42 04                 CALL 0x1000:5e8c
1000:5a4a      72 f8                    JC 0x1000:5a44
1000:5a4c      3a 06 c0 39              CMP AL,byte ptr [0x39c0]
1000:5a50      74 03                    JZ 0x1000:5a55
1000:5a52      e9 ed 01                 JMP 0x1000:5c42
1000:5a55  LAB_1000_5a55:
1000:5a55      f6 06 6f a2 01           TEST byte ptr [0xa26f],0x1
1000:5a5a      75 03                    JNZ 0x1000:5a5f
1000:5a5c      e9 94 00                 JMP 0x1000:5af3
1000:5a5f  LAB_1000_5a5f:
1000:5a5f      bb 00 00                 MOV BX,0x0
1000:5a62      e8 af 02                 CALL 0x1000:5d14
1000:5a65      a2 83 a4                 MOV [0xa483],AL
1000:5a68      e8 a9 02                 CALL 0x1000:5d14
1000:5a6b      8a d0                    MOV DL,AL
1000:5a6d      e8 a4 02                 CALL 0x1000:5d14
1000:5a70      8a f0                    MOV DH,AL
1000:5a72      89 16 d0 89              MOV word ptr [0x89d0],DX
1000:5a76      89 16 84 a4              MOV word ptr [0xa484],DX
1000:5a7a      bf 31 a2                 MOV DI,0xa231
1000:5a7d      be 07 00                 MOV SI,0x7
1000:5a80      b9 03 00                 MOV CX,0x3
1000:5a83      f3 a4                    MOVSB.REP ES:DI,SI
1000:5a85      47                       INC DI
1000:5a86      a0 10 00                 MOV AL,[0x10]
1000:5a89      aa                       STOSB ES:DI
1000:5a8a      bf 26 a2                 MOV DI,0xa226
1000:5a8d      e8 84 02                 CALL 0x1000:5d14
1000:5a90      aa                       STOSB ES:DI
1000:5a91      e8 80 02                 CALL 0x1000:5d14
1000:5a94      aa                       STOSB ES:DI
1000:5a95      e8 7c 02                 CALL 0x1000:5d14
1000:5a98      aa                       STOSB ES:DI
1000:5a99      47                       INC DI
1000:5a9a      e8 77 02                 CALL 0x1000:5d14
1000:5a9d      aa                       STOSB ES:DI
1000:5a9e      53                       PUSH BX
1000:5a9f      e8 72 02                 CALL 0x1000:5d14
1000:5aa2      5b                       POP BX
1000:5aa3      3a c3                    CMP AL,BL
1000:5aa5      75 46                    JNZ 0x1000:5aed
1000:5aa7      53                       PUSH BX
1000:5aa8      e8 69 02                 CALL 0x1000:5d14
1000:5aab      5b                       POP BX
1000:5aac      3a c7                    CMP AL,BH
1000:5aae      75 3d                    JNZ 0x1000:5aed
1000:5ab0      bb 00 00                 MOV BX,0x0
1000:5ab3      a0 12 00                 MOV AL,[0x12]
1000:5ab6      e8 53 02                 CALL 0x1000:5d0c
1000:5ab9      8b 16 d0 89              MOV DX,word ptr [0x89d0]
1000:5abd      8a c2                    MOV AL,DL
1000:5abf      e8 4a 02                 CALL 0x1000:5d0c
1000:5ac2      8a c6                    MOV AL,DH
1000:5ac4      e8 45 02                 CALL 0x1000:5d0c
1000:5ac7      be 07 00                 MOV SI,0x7
1000:5aca      ac                       LODSB SI
1000:5acb      e8 3e 02                 CALL 0x1000:5d0c
1000:5ace      ac                       LODSB SI
1000:5acf      e8 3a 02                 CALL 0x1000:5d0c
1000:5ad2      ac                       LODSB SI
1000:5ad3      e8 36 02                 CALL 0x1000:5d0c
1000:5ad6      a0 10 00                 MOV AL,[0x10]
1000:5ad9      e8 30 02                 CALL 0x1000:5d0c
1000:5adc      8a c3                    MOV AL,BL
1000:5ade      e8 d7 03                 CALL 0x1000:5eb8
1000:5ae1      8a c7                    MOV AL,BH
1000:5ae3      e8 d2 03                 CALL 0x1000:5eb8
1000:5ae6      e8 2b 02                 CALL 0x1000:5d14
1000:5ae9      3c 40                    CMP AL,0x40
1000:5aeb      74 03                    JZ 0x1000:5af0
1000:5aed  LAB_1000_5aed:
1000:5aed      e9 b0 fe                 JMP 0x1000:59a0
1000:5af0  LAB_1000_5af0:
1000:5af0      e9 8e 00                 JMP 0x1000:5b81
1000:5af3  LAB_1000_5af3:
1000:5af3      bb 00 00                 MOV BX,0x0
1000:5af6      a0 12 00                 MOV AL,[0x12]
1000:5af9      e8 10 02                 CALL 0x1000:5d0c
1000:5afc      8b 16 d0 89              MOV DX,word ptr [0x89d0]
1000:5b00      8a c2                    MOV AL,DL
1000:5b02      e8 07 02                 CALL 0x1000:5d0c
1000:5b05      8a c6                    MOV AL,DH
1000:5b07      e8 02 02                 CALL 0x1000:5d0c
1000:5b0a      be 07 00                 MOV SI,0x7
1000:5b0d      ac                       LODSB SI
1000:5b0e      e8 fb 01                 CALL 0x1000:5d0c
1000:5b11      ac                       LODSB SI
1000:5b12      e8 f7 01                 CALL 0x1000:5d0c
1000:5b15      ac                       LODSB SI
1000:5b16      e8 f3 01                 CALL 0x1000:5d0c
1000:5b19      a0 10 00                 MOV AL,[0x10]
1000:5b1c      e8 ed 01                 CALL 0x1000:5d0c
1000:5b1f      8a c3                    MOV AL,BL
1000:5b21      e8 94 03                 CALL 0x1000:5eb8
1000:5b24      8a c7                    MOV AL,BH
1000:5b26      e8 8f 03                 CALL 0x1000:5eb8
1000:5b29      bb 00 00                 MOV BX,0x0
1000:5b2c      e8 e5 01                 CALL 0x1000:5d14
1000:5b2f      a2 83 a4                 MOV [0xa483],AL
1000:5b32      e8 df 01                 CALL 0x1000:5d14
1000:5b35      8a d0                    MOV DL,AL
1000:5b37      e8 da 01                 CALL 0x1000:5d14
1000:5b3a      8a f0                    MOV DH,AL
1000:5b3c      89 16 84 a4              MOV word ptr [0xa484],DX
1000:5b40      bf 26 a2                 MOV DI,0xa226
1000:5b43      be 07 00                 MOV SI,0x7
1000:5b46      b9 03 00                 MOV CX,0x3
1000:5b49      f3 a4                    MOVSB.REP ES:DI,SI
1000:5b4b      47                       INC DI
1000:5b4c      a0 10 00                 MOV AL,[0x10]
1000:5b4f      aa                       STOSB ES:DI
1000:5b50      bf 31 a2                 MOV DI,0xa231
1000:5b53      e8 be 01                 CALL 0x1000:5d14
1000:5b56      aa                       STOSB ES:DI
1000:5b57      e8 ba 01                 CALL 0x1000:5d14
1000:5b5a      aa                       STOSB ES:DI
1000:5b5b      e8 b6 01                 CALL 0x1000:5d14
1000:5b5e      aa                       STOSB ES:DI
1000:5b5f      47                       INC DI
1000:5b60      e8 b1 01                 CALL 0x1000:5d14
1000:5b63      aa                       STOSB ES:DI
1000:5b64      53                       PUSH BX
1000:5b65      e8 ac 01                 CALL 0x1000:5d14
1000:5b68      5b                       POP BX
1000:5b69      3a c3                    CMP AL,BL
1000:5b6b      75 11                    JNZ 0x1000:5b7e
1000:5b6d      53                       PUSH BX
1000:5b6e      e8 a3 01                 CALL 0x1000:5d14
1000:5b71      5b                       POP BX
1000:5b72      3a c7                    CMP AL,BH
1000:5b74      75 08                    JNZ 0x1000:5b7e
1000:5b76      b0 40                    MOV AL,0x40
1000:5b78      e8 3d 03                 CALL 0x1000:5eb8
1000:5b7b      eb 04                    JMP 0x1000:5b81
1000:5b7e  LAB_1000_5b7e:
1000:5b7e      e9 1f fe                 JMP 0x1000:59a0
1000:5b81  LAB_1000_5b81:
1000:5b81      a1 d0 89                 MOV AX,[0x89d0]
1000:5b84      3b 06 84 a4              CMP AX,word ptr [0xa484]
1000:5b88      75 f4                    JNZ 0x1000:5b7e
1000:5b8a      be 26 a2                 MOV SI,0xa226
1000:5b8d      bf 31 a2                 MOV DI,0xa231
1000:5b90      b9 03 00                 MOV CX,0x3
1000:5b93      f3 a6                    CMPSB.REPE ES:DI,SI
1000:5b95      75 03                    JNZ 0x1000:5b9a
1000:5b97      eb 1f                    JMP 0x1000:5bb8
1000:5b9a  LAB_1000_5b9a:
1000:5b9a      a0 83 a4                 MOV AL,[0xa483]
1000:5b9d      20 06 12 00              AND byte ptr [0x12],AL
1000:5ba1      b0 02                    MOV AL,0x2
1000:5ba3      b4 02                    MOV AH,0x2
1000:5ba5      f6 06 12 00 08           TEST byte ptr [0x12],0x8
1000:5baa      75 0b                    JNZ 0x1000:5bb7
1000:5bac      fe cc                    DEC AH
1000:5bae      f6 06 12 00 04           TEST byte ptr [0x12],0x4
1000:5bb3      75 02                    JNZ 0x1000:5bb7
1000:5bb5      fe cc                    DEC AH
1000:5bb7  LAB_1000_5bb7:
1000:5bb7      c3                       RET
1000:5bb8  LAB_1000_5bb8:
1000:5bb8      e8 40 fc                 CALL 0x1000:57fb
                ; inline script -> 1000:5c3f  <c2>  BOTH ENDS HAVE SAME INITIALS.  CAN NOT ESTABLISH LINK UNTIL ONE  PLAYER CHANGES HIS INITIALS.   <c3>HIT Esc KEY TO RETURN TO MENU
1000:5c3f  LAB_1000_5c3f:
1000:5c3f      e9 b4 00                 JMP 0x1000:5cf6
1000:5c42  LAB_1000_5c42:
1000:5c42      77 30                    JA 0x1000:5c74
1000:5c44      e8 b4 fb                 CALL 0x1000:57fb
                ; inline script -> 1000:5c71  <c2>  OPPONENT HAS A DOWN-LEVEL PROGRAM!  
1000:5c71  LAB_1000_5c71:
1000:5c71      eb 2a                    JMP 0x1000:5c9d
1000:5c74  LAB_1000_5c74:
1000:5c74      e8 84 fb                 CALL 0x1000:57fb
                ; inline script -> 1000:5c9d  <c2>  YOU HAVE A DOWN-LEVEL PROGRAM!  
1000:5c9d  LAB_1000_5c9d:
1000:5c9d      e8 5b fb                 CALL 0x1000:57fb
                ; inline script -> 1000:5cf6  <c2>CAN NOT PROCEED UNTIL BOTH ENDS  HAVE SAME LEVEL PROGRAM.  HIT Esc TO EXIT TO MENU
1000:5cf6  LAB_1000_5cf6:
1000:5cf6      e8 4c ae                 CALL 0x1000:0b45
1000:5cf9      eb fb                    JMP 0x1000:5cf6

; ------------------------------------------------------------
1000:5cfb  FUN_1000_5cfb:
1000:5cfb      c6 06 54 a2 0a           MOV byte ptr [0xa254],0xa
1000:5d00  LAB_1000_5d00:
1000:5d00      fe 06 86 a4              INC byte ptr [0xa486]
1000:5d04      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
1000:5d09      75 f5                    JNZ 0x1000:5d00
1000:5d0b      c3                       RET

; ------------------------------------------------------------
1000:5d0c  FUN_1000_5d0c:
1000:5d0c      50                       PUSH AX
1000:5d0d      e8 d9 05                 CALL 0x1000:62e9
1000:5d10      58                       POP AX
1000:5d11      e9 a4 01                 JMP 0x1000:5eb8

; ------------------------------------------------------------
1000:5d14  FUN_1000_5d14:
1000:5d14      e8 2e ae                 CALL 0x1000:0b45
1000:5d17      e8 72 01                 CALL 0x1000:5e8c
1000:5d1a      72 f8                    JC 0x1000:5d14
1000:5d1c      50                       PUSH AX
1000:5d1d      e8 c9 05                 CALL 0x1000:62e9
1000:5d20      58                       POP AX
1000:5d21      c3                       RET

; ------------------------------------------------------------
1000:5d22  FUN_1000_5d22:
1000:5d22      c7 06 55 a2 1c 02        MOV word ptr [0xa255],0x21c
1000:5d28  LAB_1000_5d28:
1000:5d28      e8 64 ba                 CALL 0x1000:178f
1000:5d2b      f6 06 0c a2 01           TEST byte ptr [0xa20c],0x1
1000:5d30      74 03                    JZ 0x1000:5d35
1000:5d32      eb 7d                    JMP 0x1000:5db1
1000:5d35  LAB_1000_5d35:
1000:5d35      83 3e 55 a2 00           CMP word ptr [0xa255],0x0
1000:5d3a      75 ec                    JNZ 0x1000:5d28
1000:5d3c      e8 bc fa                 CALL 0x1000:57fb
                ; inline script -> 1000:5dac  <c2><clear>  LOSS OF CARRIER,  OR SOMEBODY PULLED THE PLUG!   SORRY. CAN NOT CONTINUE   <c3>HIT Esc TO START NEW GAME.
1000:5dac  LAB_1000_5dac:
1000:5dac      e8 96 ad                 CALL 0x1000:0b45
1000:5daf      eb fb                    JMP 0x1000:5dac
1000:5db1  LAB_1000_5db1:
1000:5db1      be 0d a2                 MOV SI,0xa20d
1000:5db4      bb 7c a4                 MOV BX,0xa47c
1000:5db7      f6 06 6f a2 01           TEST byte ptr [0xa26f],0x1
1000:5dbc      74 02                    JZ 0x1000:5dc0
1000:5dbe      87 de                    XCHG SI,BX
1000:5dc0  LAB_1000_5dc0:
1000:5dc0      bf 12 a2                 MOV DI,0xa212
1000:5dc3      b9 04 00                 MOV CX,0x4
1000:5dc6      f3 a4                    MOVSB.REP ES:DI,SI
1000:5dc8      b0 01                    MOV AL,0x1
1000:5dca      aa                       STOSB ES:DI
1000:5dcb      87 de                    XCHG SI,BX
1000:5dcd      b9 04 00                 MOV CX,0x4
1000:5dd0      f3 a4                    MOVSB.REP ES:DI,SI
1000:5dd2      b0 01                    MOV AL,0x1
1000:5dd4      aa                       STOSB ES:DI
1000:5dd5      c3                       RET

; ------------------------------------------------------------
1000:5dd6  FUN_1000_5dd6:
1000:5dd6      a1 a7 00                 MOV AX,[0xa7]
1000:5dd9      23 c0                    AND AX,AX
1000:5ddb      75 01                    JNZ 0x1000:5dde
1000:5ddd      c3                       RET
1000:5dde  LAB_1000_5dde:
1000:5dde      fa                       CLI
1000:5ddf      06                       PUSH ES
1000:5de0      33 d2                    XOR DX,DX
1000:5de2      8e c2                    MOV ES,DX
1000:5de4      f6 06 0c 00 01           TEST byte ptr [0xc],0x1
1000:5de9      75 0e                    JNZ 0x1000:5df9
1000:5deb      26 c7 06 30 00 ea 5e     MOV word ptr ES:[0x30],0x5eea
1000:5df2      26 8c 0e 32 00           MOV word ptr ES:[0x32],CS
1000:5df7      eb 0c                    JMP 0x1000:5e05
1000:5df9  LAB_1000_5df9:
1000:5df9      26 c7 06 2c 00 ea 5e     MOV word ptr ES:[0x2c],0x5eea
1000:5e00      26 8c 0e 2e 00           MOV word ptr ES:[0x2e],CS
1000:5e05  LAB_1000_5e05:
1000:5e05      07                       POP ES
1000:5e06      e8 05 00                 CALL 0x1000:5e0e
1000:5e09      e8 6f 01                 CALL 0x1000:5f7b
1000:5e0c      fb                       STI
1000:5e0d      c3                       RET

; ------------------------------------------------------------
1000:5e0e  FUN_1000_5e0e:
1000:5e0e      8b 16 a7 00              MOV DX,word ptr [0xa7]
1000:5e12      83 c2 03                 ADD DX,0x3
1000:5e15      b0 80                    MOV AL,0x80
1000:5e17      ee                       OUT DX,AL
1000:5e18      a0 0b 00                 MOV AL,[0xb]
1000:5e1b      25 07 00                 AND AX,0x7
1000:5e1e      d1 e0                    SHL AX,0x1
1000:5e20      d1 e0                    SHL AX,0x1
1000:5e22      bf 76 39                 MOV DI,0x3976
1000:5e25      03 f8                    ADD DI,AX
1000:5e27      8b 16 a7 00              MOV DX,word ptr [0xa7]
1000:5e2b      42                       INC DX
1000:5e2c      8a 45 01                 MOV AL,byte ptr [DI + 0x1]
1000:5e2f      eb 00                    JMP 0x1000:5e31
1000:5e31  LAB_1000_5e31:
1000:5e31      ee                       OUT DX,AL
1000:5e32      4a                       DEC DX
1000:5e33      8a 05                    MOV AL,byte ptr [DI]
1000:5e35      eb 00                    JMP 0x1000:5e37
1000:5e37  LAB_1000_5e37:
1000:5e37      ee                       OUT DX,AL
1000:5e38      83 c2 03                 ADD DX,0x3
1000:5e3b      b0 03                    MOV AL,0x3
1000:5e3d      eb 00                    JMP 0x1000:5e3f
1000:5e3f  LAB_1000_5e3f:
1000:5e3f      ee                       OUT DX,AL
1000:5e40      83 ea 03                 SUB DX,0x3
1000:5e43      33 c9                    XOR CX,CX
1000:5e45  LAB_1000_5e45:
1000:5e45      eb 00                    JMP 0x1000:5e47
1000:5e47  LAB_1000_5e47:
1000:5e47      ec                       IN AL,DX
1000:5e48      e2 fb                    LOOP 0x1000:5e45
1000:5e4a      83 c2 06                 ADD DX,0x6
1000:5e4d      eb 00                    JMP 0x1000:5e4f
1000:5e4f  LAB_1000_5e4f:
1000:5e4f      ec                       IN AL,DX
1000:5e50      eb 00                    JMP 0x1000:5e52
1000:5e52  LAB_1000_5e52:
1000:5e52      ec                       IN AL,DX
1000:5e53      83 ea 02                 SUB DX,0x2
1000:5e56      b0 0b                    MOV AL,0xb
1000:5e58      eb 00                    JMP 0x1000:5e5a
1000:5e5a  LAB_1000_5e5a:
1000:5e5a      ee                       OUT DX,AL
1000:5e5b      83 ea 03                 SUB DX,0x3
1000:5e5e      b0 03                    MOV AL,0x3
1000:5e60      eb 00                    JMP 0x1000:5e62
1000:5e62  LAB_1000_5e62:
1000:5e62      ee                       OUT DX,AL
1000:5e63      42                       INC DX
1000:5e64      eb 00                    JMP 0x1000:5e66
1000:5e66  LAB_1000_5e66:
1000:5e66      ec                       IN AL,DX
1000:5e67      a0 00 a2                 MOV AL,[0xa200]
1000:5e6a      0c 18                    OR AL,0x18
1000:5e6c      f6 06 0c 00 01           TEST byte ptr [0xc],0x1
1000:5e71      74 04                    JZ 0x1000:5e77
1000:5e73      24 f7                    AND AL,0xf7
1000:5e75      eb 02                    JMP 0x1000:5e79
1000:5e77  LAB_1000_5e77:
1000:5e77      24 ef                    AND AL,0xef
1000:5e79  LAB_1000_5e79:
1000:5e79      a2 00 a2                 MOV [0xa200],AL
1000:5e7c      e6 21                    OUT 0x21,AL
1000:5e7e      c3                       RET

; ------------------------------------------------------------
1000:5e7f  FUN_1000_5e7f:
1000:5e7f      fa                       CLI
1000:5e80      a0 00 a2                 MOV AL,[0xa200]
1000:5e83      0c 18                    OR AL,0x18
1000:5e85      a2 00 a2                 MOV [0xa200],AL
1000:5e88      e6 21                    OUT 0x21,AL
1000:5e8a      fb                       STI
1000:5e8b      c3                       RET

; ------------------------------------------------------------
1000:5e8c  FUN_1000_5e8c:
1000:5e8c      fa                       CLI
1000:5e8d      e8 02 00                 CALL 0x1000:5e92
1000:5e90      fb                       STI
1000:5e91      c3                       RET

; ------------------------------------------------------------
1000:5e92  FUN_1000_5e92:
1000:5e92      fc                       CLD
1000:5e93      56                       PUSH SI
1000:5e94      b0 00                    MOV AL,0x0
1000:5e96      83 3e 70 39 00           CMP word ptr [0x3970],0x0
1000:5e9b      f9                       STC
1000:5e9c      74 18                    JZ 0x1000:5eb6
1000:5e9e      8b 36 74 39              MOV SI,word ptr [0x3974]
1000:5ea2      ac                       LODSB SI
1000:5ea3      ff 0e 70 39              DEC word ptr [0x3970]
1000:5ea7      81 fe 70 a4              CMP SI,0xa470
1000:5eab      75 03                    JNZ 0x1000:5eb0
1000:5ead      be 70 a3                 MOV SI,0xa370
1000:5eb0  LAB_1000_5eb0:
1000:5eb0      89 36 74 39              MOV word ptr [0x3974],SI
1000:5eb4      46                       INC SI
1000:5eb5      f8                       CLC
1000:5eb6  LAB_1000_5eb6:
1000:5eb6      5e                       POP SI
1000:5eb7      c3                       RET

; ------------------------------------------------------------
1000:5eb8  FUN_1000_5eb8:
1000:5eb8      e8 03 00                 CALL 0x1000:5ebe
1000:5ebb      72 fb                    JC 0x1000:5eb8
1000:5ebd      c3                       RET

; ------------------------------------------------------------
1000:5ebe  FUN_1000_5ebe:
1000:5ebe      52                       PUSH DX
1000:5ebf      50                       PUSH AX
1000:5ec0      8b 16 a7 00              MOV DX,word ptr [0xa7]
1000:5ec4      83 c2 05                 ADD DX,0x5
1000:5ec7      ec                       IN AL,DX
1000:5ec8      24 20                    AND AL,0x20
1000:5eca      58                       POP AX
1000:5ecb      f9                       STC
1000:5ecc      74 07                    JZ 0x1000:5ed5
1000:5ece      83 ea 05                 SUB DX,0x5
1000:5ed1      eb 00                    JMP 0x1000:5ed3
1000:5ed3  LAB_1000_5ed3:
1000:5ed3      ee                       OUT DX,AL
1000:5ed4      f8                       CLC
1000:5ed5  LAB_1000_5ed5:
1000:5ed5      5a                       POP DX
1000:5ed6      c3                       RET

; ------------------------------------------------------------
1000:5ed7  FUN_1000_5ed7:
1000:5ed7      50                       PUSH AX
1000:5ed8      52                       PUSH DX
1000:5ed9      8b 16 a7 00              MOV DX,word ptr [0xa7]
1000:5edd      83 c2 06                 ADD DX,0x6
1000:5ee0      ec                       IN AL,DX
1000:5ee1      24 80                    AND AL,0x80
1000:5ee3      5a                       POP DX
1000:5ee4      58                       POP AX
1000:5ee5      f9                       STC
1000:5ee6      74 01                    JZ 0x1000:5ee9
1000:5ee8      f8                       CLC
1000:5ee9  LAB_1000_5ee9:
1000:5ee9      c3                       RET
1000:5eea  serial_isr:
1000:5eea      fc                       CLD
1000:5eeb      50                       PUSH AX
1000:5eec      53                       PUSH BX
1000:5eed      51                       PUSH CX
1000:5eee      52                       PUSH DX
1000:5eef      1e                       PUSH DS
1000:5ef0      06                       PUSH ES
1000:5ef1      57                       PUSH DI
1000:5ef2      56                       PUSH SI
1000:5ef3      2e a1 00 00              MOV AX,CS:[0x0]
1000:5ef7      8e d8                    MOV DS,AX
1000:5ef9      8e c0                    MOV ES,AX
1000:5efb      8b 16 a7 00              MOV DX,word ptr [0xa7]
1000:5eff      83 c2 02                 ADD DX,0x2
1000:5f02      ec                       IN AL,DX
1000:5f03      3c 04                    CMP AL,0x4
1000:5f05      74 10                    JZ 0x1000:5f17
1000:5f07      a8 01                    TEST AL,0x1
1000:5f09      75 0c                    JNZ 0x1000:5f17
1000:5f0b      3c 06                    CMP AL,0x6
1000:5f0d      74 4a                    JZ 0x1000:5f59
1000:5f0f      3c 02                    CMP AL,0x2
1000:5f11      74 50                    JZ 0x1000:5f63
1000:5f13      3c 00                    CMP AL,0x0
1000:5f15      74 5a                    JZ 0x1000:5f71
1000:5f17  LAB_1000_5f17:
1000:5f17      8b 16 a7 00              MOV DX,word ptr [0xa7]
1000:5f1b      83 c2 05                 ADD DX,0x5
1000:5f1e      ec                       IN AL,DX
1000:5f1f      a8 01                    TEST AL,0x1
1000:5f21      74 27                    JZ 0x1000:5f4a
1000:5f23      8b 16 a7 00              MOV DX,word ptr [0xa7]
1000:5f27      eb 00                    JMP 0x1000:5f29
1000:5f29  LAB_1000_5f29:
1000:5f29      ec                       IN AL,DX
1000:5f2a      81 3e 70 39 00 01        CMP word ptr [0x3970],0x100
1000:5f30      74 18                    JZ 0x1000:5f4a
1000:5f32      ff 06 70 39              INC word ptr [0x3970]
1000:5f36      8b 36 72 39              MOV SI,word ptr [0x3972]
1000:5f3a      88 04                    MOV byte ptr [SI],AL
1000:5f3c      46                       INC SI
1000:5f3d      81 fe 70 a4              CMP SI,0xa470
1000:5f41      75 03                    JNZ 0x1000:5f46
1000:5f43      be 70 a3                 MOV SI,0xa370
1000:5f46  LAB_1000_5f46:
1000:5f46      89 36 72 39              MOV word ptr [0x3972],SI
1000:5f4a  LAB_1000_5f4a:
1000:5f4a      cd 01                    INT 0x1
1000:5f4c      5e                       POP SI
1000:5f4d      5f                       POP DI
1000:5f4e      07                       POP ES
1000:5f4f      1f                       POP DS
1000:5f50      5a                       POP DX
1000:5f51      59                       POP CX
1000:5f52      5b                       POP BX
1000:5f53      b0 20                    MOV AL,0x20
1000:5f55      e6 20                    OUT 0x20,AL
1000:5f57      58                       POP AX
1000:5f58      cf                       IRET
1000:5f59  LAB_1000_5f59:
1000:5f59      8b 16 a7 00              MOV DX,word ptr [0xa7]
1000:5f5d      83 c2 05                 ADD DX,0x5
1000:5f60      ec                       IN AL,DX
1000:5f61      eb b4                    JMP 0x1000:5f17
1000:5f63  LAB_1000_5f63:
1000:5f63      8b 16 a7 00              MOV DX,word ptr [0xa7]
1000:5f67      83 c2 02                 ADD DX,0x2
1000:5f6a      ec                       IN AL,DX
1000:5f6b      42                       INC DX
1000:5f6c      eb 00                    JMP 0x1000:5f6e
1000:5f6e  LAB_1000_5f6e:
1000:5f6e      ec                       IN AL,DX
1000:5f6f      eb a6                    JMP 0x1000:5f17
1000:5f71  LAB_1000_5f71:
1000:5f71      8b 16 a7 00              MOV DX,word ptr [0xa7]
1000:5f75      83 c2 06                 ADD DX,0x6
1000:5f78      ec                       IN AL,DX
1000:5f79      eb 9c                    JMP 0x1000:5f17

; ------------------------------------------------------------
1000:5f7b  FUN_1000_5f7b:
1000:5f7b      c7 06 74 39 70 a3        MOV word ptr [0x3974],0xa370
1000:5f81      c7 06 72 39 70 a3        MOV word ptr [0x3972],0xa370
1000:5f87      c7 06 70 39 00 00        MOV word ptr [0x3970],0x0
1000:5f8d      52                       PUSH DX
1000:5f8e      50                       PUSH AX
1000:5f8f      51                       PUSH CX
1000:5f90      8b 16 a7 00              MOV DX,word ptr [0xa7]
1000:5f94      b9 f4 01                 MOV CX,0x1f4
1000:5f97  LAB_1000_5f97:
1000:5f97      eb 00                    JMP 0x1000:5f99
1000:5f99  LAB_1000_5f99:
1000:5f99      ec                       IN AL,DX
1000:5f9a      e2 fb                    LOOP 0x1000:5f97
1000:5f9c      59                       POP CX
1000:5f9d      58                       POP AX
1000:5f9e      5a                       POP DX
1000:5f9f      c3                       RET

; ------------------------------------------------------------
1000:5fa0  FUN_1000_5fa0:
1000:5fa0      80 3e 0a 00 02           CMP byte ptr [0xa],0x2
1000:5fa5      74 07                    JZ 0x1000:5fae
1000:5fa7      c7 06 09 a2 00 00        MOV word ptr [0xa209],0x0
1000:5fad      c3                       RET
1000:5fae  LAB_1000_5fae:
1000:5fae      c6 06 70 a4 00           MOV byte ptr [0xa470],0x0
1000:5fb3      a0 0b 00                 MOV AL,[0xb]
1000:5fb6      25 07 00                 AND AX,0x7
1000:5fb9      d1 e0                    SHL AX,0x1
1000:5fbb      d1 e0                    SHL AX,0x1
1000:5fbd      bf 76 39                 MOV DI,0x3976
1000:5fc0      03 f8                    ADD DI,AX
1000:5fc2      f6 06 6f a2 01           TEST byte ptr [0xa26f],0x1
1000:5fc7      74 0c                    JZ 0x1000:5fd5
1000:5fc9      8a 45 02                 MOV AL,byte ptr [DI + 0x2]
1000:5fcc      a2 82 a4                 MOV [0xa482],AL
1000:5fcf      a2 81 a4                 MOV [0xa481],AL
1000:5fd2      e9 7c 01                 JMP 0x1000:6151
1000:5fd5  LAB_1000_5fd5:
1000:5fd5      8a 45 03                 MOV AL,byte ptr [DI + 0x3]
1000:5fd8      a2 82 a4                 MOV [0xa482],AL
1000:5fdb      c6 06 81 a4 1e           MOV byte ptr [0xa481],0x1e
1000:5fe0      eb 0f                    JMP 0x1000:5ff1
1000:5fe3  int01_trap:
1000:5fe3      83 3e 09 a2 00           CMP word ptr [0xa209],0x0
1000:5fe8      74 06                    JZ 0x1000:5ff0
1000:5fea      8b 1e 09 a2              MOV BX,word ptr [0xa209]
1000:5fee      ff d3                    CALL BX
1000:5ff0  LAB_1000_5ff0:
1000:5ff0      cf                       IRET
1000:5ff1  LAB_1000_5ff1:
1000:5ff1      c7 06 09 a2 f1 5f        MOV word ptr [0xa209],0x5ff1
1000:5ff7      80 3e 0c a2 80           CMP byte ptr [0xa20c],0x80
1000:5ffc      74 01                    JZ 0x1000:5fff
1000:5ffe  LAB_1000_5ffe:
1000:5ffe      c3                       RET
1000:5fff  LAB_1000_5fff:
1000:5fff      be 0d a2                 MOV SI,0xa20d
1000:6002      bf 74 a4                 MOV DI,0xa474
1000:6005      b9 04 00                 MOV CX,0x4
1000:6008      f3 a4                    MOVSB.REP ES:DI,SI
1000:600a      c6 06 0c a2 00           MOV byte ptr [0xa20c],0x0
1000:600f      c7 06 09 a2 0f 60        MOV word ptr [0xa209],0x600f
1000:6015      a0 70 a4                 MOV AL,[0xa470]
1000:6018      e8 a3 fe                 CALL 0x1000:5ebe
1000:601b      72 e1                    JC 0x1000:5ffe
1000:601d      c7 06 71 a4 00 00        MOV word ptr [0xa471],0x0
1000:6023      e8 b7 02                 CALL 0x1000:62dd
1000:6026      c7 06 09 a2 26 60        MOV word ptr [0xa209],0x6026
1000:602c      a0 74 a4                 MOV AL,[0xa474]
1000:602f      e8 8c fe                 CALL 0x1000:5ebe
1000:6032      72 ca                    JC 0x1000:5ffe
1000:6034      e8 a6 02                 CALL 0x1000:62dd
1000:6037      c7 06 09 a2 37 60        MOV word ptr [0xa209],0x6037
1000:603d      a0 75 a4                 MOV AL,[0xa475]
1000:6040      e8 7b fe                 CALL 0x1000:5ebe
1000:6043      72 b9                    JC 0x1000:5ffe
1000:6045      e8 95 02                 CALL 0x1000:62dd
1000:6048      c7 06 09 a2 48 60        MOV word ptr [0xa209],0x6048
1000:604e      a0 76 a4                 MOV AL,[0xa476]
1000:6051      e8 6a fe                 CALL 0x1000:5ebe
1000:6054      72 5f                    JC 0x1000:60b5
1000:6056      e8 84 02                 CALL 0x1000:62dd
1000:6059      c7 06 09 a2 59 60        MOV word ptr [0xa209],0x6059
1000:605f      a0 77 a4                 MOV AL,[0xa477]
1000:6062      e8 59 fe                 CALL 0x1000:5ebe
1000:6065      72 4e                    JC 0x1000:60b5
1000:6067      e8 73 02                 CALL 0x1000:62dd
1000:606a      c7 06 09 a2 6a 60        MOV word ptr [0xa209],0x606a
1000:6070      a0 6f a2                 MOV AL,[0xa26f]
1000:6073      e8 48 fe                 CALL 0x1000:5ebe
1000:6076      72 3d                    JC 0x1000:60b5
1000:6078      e8 62 02                 CALL 0x1000:62dd
1000:607b      c7 06 09 a2 7b 60        MOV word ptr [0xa209],0x607b
1000:6081      a0 71 a4                 MOV AL,[0xa471]
1000:6084      e8 37 fe                 CALL 0x1000:5ebe
1000:6087      72 2c                    JC 0x1000:60b5
1000:6089      c7 06 09 a2 89 60        MOV word ptr [0xa209],0x6089
1000:608f      a0 72 a4                 MOV AL,[0xa472]
1000:6092      e8 29 fe                 CALL 0x1000:5ebe
1000:6095      72 1e                    JC 0x1000:60b5
1000:6097      a0 81 a4                 MOV AL,[0xa481]
1000:609a      a2 54 a2                 MOV [0xa254],AL
1000:609d      a0 82 a4                 MOV AL,[0xa482]
1000:60a0      a2 81 a4                 MOV [0xa481],AL
1000:60a3      c7 06 09 a2 a3 60        MOV word ptr [0xa209],0x60a3
1000:60a9      e8 e6 fd                 CALL 0x1000:5e92
1000:60ac      73 0b                    JNC 0x1000:60b9
1000:60ae      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
1000:60b3      74 01                    JZ 0x1000:60b6
1000:60b5  LAB_1000_60b5:
1000:60b5      c3                       RET
1000:60b6  LAB_1000_60b6:
1000:60b6      e9 7f 00                 JMP 0x1000:6138
1000:60b9  LAB_1000_60b9:
1000:60b9      3a 06 70 a4              CMP AL,byte ptr [0xa470]
1000:60bd      75 79                    JNZ 0x1000:6138
1000:60bf      c7 06 09 a2 bf 60        MOV word ptr [0xa209],0x60bf
1000:60c5      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
1000:60ca      74 6c                    JZ 0x1000:6138
1000:60cc      83 3e 70 39 07           CMP word ptr [0x3970],0x7
1000:60d1      72 7d                    JC 0x1000:6150
1000:60d3      bb 00 00                 MOV BX,0x0
1000:60d6      a0 70 a4                 MOV AL,[0xa470]
1000:60d9      e8 0d 02                 CALL 0x1000:62e9
1000:60dc      e8 b3 fd                 CALL 0x1000:5e92
1000:60df      a2 78 a4                 MOV [0xa478],AL
1000:60e2      e8 04 02                 CALL 0x1000:62e9
1000:60e5      e8 aa fd                 CALL 0x1000:5e92
1000:60e8      a2 79 a4                 MOV [0xa479],AL
1000:60eb      e8 fb 01                 CALL 0x1000:62e9
1000:60ee      e8 a1 fd                 CALL 0x1000:5e92
1000:60f1      a2 7a a4                 MOV [0xa47a],AL
1000:60f4      e8 f2 01                 CALL 0x1000:62e9
1000:60f7      e8 98 fd                 CALL 0x1000:5e92
1000:60fa      a2 7b a4                 MOV [0xa47b],AL
1000:60fd      e8 e9 01                 CALL 0x1000:62e9
1000:6100      e8 8f fd                 CALL 0x1000:5e92
1000:6103      a2 80 a4                 MOV [0xa480],AL
1000:6106      e8 e0 01                 CALL 0x1000:62e9
1000:6109      e8 86 fd                 CALL 0x1000:5e92
1000:610c      3a c3                    CMP AL,BL
1000:610e      75 28                    JNZ 0x1000:6138
1000:6110      e8 7f fd                 CALL 0x1000:5e92
1000:6113      3a c7                    CMP AL,BH
1000:6115      75 21                    JNZ 0x1000:6138
1000:6117      a0 6f a2                 MOV AL,[0xa26f]
1000:611a      3a 06 80 a4              CMP AL,byte ptr [0xa480]
1000:611e      74 18                    JZ 0x1000:6138
1000:6120      80 06 70 a4 01           ADD byte ptr [0xa470],0x1
1000:6125      be 78 a4                 MOV SI,0xa478
1000:6128      bf 7c a4                 MOV DI,0xa47c
1000:612b      b9 04 00                 MOV CX,0x4
1000:612e      f3 a4                    MOVSB.REP ES:DI,SI
1000:6130      c6 06 0c a2 01           MOV byte ptr [0xa20c],0x1
1000:6135      e9 b9 fe                 JMP 0x1000:5ff1
1000:6138  LAB_1000_6138:
1000:6138      c7 06 09 a2 38 61        MOV word ptr [0xa209],0x6138
1000:613e      e8 8e 01                 CALL 0x1000:62cf
1000:6141      e8 4e fd                 CALL 0x1000:5e92
1000:6144      73 f2                    JNC 0x1000:6138
1000:6146      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
1000:614b      75 03                    JNZ 0x1000:6150
1000:614d      e9 af fe                 JMP 0x1000:5fff
1000:6150  LAB_1000_6150:
1000:6150      c3                       RET
1000:6151  LAB_1000_6151:
1000:6151      c7 06 09 a2 51 61        MOV word ptr [0xa209],0x6151
1000:6157      83 3e 70 39 00           CMP word ptr [0x3970],0x0
1000:615c      74 1a                    JZ 0x1000:6178
1000:615e      a0 81 a4                 MOV AL,[0xa481]
1000:6161      a2 54 a2                 MOV [0xa254],AL
1000:6164      c7 06 09 a2 64 61        MOV word ptr [0xa209],0x6164
1000:616a      83 3e 70 39 08           CMP word ptr [0x3970],0x8
1000:616f      73 08                    JNC 0x1000:6179
1000:6171      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
1000:6176      74 d9                    JZ 0x1000:6151
1000:6178  LAB_1000_6178:
1000:6178      c3                       RET
1000:6179  LAB_1000_6179:
1000:6179      bb 00 00                 MOV BX,0x0
1000:617c      e8 13 fd                 CALL 0x1000:5e92
1000:617f      c6 06 73 a4 00           MOV byte ptr [0xa473],0x0
1000:6184      3a 06 70 a4              CMP AL,byte ptr [0xa470]
1000:6188      74 12                    JZ 0x1000:619c
1000:618a      04 01                    ADD AL,0x1
1000:618c      3a 06 70 a4              CMP AL,byte ptr [0xa470]
1000:6190      74 03                    JZ 0x1000:6195
1000:6192  LAB_1000_6192:
1000:6192      e9 22 01                 JMP 0x1000:62b7
1000:6195  LAB_1000_6195:
1000:6195      c6 06 73 a4 01           MOV byte ptr [0xa473],0x1
1000:619a      2c 01                    SUB AL,0x1
1000:619c  LAB_1000_619c:
1000:619c      e8 4a 01                 CALL 0x1000:62e9
1000:619f      e8 f0 fc                 CALL 0x1000:5e92
1000:61a2      a2 78 a4                 MOV [0xa478],AL
1000:61a5      e8 41 01                 CALL 0x1000:62e9
1000:61a8      e8 e7 fc                 CALL 0x1000:5e92
1000:61ab      a2 79 a4                 MOV [0xa479],AL
1000:61ae      e8 38 01                 CALL 0x1000:62e9
1000:61b1      e8 de fc                 CALL 0x1000:5e92
1000:61b4      a2 7a a4                 MOV [0xa47a],AL
1000:61b7      e8 2f 01                 CALL 0x1000:62e9
1000:61ba      e8 d5 fc                 CALL 0x1000:5e92
1000:61bd      a2 7b a4                 MOV [0xa47b],AL
1000:61c0      e8 26 01                 CALL 0x1000:62e9
1000:61c3      e8 cc fc                 CALL 0x1000:5e92
1000:61c6      a2 80 a4                 MOV [0xa480],AL
1000:61c9      e8 1d 01                 CALL 0x1000:62e9
1000:61cc      e8 c3 fc                 CALL 0x1000:5e92
1000:61cf      3a c3                    CMP AL,BL
1000:61d1      75 bf                    JNZ 0x1000:6192
1000:61d3      e8 bc fc                 CALL 0x1000:5e92
1000:61d6      3a c7                    CMP AL,BH
1000:61d8      75 b8                    JNZ 0x1000:6192
1000:61da      a0 6f a2                 MOV AL,[0xa26f]
1000:61dd      3a 06 80 a4              CMP AL,byte ptr [0xa480]
1000:61e1      74 af                    JZ 0x1000:6192
1000:61e3      80 3e 73 a4 00           CMP byte ptr [0xa473],0x0
1000:61e8      75 1d                    JNZ 0x1000:6207
1000:61ea      c7 06 09 a2 ea 61        MOV word ptr [0xa209],0x61ea
1000:61f0      80 3e 0c a2 80           CMP byte ptr [0xa20c],0x80
1000:61f5      75 22                    JNZ 0x1000:6219
1000:61f7      be 0d a2                 MOV SI,0xa20d
1000:61fa      bf 74 a4                 MOV DI,0xa474
1000:61fd      b9 04 00                 MOV CX,0x4
1000:6200      f3 a4                    MOVSB.REP ES:DI,SI
1000:6202      c6 06 0c a2 00           MOV byte ptr [0xa20c],0x0
1000:6207  LAB_1000_6207:
1000:6207      c7 06 09 a2 07 62        MOV word ptr [0xa209],0x6207
1000:620d      a0 70 a4                 MOV AL,[0xa470]
1000:6210      2a 06 73 a4              SUB AL,byte ptr [0xa473]
1000:6214      e8 a7 fc                 CALL 0x1000:5ebe
1000:6217      73 01                    JNC 0x1000:621a
1000:6219  LAB_1000_6219:
1000:6219      c3                       RET
1000:621a  LAB_1000_621a:
1000:621a      c7 06 71 a4 00 00        MOV word ptr [0xa471],0x0
1000:6220      e8 ba 00                 CALL 0x1000:62dd
1000:6223      c7 06 09 a2 23 62        MOV word ptr [0xa209],0x6223
1000:6229      a0 74 a4                 MOV AL,[0xa474]
1000:622c      e8 8f fc                 CALL 0x1000:5ebe
1000:622f      72 e8                    JC 0x1000:6219
1000:6231      e8 a9 00                 CALL 0x1000:62dd
1000:6234      c7 06 09 a2 34 62        MOV word ptr [0xa209],0x6234
1000:623a      a0 75 a4                 MOV AL,[0xa475]
1000:623d      e8 7e fc                 CALL 0x1000:5ebe
1000:6240      72 d7                    JC 0x1000:6219
1000:6242      e8 98 00                 CALL 0x1000:62dd
1000:6245      c7 06 09 a2 45 62        MOV word ptr [0xa209],0x6245
1000:624b      a0 76 a4                 MOV AL,[0xa476]
1000:624e      e8 6d fc                 CALL 0x1000:5ebe
1000:6251      72 c6                    JC 0x1000:6219
1000:6253      e8 87 00                 CALL 0x1000:62dd
1000:6256      c7 06 09 a2 56 62        MOV word ptr [0xa209],0x6256
1000:625c      a0 77 a4                 MOV AL,[0xa477]
1000:625f      e8 5c fc                 CALL 0x1000:5ebe
1000:6262      72 b5                    JC 0x1000:6219
1000:6264      e8 76 00                 CALL 0x1000:62dd
1000:6267      c7 06 09 a2 67 62        MOV word ptr [0xa209],0x6267
1000:626d      a0 6f a2                 MOV AL,[0xa26f]
1000:6270      e8 4b fc                 CALL 0x1000:5ebe
1000:6273      72 41                    JC 0x1000:62b6
1000:6275      e8 65 00                 CALL 0x1000:62dd
1000:6278      c7 06 09 a2 78 62        MOV word ptr [0xa209],0x6278
1000:627e      a0 71 a4                 MOV AL,[0xa471]
1000:6281      e8 3a fc                 CALL 0x1000:5ebe
1000:6284      72 30                    JC 0x1000:62b6
1000:6286      c7 06 09 a2 86 62        MOV word ptr [0xa209],0x6286
1000:628c      a0 72 a4                 MOV AL,[0xa472]
1000:628f      e8 2c fc                 CALL 0x1000:5ebe
1000:6292      72 22                    JC 0x1000:62b6
1000:6294      80 3e 73 a4 00           CMP byte ptr [0xa473],0x0
1000:6299      74 03                    JZ 0x1000:629e
1000:629b      e9 b3 fe                 JMP 0x1000:6151
1000:629e  LAB_1000_629e:
1000:629e      80 06 70 a4 01           ADD byte ptr [0xa470],0x1
1000:62a3      be 78 a4                 MOV SI,0xa478
1000:62a6      bf 7c a4                 MOV DI,0xa47c
1000:62a9      b9 04 00                 MOV CX,0x4
1000:62ac      f3 a4                    MOVSB.REP ES:DI,SI
1000:62ae      c6 06 0c a2 01           MOV byte ptr [0xa20c],0x1
1000:62b3      e9 9b fe                 JMP 0x1000:6151
1000:62b6  LAB_1000_62b6:
1000:62b6      c3                       RET
1000:62b7  LAB_1000_62b7:
1000:62b7      c7 06 09 a2 b7 62        MOV word ptr [0xa209],0x62b7
1000:62bd      e8 0f 00                 CALL 0x1000:62cf
1000:62c0      e8 cf fb                 CALL 0x1000:5e92
1000:62c3      73 f2                    JNC 0x1000:62b7
1000:62c5      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
1000:62ca      75 ea                    JNZ 0x1000:62b6
1000:62cc      e9 82 fe                 JMP 0x1000:6151

; ------------------------------------------------------------
1000:62cf  FUN_1000_62cf:
1000:62cf      83 3e 5e a2 00           CMP word ptr [0xa25e],0x0
1000:62d4      75 06                    JNZ 0x1000:62dc
1000:62d6      c7 06 5e a2 01 00        MOV word ptr [0xa25e],0x1
1000:62dc  LAB_1000_62dc:
1000:62dc      c3                       RET

; ------------------------------------------------------------
1000:62dd  FUN_1000_62dd:
1000:62dd      8b 1e 71 a4              MOV BX,word ptr [0xa471]
1000:62e1      e8 05 00                 CALL 0x1000:62e9
1000:62e4      89 1e 71 a4              MOV word ptr [0xa471],BX
1000:62e8      c3                       RET

; ------------------------------------------------------------
1000:62e9  FUN_1000_62e9:
1000:62e9      52                       PUSH DX
1000:62ea      33 d2                    XOR DX,DX
1000:62ec      32 c7                    XOR AL,BH
1000:62ee      7a 03                    JP 0x1000:62f3
1000:62f0      b2 02                    MOV DL,0x2
1000:62f2      f9                       STC
1000:62f3  LAB_1000_62f3:
1000:62f3      d0 d8                    RCR AL,0x1
1000:62f5      8a f0                    MOV DH,AL
1000:62f7      d0 da                    RCR DL,0x1
1000:62f9      8a e2                    MOV AH,DL
1000:62fb      d0 d8                    RCR AL,0x1
1000:62fd      d0 da                    RCR DL,0x1
1000:62ff      32 c6                    XOR AL,DH
1000:6301      8a f0                    MOV DH,AL
1000:6303      8a c2                    MOV AL,DL
1000:6305      32 c4                    XOR AL,AH
1000:6307      32 c3                    XOR AL,BL
1000:6309      8a f8                    MOV BH,AL
1000:630b      8a de                    MOV BL,DH
1000:630d      5a                       POP DX
1000:630e      c3                       RET

; ------------------------------------------------------------
1000:6310  FUN_1000_6310:
1000:6310      bf 12 a2                 MOV DI,0xa212
1000:6313      be 26 a2                 MOV SI,0xa226
1000:6316      bb 00 00                 MOV BX,0x0
1000:6319  LAB_1000_6319:
1000:6319      80 3c 6d                 CMP byte ptr [SI],0x6d
1000:631c      75 1f                    JNZ 0x1000:633d
1000:631e      80 bf e0 89 00           CMP byte ptr [BX + 0x89e0],0x0
1000:6323      75 18                    JNZ 0x1000:633d
1000:6325      53                       PUSH BX
1000:6326      56                       PUSH SI
1000:6327      57                       PUSH DI
1000:6328      e8 20 00                 CALL 0x1000:634b
1000:632b      5f                       POP DI
1000:632c      5e                       POP SI
1000:632d      5b                       POP BX
1000:632e      aa                       STOSB ES:DI
1000:632f      b0 00                    MOV AL,0x0
1000:6331      aa                       STOSB ES:DI
1000:6332      b0 00                    MOV AL,0x0
1000:6334      aa                       STOSB ES:DI
1000:6335      b0 00                    MOV AL,0x0
1000:6337      aa                       STOSB ES:DI
1000:6338      b0 01                    MOV AL,0x1
1000:633a      aa                       STOSB ES:DI
1000:633b      eb 03                    JMP 0x1000:6340
1000:633d  LAB_1000_633d:
1000:633d      83 c7 05                 ADD DI,0x5
1000:6340  LAB_1000_6340:
1000:6340      83 c6 0b                 ADD SI,0xb
1000:6343      fe c3                    INC BL
1000:6345      80 fb 04                 CMP BL,0x4
1000:6348      72 cf                    JC 0x1000:6319
1000:634a      c3                       RET

; ------------------------------------------------------------
1000:634b  FUN_1000_634b:
1000:634b      88 1e 74 a2              MOV byte ptr [0xa274],BL
1000:634f      e8 7c bb                 CALL 0x1000:1ece
                ; ptr table -> 1000:635a  [ptr] 1000:a268 1000:a269 1000:a26a 1000:a26b
1000:635a  LAB_1000_635a:
1000:635a      8a 07                    MOV AL,byte ptr [BX]
1000:635c      22 c0                    AND AL,AL
1000:635e      74 05                    JZ 0x1000:6365
1000:6360      fe 0f                    DEC byte ptr [BX]
1000:6362      32 c0                    XOR AL,AL
1000:6364      c3                       RET
1000:6365  LAB_1000_6365:
1000:6365      a0 0f 00                 MOV AL,[0xf]
1000:6368      b4 14                    MOV AH,0x14
1000:636a      22 c0                    AND AL,AL
1000:636c      74 0e                    JZ 0x1000:637c
1000:636e      b4 0d                    MOV AH,0xd
1000:6370      fe c8                    DEC AL
1000:6372      74 08                    JZ 0x1000:637c
1000:6374      fe c8                    DEC AL
1000:6376      b4 06                    MOV AH,0x6
1000:6378      74 02                    JZ 0x1000:637c
1000:637a      b4 00                    MOV AH,0x0
1000:637c  LAB_1000_637c:
1000:637c      88 27                    MOV byte ptr [BX],AH
1000:637e      e8 6b 00                 CALL 0x1000:63ec
1000:6381      75 03                    JNZ 0x1000:6386
1000:6383      b0 85                    MOV AL,0x85
1000:6385      c3                       RET
1000:6386  LAB_1000_6386:
1000:6386      e8 45 bb                 CALL 0x1000:1ece
                ; ptr table -> 1000:6391  [ptr] 1000:a275 1000:a276 1000:a277 1000:a278
1000:6391  LAB_1000_6391:
1000:6391      8a 07                    MOV AL,byte ptr [BX]
1000:6393      22 c0                    AND AL,AL
1000:6395      74 04                    JZ 0x1000:639b
1000:6397      c6 07 00                 MOV byte ptr [BX],0x0
1000:639a      c3                       RET
1000:639b  LAB_1000_639b:
1000:639b      e8 30 bb                 CALL 0x1000:1ece
                ; ptr table -> 1000:63a6  [ptr] 1000:89d4 1000:89d5 1000:89d6 1000:89d7
1000:63a6  LAB_1000_63a6:
1000:63a6      8a 07                    MOV AL,byte ptr [BX]
1000:63a8      b9 04 00                 MOV CX,0x4
1000:63ab  LAB_1000_63ab:
1000:63ab      51                       PUSH CX
1000:63ac      fe c0                    INC AL
1000:63ae      24 03                    AND AL,0x3
1000:63b0      50                       PUSH AX
1000:63b1      e8 58 c6                 CALL 0x1000:2a0c
1000:63b4      74 05                    JZ 0x1000:63bb
1000:63b6      e8 81 03                 CALL 0x1000:673a
1000:63b9      72 07                    JC 0x1000:63c2
1000:63bb  LAB_1000_63bb:
1000:63bb      58                       POP AX
1000:63bc      59                       POP CX
1000:63bd      e2 ec                    LOOP 0x1000:63ab
1000:63bf      32 c0                    XOR AL,AL
1000:63c1      c3                       RET
1000:63c2  LAB_1000_63c2:
1000:63c2      58                       POP AX
1000:63c3      59                       POP CX
1000:63c4      53                       PUSH BX
1000:63c5      e8 06 bb                 CALL 0x1000:1ece
                ; ptr table -> 1000:63d0  [ptr] 1000:89d4 1000:89d5 1000:89d6 1000:89d7
1000:63d0  LAB_1000_63d0:
1000:63d0      80 27 ec                 AND byte ptr [BX],0xec
1000:63d3      08 07                    OR byte ptr [BX],AL
1000:63d5      5b                       POP BX
1000:63d6      8a e0                    MOV AH,AL
1000:63d8      8a c3                    MOV AL,BL
1000:63da      50                       PUSH AX
1000:63db      53                       PUSH BX
1000:63dc      e8 ef ba                 CALL 0x1000:1ece
                ; ptr table -> 1000:63e7  [ptr] 1000:a275 1000:a276 1000:a277 1000:a278
1000:63e7  LAB_1000_63e7:
1000:63e7      58                       POP AX
1000:63e8      88 27                    MOV byte ptr [BX],AH
1000:63ea      58                       POP AX
1000:63eb      c3                       RET

; ------------------------------------------------------------
1000:63ec  FUN_1000_63ec:
1000:63ec      80 3e d2 89 0a           CMP byte ptr [0x89d2],0xa
1000:63f1      73 01                    JNC 0x1000:63f4
1000:63f3      c3                       RET
1000:63f4  LAB_1000_63f4:
1000:63f4      c6 06 90 a4 00           MOV byte ptr [0xa490],0x0
1000:63f9      e8 d2 ba                 CALL 0x1000:1ece
                ; ptr table -> 1000:6404  [ptr] 1000:8c64 1000:8d50 1000:8e3c 1000:8f28
1000:6404  LAB_1000_6404:
1000:6404      8b f3                    MOV SI,BX
1000:6406      b1 00                    MOV CL,0x0
1000:6408  LAB_1000_6408:
1000:6408      f6 04 80                 TEST byte ptr [SI],0x80
1000:640b      74 38                    JZ 0x1000:6445
1000:640d      fe 06 90 a4              INC byte ptr [0xa490]
1000:6411      56                       PUSH SI
1000:6412      51                       PUSH CX
1000:6413      83 7c 24 00              CMP word ptr [SI + 0x24],0x0
1000:6417      75 24                    JNZ 0x1000:643d
1000:6419      c6 44 11 00              MOV byte ptr [SI + 0x11],0x0
1000:641d      e8 5a df                 CALL 0x1000:437a
1000:6420      88 44 0a                 MOV byte ptr [SI + 0xa],AL
1000:6423      b8 0c 00                 MOV AX,0xc
1000:6426      f6 e1                    MUL CL
1000:6428      88 44 23                 MOV byte ptr [SI + 0x23],AL
1000:642b      b8 20 03                 MOV AX,0x320
1000:642e      33 d2                    XOR DX,DX
1000:6430      f7 e1                    MUL CX
1000:6432      05 b8 0b                 ADD AX,0xbb8
1000:6435      89 44 26                 MOV word ptr [SI + 0x26],AX
1000:6438      c7 44 24 55 64           MOV word ptr [SI + 0x24],0x6455
1000:643d  LAB_1000_643d:
1000:643d      ff 54 24                 CALL word ptr [SI + 0x24]
1000:6440      e8 de 02                 CALL 0x1000:6721
1000:6443      59                       POP CX
1000:6444      5e                       POP SI
1000:6445  LAB_1000_6445:
1000:6445      83 c6 3b                 ADD SI,0x3b
1000:6448      fe c1                    INC CL
1000:644a      80 f9 04                 CMP CL,0x4
1000:644d      75 b9                    JNZ 0x1000:6408
1000:644f      f6 06 90 a4 ff           TEST byte ptr [0xa490],0xff
1000:6454      c3                       RET

; ------------------------------------------------------------
1000:6455  FUN_1000_6455:
1000:6455      e8 76 ba                 CALL 0x1000:1ece
                ; ptr table -> 1000:6460  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
1000:6460  LAB_1000_6460:
1000:6460      83 7f 08 00              CMP word ptr [BX + 0x8],0x0
1000:6464      74 25                    JZ 0x1000:648b
1000:6466      c6 44 11 00              MOV byte ptr [SI + 0x11],0x0
1000:646a      8b 44 08                 MOV AX,word ptr [SI + 0x8]
1000:646d      3b 44 26                 CMP AX,word ptr [SI + 0x26]
1000:6470      72 18                    JC 0x1000:648a
1000:6472      e8 8c 03                 CALL 0x1000:6801
1000:6475      3a 44 23                 CMP AL,byte ptr [SI + 0x23]
1000:6478      73 11                    JNC 0x1000:648b
1000:647a      80 7c 23 00              CMP byte ptr [SI + 0x23],0x0
1000:647e      74 0a                    JZ 0x1000:648a
1000:6480      f6 06 d2 89 03           TEST byte ptr [0x89d2],0x3
1000:6485      75 03                    JNZ 0x1000:648a
1000:6487      fe 4c 23                 DEC byte ptr [SI + 0x23]
1000:648a  LAB_1000_648a:
1000:648a      c3                       RET
1000:648b  LAB_1000_648b:
1000:648b      c7 44 24 9a 64           MOV word ptr [SI + 0x24],0x649a
1000:6490      e8 e7 de                 CALL 0x1000:437a
1000:6493      24 0f                    AND AL,0xf
1000:6495      04 07                    ADD AL,0x7
1000:6497      e9 d2 01                 JMP 0x1000:666c
1000:649a      80 7c 14 00              CMP byte ptr [SI + 0x14],0x0
1000:649e      74 0b                    JZ 0x1000:64ab
1000:64a0      f6 06 12 00 01           TEST byte ptr [0x12],0x1
1000:64a5      74 09                    JZ 0x1000:64b0
1000:64a7      fe 4c 14                 DEC byte ptr [SI + 0x14]
1000:64aa      c3                       RET
1000:64ab  LAB_1000_64ab:
1000:64ab      c7 44 24 b1 64           MOV word ptr [SI + 0x24],0x64b1
1000:64b0  LAB_1000_64b0:
1000:64b0      c3                       RET
1000:64b1      f6 04 44                 TEST byte ptr [SI],0x44
1000:64b4      74 0f                    JZ 0x1000:64c5
1000:64b6      81 7c 08 a0 0f           CMP word ptr [SI + 0x8],0xfa0
1000:64bb      72 07                    JC 0x1000:64c4
1000:64bd      81 7c 08 80 3e           CMP word ptr [SI + 0x8],0x3e80
1000:64c2      72 01                    JC 0x1000:64c5
1000:64c4  LAB_1000_64c4:
1000:64c4      c3                       RET
1000:64c5  LAB_1000_64c5:
1000:64c5      81 7c 08 a8 61           CMP word ptr [SI + 0x8],0x61a8
1000:64ca      72 19                    JC 0x1000:64e5
1000:64cc      80 7c 07 08              CMP byte ptr [SI + 0x7],0x8
1000:64d0      72 13                    JC 0x1000:64e5
1000:64d2      80 7c 2a 06              CMP byte ptr [SI + 0x2a],0x6
1000:64d6      72 0d                    JC 0x1000:64e5
1000:64d8      e8 26 03                 CALL 0x1000:6801
1000:64db      3c 14                    CMP AL,0x14
1000:64dd      72 06                    JC 0x1000:64e5
1000:64df      c7 44 24 7a 66           MOV word ptr [SI + 0x24],0x667a
1000:64e4      c3                       RET
1000:64e5  LAB_1000_64e5:
1000:64e5      f6 44 28 ff              TEST byte ptr [SI + 0x28],0xff
1000:64e9      75 03                    JNZ 0x1000:64ee
1000:64eb      e9 e7 00                 JMP 0x1000:65d5
1000:64ee  LAB_1000_64ee:
1000:64ee      f6 44 28 08              TEST byte ptr [SI + 0x28],0x8
1000:64f2      74 0b                    JZ 0x1000:64ff
1000:64f4      80 7c 2a 04              CMP byte ptr [SI + 0x2a],0x4
1000:64f8      77 05                    JA 0x1000:64ff
1000:64fa      b0 03                    MOV AL,0x3
1000:64fc      e9 fe 00                 JMP 0x1000:65fd
1000:64ff  LAB_1000_64ff:
1000:64ff      f6 44 28 20              TEST byte ptr [SI + 0x28],0x20
1000:6503      74 0c                    JZ 0x1000:6511
1000:6505      81 7c 08 ac 0d           CMP word ptr [SI + 0x8],0xdac
1000:650a      77 05                    JA 0x1000:6511
1000:650c      b0 0b                    MOV AL,0xb
1000:650e      e9 ec 00                 JMP 0x1000:65fd
1000:6511  LAB_1000_6511:
1000:6511      f6 44 28 02              TEST byte ptr [SI + 0x28],0x2
1000:6515      74 0b                    JZ 0x1000:6522
1000:6517      80 7c 07 05              CMP byte ptr [SI + 0x7],0x5
1000:651b      77 05                    JA 0x1000:6522
1000:651d      b0 09                    MOV AL,0x9
1000:651f      e9 db 00                 JMP 0x1000:65fd
1000:6522  LAB_1000_6522:
1000:6522      f6 44 28 01              TEST byte ptr [SI + 0x28],0x1
1000:6526      74 0c                    JZ 0x1000:6534
1000:6528      81 7c 08 f8 2a           CMP word ptr [SI + 0x8],0x2af8
1000:652d      77 05                    JA 0x1000:6534
1000:652f      b0 02                    MOV AL,0x2
1000:6531      e9 c9 00                 JMP 0x1000:65fd
1000:6534  LAB_1000_6534:
1000:6534      f6 44 28 04              TEST byte ptr [SI + 0x28],0x4
1000:6538      74 0b                    JZ 0x1000:6545
1000:653a      80 7c 0f 0a              CMP byte ptr [SI + 0xf],0xa
1000:653e      77 05                    JA 0x1000:6545
1000:6540      b0 05                    MOV AL,0x5
1000:6542      e9 b8 00                 JMP 0x1000:65fd
1000:6545  LAB_1000_6545:
1000:6545      f6 44 28 80              TEST byte ptr [SI + 0x28],0x80
1000:6549      74 24                    JZ 0x1000:656f
1000:654b      e8 80 b9                 CALL 0x1000:1ece
                ; ptr table -> 1000:6556  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
1000:6556  LAB_1000_6556:
1000:6556      83 7f 08 00              CMP word ptr [BX + 0x8],0x0
1000:655a      74 13                    JZ 0x1000:656f
1000:655c      81 7f 08 4c 1d           CMP word ptr [BX + 0x8],0x1d4c
1000:6561      77 0c                    JA 0x1000:656f
1000:6563      81 7c 08 20 4e           CMP word ptr [SI + 0x8],0x4e20
1000:6568      72 05                    JC 0x1000:656f
1000:656a      b0 04                    MOV AL,0x4
1000:656c      e9 8e 00                 JMP 0x1000:65fd
1000:656f  LAB_1000_656f:
1000:656f      f6 44 28 02              TEST byte ptr [SI + 0x28],0x2
1000:6573      74 0b                    JZ 0x1000:6580
1000:6575      80 7c 07 09              CMP byte ptr [SI + 0x7],0x9
1000:6579      73 05                    JNC 0x1000:6580
1000:657b      b0 09                    MOV AL,0x9
1000:657d      eb 7e                    JMP 0x1000:65fd
1000:6580  LAB_1000_6580:
1000:6580      f6 44 28 40              TEST byte ptr [SI + 0x28],0x40
1000:6584      74 0b                    JZ 0x1000:6591
1000:6586      f6 44 16 40              TEST byte ptr [SI + 0x16],0x40
1000:658a      74 05                    JZ 0x1000:6591
1000:658c      b0 0a                    MOV AL,0xa
1000:658e      eb 6d                    JMP 0x1000:65fd
1000:6591  LAB_1000_6591:
1000:6591      f6 44 28 80              TEST byte ptr [SI + 0x28],0x80
1000:6595      74 0c                    JZ 0x1000:65a3
1000:6597      81 7c 08 d0 07           CMP word ptr [SI + 0x8],0x7d0
1000:659c      77 05                    JA 0x1000:65a3
1000:659e      b0 04                    MOV AL,0x4
1000:65a0      eb 5b                    JMP 0x1000:65fd
1000:65a3  LAB_1000_65a3:
1000:65a3      f6 44 28 01              TEST byte ptr [SI + 0x28],0x1
1000:65a7      74 05                    JZ 0x1000:65ae
1000:65a9      b0 02                    MOV AL,0x2
1000:65ab      eb 50                    JMP 0x1000:65fd
1000:65ae  LAB_1000_65ae:
1000:65ae      f6 44 28 04              TEST byte ptr [SI + 0x28],0x4
1000:65b2      74 0b                    JZ 0x1000:65bf
1000:65b4      80 7c 0f 32              CMP byte ptr [SI + 0xf],0x32
1000:65b8      77 05                    JA 0x1000:65bf
1000:65ba      b0 05                    MOV AL,0x5
1000:65bc      eb 3f                    JMP 0x1000:65fd
1000:65bf  LAB_1000_65bf:
1000:65bf      f6 44 28 10              TEST byte ptr [SI + 0x28],0x10
1000:65c3      74 05                    JZ 0x1000:65ca
1000:65c5      b0 01                    MOV AL,0x1
1000:65c7      eb 34                    JMP 0x1000:65fd
1000:65ca  LAB_1000_65ca:
1000:65ca      f6 44 28 40              TEST byte ptr [SI + 0x28],0x40
1000:65ce      74 05                    JZ 0x1000:65d5
1000:65d0      b0 0a                    MOV AL,0xa
1000:65d2      eb 29                    JMP 0x1000:65fd
1000:65d5  LAB_1000_65d5:
1000:65d5      f6 44 16 40              TEST byte ptr [SI + 0x16],0x40
1000:65d9      74 0c                    JZ 0x1000:65e7
1000:65db      81 7c 08 40 1f           CMP word ptr [SI + 0x8],0x1f40
1000:65e0      77 23                    JA 0x1000:6605
1000:65e2      b0 08                    MOV AL,0x8
1000:65e4      eb 17                    JMP 0x1000:65fd
1000:65e7  LAB_1000_65e7:
1000:65e7      f6 06 12 00 01           TEST byte ptr [0x12],0x1
1000:65ec      b0 02                    MOV AL,0x2
1000:65ee      75 0d                    JNZ 0x1000:65fd
1000:65f0      e8 0e 02                 CALL 0x1000:6801
1000:65f3      3a 06 00 00              CMP AL,byte ptr [0x0]
1000:65f7      b0 02                    MOV AL,0x2
1000:65f9      74 02                    JZ 0x1000:65fd
1000:65fb      b0 01                    MOV AL,0x1
1000:65fd  LAB_1000_65fd:
1000:65fd      88 44 11                 MOV byte ptr [SI + 0x11],AL
1000:6600      c7 44 24 0a 66           MOV word ptr [SI + 0x24],0x660a
1000:6605  LAB_1000_6605:
1000:6605      b0 05                    MOV AL,0x5
1000:6607      eb 63                    JMP 0x1000:666c
1000:660a      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
1000:660d      a8 80                    TEST AL,0x80
1000:660f      75 48                    JNZ 0x1000:6659
1000:6611      24 1f                    AND AL,0x1f
1000:6613      3c 04                    CMP AL,0x4
1000:6615      74 4b                    JZ 0x1000:6662
1000:6617      3c 01                    CMP AL,0x1
1000:6619      75 09                    JNZ 0x1000:6624
1000:661b      f6 44 28 ef              TEST byte ptr [SI + 0x28],0xef
1000:661f      75 38                    JNZ 0x1000:6659
1000:6621      eb 10                    JMP 0x1000:6633
1000:6624  LAB_1000_6624:
1000:6624      3c 06                    CMP AL,0x6
1000:6626      74 1c                    JZ 0x1000:6644
1000:6628      3c 07                    CMP AL,0x7
1000:662a      74 18                    JZ 0x1000:6644
1000:662c      81 7c 12 94 11           CMP word ptr [SI + 0x12],0x1194
1000:6631      77 26                    JA 0x1000:6659
1000:6633  LAB_1000_6633:
1000:6633      24 1f                    AND AL,0x1f
1000:6635      74 22                    JZ 0x1000:6659
1000:6637      3c 08                    CMP AL,0x8
1000:6639      75 27                    JNZ 0x1000:6662
1000:663b      f6 44 16 42              TEST byte ptr [SI + 0x16],0x42
1000:663f      74 18                    JZ 0x1000:6659
1000:6641      eb 1f                    JMP 0x1000:6662
1000:6644  LAB_1000_6644:
1000:6644      81 7c 08 e0 2e           CMP word ptr [SI + 0x8],0x2ee0
1000:6649      72 0e                    JC 0x1000:6659
1000:664b      80 7c 07 01              CMP byte ptr [SI + 0x7],0x1
1000:664f      72 11                    JC 0x1000:6662
1000:6651      f6 44 16 63              TEST byte ptr [SI + 0x16],0x63
1000:6655      b0 05                    MOV AL,0x5
1000:6657      75 13                    JNZ 0x1000:666c
1000:6659  LAB_1000_6659:
1000:6659      c6 44 11 00              MOV byte ptr [SI + 0x11],0x0
1000:665d      c7 44 24 b1 64           MOV word ptr [SI + 0x24],0x64b1
1000:6662  LAB_1000_6662:
1000:6662      81 7c 08 28 23           CMP word ptr [SI + 0x8],0x2328
1000:6667      b0 0a                    MOV AL,0xa
1000:6669      77 01                    JA 0x1000:666c
1000:666b      c3                       RET

; ------------------------------------------------------------
1000:666c  FUN_1000_666c:
1000:666c      88 44 14                 MOV byte ptr [SI + 0x14],AL
1000:666f      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
1000:6672      24 0f                    AND AL,0xf
1000:6674      0c b0                    OR AL,0xb0
1000:6676      88 44 0b                 MOV byte ptr [SI + 0xb],AL
1000:6679      c3                       RET
1000:667a      81 7c 08 10 27           CMP word ptr [SI + 0x8],0x2710
1000:667f      72 0c                    JC 0x1000:668d
1000:6681      80 7c 07 02              CMP byte ptr [SI + 0x7],0x2
1000:6685      72 06                    JC 0x1000:668d
1000:6687      80 7c 2a 03              CMP byte ptr [SI + 0x2a],0x3
1000:668b      73 0a                    JNC 0x1000:6697
1000:668d  LAB_1000_668d:
1000:668d      c7 44 24 b1 64           MOV word ptr [SI + 0x24],0x64b1
1000:6692      c6 44 11 00              MOV byte ptr [SI + 0x11],0x0
1000:6696      c3                       RET
1000:6697  LAB_1000_6697:
1000:6697      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
1000:669a      24 1f                    AND AL,0x1f
1000:669c      75 60                    JNZ 0x1000:66fe
1000:669e      f7 44 08 01 00           TEST word ptr [SI + 0x8],0x1
1000:66a3      b0 06                    MOV AL,0x6
1000:66a5      75 02                    JNZ 0x1000:66a9
1000:66a7      b0 07                    MOV AL,0x7
1000:66a9  LAB_1000_66a9:
1000:66a9      80 3e 74 a2 01           CMP byte ptr [0xa274],0x1
1000:66ae      74 0b                    JZ 0x1000:66bb
1000:66b0      b0 06                    MOV AL,0x6
1000:66b2      80 3e 74 a2 02           CMP byte ptr [0xa274],0x2
1000:66b7      74 02                    JZ 0x1000:66bb
1000:66b9      b0 07                    MOV AL,0x7
1000:66bb  LAB_1000_66bb:
1000:66bb      f6 06 12 00 02           TEST byte ptr [0x12],0x2
1000:66c0      74 33                    JZ 0x1000:66f5
1000:66c2      8a 26 74 a2              MOV AH,byte ptr [0xa274]
1000:66c6      3a 64 05                 CMP AH,byte ptr [SI + 0x5]
1000:66c9      75 05                    JNZ 0x1000:66d0
1000:66cb      b0 0c                    MOV AL,0xc
1000:66cd      eb 26                    JMP 0x1000:66f5
1000:66d0  LAB_1000_66d0:
1000:66d0      50                       PUSH AX
1000:66d1      a0 74 a2                 MOV AL,[0xa274]
1000:66d4      50                       PUSH AX
1000:66d5      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
1000:66d8      a2 74 a2                 MOV [0xa274],AL
1000:66db      e8 f0 b7                 CALL 0x1000:1ece
                ; ptr table -> 1000:66e6  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
1000:66e6  LAB_1000_66e6:
1000:66e6      58                       POP AX
1000:66e7      a2 74 a2                 MOV [0xa274],AL
1000:66ea      58                       POP AX
1000:66eb      8a 64 18                 MOV AH,byte ptr [SI + 0x18]
1000:66ee      3a 67 0c                 CMP AH,byte ptr [BX + 0xc]
1000:66f1      75 02                    JNZ 0x1000:66f5
1000:66f3      b0 0c                    MOV AL,0xc
1000:66f5  LAB_1000_66f5:
1000:66f5      88 44 11                 MOV byte ptr [SI + 0x11],AL
1000:66f8  LAB_1000_66f8:
1000:66f8      b0 05                    MOV AL,0x5
1000:66fa      e8 6f ff                 CALL 0x1000:666c
1000:66fd      c3                       RET
1000:66fe  LAB_1000_66fe:
1000:66fe      f6 44 11 80              TEST byte ptr [SI + 0x11],0x80
1000:6702      75 f4                    JNZ 0x1000:66f8
1000:6704      81 7c 12 40 1f           CMP word ptr [SI + 0x12],0x1f40
1000:6709      72 ed                    JC 0x1000:66f8
1000:670b      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
1000:670e      24 1f                    AND AL,0x1f
1000:6710      3c 0c                    CMP AL,0xc
1000:6712      75 03                    JNZ 0x1000:6717
1000:6714      e9 76 ff                 JMP 0x1000:668d
1000:6717  LAB_1000_6717:
1000:6717      3c 06                    CMP AL,0x6
1000:6719      b0 06                    MOV AL,0x6
1000:671b      75 02                    JNZ 0x1000:671f
1000:671d      b0 07                    MOV AL,0x7
1000:671f  LAB_1000_671f:
1000:671f      eb d4                    JMP 0x1000:66f5

; ------------------------------------------------------------
1000:6721  FUN_1000_6721:
1000:6721      f6 44 16 04              TEST byte ptr [SI + 0x16],0x4
1000:6725      74 12                    JZ 0x1000:6739
1000:6727      80 7c 2a 03              CMP byte ptr [SI + 0x2a],0x3
1000:672b      77 0c                    JA 0x1000:6739
1000:672d      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
1000:6730      24 0f                    AND AL,0xf
1000:6732      3c 03                    CMP AL,0x3
1000:6734      76 03                    JBE 0x1000:6739
1000:6736      fe 4c 0b                 DEC byte ptr [SI + 0xb]
1000:6739  LAB_1000_6739:
1000:6739      c3                       RET

; ------------------------------------------------------------
1000:673a  FUN_1000_673a:
1000:673a      bb 00 00                 MOV BX,0x0
1000:673d      f6 44 16 42              TEST byte ptr [SI + 0x16],0x42
1000:6741      74 1b                    JZ 0x1000:675e
1000:6743      f6 44 16 40              TEST byte ptr [SI + 0x16],0x40
1000:6747      74 0b                    JZ 0x1000:6754
1000:6749      81 7c 08 f4 01           CMP word ptr [SI + 0x8],0x1f4
1000:674e      77 04                    JA 0x1000:6754
1000:6750      b3 5a                    MOV BL,0x5a
1000:6752      f9                       STC
1000:6753      c3                       RET
1000:6754  LAB_1000_6754:
1000:6754      81 7c 08 58 1b           CMP word ptr [SI + 0x8],0x1b58
1000:6759      77 03                    JA 0x1000:675e
1000:675b      eb 2b                    JMP 0x1000:6788
1000:675e  LAB_1000_675e:
1000:675e      80 7c 07 00              CMP byte ptr [SI + 0x7],0x0
1000:6762      74 2a                    JZ 0x1000:678e
1000:6764      f6 44 19 ff              TEST byte ptr [SI + 0x19],0xff
1000:6768      75 1e                    JNZ 0x1000:6788
1000:676a      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
1000:676d      24 1f                    AND AL,0x1f
1000:676f      3c 06                    CMP AL,0x6
1000:6771      75 07                    JNZ 0x1000:677a
1000:6773      81 7c 12 a0 0f           CMP word ptr [SI + 0x12],0xfa0
1000:6778      72 06                    JC 0x1000:6780
1000:677a  LAB_1000_677a:
1000:677a      f6 44 16 63              TEST byte ptr [SI + 0x16],0x63
1000:677e      74 0e                    JZ 0x1000:678e
1000:6780  LAB_1000_6780:
1000:6780      f6 44 15 ff              TEST byte ptr [SI + 0x15],0xff
1000:6784      75 02                    JNZ 0x1000:6788
1000:6786      b3 20                    MOV BL,0x20
1000:6788  LAB_1000_6788:
1000:6788      e8 62 00                 CALL 0x1000:67ed
1000:678b      eb 1b                    JMP 0x1000:67a8
1000:678e  LAB_1000_678e:
1000:678e      f6 44 19 ff              TEST byte ptr [SI + 0x19],0xff
1000:6792      75 f4                    JNZ 0x1000:6788
1000:6794      f6 44 16 50              TEST byte ptr [SI + 0x16],0x50
1000:6798      74 0b                    JZ 0x1000:67a5
1000:679a      f6 44 15 ff              TEST byte ptr [SI + 0x15],0xff
1000:679e      75 e8                    JNZ 0x1000:6788
1000:67a0      b3 50                    MOV BL,0x50
1000:67a2      eb 04                    JMP 0x1000:67a8
1000:67a5  LAB_1000_67a5:
1000:67a5      80 24 cf                 AND byte ptr [SI],0xcf
1000:67a8  LAB_1000_67a8:
1000:67a8      ba 50 00                 MOV DX,0x50
1000:67ab      b4 03                    MOV AH,0x3
1000:67ad      80 4c 29 02              OR byte ptr [SI + 0x29],0x2
1000:67b1      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
1000:67b4      3c 02                    CMP AL,0x2
1000:67b6      74 1d                    JZ 0x1000:67d5
1000:67b8      3c 03                    CMP AL,0x3
1000:67ba      74 19                    JZ 0x1000:67d5
1000:67bc      3c 0a                    CMP AL,0xa
1000:67be      74 15                    JZ 0x1000:67d5
1000:67c0      3c 0b                    CMP AL,0xb
1000:67c2      74 11                    JZ 0x1000:67d5
1000:67c4      80 64 29 fd              AND byte ptr [SI + 0x29],0xfd
1000:67c8      3c 09                    CMP AL,0x9
1000:67ca      74 09                    JZ 0x1000:67d5
1000:67cc      3c 06                    CMP AL,0x6
1000:67ce      75 17                    JNZ 0x1000:67e7
1000:67d0      ba fa 00                 MOV DX,0xfa
1000:67d3      b4 0f                    MOV AH,0xf
1000:67d5  LAB_1000_67d5:
1000:67d5      84 26 d2 89              TEST byte ptr [0x89d2],AH
1000:67d9      75 0c                    JNZ 0x1000:67e7
1000:67db      39 54 12                 CMP word ptr [SI + 0x12],DX
1000:67de      77 07                    JA 0x1000:67e7
1000:67e0      80 fb 00                 CMP BL,0x0
1000:67e3      75 02                    JNZ 0x1000:67e7
1000:67e5      b3 4d                    MOV BL,0x4d
1000:67e7  LAB_1000_67e7:
1000:67e7      23 db                    AND BX,BX
1000:67e9      74 01                    JZ 0x1000:67ec
1000:67eb      f9                       STC
1000:67ec  LAB_1000_67ec:
1000:67ec      c3                       RET

; ------------------------------------------------------------
1000:67ed  FUN_1000_67ed:
1000:67ed      80 7c 0f 01              CMP byte ptr [SI + 0xf],0x1
1000:67f1      72 03                    JC 0x1000:67f6
1000:67f3      80 0c 10                 OR byte ptr [SI],0x10
1000:67f6  LAB_1000_67f6:
1000:67f6      81 7d 08 30 75           CMP word ptr [DI + 0x8],0x7530
1000:67fb      77 03                    JA 0x1000:6800
1000:67fd      80 0c 20                 OR byte ptr [SI],0x20
1000:6800  LAB_1000_6800:
1000:6800      c3                       RET

; ------------------------------------------------------------
1000:6801  FUN_1000_6801:
1000:6801      e8 21 ca                 CALL 0x1000:3225
1000:6804      51                       PUSH CX
1000:6805      b4 80                    MOV AH,0x80
1000:6807      8a 0e 74 a2              MOV CL,byte ptr [0xa274]
1000:680b      d2 ec                    SHR AH,CL
1000:680d      59                       POP CX
1000:680e      32 c0                    XOR AL,AL
1000:6810  LAB_1000_6810:
1000:6810      84 25                    TEST byte ptr [DI],AH
1000:6812      74 02                    JZ 0x1000:6816
1000:6814      fe c0                    INC AL
1000:6816  LAB_1000_6816:
1000:6816      83 c7 0b                 ADD DI,0xb
1000:6819      e2 f5                    LOOP 0x1000:6810
1000:681b      c3                       RET
1000:6820  int1c_timer:
1000:6820      fc                       CLD
1000:6821      50                       PUSH AX
1000:6822      53                       PUSH BX
1000:6823      51                       PUSH CX
1000:6824      52                       PUSH DX
1000:6825      56                       PUSH SI
1000:6826      57                       PUSH DI
1000:6827      55                       PUSH BP
1000:6828      1e                       PUSH DS
1000:6829      06                       PUSH ES
1000:682a      2e a1 00 00              MOV AX,CS:[0x0]
1000:682e      8e d8                    MOV DS,AX
1000:6830      8e c0                    MOV ES,AX
1000:6832      cc                       INT3
1000:6833      cd 01                    INT 0x1
1000:6835      e8 56 00                 CALL 0x1000:688e
1000:6838      e8 0e de                 CALL 0x1000:4649
1000:683b      e8 c5 00                 CALL 0x1000:6903
1000:683e      e8 2c 00                 CALL 0x1000:686d
1000:6841      07                       POP ES
1000:6842      1f                       POP DS
1000:6843      5d                       POP BP
1000:6844      5f                       POP DI
1000:6845      5e                       POP SI
1000:6846      5a                       POP DX
1000:6847      59                       POP CX
1000:6848      5b                       POP BX
1000:6849      58                       POP AX
1000:684a      cf                       IRET
1000:684b  int03_break:
1000:684b      83 3e 55 a2 00           CMP word ptr [0xa255],0x0
1000:6850      74 04                    JZ 0x1000:6856
1000:6852      ff 0e 55 a2              DEC word ptr [0xa255]
1000:6856  LAB_1000_6856:
1000:6856      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
1000:685b      74 04                    JZ 0x1000:6861
1000:685d      fe 0e 54 a2              DEC byte ptr [0xa254]
1000:6861  LAB_1000_6861:
1000:6861      83 3e 57 a2 00           CMP word ptr [0xa257],0x0
1000:6866      74 04                    JZ 0x1000:686c
1000:6868      ff 0e 57 a2              DEC word ptr [0xa257]
1000:686c  LAB_1000_686c:
1000:686c      cf                       IRET

; ------------------------------------------------------------
1000:686d  FUN_1000_686d:
1000:686d      06                       PUSH ES
1000:686e      bb 00 00                 MOV BX,0x0
1000:6871      8e c3                    MOV ES,BX
1000:6873      26 a0 17 04              MOV AL,ES:[0x417]
1000:6877      07                       POP ES
1000:6878      24 08                    AND AL,0x8
1000:687a      74 0c                    JZ 0x1000:6888
1000:687c      80 3e 66 a2 00           CMP byte ptr [0xa266],0x0
1000:6881      74 04                    JZ 0x1000:6887
1000:6883      fe 0e 66 a2              DEC byte ptr [0xa266]
1000:6887  LAB_1000_6887:
1000:6887      c3                       RET
1000:6888  LAB_1000_6888:
1000:6888      c6 06 66 a2 0c           MOV byte ptr [0xa266],0xc
1000:688d      c3                       RET

; ------------------------------------------------------------
1000:688e  FUN_1000_688e:
1000:688e      83 3e 5a a2 00           CMP word ptr [0xa25a],0x0
1000:6893      74 0a                    JZ 0x1000:689f
1000:6895      b8 00 03                 MOV AX,0x300
1000:6898      ff 0e 5a a2              DEC word ptr [0xa25a]
1000:689c      eb 49                    JMP 0x1000:68e7
1000:689f  LAB_1000_689f:
1000:689f      83 3e 62 a2 00           CMP word ptr [0xa262],0x0
1000:68a4      74 1c                    JZ 0x1000:68c2
1000:68a6      8b 1e 62 a2              MOV BX,word ptr [0xa262]
1000:68aa      8b 07                    MOV AX,word ptr [BX]
1000:68ac      83 06 62 a2 02           ADD word ptr [0xa262],0x2
1000:68b1      3d ff ff                 CMP AX,0xffff
1000:68b4      75 09                    JNZ 0x1000:68bf
1000:68b6      c7 06 62 a2 00 00        MOV word ptr [0xa262],0x0
1000:68bc      eb 3e                    JMP 0x1000:68fc
1000:68bf  LAB_1000_68bf:
1000:68bf      eb 26                    JMP 0x1000:68e7
1000:68c2  LAB_1000_68c2:
1000:68c2      83 3e 5c a2 00           CMP word ptr [0xa25c],0x0
1000:68c7      74 0a                    JZ 0x1000:68d3
1000:68c9      ff 0e 5c a2              DEC word ptr [0xa25c]
1000:68cd      b8 00 06                 MOV AX,0x600
1000:68d0      eb 15                    JMP 0x1000:68e7
1000:68d3  LAB_1000_68d3:
1000:68d3      83 3e 5e a2 00           CMP word ptr [0xa25e],0x0
1000:68d8      74 0a                    JZ 0x1000:68e4
1000:68da      ff 0e 5e a2              DEC word ptr [0xa25e]
1000:68de      b8 00 60                 MOV AX,0x6000
1000:68e1      eb 04                    JMP 0x1000:68e7
1000:68e4  LAB_1000_68e4:
1000:68e4      eb 16                    JMP 0x1000:68fc
1000:68e7  LAB_1000_68e7:
1000:68e7      e6 42                    OUT 0x42,AL
1000:68e9      8a c4                    MOV AL,AH
1000:68eb      eb 00                    JMP 0x1000:68ed
1000:68ed  LAB_1000_68ed:
1000:68ed      e6 42                    OUT 0x42,AL
1000:68ef      eb 00                    JMP 0x1000:68f1
1000:68f1  LAB_1000_68f1:
1000:68f1      e4 61                    IN AL,0x61
1000:68f3      24 fc                    AND AL,0xfc
1000:68f5      0a 06 14 00              OR AL,byte ptr [0x14]
1000:68f9      e6 61                    OUT 0x61,AL
1000:68fb      c3                       RET
1000:68fc  LAB_1000_68fc:
1000:68fc      e4 61                    IN AL,0x61
1000:68fe      24 fc                    AND AL,0xfc
1000:6900      e6 61                    OUT 0x61,AL
1000:6902      c3                       RET

; ------------------------------------------------------------
1000:6903  FUN_1000_6903:
1000:6903      f6 06 6c a2 80           TEST byte ptr [0xa26c],0x80
1000:6908      75 6d                    JNZ 0x1000:6977
1000:690a      80 3e 03 a2 01           CMP byte ptr [0xa203],0x1
1000:690f      75 66                    JNZ 0x1000:6977
1000:6911      fe 0e 04 a2              DEC byte ptr [0xa204]
1000:6915      75 60                    JNZ 0x1000:6977
1000:6917      c6 06 04 a2 12           MOV byte ptr [0xa204],0x12
1000:691c      fe 0e 05 a2              DEC byte ptr [0xa205]
1000:6920      75 09                    JNZ 0x1000:692b
1000:6922      fe 06 04 a2              INC byte ptr [0xa204]
1000:6926      c6 06 05 a2 05           MOV byte ptr [0xa205],0x5
1000:692b  LAB_1000_692b:
1000:692b      f6 06 12 00 01           TEST byte ptr [0x12],0x1
1000:6930      74 21                    JZ 0x1000:6953
1000:6932      fe 0e 06 a2              DEC byte ptr [0xa206]
1000:6936      79 3f                    JNS 0x1000:6977
1000:6938      c6 06 06 a2 3b           MOV byte ptr [0xa206],0x3b
1000:693d      fe 0e 07 a2              DEC byte ptr [0xa207]
1000:6941      79 34                    JNS 0x1000:6977
1000:6943      c6 06 07 a2 00           MOV byte ptr [0xa207],0x0
1000:6948      c6 06 06 a2 00           MOV byte ptr [0xa206],0x0
1000:694d      c6 06 03 a2 00           MOV byte ptr [0xa203],0x0
1000:6952      c3                       RET
1000:6953  LAB_1000_6953:
1000:6953      fe 06 06 a2              INC byte ptr [0xa206]
1000:6957      80 3e 06 a2 3c           CMP byte ptr [0xa206],0x3c
1000:695c      72 19                    JC 0x1000:6977
1000:695e      c6 06 06 a2 00           MOV byte ptr [0xa206],0x0
1000:6963      fe 06 07 a2              INC byte ptr [0xa207]
1000:6967      80 3e 07 a2 3c           CMP byte ptr [0xa207],0x3c
1000:696c      72 09                    JC 0x1000:6977
1000:696e      c6 06 07 a2 00           MOV byte ptr [0xa207],0x0
1000:6973      fe 06 08 a2              INC byte ptr [0xa208]
1000:6977  LAB_1000_6977:
1000:6977      c3                       RET

; ------------------------------------------------------------
1000:6980  FUN_1000_6980:
1000:6980      c6 06 73 a2 00           MOV byte ptr [0xa273],0x0
1000:6985      f6 06 a9 a4 01           TEST byte ptr [0xa4a9],0x1
1000:698a      74 01                    JZ 0x1000:698d
1000:698c      c3                       RET
1000:698d  LAB_1000_698d:
1000:698d      b8 00 00                 MOV AX,0x0
1000:6990      8e c0                    MOV ES,AX
1000:6992      26 c7 06 90 00 0c 6a     MOV word ptr ES:[0x90],0x6a0c
1000:6999      26 8c 0e 92 00           MOV word ptr ES:[0x92],CS
1000:699e      8c d8                    MOV AX,DS
1000:69a0      8e c0                    MOV ES,AX
1000:69a2      ba a0 39                 MOV DX,0x39a0
1000:69a5      b8 02 3d                 MOV AX,0x3d02
1000:69a8      cd 21                    INT 0x21
1000:69aa      73 21                    JNC 0x1000:69cd
1000:69ac      ba a0 39                 MOV DX,0x39a0
1000:69af      b8 00 3c                 MOV AX,0x3c00
1000:69b2      b9 00 00                 MOV CX,0x0
1000:69b5      cd 21                    INT 0x21
1000:69b7      72 33                    JC 0x1000:69ec
1000:69b9      a3 ab a4                 MOV [0xa4ab],AX
1000:69bc      e8 8d 03                 CALL 0x1000:6d4c
1000:69bf      bf ad a4                 MOV DI,0xa4ad
1000:69c2      b9 00 02                 MOV CX,0x200
1000:69c5      b8 00 00                 MOV AX,0x0
1000:69c8      f3 aa                    STOSB.REP ES:DI
1000:69ca      e9 bf 02                 JMP 0x1000:6c8c
1000:69cd  LAB_1000_69cd:
1000:69cd      a3 ab a4                 MOV [0xa4ab],AX
1000:69d0      8b 1e ab a4              MOV BX,word ptr [0xa4ab]
1000:69d4      ba ad a4                 MOV DX,0xa4ad
1000:69d7      b9 00 02                 MOV CX,0x200
1000:69da      b4 3f                    MOV AH,0x3f
1000:69dc      cd 21                    INT 0x21
1000:69de      72 0c                    JC 0x1000:69ec
1000:69e0      80 3e 73 a2 00           CMP byte ptr [0xa273],0x0
1000:69e5      75 05                    JNZ 0x1000:69ec
1000:69e7      3d 00 02                 CMP AX,0x200
1000:69ea      74 06                    JZ 0x1000:69f2
1000:69ec  LAB_1000_69ec:
1000:69ec      c6 06 73 a2 01           MOV byte ptr [0xa273],0x1
1000:69f1      c3                       RET
1000:69f2  LAB_1000_69f2:
1000:69f2      80 0e a9 a4 01           OR byte ptr [0xa4a9],0x1
1000:69f7      bf ad a4                 MOV DI,0xa4ad
1000:69fa      8b 05                    MOV AX,word ptr [DI]
1000:69fc      3d 00 00                 CMP AX,0x0
1000:69ff      74 05                    JZ 0x1000:6a06
1000:6a01      c6 06 72 a2 01           MOV byte ptr [0xa272],0x1
1000:6a06  LAB_1000_6a06:
1000:6a06      e8 43 03                 CALL 0x1000:6d4c
1000:6a09      e9 91 02                 JMP 0x1000:6c9d
1000:6a0c  int24_criterr:
1000:6a0c      fb                       STI
1000:6a0d      1e                       PUSH DS
1000:6a0e      06                       PUSH ES
1000:6a0f      53                       PUSH BX
1000:6a10      51                       PUSH CX
1000:6a11      52                       PUSH DX
1000:6a12      2e a1 00 00              MOV AX,CS:[0x0]
1000:6a16      8e d8                    MOV DS,AX
1000:6a18      8e c0                    MOV ES,AX
1000:6a1a      57                       PUSH DI
1000:6a1b      e8 dd ed                 CALL 0x1000:57fb
                ; inline script -> 1000:6a27  <c2><clear>    
1000:6a27  LAB_1000_6a27:
1000:6a27      58                       POP AX
1000:6a28      3c 00                    CMP AL,0x0
1000:6a2a      75 1e                    JNZ 0x1000:6a4a
1000:6a2c      e8 cc ed                 CALL 0x1000:57fb
                ; inline script -> 1000:6a47  <c2>WRITE PROTECTED DISK
1000:6a47  LAB_1000_6a47:
1000:6a47      eb 16                    JMP 0x1000:6a5f
1000:6a4a  LAB_1000_6a4a:
1000:6a4a      e8 ae ed                 CALL 0x1000:57fb
                ; inline script -> 1000:6a5f  <c2>DISK NOT READY
1000:6a5f  LAB_1000_6a5f:
1000:6a5f      e8 99 ed                 CALL 0x1000:57fb
                ; inline script -> 1000:6a99  <c2>  PLEASE CORRECT, THEN  HIT R TO RETRY OR Q TO QUIT
1000:6a99  LAB_1000_6a99:
1000:6a99      e8 a9 a0                 CALL 0x1000:0b45
1000:6a9c      75 fb                    JNZ 0x1000:6a99
1000:6a9e  LAB_1000_6a9e:
1000:6a9e      e8 a4 a0                 CALL 0x1000:0b45
1000:6aa1      74 fb                    JZ 0x1000:6a9e
1000:6aa3      3c 06                    CMP AL,0x6
1000:6aa5      75 02                    JNZ 0x1000:6aa9
1000:6aa7      eb f5                    JMP 0x1000:6a9e
1000:6aa9  LAB_1000_6aa9:
1000:6aa9      24 df                    AND AL,0xdf
1000:6aab      3c 51                    CMP AL,0x51
1000:6aad      74 0d                    JZ 0x1000:6abc
1000:6aaf      3c 52                    CMP AL,0x52
1000:6ab1      75 eb                    JNZ 0x1000:6a9e
1000:6ab3      5a                       POP DX
1000:6ab4      59                       POP CX
1000:6ab5      5b                       POP BX
1000:6ab6      07                       POP ES
1000:6ab7      1f                       POP DS
1000:6ab8      b8 01 00                 MOV AX,0x1
1000:6abb      cf                       IRET
1000:6abc  LAB_1000_6abc:
1000:6abc      83 c4 1c                 ADD SP,0x1c
1000:6abf      c6 06 73 a2 01           MOV byte ptr [0xa273],0x1
1000:6ac4      5d                       POP BP
1000:6ac5      1f                       POP DS
1000:6ac6      07                       POP ES
1000:6ac7      b8 99 99                 MOV AX,0x9999
1000:6aca      cf                       IRET

; ------------------------------------------------------------
1000:6acb  FUN_1000_6acb:
1000:6acb      bb ad a4                 MOV BX,0xa4ad
1000:6ace      ff 07                    INC word ptr [BX]
1000:6ad0      83 2e 57 a2 64           SUB word ptr [0xa257],0x64
1000:6ad5      e8 45 00                 CALL 0x1000:6b1d
1000:6ad8      50                       PUSH AX
1000:6ad9      b9 24 00                 MOV CX,0x24
1000:6adc      bf c3 a4                 MOV DI,0xa4c3
1000:6adf  LAB_1000_6adf:
1000:6adf      be a3 a4                 MOV SI,0xa4a3
1000:6ae2      80 3d 00                 CMP byte ptr [DI],0x0
1000:6ae5      74 25                    JZ 0x1000:6b0c
1000:6ae7      51                       PUSH CX
1000:6ae8      b9 06 00                 MOV CX,0x6
1000:6aeb      57                       PUSH DI
1000:6aec      f3 a6                    CMPSB.REPE ES:DI,SI
1000:6aee      5f                       POP DI
1000:6aef      59                       POP CX
1000:6af0      74 07                    JZ 0x1000:6af9
1000:6af2      83 c7 0a                 ADD DI,0xa
1000:6af5      e2 e8                    LOOP 0x1000:6adf
1000:6af7      58                       POP AX
1000:6af8      c3                       RET
1000:6af9  LAB_1000_6af9:
1000:6af9      58                       POP AX
1000:6afa      a8 01                    TEST AL,0x1
1000:6afc      74 03                    JZ 0x1000:6b01
1000:6afe      ff 45 06                 INC word ptr [DI + 0x6]
1000:6b01  LAB_1000_6b01:
1000:6b01      a8 02                    TEST AL,0x2
1000:6b03      74 03                    JZ 0x1000:6b08
1000:6b05      ff 45 08                 INC word ptr [DI + 0x8]
1000:6b08  LAB_1000_6b08:
1000:6b08      e8 1c 02                 CALL 0x1000:6d27
1000:6b0b      c3                       RET
1000:6b0c  LAB_1000_6b0c:
1000:6b0c      57                       PUSH DI
1000:6b0d      b9 06 00                 MOV CX,0x6
1000:6b10      f3 a4                    MOVSB.REP ES:DI,SI
1000:6b12      b9 04 00                 MOV CX,0x4
1000:6b15      32 c0                    XOR AL,AL
1000:6b17      f3 aa                    STOSB.REP ES:DI
1000:6b19      5f                       POP DI
1000:6b1a      eb dd                    JMP 0x1000:6af9

; ------------------------------------------------------------
1000:6b1d  FUN_1000_6b1d:
1000:6b1d      80 3e 31 a2 6d           CMP byte ptr [0xa231],0x6d
1000:6b22      75 38                    JNZ 0x1000:6b5c
1000:6b24      8b 1e e6 89              MOV BX,word ptr [0x89e6]
1000:6b28      80 3e 3c a2 6d           CMP byte ptr [0xa23c],0x6d
1000:6b2d      b6 31                    MOV DH,0x31
1000:6b2f      75 1f                    JNZ 0x1000:6b50
1000:6b31      3b 1e e8 89              CMP BX,word ptr [0x89e8]
1000:6b35      73 04                    JNC 0x1000:6b3b
1000:6b37      8b 1e e8 89              MOV BX,word ptr [0x89e8]
1000:6b3b  LAB_1000_6b3b:
1000:6b3b      fe c6                    INC DH
1000:6b3d      80 3e 47 a2 6d           CMP byte ptr [0xa247],0x6d
1000:6b42      75 0c                    JNZ 0x1000:6b50
1000:6b44      fe c6                    INC DH
1000:6b46      3b 1e ea 89              CMP BX,word ptr [0x89ea]
1000:6b4a      73 04                    JNC 0x1000:6b50
1000:6b4c      8b 1e ec 89              MOV BX,word ptr [0x89ec]
1000:6b50  LAB_1000_6b50:
1000:6b50      a1 e4 89                 MOV AX,[0x89e4]
1000:6b53      3b c3                    CMP AX,BX
1000:6b55      b7 6d                    MOV BH,0x6d
1000:6b57      b5 65                    MOV CH,0x65
1000:6b59      eb 14                    JMP 0x1000:6b6f
1000:6b5c  LAB_1000_6b5c:
1000:6b5c      8a 3e 31 a2              MOV BH,byte ptr [0xa231]
1000:6b60      8a 2e 32 a2              MOV CH,byte ptr [0xa232]
1000:6b64      8a 36 33 a2              MOV DH,byte ptr [0xa233]
1000:6b68      a1 e4 89                 MOV AX,[0x89e4]
1000:6b6b      3b 06 e6 89              CMP AX,word ptr [0x89e6]
1000:6b6f  LAB_1000_6b6f:
1000:6b6f      b4 01                    MOV AH,0x1
1000:6b71      77 06                    JA 0x1000:6b79
1000:6b73      b4 02                    MOV AH,0x2
1000:6b75      72 02                    JC 0x1000:6b79
1000:6b77      fe c4                    INC AH
1000:6b79  LAB_1000_6b79:
1000:6b79      8a c4                    MOV AL,AH
1000:6b7b      be 26 a2                 MOV SI,0xa226
1000:6b7e      8a 1c                    MOV BL,byte ptr [SI]
1000:6b80      8a 4c 01                 MOV CL,byte ptr [SI + 0x1]
1000:6b83      8a 54 02                 MOV DL,byte ptr [SI + 0x2]
1000:6b86      3a df                    CMP BL,BH
1000:6b88      77 12                    JA 0x1000:6b9c
1000:6b8a      72 23                    JC 0x1000:6baf
1000:6b8c      3a cd                    CMP CL,CH
1000:6b8e      77 0c                    JA 0x1000:6b9c
1000:6b90      72 1d                    JC 0x1000:6baf
1000:6b92      3a d6                    CMP DL,DH
1000:6b94      77 06                    JA 0x1000:6b9c
1000:6b96      72 17                    JC 0x1000:6baf
1000:6b98      f9                       STC
1000:6b99      eb 14                    JMP 0x1000:6baf
1000:6b9c  LAB_1000_6b9c:
1000:6b9c      8a e0                    MOV AH,AL
1000:6b9e      24 01                    AND AL,0x1
1000:6ba0      80 e4 02                 AND AH,0x2
1000:6ba3      d0 e0                    SHL AL,0x1
1000:6ba5      d0 ec                    SHR AH,0x1
1000:6ba7      0a c4                    OR AL,AH
1000:6ba9      86 df                    XCHG BH,BL
1000:6bab      86 cd                    XCHG CH,CL
1000:6bad      86 d6                    XCHG DH,DL
1000:6baf  LAB_1000_6baf:
1000:6baf      bf a3 a4                 MOV DI,0xa4a3
1000:6bb2      88 1d                    MOV byte ptr [DI],BL
1000:6bb4      88 4d 01                 MOV byte ptr [DI + 0x1],CL
1000:6bb7      88 55 02                 MOV byte ptr [DI + 0x2],DL
1000:6bba      88 7d 03                 MOV byte ptr [DI + 0x3],BH
1000:6bbd      88 6d 04                 MOV byte ptr [DI + 0x4],CH
1000:6bc0      88 75 05                 MOV byte ptr [DI + 0x5],DH
1000:6bc3      f8                       CLC
1000:6bc4      c3                       RET

; ------------------------------------------------------------
1000:6bc5  FUN_1000_6bc5:
1000:6bc5      e8 33 ec                 CALL 0x1000:57fb
                ; inline script -> 1000:6be8  <c3><clear>    TREK RECORD  <c1>(# GAMES 
1000:6be8  LAB_1000_6be8:
1000:6be8      bb ad a4                 MOV BX,0xa4ad
1000:6beb      8b 07                    MOV AX,word ptr [BX]
1000:6bed      e8 25 e8                 CALL 0x1000:5415
1000:6bf0      e8 08 ec                 CALL 0x1000:57fb
                ; inline script -> 1000:6bfb  <c1>)   
1000:6bfb  LAB_1000_6bfb:
1000:6bfb      be c3 a4                 MOV SI,0xa4c3
1000:6bfe      b9 12 00                 MOV CX,0x12
1000:6c01  LAB_1000_6c01:
1000:6c01      51                       PUSH CX
1000:6c02      e8 a9 00                 CALL 0x1000:6cae
1000:6c05      e8 f3 eb                 CALL 0x1000:57fb
                ; inline script -> 1000:6c0f  <c1>  
1000:6c0f  LAB_1000_6c0f:
1000:6c0f      e8 9c 00                 CALL 0x1000:6cae
1000:6c12      e8 e6 eb                 CALL 0x1000:57fb
                ; inline script -> 1000:6c1b  <c1>  
1000:6c1b  LAB_1000_6c1b:
1000:6c1b      59                       POP CX
1000:6c1c      e2 e3                    LOOP 0x1000:6c01
1000:6c1e      e8 da eb                 CALL 0x1000:57fb
                ; inline script -> 1000:6c46  <c3><box>    HIT Esc FOR PRIMARY MENU
1000:6c46  LAB_1000_6c46:
1000:6c46      e8 fc 9e                 CALL 0x1000:0b45
1000:6c49      74 fb                    JZ 0x1000:6c46
1000:6c4b      3c 06                    CMP AL,0x6
1000:6c4d      74 3a                    JZ 0x1000:6c89
1000:6c4f      24 df                    AND AL,0xdf
1000:6c51      3c 5a                    CMP AL,0x5a
1000:6c53      75 f1                    JNZ 0x1000:6c46
1000:6c55  LAB_1000_6c55:
1000:6c55      e8 ed 9e                 CALL 0x1000:0b45
1000:6c58      74 fb                    JZ 0x1000:6c55
1000:6c5a      3c 06                    CMP AL,0x6
1000:6c5c      74 2b                    JZ 0x1000:6c89
1000:6c5e      24 df                    AND AL,0xdf
1000:6c60      3c 41                    CMP AL,0x41
1000:6c62      75 e2                    JNZ 0x1000:6c46
1000:6c64  LAB_1000_6c64:
1000:6c64      e8 de 9e                 CALL 0x1000:0b45
1000:6c67      74 fb                    JZ 0x1000:6c64
1000:6c69      3c 06                    CMP AL,0x6
1000:6c6b      74 1c                    JZ 0x1000:6c89
1000:6c6d      24 df                    AND AL,0xdf
1000:6c6f      3c 50                    CMP AL,0x50
1000:6c71      75 d3                    JNZ 0x1000:6c46
1000:6c73      bf ad a4                 MOV DI,0xa4ad
1000:6c76      33 c0                    XOR AX,AX
1000:6c78      ab                       STOSW ES:DI
1000:6c79      83 c7 0e                 ADD DI,0xe
1000:6c7c      b9 68 01                 MOV CX,0x168
1000:6c7f      b0 00                    MOV AL,0x0
1000:6c81      f3 aa                    STOSB.REP ES:DI
1000:6c83      e8 a1 00                 CALL 0x1000:6d27
1000:6c86      e9 dd 94                 JMP 0x1000:0166
1000:6c89  LAB_1000_6c89:
1000:6c89      e9 39 ff                 JMP 0x1000:6bc5

; ------------------------------------------------------------
1000:6c8c  FUN_1000_6c8c:
1000:6c8c      bf af a4                 MOV DI,0xa4af
1000:6c8f      be 07 00                 MOV SI,0x7
1000:6c92      b9 14 00                 MOV CX,0x14
1000:6c95      f3 a4                    MOVSB.REP ES:DI,SI
1000:6c97      e8 8d 00                 CALL 0x1000:6d27
1000:6c9a      e9 c9 94                 JMP 0x1000:0166

; ------------------------------------------------------------
1000:6c9d  FUN_1000_6c9d:
1000:6c9d      be af a4                 MOV SI,0xa4af
1000:6ca0      bf 07 00                 MOV DI,0x7
1000:6ca3      b9 14 00                 MOV CX,0x14
1000:6ca6      f3 a4                    MOVSB.REP ES:DI,SI
1000:6ca8      c6 06 67 a2 05           MOV byte ptr [0xa267],0x5
1000:6cad      c3                       RET

; ------------------------------------------------------------
1000:6cae  FUN_1000_6cae:
1000:6cae      8a 04                    MOV AL,byte ptr [SI]
1000:6cb0      22 c0                    AND AL,AL
1000:6cb2      74 41                    JZ 0x1000:6cf5
1000:6cb4      e8 58 00                 CALL 0x1000:6d0f
1000:6cb7      8a 44 01                 MOV AL,byte ptr [SI + 0x1]
1000:6cba      e8 52 00                 CALL 0x1000:6d0f
1000:6cbd      8a 44 02                 MOV AL,byte ptr [SI + 0x2]
1000:6cc0      e8 4c 00                 CALL 0x1000:6d0f
1000:6cc3      8b 44 06                 MOV AX,word ptr [SI + 0x6]
1000:6cc6      56                       PUSH SI
1000:6cc7      e8 4b e7                 CALL 0x1000:5415
1000:6cca      e8 2e eb                 CALL 0x1000:57fb
                ; inline script -> 1000:6cd5  <c1> vs 
1000:6cd5  LAB_1000_6cd5:
1000:6cd5      5e                       POP SI
1000:6cd6      8a 44 03                 MOV AL,byte ptr [SI + 0x3]
1000:6cd9      e8 33 00                 CALL 0x1000:6d0f
1000:6cdc      8a 44 04                 MOV AL,byte ptr [SI + 0x4]
1000:6cdf      e8 2d 00                 CALL 0x1000:6d0f
1000:6ce2      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
1000:6ce5      e8 27 00                 CALL 0x1000:6d0f
1000:6ce8      8b 44 08                 MOV AX,word ptr [SI + 0x8]
1000:6ceb      56                       PUSH SI
1000:6cec      e8 26 e7                 CALL 0x1000:5415
1000:6cef      5e                       POP SI
1000:6cf0      83 c6 0a                 ADD SI,0xa
1000:6cf3      f8                       CLC
1000:6cf4      c3                       RET
1000:6cf5  LAB_1000_6cf5:
1000:6cf5      e8 03 eb                 CALL 0x1000:57fb
                ; inline script -> 1000:6d0e  <c1>                  
1000:6d0e  LAB_1000_6d0e:
1000:6d0e      c3                       RET

; ------------------------------------------------------------
1000:6d0f  FUN_1000_6d0f:
1000:6d0f      56                       PUSH SI
1000:6d10      b4 01                    MOV AH,0x1
1000:6d12      e8 66 e8                 CALL 0x1000:557b
1000:6d15      5e                       POP SI
1000:6d16      c3                       RET

; ------------------------------------------------------------
1000:6d17  FUN_1000_6d17:
1000:6d17      c7 06 55 a2 b4 00        MOV word ptr [0xa255],0xb4
1000:6d1d  LAB_1000_6d1d:
1000:6d1d      83 3e 55 a2 00           CMP word ptr [0xa255],0x0
1000:6d22      75 f9                    JNZ 0x1000:6d1d
1000:6d24      e9 6f 97                 JMP 0x1000:0496

; ------------------------------------------------------------
1000:6d27  FUN_1000_6d27:
1000:6d27      ba a0 39                 MOV DX,0x39a0
1000:6d2a      b8 02 3d                 MOV AX,0x3d02
1000:6d2d      cd 21                    INT 0x21
1000:6d2f      a3 ab a4                 MOV [0xa4ab],AX
1000:6d32      8b d8                    MOV BX,AX
1000:6d34      ba ad a4                 MOV DX,0xa4ad
1000:6d37      b9 00 02                 MOV CX,0x200
1000:6d3a      b4 40                    MOV AH,0x40
1000:6d3c      cd 21                    INT 0x21
1000:6d3e      8b 1e ab a4              MOV BX,word ptr [0xa4ab]
1000:6d42      ba ad a4                 MOV DX,0xa4ad
1000:6d45      b9 00 00                 MOV CX,0x0
1000:6d48      b4 40                    MOV AH,0x40
1000:6d4a      cd 21                    INT 0x21

; ------------------------------------------------------------
1000:6d4c  FUN_1000_6d4c:
1000:6d4c      8b 1e ab a4              MOV BX,word ptr [0xa4ab]
1000:6d50      b4 3e                    MOV AH,0x3e
1000:6d52      cd 21                    INT 0x21
1000:6d54      c3                       RET
1000:6d60      2e 8e 1e 00 00           MOV DS,word ptr CS:[0x0]
1000:6d65      a0 12 00                 MOV AL,[0x12]
1000:6d68      a2 b0 39                 MOV [0x39b0],AL
1000:6d6b      c6 06 b1 39 02           MOV byte ptr [0x39b1],0x2
1000:6d70      c6 06 08 a2 00           MOV byte ptr [0xa208],0x0
1000:6d75      c6 06 07 a2 00           MOV byte ptr [0xa207],0x0
1000:6d7a      c6 06 06 a2 00           MOV byte ptr [0xa206],0x0
1000:6d7f      c6 06 03 a2 01           MOV byte ptr [0xa203],0x1
1000:6d84      c6 06 74 a2 00           MOV byte ptr [0xa274],0x0
1000:6d89      c6 06 70 a2 01           MOV byte ptr [0xa270],0x1
1000:6d8e      c7 06 d0 89 00 00        MOV word ptr [0x89d0],0x0
1000:6d94      c6 06 71 a2 01           MOV byte ptr [0xa271],0x1
1000:6d99      c6 06 31 a2 6d           MOV byte ptr [0xa231],0x6d
1000:6d9e      c6 06 32 a2 65           MOV byte ptr [0xa232],0x65
1000:6da3      c6 06 33 a2 31           MOV byte ptr [0xa233],0x31
1000:6da8      c6 06 35 a2 01           MOV byte ptr [0xa235],0x1
1000:6dad      c6 06 26 a2 43           MOV byte ptr [0xa226],0x43
1000:6db2      c6 06 27 a2 42           MOV byte ptr [0xa227],0x42
1000:6db7      c6 06 28 a2 4d           MOV byte ptr [0xa228],0x4d
1000:6dbc      c6 06 2a a2 01           MOV byte ptr [0xa22a],0x1
1000:6dc1      e8 0d d2                 CALL 0x1000:3fd1
1000:6dc4      c6 06 dc 89 0a           MOV byte ptr [0x89dc],0xa
1000:6dc9      c6 06 dd 89 0a           MOV byte ptr [0x89dd],0xa
1000:6dce      c6 06 74 a2 00           MOV byte ptr [0xa274],0x0
1000:6dd3      b1 00                    MOV CL,0x0
1000:6dd5      bf 64 8c                 MOV DI,0x8c64
1000:6dd8  LAB_1000_6dd8:
1000:6dd8      51                       PUSH CX
1000:6dd9      e8 7d d6                 CALL 0x1000:4459
1000:6ddc      59                       POP CX
1000:6ddd      fe c1                    INC CL
1000:6ddf      83 c7 3b                 ADD DI,0x3b
1000:6de2      80 f9 04                 CMP CL,0x4
1000:6de5      72 f1                    JC 0x1000:6dd8
1000:6de7      c6 06 74 a2 01           MOV byte ptr [0xa274],0x1
1000:6dec      b1 00                    MOV CL,0x0
1000:6dee  LAB_1000_6dee:
1000:6dee      51                       PUSH CX
1000:6def      e8 67 d6                 CALL 0x1000:4459
1000:6df2      59                       POP CX
1000:6df3      fe c1                    INC CL
1000:6df5      80 f9 04                 CMP CL,0x4
1000:6df8      72 f4                    JC 0x1000:6dee
1000:6dfa      c6 06 74 a2 00           MOV byte ptr [0xa274],0x0
1000:6dff      b9 0a 00                 MOV CX,0xa
1000:6e02  LAB_1000_6e02:
1000:6e02      51                       PUSH CX
1000:6e03      e8 a6 c9                 CALL 0x1000:37ac
1000:6e06      59                       POP CX
1000:6e07      e2 f9                    LOOP 0x1000:6e02
1000:6e09      c6 06 6f a2 00           MOV byte ptr [0xa26f],0x0
1000:6e0e      c6 06 d4 89 40           MOV byte ptr [0x89d4],0x40
1000:6e13      be 64 8c                 MOV SI,0x8c64
1000:6e16      c6 44 0a 20              MOV byte ptr [SI + 0xa],0x20
1000:6e1a      c6 44 0b 20              MOV byte ptr [SI + 0xb],0x20
1000:6e1e      c6 44 06 05              MOV byte ptr [SI + 0x6],0x5
1000:6e22      c6 44 07 0a              MOV byte ptr [SI + 0x7],0xa
1000:6e26      c6 44 0f 0a              MOV byte ptr [SI + 0xf],0xa
1000:6e2a      80 0c 35                 OR byte ptr [SI],0x35
1000:6e2d      c6 44 2a 0a              MOV byte ptr [SI + 0x2a],0xa
1000:6e31      c6 44 11 81              MOV byte ptr [SI + 0x11],0x81
1000:6e35      c7 44 12 a2 02           MOV word ptr [SI + 0x12],0x2a2
1000:6e3a      c6 44 16 08              MOV byte ptr [SI + 0x16],0x8
1000:6e3e      b9 07 00                 MOV CX,0x7
1000:6e41  LAB_1000_6e41:
1000:6e41      83 c6 3b                 ADD SI,0x3b
1000:6e44      80 0c 04                 OR byte ptr [SI],0x4
1000:6e47      e2 f8                    LOOP 0x1000:6e41
1000:6e49      be ad 6e                 MOV SI,0x6ead
1000:6e4c  LAB_1000_6e4c:
1000:6e4c      56                       PUSH SI
1000:6e4d      fe 06 d2 89              INC byte ptr [0x89d2]
1000:6e51      2e ff 14                 CALL word ptr CS:[SI]
1000:6e54      73 03                    JNC 0x1000:6e59
1000:6e56      58                       POP AX
1000:6e57      eb f3                    JMP 0x1000:6e4c
1000:6e59  LAB_1000_6e59:
1000:6e59      a0 b0 39                 MOV AL,[0x39b0]
1000:6e5c      a2 12 00                 MOV [0x12],AL
1000:6e5f      e8 e3 9c                 CALL 0x1000:0b45
1000:6e62      c6 06 6c a2 00           MOV byte ptr [0xa26c],0x0
1000:6e67      8a 26 b1 39              MOV AH,byte ptr [0x39b1]
1000:6e6b      88 26 12 00              MOV byte ptr [0x12],AH
1000:6e6f      5e                       POP SI
1000:6e70      74 da                    JZ 0x1000:6e4c
1000:6e72      3c 06                    CMP AL,0x6
1000:6e74      74 d6                    JZ 0x1000:6e4c
1000:6e76      3c c9                    CMP AL,0xc9
1000:6e78      74 08                    JZ 0x1000:6e82
1000:6e7a      3c 2d                    CMP AL,0x2d
1000:6e7c      74 04                    JZ 0x1000:6e82
1000:6e7e      3c c8                    CMP AL,0xc8
1000:6e80      75 0b                    JNZ 0x1000:6e8d
1000:6e82  LAB_1000_6e82:
1000:6e82      81 fe ad 6e              CMP SI,0x6ead
1000:6e86      74 1d                    JZ 0x1000:6ea5
1000:6e88      83 ee 02                 SUB SI,0x2
1000:6e8b      eb bf                    JMP 0x1000:6e4c
1000:6e8d  LAB_1000_6e8d:
1000:6e8d      3c d1                    CMP AL,0xd1
1000:6e8f      74 08                    JZ 0x1000:6e99
1000:6e91      3c 2b                    CMP AL,0x2b
1000:6e93      74 04                    JZ 0x1000:6e99
1000:6e95      3c d0                    CMP AL,0xd0
1000:6e97      75 0c                    JNZ 0x1000:6ea5
1000:6e99  LAB_1000_6e99:
1000:6e99      2e 83 7c 02 00           CMP word ptr CS:[SI + 0x2],0x0
1000:6e9e      74 05                    JZ 0x1000:6ea5
1000:6ea0      83 c6 02                 ADD SI,0x2
1000:6ea3      eb a7                    JMP 0x1000:6e4c
1000:6ea5  LAB_1000_6ea5:
1000:6ea5      56                       PUSH SI
1000:6ea6      e8 56 ea                 CALL 0x1000:58ff
1000:6ea9      5e                       POP SI
1000:6eaa      eb a0                    JMP 0x1000:6e4c

; ------------------------------------------------------------
1000:6f19  FUN_1000_6f19:
1000:6f19      c6 06 d4 89 40           MOV byte ptr [0x89d4],0x40
1000:6f1e      c6 06 b1 39 02           MOV byte ptr [0x39b1],0x2
1000:6f23      e8 d5 e8                 CALL 0x1000:57fb
                ; inline script -> 1000:6fb7  <c3><clear>                INSTRUCTIONS   <c1>    USE PgUp AND PgDn KEYS TO SCAN.       PRINT FILE "TREKCMDS" TO GET A      SUMMARY OF ALL THE COMMANDS.  
1000:6fb7  LAB_1000_6fb7:
1000:6fb7      80 3e 72 a2 01           CMP byte ptr [0xa272],0x1
1000:6fbc      75 09                    JNZ 0x1000:6fc7
1000:6fbe      e8 3a e8                 CALL 0x1000:57fb
                ; inline script -> 1000:6fc5  <c3>
1000:6fc5  LAB_1000_6fc5:
1000:6fc5      f8                       CLC
1000:6fc6      c3                       RET
1000:6fc7  LAB_1000_6fc7:
1000:6fc7      e8 31 e8                 CALL 0x1000:57fb
                ; inline script -> 1000:7077  <c2>SINCE THIS IS YOUR FIRST TIME,  IT IS A REQUIREMENT THAT YOU  READ ALL THE INSTRUCTIONS VERY  CAREFULLY.  THE GAME WILL NOT  START UNTIL I AM SURE YOU KNOW 
1000:7077  LAB_1000_7077:
1000:7077      f8                       CLC
1000:7078      c3                       RET

; ------------------------------------------------------------
1000:7079  FUN_1000_7079:
1000:7079      e8 7f e7                 CALL 0x1000:57fb
                ; inline script -> 1000:738b  <c2><clear>              GAME HISTORY   <c1>     TREK ORIGINATED ABOUT SIX YEARS  AGO AS A Z80 BASED, HARDWARE INDEPENDENT  GAME.  THE ORIGINAL GOAL WAS TO DESI
1000:738b  LAB_1000_738b:
1000:738b      f8                       CLC
1000:738c      c3                       RET
1000:738d      e8 6b e4                 CALL 0x1000:57fb
                ; inline script -> 1000:75aa  <c2><clear>              GAME UPDATES   <c1>    IF YOU WOULD LIKE TO RECEIVE THE  LATEST LEVEL OF TREK, PLEASE SEND $10.00  WITH YOUR NAME, ADDRESS, (AND PHONE 
1000:75aa  LAB_1000_75aa:
1000:75aa      f8                       CLC
1000:75ab      c3                       RET
1000:75ac      e8 4c e2                 CALL 0x1000:57fb
                ; inline script -> 1000:7741  <c2><clear>         UPDATE HISTORY   <c1>TREK23 - OCT 30,1985           INITIAL PUBLIC RELEASE  TREK24 - NOT RELEASED TO PUBLIC  TREK25 - AUG 10,1986           
1000:7741  LAB_1000_7741:
1000:7741      f8                       CLC
1000:7742      c3                       RET
1000:7743      e8 b5 e0                 CALL 0x1000:57fb
                ; inline script -> 1000:79c1  <c2><clear>            GAME DESCRIPTION   <c1>  EACH PLAYER STARTS WITH A STARBASE AND  UP TO TWELVE STARSHIPS, DEPENDING ON THE  HANDICAP LEVEL SELECTED.  EACH
1000:79c1  LAB_1000_79c1:
1000:79c1      f8                       CLC
1000:79c2      c3                       RET
1000:79c3      e8 35 de                 CALL 0x1000:57fb
                ; inline script -> 1000:7b7b  <c3><clear>            SHIPS AND BASES      <c1>   YOUR STARSHIPS    <c2>  ENEMY STARSHIPS      <c1>   YOUR STARBASE     <c2>  ENEMY STARBASE  <c3>-------------
1000:7b7b  LAB_1000_7b7b:
1000:7b7b      a0 d2 89                 MOV AL,[0x89d2]
1000:7b7e      24 03                    AND AL,0x3
1000:7b80      75 17                    JNZ 0x1000:7b99
1000:7b82      e8 76 dc                 CALL 0x1000:57fb
                ; inline script -> 1000:7b97  <c3><pic><pic>
1000:7b97  LAB_1000_7b97:
1000:7b97      f8                       CLC
1000:7b98      c3                       RET
1000:7b99  LAB_1000_7b99:
1000:7b99      fe c8                    DEC AL
1000:7b9b      75 17                    JNZ 0x1000:7bb4
1000:7b9d      e8 5b dc                 CALL 0x1000:57fb
                ; inline script -> 1000:7bb2  <c3><pic><pic>
1000:7bb2  LAB_1000_7bb2:
1000:7bb2      f8                       CLC
1000:7bb3      c3                       RET
1000:7bb4  LAB_1000_7bb4:
1000:7bb4      fe c8                    DEC AL
1000:7bb6      75 17                    JNZ 0x1000:7bcf
1000:7bb8      e8 40 dc                 CALL 0x1000:57fb
                ; inline script -> 1000:7bcd  <c3><pic><pic>
1000:7bcd  LAB_1000_7bcd:
1000:7bcd      f8                       CLC
1000:7bce      c3                       RET
1000:7bcf  LAB_1000_7bcf:
1000:7bcf      e8 29 dc                 CALL 0x1000:57fb
                ; inline script -> 1000:7be4  <c3><pic><pic>
1000:7be4  LAB_1000_7be4:
1000:7be4      f8                       CLC
1000:7be5      c3                       RET
1000:7be6      e8 12 dc                 CALL 0x1000:57fb
                ; inline script -> 1000:7dd9  <c3><clear>                PLANETS   <c1>       ENERGY (UP TO 15,000 UNITS)          TORPEDO (UP TO 10 TORPEDOES)          DOCK (TRANSPORTS SHIP TO BASE)       
1000:7dd9  LAB_1000_7dd9:
1000:7dd9      f8                       CLC
1000:7dda      c3                       RET
1000:7ddb      e8 1d da                 CALL 0x1000:57fb
                ; inline script -> 1000:7feb  <c3><clear>                 FLAGS   <c1>EACH SHIP GETS ONE FLAG TO MARK ONE  PLANET.  ONCE A PLANET IS FLAGGED, IT  CAN ONLY BE USED BY YOU.  IT IS STILL  VISIB
1000:7feb  LAB_1000_7feb:
1000:7feb      f8                       CLC
1000:7fec      c3                       RET
1000:7fed      e8 0b d8                 CALL 0x1000:57fb
                ; inline script -> 1000:8294  <c3><clear>                STARS   <c1>       NORMAL STAR (DRAINS SHIP ENERGY,              BEST TO AVOID IF POSSIBLE)         NOVA STAR (READY TO EXPLODE,     
1000:8294  LAB_1000_8294:
1000:8294      f8                       CLC
1000:8295      c3                       RET
1000:8296      e8 62 d5                 CALL 0x1000:57fb
                ; inline script -> 1000:8594  <c3><clear>    OTHER SIGHTS YOU WILL ENCOUNTER   <c1>      DEAD SHIP (HARMLESS TO            YOUR OTHER SHIPS)        DEAD SHIP (CONTAINING ENEMY MINES         
1000:8594  LAB_1000_8594:
1000:8594      a0 d2 89                 MOV AL,[0x89d2]
1000:8597      d0 e8                    SHR AL,0x1
1000:8599      24 07                    AND AL,0x7
1000:859b      75 33                    JNZ 0x1000:85d0
1000:859d      e8 5b d2                 CALL 0x1000:57fb
                ; inline script -> 1000:85ce  <c3><pic><pic><pic><pic><pic><pic>
1000:85ce  LAB_1000_85ce:
1000:85ce      f8                       CLC
1000:85cf      c3                       RET
1000:85d0  LAB_1000_85d0:
1000:85d0      fe c8                    DEC AL
1000:85d2      75 33                    JNZ 0x1000:8607
1000:85d4      e8 24 d2                 CALL 0x1000:57fb
                ; inline script -> 1000:8605  <c3><pic><pic><pic><pic><pic><pic>
1000:8605  LAB_1000_8605:
1000:8605      f8                       CLC
1000:8606      c3                       RET
1000:8607  LAB_1000_8607:
1000:8607      fe c8                    DEC AL
1000:8609      75 33                    JNZ 0x1000:863e
1000:860b      e8 ed d1                 CALL 0x1000:57fb
                ; inline script -> 1000:863c  <c3><pic><pic><pic><pic><pic><pic>
1000:863c  LAB_1000_863c:
1000:863c      f8                       CLC
1000:863d      c3                       RET
1000:863e  LAB_1000_863e:
1000:863e      fe c8                    DEC AL
1000:8640      75 33                    JNZ 0x1000:8675
1000:8642      e8 b6 d1                 CALL 0x1000:57fb
                ; inline script -> 1000:8673  <c3><pic><pic><pic><pic><pic><pic>
1000:8673  LAB_1000_8673:
1000:8673      f8                       CLC
1000:8674      c3                       RET
1000:8675  LAB_1000_8675:
1000:8675      fe c8                    DEC AL
1000:8677      75 33                    JNZ 0x1000:86ac
1000:8679      e8 7f d1                 CALL 0x1000:57fb
                ; inline script -> 1000:86aa  <c3><pic><pic><pic><pic><pic><pic>
1000:86aa  LAB_1000_86aa:
1000:86aa      f8                       CLC
1000:86ab      c3                       RET
1000:86ac  LAB_1000_86ac:
1000:86ac      fe c8                    DEC AL
1000:86ae      75 33                    JNZ 0x1000:86e3
1000:86b0      e8 48 d1                 CALL 0x1000:57fb
                ; inline script -> 1000:86e1  <c3><pic><pic><pic><pic><pic><pic>
1000:86e1  LAB_1000_86e1:
1000:86e1      f8                       CLC
1000:86e2      c3                       RET
1000:86e3  LAB_1000_86e3:
1000:86e3      fe c8                    DEC AL
1000:86e5      75 33                    JNZ 0x1000:871a
1000:86e7      e8 11 d1                 CALL 0x1000:57fb
                ; inline script -> 1000:8718  <c3><pic><pic><pic><pic><pic><pic>
1000:8718  LAB_1000_8718:
1000:8718      f8                       CLC
1000:8719      c3                       RET
1000:871a  LAB_1000_871a:
1000:871a      e8 de d0                 CALL 0x1000:57fb
                ; inline script -> 1000:874b  <c3><pic><pic><pic><pic><pic><pic>
1000:874b  LAB_1000_874b:
1000:874b      f8                       CLC
1000:874c      c3                       RET
1000:874d      e8 ab d0                 CALL 0x1000:57fb
                ; inline script -> 1000:89aa  <c3><clear>      SHIP AND VIEW SELECTION KEYS      KEY              FUNCTION  <c2>    F1<c1>      SELECT SHIP 1  <c2>    F2<c1>        "     "   2  <c2>    F3<c
1000:89aa  LAB_1000_89aa:
1000:89aa      f8                       CLC
1000:89ab      c3                       RET
1000:89ac      e8 4c ce                 CALL 0x1000:57fb
                ; inline script -> 1000:8b00  <c3><clear>           SHIP MOVEMENT KEYS       KEY          FUNCTION  <c2> +  or <c3><c1>  INCREASE IMPULSE SPEED .1  <c2> -  or <c3><c1>  DECREASE IMPULSE SPEE
1000:8b00  LAB_1000_8b00:
1000:8b00      f8                       CLC
1000:8b01      c3                       RET
1000:8b02      e8 f6 cc                 CALL 0x1000:57fb
                ; inline script -> 1000:8c49  <c3><clear>              WEAPONS KEYS     KEY          FUNCTION  <c2>Space<c1>  FIRE PHOTON TORPEDO  <c2>  C  <c1>  CANCEL PHOTON TORPEDO  <c2>  P  <c1>  FIRE F
1000:8c49  LAB_1000_8c49:
1000:8c49      f8                       CLC
1000:8c4a      c3                       RET
1000:8c4b      e8 ad cb                 CALL 0x1000:57fb
                ; inline script -> 1000:8e74  <c3><clear>            SCAN RANGE KEYS    KEY                FUNCTION  <c2> 1  <c1>  SCAN 400 BY  400  (SHORT RANGE)  <c2> 2  <c1>   "  1600 BY 1600  (MEDIUM RA
1000:8e74  LAB_1000_8e74:
1000:8e74      f8                       CLC
1000:8e75      c3                       RET
1000:8e76      e8 82 c9                 CALL 0x1000:57fb
                ; inline script -> 1000:90e8  <c3><clear>             AUXILLARY KEYS       KEY          FUNCTION  <c2>    G <c1>  GET PREVIOUSLY DROPPED MINE  <c3>           (ALLOWS YOU TO PICK UP ONE      
1000:90e8  LAB_1000_90e8:
1000:90e8      f8                       CLC
1000:90e9      c3                       RET
1000:90ea      e8 0e c7                 CALL 0x1000:57fb
                ; inline script -> 1000:9320  <c3><clear>     COMPUTER MODE KEYS   <c1> KEY            FUNCTION  ALT-A        SEEK ALL  ALT-B        SEEK ENEMY BASE  ALT-C        RESET AUTO SEEK  ALT-D     
1000:9320  LAB_1000_9320:
1000:9320      f8                       CLC
1000:9321      c3                       RET
1000:9322      e8 d6 c4                 CALL 0x1000:57fb
                ; inline script -> 1000:9512  <c3><clear>             MESSAGE SYSTEM   <c1>   MESSAGES MAY BE SENT TO YOUR OPPONENT  WHILE PLAYING THE GAME.  THE TAB KEY  (OVER THE Ctrl KEY) IS USED TO ENTE
1000:9512  LAB_1000_9512:
1000:9512      f8                       CLC
1000:9513      c3                       RET
1000:9514      e8 e4 c2                 CALL 0x1000:57fb
                ; inline script -> 1000:96c8  <c3><clear>           BUILDING A BASE   <c1>   THE MINI-BASES SCATTERED THROUGHOUT  THE UNIVERSE (IN YOUR PLANE) CAN BE  CONVERTED INTO A NEW BASE.  YOU MUST FI
1000:96c8  LAB_1000_96c8:
1000:96c8      f8                       CLC
1000:96c9      c3                       RET
1000:96ca      e8 2e c1                 CALL 0x1000:57fb
                ; inline script -> 1000:9935  <c3><clear>             SCORING SYSTEM   <c1>   SCORES ARE BASED ON THE AMOUNT OF  DAMAGE YOU INFLICT ON YOUR ENEMIES AND  THE AMOUNT OF ENERGY YOU HAVE LEFT AT
1000:9935  LAB_1000_9935:
1000:9935      f8                       CLC
1000:9936      c3                       RET
1000:9937      e8 c1 be                 CALL 0x1000:57fb
                ; inline script -> 1000:99b8  <c1><clear>  HIT Esc TO PAUSE GAME.   AFTER 3 SECONDS PAUSE   MESSAGE WILL APPEAR.   BOTH PLAYERS MUST THEN   HIT Esc TO CONTINUE.  
1000:99b8  LAB_1000_99b8:
1000:99b8      c6 06 6c a2 80           MOV byte ptr [0xa26c],0x80
1000:99bd      c7 06 b5 39 4e 00        MOV word ptr [0x39b5],0x4e
1000:99c3      c7 06 b7 39 82 00        MOV word ptr [0x39b7],0x82
1000:99c9      e9 62 0b                 JMP 0x1000:a52e
1000:99cc      e8 2c be                 CALL 0x1000:57fb
                ; inline script -> 1000:9a19  <c1><clear>     DIRECTION METER   GREEN HAND -> DESIRED   RED HAND   -> ACTUAL  
1000:9a19  LAB_1000_9a19:
1000:9a19      c7 06 b5 39 c8 00        MOV word ptr [0x39b5],0xc8
1000:9a1f      c7 06 b7 39 16 00        MOV word ptr [0x39b7],0x16
1000:9a25      e9 06 0b                 JMP 0x1000:a52e
1000:9a28      e8 d0 bd                 CALL 0x1000:57fb
                ; inline script -> 1000:9a73  <c1><clear>     IMPULSE METER   GREEN HAND -> DESIRED   RED HAND   -> ACTUAL  
1000:9a73  LAB_1000_9a73:
1000:9a73      c7 06 b5 39 ec 00        MOV word ptr [0x39b5],0xec
1000:9a79      c7 06 b7 39 16 00        MOV word ptr [0x39b7],0x16
1000:9a7f      e9 ac 0a                 JMP 0x1000:a52e
1000:9a82      e8 76 bd                 CALL 0x1000:57fb
                ; inline script -> 1000:9a9f  <c1><clear>    NUMBER OF MINES  
1000:9a9f  LAB_1000_9a9f:
1000:9a9f      c7 06 b5 39 10 01        MOV word ptr [0x39b5],0x110
1000:9aa5      c7 06 b7 39 08 00        MOV word ptr [0x39b7],0x8
1000:9aab      e9 80 0a                 JMP 0x1000:a52e
1000:9aae      e8 4a bd                 CALL 0x1000:57fb
                ; inline script -> 1000:9acd  <c1><clear>  NUMBER OF TORPEDOES  
1000:9acd  LAB_1000_9acd:
1000:9acd      c7 06 b5 39 12 01        MOV word ptr [0x39b5],0x112
1000:9ad3      c7 06 b7 39 16 00        MOV word ptr [0x39b7],0x16
1000:9ad9      e9 52 0a                 JMP 0x1000:a52e
1000:9adc      e8 1c bd                 CALL 0x1000:57fb
                ; inline script -> 1000:9b61  <c1><clear>  FLAG STATUS     IF F(LAG) COMMAND     IS ACTIVE, IT WILL     BLINK INDICATING NEXT     PLANET IN RANGE WILL     BE FLAGGED.
1000:9b61  LAB_1000_9b61:
1000:9b61      c7 06 b5 39 d8 00        MOV word ptr [0x39b5],0xd8
1000:9b67      c7 06 b7 39 1d 00        MOV word ptr [0x39b7],0x1d
1000:9b6d      e9 be 09                 JMP 0x1000:a52e
1000:9b70      e8 88 bc                 CALL 0x1000:57fb
                ; inline script -> 1000:9ba1  <c1><clear>    WARP METER   GREEN BAR -> TIME LEFT  
1000:9ba1  LAB_1000_9ba1:
1000:9ba1      c7 06 b5 39 c0 00        MOV word ptr [0x39b5],0xc0
1000:9ba7      c7 06 b7 39 26 00        MOV word ptr [0x39b7],0x26
1000:9bad      e9 7e 09                 JMP 0x1000:a52e
1000:9bb0      e8 48 bc                 CALL 0x1000:57fb
                ; inline script -> 1000:9be1  <c1><clear>  INVISO METER   GREEN BAR -> TIME LEFT  
1000:9be1  LAB_1000_9be1:
1000:9be1      c7 06 b5 39 c0 00        MOV word ptr [0x39b5],0xc0
1000:9be7      c7 06 b7 39 30 00        MOV word ptr [0x39b7],0x30
1000:9bed      e9 3e 09                 JMP 0x1000:a52e
1000:9bf0      e8 08 bc                 CALL 0x1000:57fb
                ; inline script -> 1000:9c56  <c1><clear>  CURRENT SHIP    ALWAYS APPEARS IN    CENTER OF SCREEN.    COMMANDS AFFECT    THIS SHIP ONLY.
1000:9c56  LAB_1000_9c56:
1000:9c56      c7 06 b5 39 e3 00        MOV word ptr [0x39b5],0xe3
1000:9c5c      c7 06 b7 39 3c 00        MOV word ptr [0x39b7],0x3c
1000:9c62      e9 c9 08                 JMP 0x1000:a52e
1000:9c65      e8 93 bb                 CALL 0x1000:57fb
                ; inline script -> 1000:9ca6  <c1><clear>  COMPUTER STATUS   CURRENT SEEK OBJECT   AND DISTANCE.  
1000:9ca6  LAB_1000_9ca6:
1000:9ca6      c7 06 b5 39 fc 00        MOV word ptr [0x39b5],0xfc
1000:9cac      c7 06 b7 39 44 00        MOV word ptr [0x39b7],0x44
1000:9cb2      e9 79 08                 JMP 0x1000:a52e
1000:9cb5      e8 43 bb                 CALL 0x1000:57fb
                ; inline script -> 1000:9d23  <c1><clear>  GALAXY LEVEL    IF PLAYING IN MULTI-    GALAXIES, CURRENT    LEVEL OF THIS SHIP    WILL BE INDICATED
1000:9d23  LAB_1000_9d23:
1000:9d23      c7 06 b5 39 e3 00        MOV word ptr [0x39b5],0xe3
1000:9d29      c7 06 b7 39 4c 00        MOV word ptr [0x39b7],0x4c
1000:9d2f      e9 fc 07                 JMP 0x1000:a52e
1000:9d32      e8 c6 ba                 CALL 0x1000:57fb
                ; inline script -> 1000:9d6e  <c1><clear>  WEAPONS STATUS    READY  <c3>  FIRED    WAIT  <c2>  INOP
1000:9d6e  LAB_1000_9d6e:
1000:9d6e      c7 06 b5 39 00 01        MOV word ptr [0x39b5],0x100
1000:9d74      c7 06 b7 39 54 00        MOV word ptr [0x39b7],0x54
1000:9d7a      e9 b1 07                 JMP 0x1000:a52e
1000:9d7d      e8 7b ba                 CALL 0x1000:57fb
                ; inline script -> 1000:9dad  <c1><clear>  SHIELDS STATUS    DOWN  <c3>  UP  <c2>  INOP
1000:9dad  LAB_1000_9dad:
1000:9dad      c7 06 b5 39 00 01        MOV word ptr [0x39b5],0x100
1000:9db3      c7 06 b7 39 5c 00        MOV word ptr [0x39b7],0x5c
1000:9db9      e9 72 07                 JMP 0x1000:a52e
1000:9dbc      e8 3c ba                 CALL 0x1000:57fb
                ; inline script -> 1000:9df3  <c1><clear>  SCANNER STATUS    SHORT, MED, LONG,    OR MAP
1000:9df3  LAB_1000_9df3:
1000:9df3      c7 06 b5 39 00 01        MOV word ptr [0x39b5],0x100
1000:9df9      c7 06 b7 39 64 00        MOV word ptr [0x39b7],0x64
1000:9dff      e9 2c 07                 JMP 0x1000:a52e
1000:9e02      e8 f6 b9                 CALL 0x1000:57fb
                ; inline script -> 1000:9e2d  <c1><clear>  COMPUTER STATUS    READY OR <c2>INOP
1000:9e2d  LAB_1000_9e2d:
1000:9e2d      c7 06 b5 39 00 01        MOV word ptr [0x39b5],0x100
1000:9e33      c7 06 b7 39 6c 00        MOV word ptr [0x39b7],0x6c
1000:9e39      e9 f2 06                 JMP 0x1000:a52e
1000:9e3c      e8 bc b9                 CALL 0x1000:57fb
                ; inline script -> 1000:9ea7  <c1><clear>  FIRE CONTROL    INDICATES ENEMY    SELECTED BY F5 KEY.    * DESIGNATES ANY    ENEMY SHIP OR BASE.
1000:9ea7  LAB_1000_9ea7:
1000:9ea7      c7 06 b5 39 00 01        MOV word ptr [0x39b5],0x100
1000:9ead      c7 06 b7 39 74 00        MOV word ptr [0x39b7],0x74
1000:9eb3      e9 78 06                 JMP 0x1000:a52e
1000:9eb6      e8 42 b9                 CALL 0x1000:57fb
                ; inline script -> 1000:9efd  <c1><clear>  YOUR BASE STATUS    CONDITION, ENERGY,    MINES AND TORPEDOES
1000:9efd  LAB_1000_9efd:
1000:9efd      c7 06 b5 39 b8 00        MOV word ptr [0x39b5],0xb8
1000:9f03      c7 06 b7 39 84 00        MOV word ptr [0x39b7],0x84
1000:9f09      e9 22 06                 JMP 0x1000:a52e
1000:9f0c      e8 ec b8                 CALL 0x1000:57fb
                ; inline script -> 1000:9f2b  <c1><clear>  SUMMARY OF YOUR SHIPS
1000:9f2b  LAB_1000_9f2b:
1000:9f2b      c7 06 b5 39 b8 00        MOV word ptr [0x39b5],0xb8
1000:9f31      c7 06 b7 39 a8 00        MOV word ptr [0x39b7],0xa8
1000:9f37      e9 f4 05                 JMP 0x1000:a52e
1000:9f3a      e8 be b8                 CALL 0x1000:57fb
                ; inline script -> 1000:9fbd  <c1><clear>  INVISO INDICATOR    IF ON, INVISIBLE.    IF OFF, VISIBLE.    IF BLINKING, SHIP     IS VISIBLE WHILE     WEAPON IS ACTIVE.
1000:9fbd  LAB_1000_9fbd:
1000:9fbd      c7 06 b5 39 c4 00        MOV word ptr [0x39b5],0xc4
1000:9fc3      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
1000:9fc9      e9 62 05                 JMP 0x1000:a52e
1000:9fcc      e8 2c b8                 CALL 0x1000:57fb
                ; inline script -> 1000:9fe3  <c1><clear>  ENERGY STATUS
1000:9fe3  LAB_1000_9fe3:
1000:9fe3      c7 06 b5 39 d4 00        MOV word ptr [0x39b5],0xd4
1000:9fe9      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
1000:9fef      e9 3c 05                 JMP 0x1000:a52e
1000:9ff2      e8 06 b8                 CALL 0x1000:57fb
                ; inline script -> 1000:a028  <c1><clear>  RED CHECK INDICATES   PREVIOUS SEEK COMPLETE
1000:a028  LAB_1000_a028:
1000:a028      c7 06 b5 39 f2 00        MOV word ptr [0x39b5],0xf2
1000:a02e      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
1000:a034      e9 f7 04                 JMP 0x1000:a52e
1000:a037      e8 c1 b7                 CALL 0x1000:57fb
                ; inline script -> 1000:a07e  <c1><clear>  COMPUTER INDICATOR   SHOWS OBJECT THAT   COMPUTER IS SEEKING.
1000:a07e  LAB_1000_a07e:
1000:a07e      c7 06 b5 39 fc 00        MOV word ptr [0x39b5],0xfc
1000:a084      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
1000:a08a      e9 a1 04                 JMP 0x1000:a52e
1000:a08d      e8 6b b7                 CALL 0x1000:57fb
                ; inline script -> 1000:a118  <c1><clear>  CONDITION OF SHIP   GREEN-NO SHIP IN AREA   YELLOW-SHIP SPOTTED   ORANGE-SHIP IN RANGE   RED-SHIP VERY CLOSE       OR MUCH DAMAGE
1000:a118  LAB_1000_a118:
1000:a118      c7 06 b5 39 04 01        MOV word ptr [0x39b5],0x104
1000:a11e      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
1000:a124      e9 07 04                 JMP 0x1000:a52e
1000:a127      e8 d1 b6                 CALL 0x1000:57fb
                ; inline script -> 1000:a141  <c1><clear>  DOCKED INDICATOR
1000:a141  LAB_1000_a141:
1000:a141      c7 06 b5 39 0c 01        MOV word ptr [0x39b5],0x10c
1000:a147      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
1000:a14d      e9 de 03                 JMP 0x1000:a52e
1000:a150      e8 a8 b6                 CALL 0x1000:57fb
                ; inline script -> 1000:a1ef  <c1><clear>  WARNING INDICATOR    <c2>T<c1>=TORPEDO CLOSE    <c2>M<c1>=MINE CLOSE    <c2>R<c1>=ROGUE SHIP    <c2>H<c1>=HUM IN AREA    <c2>P<c1>=PHASER CLOSE    
1000:a1ef  LAB_1000_a1ef:
1000:a1ef      c7 06 b5 39 14 01        MOV word ptr [0x39b5],0x114
1000:a1f5      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
1000:a1fb      e9 30 03                 JMP 0x1000:a52e
1000:a1fe      e8 fa b5                 CALL 0x1000:57fb
                ; inline script -> 1000:a251  <c1><clear>  MINE SWEEP INDICATOR    (WHEN BLINKING,    GET MINE COMMAND IS    ACTIVE)
1000:a251  LAB_1000_a251:
1000:a251      c7 06 b5 39 1c 01        MOV word ptr [0x39b5],0x11c
1000:a257      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
1000:a25d      e9 ce 02                 JMP 0x1000:a52e
1000:a260      e8 98 b5                 CALL 0x1000:57fb
                ; inline script -> 1000:a2e4  <c1><clear>  MINE SWEEP INDICATOR   COLOR INDICATES NUMBER   OF MINES THAT SWEEP WILL   DESTROY.  <c2>   M = 1-3  <c3>   M = 4-6  <c1>   M = > 6
1000:a2e4  LAB_1000_a2e4:
1000:a2e4      c7 06 b5 39 1c 01        MOV word ptr [0x39b5],0x11c
1000:a2ea      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
1000:a2f0      e9 3b 02                 JMP 0x1000:a52e
1000:a2f3      e8 05 b5                 CALL 0x1000:57fb
                ; inline script -> 1000:a313  <c1><clear>  SUPER SHIELD INDICATOR
1000:a313  LAB_1000_a313:
1000:a313      c7 06 b5 39 24 01        MOV word ptr [0x39b5],0x124
1000:a319      c7 06 b7 39 9c 00        MOV word ptr [0x39b7],0x9c
1000:a31f      e9 0c 02                 JMP 0x1000:a52e
1000:a322      e8 d6 b4                 CALL 0x1000:57fb
                ; inline script -> 1000:a35c  <c1><clear>  SOUND ENABLED INDICATOR    Ctrl-S TOGGLES ON/OFF
1000:a35c  LAB_1000_a35c:
1000:a35c      c7 06 b5 39 d7 00        MOV word ptr [0x39b5],0xd7
1000:a362      c7 06 b7 39 03 00        MOV word ptr [0x39b7],0x3
1000:a368      c6 06 d4 89 40           MOV byte ptr [0x89d4],0x40
1000:a36d      e9 be 01                 JMP 0x1000:a52e
1000:a370      e8 88 b4                 CALL 0x1000:57fb
                ; inline script -> 1000:a3fe  <c1><clear>  Ctrl-F  TOGGLES BETWEEN    TREK AND IBM CHARACTER    FONTS.   Ctrl-P  SELECTS COLORS    RED-GREEN-YELLOW or    MAGENTA-CYAN-WHITE.  
1000:a3fe  LAB_1000_a3fe:
1000:a3fe      e8 2f a1                 CALL 0x1000:4530
1000:a401      e8 f7 b3                 CALL 0x1000:57fb
                ; inline script -> 1000:a408  <c3>
1000:a408  LAB_1000_a408:
1000:a408      f8                       CLC
1000:a409      c3                       RET
1000:a40a      e8 ee b3                 CALL 0x1000:57fb
                ; inline script -> 1000:a458  <c1><clear>  BASE VIEW   PLAYER'S ID, SCORE,   TOTAL ENERGY AND   NUMBER OF SHIPS
1000:a458  LAB_1000_a458:
1000:a458      c7 06 b5 39 b8 00        MOV word ptr [0x39b5],0xb8
1000:a45e      c7 06 b7 39 1e 00        MOV word ptr [0x39b7],0x1e
1000:a464      c6 06 d4 89 50           MOV byte ptr [0x89d4],0x50
1000:a469      e9 c2 00                 JMP 0x1000:a52e
1000:a46c      e8 8c b3                 CALL 0x1000:57fb
                ; inline script -> 1000:a4b6  <c1><clear>  GAME TIMER-LONG GAME   HOURS:MINS:SECS   SINCE BEGINNING OF GAME
1000:a4b6  LAB_1000_a4b6:
1000:a4b6      c6 06 b1 39 02           MOV byte ptr [0x39b1],0x2
1000:a4bb      c7 06 b5 39 d4 00        MOV word ptr [0x39b5],0xd4
1000:a4c1      c7 06 b7 39 be 00        MOV word ptr [0x39b7],0xbe
1000:a4c7      eb 65                    JMP 0x1000:a52e
1000:a4ca      e8 2e b3                 CALL 0x1000:57fb
                ; inline script -> 1000:a50e  <c1><clear>  GAME TIMER-TIMED GAME   MINS:SECS   LEFT UNTIL END OF GAME
1000:a50e  LAB_1000_a50e:
1000:a50e      c6 06 b1 39 03           MOV byte ptr [0x39b1],0x3
1000:a513      c7 06 b5 39 e0 00        MOV word ptr [0x39b5],0xe0
1000:a519      c7 06 b7 39 be 00        MOV word ptr [0x39b7],0xbe
1000:a51f      80 3e 07 a2 00           CMP byte ptr [0xa207],0x0
1000:a524      75 05                    JNZ 0x1000:a52b
1000:a526      c6 06 07 a2 1e           MOV byte ptr [0xa207],0x1e
1000:a52b  LAB_1000_a52b:
1000:a52b      eb 01                    JMP 0x1000:a52e
1000:a52e  LAB_1000_a52e:
1000:a52e      e8 ff 9f                 CALL 0x1000:4530
1000:a531      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
1000:a536      75 06                    JNZ 0x1000:a53e
1000:a538      bb b2 39                 MOV BX,0x39b2
1000:a53b      e8 ce b2                 CALL 0x1000:580c
1000:a53e  LAB_1000_a53e:
1000:a53e      e8 ba b2                 CALL 0x1000:57fb
                ; inline script -> 1000:a545  <c3>
1000:a545  LAB_1000_a545:
1000:a545      f8                       CLC
1000:a546      c3                       RET
1000:a547      c6 06 72 a2 01           MOV byte ptr [0xa272],0x1
1000:a54c      e8 ac b2                 CALL 0x1000:57fb
                ; inline script -> 1000:a727  <c1><clear>      THAT CONCLUDES THE INSTRUCTIONS.    NEXT TIME THE GAME STARTS, HIT Esc KEY  TO RETURN TO THE PRIMARY MENU FROM ANY  POINT IN THE INSTRUCTIONS. 
1000:a727  LAB_1000_a727:
1000:a727      f8                       CLC
1000:a728      c3                       RET

; ------------------------------------------------------------
1000:a800  FUN_1000_a800:
1000:a800      be c1 39                 MOV SI,0x39c1
1000:a803      ba 21 00                 MOV DX,0x21
1000:a806      b8 00 b8                 MOV AX,0xb800
1000:a809      8e c0                    MOV ES,AX
1000:a80b      bf d0 03                 MOV DI,0x3d0
1000:a80e  LAB_1000_a80e:
1000:a80e      b9 50 00                 MOV CX,0x50
1000:a811      2b ca                    SUB CX,DX
1000:a813      f3 a4                    MOVSB.REP ES:DI,SI
1000:a815      03 fa                    ADD DI,DX
1000:a817      83 ef 50                 SUB DI,0x50
1000:a81a      81 c7 00 20              ADD DI,0x2000
1000:a81e      b9 50 00                 MOV CX,0x50
1000:a821      2b ca                    SUB CX,DX
1000:a823      f3 a4                    MOVSB.REP ES:DI,SI
1000:a825      03 fa                    ADD DI,DX
1000:a827      81 ef 00 20              SUB DI,0x2000
1000:a82b      81 fe 1d 4c              CMP SI,0x4c1d
1000:a82f      72 dd                    JC 0x1000:a80e
1000:a831      c6 06 d0 89 67           MOV byte ptr [0x89d0],0x67
1000:a836      b9 bc 02                 MOV CX,0x2bc
1000:a839  LAB_1000_a839:
1000:a839      e8 3e 9b                 CALL 0x1000:437a
1000:a83c      8b f8                    MOV DI,AX
1000:a83e      81 e7 ff 3f              AND DI,0x3fff
1000:a842      51                       PUSH CX
1000:a843      b1 05                    MOV CL,0x5
1000:a845      d2 ec                    SHR AH,CL
1000:a847      80 e4 06                 AND AH,0x6
1000:a84a      8a cc                    MOV CL,AH
1000:a84c      b0 03                    MOV AL,0x3
1000:a84e      d2 e0                    SHL AL,CL
1000:a850      26 8a 25                 MOV AH,byte ptr ES:[DI]
1000:a853      f6 c4 aa                 TEST AH,0xaa
1000:a856      75 05                    JNZ 0x1000:a85d
1000:a858      24 11                    AND AL,0x11
1000:a85a      26 30 05                 XOR byte ptr ES:[DI],AL
1000:a85d  LAB_1000_a85d:
1000:a85d      e8 14 00                 CALL 0x1000:a874
1000:a860      59                       POP CX
1000:a861      51                       PUSH CX
1000:a862      81 f9 26 02              CMP CX,0x226
1000:a866      77 03                    JA 0x1000:a86b
1000:a868      e8 da 62                 CALL 0x1000:0b45
1000:a86b  LAB_1000_a86b:
1000:a86b      b9 50 00                 MOV CX,0x50
1000:a86e  LAB_1000_a86e:
1000:a86e      e2 fe                    LOOP 0x1000:a86e
1000:a870      59                       POP CX
1000:a871      e2 c6                    LOOP 0x1000:a839
1000:a873      c3                       RET

; ------------------------------------------------------------
1000:a874  FUN_1000_a874:
1000:a874      bf 8a 16                 MOV DI,0x168a
1000:a877      bb d5 a8                 MOV BX,0xa8d5
1000:a87a      e8 1c 00                 CALL 0x1000:a899
1000:a87d      bf 08 19                 MOV DI,0x1908
1000:a880      bb f9 a8                 MOV BX,0xa8f9
1000:a883      e8 13 00                 CALL 0x1000:a899
1000:a886      bf 95 1b                 MOV DI,0x1b95
1000:a889      bb 20 a9                 MOV BX,0xa920
1000:a88c      e8 0a 00                 CALL 0x1000:a899
1000:a88f      bf 07 1e                 MOV DI,0x1e07
1000:a892      bb 3a a9                 MOV BX,0xa93a
1000:a895      e8 01 00                 CALL 0x1000:a899
1000:a898      c3                       RET

; ------------------------------------------------------------
1000:a899  FUN_1000_a899:
1000:a899      c6 06 64 a2 01           MOV byte ptr [0xa264],0x1
1000:a89e  LAB_1000_a89e:
1000:a89e      2e 8a 07                 MOV AL,byte ptr CS:[BX]
1000:a8a1      e8 c8 b0                 CALL 0x1000:596c
1000:a8a4      43                       INC BX
1000:a8a5      22 c0                    AND AL,AL
1000:a8a7      74 27                    JZ 0x1000:a8d0
1000:a8a9      3c 04                    CMP AL,0x4
1000:a8ab      72 f1                    JC 0x1000:a89e
1000:a8ad      57                       PUSH DI
1000:a8ae      8b 36 16 00              MOV SI,word ptr [0x16]
1000:a8b2      b9 04 00                 MOV CX,0x4
1000:a8b5      32 e4                    XOR AH,AH
1000:a8b7      d3 e0                    SHL AX,CL
1000:a8b9      03 f0                    ADD SI,AX
1000:a8bb  LAB_1000_a8bb:
1000:a8bb      ad                       LODSW SI
1000:a8bc      26 89 05                 MOV word ptr ES:[DI],AX
1000:a8bf      ad                       LODSW SI
1000:a8c0      26 89 85 00 20           MOV word ptr ES:[DI + 0x2000],AX
1000:a8c5      83 c7 50                 ADD DI,0x50
1000:a8c8      e2 f1                    LOOP 0x1000:a8bb
1000:a8ca      5f                       POP DI
1000:a8cb      83 c7 02                 ADD DI,0x2
1000:a8ce      eb ce                    JMP 0x1000:a89e
1000:a8d0  LAB_1000_a8d0:
1000:a8d0      c3                       RET

; ------------------------------------------------------------
1000:a93e  FUN_1000_a93e:
1000:a93e      e8 ba ae                 CALL 0x1000:57fb
                ; inline script -> 1000:ac29  <c3><clear>           TREK 2.8   AUGUST 1,1987<c1>       A LIMITED LICENSE IS GRANTED TO ALL  USERS OF THIS PROGRAM TO MAKE COPIES OR  DISTRIBUTE ELECTRONICALLY
1000:ac29  LAB_1000_ac29:
1000:ac29      c7 06 55 a2 48 00        MOV word ptr [0xa255],0x48
1000:ac2f  LAB_1000_ac2f:
1000:ac2f      83 3e 55 a2 00           CMP word ptr [0xa255],0x0
1000:ac34      75 f9                    JNZ 0x1000:ac2f
1000:ac36      c3                       RET

; ------------------------------------------------------------
1000:ac37  FUN_1000_ac37:
1000:ac37      be 00 a8                 MOV SI,0xa800
1000:ac3a      b9 33 02                 MOV CX,0x233
1000:ac3d      2b c0                    SUB AX,AX
1000:ac3f  LAB_1000_ac3f:
1000:ac3f      2e 2b 04                 SUB AX,word ptr CS:[SI]
1000:ac42      83 c6 02                 ADD SI,0x2
1000:ac45      e2 f8                    LOOP 0x1000:ac3f
1000:ac47      23 c0                    AND AX,AX
1000:ac49      75 02                    JNZ 0x1000:ac4d
1000:ac4b      c3                       RET
1000:ac4d  LAB_1000_ac4d:
1000:ac4d      fa                       CLI
1000:ac4e      33 c0                    XOR AX,AX
1000:ac50      50                       PUSH AX
1000:ac51      48                       DEC AX
1000:ac52      50                       PUSH AX
1000:ac53      40                       INC AX
1000:ac54      50                       PUSH AX
1000:ac55      cf                       IRET

; ------------------------------------------------------------
1000:ac56  FUN_1000_ac56:
1000:ac56      c7 06 57 a2 00 00        MOV word ptr [0xa257],0x0
1000:ac5c      fa                       CLI
1000:ac5d      a0 00 a2                 MOV AL,[0xa200]
1000:ac60      24 fd                    AND AL,0xfd
1000:ac62      e6 21                    OUT 0x21,AL
1000:ac64      fb                       STI
1000:ac65      c3                       RET

; ------------------------------------------------------------
1000:cfa0  FUN_1000_cfa0:
1000:cfa0      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:cfa3      00 28                    ADD byte ptr [BX + SI],CH
1000:cfa5      00 07                    ADD byte ptr [BX],AL
1000:cfa7      3f                       AAS
1000:cfa8      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:cfab      00 00                    ADD byte ptr [BX + SI],AL
1000:cfad      00 07                    ADD byte ptr [BX],AL
1000:cfaf      3f                       AAS
1000:cfb0      80 00 b5                 ADD byte ptr [BX + SI],0xb5
1000:cfb3      00 55 00                 ADD byte ptr [DI + 0x0],DL
1000:cfb6      57                       PUSH DI
1000:cfb7      3f                       AAS
1000:cfb8      80 00 bf                 ADD byte ptr [BX + SI],0xbf
1000:cfbb      00 ff                    ADD BH,BH
1000:cfbd      00 ff                    ADD BH,BH
1000:cfbf      3f                       AAS
1000:cfc0      80 00 aa                 ADD byte ptr [BX + SI],0xaa
1000:cfc3      00 aa 00 aa              ADD byte ptr [BP + SI + 0xaa00],CH
1000:cfc7      3f                       AAS
1000:cfc8      80 0d 0d                 OR byte ptr [DI],0xd
1000:cfcb      00 aa 00 aa              ADD byte ptr [BP + SI + 0xaa00],CH
1000:cfcf      00 aa 3f 80              ADD byte ptr [BP + SI + 0x803f],CH
1000:cfd3      00 bf 00 ff              ADD byte ptr [BX + 0xff00],BH
1000:cfd7      00 ff                    ADD BH,BH
1000:cfd9      3f                       AAS
1000:cfda      80 00 b5                 ADD byte ptr [BX + SI],0xb5
1000:cfdd      00 55 00                 ADD byte ptr [DI + 0x0],DL
1000:cfe0      57                       PUSH DI
1000:cfe1      3f                       AAS
1000:cfe2      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:cfe5      00 00                    ADD byte ptr [BX + SI],AL
1000:cfe7      00 07                    ADD byte ptr [BX],AL
1000:cfe9      3f                       AAS
1000:cfea      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:cfed      00 2a                    ADD byte ptr [BP + SI],CH
1000:cfef      00 07                    ADD byte ptr [BX],AL
1000:cff1      3f                       AAS
1000:cff2      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:cff5      00 20                    ADD byte ptr [BX + SI],AH
1000:cff7      00 07                    ADD byte ptr [BX],AL
1000:cff9      3f                       AAS
1000:cffa      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:cffd      00 20                    ADD byte ptr [BX + SI],AH
1000:cfff      00 07                    ADD byte ptr [BX],AL
1000:d001      3f                       AAS
1000:d002      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:d005      00 20                    ADD byte ptr [BX + SI],AH
1000:d007      00 07                    ADD byte ptr [BX],AL
1000:d009      3f                       AAS
1000:d00a      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:d00d      00 2a                    ADD byte ptr [BP + SI],CH
1000:d00f      00 07                    ADD byte ptr [BX],AL
1000:d011      3f                       AAS
1000:d012      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:d015      00 00                    ADD byte ptr [BX + SI],AL
1000:d017      00 07                    ADD byte ptr [BX],AL
1000:d019      3f                       AAS
1000:d01a      80 00 b5                 ADD byte ptr [BX + SI],0xb5
1000:d01d      00 55 00                 ADD byte ptr [DI + 0x0],DL
1000:d020      57                       PUSH DI
1000:d021      3f                       AAS
1000:d022      80 00 bf                 ADD byte ptr [BX + SI],0xbf
1000:d025      00 ff                    ADD BH,BH
1000:d027      00 ff                    ADD BH,BH
1000:d029      3f                       AAS
1000:d02a      80 00 aa                 ADD byte ptr [BX + SI],0xaa
1000:d02d      00 aa 00 aa              ADD byte ptr [BP + SI + 0xaa00],CH
1000:d031      3f                       AAS
1000:d032      80 0d 0d                 OR byte ptr [DI],0xd
1000:d035      00 aa 00 aa              ADD byte ptr [BP + SI + 0xaa00],CH
1000:d039      00 aa 3f 80              ADD byte ptr [BP + SI + 0x803f],CH
1000:d03d      00 bf 00 ff              ADD byte ptr [BX + 0xff00],BH
1000:d041      00 ff                    ADD BH,BH
1000:d043      3f                       AAS
1000:d044      80 00 b5                 ADD byte ptr [BX + SI],0xb5
1000:d047      00 55 00                 ADD byte ptr [DI + 0x0],DL
1000:d04a      57                       PUSH DI
1000:d04b      3f                       AAS
1000:d04c      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:d04f      00 00                    ADD byte ptr [BX + SI],AL
1000:d051      00 07                    ADD byte ptr [BX],AL
1000:d053      3f                       AAS
1000:d054      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:d057      00 28                    ADD byte ptr [BX + SI],CH
1000:d059      00 07                    ADD byte ptr [BX],AL
1000:d05b      3f                       AAS
1000:d05c      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:d05f      00 22                    ADD byte ptr [BP + SI],AH
1000:d061      00 07                    ADD byte ptr [BX],AL
1000:d063      3f                       AAS
1000:d064      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:d067      00 22                    ADD byte ptr [BP + SI],AH
1000:d069      00 07                    ADD byte ptr [BX],AL
1000:d06b      3f                       AAS
1000:d06c      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:d06f      00 22                    ADD byte ptr [BP + SI],AH
1000:d071      00 07                    ADD byte ptr [BX],AL
1000:d073      3f                       AAS
1000:d074      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:d077      00 28                    ADD byte ptr [BX + SI],CH
1000:d079      00 07                    ADD byte ptr [BX],AL
1000:d07b      3f                       AAS
1000:d07c      80 03 b4                 ADD byte ptr [BP + DI],0xb4
1000:d07f      00 00                    ADD byte ptr [BX + SI],AL
1000:d081      00 07                    ADD byte ptr [BX],AL
1000:d083      3f                       AAS
1000:d084      80 00 b5                 ADD byte ptr [BX + SI],0xb5
1000:d087      00 55 00                 ADD byte ptr [DI + 0x0],DL
1000:d08a      57                       PUSH DI
1000:d08b      3f                       AAS
1000:d08c      80 00 bf                 ADD byte ptr [BX + SI],0xbf
1000:d08f      00 ff                    ADD BH,BH
1000:d091      00 ff                    ADD BH,BH
1000:d093      3f                       AAS
1000:d094      80 00 aa                 ADD byte ptr [BX + SI],0xaa
1000:d097      00 aa 00 aa              ADD byte ptr [BP + SI + 0xaa00],CH
1000:d09b      3f                       AAS
1000:d09c      80 09 09                 OR byte ptr [BX + DI],0x9
1000:d09f      00 00                    ADD byte ptr [BX + SI],AL
1000:d0a1      00 c0                    ADD AL,AL
1000:d0a3      3f                       AAS
1000:d0a4      00 00                    ADD byte ptr [BX + SI],AL
1000:d0a6      00 00                    ADD byte ptr [BX + SI],AL
1000:d0a8      30 3f                    XOR byte ptr [BX],BH
1000:d0aa      00 00                    ADD byte ptr [BX + SI],AL
1000:d0ac      00 00                    ADD byte ptr [BX + SI],AL
1000:d0ae      30 3f                    XOR byte ptr [BX],BH
1000:d0b0      00 00                    ADD byte ptr [BX + SI],AL
1000:d0b2      3c 00                    CMP AL,0x0
1000:d0b4      c0 3f 00                 SAR byte ptr [BX],0x0
1000:d0b7      00 c3                    ADD BL,AL
1000:d0b9      00 f0                    ADD AL,DH
1000:d0bb      3f                       AAS
1000:d0bc      c0 00 00                 ROL byte ptr [BX + SI],0x0
1000:d0bf      00 cf                    ADD BH,CL
1000:d0c1      3f                       AAS
1000:d0c2      00 00                    ADD byte ptr [BX + SI],AL
1000:d0c4      03 00                    ADD AX,word ptr [BX + SI]
1000:d0c6      00 3f                    ADD byte ptr [BX],BH
1000:d0c8      00 00                    ADD byte ptr [BX + SI],AL
1000:d0ca      03 00                    ADD AX,word ptr [BX + SI]
1000:d0cc      00 3f                    ADD byte ptr [BX],BH
1000:d0ce      00 00                    ADD byte ptr [BX + SI],AL
1000:d0d0      00 00                    ADD byte ptr [BX + SI],AL
1000:d0d2      c0 3f 00                 SAR byte ptr [BX],0x0
1000:d0d5      03 03                    ADD AX,word ptr [BP + DI]
1000:d0d7      cf                       IRET
