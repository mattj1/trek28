package trek

// Drawing procedures.
// 1000:0dbd through 1000:0f5c, 1000:11eb, 1000:4530 through 1000:580c,
// 1000:5815, 1000:596c, and 1000:a800.
// The assembly above each procedure is the listing. The body is empty until that procedure is translated.
// A notes line is a name already supported by the annotation notes.
// A procedure that stores into CGA video memory (segment B800) or writes port 0x3D9 keeps an empty body.
// host_blit, host_set_palette, and host_color_select are the host seams for those stores.

// @proc 1000:0dbd
// listing: FUN_1000_0dbd
// notes: draw_terminal_screen
// status: unread
// 1000:0dbd  FUN_1000_0dbd:
// 1000:0dbd      c6 06 9b 00 00           MOV byte ptr [0x9b],0x0
// 1000:0dc2      c6 06 9c 00 00           MOV byte ptr [0x9c],0x0
// 1000:0dc7      c6 06 a0 00 00           MOV byte ptr [0xa0],0x0
// 1000:0dcc      c6 06 a1 00 00           MOV byte ptr [0xa1],0x0
// 1000:0dd1      c6 06 96 00 00           MOV byte ptr [0x96],0x0
// 1000:0dd6      c6 06 97 00 00           MOV byte ptr [0x97],0x0
// 1000:0ddb      bf 00 00                 MOV DI,0x0
// 1000:0dde      b9 c8 00                 MOV CX,0xc8
// 1000:0de1  LAB_1000_0de1:
// 1000:0de1      b0 20                    MOV AL,0x20
// 1000:0de3      bb 96 00                 MOV BX,0x96
// 1000:0de6      e8 a8 00                 CALL 0x1000:0e91
// 1000:0de9      e2 f6                    LOOP 0x1000:0de1
// 1000:0deb      e8 82 00                 CALL 0x1000:0e70
//                 ; encoded string -> 1000:0e1a  <c1>------------- RECEIVE AREA -------------
// 1000:0e1a  LAB_1000_0e1a:
// 1000:0e1a      b9 68 01                 MOV CX,0x168
// 1000:0e1d  LAB_1000_0e1d:
// 1000:0e1d      b0 20                    MOV AL,0x20
// 1000:0e1f      bb 96 00                 MOV BX,0x96
// 1000:0e22      e8 6c 00                 CALL 0x1000:0e91
// 1000:0e25      e2 f6                    LOOP 0x1000:0e1d
// 1000:0e27      e8 46 00                 CALL 0x1000:0e70
//                 ; encoded string -> 1000:0e56  <c1>--------------- SEND AREA --------------
// 1000:0e56  LAB_1000_0e56:
// 1000:0e56      b9 68 01                 MOV CX,0x168
// 1000:0e59  LAB_1000_0e59:
// 1000:0e59      b0 20                    MOV AL,0x20
// 1000:0e5b      bb 96 00                 MOV BX,0x96
// 1000:0e5e      e8 30 00                 CALL 0x1000:0e91
// 1000:0e61      e2 f6                    LOOP 0x1000:0e59
// 1000:0e63      bb a0 00                 MOV BX,0xa0
// 1000:0e66      e8 f3 00                 CALL 0x1000:0f5c
// 1000:0e69      bb 9b 00                 MOV BX,0x9b
// 1000:0e6c      e8 ed 00                 CALL 0x1000:0f5c
// 1000:0e6f      c3                       RET
fun_0dbd :: proc() {
}

// @proc 1000:0e70
// listing: print_encoded
// status: unread
// 1000:0e70  print_encoded:
// 1000:0e70      5b                       POP BX
// 1000:0e71      c6 06 64 a2 01           MOV byte ptr [0xa264],0x1
// 1000:0e76  LAB_1000_0e76:
// 1000:0e76      2e 8a 07                 MOV AL,byte ptr CS:[BX]
// 1000:0e79      e8 f0 4a                 CALL 0x1000:596c
// 1000:0e7c      43                       INC BX
// 1000:0e7d      22 c0                    AND AL,AL
// 1000:0e7f      74 0e                    JZ 0x1000:0e8f
// 1000:0e81      3c 04                    CMP AL,0x4
// 1000:0e83      72 f1                    JC 0x1000:0e76
// 1000:0e85      53                       PUSH BX
// 1000:0e86      bb 96 00                 MOV BX,0x96
// 1000:0e89      e8 05 00                 CALL 0x1000:0e91
// 1000:0e8c      5b                       POP BX
// 1000:0e8d      eb e7                    JMP 0x1000:0e76
// 1000:0e8f  LAB_1000_0e8f:
// 1000:0e8f      ff e3                    JMP BX
fun_0e70 :: proc() {
}

// @proc 1000:0e91
// listing: FUN_1000_0e91
// notes: terminal_putc
// status: unread
// 1000:0e91  FUN_1000_0e91:
// 1000:0e91      e8 c8 00                 CALL 0x1000:0f5c
// 1000:0e94      e8 a9 00                 CALL 0x1000:0f40
// 1000:0e97      3c 0d                    CMP AL,0xd
// 1000:0e99      75 06                    JNZ 0x1000:0ea1
// 1000:0e9b      c6 07 00                 MOV byte ptr [BX],0x0
// 1000:0e9e      eb 57                    JMP 0x1000:0ef7
// 1000:0ea1  LAB_1000_0ea1:
// 1000:0ea1      3c 0a                    CMP AL,0xa
// 1000:0ea3      75 06                    JNZ 0x1000:0eab
// 1000:0ea5      fe 47 01                 INC byte ptr [BX + 0x1]
// 1000:0ea8      eb 3a                    JMP 0x1000:0ee4
// 1000:0eab  LAB_1000_0eab:
// 1000:0eab      3c 07                    CMP AL,0x7
// 1000:0ead      75 09                    JNZ 0x1000:0eb8
// 1000:0eaf      c7 06 5a a2 04 00        MOV word ptr [0xa25a],0x4
// 1000:0eb5      eb 40                    JMP 0x1000:0ef7
// 1000:0eb8  LAB_1000_0eb8:
// 1000:0eb8      3c 08                    CMP AL,0x8
// 1000:0eba      75 14                    JNZ 0x1000:0ed0
// 1000:0ebc      80 3f 00                 CMP byte ptr [BX],0x0
// 1000:0ebf      74 36                    JZ 0x1000:0ef7
// 1000:0ec1      fe 0f                    DEC byte ptr [BX]
// 1000:0ec3      83 ef 02                 SUB DI,0x2
// 1000:0ec6      b0 20                    MOV AL,0x20
// 1000:0ec8      e8 20 03                 CALL 0x1000:11eb
// 1000:0ecb      b0 08                    MOV AL,0x8
// 1000:0ecd      eb 28                    JMP 0x1000:0ef7
// 1000:0ed0  LAB_1000_0ed0:
// 1000:0ed0      3c 20                    CMP AL,0x20
// 1000:0ed2      72 23                    JC 0x1000:0ef7
// 1000:0ed4      e8 14 03                 CALL 0x1000:11eb
// 1000:0ed7      fe 07                    INC byte ptr [BX]
// 1000:0ed9      80 3f 28                 CMP byte ptr [BX],0x28
// 1000:0edc      72 06                    JC 0x1000:0ee4
// 1000:0ede      c6 07 00                 MOV byte ptr [BX],0x0
// 1000:0ee1      fe 47 01                 INC byte ptr [BX + 0x1]
// 1000:0ee4  LAB_1000_0ee4:
// 1000:0ee4      8a 67 01                 MOV AH,byte ptr [BX + 0x1]
// 1000:0ee7      3a 67 02                 CMP AH,byte ptr [BX + 0x2]
// 1000:0eea      72 0b                    JC 0x1000:0ef7
// 1000:0eec      8a 67 02                 MOV AH,byte ptr [BX + 0x2]
// 1000:0eef      fe cc                    DEC AH
// 1000:0ef1      88 67 01                 MOV byte ptr [BX + 0x1],AH
// 1000:0ef4      e8 04 00                 CALL 0x1000:0efb
// 1000:0ef7  LAB_1000_0ef7:
// 1000:0ef7      e8 62 00                 CALL 0x1000:0f5c
// 1000:0efa      c3                       RET
fun_0e91 :: proc() {
}

// @proc 1000:0efb
// listing: FUN_1000_0efb
// status: unread
// video: scrolls and clears CGA memory at segment B800. The store stays stubbed.
// 1000:0efb  FUN_1000_0efb:
// 1000:0efb      50                       PUSH AX
// 1000:0efc      1e                       PUSH DS
// 1000:0efd      06                       PUSH ES
// 1000:0efe      57                       PUSH DI
// 1000:0eff      56                       PUSH SI
// 1000:0f00      53                       PUSH BX
// 1000:0f01      51                       PUSH CX
// 1000:0f02      8b 7f 03                 MOV DI,word ptr [BX + 0x3]
// 1000:0f05      57                       PUSH DI
// 1000:0f06      b8 00 b8                 MOV AX,0xb800
// 1000:0f09      8e d8                    MOV DS,AX
// 1000:0f0b      8e c0                    MOV ES,AX
// 1000:0f0d      8b f7                    MOV SI,DI
// 1000:0f0f      81 c6 40 01              ADD SI,0x140
// 1000:0f13      b9 00 05                 MOV CX,0x500
// 1000:0f16      f3 a5                    MOVSW.REP ES:DI,SI
// 1000:0f18      b8 00 00                 MOV AX,0x0
// 1000:0f1b      b9 a0 00                 MOV CX,0xa0
// 1000:0f1e      f3 ab                    STOSW.REP ES:DI
// 1000:0f20      5f                       POP DI
// 1000:0f21      81 c7 00 20              ADD DI,0x2000
// 1000:0f25      8b f7                    MOV SI,DI
// 1000:0f27      81 c6 40 01              ADD SI,0x140
// 1000:0f2b      b9 00 05                 MOV CX,0x500
// 1000:0f2e      f3 a5                    MOVSW.REP ES:DI,SI
// 1000:0f30      b8 00 00                 MOV AX,0x0
// 1000:0f33      b9 a0 00                 MOV CX,0xa0
// 1000:0f36      f3 ab                    STOSW.REP ES:DI
// 1000:0f38      59                       POP CX
// 1000:0f39      5b                       POP BX
// 1000:0f3a      5e                       POP SI
// 1000:0f3b      5f                       POP DI
// 1000:0f3c      07                       POP ES
// 1000:0f3d      1f                       POP DS
// 1000:0f3e      58                       POP AX
// 1000:0f3f      c3                       RET
fun_0efb :: proc() {
}

// @proc 1000:0f40
// listing: FUN_1000_0f40
// status: unread
// 1000:0f40  FUN_1000_0f40:
// 1000:0f40      50                       PUSH AX
// 1000:0f41      51                       PUSH CX
// 1000:0f42      8a 47 01                 MOV AL,byte ptr [BX + 0x1]
// 1000:0f45      32 e4                    XOR AH,AH
// 1000:0f47      b9 40 01                 MOV CX,0x140
// 1000:0f4a      f7 e1                    MUL CX
// 1000:0f4c      8b 7f 03                 MOV DI,word ptr [BX + 0x3]
// 1000:0f4f      03 f8                    ADD DI,AX
// 1000:0f51      8a 07                    MOV AL,byte ptr [BX]
// 1000:0f53      32 e4                    XOR AH,AH
// 1000:0f55      d1 e0                    SHL AX,0x1
// 1000:0f57      03 f8                    ADD DI,AX
// 1000:0f59      59                       POP CX
// 1000:0f5a      58                       POP AX
// 1000:0f5b      c3                       RET
fun_0f40 :: proc() {
}

// @proc 1000:0f5c
// listing: FUN_1000_0f5c
// status: unread
// video: inverts words in CGA memory at segment B800. The store stays stubbed.
// 1000:0f5c  FUN_1000_0f5c:
// 1000:0f5c      81 fb 96 00              CMP BX,0x96
// 1000:0f60      74 22                    JZ 0x1000:0f84
// 1000:0f62      50                       PUSH AX
// 1000:0f63      06                       PUSH ES
// 1000:0f64      51                       PUSH CX
// 1000:0f65      e8 d8 ff                 CALL 0x1000:0f40
// 1000:0f68      b8 00 b8                 MOV AX,0xb800
// 1000:0f6b      8e c0                    MOV ES,AX
// 1000:0f6d      b9 04 00                 MOV CX,0x4
// 1000:0f70  LAB_1000_0f70:
// 1000:0f70      26 81 35 55 55           XOR word ptr ES:[DI],0x5555
// 1000:0f75      26 81 b5 00 20 55 55     XOR word ptr ES:[DI + 0x2000],0x5555
// 1000:0f7c      83 c7 50                 ADD DI,0x50
// 1000:0f7f      e2 ef                    LOOP 0x1000:0f70
// 1000:0f81      59                       POP CX
// 1000:0f82      07                       POP ES
// 1000:0f83      58                       POP AX
// 1000:0f84  LAB_1000_0f84:
// 1000:0f84      c3                       RET
fun_0f5c :: proc() {
}

// @proc 1000:11eb
// listing: FUN_1000_11eb
// status: unread
// video: stores glyph words into CGA memory at segment B800. The store stays stubbed.
// 1000:11eb  FUN_1000_11eb:
// 1000:11eb      50                       PUSH AX
// 1000:11ec      06                       PUSH ES
// 1000:11ed      56                       PUSH SI
// 1000:11ee      57                       PUSH DI
// 1000:11ef      51                       PUSH CX
// 1000:11f0      b9 00 b8                 MOV CX,0xb800
// 1000:11f3      8e c1                    MOV ES,CX
// 1000:11f5      8b 36 16 00              MOV SI,word ptr [0x16]
// 1000:11f9      b9 04 00                 MOV CX,0x4
// 1000:11fc      25 7f 00                 AND AX,0x7f
// 1000:11ff      d3 e0                    SHL AX,CL
// 1000:1201      03 f0                    ADD SI,AX
// 1000:1203  LAB_1000_1203:
// 1000:1203      ad                       LODSW SI
// 1000:1204      26 89 05                 MOV word ptr ES:[DI],AX
// 1000:1207      ad                       LODSW SI
// 1000:1208      26 89 85 00 20           MOV word ptr ES:[DI + 0x2000],AX
// 1000:120d      83 c7 50                 ADD DI,0x50
// 1000:1210      e2 f1                    LOOP 0x1000:1203
// 1000:1212      59                       POP CX
// 1000:1213      5f                       POP DI
// 1000:1214      5e                       POP SI
// 1000:1215      07                       POP ES
// 1000:1216      58                       POP AX
// 1000:1217      c3                       RET
fun_11eb :: proc() {
}

// @proc 1000:4530
// listing: FUN_1000_4530
// notes: draw_hud
// status: unread
// 1000:4530  FUN_1000_4530:
// 1000:4530      80 3e 71 a2 01           CMP byte ptr [0xa271],0x1
// 1000:4535      74 03                    JZ 0x1000:453a
// 1000:4537      e8 16 0f                 CALL 0x1000:5450
// 1000:453a  LAB_1000_453a:
// 1000:453a      a0 6f a2                 MOV AL,[0xa26f]
// 1000:453d      a2 74 a2                 MOV [0xa274],AL
// 1000:4540      e8 19 0e                 CALL 0x1000:535c
// 1000:4543      8a 07                    MOV AL,byte ptr [BX]
// 1000:4545      f6 07 10                 TEST byte ptr [BX],0x10
// 1000:4548      74 40                    JZ 0x1000:458a
// 1000:454a      c6 06 99 a2 00           MOV byte ptr [0xa299],0x0
// 1000:454f      e8 7c d9                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:455a  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
// 1000:455a  LAB_1000_455a:
// 1000:455a      b4 10                    MOV AH,0x10
// 1000:455c      b0 00                    MOV AL,0x0
// 1000:455e      80 7f 0d 00              CMP byte ptr [BX + 0xd],0x0
// 1000:4562      74 1c                    JZ 0x1000:4580
// 1000:4564      8a 67 05                 MOV AH,byte ptr [BX + 0x5]
// 1000:4567      8a 1f                    MOV BL,byte ptr [BX]
// 1000:4569      b0 00                    MOV AL,0x0
// 1000:456b      80 e3 07                 AND BL,0x7
// 1000:456e      74 10                    JZ 0x1000:4580
// 1000:4570      b0 03                    MOV AL,0x3
// 1000:4572      80 fb 04                 CMP BL,0x4
// 1000:4575      73 09                    JNC 0x1000:4580
// 1000:4577      b0 02                    MOV AL,0x2
// 1000:4579      80 fb 02                 CMP BL,0x2
// 1000:457c      73 02                    JNC 0x1000:4580
// 1000:457e      b0 01                    MOV AL,0x1
// 1000:4580  LAB_1000_4580:
// 1000:4580      88 26 60 a3              MOV byte ptr [0xa360],AH
// 1000:4584      e8 dd 0e                 CALL 0x1000:5464
// 1000:4587      eb 7e                    JMP 0x1000:4607
// 1000:458a  LAB_1000_458a:
// 1000:458a      e8 7f e4                 CALL 0x1000:2a0c
// 1000:458d      89 36 97 a2              MOV word ptr [0xa297],SI
// 1000:4591      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
// 1000:4594      a2 60 a3                 MOV [0xa360],AL
// 1000:4597      8a 04                    MOV AL,byte ptr [SI]
// 1000:4599      e8 c8 0e                 CALL 0x1000:5464
// 1000:459c      8a 44 0e                 MOV AL,byte ptr [SI + 0xe]
// 1000:459f      d0 e0                    SHL AL,0x1
// 1000:45a1      d0 e0                    SHL AL,0x1
// 1000:45a3      fa                       CLI
// 1000:45a4      80 26 99 a2 03           AND byte ptr [0xa299],0x3
// 1000:45a9      08 06 99 a2              OR byte ptr [0xa299],AL
// 1000:45ad      fb                       STI
// 1000:45ae      24 f0                    AND AL,0xf0
// 1000:45b0      75 0b                    JNZ 0x1000:45bd
// 1000:45b2      80 3e 66 a2 00           CMP byte ptr [0xa266],0x0
// 1000:45b7      eb 04                    JMP 0x1000:45bd
// 1000:45bd  LAB_1000_45bd:
// 1000:45bd      8a 44 0a                 MOV AL,byte ptr [SI + 0xa]
// 1000:45c0      e8 4e 11                 CALL 0x1000:5711
// 1000:45c3      8b 36 97 a2              MOV SI,word ptr [0xa297]
// 1000:45c7      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
// 1000:45ca      e8 e3 10                 CALL 0x1000:56b0
// 1000:45cd      8b 36 97 a2              MOV SI,word ptr [0xa297]
// 1000:45d1      8a 44 06                 MOV AL,byte ptr [SI + 0x6]
// 1000:45d4      e8 87 11                 CALL 0x1000:575e
// 1000:45d7      8b 36 97 a2              MOV SI,word ptr [0xa297]
// 1000:45db      8a 44 07                 MOV AL,byte ptr [SI + 0x7]
// 1000:45de      e8 97 11                 CALL 0x1000:5778
// 1000:45e1      8b 36 97 a2              MOV SI,word ptr [0xa297]
// 1000:45e5      8a 44 14                 MOV AL,byte ptr [SI + 0x14]
// 1000:45e8      ba 22 00                 MOV DX,0x22
// 1000:45eb      be 41 1d                 MOV SI,0x1d41
// 1000:45ee      e8 be 11                 CALL 0x1000:57af
// 1000:45f1      8b 36 97 a2              MOV SI,word ptr [0xa297]
// 1000:45f5      8a 44 0f                 MOV AL,byte ptr [SI + 0xf]
// 1000:45f8      ba 2c 00                 MOV DX,0x2c
// 1000:45fb      be 1b 1d                 MOV SI,0x1d1b
// 1000:45fe      e8 ae 11                 CALL 0x1000:57af
// 1000:4601      e8 88 10                 CALL 0x1000:568c
// 1000:4604      e8 71 10                 CALL 0x1000:5678
// 1000:4607  LAB_1000_4607:
// 1000:4607      e8 65 00                 CALL 0x1000:466f
// 1000:460a      e8 0a 06                 CALL 0x1000:4c17
// 1000:460d      e8 99 0a                 CALL 0x1000:50a9
// 1000:4610      e8 08 0b                 CALL 0x1000:511b
// 1000:4613      e8 9a 0e                 CALL 0x1000:54b0
// 1000:4616      c3                       RET
fun_4530 :: proc() {
}

