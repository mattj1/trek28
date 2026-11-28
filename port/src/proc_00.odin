package trek

// Procedures 1000:0018 through 1000:0f85.
// 1000:0dbd through 1000:0f5c, and 1000:11eb, are in draw.odin.
// The assembly is the listing. The body is empty until the procedure is translated.
// A notes line is a name already supported by the annotation notes.

// @proc 1000:0018
// listing: start
// status: unread
// 1000:0018  start:
// 1000:0018      2e 8c 1e 04 00           MOV word ptr CS:[0x4],DS
// 1000:001d      2e c7 06 02 00 00 00     MOV word ptr CS:[0x2],0x0
// 1000:0024      8b 2e 02 00              MOV BP,word ptr [0x2]
// 1000:0028      b8 c7 0a                 MOV AX,0xac7
// 1000:002b      8c cb                    MOV BX,CS
// 1000:002d      03 c3                    ADD AX,BX
// 1000:002f      2e a3 00 00              MOV CS:[0x0],AX
// 1000:0033      8e d8                    MOV DS,AX
// 1000:0035      b8 32 15                 MOV AX,0x1532
// 1000:0038      03 c3                    ADD AX,BX
// 1000:003a      8e d0                    MOV SS,AX
// 1000:003c      bc 00 02                 MOV SP,0x200
// 1000:003f      e8 d1 00                 CALL 0x1000:0113
// 1000:0042      8c cb                    MOV BX,CS
// 1000:0044      b1 04                    MOV CL,0x4
// 1000:0046      2e a1 10 00              MOV AX,CS:[0x10]
// 1000:004a      d3 e8                    SHR AX,CL
// 1000:004c      03 d8                    ADD BX,AX
// 1000:004e      8e c3                    MOV ES,BX
// 1000:0050      8c d0                    MOV AX,SS
// 1000:0052      2b c3                    SUB AX,BX
// 1000:0054      d3 e0                    SHL AX,CL
// 1000:0056      8b c8                    MOV CX,AX
// 1000:0058      32 c0                    XOR AL,AL
// 1000:005a      33 ff                    XOR DI,DI
// 1000:005c      f3 aa                    STOSB.REP ES:DI
// 1000:005e      fa                       CLI
// 1000:005f      8b cc                    MOV CX,SP
// 1000:0061      f3 aa                    STOSB.REP ES:DI
// 1000:0063      e4 21                    IN AL,0x21
// 1000:0065      89 26 43 a3              MOV word ptr [0xa343],SP
// 1000:0069      a2 00 a2                 MOV [0xa200],AL
// 1000:006c      b8 00 00                 MOV AX,0x0
// 1000:006f      8e c0                    MOV ES,AX
// 1000:0071      b8 20 68                 MOV AX,0x6820
// 1000:0074      26 87 06 70 00           XCHG word ptr ES:[0x70],AX
// 1000:0079      a3 7a a2                 MOV [0xa27a],AX
// 1000:007c      8c c8                    MOV AX,CS
// 1000:007e      26 87 06 72 00           XCHG word ptr ES:[0x72],AX
// 1000:0083      a3 7c a2                 MOV [0xa27c],AX
// 1000:0086      b8 e3 5f                 MOV AX,0x5fe3
// 1000:0089      26 a3 04 00              MOV ES:[0x4],AX
// 1000:008d      26 8c 0e 06 00           MOV word ptr ES:[0x6],CS
// 1000:0092      b8 4b 68                 MOV AX,0x684b
// 1000:0095      26 a3 0c 00              MOV ES:[0xc],AX
// 1000:0099      26 8c 0e 0e 00           MOV word ptr ES:[0xe],CS
// 1000:009e      fb                       STI
// 1000:009f      2e 8e 06 00 00           MOV ES,word ptr CS:[0x0]
// 1000:00a4      b8 04 00                 MOV AX,0x4
// 1000:00a7      cd 10                    INT 0x10
// 1000:00a9      e8 03 0b                 CALL 0x1000:0baf
// 1000:00ac      c7 06 a5 00 b5 00        MOV word ptr [0xa5],0xb5
// 1000:00b2      e8 4b a7                 CALL 0x1000:a800
// 1000:00b5      8b 26 43 a3              MOV SP,word ptr [0xa343]
// 1000:00b9      8c d8                    MOV AX,DS
// 1000:00bb      8e c0                    MOV ES,AX
// 1000:00bd      bf d0 89                 MOV DI,0x89d0
// 1000:00c0      8b 0e d1 00              MOV CX,word ptr [0xd1]
// 1000:00c4      32 c0                    XOR AL,AL
// 1000:00c6      f3 aa                    STOSB.REP ES:DI
// 1000:00c8      c7 06 a5 00 d1 00        MOV word ptr [0xa5],0xd1
// 1000:00ce      e8 6d a8                 CALL 0x1000:a93e
// 1000:00d1      8b 26 43 a3              MOV SP,word ptr [0xa343]
// 1000:00d5      bf d0 89                 MOV DI,0x89d0
// 1000:00d8      8b 0e d1 00              MOV CX,word ptr [0xd1]
// 1000:00dc      32 c0                    XOR AL,AL
// 1000:00de      f3 aa                    STOSB.REP ES:DI
// 1000:00e0      b4 00                    MOV AH,0x0
// 1000:00e2      cd 1a                    INT 0x1a
// 1000:00e4      86 d6                    XCHG DH,DL
// 1000:00e6      89 16 d0 89              MOV word ptr [0x89d0],DX
// 1000:00ea      c6 06 70 a2 07           MOV byte ptr [0xa270],0x7
// 1000:00ef      e8 93 04                 CALL 0x1000:0585
// 1000:00f2      c6 06 67 a2 00           MOV byte ptr [0xa267],0x0
// 1000:00f7      c7 06 a5 00 66 01        MOV word ptr [0xa5],0x166
// 1000:00fd      b9 d0 07                 MOV CX,0x7d0
// 1000:0100  LAB_1000_0100:
// 1000:0100      51                       PUSH CX
// 1000:0101      b9 96 19                 MOV CX,0x1996
// 1000:0104  LAB_1000_0104:
// 1000:0104      e2 fe                    LOOP 0x1000:0104
// 1000:0106      ff 06 d0 89              INC word ptr [0x89d0]
// 1000:010a      e8 38 0a                 CALL 0x1000:0b45
// 1000:010d      59                       POP CX
// 1000:010e      e2 f0                    LOOP 0x1000:0100
// 1000:0110      eb 54                    JMP 0x1000:0166
fun_0018 :: proc() {
}

// @proc 1000:0113
// listing: FUN_1000_0113
// notes: check_dos_and_memory
// status: unread
// 1000:0113  FUN_1000_0113:
// 1000:0113      8c d0                    MOV AX,SS
// 1000:0115      05 32 00                 ADD AX,0x32
// 1000:0118      3b c5                    CMP AX,BP
// 1000:011a      72 06                    JC 0x1000:0122
// 1000:011c      be 40 00                 MOV SI,0x40
// 1000:011f      eb 2a                    JMP 0x1000:014b
// 1000:0122  LAB_1000_0122:
// 1000:0122      b4 30                    MOV AH,0x30
// 1000:0124      cd 21                    INT 0x21
// 1000:0126      86 c4                    XCHG AH,AL
// 1000:0128      3d 00 02                 CMP AX,0x200
// 1000:012b      73 06                    JNC 0x1000:0133
// 1000:012d      be 22 00                 MOV SI,0x22
// 1000:0130      eb 19                    JMP 0x1000:014b
// 1000:0133  LAB_1000_0133:
// 1000:0133      b4 00                    MOV AH,0x0
// 1000:0135      cd 11                    INT 0x11
// 1000:0137      25 30 00                 AND AX,0x30
// 1000:013a      3d 30 00                 CMP AX,0x30
// 1000:013d      75 0b                    JNZ 0x1000:014a
// 1000:013f      b8 40 00                 MOV AX,0x40
// 1000:0142      8e c0                    MOV ES,AX
// 1000:0144      26 80 26 10 00 ef        AND byte ptr ES:[0x10],0xef
// 1000:014a  LAB_1000_014a:
// 1000:014a      c3                       RET
// 1000:014b  LAB_1000_014b:
// 1000:014b      e8 0a 00                 CALL 0x1000:0158
// 1000:014e      2e 8e 1e 04 00           MOV DS,word ptr CS:[0x4]
// 1000:0153      2e ff 2e 02 00           JMPF CS:[0x2]
fun_0113 :: proc() {
}