// @proc 1000:4649
// listing: FUN_1000_4649
// notes: cga_blink_tick
// status: unread
// video: writes CGA color-select port 0x3D9. host_color_select is the seam. The body stays empty.
// 1000:4649  FUN_1000_4649:
// 1000:4649      52                       PUSH DX
// 1000:464a      51                       PUSH CX
// 1000:464b      a0 15 00                 MOV AL,[0x15]
// 1000:464e      24 01                    AND AL,0x1
// 1000:4650      75 1a                    JNZ 0x1000:466c
// 1000:4652      b0 10                    MOV AL,0x10
// 1000:4654      80 3e 99 a2 00           CMP byte ptr [0xa299],0x0
// 1000:4659      74 0d                    JZ 0x1000:4668
// 1000:465b      fe 0e 99 a2              DEC byte ptr [0xa299]
// 1000:465f      f6 06 99 a2 01           TEST byte ptr [0xa299],0x1
// 1000:4664      74 02                    JZ 0x1000:4668
// 1000:4666      0c 04                    OR AL,0x4
// 1000:4668  LAB_1000_4668:
// 1000:4668      ba d9 03                 MOV DX,0x3d9
// 1000:466b      ee                       OUT DX,AL
// 1000:466c  LAB_1000_466c:
// 1000:466c      59                       POP CX
// 1000:466d      5a                       POP DX
// 1000:466e      c3                       RET
fun_4649 :: proc() {
}

// @proc 1000:466f
// listing: FUN_1000_466f
// notes: draw_status_text
// status: unread
// 1000:466f  FUN_1000_466f:
// 1000:466f      e8 ea 0c                 CALL 0x1000:535c
// 1000:4672      f6 07 10                 TEST byte ptr [BX],0x10
// 1000:4675      74 03                    JZ 0x1000:467a
// 1000:4677      e9 db 01                 JMP 0x1000:4855
// 1000:467a  LAB_1000_467a:
// 1000:467a      b9 36 00                 MOV CX,0x36
// 1000:467d      ba 38 00                 MOV DX,0x38
// 1000:4680      e8 e6 0f                 CALL 0x1000:5669
// 1000:4683      e8 ce 0e                 CALL 0x1000:5554
//                 ; cstring -> 1000:468d  <c1>Ship 
// 1000:468d  LAB_1000_468d:
// 1000:468d      e8 cc 0c                 CALL 0x1000:535c
// 1000:4690      8a 07                    MOV AL,byte ptr [BX]
// 1000:4692      24 03                    AND AL,0x3
// 1000:4694      fe c0                    INC AL
// 1000:4696      04 30                    ADD AL,0x30
// 1000:4698      32 e4                    XOR AH,AH
// 1000:469a      e8 de 0e                 CALL 0x1000:557b
// 1000:469d      e8 b4 0e                 CALL 0x1000:5554
//                 ; cstring -> 1000:46a4   E=
// 1000:46a4  LAB_1000_46a4:
// 1000:46a4      e8 b5 0c                 CALL 0x1000:535c
// 1000:46a7      8a 07                    MOV AL,byte ptr [BX]
// 1000:46a9      e8 60 e3                 CALL 0x1000:2a0c
// 1000:46ac      8b 44 08                 MOV AX,word ptr [SI + 0x8]
// 1000:46af      e8 5c 0d                 CALL 0x1000:540e
// 1000:46b2      b9 36 00                 MOV CX,0x36
// 1000:46b5      ba 40 00                 MOV DX,0x40
// 1000:46b8      e8 ae 0f                 CALL 0x1000:5669
// 1000:46bb      8a 64 11                 MOV AH,byte ptr [SI + 0x11]
// 1000:46be      80 e4 1f                 AND AH,0x1f
// 1000:46c1      75 03                    JNZ 0x1000:46c6
// 1000:46c3      eb 20                    JMP 0x1000:46e5
// 1000:46c6  LAB_1000_46c6:
// 1000:46c6      e8 8b 0e                 CALL 0x1000:5554
//                 ; cstring -> 1000:46d2  Seeking 
// 1000:46d2  LAB_1000_46d2:
// 1000:46d2      e8 ae 04                 CALL 0x1000:4b83
// 1000:46d5      e8 7c 0e                 CALL 0x1000:5554
//                 ; cstring -> 1000:46da   
// 1000:46da  LAB_1000_46da:
// 1000:46da      8b 44 12                 MOV AX,word ptr [SI + 0x12]
// 1000:46dd      3d 0f 27                 CMP AX,0x270f
// 1000:46e0      77 03                    JA 0x1000:46e5
// 1000:46e2      e8 30 0d                 CALL 0x1000:5415
// 1000:46e5  LAB_1000_46e5:
// 1000:46e5      f6 06 12 00 02           TEST byte ptr [0x12],0x2
// 1000:46ea      74 1f                    JZ 0x1000:470b
// 1000:46ec      b9 36 00                 MOV CX,0x36
// 1000:46ef      ba 48 00                 MOV DX,0x48
// 1000:46f2      e8 74 0f                 CALL 0x1000:5669
// 1000:46f5      e8 5c 0e                 CALL 0x1000:5554
//                 ; cstring -> 1000:4703  <c1>  Level  
// 1000:4703  LAB_1000_4703:
// 1000:4703      a0 60 a3                 MOV AL,[0xa360]
// 1000:4706      04 41                    ADD AL,0x41
// 1000:4708      e8 6c 0e                 CALL 0x1000:5577
// 1000:470b  LAB_1000_470b:
// 1000:470b      b9 36 00                 MOV CX,0x36
// 1000:470e      ba 50 00                 MOV DX,0x50
// 1000:4711      e8 55 0f                 CALL 0x1000:5669
// 1000:4714      e8 3d 0e                 CALL 0x1000:5554
//                 ; cstring -> 1000:4722  <c1>Weapons  
// 1000:4722  LAB_1000_4722:
// 1000:4722      80 7c 15 00              CMP byte ptr [SI + 0x15],0x0
// 1000:4726      74 22                    JZ 0x1000:474a
// 1000:4728      80 7c 15 0c              CMP byte ptr [SI + 0x15],0xc
// 1000:472c      76 0b                    JBE 0x1000:4739
// 1000:472e      e8 23 0e                 CALL 0x1000:5554
//                 ; cstring -> 1000:4737  <c2>INOP
// 1000:4737  LAB_1000_4737:
// 1000:4737      eb 2d                    JMP 0x1000:4766
// 1000:4739  LAB_1000_4739:
// 1000:4739      f6 44 19 ff              TEST byte ptr [SI + 0x19],0xff
// 1000:473d      75 11                    JNZ 0x1000:4750
// 1000:473f      e8 12 0e                 CALL 0x1000:5554
//                 ; cstring -> 1000:4748  <c3>Wait
// 1000:4748  LAB_1000_4748:
// 1000:4748      eb 1c                    JMP 0x1000:4766
// 1000:474a  LAB_1000_474a:
// 1000:474a      f6 44 19 ff              TEST byte ptr [SI + 0x19],0xff
// 1000:474e      74 0c                    JZ 0x1000:475c
// 1000:4750  LAB_1000_4750:
// 1000:4750      e8 01 0e                 CALL 0x1000:5554
//                 ; cstring -> 1000:475a  <c3>Fired
// 1000:475a  LAB_1000_475a:
// 1000:475a      eb 0a                    JMP 0x1000:4766
// 1000:475c  LAB_1000_475c:
// 1000:475c      e8 f5 0d                 CALL 0x1000:5554
//                 ; cstring -> 1000:4766  <c1>Ready
// 1000:4766  LAB_1000_4766:
// 1000:4766      b9 36 00                 MOV CX,0x36
// 1000:4769      ba 58 00                 MOV DX,0x58
// 1000:476c      e8 fa 0e                 CALL 0x1000:5669
// 1000:476f      e8 e2 0d                 CALL 0x1000:5554
//                 ; cstring -> 1000:477d  <c1>Shields  
// 1000:477d  LAB_1000_477d:
// 1000:477d      80 7c 0e 08              CMP byte ptr [SI + 0xe],0x8
// 1000:4781      72 0b                    JC 0x1000:478e
// 1000:4783      e8 ce 0d                 CALL 0x1000:5554
//                 ; cstring -> 1000:478c  <c2>INOP
// 1000:478c  LAB_1000_478c:
// 1000:478c      eb 1b                    JMP 0x1000:47a9
// 1000:478e  LAB_1000_478e:
// 1000:478e      f6 04 20                 TEST byte ptr [SI],0x20
// 1000:4791      74 0c                    JZ 0x1000:479f
// 1000:4793      e8 be 0d                 CALL 0x1000:5554
//                 ; cstring -> 1000:479d  <c3>Up   
// 1000:479d  LAB_1000_479d:
// 1000:479d      eb 0a                    JMP 0x1000:47a9
// 1000:479f  LAB_1000_479f:
// 1000:479f      e8 b2 0d                 CALL 0x1000:5554
//                 ; cstring -> 1000:47a9  <c1>Down 
// 1000:47a9  LAB_1000_47a9:
// 1000:47a9      b9 36 00                 MOV CX,0x36
// 1000:47ac      ba 60 00                 MOV DX,0x60
// 1000:47af      e8 b7 0e                 CALL 0x1000:5669
// 1000:47b2      e8 9f 0d                 CALL 0x1000:5554
//                 ; cstring -> 1000:47c0  <c1>Scanner  
// 1000:47c0  LAB_1000_47c0:
// 1000:47c0      80 3e 70 a2 02           CMP byte ptr [0xa270],0x2
// 1000:47c5      77 0b                    JA 0x1000:47d2
// 1000:47c7      e8 8a 0d                 CALL 0x1000:5554
//                 ; cstring -> 1000:47d0  Short
// 1000:47d0  LAB_1000_47d0:
// 1000:47d0      eb 28                    JMP 0x1000:47fa
// 1000:47d2  LAB_1000_47d2:
// 1000:47d2      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
// 1000:47d7      77 09                    JA 0x1000:47e2
// 1000:47d9      e8 78 0d                 CALL 0x1000:5554
//                 ; cstring -> 1000:47e0  Med
// 1000:47e0  LAB_1000_47e0:
// 1000:47e0      eb 18                    JMP 0x1000:47fa
// 1000:47e2  LAB_1000_47e2:
// 1000:47e2      80 3e 70 a2 06           CMP byte ptr [0xa270],0x6
// 1000:47e7      77 0a                    JA 0x1000:47f3
// 1000:47e9      e8 68 0d                 CALL 0x1000:5554
//                 ; cstring -> 1000:47f1  Long
// 1000:47f1  LAB_1000_47f1:
// 1000:47f1      eb 07                    JMP 0x1000:47fa
// 1000:47f3  LAB_1000_47f3:
// 1000:47f3      e8 5e 0d                 CALL 0x1000:5554
//                 ; cstring -> 1000:47fa  Map
// 1000:47fa  LAB_1000_47fa:
// 1000:47fa      b9 36 00                 MOV CX,0x36
// 1000:47fd      ba 68 00                 MOV DX,0x68
// 1000:4800      e8 66 0e                 CALL 0x1000:5669
// 1000:4803      e8 4e 0d                 CALL 0x1000:5554
//                 ; cstring -> 1000:4811  <c1>Computer 
// 1000:4811  LAB_1000_4811:
// 1000:4811      80 7c 0e 0c              CMP byte ptr [SI + 0xe],0xc
// 1000:4815      73 0b                    JNC 0x1000:4822
// 1000:4817      e8 3a 0d                 CALL 0x1000:5554
//                 ; cstring -> 1000:4820  Ready
// 1000:4820  LAB_1000_4820:
// 1000:4820      eb 09                    JMP 0x1000:482b
// 1000:4822  LAB_1000_4822:
// 1000:4822      e8 2f 0d                 CALL 0x1000:5554
//                 ; cstring -> 1000:482b  <c2>INOP
// 1000:482b  LAB_1000_482b:
// 1000:482b      b9 36 00                 MOV CX,0x36
// 1000:482e      ba 70 00                 MOV DX,0x70
// 1000:4831      e8 35 0e                 CALL 0x1000:5669
// 1000:4834      e8 1d 0d                 CALL 0x1000:5554
//                 ; cstring -> 1000:4842  <c1>Fire Ctl 
// 1000:4842  LAB_1000_4842:
// 1000:4842      8a 44 2b                 MOV AL,byte ptr [SI + 0x2b]
// 1000:4845      3a 44 17                 CMP AL,byte ptr [SI + 0x17]
// 1000:4848      74 06                    JZ 0x1000:4850
// 1000:484a      24 03                    AND AL,0x3
// 1000:484c      04 41                    ADD AL,0x41
// 1000:484e      eb 02                    JMP 0x1000:4852
// 1000:4850  LAB_1000_4850:
// 1000:4850      b0 2a                    MOV AL,0x2a
// 1000:4852  LAB_1000_4852:
// 1000:4852      e8 22 0d                 CALL 0x1000:5577
// 1000:4855  LAB_1000_4855:
// 1000:4855      b9 36 00                 MOV CX,0x36
// 1000:4858      ba 80 00                 MOV DX,0x80
// 1000:485b      e8 0b 0e                 CALL 0x1000:5669
// 1000:485e      e8 6d d6                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:4869  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
// 1000:4869  LAB_1000_4869:
// 1000:4869      80 7f 0d 00              CMP byte ptr [BX + 0xd],0x0
// 1000:486d      75 15                    JNZ 0x1000:4884
// 1000:486f      e8 e2 0c                 CALL 0x1000:5554
//                 ; cstring -> 1000:4881  <c1>   BASE DEAD!
// 1000:4881  LAB_1000_4881:
// 1000:4881      e9 89 00                 JMP 0x1000:490d
// 1000:4884  LAB_1000_4884:
// 1000:4884      8a 07                    MOV AL,byte ptr [BX]
// 1000:4886      a8 80                    TEST AL,0x80
// 1000:4888      74 09                    JZ 0x1000:4893
// 1000:488a      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
// 1000:488f      74 2b                    JZ 0x1000:48bc
// 1000:4891      eb 1e                    JMP 0x1000:48b1
// 1000:4893  LAB_1000_4893:
// 1000:4893      24 07                    AND AL,0x7
// 1000:4895      75 0b                    JNZ 0x1000:48a2
// 1000:4897      e8 ba 0c                 CALL 0x1000:5554
//                 ; cstring -> 1000:48a0  <c1>Base
// 1000:48a0  LAB_1000_48a0:
// 1000:48a0      eb 23                    JMP 0x1000:48c5
// 1000:48a2  LAB_1000_48a2:
// 1000:48a2      3c 01                    CMP AL,0x1
// 1000:48a4      75 0b                    JNZ 0x1000:48b1
// 1000:48a6      e8 ab 0c                 CALL 0x1000:5554
//                 ; cstring -> 1000:48af  <c3>Base
// 1000:48af  LAB_1000_48af:
// 1000:48af      eb 14                    JMP 0x1000:48c5
// 1000:48b1  LAB_1000_48b1:
// 1000:48b1      e8 a0 0c                 CALL 0x1000:5554
//                 ; cstring -> 1000:48ba  <c2>Base
// 1000:48ba  LAB_1000_48ba:
// 1000:48ba      eb 09                    JMP 0x1000:48c5
// 1000:48bc  LAB_1000_48bc:
// 1000:48bc      e8 95 0c                 CALL 0x1000:5554
//                 ; cstring -> 1000:48c5  <c1>    
// 1000:48c5  LAB_1000_48c5:
// 1000:48c5      e8 8c 0c                 CALL 0x1000:5554
//                 ; cstring -> 1000:48ce  <c1>  E=
// 1000:48ce  LAB_1000_48ce:
// 1000:48ce      e8 fd d5                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:48d9  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
// 1000:48d9  LAB_1000_48d9:
// 1000:48d9      8b f3                    MOV SI,BX
// 1000:48db      8b 44 08                 MOV AX,word ptr [SI + 0x8]
// 1000:48de      e8 2d 0b                 CALL 0x1000:540e
// 1000:48e1      e8 70 0c                 CALL 0x1000:5554
//                 ; cstring -> 1000:48e6  0
// 1000:48e6  LAB_1000_48e6:
// 1000:48e6      b9 36 00                 MOV CX,0x36
// 1000:48e9      ba 88 00                 MOV DX,0x88
// 1000:48ec      e8 7a 0d                 CALL 0x1000:5669
// 1000:48ef      e8 62 0c                 CALL 0x1000:5554
//                 ; cstring -> 1000:48f5  T=
// 1000:48f5  LAB_1000_48f5:
// 1000:48f5      8a 44 07                 MOV AL,byte ptr [SI + 0x7]
// 1000:48f8      b3 20                    MOV BL,0x20
// 1000:48fa      e8 1f 0b                 CALL 0x1000:541c
// 1000:48fd      e8 54 0c                 CALL 0x1000:5554
//                 ; cstring -> 1000:4905    M=
// 1000:4905  LAB_1000_4905:
// 1000:4905      8a 44 06                 MOV AL,byte ptr [SI + 0x6]
// 1000:4908      b3 20                    MOV BL,0x20
// 1000:490a      e8 16 0b                 CALL 0x1000:5423
// 1000:490d  LAB_1000_490d:
// 1000:490d      e8 4c 0a                 CALL 0x1000:535c
// 1000:4910      f6 07 10                 TEST byte ptr [BX],0x10
// 1000:4913      74 03                    JZ 0x1000:4918
// 1000:4915      e8 27 01                 CALL 0x1000:4a3f
// 1000:4918  LAB_1000_4918:
// 1000:4918      e8 53 00                 CALL 0x1000:496e
// 1000:491b      e8 01 00                 CALL 0x1000:491f
// 1000:491e      c3                       RET
fun_466f :: proc() {
}

// @proc 1000:491f
// listing: FUN_1000_491f
// status: unread
// 1000:491f  FUN_1000_491f:
// 1000:491f      c6 06 9b a2 03           MOV byte ptr [0xa29b],0x3
// 1000:4924      f6 06 12 00 01           TEST byte ptr [0x12],0x1
// 1000:4929      74 17                    JZ 0x1000:4942
// 1000:492b      b9 40 00                 MOV CX,0x40
// 1000:492e      ba bb 00                 MOV DX,0xbb
// 1000:4931      e8 35 0d                 CALL 0x1000:5669
// 1000:4934      80 3e 07 a2 00           CMP byte ptr [0xa207],0x0
// 1000:4939      75 1d                    JNZ 0x1000:4958
// 1000:493b      c6 06 9b a2 02           MOV byte ptr [0xa29b],0x2
// 1000:4940      eb 16                    JMP 0x1000:4958
// 1000:4942  LAB_1000_4942:
// 1000:4942      b9 3c 00                 MOV CX,0x3c
// 1000:4945      ba bb 00                 MOV DX,0xbb
// 1000:4948      e8 1e 0d                 CALL 0x1000:5669
// 1000:494b      a0 08 a2                 MOV AL,[0xa208]
// 1000:494e      b3 30                    MOV BL,0x30
// 1000:4950      e8 d0 0a                 CALL 0x1000:5423
// 1000:4953      e8 fe 0b                 CALL 0x1000:5554
//                 ; cstring -> 1000:4958  :
// 1000:4958  LAB_1000_4958:
// 1000:4958      a0 07 a2                 MOV AL,[0xa207]
// 1000:495b      b3 30                    MOV BL,0x30
// 1000:495d      e8 c3 0a                 CALL 0x1000:5423
// 1000:4960      e8 f1 0b                 CALL 0x1000:5554
//                 ; cstring -> 1000:4965  :
// 1000:4965  LAB_1000_4965:
// 1000:4965      a0 06 a2                 MOV AL,[0xa206]
// 1000:4968      b3 30                    MOV BL,0x30
// 1000:496a      e8 b6 0a                 CALL 0x1000:5423
// 1000:496d      c3                       RET
fun_491f :: proc() {
}