// @proc 1000:0158
// listing: FUN_1000_0158
// notes: puts_dos
// status: unread
// 1000:0158  FUN_1000_0158:
// 1000:0158      ac                       LODSB SI
// 1000:0159      3c 00                    CMP AL,0x0
// 1000:015b      74 08                    JZ 0x1000:0165
// 1000:015d      b4 02                    MOV AH,0x2
// 1000:015f      8a d0                    MOV DL,AL
// 1000:0161      cd 21                    INT 0x21
// 1000:0163      eb f3                    JMP 0x1000:0158
// 1000:0165  LAB_1000_0165:
// 1000:0165      c3                       RET
fun_0158 :: proc() {
}

// @proc 1000:0166
// listing: FUN_1000_0166
// notes: primary_menu
// status: unread
// 1000:0166  FUN_1000_0166:
// 1000:0166      c7 06 09 a2 00 00        MOV word ptr [0xa209],0x0
// 1000:016c      8b 26 43 a3              MOV SP,word ptr [0xa343]
// 1000:0170      b0 ff                    MOV AL,0xff
// 1000:0172      e6 21                    OUT 0x21,AL
// 1000:0174      e8 05 0b                 CALL 0x1000:0c7c
// 1000:0177      e8 06 68                 CALL 0x1000:6980
// 1000:017a      c6 06 71 a2 00           MOV byte ptr [0xa271],0x0
// 1000:017f      e8 11 02                 CALL 0x1000:0393
// 1000:0182      e8 76 56                 CALL 0x1000:57fb
//                 ; inline script -> 1000:01af  <c3><clear>      PRIMARY MENU    <c1>  INSTRUCTIONS
// 1000:01af  LAB_1000_01af:
// 1000:01af      80 3e 72 a2 01           CMP byte ptr [0xa272],0x1
// 1000:01b4      74 19                    JZ 0x1000:01cf
// 1000:01b6      e8 42 56                 CALL 0x1000:57fb
//                 ; inline script -> 1000:01cf  <c2>(REQUIRED READING)
// 1000:01cf  LAB_1000_01cf:
// 1000:01cf      e8 29 56                 CALL 0x1000:57fb
//                 ; inline script -> 1000:01f0  <c1>     DISPLAY STATISTICS   
// 1000:01f0  LAB_1000_01f0:
// 1000:01f0      80 3e 07 00 20           CMP byte ptr [0x7],0x20
// 1000:01f5      75 20                    JNZ 0x1000:0217
// 1000:01f7      e8 01 56                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0214  <c1>  ENTER YOUR INITIALS 
// 1000:0214  LAB_1000_0214:
// 1000:0214      eb 2b                    JMP 0x1000:0241
// 1000:0217  LAB_1000_0217:
// 1000:0217      e8 e1 55                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0236  <c1>  CHANGE YOUR INITIALS (
// 1000:0236  LAB_1000_0236:
// 1000:0236      e8 29 03                 CALL 0x1000:0562
// 1000:0239      e8 bf 55                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0241  <c1>)
// 1000:0241  LAB_1000_0241:
// 1000:0241      e8 b7 55                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0259  <c1>     SETUP GAME (
// 1000:0259  LAB_1000_0259:
// 1000:0259      80 3e 0a 00 01           CMP byte ptr [0xa],0x1
// 1000:025e      75 4a                    JNZ 0x1000:02aa
// 1000:0260      e8 98 55                 CALL 0x1000:57fb
//                 ; inline script -> 1000:026e  <c1>1 Plyr,
// 1000:026e  LAB_1000_026e:
// 1000:026e      a0 0f 00                 MOV AL,[0xf]
// 1000:0271      e8 7b 05                 CALL 0x1000:07ef
// 1000:0274      b0 2c                    MOV AL,0x2c
// 1000:0276      e8 fe 52                 CALL 0x1000:5577
// 1000:0279      a0 13 00                 MOV AL,[0x13]
// 1000:027c      22 c0                    AND AL,AL
// 1000:027e      75 12                    JNZ 0x1000:0292
// 1000:0280      e8 78 55                 CALL 0x1000:57fb
//                 ; inline script -> 1000:028f  <c1>1 Enemy)
// 1000:028f  LAB_1000_028f:
// 1000:028f      eb 62                    JMP 0x1000:02f3
// 1000:0292  LAB_1000_0292:
// 1000:0292      04 31                    ADD AL,0x31
// 1000:0294      e8 e0 52                 CALL 0x1000:5577
// 1000:0297      e8 61 55                 CALL 0x1000:57fb
//                 ; inline script -> 1000:02a7  <c1> Enemies)
// 1000:02a7  LAB_1000_02a7:
// 1000:02a7      eb 4a                    JMP 0x1000:02f3
// 1000:02aa  LAB_1000_02aa:
// 1000:02aa      e8 4e 55                 CALL 0x1000:57fb
//                 ; inline script -> 1000:02b8  <c1>2 Plyr,
// 1000:02b8  LAB_1000_02b8:
// 1000:02b8      e8 af 09                 CALL 0x1000:0c6a
// 1000:02bb      e8 3d 55                 CALL 0x1000:57fb
//                 ; inline script -> 1000:02cb  <c1> BAUD,COM
// 1000:02cb  LAB_1000_02cb:
// 1000:02cb      a0 0c 00                 MOV AL,[0xc]
// 1000:02ce      04 31                    ADD AL,0x31
// 1000:02d0      e8 a4 52                 CALL 0x1000:5577
// 1000:02d3      a0 0e 00                 MOV AL,[0xe]
// 1000:02d6      22 c0                    AND AL,AL
// 1000:02d8      75 0e                    JNZ 0x1000:02e8
// 1000:02da      e8 1e 55                 CALL 0x1000:57fb
//                 ; inline script -> 1000:02e5  <c1>,AC)
// 1000:02e5  LAB_1000_02e5:
// 1000:02e5      eb 0c                    JMP 0x1000:02f3
// 1000:02e8  LAB_1000_02e8:
// 1000:02e8      e8 10 55                 CALL 0x1000:57fb
//                 ; inline script -> 1000:02f3  <c1>,SM)
// 1000:02f3  LAB_1000_02f3:
// 1000:02f3      e8 05 55                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0346  <c1>     ENTER TERMINAL MODE     PLAY GAME     SAVE DEFAULTS TO DISK     QUIT   
// 1000:0346  LAB_1000_0346:
// 1000:0346      bb 8e 00                 MOV BX,0x8e
// 1000:0349      e8 c0 54                 CALL 0x1000:580c
// 1000:034c      32 c0                    XOR AL,AL
// 1000:034e      e8 9d 08                 CALL 0x1000:0bee
// 1000:0351  LAB_1000_0351:
// 1000:0351      ff 06 d0 89              INC word ptr [0x89d0]
// 1000:0355      e8 ed 07                 CALL 0x1000:0b45
// 1000:0358      74 f7                    JZ 0x1000:0351
// 1000:035a      3c 06                    CMP AL,0x6
// 1000:035c      74 32                    JZ 0x1000:0390
// 1000:035e      e8 a6 07                 CALL 0x1000:0b07
// 1000:0361      75 07                    JNZ 0x1000:036a
// 1000:0363      fe 06 67 a2              INC byte ptr [0xa267]
// 1000:0367      e9 fc fd                 JMP 0x1000:0166
// 1000:036a  LAB_1000_036a:
// 1000:036a      e8 a1 07                 CALL 0x1000:0b0e
// 1000:036d      75 04                    JNZ 0x1000:0373
// 1000:036f      fe 0e 67 a2              DEC byte ptr [0xa267]
// 1000:0373  LAB_1000_0373:
// 1000:0373      3c 0d                    CMP AL,0xd
// 1000:0375      75 19                    JNZ 0x1000:0390
// 1000:0377      80 3e 72 a2 01           CMP byte ptr [0xa272],0x1
// 1000:037c      74 0e                    JZ 0x1000:038c
// 1000:037e      81 3e 41 a3 96 04        CMP word ptr [0xa341],0x496
// 1000:0384      74 06                    JZ 0x1000:038c
// 1000:0386      c7 06 41 a3 60 6d        MOV word ptr [0xa341],0x6d60
// 1000:038c  LAB_1000_038c:
// 1000:038c      ff 26 41 a3              JMP word ptr [0xa341]
// 1000:0390  LAB_1000_0390:
// 1000:0390      e9 d3 fd                 JMP 0x1000:0166
fun_0166 :: proc() {
}

// @proc 1000:0393
// listing: FUN_1000_0393
// notes: menu_row_from_index
// status: unread
// 1000:0393  FUN_1000_0393:
// 1000:0393      80 3e 67 a2 08           CMP byte ptr [0xa267],0x8
// 1000:0398      72 0f                    JC 0x1000:03a9
// 1000:039a      75 08                    JNZ 0x1000:03a4
// 1000:039c      c6 06 67 a2 00           MOV byte ptr [0xa267],0x0
// 1000:03a1      eb 06                    JMP 0x1000:03a9
// 1000:03a4  LAB_1000_03a4:
// 1000:03a4      c6 06 67 a2 07           MOV byte ptr [0xa267],0x7
// 1000:03a9  LAB_1000_03a9:
// 1000:03a9      a0 67 a2                 MOV AL,[0xa267]
// 1000:03ac      b4 06                    MOV AH,0x6
// 1000:03ae      f6 e4                    MUL AH
// 1000:03b0      be ca 03                 MOV SI,0x3ca
// 1000:03b3      03 f0                    ADD SI,AX
// 1000:03b5      2e 8b 04                 MOV AX,word ptr CS:[SI]
// 1000:03b8      a3 91 00                 MOV [0x91],AX
// 1000:03bb      2e 8b 44 02              MOV AX,word ptr CS:[SI + 0x2]
// 1000:03bf      a3 93 00                 MOV [0x93],AX
// 1000:03c2      2e 8b 44 04              MOV AX,word ptr CS:[SI + 0x4]
// 1000:03c6      a3 41 a3                 MOV [0xa341],AX
// 1000:03c9      c3                       RET
// 1000:03fa      e8 fe 53                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0425  <c3><box> ** SAVING DEFAULTS TO DISK ** 
// 1000:0425  LAB_1000_0425:
// 1000:0425      e9 64 68                 JMP 0x1000:6c8c
// 1000:0428      e8 d0 53                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0489  <c3><clear>     READY TO ABORT TREK.   HIT Esc TO CONTINUE PLAYING or  HIT ANY OTHER KEY TO REBOOT  
// 1000:0489  LAB_1000_0489:
// 1000:0489      e8 b9 06                 CALL 0x1000:0b45
// 1000:048c      74 fb                    JZ 0x1000:0489
// 1000:048e      c6 06 6e a2 01           MOV byte ptr [0xa26e],0x1
// 1000:0493      eb 0b                    JMP 0x1000:04a0
fun_0393 :: proc() {
}

// @proc 1000:0496
// listing: FUN_1000_0496
// notes: quit_to_dos
// status: unread
// 1000:0496  FUN_1000_0496:
// 1000:0496      2e 8e 1e 00 00           MOV DS,word ptr CS:[0x0]
// 1000:049b      c6 06 6e a2 00           MOV byte ptr [0xa26e],0x0
// 1000:04a0  LAB_1000_04a0:
// 1000:04a0      e8 dc 59                 CALL 0x1000:5e7f
// 1000:04a3      b8 00 00                 MOV AX,0x0
// 1000:04a6      8e c0                    MOV ES,AX
// 1000:04a8      a1 7a a2                 MOV AX,[0xa27a]
// 1000:04ab      26 a3 70 00              MOV ES:[0x70],AX
// 1000:04af      a1 7c a2                 MOV AX,[0xa27c]
// 1000:04b2      26 a3 72 00              MOV ES:[0x72],AX
// 1000:04b6      2e a1 00 00              MOV AX,CS:[0x0]
// 1000:04ba      8e d8                    MOV DS,AX
// 1000:04bc      8e c0                    MOV ES,AX
// 1000:04be      b8 03 00                 MOV AX,0x3
// 1000:04c1      cd 10                    INT 0x10
// 1000:04c3      2e 8e 1e 04 00           MOV DS,word ptr CS:[0x4]
// 1000:04c8      2e ff 2e 02 00           JMPF CS:[0x2]
fun_0496 :: proc() {
}

// @proc 1000:04cd
// listing: FUN_1000_04cd
// notes: edit_initials
// status: unread
// 1000:04cd  FUN_1000_04cd:
// 1000:04cd      be 07 00                 MOV SI,0x7
// 1000:04d0  LAB_1000_04d0:
// 1000:04d0      56                       PUSH SI
// 1000:04d1      e8 27 53                 CALL 0x1000:57fb
//                 ; inline script -> 1000:04ef  <c3><clear>CURRENT INITIALS ARE: 
// 1000:04ef  LAB_1000_04ef:
// 1000:04ef      e8 70 00                 CALL 0x1000:0562
// 1000:04f2      e8 06 53                 CALL 0x1000:57fb
//                 ; inline script -> 1000:051d  <c3>   Hit Esc to return to primary menu
// 1000:051d  LAB_1000_051d:
// 1000:051d      5e                       POP SI
// 1000:051e  LAB_1000_051e:
// 1000:051e      ff 06 d0 89              INC word ptr [0x89d0]
// 1000:0522      e8 20 06                 CALL 0x1000:0b45
// 1000:0525      74 f7                    JZ 0x1000:051e
// 1000:0527      3c 06                    CMP AL,0x6
// 1000:0529      74 a5                    JZ 0x1000:04d0
// 1000:052b      3c 0d                    CMP AL,0xd
// 1000:052d      74 30                    JZ 0x1000:055f
// 1000:052f      3c 08                    CMP AL,0x8
// 1000:0531      75 09                    JNZ 0x1000:053c
// 1000:0533      81 fe 07 00              CMP SI,0x7
// 1000:0537      74 e5                    JZ 0x1000:051e
// 1000:0539      4e                       DEC SI
// 1000:053a      eb e2                    JMP 0x1000:051e
// 1000:053c  LAB_1000_053c:
// 1000:053c      81 fe 07 00              CMP SI,0x7
// 1000:0540      74 04                    JZ 0x1000:0546
// 1000:0542      3c 20                    CMP AL,0x20
// 1000:0544      74 0a                    JZ 0x1000:0550
// 1000:0546  LAB_1000_0546:
// 1000:0546      24 df                    AND AL,0xdf
// 1000:0548      3c 41                    CMP AL,0x41
// 1000:054a      72 d2                    JC 0x1000:051e
// 1000:054c      3c 5a                    CMP AL,0x5a
// 1000:054e      77 ce                    JA 0x1000:051e
// 1000:0550  LAB_1000_0550:
// 1000:0550      88 04                    MOV byte ptr [SI],AL
// 1000:0552      46                       INC SI
// 1000:0553      81 fe 0a 00              CMP SI,0xa
// 1000:0557      72 03                    JC 0x1000:055c
// 1000:0559      e9 71 ff                 JMP 0x1000:04cd
// 1000:055c  LAB_1000_055c:
// 1000:055c      e9 71 ff                 JMP 0x1000:04d0
// 1000:055f  LAB_1000_055f:
// 1000:055f      e9 04 fc                 JMP 0x1000:0166
fun_04cd :: proc() {
}

// @proc 1000:0562
// listing: FUN_1000_0562
// notes: print_initials
// status: unread
// 1000:0562  FUN_1000_0562:
// 1000:0562      a0 07 00                 MOV AL,[0x7]
// 1000:0565      e8 0f 50                 CALL 0x1000:5577
// 1000:0568      a0 08 00                 MOV AL,[0x8]
// 1000:056b      e8 09 50                 CALL 0x1000:5577
// 1000:056e      a0 09 00                 MOV AL,[0x9]
// 1000:0571      e8 03 50                 CALL 0x1000:5577
// 1000:0574      c3                       RET
// 1000:0575      80 3e 07 00 20           CMP byte ptr [0x7],0x20
// 1000:057a      75 03                    JNZ 0x1000:057f
// 1000:057c      e9 4e ff                 JMP 0x1000:04cd
// 1000:057f  LAB_1000_057f:
// 1000:057f      e8 de 07                 CALL 0x1000:0d60
// 1000:0582      e9 ee 0e                 JMP 0x1000:1473
fun_0562 :: proc() {
}