// @proc 1000:496e
// listing: FUN_1000_496e
// status: unread
// 1000:496e  FUN_1000_496e:
// 1000:496e      e8 5d d5                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:4979  [ptr] 1000:8c64 1000:8d50 1000:8e3c 1000:8f28
// 1000:4979  LAB_1000_4979:
// 1000:4979      8b f3                    MOV SI,BX
// 1000:497b      b0 00                    MOV AL,0x0
// 1000:497d  LAB_1000_497d:
// 1000:497d      f6 04 80                 TEST byte ptr [SI],0x80
// 1000:4980      75 03                    JNZ 0x1000:4985
// 1000:4982      e9 a7 00                 JMP 0x1000:4a2c
// 1000:4985  LAB_1000_4985:
// 1000:4985      50                       PUSH AX
// 1000:4986      b9 36 00                 MOV CX,0x36
// 1000:4989      02 c0                    ADD AL,AL
// 1000:498b      02 c0                    ADD AL,AL
// 1000:498d      02 c0                    ADD AL,AL
// 1000:498f      8a d0                    MOV DL,AL
// 1000:4991      32 f6                    XOR DH,DH
// 1000:4993      81 c2 98 00              ADD DX,0x98
// 1000:4997      e8 cf 0c                 CALL 0x1000:5669
// 1000:499a      f6 44 0e ff              TEST byte ptr [SI + 0xe],0xff
// 1000:499e      74 0c                    JZ 0x1000:49ac
// 1000:49a0      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
// 1000:49a5      74 05                    JZ 0x1000:49ac
// 1000:49a7      b8 20 00                 MOV AX,0x20
// 1000:49aa      eb 06                    JMP 0x1000:49b2
// 1000:49ac  LAB_1000_49ac:
// 1000:49ac      58                       POP AX
// 1000:49ad      50                       PUSH AX
// 1000:49ae      04 31                    ADD AL,0x31
// 1000:49b0      32 e4                    XOR AH,AH
// 1000:49b2  LAB_1000_49b2:
// 1000:49b2      e8 c6 0b                 CALL 0x1000:557b
// 1000:49b5      f6 04 10                 TEST byte ptr [SI],0x10
// 1000:49b8      b8 20 00                 MOV AX,0x20
// 1000:49bb      74 10                    JZ 0x1000:49cd
// 1000:49bd      f6 44 19 f0              TEST byte ptr [SI + 0x19],0xf0
// 1000:49c1      74 07                    JZ 0x1000:49ca
// 1000:49c3      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
// 1000:49c8      75 03                    JNZ 0x1000:49cd
// 1000:49ca  LAB_1000_49ca:
// 1000:49ca      b8 1f 00                 MOV AX,0x1f
// 1000:49cd  LAB_1000_49cd:
// 1000:49cd      e8 ab 0b                 CALL 0x1000:557b
// 1000:49d0      c6 06 9b a2 01           MOV byte ptr [0xa29b],0x1
// 1000:49d5      8b 44 08                 MOV AX,word ptr [SI + 0x8]
// 1000:49d8      e8 33 0a                 CALL 0x1000:540e
// 1000:49db      f6 44 11 80              TEST byte ptr [SI + 0x11],0x80
// 1000:49df      b8 1e 02                 MOV AX,0x21e
// 1000:49e2      75 03                    JNZ 0x1000:49e7
// 1000:49e4      b8 20 00                 MOV AX,0x20
// 1000:49e7  LAB_1000_49e7:
// 1000:49e7      e8 91 0b                 CALL 0x1000:557b
// 1000:49ea      e8 96 01                 CALL 0x1000:4b83
// 1000:49ed      e8 a3 01                 CALL 0x1000:4b93
// 1000:49f0      80 7c 2a 00              CMP byte ptr [SI + 0x2a],0x0
// 1000:49f4      b8 20 00                 MOV AX,0x20
// 1000:49f7      74 21                    JZ 0x1000:4a1a
// 1000:49f9      b0 4d                    MOV AL,0x4d
// 1000:49fb      80 7c 2a 06              CMP byte ptr [SI + 0x2a],0x6
// 1000:49ff      77 0a                    JA 0x1000:4a0b
// 1000:4a01      b4 03                    MOV AH,0x3
// 1000:4a03      80 7c 2a 03              CMP byte ptr [SI + 0x2a],0x3
// 1000:4a07      77 02                    JA 0x1000:4a0b
// 1000:4a09      b4 02                    MOV AH,0x2
// 1000:4a0b  LAB_1000_4a0b:
// 1000:4a0b      80 7c 22 00              CMP byte ptr [SI + 0x22],0x0
// 1000:4a0f      74 09                    JZ 0x1000:4a1a
// 1000:4a11      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
// 1000:4a16      74 02                    JZ 0x1000:4a1a
// 1000:4a18      b0 20                    MOV AL,0x20
// 1000:4a1a  LAB_1000_4a1a:
// 1000:4a1a      e8 5e 0b                 CALL 0x1000:557b
// 1000:4a1d      f6 04 20                 TEST byte ptr [SI],0x20
// 1000:4a20      b8 53 00                 MOV AX,0x53
// 1000:4a23      75 03                    JNZ 0x1000:4a28
// 1000:4a25      b8 20 00                 MOV AX,0x20
// 1000:4a28  LAB_1000_4a28:
// 1000:4a28      e8 50 0b                 CALL 0x1000:557b
// 1000:4a2b      58                       POP AX
// 1000:4a2c  LAB_1000_4a2c:
// 1000:4a2c      fe c0                    INC AL
// 1000:4a2e      83 c6 3b                 ADD SI,0x3b
// 1000:4a31      3c 04                    CMP AL,0x4
// 1000:4a33      74 03                    JZ 0x1000:4a38
// 1000:4a35      e9 45 ff                 JMP 0x1000:497d
// 1000:4a38  LAB_1000_4a38:
// 1000:4a38      c3                       RET
fun_496e :: proc() {
}

// @proc 1000:4a3f
// listing: FUN_1000_4a3f
// status: unread
// 1000:4a3f  FUN_1000_4a3f:
// 1000:4a3f      b8 00 00                 MOV AX,0x0
// 1000:4a42      c7 06 28 01 00 00        MOV word ptr [0x128],0x0
// 1000:4a48  LAB_1000_4a48:
// 1000:4a48      50                       PUSH AX
// 1000:4a49      3a 06 74 a2              CMP AL,byte ptr [0xa274]
// 1000:4a4d      b0 01                    MOV AL,0x1
// 1000:4a4f      74 02                    JZ 0x1000:4a53
// 1000:4a51      b0 02                    MOV AL,0x2
// 1000:4a53  LAB_1000_4a53:
// 1000:4a53      a2 9b a2                 MOV [0xa29b],AL
// 1000:4a56      b9 3a 00                 MOV CX,0x3a
// 1000:4a59      8b 16 28 01              MOV DX,word ptr [0x128]
// 1000:4a5d      e8 09 0c                 CALL 0x1000:5669
// 1000:4a60      58                       POP AX
// 1000:4a61      50                       PUSH AX
// 1000:4a62      b4 0b                    MOV AH,0xb
// 1000:4a64      f6 e4                    MUL AH
// 1000:4a66      be 26 a2                 MOV SI,0xa226
// 1000:4a69      03 f0                    ADD SI,AX
// 1000:4a6b      8a 04                    MOV AL,byte ptr [SI]
// 1000:4a6d      22 c0                    AND AL,AL
// 1000:4a6f      75 02                    JNZ 0x1000:4a73
// 1000:4a71      58                       POP AX
// 1000:4a72      c3                       RET
// 1000:4a73  LAB_1000_4a73:
// 1000:4a73      58                       POP AX
// 1000:4a74      50                       PUSH AX
// 1000:4a75      56                       PUSH SI
// 1000:4a76      04 41                    ADD AL,0x41
// 1000:4a78      e8 fc 0a                 CALL 0x1000:5577
// 1000:4a7b      b0 3d                    MOV AL,0x3d
// 1000:4a7d      e8 f7 0a                 CALL 0x1000:5577
// 1000:4a80      5e                       POP SI
// 1000:4a81      b9 03 00                 MOV CX,0x3
// 1000:4a84  LAB_1000_4a84:
// 1000:4a84      ac                       LODSB SI
// 1000:4a85      e8 ef 0a                 CALL 0x1000:5577
// 1000:4a88      e2 fa                    LOOP 0x1000:4a84
// 1000:4a8a      b0 20                    MOV AL,0x20
// 1000:4a8c      e8 e8 0a                 CALL 0x1000:5577
// 1000:4a8f      5b                       POP BX
// 1000:4a90      53                       PUSH BX
// 1000:4a91      8a 87 e0 89              MOV AL,byte ptr [BX + 0x89e0]
// 1000:4a95      50                       PUSH AX
// 1000:4a96      22 c0                    AND AL,AL
// 1000:4a98      74 0b                    JZ 0x1000:4aa5
// 1000:4a9a      e8 b7 0a                 CALL 0x1000:5554
//                 ; cstring -> 1000:4aa3  (OUT)
// 1000:4aa3  LAB_1000_4aa3:
// 1000:4aa3      eb 09                    JMP 0x1000:4aae
// 1000:4aa5  LAB_1000_4aa5:
// 1000:4aa5      d1 e3                    SHL BX,0x1
// 1000:4aa7      8b 87 e4 89              MOV AX,word ptr [BX + 0x89e4]
// 1000:4aab      e8 60 09                 CALL 0x1000:540e
// 1000:4aae  LAB_1000_4aae:
// 1000:4aae      b9 36 00                 MOV CX,0x36
// 1000:4ab1      83 06 28 01 08           ADD word ptr [0x128],0x8
// 1000:4ab6      8b 16 28 01              MOV DX,word ptr [0x128]
// 1000:4aba      e8 ac 0b                 CALL 0x1000:5669
// 1000:4abd      58                       POP AX
// 1000:4abe      22 c0                    AND AL,AL
// 1000:4ac0      74 56                    JZ 0x1000:4b18
// 1000:4ac2      24 0f                    AND AL,0xf
// 1000:4ac4      fe c8                    DEC AL
// 1000:4ac6      75 0f                    JNZ 0x1000:4ad7
// 1000:4ac8      e8 89 0a                 CALL 0x1000:5554
//                 ; cstring -> 1000:4ad4  NO SHIPS
// 1000:4ad4  LAB_1000_4ad4:
// 1000:4ad4      eb 3a                    JMP 0x1000:4b10
// 1000:4ad7  LAB_1000_4ad7:
// 1000:4ad7      fe c8                    DEC AL
// 1000:4ad9      75 0e                    JNZ 0x1000:4ae9
// 1000:4adb      e8 76 0a                 CALL 0x1000:5554
//                 ; cstring -> 1000:4ae6  NO BASE
// 1000:4ae6  LAB_1000_4ae6:
// 1000:4ae6      eb 28                    JMP 0x1000:4b10
// 1000:4ae9  LAB_1000_4ae9:
// 1000:4ae9      fe c8                    DEC AL
// 1000:4aeb      75 12                    JNZ 0x1000:4aff
// 1000:4aed      e8 64 0a                 CALL 0x1000:5554
//                 ; cstring -> 1000:4afc  SURRENDERED
// 1000:4afc  LAB_1000_4afc:
// 1000:4afc      eb 12                    JMP 0x1000:4b10
// 1000:4aff  LAB_1000_4aff:
// 1000:4aff      e8 52 0a                 CALL 0x1000:5554
//                 ; cstring -> 1000:4b10  **** TIE ****
// 1000:4b10  LAB_1000_4b10:
// 1000:4b10      83 06 28 01 08           ADD word ptr [0x128],0x8
// 1000:4b15      eb 57                    JMP 0x1000:4b6e
// 1000:4b18  LAB_1000_4b18:
// 1000:4b18      e8 39 0a                 CALL 0x1000:5554
//                 ; cstring -> 1000:4b1e  E=
// 1000:4b1e  LAB_1000_4b1e:
// 1000:4b1e      58                       POP AX
// 1000:4b1f      50                       PUSH AX
// 1000:4b20      b4 ec                    MOV AH,0xec
// 1000:4b22      f6 e4                    MUL AH
// 1000:4b24      be 64 8c                 MOV SI,0x8c64
// 1000:4b27      03 f0                    ADD SI,AX
// 1000:4b29      b9 04 00                 MOV CX,0x4
// 1000:4b2c      bb 00 00                 MOV BX,0x0
// 1000:4b2f  LAB_1000_4b2f:
// 1000:4b2f      f6 04 80                 TEST byte ptr [SI],0x80
// 1000:4b32      74 0f                    JZ 0x1000:4b43
// 1000:4b34      51                       PUSH CX
// 1000:4b35      b9 0a 00                 MOV CX,0xa
// 1000:4b38      8b 44 08                 MOV AX,word ptr [SI + 0x8]
// 1000:4b3b      ba 00 00                 MOV DX,0x0
// 1000:4b3e      f7 f1                    DIV CX
// 1000:4b40      59                       POP CX
// 1000:4b41      03 d8                    ADD BX,AX
// 1000:4b43  LAB_1000_4b43:
// 1000:4b43      83 c6 3b                 ADD SI,0x3b
// 1000:4b46      e2 e7                    LOOP 0x1000:4b2f
// 1000:4b48      58                       POP AX
// 1000:4b49      50                       PUSH AX
// 1000:4b4a      b4 0e                    MOV AH,0xe
// 1000:4b4c      f6 e4                    MUL AH
// 1000:4b4e      be 14 90                 MOV SI,0x9014
// 1000:4b51      03 f0                    ADD SI,AX
// 1000:4b53      03 5c 08                 ADD BX,word ptr [SI + 0x8]
// 1000:4b56      8b c3                    MOV AX,BX
// 1000:4b58      e8 b3 08                 CALL 0x1000:540e
// 1000:4b5b      e8 f6 09                 CALL 0x1000:5554
//                 ; cstring -> 1000:4b63  0 #=
// 1000:4b63  LAB_1000_4b63:
// 1000:4b63      5b                       POP BX
// 1000:4b64      53                       PUSH BX
// 1000:4b65      8a 87 dc 89              MOV AL,byte ptr [BX + 0x89dc]
// 1000:4b69      b3 20                    MOV BL,0x20
// 1000:4b6b      e8 b5 08                 CALL 0x1000:5423
// 1000:4b6e  LAB_1000_4b6e:
// 1000:4b6e      83 06 28 01 08           ADD word ptr [0x128],0x8
// 1000:4b73      83 06 28 01 08           ADD word ptr [0x128],0x8
// 1000:4b78      58                       POP AX
// 1000:4b79      fe c0                    INC AL
// 1000:4b7b      3c 04                    CMP AL,0x4
// 1000:4b7d      73 03                    JNC 0x1000:4b82
// 1000:4b7f      e9 c6 fe                 JMP 0x1000:4a48
// 1000:4b82  LAB_1000_4b82:
// 1000:4b82      c3                       RET
fun_4a3f :: proc() {
}

// @proc 1000:4b83
// listing: FUN_1000_4b83
// status: unread
// 1000:4b83  FUN_1000_4b83:
// 1000:4b83      8a 5c 11                 MOV BL,byte ptr [SI + 0x11]
// 1000:4b86      81 e3 1f 00              AND BX,0x1f
// 1000:4b8a      8a 87 10 01              MOV AL,byte ptr [BX + 0x110]
// 1000:4b8e      b4 00                    MOV AH,0x0
// 1000:4b90      e9 e8 09                 JMP 0x1000:557b
fun_4b83 :: proc() {
}

// @proc 1000:4b93
// listing: FUN_1000_4b93
// status: unread
// 1000:4b93  FUN_1000_4b93:
// 1000:4b93      8a 04                    MOV AL,byte ptr [SI]
// 1000:4b95      24 07                    AND AL,0x7
// 1000:4b97      8a c8                    MOV CL,AL
// 1000:4b99      8a 44 0e                 MOV AL,byte ptr [SI + 0xe]
// 1000:4b9c      22 c0                    AND AL,AL
// 1000:4b9e      74 0c                    JZ 0x1000:4bac
// 1000:4ba0      3c 05                    CMP AL,0x5
// 1000:4ba2      77 06                    JA 0x1000:4baa
// 1000:4ba4      8a c1                    MOV AL,CL
// 1000:4ba6      24 02                    AND AL,0x2
// 1000:4ba8      74 02                    JZ 0x1000:4bac
// 1000:4baa  LAB_1000_4baa:
// 1000:4baa      b0 03                    MOV AL,0x3
// 1000:4bac  LAB_1000_4bac:
// 1000:4bac      0a c1                    OR AL,CL
// 1000:4bae      8a c8                    MOV CL,AL
// 1000:4bb0      8a c1                    MOV AL,CL
// 1000:4bb2      24 03                    AND AL,0x3
// 1000:4bb4      bb 0f 4c                 MOV BX,0x4c0f
// 1000:4bb7      32 e4                    XOR AH,AH
// 1000:4bb9      03 d8                    ADD BX,AX
// 1000:4bbb      03 d8                    ADD BX,AX
// 1000:4bbd      2e 8b 07                 MOV AX,word ptr CS:[BX]
// 1000:4bc0      51                       PUSH CX
// 1000:4bc1      e8 b7 09                 CALL 0x1000:557b
// 1000:4bc4      59                       POP CX
// 1000:4bc5      80 e1 04                 AND CL,0x4
// 1000:4bc8      b8 20 00                 MOV AX,0x20
// 1000:4bcb      74 03                    JZ 0x1000:4bd0
// 1000:4bcd      b8 44 00                 MOV AX,0x44
// 1000:4bd0  LAB_1000_4bd0:
// 1000:4bd0      e8 a8 09                 CALL 0x1000:557b
// 1000:4bd3      8a 64 16                 MOV AH,byte ptr [SI + 0x16]
// 1000:4bd6      22 e4                    AND AH,AH
// 1000:4bd8      74 20                    JZ 0x1000:4bfa
// 1000:4bda      8a 1e 96 a2              MOV BL,byte ptr [0xa296]
// 1000:4bde  LAB_1000_4bde:
// 1000:4bde      80 c3 02                 ADD BL,0x2
// 1000:4be1      81 e3 0e 00              AND BX,0xe
// 1000:4be5      2e 84 a7 ff 4b           TEST byte ptr CS:[BX + 0x4bff],AH
// 1000:4bea      74 f2                    JZ 0x1000:4bde
// 1000:4bec      88 1e 96 a2              MOV byte ptr [0xa296],BL
// 1000:4bf0      b4 02                    MOV AH,0x2
// 1000:4bf2      2e 8a 87 00 4c           MOV AL,byte ptr CS:[BX + 0x4c00]
// 1000:4bf7      e9 81 09                 JMP 0x1000:557b
// 1000:4bfa  LAB_1000_4bfa:
// 1000:4bfa      b0 20                    MOV AL,0x20
// 1000:4bfc      e9 7c 09                 JMP 0x1000:557b
fun_4b93 :: proc() {
}

// @proc 1000:4c17
// listing: FUN_1000_4c17
// status: unread
// 1000:4c17  FUN_1000_4c17:
// 1000:4c17      e8 1c 06                 CALL 0x1000:5236
// 1000:4c1a      e8 09 04                 CALL 0x1000:5026
// 1000:4c1d      e8 63 01                 CALL 0x1000:4d83
// 1000:4c20      e8 83 02                 CALL 0x1000:4ea6
// 1000:4c23      e8 c5 00                 CALL 0x1000:4ceb
// 1000:4c26      e8 0a 00                 CALL 0x1000:4c33
// 1000:4c29      e8 be 02                 CALL 0x1000:4eea
// 1000:4c2c      e8 5f 03                 CALL 0x1000:4f8e
// 1000:4c2f      e8 26 04                 CALL 0x1000:5058
// 1000:4c32      c3                       RET
fun_4c17 :: proc() {
}