// @proc 1000:0585
// listing: FUN_1000_0585
// notes: find_com_port
// status: unread
// 1000:0585  FUN_1000_0585:
// 1000:0585      06                       PUSH ES
// 1000:0586      33 c0                    XOR AX,AX
// 1000:0588      8e c0                    MOV ES,AX
// 1000:058a      b9 04 00                 MOV CX,0x4
// 1000:058d  LAB_1000_058d:
// 1000:058d      80 26 0c 00 03           AND byte ptr [0xc],0x3
// 1000:0592      8a 1e 0c 00              MOV BL,byte ptr [0xc]
// 1000:0596      32 ff                    XOR BH,BH
// 1000:0598      d1 e3                    SHL BX,0x1
// 1000:059a      26 8b 87 00 04           MOV AX,word ptr ES:[BX + 0x400]
// 1000:059f      3d 00 00                 CMP AX,0x0
// 1000:05a2      75 12                    JNZ 0x1000:05b6
// 1000:05a4      fe 06 0c 00              INC byte ptr [0xc]
// 1000:05a8      80 26 0c 00 03           AND byte ptr [0xc],0x3
// 1000:05ad      e2 de                    LOOP 0x1000:058d
// 1000:05af      07                       POP ES
// 1000:05b0      c6 06 0a 00 01           MOV byte ptr [0xa],0x1
// 1000:05b5      c3                       RET
// 1000:05b6  LAB_1000_05b6:
// 1000:05b6      07                       POP ES
// 1000:05b7      a3 a7 00                 MOV [0xa7],AX
// 1000:05ba      c6 06 03 00 01           MOV byte ptr [0x3],0x1
// 1000:05bf      c3                       RET
// 1000:05c0      c6 06 3e a3 00           MOV byte ptr [0xa33e],0x0
// 1000:05c5  LAB_1000_05c5:
// 1000:05c5      e8 bd ff                 CALL 0x1000:0585
// 1000:05c8      a0 3e a3                 MOV AL,[0xa33e]
// 1000:05cb      b4 06                    MOV AH,0x6
// 1000:05cd      f6 e4                    MUL AH
// 1000:05cf      be ca 03                 MOV SI,0x3ca
// 1000:05d2      03 f0                    ADD SI,AX
// 1000:05d4      2e 8b 04                 MOV AX,word ptr CS:[SI]
// 1000:05d7      a3 91 00                 MOV [0x91],AX
// 1000:05da      2e 8b 44 02              MOV AX,word ptr CS:[SI + 0x2]
// 1000:05de      a3 93 00                 MOV [0x93],AX
// 1000:05e1      e8 17 52                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0602  <c3><clear>          SETUP MENU    <c1>
// 1000:0602  LAB_1000_0602:
// 1000:0602      80 3e 0a 00 01           CMP byte ptr [0xa],0x1
// 1000:0607      74 03                    JZ 0x1000:060c
// 1000:0609      e9 bc 02                 JMP 0x1000:08c8
// 1000:060c  LAB_1000_060c:
// 1000:060c      e8 ec 51                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0641  <c1>  ONE PLAYER (PRACTICE MODE)     GAME MODE IS 
// 1000:0641  LAB_1000_0641:
// 1000:0641      e8 ec 01                 CALL 0x1000:0830
// 1000:0644      e8 b4 51                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0663  <c1>     PLAYER HANDICAP IS 
// 1000:0663  LAB_1000_0663:
// 1000:0663      a0 10 00                 MOV AL,[0x10]
// 1000:0666      e8 19 02                 CALL 0x1000:0882
// 1000:0669      e8 8f 51                 CALL 0x1000:57fb
//                 ; inline script -> 1000:068a  <c1>     COMPUTER HANDICAP IS 
// 1000:068a  LAB_1000_068a:
// 1000:068a      a0 11 00                 MOV AL,[0x11]
// 1000:068d      e8 f2 01                 CALL 0x1000:0882
// 1000:0690      e8 68 51                 CALL 0x1000:57fb
//                 ; inline script -> 1000:06ae  <c1>     COMPUTER SPEED IS 
// 1000:06ae  LAB_1000_06ae:
// 1000:06ae      a0 0f 00                 MOV AL,[0xf]
// 1000:06b1      e8 3b 01                 CALL 0x1000:07ef
// 1000:06b4      e8 44 51                 CALL 0x1000:57fb
//                 ; inline script -> 1000:06dc  <c1>     NUMBER OF COMPUTER BASES IS 
// 1000:06dc  LAB_1000_06dc:
// 1000:06dc      a0 13 00                 MOV AL,[0x13]
// 1000:06df      04 31                    ADD AL,0x31
// 1000:06e1      e8 93 4e                 CALL 0x1000:5577
// 1000:06e4      e8 14 51                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0701  <c1>     PLAYING SPEED IS 
// 1000:0701  LAB_1000_0701:
// 1000:0701      a0 0d 00                 MOV AL,[0xd]
// 1000:0704      e8 e8 00                 CALL 0x1000:07ef
// 1000:0707      bb 8e 00                 MOV BX,0x8e
// 1000:070a      e8 ff 50                 CALL 0x1000:580c
// 1000:070d      e8 ae 04                 CALL 0x1000:0bbe
// 1000:0710  LAB_1000_0710:
// 1000:0710      ff 06 d0 89              INC word ptr [0x89d0]
// 1000:0714      e8 2e 04                 CALL 0x1000:0b45
// 1000:0717      74 f7                    JZ 0x1000:0710
// 1000:0719      3c 06                    CMP AL,0x6
// 1000:071b      74 15                    JZ 0x1000:0732
// 1000:071d      e8 e7 03                 CALL 0x1000:0b07
// 1000:0720      75 13                    JNZ 0x1000:0735
// 1000:0722      fe 06 3e a3              INC byte ptr [0xa33e]
// 1000:0726      80 3e 3e a3 07           CMP byte ptr [0xa33e],0x7
// 1000:072b      72 05                    JC 0x1000:0732
// 1000:072d      c6 06 3e a3 00           MOV byte ptr [0xa33e],0x0
// 1000:0732  LAB_1000_0732:
// 1000:0732      e9 90 fe                 JMP 0x1000:05c5
// 1000:0735  LAB_1000_0735:
// 1000:0735      e8 d6 03                 CALL 0x1000:0b0e
// 1000:0738      75 10                    JNZ 0x1000:074a
// 1000:073a      fe 0e 3e a3              DEC byte ptr [0xa33e]
// 1000:073e      80 3e 3e a3 ff           CMP byte ptr [0xa33e],0xff
// 1000:0743      75 05                    JNZ 0x1000:074a
// 1000:0745      c6 06 3e a3 06           MOV byte ptr [0xa33e],0x6
// 1000:074a  LAB_1000_074a:
// 1000:074a      3c 0d                    CMP AL,0xd
// 1000:074c      75 41                    JNZ 0x1000:078f
// 1000:074e      80 3e 3e a3 00           CMP byte ptr [0xa33e],0x0
// 1000:0753      75 0b                    JNZ 0x1000:0760
// 1000:0755      e8 bd 03                 CALL 0x1000:0b15
// 1000:0758      c6 06 3e a3 00           MOV byte ptr [0xa33e],0x0
// 1000:075d      eb 62                    JMP 0x1000:07c1
// 1000:0760  LAB_1000_0760:
// 1000:0760      80 3e 3e a3 01           CMP byte ptr [0xa33e],0x1
// 1000:0765      75 13                    JNZ 0x1000:077a
// 1000:0767      a0 12 00                 MOV AL,[0x12]
// 1000:076a      80 26 12 00 fc           AND byte ptr [0x12],0xfc
// 1000:076f      fe c0                    INC AL
// 1000:0771      24 03                    AND AL,0x3
// 1000:0773      08 06 12 00              OR byte ptr [0x12],AL
// 1000:0777      eb 48                    JMP 0x1000:07c1
// 1000:077a  LAB_1000_077a:
// 1000:077a      80 3e 3e a3 02           CMP byte ptr [0xa33e],0x2
// 1000:077f      75 11                    JNZ 0x1000:0792
// 1000:0781      80 2e 10 00 02           SUB byte ptr [0x10],0x2
// 1000:0786      80 26 10 00 03           AND byte ptr [0x10],0x3
// 1000:078b      fe 06 10 00              INC byte ptr [0x10]
// 1000:078f  LAB_1000_078f:
// 1000:078f      eb 30                    JMP 0x1000:07c1
// 1000:0792  LAB_1000_0792:
// 1000:0792      80 3e 3e a3 03           CMP byte ptr [0xa33e],0x3
// 1000:0797      75 11                    JNZ 0x1000:07aa
// 1000:0799      80 2e 11 00 02           SUB byte ptr [0x11],0x2
// 1000:079e      80 26 11 00 03           AND byte ptr [0x11],0x3
// 1000:07a3      fe 06 11 00              INC byte ptr [0x11]
// 1000:07a7      eb 18                    JMP 0x1000:07c1
// 1000:07aa  LAB_1000_07aa:
// 1000:07aa      80 3e 3e a3 04           CMP byte ptr [0xa33e],0x4
// 1000:07af      75 13                    JNZ 0x1000:07c4
// 1000:07b1      fe 06 0f 00              INC byte ptr [0xf]
// 1000:07b5      80 3e 0f 00 04           CMP byte ptr [0xf],0x4
// 1000:07ba      72 05                    JC 0x1000:07c1
// 1000:07bc      c6 06 0f 00 00           MOV byte ptr [0xf],0x0
// 1000:07c1  LAB_1000_07c1:
// 1000:07c1      e9 01 fe                 JMP 0x1000:05c5
// 1000:07c4  LAB_1000_07c4:
// 1000:07c4      80 3e 3e a3 05           CMP byte ptr [0xa33e],0x5
// 1000:07c9      75 12                    JNZ 0x1000:07dd
// 1000:07cb      fe 06 13 00              INC byte ptr [0x13]
// 1000:07cf      80 3e 13 00 03           CMP byte ptr [0x13],0x3
// 1000:07d4      72 eb                    JC 0x1000:07c1
// 1000:07d6      c6 06 13 00 00           MOV byte ptr [0x13],0x0
// 1000:07db      eb e4                    JMP 0x1000:07c1
// 1000:07dd  LAB_1000_07dd:
// 1000:07dd      fe 06 0d 00              INC byte ptr [0xd]
// 1000:07e1      80 3e 0d 00 04           CMP byte ptr [0xd],0x4
// 1000:07e6      72 d9                    JC 0x1000:07c1
// 1000:07e8      c6 06 0d 00 00           MOV byte ptr [0xd],0x0
// 1000:07ed      eb d2                    JMP 0x1000:07c1
fun_0585 :: proc() {
}

// @proc 1000:07ef
// listing: FUN_1000_07ef
// notes: print_speed_name
// status: unread
// 1000:07ef  FUN_1000_07ef:
// 1000:07ef      22 c0                    AND AL,AL
// 1000:07f1      75 0c                    JNZ 0x1000:07ff
// 1000:07f3      e8 05 50                 CALL 0x1000:57fb
//                 ; inline script -> 1000:07fe  <c1>SLOW
// 1000:07fe  LAB_1000_07fe:
// 1000:07fe      c3                       RET
// 1000:07ff  LAB_1000_07ff:
// 1000:07ff      fe c8                    DEC AL
// 1000:0801      75 0e                    JNZ 0x1000:0811
// 1000:0803      e8 f5 4f                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0810  <c1>MEDIUM
// 1000:0810  LAB_1000_0810:
// 1000:0810      c3                       RET
// 1000:0811  LAB_1000_0811:
// 1000:0811      fe c8                    DEC AL
// 1000:0813      75 0c                    JNZ 0x1000:0821
// 1000:0815      e8 e3 4f                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0820  <c1>FAST
// 1000:0820  LAB_1000_0820:
// 1000:0820      c3                       RET
// 1000:0821  LAB_1000_0821:
// 1000:0821      e8 d7 4f                 CALL 0x1000:57fb
//                 ; inline script -> 1000:082f  <c1>MAXIMUM
// 1000:082f  LAB_1000_082f:
// 1000:082f      c3                       RET
fun_07ef :: proc() {
}

// @proc 1000:0830
// listing: FUN_1000_0830
// notes: print_game_mode
// status: unread
// 1000:0830  FUN_1000_0830:
// 1000:0830      a0 12 00                 MOV AL,[0x12]
// 1000:0833      24 01                    AND AL,0x1
// 1000:0835      75 0f                    JNZ 0x1000:0846
// 1000:0837      e8 c1 4f                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0844  <c1>LONG, 
// 1000:0844  LAB_1000_0844:
// 1000:0844      eb 0e                    JMP 0x1000:0854
// 1000:0846  LAB_1000_0846:
// 1000:0846      e8 b2 4f                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0854  <c1>TIMED, 
// 1000:0854  LAB_1000_0854:
// 1000:0854      a0 12 00                 MOV AL,[0x12]
// 1000:0857      24 02                    AND AL,0x2
// 1000:0859      75 14                    JNZ 0x1000:086f
// 1000:085b      e8 9d 4f                 CALL 0x1000:57fb
//                 ; inline script -> 1000:086e  <c1>SINGLE-PLANE
// 1000:086e  LAB_1000_086e:
// 1000:086e      c3                       RET
// 1000:086f  LAB_1000_086f:
// 1000:086f      e8 89 4f                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0881  <c1>MULTI-PLANE
// 1000:0881  LAB_1000_0881:
// 1000:0881      c3                       RET
fun_0830 :: proc() {
}

// @proc 1000:0882
// listing: FUN_1000_0882
// notes: print_handicap
// status: unread
// 1000:0882  FUN_1000_0882:
// 1000:0882      fe c8                    DEC AL
// 1000:0884      75 0e                    JNZ 0x1000:0894
// 1000:0886      e8 72 4f                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0893  <c1>EXPERT
// 1000:0893  LAB_1000_0893:
// 1000:0893      c3                       RET
// 1000:0894  LAB_1000_0894:
// 1000:0894      fe c8                    DEC AL
// 1000:0896      75 0e                    JNZ 0x1000:08a6
// 1000:0898      e8 60 4f                 CALL 0x1000:57fb
//                 ; inline script -> 1000:08a5  <c1>NORMAL
// 1000:08a5  LAB_1000_08a5:
// 1000:08a5      c3                       RET
// 1000:08a6  LAB_1000_08a6:
// 1000:08a6      fe c8                    DEC AL
// 1000:08a8      75 0e                    JNZ 0x1000:08b8
// 1000:08aa      e8 4e 4f                 CALL 0x1000:57fb
//                 ; inline script -> 1000:08b7  <c1>NOVICE
// 1000:08b7  LAB_1000_08b7:
// 1000:08b7      c3                       RET
// 1000:08b8  LAB_1000_08b8:
// 1000:08b8      e8 40 4f                 CALL 0x1000:57fb
//                 ; inline script -> 1000:08c7  <c1>BEGINNER
// 1000:08c7  LAB_1000_08c7:
// 1000:08c7      c3                       RET
fun_0882 :: proc() {
}