// @proc 1000:4c33
// listing: FUN_1000_4c33
// status: unread
// 1000:4c33  FUN_1000_4c33:
// 1000:4c33      bf 64 8c                 MOV DI,0x8c64
// 1000:4c36      b9 10 00                 MOV CX,0x10
// 1000:4c39  LAB_1000_4c39:
// 1000:4c39      8a 45 19                 MOV AL,byte ptr [DI + 0x19]
// 1000:4c3c      a8 ff                    TEST AL,0xff
// 1000:4c3e      74 3a                    JZ 0x1000:4c7a
// 1000:4c40      3c 04                    CMP AL,0x4
// 1000:4c42      72 10                    JC 0x1000:4c54
// 1000:4c44      a8 80                    TEST AL,0x80
// 1000:4c46      74 22                    JZ 0x1000:4c6a
// 1000:4c48      3c 84                    CMP AL,0x84
// 1000:4c4a      72 2e                    JC 0x1000:4c7a
// 1000:4c4c      bd 37 28                 MOV BP,0x2837
// 1000:4c4f      e8 2e 00                 CALL 0x1000:4c80
// 1000:4c52      eb 1c                    JMP 0x1000:4c70
// 1000:4c54  LAB_1000_4c54:
// 1000:4c54      bd 3f 28                 MOV BP,0x283f
// 1000:4c57      fe c8                    DEC AL
// 1000:4c59      be 73 13                 MOV SI,0x1373
// 1000:4c5c      74 12                    JZ 0x1000:4c70
// 1000:4c5e      fe c8                    DEC AL
// 1000:4c60      be 3b 13                 MOV SI,0x133b
// 1000:4c63      74 0b                    JZ 0x1000:4c70
// 1000:4c65      be 1d 13                 MOV SI,0x131d
// 1000:4c68      eb 06                    JMP 0x1000:4c70
// 1000:4c6a  LAB_1000_4c6a:
// 1000:4c6a      bd 3f 28                 MOV BP,0x283f
// 1000:4c6d      e8 56 00                 CALL 0x1000:4cc6
// 1000:4c70  LAB_1000_4c70:
// 1000:4c70      51                       PUSH CX
// 1000:4c71      57                       PUSH DI
// 1000:4c72      83 c7 19                 ADD DI,0x19
// 1000:4c75      e8 e7 06                 CALL 0x1000:535f
// 1000:4c78      5f                       POP DI
// 1000:4c79      59                       POP CX
// 1000:4c7a  LAB_1000_4c7a:
// 1000:4c7a      83 c7 3b                 ADD DI,0x3b
// 1000:4c7d      e2 ba                    LOOP 0x1000:4c39
// 1000:4c7f      c3                       RET
fun_4c33 :: proc() {
}

// @proc 1000:4c80
// listing: FUN_1000_4c80
// status: unread
// 1000:4c80  FUN_1000_4c80:
// 1000:4c80      b3 8c                    MOV BL,0x8c
// 1000:4c82      3a c3                    CMP AL,BL
// 1000:4c84      76 0a                    JBE 0x1000:4c90
// 1000:4c86      3c c4                    CMP AL,0xc4
// 1000:4c88      76 24                    JBE 0x1000:4cae
// 1000:4c8a      b3 c9                    MOV BL,0xc9
// 1000:4c8c      3a c3                    CMP AL,BL
// 1000:4c8e      77 1e                    JA 0x1000:4cae
// 1000:4c90  LAB_1000_4c90:
// 1000:4c90      2a d8                    SUB BL,AL
// 1000:4c92      32 ff                    XOR BH,BH
// 1000:4c94      80 3e 70 a2 02           CMP byte ptr [0xa270],0x2
// 1000:4c99      76 0b                    JBE 0x1000:4ca6
// 1000:4c9b      d1 eb                    SHR BX,0x1
// 1000:4c9d      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
// 1000:4ca2      76 02                    JBE 0x1000:4ca6
// 1000:4ca4      d1 eb                    SHR BX,0x1
// 1000:4ca6  LAB_1000_4ca6:
// 1000:4ca6      d1 e3                    SHL BX,0x1
// 1000:4ca8      2e 8b b7 b2 4c           MOV SI,word ptr CS:[BX + 0x4cb2]
// 1000:4cad      c3                       RET
// 1000:4cae  LAB_1000_4cae:
// 1000:4cae      be 37 28                 MOV SI,0x2837
// 1000:4cb1      c3                       RET
fun_4c80 :: proc() {
}

// @proc 1000:4cc6
// listing: FUN_1000_4cc6
// status: unread
// 1000:4cc6  FUN_1000_4cc6:
// 1000:4cc6      8a 45 17                 MOV AL,byte ptr [DI + 0x17]
// 1000:4cc9      3a 06 74 a2              CMP AL,byte ptr [0xa274]
// 1000:4ccd      74 0e                    JZ 0x1000:4cdd
// 1000:4ccf      be af 12                 MOV SI,0x12af
// 1000:4cd2      a0 d2 89                 MOV AL,[0x89d2]
// 1000:4cd5      24 01                    AND AL,0x1
// 1000:4cd7      74 11                    JZ 0x1000:4cea
// 1000:4cd9      be c5 12                 MOV SI,0x12c5
// 1000:4cdc      c3                       RET
// 1000:4cdd  LAB_1000_4cdd:
// 1000:4cdd      be f1 12                 MOV SI,0x12f1
// 1000:4ce0      a0 d2 89                 MOV AL,[0x89d2]
// 1000:4ce3      24 01                    AND AL,0x1
// 1000:4ce5      74 03                    JZ 0x1000:4cea
// 1000:4ce7      be db 12                 MOV SI,0x12db
// 1000:4cea  LAB_1000_4cea:
// 1000:4cea      c3                       RET
fun_4cc6 :: proc() {
}

// @proc 1000:4ceb
// listing: FUN_1000_4ceb
// status: unread
// 1000:4ceb  FUN_1000_4ceb:
// 1000:4ceb      b0 00                    MOV AL,0x0
// 1000:4ced      bf 14 90                 MOV DI,0x9014
// 1000:4cf0  LAB_1000_4cf0:
// 1000:4cf0      50                       PUSH AX
// 1000:4cf1      8a 65 0d                 MOV AH,byte ptr [DI + 0xd]
// 1000:4cf4      22 e4                    AND AH,AH
// 1000:4cf6      74 7d                    JZ 0x1000:4d75
// 1000:4cf8      80 fc 04                 CMP AH,0x4
// 1000:4cfb      74 17                    JZ 0x1000:4d14
// 1000:4cfd      be 2d 26                 MOV SI,0x262d
// 1000:4d00      bd 21 28                 MOV BP,0x2821
// 1000:4d03      fe cc                    DEC AH
// 1000:4d05      74 2d                    JZ 0x1000:4d34
// 1000:4d07      be 71 26                 MOV SI,0x2671
// 1000:4d0a      fe cc                    DEC AH
// 1000:4d0c      74 26                    JZ 0x1000:4d34
// 1000:4d0e      be f3 26                 MOV SI,0x26f3
// 1000:4d11      eb 21                    JMP 0x1000:4d34
// 1000:4d14  LAB_1000_4d14:
// 1000:4d14      3a 06 74 a2              CMP AL,byte ptr [0xa274]
// 1000:4d18      75 20                    JNZ 0x1000:4d3a
// 1000:4d1a      bd 0b 1d                 MOV BP,0x1d0b
// 1000:4d1d      be 13 19                 MOV SI,0x1913
// 1000:4d20      80 3e 70 a2 02           CMP byte ptr [0xa270],0x2
// 1000:4d25      76 0d                    JBE 0x1000:4d34
// 1000:4d27      be 0b 1c                 MOV SI,0x1c0b
// 1000:4d2a      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
// 1000:4d2f      76 03                    JBE 0x1000:4d34
// 1000:4d31      be df 1c                 MOV SI,0x1cdf
// 1000:4d34  LAB_1000_4d34:
// 1000:4d34      e8 28 06                 CALL 0x1000:535f
// 1000:4d37      eb 3c                    JMP 0x1000:4d75
// 1000:4d3a  LAB_1000_4d3a:
// 1000:4d3a      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
// 1000:4d3f      77 24                    JA 0x1000:4d65
// 1000:4d41      bd 13 1d                 MOV BP,0x1d13
// 1000:4d44      be 8f 1a                 MOV SI,0x1a8f
// 1000:4d47      80 3e 70 a2 02           CMP byte ptr [0xa270],0x2
// 1000:4d4c      76 0d                    JBE 0x1000:4d5b
// 1000:4d4e      be 75 1c                 MOV SI,0x1c75
// 1000:4d51      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
// 1000:4d56      76 03                    JBE 0x1000:4d5b
// 1000:4d58      be f5 1c                 MOV SI,0x1cf5
// 1000:4d5b  LAB_1000_4d5b:
// 1000:4d5b      e8 01 06                 CALL 0x1000:535f
// 1000:4d5e      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
// 1000:4d63      74 10                    JZ 0x1000:4d75
// 1000:4d65  LAB_1000_4d65:
// 1000:4d65      58                       POP AX
// 1000:4d66      50                       PUSH AX
// 1000:4d67      b4 1e                    MOV AH,0x1e
// 1000:4d69      f6 e4                    MUL AH
// 1000:4d6b      be eb 01                 MOV SI,0x1eb
// 1000:4d6e      03 f0                    ADD SI,AX
// 1000:4d70      8b ee                    MOV BP,SI
// 1000:4d72      e8 ea 05                 CALL 0x1000:535f
// 1000:4d75  LAB_1000_4d75:
// 1000:4d75      83 c7 0e                 ADD DI,0xe
// 1000:4d78      58                       POP AX
// 1000:4d79      fe c0                    INC AL
// 1000:4d7b      3c 04                    CMP AL,0x4
// 1000:4d7d      73 03                    JNC 0x1000:4d82
// 1000:4d7f      e9 6e ff                 JMP 0x1000:4cf0
// 1000:4d82  LAB_1000_4d82:
// 1000:4d82      c3                       RET
fun_4ceb :: proc() {
}

// @proc 1000:4d83
// listing: FUN_1000_4d83
// status: unread
// 1000:4d83  FUN_1000_4d83:
// 1000:4d83      8b 36 97 a2              MOV SI,word ptr [0xa297]
// 1000:4d87      e8 9b e4                 CALL 0x1000:3225
// 1000:4d8a  LAB_1000_4d8a:
// 1000:4d8a      51                       PUSH CX
// 1000:4d8b      a0 74 a2                 MOV AL,[0xa274]
// 1000:4d8e      24 03                    AND AL,0x3
// 1000:4d90      b4 80                    MOV AH,0x80
// 1000:4d92      74 0e                    JZ 0x1000:4da2
// 1000:4d94      b4 40                    MOV AH,0x40
// 1000:4d96      fe c8                    DEC AL
// 1000:4d98      74 08                    JZ 0x1000:4da2
// 1000:4d9a      b4 20                    MOV AH,0x20
// 1000:4d9c      fe c8                    DEC AL
// 1000:4d9e      74 02                    JZ 0x1000:4da2
// 1000:4da0      b4 10                    MOV AH,0x10
// 1000:4da2  LAB_1000_4da2:
// 1000:4da2      22 25                    AND AH,byte ptr [DI]
// 1000:4da4      74 7f                    JZ 0x1000:4e25
// 1000:4da6      8a 05                    MOV AL,byte ptr [DI]
// 1000:4da8      24 0f                    AND AL,0xf
// 1000:4daa      75 21                    JNZ 0x1000:4dcd
// 1000:4dac      80 7d 06 06              CMP byte ptr [DI + 0x6],0x6
// 1000:4db0      77 09                    JA 0x1000:4dbb
// 1000:4db2      bd a7 20                 MOV BP,0x20a7
// 1000:4db5      be 6f 20                 MOV SI,0x206f
// 1000:4db8      eb 68                    JMP 0x1000:4e22
// 1000:4dbb  LAB_1000_4dbb:
// 1000:4dbb      bd 3f 28                 MOV BP,0x283f
// 1000:4dbe      be ff 1f                 MOV SI,0x1fff
// 1000:4dc1      80 7d 06 0c              CMP byte ptr [DI + 0x6],0xc
// 1000:4dc5      77 03                    JA 0x1000:4dca
// 1000:4dc7      be 37 20                 MOV SI,0x2037
// 1000:4dca  LAB_1000_4dca:
// 1000:4dca      eb 56                    JMP 0x1000:4e22
// 1000:4dcd  LAB_1000_4dcd:
// 1000:4dcd      3c 0f                    CMP AL,0xf
// 1000:4dcf      75 13                    JNZ 0x1000:4de4
// 1000:4dd1      bd 37 28                 MOV BP,0x2837
// 1000:4dd4      be 37 28                 MOV SI,0x2837
// 1000:4dd7      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
// 1000:4ddc      77 44                    JA 0x1000:4e22
// 1000:4dde      be 2d 24                 MOV SI,0x242d
// 1000:4de1      eb 3f                    JMP 0x1000:4e22
// 1000:4de4  LAB_1000_4de4:
// 1000:4de4      be 37 28                 MOV SI,0x2837
// 1000:4de7      bd 37 28                 MOV BP,0x2837
// 1000:4dea      f6 45 06 ff              TEST byte ptr [DI + 0x6],0xff
// 1000:4dee      75 32                    JNZ 0x1000:4e22
// 1000:4df0      25 0f 00                 AND AX,0xf
// 1000:4df3      bb 66 4e                 MOV BX,0x4e66
// 1000:4df6      03 d8                    ADD BX,AX
// 1000:4df8      03 d8                    ADD BX,AX
// 1000:4dfa      03 d8                    ADD BX,AX
// 1000:4dfc      03 d8                    ADD BX,AX
// 1000:4dfe      2e 8b 37                 MOV SI,word ptr CS:[BX]
// 1000:4e01      2e 8b 6f 02              MOV BP,word ptr CS:[BX + 0x2]
// 1000:4e05      e8 28 00                 CALL 0x1000:4e30
// 1000:4e08      e8 54 05                 CALL 0x1000:535f
// 1000:4e0b      80 7d 0a ff              CMP byte ptr [DI + 0xa],0xff
// 1000:4e0f      74 14                    JZ 0x1000:4e25
// 1000:4e11      a0 74 a2                 MOV AL,[0xa274]
// 1000:4e14      3a 45 0a                 CMP AL,byte ptr [DI + 0xa]
// 1000:4e17      be 0d 17                 MOV SI,0x170d
// 1000:4e1a      bd 37 28                 MOV BP,0x2837
// 1000:4e1d      75 03                    JNZ 0x1000:4e22
// 1000:4e1f      be b7 16                 MOV SI,0x16b7
// 1000:4e22  LAB_1000_4e22:
// 1000:4e22      e8 3a 05                 CALL 0x1000:535f
// 1000:4e25  LAB_1000_4e25:
// 1000:4e25      59                       POP CX
// 1000:4e26      83 c7 0b                 ADD DI,0xb
// 1000:4e29      49                       DEC CX
// 1000:4e2a      74 03                    JZ 0x1000:4e2f
// 1000:4e2c      e9 5b ff                 JMP 0x1000:4d8a
// 1000:4e2f  LAB_1000_4e2f:
// 1000:4e2f      c3                       RET
fun_4d83 :: proc() {
}

// @proc 1000:4e30
// listing: FUN_1000_4e30
// status: unread
// 1000:4e30  FUN_1000_4e30:
// 1000:4e30      83 fe 00                 CMP SI,0x0
// 1000:4e33      75 30                    JNZ 0x1000:4e65
// 1000:4e35      8a 45 09                 MOV AL,byte ptr [DI + 0x9]
// 1000:4e38      be 65 24                 MOV SI,0x2465
// 1000:4e3b      3c 0a                    CMP AL,0xa
// 1000:4e3d      72 26                    JC 0x1000:4e65
// 1000:4e3f      be 6d 24                 MOV SI,0x246d
// 1000:4e42      3c 19                    CMP AL,0x19
// 1000:4e44      72 1f                    JC 0x1000:4e65
// 1000:4e46      be 83 24                 MOV SI,0x2483
// 1000:4e49      3c 32                    CMP AL,0x32
// 1000:4e4b      72 18                    JC 0x1000:4e65
// 1000:4e4d      be a1 24                 MOV SI,0x24a1
// 1000:4e50      3c 4b                    CMP AL,0x4b
// 1000:4e52      72 11                    JC 0x1000:4e65
// 1000:4e54      be d9 24                 MOV SI,0x24d9
// 1000:4e57      3c 64                    CMP AL,0x64
// 1000:4e59      72 0a                    JC 0x1000:4e65
// 1000:4e5b      be 1d 25                 MOV SI,0x251d
// 1000:4e5e      3c 7d                    CMP AL,0x7d
// 1000:4e60      72 03                    JC 0x1000:4e65
// 1000:4e62      be 87 25                 MOV SI,0x2587
// 1000:4e65  LAB_1000_4e65:
// 1000:4e65      c3                       RET
fun_4e30 :: proc() {
}

// @proc 1000:4ea6
// listing: FUN_1000_4ea6
// status: unread
// 1000:4ea6  FUN_1000_4ea6:
// 1000:4ea6      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
// 1000:4eab      76 01                    JBE 0x1000:4eae
// 1000:4ead      c3                       RET
// 1000:4eae  LAB_1000_4eae:
// 1000:4eae      b0 00                    MOV AL,0x0
// 1000:4eb0      bf 4c 90                 MOV DI,0x904c
// 1000:4eb3  LAB_1000_4eb3:
// 1000:4eb3      b9 14 00                 MOV CX,0x14
// 1000:4eb6  LAB_1000_4eb6:
// 1000:4eb6      80 3d 00                 CMP byte ptr [DI],0x0
// 1000:4eb9      74 23                    JZ 0x1000:4ede
// 1000:4ebb      3a 06 74 a2              CMP AL,byte ptr [0xa274]
// 1000:4ebf      be a3 18                 MOV SI,0x18a3
// 1000:4ec2      74 03                    JZ 0x1000:4ec7
// 1000:4ec4      be c1 18                 MOV SI,0x18c1
// 1000:4ec7  LAB_1000_4ec7:
// 1000:4ec7      80 3d 02                 CMP byte ptr [DI],0x2
// 1000:4eca      77 08                    JA 0x1000:4ed4
// 1000:4ecc      be d7 18                 MOV SI,0x18d7
// 1000:4ecf      74 03                    JZ 0x1000:4ed4
// 1000:4ed1      be f5 18                 MOV SI,0x18f5
// 1000:4ed4  LAB_1000_4ed4:
// 1000:4ed4      50                       PUSH AX
// 1000:4ed5      51                       PUSH CX
// 1000:4ed6      bd 37 28                 MOV BP,0x2837
// 1000:4ed9      e8 83 04                 CALL 0x1000:535f
// 1000:4edc      59                       POP CX
// 1000:4edd      58                       POP AX
// 1000:4ede  LAB_1000_4ede:
// 1000:4ede      83 c7 08                 ADD DI,0x8
// 1000:4ee1      e2 d3                    LOOP 0x1000:4eb6
// 1000:4ee3      fe c0                    INC AL
// 1000:4ee5      3c 04                    CMP AL,0x4
// 1000:4ee7      72 ca                    JC 0x1000:4eb3
// 1000:4ee9      c3                       RET
fun_4ea6 :: proc() {
}