// @proc 1000:08c8
// listing: FUN_1000_08c8
// status: unread
// 1000:08c8  FUN_1000_08c8:
// 1000:08c8      e8 30 4f                 CALL 0x1000:57fb
//                 ; inline script -> 1000:08fa  <c1>  TWO PLAYER (MODEM MODE)     GAME MODE IS 
// 1000:08fa  LAB_1000_08fa:
// 1000:08fa      e8 33 ff                 CALL 0x1000:0830
// 1000:08fd      e8 fb 4e                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0907  <c1>   
// 1000:0907  LAB_1000_0907:
// 1000:0907      e8 f1 4e                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0923  <c1>  PLAYER HANDICAP IS 
// 1000:0923  LAB_1000_0923:
// 1000:0923      a0 10 00                 MOV AL,[0x10]
// 1000:0926      e8 59 ff                 CALL 0x1000:0882
// 1000:0929      e8 cf 4e                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0942  <c1>     BAUD RATE IS 
// 1000:0942  LAB_1000_0942:
// 1000:0942      e8 25 03                 CALL 0x1000:0c6a
// 1000:0945      e8 b3 4e                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0961  <c1>     COMM PORT IS COM
// 1000:0961  LAB_1000_0961:
// 1000:0961      a0 0c 00                 MOV AL,[0xc]
// 1000:0964      04 31                    ADD AL,0x31
// 1000:0966      e8 0e 4c                 CALL 0x1000:5577
// 1000:0969      e8 8f 4e                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0973  <c1>: (
// 1000:0973  LAB_1000_0973:
// 1000:0973      a0 a8 00                 MOV AL,[0xa8]
// 1000:0976      e8 d9 02                 CALL 0x1000:0c52
// 1000:0979      a0 a7 00                 MOV AL,[0xa7]
// 1000:097c      e8 d3 02                 CALL 0x1000:0c52
// 1000:097f      e8 79 4e                 CALL 0x1000:57fb
//                 ; inline script -> 1000:099b  <c1>H)     CONNECTION IS 
// 1000:099b  LAB_1000_099b:
// 1000:099b      a0 0e 00                 MOV AL,[0xe]
// 1000:099e      22 c0                    AND AL,AL
// 1000:09a0      75 1a                    JNZ 0x1000:09bc
// 1000:09a2      e8 56 4e                 CALL 0x1000:57fb
//                 ; inline script -> 1000:09b9  <c1>ACOUSTIC COUPLER
// 1000:09b9  LAB_1000_09b9:
// 1000:09b9      eb 13                    JMP 0x1000:09ce
// 1000:09bc  LAB_1000_09bc:
// 1000:09bc      e8 3c 4e                 CALL 0x1000:57fb
//                 ; inline script -> 1000:09ce  <c1>SMART MODEM
// 1000:09ce  LAB_1000_09ce:
// 1000:09ce      e8 2a 4e                 CALL 0x1000:57fb
//                 ; inline script -> 1000:09f1  <c1>     NUMBER OF COMPUTERS IS 
// 1000:09f1  LAB_1000_09f1:
// 1000:09f1      f6 06 12 00 0c           TEST byte ptr [0x12],0xc
// 1000:09f6      b0 30                    MOV AL,0x30
// 1000:09f8      74 0b                    JZ 0x1000:0a05
// 1000:09fa      fe c0                    INC AL
// 1000:09fc      f6 06 12 00 08           TEST byte ptr [0x12],0x8
// 1000:0a01      74 02                    JZ 0x1000:0a05
// 1000:0a03      fe c0                    INC AL
// 1000:0a05  LAB_1000_0a05:
// 1000:0a05      e8 6f 4b                 CALL 0x1000:5577
// 1000:0a08      e8 f0 4d                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0a25  <c1>     PLAYING SPEED IS 
// 1000:0a25  LAB_1000_0a25:
// 1000:0a25      a0 0d 00                 MOV AL,[0xd]
// 1000:0a28      e8 c4 fd                 CALL 0x1000:07ef
// 1000:0a2b      bb 8e 00                 MOV BX,0x8e
// 1000:0a2e      e8 db 4d                 CALL 0x1000:580c
// 1000:0a31      e8 8a 01                 CALL 0x1000:0bbe
// 1000:0a34  LAB_1000_0a34:
// 1000:0a34      ff 06 d0 89              INC word ptr [0x89d0]
// 1000:0a38      e8 0a 01                 CALL 0x1000:0b45
// 1000:0a3b      74 f7                    JZ 0x1000:0a34
// 1000:0a3d      3c 06                    CMP AL,0x6
// 1000:0a3f      74 3f                    JZ 0x1000:0a80
// 1000:0a41      b3 08                    MOV BL,0x8
// 1000:0a43      e8 c1 00                 CALL 0x1000:0b07
// 1000:0a46      75 0f                    JNZ 0x1000:0a57
// 1000:0a48      fe 06 3e a3              INC byte ptr [0xa33e]
// 1000:0a4c      38 1e 3e a3              CMP byte ptr [0xa33e],BL
// 1000:0a50      72 05                    JC 0x1000:0a57
// 1000:0a52      c6 06 3e a3 00           MOV byte ptr [0xa33e],0x0
// 1000:0a57  LAB_1000_0a57:
// 1000:0a57      e8 b4 00                 CALL 0x1000:0b0e
// 1000:0a5a      75 11                    JNZ 0x1000:0a6d
// 1000:0a5c      fe 0e 3e a3              DEC byte ptr [0xa33e]
// 1000:0a60      80 3e 3e a3 ff           CMP byte ptr [0xa33e],0xff
// 1000:0a65      75 06                    JNZ 0x1000:0a6d
// 1000:0a67      fe cb                    DEC BL
// 1000:0a69      88 1e 3e a3              MOV byte ptr [0xa33e],BL
// 1000:0a6d  LAB_1000_0a6d:
// 1000:0a6d      3c 0d                    CMP AL,0xd
// 1000:0a6f      75 0f                    JNZ 0x1000:0a80
// 1000:0a71      a0 3e a3                 MOV AL,[0xa33e]
// 1000:0a74      22 c0                    AND AL,AL
// 1000:0a76      75 0b                    JNZ 0x1000:0a83
// 1000:0a78      e8 9a 00                 CALL 0x1000:0b15
// 1000:0a7b      c6 06 3e a3 00           MOV byte ptr [0xa33e],0x0
// 1000:0a80  LAB_1000_0a80:
// 1000:0a80      e9 42 fb                 JMP 0x1000:05c5
// 1000:0a83  LAB_1000_0a83:
// 1000:0a83      fe c8                    DEC AL
// 1000:0a85      75 13                    JNZ 0x1000:0a9a
// 1000:0a87      a0 12 00                 MOV AL,[0x12]
// 1000:0a8a      80 26 12 00 fc           AND byte ptr [0x12],0xfc
// 1000:0a8f      fe c0                    INC AL
// 1000:0a91      24 03                    AND AL,0x3
// 1000:0a93      08 06 12 00              OR byte ptr [0x12],AL
// 1000:0a97      e9 2b fb                 JMP 0x1000:05c5
// 1000:0a9a  LAB_1000_0a9a:
// 1000:0a9a      fe c8                    DEC AL
// 1000:0a9c      75 14                    JNZ 0x1000:0ab2
// 1000:0a9e      fe 0e 10 00              DEC byte ptr [0x10]
// 1000:0aa2      fe 0e 10 00              DEC byte ptr [0x10]
// 1000:0aa6      80 26 10 00 03           AND byte ptr [0x10],0x3
// 1000:0aab      fe 06 10 00              INC byte ptr [0x10]
// 1000:0aaf      eb 41                    JMP 0x1000:0af2
// 1000:0ab2  LAB_1000_0ab2:
// 1000:0ab2      fe c8                    DEC AL
// 1000:0ab4      75 11                    JNZ 0x1000:0ac7
// 1000:0ab6      c6 06 03 00 01           MOV byte ptr [0x3],0x1
// 1000:0abb      fe 06 0b 00              INC byte ptr [0xb]
// 1000:0abf      80 26 0b 00 07           AND byte ptr [0xb],0x7
// 1000:0ac4      eb 2c                    JMP 0x1000:0af2
// 1000:0ac7  LAB_1000_0ac7:
// 1000:0ac7      fe c8                    DEC AL
// 1000:0ac9      75 0f                    JNZ 0x1000:0ada
// 1000:0acb      c6 06 03 00 01           MOV byte ptr [0x3],0x1
// 1000:0ad0      fe 06 0c 00              INC byte ptr [0xc]
// 1000:0ad4      e8 ae fa                 CALL 0x1000:0585
// 1000:0ad7      eb 19                    JMP 0x1000:0af2
// 1000:0ada  LAB_1000_0ada:
// 1000:0ada      fe c8                    DEC AL
// 1000:0adc      75 0d                    JNZ 0x1000:0aeb
// 1000:0ade      80 26 0e 00 01           AND byte ptr [0xe],0x1
// 1000:0ae3      80 36 0e 00 01           XOR byte ptr [0xe],0x1
// 1000:0ae8      eb 08                    JMP 0x1000:0af2
// 1000:0aeb  LAB_1000_0aeb:
// 1000:0aeb      fe c8                    DEC AL
// 1000:0aed      75 06                    JNZ 0x1000:0af5
// 1000:0aef      e8 36 00                 CALL 0x1000:0b28
// 1000:0af2  LAB_1000_0af2:
// 1000:0af2      e9 d0 fa                 JMP 0x1000:05c5
// 1000:0af5  LAB_1000_0af5:
// 1000:0af5      fe 06 0d 00              INC byte ptr [0xd]
// 1000:0af9      80 3e 0d 00 04           CMP byte ptr [0xd],0x4
// 1000:0afe      72 f2                    JC 0x1000:0af2
// 1000:0b00      c6 06 0d 00 00           MOV byte ptr [0xd],0x0
// 1000:0b05      eb eb                    JMP 0x1000:0af2
fun_08c8 :: proc() {
}

// @proc 1000:0b07
// listing: FUN_1000_0b07
// notes: key_is_down
// status: unread
// 1000:0b07  FUN_1000_0b07:
// 1000:0b07      3c 2b                    CMP AL,0x2b
// 1000:0b09      74 02                    JZ 0x1000:0b0d
// 1000:0b0b      3c d0                    CMP AL,0xd0
// 1000:0b0d  LAB_1000_0b0d:
// 1000:0b0d      c3                       RET
fun_0b07 :: proc() {
}

// @proc 1000:0b0e
// listing: FUN_1000_0b0e
// notes: key_is_up
// status: unread
// 1000:0b0e  FUN_1000_0b0e:
// 1000:0b0e      3c 2d                    CMP AL,0x2d
// 1000:0b10      74 02                    JZ 0x1000:0b14
// 1000:0b12      3c c8                    CMP AL,0xc8
// 1000:0b14  LAB_1000_0b14:
// 1000:0b14      c3                       RET
fun_0b0e :: proc() {
}

// @proc 1000:0b15
// listing: FUN_1000_0b15
// notes: toggle_player_count
// status: unread
// 1000:0b15  FUN_1000_0b15:
// 1000:0b15      80 3e 0a 00 01           CMP byte ptr [0xa],0x1
// 1000:0b1a      74 06                    JZ 0x1000:0b22
// 1000:0b1c      c6 06 0a 00 01           MOV byte ptr [0xa],0x1
// 1000:0b21      c3                       RET
// 1000:0b22  LAB_1000_0b22:
// 1000:0b22      c6 06 0a 00 02           MOV byte ptr [0xa],0x2
// 1000:0b27      c3                       RET
fun_0b15 :: proc() {
}

// @proc 1000:0b28
// listing: FUN_1000_0b28
// notes: cycle_computer_count
// status: unread
// 1000:0b28  FUN_1000_0b28:
// 1000:0b28      a0 12 00                 MOV AL,[0x12]
// 1000:0b2b      24 0c                    AND AL,0xc
// 1000:0b2d      75 06                    JNZ 0x1000:0b35
// 1000:0b2f      80 0e 12 00 04           OR byte ptr [0x12],0x4
// 1000:0b34      c3                       RET
// 1000:0b35  LAB_1000_0b35:
// 1000:0b35      3c 04                    CMP AL,0x4
// 1000:0b37      75 06                    JNZ 0x1000:0b3f
// 1000:0b39      80 0e 12 00 08           OR byte ptr [0x12],0x8
// 1000:0b3e      c3                       RET
// 1000:0b3f  LAB_1000_0b3f:
// 1000:0b3f      80 26 12 00 f3           AND byte ptr [0x12],0xf3
// 1000:0b44      c3                       RET
fun_0b28 :: proc() {
}

// @proc 1000:0b45
// listing: FUN_1000_0b45
// notes: poll_key
// status: unread
// 1000:0b45  FUN_1000_0b45:
// 1000:0b45      b4 01                    MOV AH,0x1
// 1000:0b47      cd 16                    INT 0x16
// 1000:0b49      b0 00                    MOV AL,0x0
// 1000:0b4b      74 61                    JZ 0x1000:0bae
// 1000:0b4d      b4 00                    MOV AH,0x0
// 1000:0b4f      cd 16                    INT 0x16
// 1000:0b51      3c 1b                    CMP AL,0x1b
// 1000:0b53      75 0e                    JNZ 0x1000:0b63
// 1000:0b55      c6 06 72 a2 01           MOV byte ptr [0xa272],0x1
// 1000:0b5a      c6 06 6c a2 00           MOV byte ptr [0xa26c],0x0
// 1000:0b5f      ff 26 a5 00              JMP word ptr [0xa5]
// 1000:0b63  LAB_1000_0b63:
// 1000:0b63      80 fc 52                 CMP AH,0x52
// 1000:0b66      74 09                    JZ 0x1000:0b71
// 1000:0b68      80 fc 53                 CMP AH,0x53
// 1000:0b6b      74 04                    JZ 0x1000:0b71
// 1000:0b6d      3c 00                    CMP AL,0x0
// 1000:0b6f      75 05                    JNZ 0x1000:0b76
// 1000:0b71  LAB_1000_0b71:
// 1000:0b71      80 cc 80                 OR AH,0x80
// 1000:0b74      8a c4                    MOV AL,AH
// 1000:0b76  LAB_1000_0b76:
// 1000:0b76      3c 13                    CMP AL,0x13
// 1000:0b78      75 07                    JNZ 0x1000:0b81
// 1000:0b7a      80 36 14 00 03           XOR byte ptr [0x14],0x3
// 1000:0b7f      eb c4                    JMP 0x1000:0b45
// 1000:0b81  LAB_1000_0b81:
// 1000:0b81      3c 04                    CMP AL,0x4
// 1000:0b83      75 00                    JNZ 0x1000:0b85
// 1000:0b85  LAB_1000_0b85:
// 1000:0b85      3c 06                    CMP AL,0x6
// 1000:0b87      75 17                    JNZ 0x1000:0ba0
// 1000:0b89      81 3e 16 00 cd 28        CMP word ptr [0x16],0x28cd
// 1000:0b8f      c7 06 16 00 cd 28        MOV word ptr [0x16],0x28cd
// 1000:0b95      75 06                    JNZ 0x1000:0b9d
// 1000:0b97      c7 06 16 00 1d 31        MOV word ptr [0x16],0x311d
// 1000:0b9d  LAB_1000_0b9d:
// 1000:0b9d      22 c0                    AND AL,AL
// 1000:0b9f      c3                       RET
// 1000:0ba0  LAB_1000_0ba0:
// 1000:0ba0      3c 10                    CMP AL,0x10
// 1000:0ba2      75 0a                    JNZ 0x1000:0bae
// 1000:0ba4      80 36 15 00 01           XOR byte ptr [0x15],0x1
// 1000:0ba9      e8 03 00                 CALL 0x1000:0baf
// 1000:0bac      eb 97                    JMP 0x1000:0b45
// 1000:0bae  LAB_1000_0bae:
// 1000:0bae      c3                       RET
fun_0b45 :: proc() {
}

// @proc 1000:0baf
// listing: FUN_1000_0baf
// notes: set_palette
// status: unread
// 1000:0baf  FUN_1000_0baf:
// 1000:0baf      50                       PUSH AX
// 1000:0bb0      53                       PUSH BX
// 1000:0bb1      b4 0b                    MOV AH,0xb
// 1000:0bb3      8a 1e 15 00              MOV BL,byte ptr [0x15]
// 1000:0bb7      b7 01                    MOV BH,0x1
// 1000:0bb9      cd 10                    INT 0x10
// 1000:0bbb      5b                       POP BX
// 1000:0bbc      58                       POP AX
// 1000:0bbd      c3                       RET
fun_0baf :: proc() {
}

// @proc 1000:0bbe
// listing: FUN_1000_0bbe
// status: unread
// 1000:0bbe  FUN_1000_0bbe:
// 1000:0bbe      e8 3a 4c                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0bec  <c1><box>Hit Esc to return to primary menu.
// 1000:0bec  LAB_1000_0bec:
// 1000:0bec      b0 01                    MOV AL,0x1
fun_0bbe :: proc() {
}

// @proc 1000:0bee
// listing: FUN_1000_0bee
// status: unread
// 1000:0bee  FUN_1000_0bee:
// 1000:0bee      50                       PUSH AX
// 1000:0bef      e8 09 4c                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0c17  <c1><box><c3><c1> or <c3><c1> to select,    to 
// 1000:0c17  LAB_1000_0c17:
// 1000:0c17      58                       POP AX
// 1000:0c18      22 c0                    AND AL,AL
// 1000:0c1a      75 12                    JNZ 0x1000:0c2e
// 1000:0c1c      e8 dc 4b                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0c2b  <c1>execute.
// 1000:0c2b  LAB_1000_0c2b:
// 1000:0c2b      eb 10                    JMP 0x1000:0c3d
// 1000:0c2e  LAB_1000_0c2e:
// 1000:0c2e      e8 ca 4b                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0c3d  <c1>change. 
// 1000:0c3d  LAB_1000_0c3d:
// 1000:0c3d      e8 bb 4b                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0c4b  <c1><pic>
// 1000:0c4b  LAB_1000_0c4b:
// 1000:0c4b      c3                       RET
fun_0bee :: proc() {
}

// @proc 1000:0c4c
// listing: FUN_1000_0c4c
// notes: serial_cli_call
// status: unread
// 1000:0c4c  FUN_1000_0c4c:
// 1000:0c4c      fa                       CLI
// 1000:0c4d      e8 2b 53                 CALL 0x1000:5f7b
// 1000:0c50      fb                       STI
// 1000:0c51      c3                       RET
fun_0c4c :: proc() {
}

// @proc 1000:0c52
// listing: FUN_1000_0c52
// notes: print_al_hex
// status: unread
// 1000:0c52  FUN_1000_0c52:
// 1000:0c52      50                       PUSH AX
// 1000:0c53      d0 e8                    SHR AL,0x1
// 1000:0c55      d0 e8                    SHR AL,0x1
// 1000:0c57      d0 e8                    SHR AL,0x1
// 1000:0c59      d0 e8                    SHR AL,0x1
// 1000:0c5b      e8 01 00                 CALL 0x1000:0c5f
// 1000:0c5e      58                       POP AX
fun_0c52 :: proc() {
}

// @proc 1000:0c5f
// listing: thunk_FUN_1000_5577
// status: unread
// 1000:0c5f  thunk_FUN_1000_5577:
// 1000:0c5f      24 0f                    AND AL,0xf
// 1000:0c61      04 90                    ADD AL,0x90
// 1000:0c63      27                       DAA
// 1000:0c64      14 40                    ADC AL,0x40
// 1000:0c66      27                       DAA
// 1000:0c67      e9 0d 49                 JMP 0x1000:5577
fun_0c5f :: proc() {
}

// @proc 1000:0c6a
// listing: FUN_1000_0c6a
// notes: print_baud
// status: unread
// 1000:0c6a  FUN_1000_0c6a:
// 1000:0c6a      a0 0b 00                 MOV AL,[0xb]
// 1000:0c6d      24 07                    AND AL,0x7
// 1000:0c6f      b4 05                    MOV AH,0x5
// 1000:0c71      f6 e4                    MUL AH
// 1000:0c73      bb a9 00                 MOV BX,0xa9
// 1000:0c76      03 d8                    ADD BX,AX
// 1000:0c78      e8 91 4b                 CALL 0x1000:580c
// 1000:0c7b      c3                       RET
fun_0c6a :: proc() {
}