// @proc 1000:4eea
// listing: FUN_1000_4eea
// status: unread
// 1000:4eea  FUN_1000_4eea:
// 1000:4eea      e8 e1 cf                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:4ef5  [ptr] 1000:8c64 1000:8d50 1000:8e3c 1000:8f28
// 1000:4ef5  LAB_1000_4ef5:
// 1000:4ef5      8b fb                    MOV DI,BX
// 1000:4ef7      b9 00 00                 MOV CX,0x0
// 1000:4efa  LAB_1000_4efa:
// 1000:4efa      51                       PUSH CX
// 1000:4efb      be 37 28                 MOV SI,0x2837
// 1000:4efe      e8 dc 02                 CALL 0x1000:51dd
// 1000:4f01      74 60                    JZ 0x1000:4f63
// 1000:4f03      e8 56 04                 CALL 0x1000:535c
// 1000:4f06      8a 07                    MOV AL,byte ptr [BX]
// 1000:4f08      24 c0                    AND AL,0xc0
// 1000:4f0a      3c 40                    CMP AL,0x40
// 1000:4f0c      75 07                    JNZ 0x1000:4f15
// 1000:4f0e      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
// 1000:4f13      75 2e                    JNZ 0x1000:4f43
// 1000:4f15  LAB_1000_4f15:
// 1000:4f15      8a 55 0a                 MOV DL,byte ptr [DI + 0xa]
// 1000:4f18      b8 1e 00                 MOV AX,0x1e
// 1000:4f1b      80 e2 0f                 AND DL,0xf
// 1000:4f1e      f6 e2                    MUL DL
// 1000:4f20      be 7b 09                 MOV SI,0x97b
// 1000:4f23      03 f0                    ADD SI,AX
// 1000:4f25      bd 43 28                 MOV BP,0x2843
// 1000:4f28      e8 34 04                 CALL 0x1000:535f
// 1000:4f2b      e8 2e 04                 CALL 0x1000:535c
// 1000:4f2e      8a 07                    MOV AL,byte ptr [BX]
// 1000:4f30      24 c0                    AND AL,0xc0
// 1000:4f32      74 32                    JZ 0x1000:4f66
// 1000:4f34      3c 80                    CMP AL,0x80
// 1000:4f36      74 1b                    JZ 0x1000:4f53
// 1000:4f38      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
// 1000:4f3d      74 27                    JZ 0x1000:4f66
// 1000:4f3f      3c c0                    CMP AL,0xc0
// 1000:4f41      74 10                    JZ 0x1000:4f53
// 1000:4f43  LAB_1000_4f43:
// 1000:4f43      59                       POP CX
// 1000:4f44      51                       PUSH CX
// 1000:4f45      b0 0c                    MOV AL,0xc
// 1000:4f47      f6 e1                    MUL CL
// 1000:4f49      be 63 02                 MOV SI,0x263
// 1000:4f4c      03 f0                    ADD SI,AX
// 1000:4f4e      8b ee                    MOV BP,SI
// 1000:4f50      eb 11                    JMP 0x1000:4f63
// 1000:4f53  LAB_1000_4f53:
// 1000:4f53      80 3e 70 a2 07           CMP byte ptr [0xa270],0x7
// 1000:4f58      b0 00                    MOV AL,0x0
// 1000:4f5a      74 e7                    JZ 0x1000:4f43
// 1000:4f5c      58                       POP AX
// 1000:4f5d      50                       PUSH AX
// 1000:4f5e      e8 43 03                 CALL 0x1000:52a4
// 1000:4f61      eb 03                    JMP 0x1000:4f66
// 1000:4f63  LAB_1000_4f63:
// 1000:4f63      e8 f9 03                 CALL 0x1000:535f
// 1000:4f66  LAB_1000_4f66:
// 1000:4f66      8a 05                    MOV AL,byte ptr [DI]
// 1000:4f68      a8 80                    TEST AL,0x80
// 1000:4f6a      74 13                    JZ 0x1000:4f7f
// 1000:4f6c      a8 20                    TEST AL,0x20
// 1000:4f6e      74 0f                    JZ 0x1000:4f7f
// 1000:4f70      f6 45 19 80              TEST byte ptr [DI + 0x19],0x80
// 1000:4f74      75 09                    JNZ 0x1000:4f7f
// 1000:4f76      be 63 17                 MOV SI,0x1763
// 1000:4f79      bd 37 28                 MOV BP,0x2837
// 1000:4f7c      e8 e0 03                 CALL 0x1000:535f
// 1000:4f7f  LAB_1000_4f7f:
// 1000:4f7f      83 c7 3b                 ADD DI,0x3b
// 1000:4f82      59                       POP CX
// 1000:4f83      fe c1                    INC CL
// 1000:4f85      80 f9 04                 CMP CL,0x4
// 1000:4f88      74 03                    JZ 0x1000:4f8d
// 1000:4f8a      e9 6d ff                 JMP 0x1000:4efa
// 1000:4f8d  LAB_1000_4f8d:
// 1000:4f8d      c3                       RET
fun_4eea :: proc() {
}

// @proc 1000:4f8e
// listing: FUN_1000_4f8e
// status: unread
// 1000:4f8e  FUN_1000_4f8e:
// 1000:4f8e      bf 64 8c                 MOV DI,0x8c64
// 1000:4f91      b9 10 00                 MOV CX,0x10
// 1000:4f94  LAB_1000_4f94:
// 1000:4f94      a0 74 a2                 MOV AL,[0xa274]
// 1000:4f97      3a 45 17                 CMP AL,byte ptr [DI + 0x17]
// 1000:4f9a      75 03                    JNZ 0x1000:4f9f
// 1000:4f9c      eb 7e                    JMP 0x1000:501c
// 1000:4f9f  LAB_1000_4f9f:
// 1000:4f9f      51                       PUSH CX
// 1000:4fa0      be 37 28                 MOV SI,0x2837
// 1000:4fa3      e8 37 02                 CALL 0x1000:51dd
// 1000:4fa6      74 57                    JZ 0x1000:4fff
// 1000:4fa8      80 3e 70 a2 07           CMP byte ptr [0xa270],0x7
// 1000:4fad      74 6c                    JZ 0x1000:501b
// 1000:4faf      f6 45 19 f0              TEST byte ptr [DI + 0x19],0xf0
// 1000:4fb3      75 06                    JNZ 0x1000:4fbb
// 1000:4fb5      8a 05                    MOV AL,byte ptr [DI]
// 1000:4fb7      a8 10                    TEST AL,0x10
// 1000:4fb9      75 60                    JNZ 0x1000:501b
// 1000:4fbb  LAB_1000_4fbb:
// 1000:4fbb      be 37 28                 MOV SI,0x2837
// 1000:4fbe      bd 37 28                 MOV BP,0x2837
// 1000:4fc1      81 7d 08 e8 03           CMP word ptr [DI + 0x8],0x3e8
// 1000:4fc6      77 07                    JA 0x1000:4fcf
// 1000:4fc8      f6 06 d2 89 02           TEST byte ptr [0x89d2],0x2
// 1000:4fcd      75 2d                    JNZ 0x1000:4ffc
// 1000:4fcf  LAB_1000_4fcf:
// 1000:4fcf      f6 05 44                 TEST byte ptr [DI],0x44
// 1000:4fd2      75 47                    JNZ 0x1000:501b
// 1000:4fd4      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
// 1000:4fd9      74 11                    JZ 0x1000:4fec
// 1000:4fdb      8a 55 17                 MOV DL,byte ptr [DI + 0x17]
// 1000:4fde      b0 0c                    MOV AL,0xc
// 1000:4fe0      f6 e2                    MUL DL
// 1000:4fe2      be bb 01                 MOV SI,0x1bb
// 1000:4fe5      03 f0                    ADD SI,AX
// 1000:4fe7      8b ee                    MOV BP,SI
// 1000:4fe9      eb 11                    JMP 0x1000:4ffc
// 1000:4fec  LAB_1000_4fec:
// 1000:4fec      8a 55 0a                 MOV DL,byte ptr [DI + 0xa]
// 1000:4fef      b8 1e 00                 MOV AX,0x1e
// 1000:4ff2      80 e2 0f                 AND DL,0xf
// 1000:4ff5      f6 e2                    MUL DL
// 1000:4ff7      be 5b 0b                 MOV SI,0xb5b
// 1000:4ffa      03 f0                    ADD SI,AX
// 1000:4ffc  LAB_1000_4ffc:
// 1000:4ffc      bd 3b 28                 MOV BP,0x283b
// 1000:4fff  LAB_1000_4fff:
// 1000:4fff      e8 5d 03                 CALL 0x1000:535f
// 1000:5002      8a 05                    MOV AL,byte ptr [DI]
// 1000:5004      a8 80                    TEST AL,0x80
// 1000:5006      74 13                    JZ 0x1000:501b
// 1000:5008      a8 20                    TEST AL,0x20
// 1000:500a      74 0f                    JZ 0x1000:501b
// 1000:500c      f6 45 19 80              TEST byte ptr [DI + 0x19],0x80
// 1000:5010      75 09                    JNZ 0x1000:501b
// 1000:5012      be 63 17                 MOV SI,0x1763
// 1000:5015      bd 37 28                 MOV BP,0x2837
// 1000:5018      e8 44 03                 CALL 0x1000:535f
// 1000:501b  LAB_1000_501b:
// 1000:501b      59                       POP CX
// 1000:501c  LAB_1000_501c:
// 1000:501c      83 c7 3b                 ADD DI,0x3b
// 1000:501f      49                       DEC CX
// 1000:5020      74 03                    JZ 0x1000:5025
// 1000:5022      e9 6f ff                 JMP 0x1000:4f94
// 1000:5025  LAB_1000_5025:
// 1000:5025      c3                       RET
fun_4f8e :: proc() {
}

// @proc 1000:5026
// listing: FUN_1000_5026
// status: unread
// 1000:5026  FUN_1000_5026:
// 1000:5026      80 3e 70 a2 04           CMP byte ptr [0xa270],0x4
// 1000:502b      77 2a                    JA 0x1000:5057
// 1000:502d      bf 8c a0                 MOV DI,0xa08c
// 1000:5030      b9 30 00                 MOV CX,0x30
// 1000:5033  LAB_1000_5033:
// 1000:5033      80 3d 00                 CMP byte ptr [DI],0x0
// 1000:5036      74 1a                    JZ 0x1000:5052
// 1000:5038      a0 d2 89                 MOV AL,[0x89d2]
// 1000:503b      d0 e8                    SHR AL,0x1
// 1000:503d      32 05                    XOR AL,byte ptr [DI]
// 1000:503f      be f3 17                 MOV SI,0x17f3
// 1000:5042      24 07                    AND AL,0x7
// 1000:5044      b4 16                    MOV AH,0x16
// 1000:5046      f6 e4                    MUL AH
// 1000:5048      03 f0                    ADD SI,AX
// 1000:504a      bd 37 28                 MOV BP,0x2837
// 1000:504d      51                       PUSH CX
// 1000:504e      e8 0e 03                 CALL 0x1000:535f
// 1000:5051      59                       POP CX
// 1000:5052  LAB_1000_5052:
// 1000:5052      83 c7 07                 ADD DI,0x7
// 1000:5055      e2 dc                    LOOP 0x1000:5033
// 1000:5057  LAB_1000_5057:
// 1000:5057      c3                       RET
fun_5026 :: proc() {
}

// @proc 1000:5058
// listing: FUN_1000_5058
// status: unread
// 1000:5058  FUN_1000_5058:
// 1000:5058      bf 8c 8a                 MOV DI,0x8a8c
// 1000:505b      b9 00 00                 MOV CX,0x0
// 1000:505e  LAB_1000_505e:
// 1000:505e      51                       PUSH CX
// 1000:505f      be c3 02                 MOV SI,0x2c3
// 1000:5062      8a 05                    MOV AL,byte ptr [DI]
// 1000:5064      24 03                    AND AL,0x3
// 1000:5066      74 21                    JZ 0x1000:5089
// 1000:5068      fe c8                    DEC AL
// 1000:506a      be 73 03                 MOV SI,0x373
// 1000:506d      74 1a                    JZ 0x1000:5089
// 1000:506f      be 23 04                 MOV SI,0x423
// 1000:5072      8b 1e 97 a2              MOV BX,word ptr [0xa297]
// 1000:5076      81 7f 08 b8 0b           CMP word ptr [BX + 0x8],0xbb8
// 1000:507b      72 0c                    JC 0x1000:5089
// 1000:507d      80 7f 0e 14              CMP byte ptr [BX + 0xe],0x14
// 1000:5081      73 06                    JNC 0x1000:5089
// 1000:5083      be 37 28                 MOV SI,0x2837
// 1000:5086      eb 0e                    JMP 0x1000:5096
// 1000:5089  LAB_1000_5089:
// 1000:5089      a0 d2 89                 MOV AL,[0x89d2]
// 1000:508c      02 c1                    ADD AL,CL
// 1000:508e      24 03                    AND AL,0x3
// 1000:5090      b4 2c                    MOV AH,0x2c
// 1000:5092      f6 e4                    MUL AH
// 1000:5094      03 f0                    ADD SI,AX
// 1000:5096  LAB_1000_5096:
// 1000:5096      bd 37 28                 MOV BP,0x2837
// 1000:5099      e8 c3 02                 CALL 0x1000:535f
// 1000:509c      83 c7 3b                 ADD DI,0x3b
// 1000:509f      59                       POP CX
// 1000:50a0      fe c1                    INC CL
// 1000:50a2      3a 0e 01 00              CMP CL,byte ptr [0x1]
// 1000:50a6      75 b6                    JNZ 0x1000:505e
// 1000:50a8      c3                       RET
fun_5058 :: proc() {
}

// @proc 1000:50a9
// listing: FUN_1000_50a9
// status: unread
// 1000:50a9  FUN_1000_50a9:
// 1000:50a9      a0 74 a2                 MOV AL,[0xa274]
// 1000:50ac      32 e4                    XOR AH,AH
// 1000:50ae      be 28 00                 MOV SI,0x28
// 1000:50b1      f7 e6                    MUL SI
// 1000:50b3      8b f0                    MOV SI,AX
// 1000:50b5      81 c6 ec 89              ADD SI,0x89ec
// 1000:50b9      ac                       LODSB SI
// 1000:50ba      3c 00                    CMP AL,0x0
// 1000:50bc      74 26                    JZ 0x1000:50e4
// 1000:50be      b9 08 00                 MOV CX,0x8
// 1000:50c1      ba b0 00                 MOV DX,0xb0
// 1000:50c4      e8 a2 05                 CALL 0x1000:5669
// 1000:50c7      ac                       LODSB SI
// 1000:50c8  LAB_1000_50c8:
// 1000:50c8      ac                       LODSB SI
// 1000:50c9      3c 00                    CMP AL,0x0
// 1000:50cb      74 07                    JZ 0x1000:50d4
// 1000:50cd      b4 01                    MOV AH,0x1
// 1000:50cf      e8 a9 04                 CALL 0x1000:557b
// 1000:50d2      eb f4                    JMP 0x1000:50c8
// 1000:50d4  LAB_1000_50d4:
// 1000:50d4      b0 7f                    MOV AL,0x7f
// 1000:50d6      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
// 1000:50db      74 02                    JZ 0x1000:50df
// 1000:50dd      b0 20                    MOV AL,0x20
// 1000:50df  LAB_1000_50df:
// 1000:50df      b4 01                    MOV AH,0x1
// 1000:50e1      e8 97 04                 CALL 0x1000:557b
// 1000:50e4  LAB_1000_50e4:
// 1000:50e4      be 9e a2                 MOV SI,0xa29e
// 1000:50e7      ac                       LODSB SI
// 1000:50e8      3c 00                    CMP AL,0x0
// 1000:50ea      74 15                    JZ 0x1000:5101
// 1000:50ec      b9 08 00                 MOV CX,0x8
// 1000:50ef      ba b8 00                 MOV DX,0xb8
// 1000:50f2      e8 74 05                 CALL 0x1000:5669
// 1000:50f5  LAB_1000_50f5:
// 1000:50f5      ac                       LODSB SI
// 1000:50f6      3c 00                    CMP AL,0x0
// 1000:50f8      74 07                    JZ 0x1000:5101
// 1000:50fa      b4 02                    MOV AH,0x2
// 1000:50fc      e8 7c 04                 CALL 0x1000:557b
// 1000:50ff      eb f4                    JMP 0x1000:50f5
// 1000:5101  LAB_1000_5101:
// 1000:5101      c3                       RET
fun_50a9 :: proc() {
}

// @proc 1000:5102
// listing: FUN_1000_5102
// status: unread
// 1000:5102  FUN_1000_5102:
// 1000:5102      e8 83 00                 CALL 0x1000:5188
// 1000:5105      e8 f3 06                 CALL 0x1000:57fb
//                 ; inline script -> 1000:511a  <c1><box>GAME OVER
// 1000:511a  LAB_1000_511a:
// 1000:511a      c3                       RET
fun_5102 :: proc() {
}

// @proc 1000:511b
// listing: FUN_1000_511b
// status: unread
// 1000:511b  FUN_1000_511b:
// 1000:511b      f6 06 6c a2 ff           TEST byte ptr [0xa26c],0xff
// 1000:5120      75 01                    JNZ 0x1000:5123
// 1000:5122      c3                       RET
// 1000:5123  LAB_1000_5123:
// 1000:5123      f6 06 6c a2 80           TEST byte ptr [0xa26c],0x80
// 1000:5128      74 3e                    JZ 0x1000:5168
// 1000:512a      e8 5b 00                 CALL 0x1000:5188
// 1000:512d      e8 cb 06                 CALL 0x1000:57fb
//                 ; inline script -> 1000:5141  <c1><box> PAUSED 
// 1000:5141  LAB_1000_5141:
// 1000:5141      80 3e 71 a2 01           CMP byte ptr [0xa271],0x1
// 1000:5146      74 1f                    JZ 0x1000:5167
// 1000:5148      e8 b0 06                 CALL 0x1000:57fb
//                 ; inline script -> 1000:5167  <c3><box>HIT Esc TO CONTINUE
// 1000:5167  LAB_1000_5167:
// 1000:5167      c3                       RET
// 1000:5168  LAB_1000_5168:
// 1000:5168      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
// 1000:516d      74 18                    JZ 0x1000:5187
// 1000:516f      e8 16 00                 CALL 0x1000:5188
// 1000:5172      e8 86 06                 CALL 0x1000:57fb
//                 ; inline script -> 1000:5187  <c1><box> PAUSING 
// 1000:5187  LAB_1000_5187:
// 1000:5187      c3                       RET
fun_511b :: proc() {
}

// @proc 1000:5188
// listing: FUN_1000_5188
// status: unread
// 1000:5188  FUN_1000_5188:
// 1000:5188      e8 70 06                 CALL 0x1000:57fb
//                 ; inline script -> 1000:51dc  <c1><pic><pic><pic><pic><pic><pic><pic><pic><pic><pic><pic>
// 1000:51dc  LAB_1000_51dc:
// 1000:51dc      c3                       RET
fun_5188 :: proc() {
}

// @proc 1000:51dd
// listing: FUN_1000_51dd
// status: unread
// 1000:51dd  FUN_1000_51dd:
// 1000:51dd      8a 05                    MOV AL,byte ptr [DI]
// 1000:51df      a8 80                    TEST AL,0x80
// 1000:51e1      75 52                    JNZ 0x1000:5235
// 1000:51e3      bd 37 28                 MOV BP,0x2837
// 1000:51e6      22 c0                    AND AL,AL
// 1000:51e8      74 49                    JZ 0x1000:5233
// 1000:51ea      be 2d 26                 MOV SI,0x262d
// 1000:51ed      bd 21 28                 MOV BP,0x2821
// 1000:51f0      fe c8                    DEC AL
// 1000:51f2      74 3f                    JZ 0x1000:5233
// 1000:51f4      fe c8                    DEC AL
// 1000:51f6      74 3b                    JZ 0x1000:5233
// 1000:51f8      be 0f 26                 MOV SI,0x260f
// 1000:51fb      fe c8                    DEC AL
// 1000:51fd      74 34                    JZ 0x1000:5233
// 1000:51ff      bd 19 28                 MOV BP,0x2819
// 1000:5202      fe c8                    DEC AL
// 1000:5204      74 2d                    JZ 0x1000:5233
// 1000:5206      be f9 25                 MOV SI,0x25f9
// 1000:5209      fe c8                    DEC AL
// 1000:520b      74 26                    JZ 0x1000:5233
// 1000:520d      fe c8                    DEC AL
// 1000:520f      74 22                    JZ 0x1000:5233
// 1000:5211      bd 15 28                 MOV BP,0x2815
// 1000:5214      be f1 25                 MOV SI,0x25f1
// 1000:5217      fe c8                    DEC AL
// 1000:5219      74 18                    JZ 0x1000:5233
// 1000:521b      fe c8                    DEC AL
// 1000:521d      74 14                    JZ 0x1000:5233
// 1000:521f      be 0f 26                 MOV SI,0x260f
// 1000:5222      bd 19 28                 MOV BP,0x2819
// 1000:5225      fe c8                    DEC AL
// 1000:5227      74 0a                    JZ 0x1000:5233
// 1000:5229      fe c8                    DEC AL
// 1000:522b      74 06                    JZ 0x1000:5233
// 1000:522d      bd a7 20                 MOV BP,0x20a7
// 1000:5230      be 6f 20                 MOV SI,0x206f
// 1000:5233  LAB_1000_5233:
// 1000:5233      32 c0                    XOR AL,AL
// 1000:5235  LAB_1000_5235:
// 1000:5235      c3                       RET
fun_51dd :: proc() {
}