// @proc 1000:0c7c
// listing: FUN_1000_0c7c
// notes: checksum_image
// status: unread
// 1000:0c7c  FUN_1000_0c7c:
// 1000:0c7c      be 06 00                 MOV SI,0x6
// 1000:0c7f      b9 66 ac                 MOV CX,0xac66
// 1000:0c82      2b ce                    SUB CX,SI
// 1000:0c84      d1 e9                    SHR CX,0x1
// 1000:0c86      33 c0                    XOR AX,AX
// 1000:0c88  LAB_1000_0c88:
// 1000:0c88      2e 03 04                 ADD AX,word ptr CS:[SI]
// 1000:0c8b      83 c6 02                 ADD SI,0x2
// 1000:0c8e      e2 f8                    LOOP 0x1000:0c88
// 1000:0c90      23 c0                    AND AX,AX
// 1000:0c92      75 06                    JNZ 0x1000:0c9a
// 1000:0c94      a0 00 a2                 MOV AL,[0xa200]
// 1000:0c97      e6 21                    OUT 0x21,AL
// 1000:0c99      c3                       RET
// 1000:0c9a  LAB_1000_0c9a:
// 1000:0c9a      fa                       CLI
// 1000:0c9b      b0 ff                    MOV AL,0xff
// 1000:0c9d      e6 21                    OUT 0x21,AL
// 1000:0c9f      e8 59 4b                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0d5d  <c2><clear>    Program Corrupted!!  Due To Unauthorized Modification.  Can Not Continue.   Obtain A New Copy By Sending $10.00 To:      Carl McLawhorn     700 M
// 1000:0d5d  LAB_1000_0d5d:
// 1000:0d5d      e9 b7 5f                 JMP 0x1000:6d17
fun_0c7c :: proc() {
}

// @proc 1000:0d60
// listing: FUN_1000_0d60
// notes: apply_serial_if_dirty
// status: unread
// 1000:0d60  FUN_1000_0d60:
// 1000:0d60      80 3e 03 00 00           CMP byte ptr [0x3],0x0
// 1000:0d65      74 03                    JZ 0x1000:0d6a
// 1000:0d67      e8 6c 50                 CALL 0x1000:5dd6
// 1000:0d6a  LAB_1000_0d6a:
// 1000:0d6a      c6 06 03 00 00           MOV byte ptr [0x3],0x0
// 1000:0d6f      c3                       RET
// 1000:0d70      e8 88 4a                 CALL 0x1000:57fb
//                 ; inline script -> 1000:0d7b  <c3><clear>   
// 1000:0d7b  LAB_1000_0d7b:
// 1000:0d7b      e8 e2 ff                 CALL 0x1000:0d60
// 1000:0d7e      c6 06 40 a3 ff           MOV byte ptr [0xa340],0xff
// 1000:0d83      e8 c6 fe                 CALL 0x1000:0c4c
// 1000:0d86      e8 34 00                 CALL 0x1000:0dbd
// 1000:0d89  LAB_1000_0d89:
// 1000:0d89      e8 f9 01                 CALL 0x1000:0f85
// 1000:0d8c      e8 fd 50                 CALL 0x1000:5e8c
// 1000:0d8f      72 06                    JC 0x1000:0d97
// 1000:0d91      bb 9b 00                 MOV BX,0x9b
// 1000:0d94      e8 fa 00                 CALL 0x1000:0e91
// 1000:0d97  LAB_1000_0d97:
// 1000:0d97      e8 ab fd                 CALL 0x1000:0b45
// 1000:0d9a      74 ed                    JZ 0x1000:0d89
// 1000:0d9c      3c 0d                    CMP AL,0xd
// 1000:0d9e      75 12                    JNZ 0x1000:0db2
// 1000:0da0      e8 34 51                 CALL 0x1000:5ed7
// 1000:0da3      b0 0d                    MOV AL,0xd
// 1000:0da5      72 0b                    JC 0x1000:0db2
// 1000:0da7      bb a0 00                 MOV BX,0xa0
// 1000:0daa      e8 e4 00                 CALL 0x1000:0e91
// 1000:0dad      e8 08 51                 CALL 0x1000:5eb8
// 1000:0db0      b0 0a                    MOV AL,0xa
// 1000:0db2  LAB_1000_0db2:
// 1000:0db2      bb a0 00                 MOV BX,0xa0
// 1000:0db5      e8 d9 00                 CALL 0x1000:0e91
// 1000:0db8      e8 fd 50                 CALL 0x1000:5eb8
// 1000:0dbb      eb cc                    JMP 0x1000:0d89
fun_0d60 :: proc() {
}

// 1000:0dbd through 1000:0f5c are in draw.odin.

// @proc 1000:0f85
// listing: FUN_1000_0f85
// status: unread
// 1000:0f85  FUN_1000_0f85:
// 1000:0f85      c6 06 96 00 00           MOV byte ptr [0x96],0x0
// 1000:0f8a      c6 06 97 00 00           MOV byte ptr [0x97],0x0
// 1000:0f8f      80 3e 0e 00 00           CMP byte ptr [0xe],0x0
// 1000:0f94      74 03                    JZ 0x1000:0f99
// 1000:0f96      e9 2a 01                 JMP 0x1000:10c3
// 1000:0f99  LAB_1000_0f99:
// 1000:0f99      e8 3b 4f                 CALL 0x1000:5ed7
// 1000:0f9c      72 03                    JC 0x1000:0fa1
// 1000:0f9e      e9 91 00                 JMP 0x1000:1032
// 1000:0fa1  LAB_1000_0fa1:
// 1000:0fa1      b0 01                    MOV AL,0x1
// 1000:0fa3      86 06 40 a3              XCHG byte ptr [0xa340],AL
// 1000:0fa7      3a 06 40 a3              CMP AL,byte ptr [0xa340]
// 1000:0fab      75 03                    JNZ 0x1000:0fb0
// 1000:0fad      e9 3a 02                 JMP 0x1000:11ea
// 1000:0fb0  LAB_1000_0fb0:
// 1000:0fb0      e8 bd fe                 CALL 0x1000:0e70
//                 ; encoded string -> 1000:102f  <c1>IN TERMINAL MODE, NO CARRIER.           ESTABLISH LINK AND PLACE HANDSET        IN COUPLER. Esc TO EXIT.                
// 1000:102f  LAB_1000_102f:
// 1000:102f      e9 b8 01                 JMP 0x1000:11ea
// 1000:1032  LAB_1000_1032:
// 1000:1032      b0 00                    MOV AL,0x0
// 1000:1034      86 06 40 a3              XCHG byte ptr [0xa340],AL
// 1000:1038      3a 06 40 a3              CMP AL,byte ptr [0xa340]
// 1000:103c      75 03                    JNZ 0x1000:1041
// 1000:103e      e9 a9 01                 JMP 0x1000:11ea
// 1000:1041  LAB_1000_1041:
// 1000:1041      e8 2c fe                 CALL 0x1000:0e70
//                 ; encoded string -> 1000:10c0  <c1>IN TERMINAL MODE, CARRIER PRESENT       TO TALK, REMOVE HANDSET OR USE KEYBOARD TO SEND MESSAGE. Esc TO EXIT.           
// 1000:10c0  LAB_1000_10c0:
// 1000:10c0      e9 27 01                 JMP 0x1000:11ea
// 1000:10c3  LAB_1000_10c3:
// 1000:10c3      e8 11 4e                 CALL 0x1000:5ed7
// 1000:10c6      72 03                    JC 0x1000:10cb
// 1000:10c8      e9 91 00                 JMP 0x1000:115c
// 1000:10cb  LAB_1000_10cb:
// 1000:10cb      b0 01                    MOV AL,0x1
// 1000:10cd      86 06 40 a3              XCHG byte ptr [0xa340],AL
// 1000:10d1      3a 06 40 a3              CMP AL,byte ptr [0xa340]
// 1000:10d5      75 03                    JNZ 0x1000:10da
// 1000:10d7      e9 10 01                 JMP 0x1000:11ea
// 1000:10da  LAB_1000_10da:
// 1000:10da      e8 93 fd                 CALL 0x1000:0e70
//                 ; encoded string -> 1000:1159  <c1>IN TERMINAL MODE, NO CARRIER.           TYPE ATDT<number> TO ORIGINATE CALL OR       ATA TO ANSWER. Esc TO EXIT.        
// 1000:1159  LAB_1000_1159:
// 1000:1159      e9 8e 00                 JMP 0x1000:11ea
// 1000:115c  LAB_1000_115c:
// 1000:115c      b0 00                    MOV AL,0x0
// 1000:115e      86 06 40 a3              XCHG byte ptr [0xa340],AL
// 1000:1162      3a 06 40 a3              CMP AL,byte ptr [0xa340]
// 1000:1166      75 03                    JNZ 0x1000:116b
// 1000:1168      e9 7f 00                 JMP 0x1000:11ea
// 1000:116b  LAB_1000_116b:
// 1000:116b      e8 02 fd                 CALL 0x1000:0e70
//                 ; encoded string -> 1000:11ea  <c1>IN TERMINAL MODE, CARRIER PRESENT       TYPE +++ , THEN ATH TO DROP CARRIER,    PICK UP PHONE TO TALK. Esc TO EXIT.     
// 1000:11ea  LAB_1000_11ea:
// 1000:11ea      c3                       RET
fun_0f85 :: proc() {
}

// 1000:11eb is in draw.odin.