// @proc 1000:5236
// listing: FUN_1000_5236
// status: unread
// 1000:5236  FUN_1000_5236:
// 1000:5236      a0 70 a2                 MOV AL,[0xa270]
// 1000:5239      3c 07                    CMP AL,0x7
// 1000:523b      75 1c                    JNZ 0x1000:5259
// 1000:523d      be 2a 01                 MOV SI,0x12a
// 1000:5240      c7 06 8b a2 00 00        MOV word ptr [0xa28b],0x0
// 1000:5246      c7 06 8f a2 00 00        MOV word ptr [0xa28f],0x0
// 1000:524c      c7 06 8d a2 ff 3f        MOV word ptr [0xa28d],0x3fff
// 1000:5252      c7 06 91 a2 ff 3f        MOV word ptr [0xa291],0x3fff
// 1000:5258      c3                       RET
// 1000:5259  LAB_1000_5259:
// 1000:5259      e8 00 01                 CALL 0x1000:535c
// 1000:525c      f6 07 10                 TEST byte ptr [BX],0x10
// 1000:525f      74 10                    JZ 0x1000:5271
// 1000:5261      e8 6a cc                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:526c  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
// 1000:526c  LAB_1000_526c:
// 1000:526c      8b f3                    MOV SI,BX
// 1000:526e      eb 06                    JMP 0x1000:5276
// 1000:5271  LAB_1000_5271:
// 1000:5271      8a 07                    MOV AL,byte ptr [BX]
// 1000:5273      e8 96 d7                 CALL 0x1000:2a0c
// 1000:5276  LAB_1000_5276:
// 1000:5276      8a 0e 70 a2              MOV CL,byte ptr [0xa270]
// 1000:527a      ba 64 00                 MOV DX,0x64
// 1000:527d      d3 e2                    SHL DX,CL
// 1000:527f      8b 5c 01                 MOV BX,word ptr [SI + 0x1]
// 1000:5282      2b da                    SUB BX,DX
// 1000:5284      89 1e 8b a2              MOV word ptr [0xa28b],BX
// 1000:5288      03 da                    ADD BX,DX
// 1000:528a      03 da                    ADD BX,DX
// 1000:528c      4b                       DEC BX
// 1000:528d      89 1e 8d a2              MOV word ptr [0xa28d],BX
// 1000:5291      8b 5c 03                 MOV BX,word ptr [SI + 0x3]
// 1000:5294      2b da                    SUB BX,DX
// 1000:5296      89 1e 8f a2              MOV word ptr [0xa28f],BX
// 1000:529a      03 da                    ADD BX,DX
// 1000:529c      03 da                    ADD BX,DX
// 1000:529e      4b                       DEC BX
// 1000:529f      89 1e 91 a2              MOV word ptr [0xa291],BX
// 1000:52a3      c3                       RET
fun_5236 :: proc() {
}

// @proc 1000:52a4
// listing: FUN_1000_52a4
// status: unread
// 1000:52a4  FUN_1000_52a4:
// 1000:52a4      50                       PUSH AX
// 1000:52a5      be 61 01                 MOV SI,0x161
// 1000:52a8      8b ee                    MOV BP,SI
// 1000:52aa      e8 c1 00                 CALL 0x1000:536e
// 1000:52ad      58                       POP AX
// 1000:52ae      73 01                    JNC 0x1000:52b1
// 1000:52b0      c3                       RET
// 1000:52b1  LAB_1000_52b1:
// 1000:52b1      83 c6 02                 ADD SI,0x2
// 1000:52b4      51                       PUSH CX
// 1000:52b5      52                       PUSH DX
// 1000:52b6      b4 00                    MOV AH,0x0
// 1000:52b8      3c 06                    CMP AL,0x6
// 1000:52ba      73 0e                    JNC 0x1000:52ca
// 1000:52bc      fe c4                    INC AH
// 1000:52be      3c 02                    CMP AL,0x2
// 1000:52c0      72 08                    JC 0x1000:52ca
// 1000:52c2      fe c4                    INC AH
// 1000:52c4      3c 04                    CMP AL,0x4
// 1000:52c6      73 02                    JNC 0x1000:52ca
// 1000:52c8      fe c4                    INC AH
// 1000:52ca  LAB_1000_52ca:
// 1000:52ca      83 f9 14                 CMP CX,0x14
// 1000:52cd      72 21                    JC 0x1000:52f0
// 1000:52cf      81 f9 b4 00              CMP CX,0xb4
// 1000:52d3      72 36                    JC 0x1000:530b
// 1000:52d5      83 fa 14                 CMP DX,0x14
// 1000:52d8      73 05                    JNC 0x1000:52df
// 1000:52da      b4 02                    MOV AH,0x2
// 1000:52dc      eb 41                    JMP 0x1000:531f
// 1000:52df  LAB_1000_52df:
// 1000:52df      81 fa b4 00              CMP DX,0xb4
// 1000:52e3      73 06                    JNC 0x1000:52eb
// 1000:52e5      80 e4 02                 AND AH,0x2
// 1000:52e8      eb 35                    JMP 0x1000:531f
// 1000:52eb  LAB_1000_52eb:
// 1000:52eb      b4 00                    MOV AH,0x0
// 1000:52ed      eb 30                    JMP 0x1000:531f
// 1000:52f0  LAB_1000_52f0:
// 1000:52f0      83 fa 14                 CMP DX,0x14
// 1000:52f3      73 05                    JNC 0x1000:52fa
// 1000:52f5      b4 03                    MOV AH,0x3
// 1000:52f7      eb 26                    JMP 0x1000:531f
// 1000:52fa  LAB_1000_52fa:
// 1000:52fa      81 fa b4 00              CMP DX,0xb4
// 1000:52fe      73 06                    JNC 0x1000:5306
// 1000:5300      80 cc 01                 OR AH,0x1
// 1000:5303      eb 1a                    JMP 0x1000:531f
// 1000:5306  LAB_1000_5306:
// 1000:5306      b4 01                    MOV AH,0x1
// 1000:5308      eb 15                    JMP 0x1000:531f
// 1000:530b  LAB_1000_530b:
// 1000:530b      83 fa 14                 CMP DX,0x14
// 1000:530e      73 06                    JNC 0x1000:5316
// 1000:5310      80 cc 02                 OR AH,0x2
// 1000:5313      eb 0a                    JMP 0x1000:531f
// 1000:5316  LAB_1000_5316:
// 1000:5316      81 fa b4 00              CMP DX,0xb4
// 1000:531a      72 03                    JC 0x1000:531f
// 1000:531c      80 e4 01                 AND AH,0x1
// 1000:531f  LAB_1000_531f:
// 1000:531f      50                       PUSH AX
// 1000:5320      83 c1 03                 ADD CX,0x3
// 1000:5323      f6 c4 01                 TEST AH,0x1
// 1000:5326      74 06                    JZ 0x1000:532e
// 1000:5328      83 c6 16                 ADD SI,0x16
// 1000:532b      83 c1 0b                 ADD CX,0xb
// 1000:532e  LAB_1000_532e:
// 1000:532e      f6 c4 02                 TEST AH,0x2
// 1000:5331      74 06                    JZ 0x1000:5339
// 1000:5333      83 c6 2c                 ADD SI,0x2c
// 1000:5336      83 c2 0a                 ADD DX,0xa
// 1000:5339  LAB_1000_5339:
// 1000:5339      e8 ae 01                 CALL 0x1000:54ea
// 1000:533c      58                       POP AX
// 1000:533d      5a                       POP DX
// 1000:533e      59                       POP CX
// 1000:533f      be 63 02                 MOV SI,0x263
// 1000:5342      f6 c4 01                 TEST AH,0x1
// 1000:5345      74 03                    JZ 0x1000:534a
// 1000:5347      83 c1 14                 ADD CX,0x14
// 1000:534a  LAB_1000_534a:
// 1000:534a      f6 c4 02                 TEST AH,0x2
// 1000:534d      74 03                    JZ 0x1000:5352
// 1000:534f      83 c2 0a                 ADD DX,0xa
// 1000:5352  LAB_1000_5352:
// 1000:5352      b4 0c                    MOV AH,0xc
// 1000:5354      f6 e4                    MUL AH
// 1000:5356      03 f0                    ADD SI,AX
// 1000:5358      e8 8f 01                 CALL 0x1000:54ea
// 1000:535b      c3                       RET
fun_52a4 :: proc() {
}

// @proc 1000:535c
// listing: thunk_FUN_1000_1ec1
// status: unread
// 1000:535c  thunk_FUN_1000_1ec1:
// 1000:535c      e9 62 cb                 JMP 0x1000:1ec1
fun_535c :: proc() {
}

// @proc 1000:535f
// listing: FUN_1000_535f
// status: unread
// 1000:535f  FUN_1000_535f:
// 1000:535f      e8 0c 00                 CALL 0x1000:536e
// 1000:5362      72 09                    JC 0x1000:536d
// 1000:5364      81 fe 37 28              CMP SI,0x2837
// 1000:5368      74 03                    JZ 0x1000:536d
// 1000:536a      e8 7d 01                 CALL 0x1000:54ea
// 1000:536d  LAB_1000_536d:
// 1000:536d      c3                       RET
fun_535f :: proc() {
}

// @proc 1000:536e
// listing: FUN_1000_536e
// status: unread
// 1000:536e  FUN_1000_536e:
// 1000:536e      8a 45 05                 MOV AL,byte ptr [DI + 0x5]
// 1000:5371      3a 06 60 a3              CMP AL,byte ptr [0xa360]
// 1000:5375      f9                       STC
// 1000:5376      75 76                    JNZ 0x1000:53ee
// 1000:5378      8b 16 8b a2              MOV DX,word ptr [0xa28b]
// 1000:537c      8b 0e 8d a2              MOV CX,word ptr [0xa28d]
// 1000:5380      8b 5d 01                 MOV BX,word ptr [DI + 0x1]
// 1000:5383      e8 69 00                 CALL 0x1000:53ef
// 1000:5386      72 66                    JC 0x1000:53ee
// 1000:5388      8b 16 8f a2              MOV DX,word ptr [0xa28f]
// 1000:538c      8b 0e 91 a2              MOV CX,word ptr [0xa291]
// 1000:5390      8b 5d 03                 MOV BX,word ptr [DI + 0x3]
// 1000:5393      e8 59 00                 CALL 0x1000:53ef
// 1000:5396      72 56                    JC 0x1000:53ee
// 1000:5398      8b 16 91 a2              MOV DX,word ptr [0xa291]
// 1000:539c      2b 55 03                 SUB DX,word ptr [DI + 0x3]
// 1000:539f      8a 0e 70 a2              MOV CL,byte ptr [0xa270]
// 1000:53a3      80 f9 07                 CMP CL,0x7
// 1000:53a6      75 1a                    JNZ 0x1000:53c2
// 1000:53a8      b9 53 00                 MOV CX,0x53
// 1000:53ab      8b c2                    MOV AX,DX
// 1000:53ad      ba 00 00                 MOV DX,0x0
// 1000:53b0      f7 f1                    DIV CX
// 1000:53b2      50                       PUSH AX
// 1000:53b3      8b 45 01                 MOV AX,word ptr [DI + 0x1]
// 1000:53b6      ba 00 00                 MOV DX,0x0
// 1000:53b9      f7 f1                    DIV CX
// 1000:53bb      8b c8                    MOV CX,AX
// 1000:53bd      5a                       POP DX
// 1000:53be      8b f5                    MOV SI,BP
// 1000:53c0      eb 16                    JMP 0x1000:53d8
// 1000:53c2  LAB_1000_53c2:
// 1000:53c2      d3 ea                    SHR DX,CL
// 1000:53c4      8b 5d 01                 MOV BX,word ptr [DI + 0x1]
// 1000:53c7      2b 1e 8b a2              SUB BX,word ptr [0xa28b]
// 1000:53cb      d3 eb                    SHR BX,CL
// 1000:53cd      8b cb                    MOV CX,BX
// 1000:53cf      80 3e 70 a2 05           CMP byte ptr [0xa270],0x5
// 1000:53d4      72 02                    JC 0x1000:53d8
// 1000:53d6      8b f5                    MOV SI,BP
// 1000:53d8  LAB_1000_53d8:
// 1000:53d8      8a 04                    MOV AL,byte ptr [SI]
// 1000:53da      32 e4                    XOR AH,AH
// 1000:53dc      d1 e8                    SHR AX,0x1
// 1000:53de      83 c1 10                 ADD CX,0x10
// 1000:53e1      2b c8                    SUB CX,AX
// 1000:53e3      8a 44 01                 MOV AL,byte ptr [SI + 0x1]
// 1000:53e6      d1 e8                    SHR AX,0x1
// 1000:53e8      83 c2 10                 ADD DX,0x10
// 1000:53eb      2b d0                    SUB DX,AX
// 1000:53ed      f8                       CLC
// 1000:53ee  LAB_1000_53ee:
// 1000:53ee      c3                       RET
fun_536e :: proc() {
}

// @proc 1000:53ef
// listing: FUN_1000_53ef
// status: unread
// 1000:53ef  FUN_1000_53ef:
// 1000:53ef      8a c6                    MOV AL,DH
// 1000:53f1      32 c7                    XOR AL,BH
// 1000:53f3      78 06                    JS 0x1000:53fb
// 1000:53f5      3b da                    CMP BX,DX
// 1000:53f7      72 13                    JC 0x1000:540c
// 1000:53f9      eb 04                    JMP 0x1000:53ff
// 1000:53fb  LAB_1000_53fb:
// 1000:53fb      22 c6                    AND AL,DH
// 1000:53fd      79 0d                    JNS 0x1000:540c
// 1000:53ff  LAB_1000_53ff:
// 1000:53ff      8a c5                    MOV AL,CH
// 1000:5401      32 c7                    XOR AL,BH
// 1000:5403      78 03                    JS 0x1000:5408
// 1000:5405      3b cb                    CMP CX,BX
// 1000:5407      c3                       RET
// 1000:5408  LAB_1000_5408:
// 1000:5408      22 c7                    AND AL,BH
// 1000:540a      78 01                    JS 0x1000:540d
// 1000:540c  LAB_1000_540c:
// 1000:540c      f9                       STC
// 1000:540d  LAB_1000_540d:
// 1000:540d      c3                       RET
fun_53ef :: proc() {
}

// @proc 1000:540e
// listing: FUN_1000_540e
// status: unread
// 1000:540e  FUN_1000_540e:
// 1000:540e      b9 05 00                 MOV CX,0x5
// 1000:5411      b3 20                    MOV BL,0x20
// 1000:5413      eb 13                    JMP 0x1000:5428
fun_540e :: proc() {
}

// @proc 1000:5415
// listing: FUN_1000_5415
// status: unread
// 1000:5415  FUN_1000_5415:
// 1000:5415      b9 04 00                 MOV CX,0x4
// 1000:5418      b3 20                    MOV BL,0x20
// 1000:541a      eb 0c                    JMP 0x1000:5428
fun_5415 :: proc() {
}

// @proc 1000:541c
// listing: FUN_1000_541c
// status: unread
// 1000:541c  FUN_1000_541c:
// 1000:541c      b9 03 00                 MOV CX,0x3
// 1000:541f      32 e4                    XOR AH,AH
// 1000:5421      eb 05                    JMP 0x1000:5428
fun_541c :: proc() {
}

// @proc 1000:5423
// listing: FUN_1000_5423
// status: unread
// 1000:5423  FUN_1000_5423:
// 1000:5423      b9 02 00                 MOV CX,0x2
// 1000:5426      32 e4                    XOR AH,AH
// 1000:5428  LAB_1000_5428:
// 1000:5428      56                       PUSH SI
// 1000:5429      57                       PUSH DI
// 1000:542a      be 0a 00                 MOV SI,0xa
// 1000:542d      8b f9                    MOV DI,CX
// 1000:542f  LAB_1000_542f:
// 1000:542f      33 d2                    XOR DX,DX
// 1000:5431      f7 f6                    DIV SI
// 1000:5433      52                       PUSH DX
// 1000:5434      e2 f9                    LOOP 0x1000:542f
// 1000:5436      8b cf                    MOV CX,DI
// 1000:5438  LAB_1000_5438:
// 1000:5438      58                       POP AX
// 1000:5439      22 c0                    AND AL,AL
// 1000:543b      74 02                    JZ 0x1000:543f
// 1000:543d      b3 30                    MOV BL,0x30
// 1000:543f  LAB_1000_543f:
// 1000:543f      0a c3                    OR AL,BL
// 1000:5441      e8 33 01                 CALL 0x1000:5577
// 1000:5444      83 f9 02                 CMP CX,0x2
// 1000:5447      75 02                    JNZ 0x1000:544b
// 1000:5449      b3 30                    MOV BL,0x30
// 1000:544b  LAB_1000_544b:
// 1000:544b      e2 eb                    LOOP 0x1000:5438
// 1000:544d      5f                       POP DI
// 1000:544e      5e                       POP SI
// 1000:544f      c3                       RET
fun_5423 :: proc() {
}

// @proc 1000:5450
// listing: FUN_1000_5450
// status: unread
// 1000:5450  FUN_1000_5450:
// 1000:5450      06                       PUSH ES
// 1000:5451      1e                       PUSH DS
// 1000:5452      07                       POP ES
// 1000:5453      b8 00 00                 MOV AX,0x0
// 1000:5456      51                       PUSH CX
// 1000:5457      57                       PUSH DI
// 1000:5458      bf c1 39                 MOV DI,0x39c1
// 1000:545b      b9 70 23                 MOV CX,0x2370
// 1000:545e      f3 ab                    STOSW.REP ES:DI
// 1000:5460      5f                       POP DI
// 1000:5461      59                       POP CX
// 1000:5462      07                       POP ES
// 1000:5463      c3                       RET
fun_5450 :: proc() {
}

// @proc 1000:5464
// listing: FUN_1000_5464
// status: unread
// 1000:5464  FUN_1000_5464:
// 1000:5464      25 03 00                 AND AX,0x3
// 1000:5467      d1 e0                    SHL AX,0x1
// 1000:5469      bb a8 54                 MOV BX,0x54a8
// 1000:546c      03 d8                    ADD BX,AX
// 1000:546e      2e 8b 07                 MOV AX,word ptr CS:[BX]
// 1000:5471      bf 05 3f                 MOV DI,0x3f05
// 1000:5474      25 0f f0                 AND AX,0xf00f
// 1000:5477      b9 c8 00                 MOV CX,0xc8
// 1000:547a  LAB_1000_547a:
// 1000:547a      88 25                    MOV byte ptr [DI],AH
// 1000:547c      88 45 31                 MOV byte ptr [DI + 0x31],AL
// 1000:547f      83 c7 54                 ADD DI,0x54
// 1000:5482      e2 f6                    LOOP 0x1000:547a
// 1000:5484      bf 05 3f                 MOV DI,0x3f05
// 1000:5487      2e 8b 07                 MOV AX,word ptr CS:[BX]
// 1000:548a      b9 19 00                 MOV CX,0x19
// 1000:548d      f3 ab                    STOSW.REP ES:DI
// 1000:548f      bf 59 3f                 MOV DI,0x3f59
// 1000:5492      b9 19 00                 MOV CX,0x19
// 1000:5495      f3 ab                    STOSW.REP ES:DI
// 1000:5497      bf fd 7f                 MOV DI,0x7ffd
// 1000:549a      b9 19 00                 MOV CX,0x19
// 1000:549d      f3 ab                    STOSW.REP ES:DI
// 1000:549f      bf 51 80                 MOV DI,0x8051
// 1000:54a2      b9 19 00                 MOV CX,0x19
// 1000:54a5      f3 ab                    STOSW.REP ES:DI
// 1000:54a7      c3                       RET
fun_5464 :: proc() {
}

// @proc 1000:54b0
// listing: blit_screen
// status: unread
// video: copies the offscreen frame into CGA memory at segment B800. host_blit is the seam. The store stays stubbed.
// 1000:54b0  blit_screen:
// 1000:54b0      51                       PUSH CX
// 1000:54b1      57                       PUSH DI
// 1000:54b2      56                       PUSH SI
// 1000:54b3      06                       PUSH ES
// 1000:54b4      b8 00 b8                 MOV AX,0xb800
// 1000:54b7      8e c0                    MOV ES,AX
// 1000:54b9      be 05 3f                 MOV SI,0x3f05
// 1000:54bc      bf 00 00                 MOV DI,0x0
// 1000:54bf      b9 64 00                 MOV CX,0x64
// 1000:54c2  LAB_1000_54c2:
// 1000:54c2      51                       PUSH CX
// 1000:54c3      57                       PUSH DI
// 1000:54c4      b9 28 00                 MOV CX,0x28
// 1000:54c7      f3 a5                    MOVSW.REP ES:DI,SI
// 1000:54c9      83 c6 04                 ADD SI,0x4
// 1000:54cc      5f                       POP DI
// 1000:54cd      81 cf 00 20              OR DI,0x2000
// 1000:54d1      b9 28 00                 MOV CX,0x28
// 1000:54d4      f3 a5                    MOVSW.REP ES:DI,SI
// 1000:54d6      83 c6 04                 ADD SI,0x4
// 1000:54d9      81 f7 00 20              XOR DI,0x2000
// 1000:54dd      59                       POP CX
// 1000:54de      e2 e2                    LOOP 0x1000:54c2
// 1000:54e0      07                       POP ES
// 1000:54e1      5e                       POP SI
// 1000:54e2      5f                       POP DI
// 1000:54e3      59                       POP CX
// 1000:54e4      c3                       RET
fun_54b0 :: proc() {
}

// @proc 1000:54e5
// listing: FUN_1000_54e5
// status: unread
// 1000:54e5  FUN_1000_54e5:
// 1000:54e5      bb 37 3f                 MOV BX,0x3f37
// 1000:54e8      eb 03                    JMP 0x1000:54ed
fun_54e5 :: proc() {
}

// @proc 1000:54ea
// listing: FUN_1000_54ea
// status: unread
// 1000:54ea  FUN_1000_54ea:
// 1000:54ea      bb c1 39                 MOV BX,0x39c1
fun_54ea :: proc() {
}

// @proc 1000:54ed
// listing: FUN_1000_54ed
// status: unread
// 1000:54ed  FUN_1000_54ed:
// 1000:54ed      51                       PUSH CX
// 1000:54ee      52                       PUSH DX
// 1000:54ef      55                       PUSH BP
// 1000:54f0      56                       PUSH SI
// 1000:54f1      57                       PUSH DI
// 1000:54f2      32 c0                    XOR AL,AL
// 1000:54f4      d1 e9                    SHR CX,0x1
// 1000:54f6      d0 d8                    RCR AL,0x1
// 1000:54f8      d1 e9                    SHR CX,0x1
// 1000:54fa      d0 d0                    RCL AL,0x1
// 1000:54fc      d0 d0                    RCL AL,0x1
// 1000:54fe      8b e9                    MOV BP,CX
// 1000:5500      02 c0                    ADD AL,AL
// 1000:5502      8a c8                    MOV CL,AL
// 1000:5504      b5 08                    MOV CH,0x8
// 1000:5506      2a e8                    SUB CH,AL
// 1000:5508      b8 54 00                 MOV AX,0x54
// 1000:550b      f6 e2                    MUL DL
// 1000:550d      03 d8                    ADD BX,AX
// 1000:550f      8b 14                    MOV DX,word ptr [SI]
// 1000:5511      46                       INC SI
// 1000:5512      46                       INC SI
// 1000:5513  LAB_1000_5513:
// 1000:5513      8b fd                    MOV DI,BP
// 1000:5515      52                       PUSH DX
// 1000:5516  LAB_1000_5516:
// 1000:5516      8a 24                    MOV AH,byte ptr [SI]
// 1000:5518      46                       INC SI
// 1000:5519      b0 ff                    MOV AL,0xff
// 1000:551b      d3 c8                    ROR AX,CL
// 1000:551d      3b 3e 05 00              CMP DI,word ptr [0x5]
// 1000:5521      73 0e                    JNC 0x1000:5531
// 1000:5523      20 41 01                 AND byte ptr [BX + DI + 0x1],AL
// 1000:5526      8a 04                    MOV AL,byte ptr [SI]
// 1000:5528      86 cd                    XCHG CH,CL
// 1000:552a      d2 e0                    SHL AL,CL
// 1000:552c      86 cd                    XCHG CH,CL
// 1000:552e      08 41 01                 OR byte ptr [BX + DI + 0x1],AL
// 1000:5531  LAB_1000_5531:
// 1000:5531      3b 3e 05 00              CMP DI,word ptr [0x5]
// 1000:5535      77 08                    JA 0x1000:553f
// 1000:5537      20 21                    AND byte ptr [BX + DI],AH
// 1000:5539      8a 04                    MOV AL,byte ptr [SI]
// 1000:553b      d2 e8                    SHR AL,CL
// 1000:553d      08 01                    OR byte ptr [BX + DI],AL
// 1000:553f  LAB_1000_553f:
// 1000:553f      46                       INC SI
// 1000:5540      47                       INC DI
// 1000:5541      80 ea 04                 SUB DL,0x4
// 1000:5544      77 d0                    JA 0x1000:5516
// 1000:5546      83 c3 54                 ADD BX,0x54
// 1000:5549      5a                       POP DX
// 1000:554a      fe ce                    DEC DH
// 1000:554c      75 c5                    JNZ 0x1000:5513
// 1000:554e      5f                       POP DI
// 1000:554f      5e                       POP SI
// 1000:5550      5d                       POP BP
// 1000:5551      5a                       POP DX
// 1000:5552      59                       POP CX
// 1000:5553      c3                       RET
fun_54ed :: proc() {
}

// @proc 1000:5554
// listing: print_cstr
// status: unread
// 1000:5554  print_cstr:
// 1000:5554      58                       POP AX
// 1000:5555      53                       PUSH BX
// 1000:5556      8b d8                    MOV BX,AX
// 1000:5558  LAB_1000_5558:
// 1000:5558      2e 8a 07                 MOV AL,byte ptr CS:[BX]
// 1000:555b      43                       INC BX
// 1000:555c      3c 00                    CMP AL,0x0
// 1000:555e      74 12                    JZ 0x1000:5572
// 1000:5560      3c 04                    CMP AL,0x4
// 1000:5562      73 05                    JNC 0x1000:5569
// 1000:5564      a2 9b a2                 MOV [0xa29b],AL
// 1000:5567      eb ef                    JMP 0x1000:5558
// 1000:5569  LAB_1000_5569:
// 1000:5569      8a 26 9b a2              MOV AH,byte ptr [0xa29b]
// 1000:556d      e8 0b 00                 CALL 0x1000:557b
// 1000:5570      eb e6                    JMP 0x1000:5558
// 1000:5572  LAB_1000_5572:
// 1000:5572      8b c3                    MOV AX,BX
// 1000:5574      5b                       POP BX
// 1000:5575      50                       PUSH AX
// 1000:5576      c3                       RET
fun_5554 :: proc() {
}

// @proc 1000:5577
// listing: FUN_1000_5577
// status: unread
// 1000:5577  FUN_1000_5577:
// 1000:5577      8a 26 9b a2              MOV AH,byte ptr [0xa29b]
fun_5577 :: proc() {
}

// @proc 1000:557b
// listing: FUN_1000_557b
// notes: draw_glyph
// status: unread
// 1000:557b  FUN_1000_557b:
// 1000:557b      53                       PUSH BX
// 1000:557c      56                       PUSH SI
// 1000:557d      51                       PUSH CX
// 1000:557e      8b 1e 93 a2              MOV BX,word ptr [0xa293]
// 1000:5582      83 06 93 a2 02           ADD word ptr [0xa293],0x2
// 1000:5587      8b 36 16 00              MOV SI,word ptr [0x16]
// 1000:558b      b1 04                    MOV CL,0x4
// 1000:558d      3c 90                    CMP AL,0x90
// 1000:558f      72 03                    JC 0x1000:5594
// 1000:5591      e9 02 af                 JMP 0x1000:0496
// 1000:5594  LAB_1000_5594:
// 1000:5594      fe cc                    DEC AH
// 1000:5596      74 08                    JZ 0x1000:55a0
// 1000:5598      fe cc                    DEC AH
// 1000:559a      74 33                    JZ 0x1000:55cf
// 1000:559c      fe cc                    DEC AH
// 1000:559e      74 6c                    JZ 0x1000:560c
// 1000:55a0  LAB_1000_55a0:
// 1000:55a0      32 e4                    XOR AH,AH
// 1000:55a2      d3 e0                    SHL AX,CL
// 1000:55a4      03 f0                    ADD SI,AX
// 1000:55a6      ad                       LODSW SI
// 1000:55a7      89 07                    MOV word ptr [BX],AX
// 1000:55a9      ad                       LODSW SI
// 1000:55aa      89 47 54                 MOV word ptr [BX + 0x54],AX
// 1000:55ad      ad                       LODSW SI
// 1000:55ae      89 87 a8 00              MOV word ptr [BX + 0xa8],AX
// 1000:55b2      ad                       LODSW SI
// 1000:55b3      89 87 fc 00              MOV word ptr [BX + 0xfc],AX
// 1000:55b7      ad                       LODSW SI
// 1000:55b8      89 87 50 01              MOV word ptr [BX + 0x150],AX
// 1000:55bc      ad                       LODSW SI
// 1000:55bd      89 87 a4 01              MOV word ptr [BX + 0x1a4],AX
// 1000:55c1      ad                       LODSW SI
// 1000:55c2      89 87 f8 01              MOV word ptr [BX + 0x1f8],AX
// 1000:55c6      ad                       LODSW SI
// 1000:55c7      89 87 4c 02              MOV word ptr [BX + 0x24c],AX
// 1000:55cb      59                       POP CX
// 1000:55cc      5e                       POP SI
// 1000:55cd      5b                       POP BX
// 1000:55ce      c3                       RET
// 1000:55cf  LAB_1000_55cf:
// 1000:55cf      d3 e0                    SHL AX,CL
// 1000:55d1      03 f0                    ADD SI,AX
// 1000:55d3      ad                       LODSW SI
// 1000:55d4      d1 e0                    SHL AX,0x1
// 1000:55d6      89 07                    MOV word ptr [BX],AX
// 1000:55d8      ad                       LODSW SI
// 1000:55d9      d1 e0                    SHL AX,0x1
// 1000:55db      89 47 54                 MOV word ptr [BX + 0x54],AX
// 1000:55de      ad                       LODSW SI
// 1000:55df      d1 e0                    SHL AX,0x1
// 1000:55e1      89 87 a8 00              MOV word ptr [BX + 0xa8],AX
// 1000:55e5      ad                       LODSW SI
// 1000:55e6      d1 e0                    SHL AX,0x1
// 1000:55e8      89 87 fc 00              MOV word ptr [BX + 0xfc],AX
// 1000:55ec      ad                       LODSW SI
// 1000:55ed      d1 e0                    SHL AX,0x1
// 1000:55ef      89 87 50 01              MOV word ptr [BX + 0x150],AX
// 1000:55f3      ad                       LODSW SI
// 1000:55f4      d1 e0                    SHL AX,0x1
// 1000:55f6      89 87 a4 01              MOV word ptr [BX + 0x1a4],AX
// 1000:55fa      ad                       LODSW SI
// 1000:55fb      d1 e0                    SHL AX,0x1
// 1000:55fd      89 87 f8 01              MOV word ptr [BX + 0x1f8],AX
// 1000:5601      ad                       LODSW SI
// 1000:5602      d1 e0                    SHL AX,0x1
// 1000:5604      89 87 4c 02              MOV word ptr [BX + 0x24c],AX
// 1000:5608      59                       POP CX
// 1000:5609      5e                       POP SI
// 1000:560a      5b                       POP BX
// 1000:560b      c3                       RET
// 1000:560c  LAB_1000_560c:
// 1000:560c      d3 e0                    SHL AX,CL
// 1000:560e      03 f0                    ADD SI,AX
// 1000:5610      ad                       LODSW SI
// 1000:5611      8b c8                    MOV CX,AX
// 1000:5613      d1 e0                    SHL AX,0x1
// 1000:5615      0b c1                    OR AX,CX
// 1000:5617      89 07                    MOV word ptr [BX],AX
// 1000:5619      ad                       LODSW SI
// 1000:561a      8b c8                    MOV CX,AX
// 1000:561c      d1 e0                    SHL AX,0x1
// 1000:561e      0b c1                    OR AX,CX
// 1000:5620      89 47 54                 MOV word ptr [BX + 0x54],AX
// 1000:5623      ad                       LODSW SI
// 1000:5624      8b c8                    MOV CX,AX
// 1000:5626      d1 e0                    SHL AX,0x1
// 1000:5628      0b c1                    OR AX,CX
// 1000:562a      89 87 a8 00              MOV word ptr [BX + 0xa8],AX
// 1000:562e      ad                       LODSW SI
// 1000:562f      8b c8                    MOV CX,AX
// 1000:5631      d1 e0                    SHL AX,0x1
// 1000:5633      0b c1                    OR AX,CX
// 1000:5635      89 87 fc 00              MOV word ptr [BX + 0xfc],AX
// 1000:5639      ad                       LODSW SI
// 1000:563a      8b c8                    MOV CX,AX
// 1000:563c      d1 e0                    SHL AX,0x1
// 1000:563e      0b c1                    OR AX,CX
// 1000:5640      89 87 50 01              MOV word ptr [BX + 0x150],AX
// 1000:5644      ad                       LODSW SI
// 1000:5645      8b c8                    MOV CX,AX
// 1000:5647      d1 e0                    SHL AX,0x1
// 1000:5649      0b c1                    OR AX,CX
// 1000:564b      89 87 a4 01              MOV word ptr [BX + 0x1a4],AX
// 1000:564f      ad                       LODSW SI
// 1000:5650      8b c8                    MOV CX,AX
// 1000:5652      d1 e0                    SHL AX,0x1
// 1000:5654      0b c1                    OR AX,CX
// 1000:5656      89 87 f8 01              MOV word ptr [BX + 0x1f8],AX
// 1000:565a      ad                       LODSW SI
// 1000:565b      8b c8                    MOV CX,AX
// 1000:565d      d1 e0                    SHL AX,0x1
// 1000:565f      0b c1                    OR AX,CX
// 1000:5661      89 87 4c 02              MOV word ptr [BX + 0x24c],AX
// 1000:5665      59                       POP CX
// 1000:5666      5e                       POP SI
// 1000:5667      5b                       POP BX
// 1000:5668      c3                       RET
fun_557b :: proc() {
}

// @proc 1000:5669
// listing: FUN_1000_5669
// notes: move_cursor
// status: unread
// 1000:5669  FUN_1000_5669:
// 1000:5669      50                       PUSH AX
// 1000:566a      b0 54                    MOV AL,0x54
// 1000:566c      f6 e2                    MUL DL
// 1000:566e      03 c1                    ADD AX,CX
// 1000:5670      05 01 3f                 ADD AX,0x3f01
// 1000:5673      a3 93 a2                 MOV [0xa293],AX
// 1000:5676      58                       POP AX
// 1000:5677      c3                       RET
fun_5669 :: proc() {
}

// @proc 1000:5678
// listing: FUN_1000_5678
// status: unread
// 1000:5678  FUN_1000_5678:
// 1000:5678      f6 06 14 00 03           TEST byte ptr [0x14],0x3
// 1000:567d      74 0c                    JZ 0x1000:568b
// 1000:567f      b9 21 00                 MOV CX,0x21
// 1000:5682      ba 00 00                 MOV DX,0x0
// 1000:5685      be 33 01                 MOV SI,0x133
// 1000:5688      e8 5a fe                 CALL 0x1000:54e5
// 1000:568b  LAB_1000_568b:
// 1000:568b      c3                       RET
fun_5678 :: proc() {
}

// @proc 1000:568c
// listing: FUN_1000_568c
// status: unread
// 1000:568c  FUN_1000_568c:
// 1000:568c      8b 36 97 a2              MOV SI,word ptr [0xa297]
// 1000:5690      f6 44 29 01              TEST byte ptr [SI + 0x29],0x1
// 1000:5694      74 19                    JZ 0x1000:56af
// 1000:5696      f6 44 29 02              TEST byte ptr [SI + 0x29],0x2
// 1000:569a      74 07                    JZ 0x1000:56a3
// 1000:569c      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
// 1000:56a1      74 0c                    JZ 0x1000:56af
// 1000:56a3  LAB_1000_56a3:
// 1000:56a3      b9 1f 00                 MOV CX,0x1f
// 1000:56a6      ba 1a 00                 MOV DX,0x1a
// 1000:56a9      be 3f 01                 MOV SI,0x13f
// 1000:56ac      e8 36 fe                 CALL 0x1000:54e5
// 1000:56af  LAB_1000_56af:
// 1000:56af      c3                       RET
fun_568c :: proc() {
}

// @proc 1000:56b0
// listing: FUN_1000_56b0
// notes: draw_impulse_gauge
// status: unread
// 1000:56b0  FUN_1000_56b0:
// 1000:56b0      50                       PUSH AX
// 1000:56b1      b9 24 00                 MOV CX,0x24
// 1000:56b4      ba 00 00                 MOV DX,0x0
// 1000:56b7      be d3 04                 MOV SI,0x4d3
// 1000:56ba      e8 28 fe                 CALL 0x1000:54e5
// 1000:56bd      5a                       POP DX
// 1000:56be      52                       PUSH DX
// 1000:56bf      80 e2 f0                 AND DL,0xf0
// 1000:56c2      d0 ea                    SHR DL,0x1
// 1000:56c4      d0 ea                    SHR DL,0x1
// 1000:56c6      d0 ea                    SHR DL,0x1
// 1000:56c8      d0 ea                    SHR DL,0x1
// 1000:56ca      80 fa 0b                 CMP DL,0xb
// 1000:56cd      72 02                    JC 0x1000:56d1
// 1000:56cf      b2 0b                    MOV DL,0xb
// 1000:56d1  LAB_1000_56d1:
// 1000:56d1      b8 14 00                 MOV AX,0x14
// 1000:56d4      f6 e2                    MUL DL
// 1000:56d6      be 3b 0d                 MOV SI,0xd3b
// 1000:56d9      03 f0                    ADD SI,AX
// 1000:56db      8a 0c                    MOV CL,byte ptr [SI]
// 1000:56dd      32 ed                    XOR CH,CH
// 1000:56df      83 c1 24                 ADD CX,0x24
// 1000:56e2      46                       INC SI
// 1000:56e3      8a 14                    MOV DL,byte ptr [SI]
// 1000:56e5      32 f6                    XOR DH,DH
// 1000:56e7      46                       INC SI
// 1000:56e8      e8 fa fd                 CALL 0x1000:54e5
// 1000:56eb      5a                       POP DX
// 1000:56ec      80 e2 0f                 AND DL,0xf
// 1000:56ef      80 fa 0b                 CMP DL,0xb
// 1000:56f2      72 02                    JC 0x1000:56f6
// 1000:56f4      b2 0b                    MOV DL,0xb
// 1000:56f6  LAB_1000_56f6:
// 1000:56f6      b8 14 00                 MOV AX,0x14
// 1000:56f9      f6 e2                    MUL DL
// 1000:56fb      be 2b 0e                 MOV SI,0xe2b
// 1000:56fe      03 f0                    ADD SI,AX
// 1000:5700      8a 0c                    MOV CL,byte ptr [SI]
// 1000:5702      32 ed                    XOR CH,CH
// 1000:5704      83 c1 24                 ADD CX,0x24
// 1000:5707      46                       INC SI
// 1000:5708      8a 14                    MOV DL,byte ptr [SI]
// 1000:570a      32 f6                    XOR DH,DH
// 1000:570c      46                       INC SI
// 1000:570d      e8 d5 fd                 CALL 0x1000:54e5
// 1000:5710      c3                       RET
fun_56b0 :: proc() {
}

// @proc 1000:5711
// listing: FUN_1000_5711
// notes: draw_heading_gauge
// status: unread
// 1000:5711  FUN_1000_5711:
// 1000:5711      50                       PUSH AX
// 1000:5712      b9 00 00                 MOV CX,0x0
// 1000:5715      ba 00 00                 MOV DX,0x0
// 1000:5718      be 27 07                 MOV SI,0x727
// 1000:571b      e8 c7 fd                 CALL 0x1000:54e5
// 1000:571e      5a                       POP DX
// 1000:571f      52                       PUSH DX
// 1000:5720      80 e2 f0                 AND DL,0xf0
// 1000:5723      d0 ea                    SHR DL,0x1
// 1000:5725      d0 ea                    SHR DL,0x1
// 1000:5727      d0 ea                    SHR DL,0x1
// 1000:5729      d0 ea                    SHR DL,0x1
// 1000:572b      b8 1c 00                 MOV AX,0x1c
// 1000:572e      f6 e2                    MUL DL
// 1000:5730      be 1b 0f                 MOV SI,0xf1b
// 1000:5733      03 f0                    ADD SI,AX
// 1000:5735      8a 0c                    MOV CL,byte ptr [SI]
// 1000:5737      32 ed                    XOR CH,CH
// 1000:5739      46                       INC SI
// 1000:573a      8a 14                    MOV DL,byte ptr [SI]
// 1000:573c      32 f6                    XOR DH,DH
// 1000:573e      46                       INC SI
// 1000:573f      e8 a3 fd                 CALL 0x1000:54e5
// 1000:5742      5a                       POP DX
// 1000:5743      80 e2 0f                 AND DL,0xf
// 1000:5746      b8 1c 00                 MOV AX,0x1c
// 1000:5749      f6 e2                    MUL DL
// 1000:574b      be d3 10                 MOV SI,0x10d3
// 1000:574e      03 f0                    ADD SI,AX
// 1000:5750      8a 0c                    MOV CL,byte ptr [SI]
// 1000:5752      32 ed                    XOR CH,CH
// 1000:5754      46                       INC SI
// 1000:5755      8a 14                    MOV DL,byte ptr [SI]
// 1000:5757      32 f6                    XOR DH,DH
// 1000:5759      46                       INC SI
// 1000:575a      e8 88 fd                 CALL 0x1000:54e5
// 1000:575d      c3                       RET
fun_5711 :: proc() {
}

// @proc 1000:575e
// listing: FUN_1000_575e
// notes: draw_mine_icons
// status: unread
// 1000:575e  FUN_1000_575e:
// 1000:575e      b9 4a 00                 MOV CX,0x4a
// 1000:5761      ba 00 00                 MOV DX,0x0
// 1000:5764  LAB_1000_5764:
// 1000:5764      3c 00                    CMP AL,0x0
// 1000:5766      74 0f                    JZ 0x1000:5777
// 1000:5768      50                       PUSH AX
// 1000:5769      be a3 18                 MOV SI,0x18a3
// 1000:576c      e8 76 fd                 CALL 0x1000:54e5
// 1000:576f      83 c1 08                 ADD CX,0x8
// 1000:5772      58                       POP AX
// 1000:5773      fe c8                    DEC AL
// 1000:5775      75 ed                    JNZ 0x1000:5764
// 1000:5777  LAB_1000_5777:
// 1000:5777      c3                       RET
fun_575e :: proc() {
}

// @proc 1000:5778
// listing: FUN_1000_5778
// notes: draw_torpedo_icons
// status: unread
// 1000:5778  FUN_1000_5778:
// 1000:5778      50                       PUSH AX
// 1000:5779      3c 0b                    CMP AL,0xb
// 1000:577b      72 02                    JC 0x1000:577f
// 1000:577d      b0 09                    MOV AL,0x9
// 1000:577f  LAB_1000_577f:
// 1000:577f      b9 4b 00                 MOV CX,0x4b
// 1000:5782      ba 0c 00                 MOV DX,0xc
// 1000:5785  LAB_1000_5785:
// 1000:5785      3c 00                    CMP AL,0x0
// 1000:5787      74 1a                    JZ 0x1000:57a3
// 1000:5789      50                       PUSH AX
// 1000:578a      be 8b 12                 MOV SI,0x128b
// 1000:578d      e8 55 fd                 CALL 0x1000:54e5
// 1000:5790      58                       POP AX
// 1000:5791      83 c1 08                 ADD CX,0x8
// 1000:5794      83 f9 73                 CMP CX,0x73
// 1000:5797      75 06                    JNZ 0x1000:579f
// 1000:5799      83 c2 0b                 ADD DX,0xb
// 1000:579c      b9 4b 00                 MOV CX,0x4b
// 1000:579f  LAB_1000_579f:
// 1000:579f      fe c8                    DEC AL
// 1000:57a1      75 e2                    JNZ 0x1000:5785
// 1000:57a3  LAB_1000_57a3:
// 1000:57a3      58                       POP AX
// 1000:57a4      3c 0b                    CMP AL,0xb
// 1000:57a6      72 06                    JC 0x1000:57ae
// 1000:57a8      be 9d 12                 MOV SI,0x129d
// 1000:57ab      e8 37 fd                 CALL 0x1000:54e5
// 1000:57ae  LAB_1000_57ae:
// 1000:57ae      c3                       RET
fun_5778 :: proc() {
}

// @proc 1000:57af
// listing: FUN_1000_57af
// notes: draw_bar_meter
// status: unread
// 1000:57af  FUN_1000_57af:
// 1000:57af      50                       PUSH AX
// 1000:57b0      52                       PUSH DX
// 1000:57b1      b9 02 00                 MOV CX,0x2
// 1000:57b4      e8 2e fd                 CALL 0x1000:54e5
// 1000:57b7      5a                       POP DX
// 1000:57b8      58                       POP AX
// 1000:57b9      52                       PUSH DX
// 1000:57ba      83 c2 01                 ADD DX,0x1
// 1000:57bd      b9 0a 00                 MOV CX,0xa
// 1000:57c0  LAB_1000_57c0:
// 1000:57c0      22 c0                    AND AL,AL
// 1000:57c2      74 2c                    JZ 0x1000:57f0
// 1000:57c4      3c 04                    CMP AL,0x4
// 1000:57c6      72 07                    JC 0x1000:57cf
// 1000:57c8      2c 04                    SUB AL,0x4
// 1000:57ca      be 97 1d                 MOV SI,0x1d97
// 1000:57cd      eb 13                    JMP 0x1000:57e2
// 1000:57cf  LAB_1000_57cf:
// 1000:57cf      be 87 1d                 MOV SI,0x1d87
// 1000:57d2      3c 03                    CMP AL,0x3
// 1000:57d4      74 0a                    JZ 0x1000:57e0
// 1000:57d6      be 77 1d                 MOV SI,0x1d77
// 1000:57d9      3c 02                    CMP AL,0x2
// 1000:57db      74 03                    JZ 0x1000:57e0
// 1000:57dd      be 67 1d                 MOV SI,0x1d67
// 1000:57e0  LAB_1000_57e0:
// 1000:57e0      32 c0                    XOR AL,AL
// 1000:57e2  LAB_1000_57e2:
// 1000:57e2      50                       PUSH AX
// 1000:57e3      52                       PUSH DX
// 1000:57e4      51                       PUSH CX
// 1000:57e5      e8 fd fc                 CALL 0x1000:54e5
// 1000:57e8      59                       POP CX
// 1000:57e9      5a                       POP DX
// 1000:57ea      58                       POP AX
// 1000:57eb      83 c1 04                 ADD CX,0x4
// 1000:57ee      eb d0                    JMP 0x1000:57c0
// 1000:57f0  LAB_1000_57f0:
// 1000:57f0      5a                       POP DX
// 1000:57f1      b9 0a 00                 MOV CX,0xa
// 1000:57f4      be a7 1d                 MOV SI,0x1da7
// 1000:57f7      e8 eb fc                 CALL 0x1000:54e5
// 1000:57fa      c3                       RET
fun_57af :: proc() {
}

// @proc 1000:57fb
// listing: print_inline
// status: unread
// 1000:57fb  print_inline:
// 1000:57fb      c6 06 64 a2 01           MOV byte ptr [0xa264],0x1
// 1000:5800      5b                       POP BX
// 1000:5801      06                       PUSH ES
// 1000:5802      8c c8                    MOV AX,CS
// 1000:5804      8e c0                    MOV ES,AX
// 1000:5806      e8 0c 00                 CALL 0x1000:5815
// 1000:5809      07                       POP ES
// 1000:580a      53                       PUSH BX
// 1000:580b      c3                       RET
fun_57fb :: proc() {
}

// @proc 1000:580c
// listing: FUN_1000_580c
// status: unread
// 1000:580c  FUN_1000_580c:
// 1000:580c      c6 06 64 a2 02           MOV byte ptr [0xa264],0x2
// 1000:5811      8c d8                    MOV AX,DS
// 1000:5813      8e c0                    MOV ES,AX
fun_580c :: proc() {
}

// @proc 1000:5815
// listing: exec_script
// status: unread
// 1000:5815  exec_script:
// 1000:5815      26 8a 07                 MOV AL,byte ptr ES:[BX]
// 1000:5818      e8 51 01                 CALL 0x1000:596c
// 1000:581b      43                       INC BX
// 1000:581c      3c ff                    CMP AL,0xff
// 1000:581e      74 07                    JZ 0x1000:5827
// 1000:5820      3c 00                    CMP AL,0x0
// 1000:5822      75 08                    JNZ 0x1000:582c
// 1000:5824      e8 89 fc                 CALL 0x1000:54b0
// 1000:5827  LAB_1000_5827:
// 1000:5827      8c d8                    MOV AX,DS
// 1000:5829      8e c0                    MOV ES,AX
// 1000:582b      c3                       RET
// 1000:582c  LAB_1000_582c:
// 1000:582c      3c 10                    CMP AL,0x10
// 1000:582e      76 09                    JBE 0x1000:5839
// 1000:5830      8a 26 9b a2              MOV AH,byte ptr [0xa29b]
// 1000:5834      e8 44 fd                 CALL 0x1000:557b
// 1000:5837      eb dc                    JMP 0x1000:5815
// 1000:5839  LAB_1000_5839:
// 1000:5839      3c 03                    CMP AL,0x3
// 1000:583b      77 05                    JA 0x1000:5842
// 1000:583d      a2 9b a2                 MOV [0xa29b],AL
// 1000:5840      eb d3                    JMP 0x1000:5815
// 1000:5842  LAB_1000_5842:
// 1000:5842      3c 04                    CMP AL,0x4
// 1000:5844      75 03                    JNZ 0x1000:5849
// 1000:5846      e9 91 00                 JMP 0x1000:58da
// 1000:5849  LAB_1000_5849:
// 1000:5849      3c 05                    CMP AL,0x5
// 1000:584b      75 12                    JNZ 0x1000:585f
// 1000:584d      26 8b 0f                 MOV CX,word ptr ES:[BX]
// 1000:5850      83 c1 04                 ADD CX,0x4
// 1000:5853      26 8b 57 02              MOV DX,word ptr ES:[BX + 0x2]
// 1000:5857      83 c3 04                 ADD BX,0x4
// 1000:585a      e8 0c fe                 CALL 0x1000:5669
// 1000:585d      eb b6                    JMP 0x1000:5815
// 1000:585f  LAB_1000_585f:
// 1000:585f      3c 07                    CMP AL,0x7
// 1000:5861      75 05                    JNZ 0x1000:5868
// 1000:5863      e8 99 00                 CALL 0x1000:58ff
// 1000:5866      eb ad                    JMP 0x1000:5815
// 1000:5868  LAB_1000_5868:
// 1000:5868      3c 0d                    CMP AL,0xd
// 1000:586a      75 19                    JNZ 0x1000:5885
// 1000:586c      a1 93 a2                 MOV AX,[0xa293]
// 1000:586f      2d 05 3f                 SUB AX,0x3f05
// 1000:5872      b9 f4 02                 MOV CX,0x2f4
// 1000:5875      33 d2                    XOR DX,DX
// 1000:5877      f7 f1                    DIV CX
// 1000:5879      33 d2                    XOR DX,DX
// 1000:587b      f7 e1                    MUL CX
// 1000:587d      05 05 3f                 ADD AX,0x3f05
// 1000:5880      a3 93 a2                 MOV [0xa293],AX
// 1000:5883      eb 90                    JMP 0x1000:5815
// 1000:5885  LAB_1000_5885:
// 1000:5885      3c 0a                    CMP AL,0xa
// 1000:5887      75 31                    JNZ 0x1000:58ba
// 1000:5889      a1 93 a2                 MOV AX,[0xa293]
// 1000:588c      05 f4 02                 ADD AX,0x2f4
// 1000:588f      3d 05 7e                 CMP AX,0x7e05
// 1000:5892      73 06                    JNC 0x1000:589a
// 1000:5894      a3 93 a2                 MOV [0xa293],AX
// 1000:5897      e9 7b ff                 JMP 0x1000:5815
// 1000:589a  LAB_1000_589a:
// 1000:589a      06                       PUSH ES
// 1000:589b      56                       PUSH SI
// 1000:589c      57                       PUSH DI
// 1000:589d      8c d8                    MOV AX,DS
// 1000:589f      8e c0                    MOV ES,AX
// 1000:58a1      be f5 41                 MOV SI,0x41f5
// 1000:58a4      bf 01 3f                 MOV DI,0x3f01
// 1000:58a7      b9 02 1f                 MOV CX,0x1f02
// 1000:58aa      fc                       CLD
// 1000:58ab      f3 a5                    MOVSW.REP ES:DI,SI
// 1000:58ad      33 c0                    XOR AX,AX
// 1000:58af      b9 7a 01                 MOV CX,0x17a
// 1000:58b2      f3 ab                    STOSW.REP ES:DI
// 1000:58b4      5f                       POP DI
// 1000:58b5      5e                       POP SI
// 1000:58b6      07                       POP ES
// 1000:58b7      e9 5b ff                 JMP 0x1000:5815
// 1000:58ba  LAB_1000_58ba:
// 1000:58ba      3c 0b                    CMP AL,0xb
// 1000:58bc      75 0c                    JNZ 0x1000:58ca
// 1000:58be      e8 8f fb                 CALL 0x1000:5450
// 1000:58c1      c7 06 93 a2 05 3f        MOV word ptr [0xa293],0x3f05
// 1000:58c7      e9 4b ff                 JMP 0x1000:5815
// 1000:58ca  LAB_1000_58ca:
// 1000:58ca      3c 0c                    CMP AL,0xc
// 1000:58cc      75 09                    JNZ 0x1000:58d7
// 1000:58ce      c7 06 93 a2 05 3f        MOV word ptr [0xa293],0x3f05
// 1000:58d4      e9 3e ff                 JMP 0x1000:5815
// 1000:58d7  LAB_1000_58d7:
// 1000:58d7      e9 3b ff                 JMP 0x1000:5815
// 1000:58da  LAB_1000_58da:
// 1000:58da      53                       PUSH BX
// 1000:58db      26 8b 37                 MOV SI,word ptr ES:[BX]
// 1000:58de      26 8b 4f 02              MOV CX,word ptr ES:[BX + 0x2]
// 1000:58e2      26 8b 57 04              MOV DX,word ptr ES:[BX + 0x4]
// 1000:58e6      bb 05 3f                 MOV BX,0x3f05
// 1000:58e9      c7 06 05 00 50 00        MOV word ptr [0x5],0x50
// 1000:58ef      e8 fb fb                 CALL 0x1000:54ed
// 1000:58f2      c7 06 05 00 35 00        MOV word ptr [0x5],0x35
// 1000:58f8      5b                       POP BX
// 1000:58f9      83 c3 06                 ADD BX,0x6
// 1000:58fc      e9 16 ff                 JMP 0x1000:5815
fun_5815 :: proc() {
}

// @proc 1000:596c
// listing: decode_script_byte
// status: unread
// 1000:596c  decode_script_byte:
// 1000:596c      80 3e 64 a2 02           CMP byte ptr [0xa264],0x2
// 1000:5971      74 2b                    JZ 0x1000:599e
// 1000:5973      80 3e 64 a2 01           CMP byte ptr [0xa264],0x1
// 1000:5978      75 1c                    JNZ 0x1000:5996
// 1000:597a      c6 06 64 a2 00           MOV byte ptr [0xa264],0x0
// 1000:597f      50                       PUSH AX
// 1000:5980      8b c3                    MOV AX,BX
// 1000:5982      2e 03 07                 ADD AX,word ptr CS:[BX]
// 1000:5985      83 c3 02                 ADD BX,0x2
// 1000:5988      a2 65 a2                 MOV [0xa265],AL
// 1000:598b      05 57 13                 ADD AX,0x1357
// 1000:598e      09 06 01 a2              OR word ptr [0xa201],AX
// 1000:5992      58                       POP AX
// 1000:5993      2e 8a 07                 MOV AL,byte ptr CS:[BX]
// 1000:5996  LAB_1000_5996:
// 1000:5996      2a 06 65 a2              SUB AL,byte ptr [0xa265]
// 1000:599a      28 06 65 a2              SUB byte ptr [0xa265],AL
// 1000:599e  LAB_1000_599e:
// 1000:599e      c3                       RET
fun_596c :: proc() {
}

// @proc 1000:a800
// listing: FUN_1000_a800
// status: unread
// video: copies bytes into CGA memory at segment B800 and XORs pixels there. The store stays stubbed.
// 1000:a800  FUN_1000_a800:
// 1000:a800      be c1 39                 MOV SI,0x39c1
// 1000:a803      ba 21 00                 MOV DX,0x21
// 1000:a806      b8 00 b8                 MOV AX,0xb800
// 1000:a809      8e c0                    MOV ES,AX
// 1000:a80b      bf d0 03                 MOV DI,0x3d0
// 1000:a80e  LAB_1000_a80e:
// 1000:a80e      b9 50 00                 MOV CX,0x50
// 1000:a811      2b ca                    SUB CX,DX
// 1000:a813      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:a815      03 fa                    ADD DI,DX
// 1000:a817      83 ef 50                 SUB DI,0x50
// 1000:a81a      81 c7 00 20              ADD DI,0x2000
// 1000:a81e      b9 50 00                 MOV CX,0x50
// 1000:a821      2b ca                    SUB CX,DX
// 1000:a823      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:a825      03 fa                    ADD DI,DX
// 1000:a827      81 ef 00 20              SUB DI,0x2000
// 1000:a82b      81 fe 1d 4c              CMP SI,0x4c1d
// 1000:a82f      72 dd                    JC 0x1000:a80e
// 1000:a831      c6 06 d0 89 67           MOV byte ptr [0x89d0],0x67
// 1000:a836      b9 bc 02                 MOV CX,0x2bc
// 1000:a839  LAB_1000_a839:
// 1000:a839      e8 3e 9b                 CALL 0x1000:437a
// 1000:a83c      8b f8                    MOV DI,AX
// 1000:a83e      81 e7 ff 3f              AND DI,0x3fff
// 1000:a842      51                       PUSH CX
// 1000:a843      b1 05                    MOV CL,0x5
// 1000:a845      d2 ec                    SHR AH,CL
// 1000:a847      80 e4 06                 AND AH,0x6
// 1000:a84a      8a cc                    MOV CL,AH
// 1000:a84c      b0 03                    MOV AL,0x3
// 1000:a84e      d2 e0                    SHL AL,CL
// 1000:a850      26 8a 25                 MOV AH,byte ptr ES:[DI]
// 1000:a853      f6 c4 aa                 TEST AH,0xaa
// 1000:a856      75 05                    JNZ 0x1000:a85d
// 1000:a858      24 11                    AND AL,0x11
// 1000:a85a      26 30 05                 XOR byte ptr ES:[DI],AL
// 1000:a85d  LAB_1000_a85d:
// 1000:a85d      e8 14 00                 CALL 0x1000:a874
// 1000:a860      59                       POP CX
// 1000:a861      51                       PUSH CX
// 1000:a862      81 f9 26 02              CMP CX,0x226
// 1000:a866      77 03                    JA 0x1000:a86b
// 1000:a868      e8 da 62                 CALL 0x1000:0b45
// 1000:a86b  LAB_1000_a86b:
// 1000:a86b      b9 50 00                 MOV CX,0x50
// 1000:a86e  LAB_1000_a86e:
// 1000:a86e      e2 fe                    LOOP 0x1000:a86e
// 1000:a870      59                       POP CX
// 1000:a871      e2 c6                    LOOP 0x1000:a839
// 1000:a873      c3                       RET
fun_a800 :: proc() {
}

