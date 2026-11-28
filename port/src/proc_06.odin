package trek

// Procedures 1000:58ff, then 1000:59a0 through 1000:6455.
// 1000:5815 and 1000:596c are in draw.odin.
// The assembly is the listing. The body is empty until the procedure is translated.
// A notes line is a name already supported by the annotation notes.

// 1000:5815 is in draw.odin.

// @proc 1000:58ff
// listing: FUN_1000_58ff
// status: unread
// 1000:58ff  FUN_1000_58ff:
// 1000:58ff      53                       PUSH BX
// 1000:5900      b8 04 00                 MOV AX,0x4
// 1000:5903      bb 5a a2                 MOV BX,0xa25a
// 1000:5906      e8 8e c1                 CALL 0x1000:1a97
// 1000:5909      5b                       POP BX
// 1000:590a      c3                       RET
fun_58ff :: proc() {
}

// 1000:596c is in draw.odin.

// @proc 1000:59a0
// listing: FUN_1000_59a0
// status: unread
// 1000:59a0  FUN_1000_59a0:
// 1000:59a0      e8 58 fe                 CALL 0x1000:57fb
//                 ; inline script -> 1000:59c7  <c1><clear>  WAITING FOR FIRST RESPONSE.  
// 1000:59c7  LAB_1000_59c7:
// 1000:59c7      e8 31 03                 CALL 0x1000:5cfb
// 1000:59ca  LAB_1000_59ca:
// 1000:59ca      e8 7f b2                 CALL 0x1000:0c4c
// 1000:59cd      c6 06 6f a2 00           MOV byte ptr [0xa26f],0x0
// 1000:59d2      ba 5a 41                 MOV DX,0x415a
// 1000:59d5      f6 06 86 a4 01           TEST byte ptr [0xa486],0x1
// 1000:59da      74 07                    JZ 0x1000:59e3
// 1000:59dc      c6 06 6f a2 01           MOV byte ptr [0xa26f],0x1
// 1000:59e1      86 d6                    XCHG DH,DL
// 1000:59e3  LAB_1000_59e3:
// 1000:59e3      52                       PUSH DX
// 1000:59e4      e8 14 03                 CALL 0x1000:5cfb
// 1000:59e7      e8 5b b1                 CALL 0x1000:0b45
// 1000:59ea      5a                       POP DX
// 1000:59eb      52                       PUSH DX
// 1000:59ec      8a c6                    MOV AL,DH
// 1000:59ee      e8 c7 04                 CALL 0x1000:5eb8
// 1000:59f1      e8 98 04                 CALL 0x1000:5e8c
// 1000:59f4      5a                       POP DX
// 1000:59f5      72 ec                    JC 0x1000:59e3
// 1000:59f7      3a c2                    CMP AL,DL
// 1000:59f9      74 26                    JZ 0x1000:5a21
// 1000:59fb      3a c6                    CMP AL,DH
// 1000:59fd      74 07                    JZ 0x1000:5a06
// 1000:59ff      52                       PUSH DX
// 1000:5a00      e8 49 b2                 CALL 0x1000:0c4c
// 1000:5a03      5a                       POP DX
// 1000:5a04      eb dd                    JMP 0x1000:59e3
// 1000:5a06  LAB_1000_5a06:
// 1000:5a06      e8 f2 fd                 CALL 0x1000:57fb
//                 ; inline script -> 1000:5a1f  <c1>STILL TRYING....  
// 1000:5a1f  LAB_1000_5a1f:
// 1000:5a1f      eb a9                    JMP 0x1000:59ca
// 1000:5a21  LAB_1000_5a21:
// 1000:5a21      b0 a0                    MOV AL,0xa0
// 1000:5a23      e8 92 04                 CALL 0x1000:5eb8
// 1000:5a26      c6 06 54 a2 36           MOV byte ptr [0xa254],0x36
// 1000:5a2b  LAB_1000_5a2b:
// 1000:5a2b      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
// 1000:5a30      74 d4                    JZ 0x1000:5a06
// 1000:5a32      e8 10 b1                 CALL 0x1000:0b45
// 1000:5a35      e8 54 04                 CALL 0x1000:5e8c
// 1000:5a38      72 f1                    JC 0x1000:5a2b
// 1000:5a3a      3c a0                    CMP AL,0xa0
// 1000:5a3c      75 ed                    JNZ 0x1000:5a2b
// 1000:5a3e      a0 c0 39                 MOV AL,[0x39c0]
// 1000:5a41      e8 74 04                 CALL 0x1000:5eb8
// 1000:5a44  LAB_1000_5a44:
// 1000:5a44      e8 fe b0                 CALL 0x1000:0b45
// 1000:5a47      e8 42 04                 CALL 0x1000:5e8c
// 1000:5a4a      72 f8                    JC 0x1000:5a44
// 1000:5a4c      3a 06 c0 39              CMP AL,byte ptr [0x39c0]
// 1000:5a50      74 03                    JZ 0x1000:5a55
// 1000:5a52      e9 ed 01                 JMP 0x1000:5c42
// 1000:5a55  LAB_1000_5a55:
// 1000:5a55      f6 06 6f a2 01           TEST byte ptr [0xa26f],0x1
// 1000:5a5a      75 03                    JNZ 0x1000:5a5f
// 1000:5a5c      e9 94 00                 JMP 0x1000:5af3
// 1000:5a5f  LAB_1000_5a5f:
// 1000:5a5f      bb 00 00                 MOV BX,0x0
// 1000:5a62      e8 af 02                 CALL 0x1000:5d14
// 1000:5a65      a2 83 a4                 MOV [0xa483],AL
// 1000:5a68      e8 a9 02                 CALL 0x1000:5d14
// 1000:5a6b      8a d0                    MOV DL,AL
// 1000:5a6d      e8 a4 02                 CALL 0x1000:5d14
// 1000:5a70      8a f0                    MOV DH,AL
// 1000:5a72      89 16 d0 89              MOV word ptr [0x89d0],DX
// 1000:5a76      89 16 84 a4              MOV word ptr [0xa484],DX
// 1000:5a7a      bf 31 a2                 MOV DI,0xa231
// 1000:5a7d      be 07 00                 MOV SI,0x7
// 1000:5a80      b9 03 00                 MOV CX,0x3
// 1000:5a83      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:5a85      47                       INC DI
// 1000:5a86      a0 10 00                 MOV AL,[0x10]
// 1000:5a89      aa                       STOSB ES:DI
// 1000:5a8a      bf 26 a2                 MOV DI,0xa226
// 1000:5a8d      e8 84 02                 CALL 0x1000:5d14
// 1000:5a90      aa                       STOSB ES:DI
// 1000:5a91      e8 80 02                 CALL 0x1000:5d14
// 1000:5a94      aa                       STOSB ES:DI
// 1000:5a95      e8 7c 02                 CALL 0x1000:5d14
// 1000:5a98      aa                       STOSB ES:DI
// 1000:5a99      47                       INC DI
// 1000:5a9a      e8 77 02                 CALL 0x1000:5d14
// 1000:5a9d      aa                       STOSB ES:DI
// 1000:5a9e      53                       PUSH BX
// 1000:5a9f      e8 72 02                 CALL 0x1000:5d14
// 1000:5aa2      5b                       POP BX
// 1000:5aa3      3a c3                    CMP AL,BL
// 1000:5aa5      75 46                    JNZ 0x1000:5aed
// 1000:5aa7      53                       PUSH BX
// 1000:5aa8      e8 69 02                 CALL 0x1000:5d14
// 1000:5aab      5b                       POP BX
// 1000:5aac      3a c7                    CMP AL,BH
// 1000:5aae      75 3d                    JNZ 0x1000:5aed
// 1000:5ab0      bb 00 00                 MOV BX,0x0
// 1000:5ab3      a0 12 00                 MOV AL,[0x12]
// 1000:5ab6      e8 53 02                 CALL 0x1000:5d0c
// 1000:5ab9      8b 16 d0 89              MOV DX,word ptr [0x89d0]
// 1000:5abd      8a c2                    MOV AL,DL
// 1000:5abf      e8 4a 02                 CALL 0x1000:5d0c
// 1000:5ac2      8a c6                    MOV AL,DH
// 1000:5ac4      e8 45 02                 CALL 0x1000:5d0c
// 1000:5ac7      be 07 00                 MOV SI,0x7
// 1000:5aca      ac                       LODSB SI
// 1000:5acb      e8 3e 02                 CALL 0x1000:5d0c
// 1000:5ace      ac                       LODSB SI
// 1000:5acf      e8 3a 02                 CALL 0x1000:5d0c
// 1000:5ad2      ac                       LODSB SI
// 1000:5ad3      e8 36 02                 CALL 0x1000:5d0c
// 1000:5ad6      a0 10 00                 MOV AL,[0x10]
// 1000:5ad9      e8 30 02                 CALL 0x1000:5d0c
// 1000:5adc      8a c3                    MOV AL,BL
// 1000:5ade      e8 d7 03                 CALL 0x1000:5eb8
// 1000:5ae1      8a c7                    MOV AL,BH
// 1000:5ae3      e8 d2 03                 CALL 0x1000:5eb8
// 1000:5ae6      e8 2b 02                 CALL 0x1000:5d14
// 1000:5ae9      3c 40                    CMP AL,0x40
// 1000:5aeb      74 03                    JZ 0x1000:5af0
// 1000:5aed  LAB_1000_5aed:
// 1000:5aed      e9 b0 fe                 JMP 0x1000:59a0
// 1000:5af0  LAB_1000_5af0:
// 1000:5af0      e9 8e 00                 JMP 0x1000:5b81
// 1000:5af3  LAB_1000_5af3:
// 1000:5af3      bb 00 00                 MOV BX,0x0
// 1000:5af6      a0 12 00                 MOV AL,[0x12]
// 1000:5af9      e8 10 02                 CALL 0x1000:5d0c
// 1000:5afc      8b 16 d0 89              MOV DX,word ptr [0x89d0]
// 1000:5b00      8a c2                    MOV AL,DL
// 1000:5b02      e8 07 02                 CALL 0x1000:5d0c
// 1000:5b05      8a c6                    MOV AL,DH
// 1000:5b07      e8 02 02                 CALL 0x1000:5d0c
// 1000:5b0a      be 07 00                 MOV SI,0x7
// 1000:5b0d      ac                       LODSB SI
// 1000:5b0e      e8 fb 01                 CALL 0x1000:5d0c
// 1000:5b11      ac                       LODSB SI
// 1000:5b12      e8 f7 01                 CALL 0x1000:5d0c
// 1000:5b15      ac                       LODSB SI
// 1000:5b16      e8 f3 01                 CALL 0x1000:5d0c
// 1000:5b19      a0 10 00                 MOV AL,[0x10]
// 1000:5b1c      e8 ed 01                 CALL 0x1000:5d0c
// 1000:5b1f      8a c3                    MOV AL,BL
// 1000:5b21      e8 94 03                 CALL 0x1000:5eb8
// 1000:5b24      8a c7                    MOV AL,BH
// 1000:5b26      e8 8f 03                 CALL 0x1000:5eb8
// 1000:5b29      bb 00 00                 MOV BX,0x0
// 1000:5b2c      e8 e5 01                 CALL 0x1000:5d14
// 1000:5b2f      a2 83 a4                 MOV [0xa483],AL
// 1000:5b32      e8 df 01                 CALL 0x1000:5d14
// 1000:5b35      8a d0                    MOV DL,AL
// 1000:5b37      e8 da 01                 CALL 0x1000:5d14
// 1000:5b3a      8a f0                    MOV DH,AL
// 1000:5b3c      89 16 84 a4              MOV word ptr [0xa484],DX
// 1000:5b40      bf 26 a2                 MOV DI,0xa226
// 1000:5b43      be 07 00                 MOV SI,0x7
// 1000:5b46      b9 03 00                 MOV CX,0x3
// 1000:5b49      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:5b4b      47                       INC DI
// 1000:5b4c      a0 10 00                 MOV AL,[0x10]
// 1000:5b4f      aa                       STOSB ES:DI
// 1000:5b50      bf 31 a2                 MOV DI,0xa231
// 1000:5b53      e8 be 01                 CALL 0x1000:5d14
// 1000:5b56      aa                       STOSB ES:DI
// 1000:5b57      e8 ba 01                 CALL 0x1000:5d14
// 1000:5b5a      aa                       STOSB ES:DI
// 1000:5b5b      e8 b6 01                 CALL 0x1000:5d14
// 1000:5b5e      aa                       STOSB ES:DI
// 1000:5b5f      47                       INC DI
// 1000:5b60      e8 b1 01                 CALL 0x1000:5d14
// 1000:5b63      aa                       STOSB ES:DI
// 1000:5b64      53                       PUSH BX
// 1000:5b65      e8 ac 01                 CALL 0x1000:5d14
// 1000:5b68      5b                       POP BX
// 1000:5b69      3a c3                    CMP AL,BL
// 1000:5b6b      75 11                    JNZ 0x1000:5b7e
// 1000:5b6d      53                       PUSH BX
// 1000:5b6e      e8 a3 01                 CALL 0x1000:5d14
// 1000:5b71      5b                       POP BX
// 1000:5b72      3a c7                    CMP AL,BH
// 1000:5b74      75 08                    JNZ 0x1000:5b7e
// 1000:5b76      b0 40                    MOV AL,0x40
// 1000:5b78      e8 3d 03                 CALL 0x1000:5eb8
// 1000:5b7b      eb 04                    JMP 0x1000:5b81
// 1000:5b7e  LAB_1000_5b7e:
// 1000:5b7e      e9 1f fe                 JMP 0x1000:59a0
// 1000:5b81  LAB_1000_5b81:
// 1000:5b81      a1 d0 89                 MOV AX,[0x89d0]
// 1000:5b84      3b 06 84 a4              CMP AX,word ptr [0xa484]
// 1000:5b88      75 f4                    JNZ 0x1000:5b7e
// 1000:5b8a      be 26 a2                 MOV SI,0xa226
// 1000:5b8d      bf 31 a2                 MOV DI,0xa231
// 1000:5b90      b9 03 00                 MOV CX,0x3
// 1000:5b93      f3 a6                    CMPSB.REPE ES:DI,SI
// 1000:5b95      75 03                    JNZ 0x1000:5b9a
// 1000:5b97      eb 1f                    JMP 0x1000:5bb8
// 1000:5b9a  LAB_1000_5b9a:
// 1000:5b9a      a0 83 a4                 MOV AL,[0xa483]
// 1000:5b9d      20 06 12 00              AND byte ptr [0x12],AL
// 1000:5ba1      b0 02                    MOV AL,0x2
// 1000:5ba3      b4 02                    MOV AH,0x2
// 1000:5ba5      f6 06 12 00 08           TEST byte ptr [0x12],0x8
// 1000:5baa      75 0b                    JNZ 0x1000:5bb7
// 1000:5bac      fe cc                    DEC AH
// 1000:5bae      f6 06 12 00 04           TEST byte ptr [0x12],0x4
// 1000:5bb3      75 02                    JNZ 0x1000:5bb7
// 1000:5bb5      fe cc                    DEC AH
// 1000:5bb7  LAB_1000_5bb7:
// 1000:5bb7      c3                       RET
// 1000:5bb8  LAB_1000_5bb8:
// 1000:5bb8      e8 40 fc                 CALL 0x1000:57fb
//                 ; inline script -> 1000:5c3f  <c2>  BOTH ENDS HAVE SAME INITIALS.  CAN NOT ESTABLISH LINK UNTIL ONE  PLAYER CHANGES HIS INITIALS.   <c3>HIT Esc KEY TO RETURN TO MENU
// 1000:5c3f  LAB_1000_5c3f:
// 1000:5c3f      e9 b4 00                 JMP 0x1000:5cf6
// 1000:5c42  LAB_1000_5c42:
// 1000:5c42      77 30                    JA 0x1000:5c74
// 1000:5c44      e8 b4 fb                 CALL 0x1000:57fb
//                 ; inline script -> 1000:5c71  <c2>  OPPONENT HAS A DOWN-LEVEL PROGRAM!  
// 1000:5c71  LAB_1000_5c71:
// 1000:5c71      eb 2a                    JMP 0x1000:5c9d
// 1000:5c74  LAB_1000_5c74:
// 1000:5c74      e8 84 fb                 CALL 0x1000:57fb
//                 ; inline script -> 1000:5c9d  <c2>  YOU HAVE A DOWN-LEVEL PROGRAM!  
// 1000:5c9d  LAB_1000_5c9d:
// 1000:5c9d      e8 5b fb                 CALL 0x1000:57fb
//                 ; inline script -> 1000:5cf6  <c2>CAN NOT PROCEED UNTIL BOTH ENDS  HAVE SAME LEVEL PROGRAM.  HIT Esc TO EXIT TO MENU
// 1000:5cf6  LAB_1000_5cf6:
// 1000:5cf6      e8 4c ae                 CALL 0x1000:0b45
// 1000:5cf9      eb fb                    JMP 0x1000:5cf6
fun_59a0 :: proc() {
}

// @proc 1000:5cfb
// listing: FUN_1000_5cfb
// status: unread
// 1000:5cfb  FUN_1000_5cfb:
// 1000:5cfb      c6 06 54 a2 0a           MOV byte ptr [0xa254],0xa
// 1000:5d00  LAB_1000_5d00:
// 1000:5d00      fe 06 86 a4              INC byte ptr [0xa486]
// 1000:5d04      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
// 1000:5d09      75 f5                    JNZ 0x1000:5d00
// 1000:5d0b      c3                       RET
fun_5cfb :: proc() {
}

// @proc 1000:5d0c
// listing: FUN_1000_5d0c
// status: unread
// 1000:5d0c  FUN_1000_5d0c:
// 1000:5d0c      50                       PUSH AX
// 1000:5d0d      e8 d9 05                 CALL 0x1000:62e9
// 1000:5d10      58                       POP AX
// 1000:5d11      e9 a4 01                 JMP 0x1000:5eb8
fun_5d0c :: proc() {
}

// @proc 1000:5d14
// listing: FUN_1000_5d14
// status: unread
// 1000:5d14  FUN_1000_5d14:
// 1000:5d14      e8 2e ae                 CALL 0x1000:0b45
// 1000:5d17      e8 72 01                 CALL 0x1000:5e8c
// 1000:5d1a      72 f8                    JC 0x1000:5d14
// 1000:5d1c      50                       PUSH AX
// 1000:5d1d      e8 c9 05                 CALL 0x1000:62e9
// 1000:5d20      58                       POP AX
// 1000:5d21      c3                       RET
fun_5d14 :: proc() {
}

// @proc 1000:5d22
// listing: FUN_1000_5d22
// status: unread
// 1000:5d22  FUN_1000_5d22:
// 1000:5d22      c7 06 55 a2 1c 02        MOV word ptr [0xa255],0x21c
// 1000:5d28  LAB_1000_5d28:
// 1000:5d28      e8 64 ba                 CALL 0x1000:178f
// 1000:5d2b      f6 06 0c a2 01           TEST byte ptr [0xa20c],0x1
// 1000:5d30      74 03                    JZ 0x1000:5d35
// 1000:5d32      eb 7d                    JMP 0x1000:5db1
// 1000:5d35  LAB_1000_5d35:
// 1000:5d35      83 3e 55 a2 00           CMP word ptr [0xa255],0x0
// 1000:5d3a      75 ec                    JNZ 0x1000:5d28
// 1000:5d3c      e8 bc fa                 CALL 0x1000:57fb
//                 ; inline script -> 1000:5dac  <c2><clear>  LOSS OF CARRIER,  OR SOMEBODY PULLED THE PLUG!   SORRY. CAN NOT CONTINUE   <c3>HIT Esc TO START NEW GAME.
// 1000:5dac  LAB_1000_5dac:
// 1000:5dac      e8 96 ad                 CALL 0x1000:0b45
// 1000:5daf      eb fb                    JMP 0x1000:5dac
// 1000:5db1  LAB_1000_5db1:
// 1000:5db1      be 0d a2                 MOV SI,0xa20d
// 1000:5db4      bb 7c a4                 MOV BX,0xa47c
// 1000:5db7      f6 06 6f a2 01           TEST byte ptr [0xa26f],0x1
// 1000:5dbc      74 02                    JZ 0x1000:5dc0
// 1000:5dbe      87 de                    XCHG SI,BX
// 1000:5dc0  LAB_1000_5dc0:
// 1000:5dc0      bf 12 a2                 MOV DI,0xa212
// 1000:5dc3      b9 04 00                 MOV CX,0x4
// 1000:5dc6      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:5dc8      b0 01                    MOV AL,0x1
// 1000:5dca      aa                       STOSB ES:DI
// 1000:5dcb      87 de                    XCHG SI,BX
// 1000:5dcd      b9 04 00                 MOV CX,0x4
// 1000:5dd0      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:5dd2      b0 01                    MOV AL,0x1
// 1000:5dd4      aa                       STOSB ES:DI
// 1000:5dd5      c3                       RET
fun_5d22 :: proc() {
}

// @proc 1000:5dd6
// listing: FUN_1000_5dd6
// status: unread
// 1000:5dd6  FUN_1000_5dd6:
// 1000:5dd6      a1 a7 00                 MOV AX,[0xa7]
// 1000:5dd9      23 c0                    AND AX,AX
// 1000:5ddb      75 01                    JNZ 0x1000:5dde
// 1000:5ddd      c3                       RET
// 1000:5dde  LAB_1000_5dde:
// 1000:5dde      fa                       CLI
// 1000:5ddf      06                       PUSH ES
// 1000:5de0      33 d2                    XOR DX,DX
// 1000:5de2      8e c2                    MOV ES,DX
// 1000:5de4      f6 06 0c 00 01           TEST byte ptr [0xc],0x1
// 1000:5de9      75 0e                    JNZ 0x1000:5df9
// 1000:5deb      26 c7 06 30 00 ea 5e     MOV word ptr ES:[0x30],0x5eea
// 1000:5df2      26 8c 0e 32 00           MOV word ptr ES:[0x32],CS
// 1000:5df7      eb 0c                    JMP 0x1000:5e05
// 1000:5df9  LAB_1000_5df9:
// 1000:5df9      26 c7 06 2c 00 ea 5e     MOV word ptr ES:[0x2c],0x5eea
// 1000:5e00      26 8c 0e 2e 00           MOV word ptr ES:[0x2e],CS
// 1000:5e05  LAB_1000_5e05:
// 1000:5e05      07                       POP ES
// 1000:5e06      e8 05 00                 CALL 0x1000:5e0e
// 1000:5e09      e8 6f 01                 CALL 0x1000:5f7b
// 1000:5e0c      fb                       STI
// 1000:5e0d      c3                       RET
fun_5dd6 :: proc() {
}

// @proc 1000:5e0e
// listing: FUN_1000_5e0e
// status: unread
// 1000:5e0e  FUN_1000_5e0e:
// 1000:5e0e      8b 16 a7 00              MOV DX,word ptr [0xa7]
// 1000:5e12      83 c2 03                 ADD DX,0x3
// 1000:5e15      b0 80                    MOV AL,0x80
// 1000:5e17      ee                       OUT DX,AL
// 1000:5e18      a0 0b 00                 MOV AL,[0xb]
// 1000:5e1b      25 07 00                 AND AX,0x7
// 1000:5e1e      d1 e0                    SHL AX,0x1
// 1000:5e20      d1 e0                    SHL AX,0x1
// 1000:5e22      bf 76 39                 MOV DI,0x3976
// 1000:5e25      03 f8                    ADD DI,AX
// 1000:5e27      8b 16 a7 00              MOV DX,word ptr [0xa7]
// 1000:5e2b      42                       INC DX
// 1000:5e2c      8a 45 01                 MOV AL,byte ptr [DI + 0x1]
// 1000:5e2f      eb 00                    JMP 0x1000:5e31
// 1000:5e31  LAB_1000_5e31:
// 1000:5e31      ee                       OUT DX,AL
// 1000:5e32      4a                       DEC DX
// 1000:5e33      8a 05                    MOV AL,byte ptr [DI]
// 1000:5e35      eb 00                    JMP 0x1000:5e37
// 1000:5e37  LAB_1000_5e37:
// 1000:5e37      ee                       OUT DX,AL
// 1000:5e38      83 c2 03                 ADD DX,0x3
// 1000:5e3b      b0 03                    MOV AL,0x3
// 1000:5e3d      eb 00                    JMP 0x1000:5e3f
// 1000:5e3f  LAB_1000_5e3f:
// 1000:5e3f      ee                       OUT DX,AL
// 1000:5e40      83 ea 03                 SUB DX,0x3
// 1000:5e43      33 c9                    XOR CX,CX
// 1000:5e45  LAB_1000_5e45:
// 1000:5e45      eb 00                    JMP 0x1000:5e47
// 1000:5e47  LAB_1000_5e47:
// 1000:5e47      ec                       IN AL,DX
// 1000:5e48      e2 fb                    LOOP 0x1000:5e45
// 1000:5e4a      83 c2 06                 ADD DX,0x6
// 1000:5e4d      eb 00                    JMP 0x1000:5e4f
// 1000:5e4f  LAB_1000_5e4f:
// 1000:5e4f      ec                       IN AL,DX
// 1000:5e50      eb 00                    JMP 0x1000:5e52
// 1000:5e52  LAB_1000_5e52:
// 1000:5e52      ec                       IN AL,DX
// 1000:5e53      83 ea 02                 SUB DX,0x2
// 1000:5e56      b0 0b                    MOV AL,0xb
// 1000:5e58      eb 00                    JMP 0x1000:5e5a
// 1000:5e5a  LAB_1000_5e5a:
// 1000:5e5a      ee                       OUT DX,AL
// 1000:5e5b      83 ea 03                 SUB DX,0x3
// 1000:5e5e      b0 03                    MOV AL,0x3
// 1000:5e60      eb 00                    JMP 0x1000:5e62
// 1000:5e62  LAB_1000_5e62:
// 1000:5e62      ee                       OUT DX,AL
// 1000:5e63      42                       INC DX
// 1000:5e64      eb 00                    JMP 0x1000:5e66
// 1000:5e66  LAB_1000_5e66:
// 1000:5e66      ec                       IN AL,DX
// 1000:5e67      a0 00 a2                 MOV AL,[0xa200]
// 1000:5e6a      0c 18                    OR AL,0x18
// 1000:5e6c      f6 06 0c 00 01           TEST byte ptr [0xc],0x1
// 1000:5e71      74 04                    JZ 0x1000:5e77
// 1000:5e73      24 f7                    AND AL,0xf7
// 1000:5e75      eb 02                    JMP 0x1000:5e79
// 1000:5e77  LAB_1000_5e77:
// 1000:5e77      24 ef                    AND AL,0xef
// 1000:5e79  LAB_1000_5e79:
// 1000:5e79      a2 00 a2                 MOV [0xa200],AL
// 1000:5e7c      e6 21                    OUT 0x21,AL
// 1000:5e7e      c3                       RET
fun_5e0e :: proc() {
}

// @proc 1000:5e7f
// listing: FUN_1000_5e7f
// status: unread
// 1000:5e7f  FUN_1000_5e7f:
// 1000:5e7f      fa                       CLI
// 1000:5e80      a0 00 a2                 MOV AL,[0xa200]
// 1000:5e83      0c 18                    OR AL,0x18
// 1000:5e85      a2 00 a2                 MOV [0xa200],AL
// 1000:5e88      e6 21                    OUT 0x21,AL
// 1000:5e8a      fb                       STI
// 1000:5e8b      c3                       RET
fun_5e7f :: proc() {
}

// @proc 1000:5e8c
// listing: FUN_1000_5e8c
// status: unread
// 1000:5e8c  FUN_1000_5e8c:
// 1000:5e8c      fa                       CLI
// 1000:5e8d      e8 02 00                 CALL 0x1000:5e92
// 1000:5e90      fb                       STI
// 1000:5e91      c3                       RET
fun_5e8c :: proc() {
}

// @proc 1000:5e92
// listing: FUN_1000_5e92
// status: unread
// 1000:5e92  FUN_1000_5e92:
// 1000:5e92      fc                       CLD
// 1000:5e93      56                       PUSH SI
// 1000:5e94      b0 00                    MOV AL,0x0
// 1000:5e96      83 3e 70 39 00           CMP word ptr [0x3970],0x0
// 1000:5e9b      f9                       STC
// 1000:5e9c      74 18                    JZ 0x1000:5eb6
// 1000:5e9e      8b 36 74 39              MOV SI,word ptr [0x3974]
// 1000:5ea2      ac                       LODSB SI
// 1000:5ea3      ff 0e 70 39              DEC word ptr [0x3970]
// 1000:5ea7      81 fe 70 a4              CMP SI,0xa470
// 1000:5eab      75 03                    JNZ 0x1000:5eb0
// 1000:5ead      be 70 a3                 MOV SI,0xa370
// 1000:5eb0  LAB_1000_5eb0:
// 1000:5eb0      89 36 74 39              MOV word ptr [0x3974],SI
// 1000:5eb4      46                       INC SI
// 1000:5eb5      f8                       CLC
// 1000:5eb6  LAB_1000_5eb6:
// 1000:5eb6      5e                       POP SI
// 1000:5eb7      c3                       RET
fun_5e92 :: proc() {
}

// @proc 1000:5eb8
// listing: FUN_1000_5eb8
// status: unread
// 1000:5eb8  FUN_1000_5eb8:
// 1000:5eb8      e8 03 00                 CALL 0x1000:5ebe
// 1000:5ebb      72 fb                    JC 0x1000:5eb8
// 1000:5ebd      c3                       RET
fun_5eb8 :: proc() {
}

// @proc 1000:5ebe
// listing: FUN_1000_5ebe
// status: unread
// 1000:5ebe  FUN_1000_5ebe:
// 1000:5ebe      52                       PUSH DX
// 1000:5ebf      50                       PUSH AX
// 1000:5ec0      8b 16 a7 00              MOV DX,word ptr [0xa7]
// 1000:5ec4      83 c2 05                 ADD DX,0x5
// 1000:5ec7      ec                       IN AL,DX
// 1000:5ec8      24 20                    AND AL,0x20
// 1000:5eca      58                       POP AX
// 1000:5ecb      f9                       STC
// 1000:5ecc      74 07                    JZ 0x1000:5ed5
// 1000:5ece      83 ea 05                 SUB DX,0x5
// 1000:5ed1      eb 00                    JMP 0x1000:5ed3
// 1000:5ed3  LAB_1000_5ed3:
// 1000:5ed3      ee                       OUT DX,AL
// 1000:5ed4      f8                       CLC
// 1000:5ed5  LAB_1000_5ed5:
// 1000:5ed5      5a                       POP DX
// 1000:5ed6      c3                       RET
fun_5ebe :: proc() {
}

// @proc 1000:5ed7
// listing: FUN_1000_5ed7
// status: unread
// 1000:5ed7  FUN_1000_5ed7:
// 1000:5ed7      50                       PUSH AX
// 1000:5ed8      52                       PUSH DX
// 1000:5ed9      8b 16 a7 00              MOV DX,word ptr [0xa7]
// 1000:5edd      83 c2 06                 ADD DX,0x6
// 1000:5ee0      ec                       IN AL,DX
// 1000:5ee1      24 80                    AND AL,0x80
// 1000:5ee3      5a                       POP DX
// 1000:5ee4      58                       POP AX
// 1000:5ee5      f9                       STC
// 1000:5ee6      74 01                    JZ 0x1000:5ee9
// 1000:5ee8      f8                       CLC
// 1000:5ee9  LAB_1000_5ee9:
// 1000:5ee9      c3                       RET
// 1000:5eea serial_isr is represented as its own procedure.
fun_5ed7 :: proc() {
}

// @proc 1000:5eea
// listing: serial_isr
// status: unread
// Named entry in the listing. Ghidra did not give it a function header.
// 1000:5eea  serial_isr:
// 1000:5eea      fc                       CLD
// 1000:5eeb      50                       PUSH AX
// 1000:5eec      53                       PUSH BX
// 1000:5eed      51                       PUSH CX
// 1000:5eee      52                       PUSH DX
// 1000:5eef      1e                       PUSH DS
// 1000:5ef0      06                       PUSH ES
// 1000:5ef1      57                       PUSH DI
// 1000:5ef2      56                       PUSH SI
// 1000:5ef3      2e a1 00 00              MOV AX,CS:[0x0]
// 1000:5ef7      8e d8                    MOV DS,AX
// 1000:5ef9      8e c0                    MOV ES,AX
// 1000:5efb      8b 16 a7 00              MOV DX,word ptr [0xa7]
// 1000:5eff      83 c2 02                 ADD DX,0x2
// 1000:5f02      ec                       IN AL,DX
// 1000:5f03      3c 04                    CMP AL,0x4
// 1000:5f05      74 10                    JZ 0x1000:5f17
// 1000:5f07      a8 01                    TEST AL,0x1
// 1000:5f09      75 0c                    JNZ 0x1000:5f17
// 1000:5f0b      3c 06                    CMP AL,0x6
// 1000:5f0d      74 4a                    JZ 0x1000:5f59
// 1000:5f0f      3c 02                    CMP AL,0x2
// 1000:5f11      74 50                    JZ 0x1000:5f63
// 1000:5f13      3c 00                    CMP AL,0x0
// 1000:5f15      74 5a                    JZ 0x1000:5f71
// 1000:5f17  LAB_1000_5f17:
// 1000:5f17      8b 16 a7 00              MOV DX,word ptr [0xa7]
// 1000:5f1b      83 c2 05                 ADD DX,0x5
// 1000:5f1e      ec                       IN AL,DX
// 1000:5f1f      a8 01                    TEST AL,0x1
// 1000:5f21      74 27                    JZ 0x1000:5f4a
// 1000:5f23      8b 16 a7 00              MOV DX,word ptr [0xa7]
// 1000:5f27      eb 00                    JMP 0x1000:5f29
// 1000:5f29  LAB_1000_5f29:
// 1000:5f29      ec                       IN AL,DX
// 1000:5f2a      81 3e 70 39 00 01        CMP word ptr [0x3970],0x100
// 1000:5f30      74 18                    JZ 0x1000:5f4a
// 1000:5f32      ff 06 70 39              INC word ptr [0x3970]
// 1000:5f36      8b 36 72 39              MOV SI,word ptr [0x3972]
// 1000:5f3a      88 04                    MOV byte ptr [SI],AL
// 1000:5f3c      46                       INC SI
// 1000:5f3d      81 fe 70 a4              CMP SI,0xa470
// 1000:5f41      75 03                    JNZ 0x1000:5f46
// 1000:5f43      be 70 a3                 MOV SI,0xa370
// 1000:5f46  LAB_1000_5f46:
// 1000:5f46      89 36 72 39              MOV word ptr [0x3972],SI
// 1000:5f4a  LAB_1000_5f4a:
// 1000:5f4a      cd 01                    INT 0x1
// 1000:5f4c      5e                       POP SI
// 1000:5f4d      5f                       POP DI
// 1000:5f4e      07                       POP ES
// 1000:5f4f      1f                       POP DS
// 1000:5f50      5a                       POP DX
// 1000:5f51      59                       POP CX
// 1000:5f52      5b                       POP BX
// 1000:5f53      b0 20                    MOV AL,0x20
// 1000:5f55      e6 20                    OUT 0x20,AL
// 1000:5f57      58                       POP AX
// 1000:5f58      cf                       IRET
// 1000:5f59  LAB_1000_5f59:
// 1000:5f59      8b 16 a7 00              MOV DX,word ptr [0xa7]
// 1000:5f5d      83 c2 05                 ADD DX,0x5
// 1000:5f60      ec                       IN AL,DX
// 1000:5f61      eb b4                    JMP 0x1000:5f17
// 1000:5f63  LAB_1000_5f63:
// 1000:5f63      8b 16 a7 00              MOV DX,word ptr [0xa7]
// 1000:5f67      83 c2 02                 ADD DX,0x2
// 1000:5f6a      ec                       IN AL,DX
// 1000:5f6b      42                       INC DX
// 1000:5f6c      eb 00                    JMP 0x1000:5f6e
// 1000:5f6e  LAB_1000_5f6e:
// 1000:5f6e      ec                       IN AL,DX
// 1000:5f6f      eb a6                    JMP 0x1000:5f17
// 1000:5f71  LAB_1000_5f71:
// 1000:5f71      8b 16 a7 00              MOV DX,word ptr [0xa7]
// 1000:5f75      83 c2 06                 ADD DX,0x6
// 1000:5f78      ec                       IN AL,DX
// 1000:5f79      eb 9c                    JMP 0x1000:5f17
serial_isr :: proc() {
}

// @proc 1000:5f7b
// listing: FUN_1000_5f7b
// status: unread
// 1000:5f7b  FUN_1000_5f7b:
// 1000:5f7b      c7 06 74 39 70 a3        MOV word ptr [0x3974],0xa370
// 1000:5f81      c7 06 72 39 70 a3        MOV word ptr [0x3972],0xa370
// 1000:5f87      c7 06 70 39 00 00        MOV word ptr [0x3970],0x0
// 1000:5f8d      52                       PUSH DX
// 1000:5f8e      50                       PUSH AX
// 1000:5f8f      51                       PUSH CX
// 1000:5f90      8b 16 a7 00              MOV DX,word ptr [0xa7]
// 1000:5f94      b9 f4 01                 MOV CX,0x1f4
// 1000:5f97  LAB_1000_5f97:
// 1000:5f97      eb 00                    JMP 0x1000:5f99
// 1000:5f99  LAB_1000_5f99:
// 1000:5f99      ec                       IN AL,DX
// 1000:5f9a      e2 fb                    LOOP 0x1000:5f97
// 1000:5f9c      59                       POP CX
// 1000:5f9d      58                       POP AX
// 1000:5f9e      5a                       POP DX
// 1000:5f9f      c3                       RET
fun_5f7b :: proc() {
}

// @proc 1000:5fa0
// listing: FUN_1000_5fa0
// notes: start_two_player_link
// status: unread
// 1000:5fa0  FUN_1000_5fa0:
// 1000:5fa0      80 3e 0a 00 02           CMP byte ptr [0xa],0x2
// 1000:5fa5      74 07                    JZ 0x1000:5fae
// 1000:5fa7      c7 06 09 a2 00 00        MOV word ptr [0xa209],0x0
// 1000:5fad      c3                       RET
// 1000:5fae  LAB_1000_5fae:
// 1000:5fae      c6 06 70 a4 00           MOV byte ptr [0xa470],0x0
// 1000:5fb3      a0 0b 00                 MOV AL,[0xb]
// 1000:5fb6      25 07 00                 AND AX,0x7
// 1000:5fb9      d1 e0                    SHL AX,0x1
// 1000:5fbb      d1 e0                    SHL AX,0x1
// 1000:5fbd      bf 76 39                 MOV DI,0x3976
// 1000:5fc0      03 f8                    ADD DI,AX
// 1000:5fc2      f6 06 6f a2 01           TEST byte ptr [0xa26f],0x1
// 1000:5fc7      74 0c                    JZ 0x1000:5fd5
// 1000:5fc9      8a 45 02                 MOV AL,byte ptr [DI + 0x2]
// 1000:5fcc      a2 82 a4                 MOV [0xa482],AL
// 1000:5fcf      a2 81 a4                 MOV [0xa481],AL
// 1000:5fd2      e9 7c 01                 JMP 0x1000:6151
// 1000:5fd5  LAB_1000_5fd5:
// 1000:5fd5      8a 45 03                 MOV AL,byte ptr [DI + 0x3]
// 1000:5fd8      a2 82 a4                 MOV [0xa482],AL
// 1000:5fdb      c6 06 81 a4 1e           MOV byte ptr [0xa481],0x1e
// 1000:5fe0      eb 0f                    JMP 0x1000:5ff1
// 1000:5fe3 int01_trap is represented as its own procedure.
// 1000:5ff1  LAB_1000_5ff1:
// 1000:5ff1      c7 06 09 a2 f1 5f        MOV word ptr [0xa209],0x5ff1
// 1000:5ff7      80 3e 0c a2 80           CMP byte ptr [0xa20c],0x80
// 1000:5ffc      74 01                    JZ 0x1000:5fff
// 1000:5ffe  LAB_1000_5ffe:
// 1000:5ffe      c3                       RET
// 1000:5fff  LAB_1000_5fff:
// 1000:5fff      be 0d a2                 MOV SI,0xa20d
// 1000:6002      bf 74 a4                 MOV DI,0xa474
// 1000:6005      b9 04 00                 MOV CX,0x4
// 1000:6008      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:600a      c6 06 0c a2 00           MOV byte ptr [0xa20c],0x0
// 1000:600f      c7 06 09 a2 0f 60        MOV word ptr [0xa209],0x600f
// 1000:6015      a0 70 a4                 MOV AL,[0xa470]
// 1000:6018      e8 a3 fe                 CALL 0x1000:5ebe
// 1000:601b      72 e1                    JC 0x1000:5ffe
// 1000:601d      c7 06 71 a4 00 00        MOV word ptr [0xa471],0x0
// 1000:6023      e8 b7 02                 CALL 0x1000:62dd
// 1000:6026      c7 06 09 a2 26 60        MOV word ptr [0xa209],0x6026
// 1000:602c      a0 74 a4                 MOV AL,[0xa474]
// 1000:602f      e8 8c fe                 CALL 0x1000:5ebe
// 1000:6032      72 ca                    JC 0x1000:5ffe
// 1000:6034      e8 a6 02                 CALL 0x1000:62dd
// 1000:6037      c7 06 09 a2 37 60        MOV word ptr [0xa209],0x6037
// 1000:603d      a0 75 a4                 MOV AL,[0xa475]
// 1000:6040      e8 7b fe                 CALL 0x1000:5ebe
// 1000:6043      72 b9                    JC 0x1000:5ffe
// 1000:6045      e8 95 02                 CALL 0x1000:62dd
// 1000:6048      c7 06 09 a2 48 60        MOV word ptr [0xa209],0x6048
// 1000:604e      a0 76 a4                 MOV AL,[0xa476]
// 1000:6051      e8 6a fe                 CALL 0x1000:5ebe
// 1000:6054      72 5f                    JC 0x1000:60b5
// 1000:6056      e8 84 02                 CALL 0x1000:62dd
// 1000:6059      c7 06 09 a2 59 60        MOV word ptr [0xa209],0x6059
// 1000:605f      a0 77 a4                 MOV AL,[0xa477]
// 1000:6062      e8 59 fe                 CALL 0x1000:5ebe
// 1000:6065      72 4e                    JC 0x1000:60b5
// 1000:6067      e8 73 02                 CALL 0x1000:62dd
// 1000:606a      c7 06 09 a2 6a 60        MOV word ptr [0xa209],0x606a
// 1000:6070      a0 6f a2                 MOV AL,[0xa26f]
// 1000:6073      e8 48 fe                 CALL 0x1000:5ebe
// 1000:6076      72 3d                    JC 0x1000:60b5
// 1000:6078      e8 62 02                 CALL 0x1000:62dd
// 1000:607b      c7 06 09 a2 7b 60        MOV word ptr [0xa209],0x607b
// 1000:6081      a0 71 a4                 MOV AL,[0xa471]
// 1000:6084      e8 37 fe                 CALL 0x1000:5ebe
// 1000:6087      72 2c                    JC 0x1000:60b5
// 1000:6089      c7 06 09 a2 89 60        MOV word ptr [0xa209],0x6089
// 1000:608f      a0 72 a4                 MOV AL,[0xa472]
// 1000:6092      e8 29 fe                 CALL 0x1000:5ebe
// 1000:6095      72 1e                    JC 0x1000:60b5
// 1000:6097      a0 81 a4                 MOV AL,[0xa481]
// 1000:609a      a2 54 a2                 MOV [0xa254],AL
// 1000:609d      a0 82 a4                 MOV AL,[0xa482]
// 1000:60a0      a2 81 a4                 MOV [0xa481],AL
// 1000:60a3      c7 06 09 a2 a3 60        MOV word ptr [0xa209],0x60a3
// 1000:60a9      e8 e6 fd                 CALL 0x1000:5e92
// 1000:60ac      73 0b                    JNC 0x1000:60b9
// 1000:60ae      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
// 1000:60b3      74 01                    JZ 0x1000:60b6
// 1000:60b5  LAB_1000_60b5:
// 1000:60b5      c3                       RET
// 1000:60b6  LAB_1000_60b6:
// 1000:60b6      e9 7f 00                 JMP 0x1000:6138
// 1000:60b9  LAB_1000_60b9:
// 1000:60b9      3a 06 70 a4              CMP AL,byte ptr [0xa470]
// 1000:60bd      75 79                    JNZ 0x1000:6138
// 1000:60bf      c7 06 09 a2 bf 60        MOV word ptr [0xa209],0x60bf
// 1000:60c5      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
// 1000:60ca      74 6c                    JZ 0x1000:6138
// 1000:60cc      83 3e 70 39 07           CMP word ptr [0x3970],0x7
// 1000:60d1      72 7d                    JC 0x1000:6150
// 1000:60d3      bb 00 00                 MOV BX,0x0
// 1000:60d6      a0 70 a4                 MOV AL,[0xa470]
// 1000:60d9      e8 0d 02                 CALL 0x1000:62e9
// 1000:60dc      e8 b3 fd                 CALL 0x1000:5e92
// 1000:60df      a2 78 a4                 MOV [0xa478],AL
// 1000:60e2      e8 04 02                 CALL 0x1000:62e9
// 1000:60e5      e8 aa fd                 CALL 0x1000:5e92
// 1000:60e8      a2 79 a4                 MOV [0xa479],AL
// 1000:60eb      e8 fb 01                 CALL 0x1000:62e9
// 1000:60ee      e8 a1 fd                 CALL 0x1000:5e92
// 1000:60f1      a2 7a a4                 MOV [0xa47a],AL
// 1000:60f4      e8 f2 01                 CALL 0x1000:62e9
// 1000:60f7      e8 98 fd                 CALL 0x1000:5e92
// 1000:60fa      a2 7b a4                 MOV [0xa47b],AL
// 1000:60fd      e8 e9 01                 CALL 0x1000:62e9
// 1000:6100      e8 8f fd                 CALL 0x1000:5e92
// 1000:6103      a2 80 a4                 MOV [0xa480],AL
// 1000:6106      e8 e0 01                 CALL 0x1000:62e9
// 1000:6109      e8 86 fd                 CALL 0x1000:5e92
// 1000:610c      3a c3                    CMP AL,BL
// 1000:610e      75 28                    JNZ 0x1000:6138
// 1000:6110      e8 7f fd                 CALL 0x1000:5e92
// 1000:6113      3a c7                    CMP AL,BH
// 1000:6115      75 21                    JNZ 0x1000:6138
// 1000:6117      a0 6f a2                 MOV AL,[0xa26f]
// 1000:611a      3a 06 80 a4              CMP AL,byte ptr [0xa480]
// 1000:611e      74 18                    JZ 0x1000:6138
// 1000:6120      80 06 70 a4 01           ADD byte ptr [0xa470],0x1
// 1000:6125      be 78 a4                 MOV SI,0xa478
// 1000:6128      bf 7c a4                 MOV DI,0xa47c
// 1000:612b      b9 04 00                 MOV CX,0x4
// 1000:612e      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:6130      c6 06 0c a2 01           MOV byte ptr [0xa20c],0x1
// 1000:6135      e9 b9 fe                 JMP 0x1000:5ff1
// 1000:6138  LAB_1000_6138:
// 1000:6138      c7 06 09 a2 38 61        MOV word ptr [0xa209],0x6138
// 1000:613e      e8 8e 01                 CALL 0x1000:62cf
// 1000:6141      e8 4e fd                 CALL 0x1000:5e92
// 1000:6144      73 f2                    JNC 0x1000:6138
// 1000:6146      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
// 1000:614b      75 03                    JNZ 0x1000:6150
// 1000:614d      e9 af fe                 JMP 0x1000:5fff
// 1000:6150  LAB_1000_6150:
// 1000:6150      c3                       RET
// 1000:6151  LAB_1000_6151:
// 1000:6151      c7 06 09 a2 51 61        MOV word ptr [0xa209],0x6151
// 1000:6157      83 3e 70 39 00           CMP word ptr [0x3970],0x0
// 1000:615c      74 1a                    JZ 0x1000:6178
// 1000:615e      a0 81 a4                 MOV AL,[0xa481]
// 1000:6161      a2 54 a2                 MOV [0xa254],AL
// 1000:6164      c7 06 09 a2 64 61        MOV word ptr [0xa209],0x6164
// 1000:616a      83 3e 70 39 08           CMP word ptr [0x3970],0x8
// 1000:616f      73 08                    JNC 0x1000:6179
// 1000:6171      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
// 1000:6176      74 d9                    JZ 0x1000:6151
// 1000:6178  LAB_1000_6178:
// 1000:6178      c3                       RET
// 1000:6179  LAB_1000_6179:
// 1000:6179      bb 00 00                 MOV BX,0x0
// 1000:617c      e8 13 fd                 CALL 0x1000:5e92
// 1000:617f      c6 06 73 a4 00           MOV byte ptr [0xa473],0x0
// 1000:6184      3a 06 70 a4              CMP AL,byte ptr [0xa470]
// 1000:6188      74 12                    JZ 0x1000:619c
// 1000:618a      04 01                    ADD AL,0x1
// 1000:618c      3a 06 70 a4              CMP AL,byte ptr [0xa470]
// 1000:6190      74 03                    JZ 0x1000:6195
// 1000:6192  LAB_1000_6192:
// 1000:6192      e9 22 01                 JMP 0x1000:62b7
// 1000:6195  LAB_1000_6195:
// 1000:6195      c6 06 73 a4 01           MOV byte ptr [0xa473],0x1
// 1000:619a      2c 01                    SUB AL,0x1
// 1000:619c  LAB_1000_619c:
// 1000:619c      e8 4a 01                 CALL 0x1000:62e9
// 1000:619f      e8 f0 fc                 CALL 0x1000:5e92
// 1000:61a2      a2 78 a4                 MOV [0xa478],AL
// 1000:61a5      e8 41 01                 CALL 0x1000:62e9
// 1000:61a8      e8 e7 fc                 CALL 0x1000:5e92
// 1000:61ab      a2 79 a4                 MOV [0xa479],AL
// 1000:61ae      e8 38 01                 CALL 0x1000:62e9
// 1000:61b1      e8 de fc                 CALL 0x1000:5e92
// 1000:61b4      a2 7a a4                 MOV [0xa47a],AL
// 1000:61b7      e8 2f 01                 CALL 0x1000:62e9
// 1000:61ba      e8 d5 fc                 CALL 0x1000:5e92
// 1000:61bd      a2 7b a4                 MOV [0xa47b],AL
// 1000:61c0      e8 26 01                 CALL 0x1000:62e9
// 1000:61c3      e8 cc fc                 CALL 0x1000:5e92
// 1000:61c6      a2 80 a4                 MOV [0xa480],AL
// 1000:61c9      e8 1d 01                 CALL 0x1000:62e9
// 1000:61cc      e8 c3 fc                 CALL 0x1000:5e92
// 1000:61cf      3a c3                    CMP AL,BL
// 1000:61d1      75 bf                    JNZ 0x1000:6192
// 1000:61d3      e8 bc fc                 CALL 0x1000:5e92
// 1000:61d6      3a c7                    CMP AL,BH
// 1000:61d8      75 b8                    JNZ 0x1000:6192
// 1000:61da      a0 6f a2                 MOV AL,[0xa26f]
// 1000:61dd      3a 06 80 a4              CMP AL,byte ptr [0xa480]
// 1000:61e1      74 af                    JZ 0x1000:6192
// 1000:61e3      80 3e 73 a4 00           CMP byte ptr [0xa473],0x0
// 1000:61e8      75 1d                    JNZ 0x1000:6207
// 1000:61ea      c7 06 09 a2 ea 61        MOV word ptr [0xa209],0x61ea
// 1000:61f0      80 3e 0c a2 80           CMP byte ptr [0xa20c],0x80
// 1000:61f5      75 22                    JNZ 0x1000:6219
// 1000:61f7      be 0d a2                 MOV SI,0xa20d
// 1000:61fa      bf 74 a4                 MOV DI,0xa474
// 1000:61fd      b9 04 00                 MOV CX,0x4
// 1000:6200      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:6202      c6 06 0c a2 00           MOV byte ptr [0xa20c],0x0
// 1000:6207  LAB_1000_6207:
// 1000:6207      c7 06 09 a2 07 62        MOV word ptr [0xa209],0x6207
// 1000:620d      a0 70 a4                 MOV AL,[0xa470]
// 1000:6210      2a 06 73 a4              SUB AL,byte ptr [0xa473]
// 1000:6214      e8 a7 fc                 CALL 0x1000:5ebe
// 1000:6217      73 01                    JNC 0x1000:621a
// 1000:6219  LAB_1000_6219:
// 1000:6219      c3                       RET
// 1000:621a  LAB_1000_621a:
// 1000:621a      c7 06 71 a4 00 00        MOV word ptr [0xa471],0x0
// 1000:6220      e8 ba 00                 CALL 0x1000:62dd
// 1000:6223      c7 06 09 a2 23 62        MOV word ptr [0xa209],0x6223
// 1000:6229      a0 74 a4                 MOV AL,[0xa474]
// 1000:622c      e8 8f fc                 CALL 0x1000:5ebe
// 1000:622f      72 e8                    JC 0x1000:6219
// 1000:6231      e8 a9 00                 CALL 0x1000:62dd
// 1000:6234      c7 06 09 a2 34 62        MOV word ptr [0xa209],0x6234
// 1000:623a      a0 75 a4                 MOV AL,[0xa475]
// 1000:623d      e8 7e fc                 CALL 0x1000:5ebe
// 1000:6240      72 d7                    JC 0x1000:6219
// 1000:6242      e8 98 00                 CALL 0x1000:62dd
// 1000:6245      c7 06 09 a2 45 62        MOV word ptr [0xa209],0x6245
// 1000:624b      a0 76 a4                 MOV AL,[0xa476]
// 1000:624e      e8 6d fc                 CALL 0x1000:5ebe
// 1000:6251      72 c6                    JC 0x1000:6219
// 1000:6253      e8 87 00                 CALL 0x1000:62dd
// 1000:6256      c7 06 09 a2 56 62        MOV word ptr [0xa209],0x6256
// 1000:625c      a0 77 a4                 MOV AL,[0xa477]
// 1000:625f      e8 5c fc                 CALL 0x1000:5ebe
// 1000:6262      72 b5                    JC 0x1000:6219
// 1000:6264      e8 76 00                 CALL 0x1000:62dd
// 1000:6267      c7 06 09 a2 67 62        MOV word ptr [0xa209],0x6267
// 1000:626d      a0 6f a2                 MOV AL,[0xa26f]
// 1000:6270      e8 4b fc                 CALL 0x1000:5ebe
// 1000:6273      72 41                    JC 0x1000:62b6
// 1000:6275      e8 65 00                 CALL 0x1000:62dd
// 1000:6278      c7 06 09 a2 78 62        MOV word ptr [0xa209],0x6278
// 1000:627e      a0 71 a4                 MOV AL,[0xa471]
// 1000:6281      e8 3a fc                 CALL 0x1000:5ebe
// 1000:6284      72 30                    JC 0x1000:62b6
// 1000:6286      c7 06 09 a2 86 62        MOV word ptr [0xa209],0x6286
// 1000:628c      a0 72 a4                 MOV AL,[0xa472]
// 1000:628f      e8 2c fc                 CALL 0x1000:5ebe
// 1000:6292      72 22                    JC 0x1000:62b6
// 1000:6294      80 3e 73 a4 00           CMP byte ptr [0xa473],0x0
// 1000:6299      74 03                    JZ 0x1000:629e
// 1000:629b      e9 b3 fe                 JMP 0x1000:6151
// 1000:629e  LAB_1000_629e:
// 1000:629e      80 06 70 a4 01           ADD byte ptr [0xa470],0x1
// 1000:62a3      be 78 a4                 MOV SI,0xa478
// 1000:62a6      bf 7c a4                 MOV DI,0xa47c
// 1000:62a9      b9 04 00                 MOV CX,0x4
// 1000:62ac      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:62ae      c6 06 0c a2 01           MOV byte ptr [0xa20c],0x1
// 1000:62b3      e9 9b fe                 JMP 0x1000:6151
// 1000:62b6  LAB_1000_62b6:
// 1000:62b6      c3                       RET
// 1000:62b7  LAB_1000_62b7:
// 1000:62b7      c7 06 09 a2 b7 62        MOV word ptr [0xa209],0x62b7
// 1000:62bd      e8 0f 00                 CALL 0x1000:62cf
// 1000:62c0      e8 cf fb                 CALL 0x1000:5e92
// 1000:62c3      73 f2                    JNC 0x1000:62b7
// 1000:62c5      80 3e 54 a2 00           CMP byte ptr [0xa254],0x0
// 1000:62ca      75 ea                    JNZ 0x1000:62b6
// 1000:62cc      e9 82 fe                 JMP 0x1000:6151
fun_5fa0 :: proc() {
}

// @proc 1000:5fe3
// listing: int01_trap
// notes: int01_resume
// status: unread
// Named entry in the listing. Ghidra did not give it a function header.
// 1000:5fe3  int01_trap:
// 1000:5fe3      83 3e 09 a2 00           CMP word ptr [0xa209],0x0
// 1000:5fe8      74 06                    JZ 0x1000:5ff0
// 1000:5fea      8b 1e 09 a2              MOV BX,word ptr [0xa209]
// 1000:5fee      ff d3                    CALL BX
// 1000:5ff0  LAB_1000_5ff0:
// 1000:5ff0      cf                       IRET
int01_trap :: proc() {
}

// @proc 1000:62cf
// listing: FUN_1000_62cf
// status: unread
// 1000:62cf  FUN_1000_62cf:
// 1000:62cf      83 3e 5e a2 00           CMP word ptr [0xa25e],0x0
// 1000:62d4      75 06                    JNZ 0x1000:62dc
// 1000:62d6      c7 06 5e a2 01 00        MOV word ptr [0xa25e],0x1
// 1000:62dc  LAB_1000_62dc:
// 1000:62dc      c3                       RET
fun_62cf :: proc() {
}

// @proc 1000:62dd
// listing: FUN_1000_62dd
// status: unread
// 1000:62dd  FUN_1000_62dd:
// 1000:62dd      8b 1e 71 a4              MOV BX,word ptr [0xa471]
// 1000:62e1      e8 05 00                 CALL 0x1000:62e9
// 1000:62e4      89 1e 71 a4              MOV word ptr [0xa471],BX
// 1000:62e8      c3                       RET
fun_62dd :: proc() {
}

// @proc 1000:62e9
// listing: FUN_1000_62e9
// status: unread
// 1000:62e9  FUN_1000_62e9:
// 1000:62e9      52                       PUSH DX
// 1000:62ea      33 d2                    XOR DX,DX
// 1000:62ec      32 c7                    XOR AL,BH
// 1000:62ee      7a 03                    JP 0x1000:62f3
// 1000:62f0      b2 02                    MOV DL,0x2
// 1000:62f2      f9                       STC
// 1000:62f3  LAB_1000_62f3:
// 1000:62f3      d0 d8                    RCR AL,0x1
// 1000:62f5      8a f0                    MOV DH,AL
// 1000:62f7      d0 da                    RCR DL,0x1
// 1000:62f9      8a e2                    MOV AH,DL
// 1000:62fb      d0 d8                    RCR AL,0x1
// 1000:62fd      d0 da                    RCR DL,0x1
// 1000:62ff      32 c6                    XOR AL,DH
// 1000:6301      8a f0                    MOV DH,AL
// 1000:6303      8a c2                    MOV AL,DL
// 1000:6305      32 c4                    XOR AL,AH
// 1000:6307      32 c3                    XOR AL,BL
// 1000:6309      8a f8                    MOV BH,AL
// 1000:630b      8a de                    MOV BL,DH
// 1000:630d      5a                       POP DX
// 1000:630e      c3                       RET
fun_62e9 :: proc() {
}

// @proc 1000:6310
// listing: FUN_1000_6310
// status: unread
// 1000:6310  FUN_1000_6310:
// 1000:6310      bf 12 a2                 MOV DI,0xa212
// 1000:6313      be 26 a2                 MOV SI,0xa226
// 1000:6316      bb 00 00                 MOV BX,0x0
// 1000:6319  LAB_1000_6319:
// 1000:6319      80 3c 6d                 CMP byte ptr [SI],0x6d
// 1000:631c      75 1f                    JNZ 0x1000:633d
// 1000:631e      80 bf e0 89 00           CMP byte ptr [BX + 0x89e0],0x0
// 1000:6323      75 18                    JNZ 0x1000:633d
// 1000:6325      53                       PUSH BX
// 1000:6326      56                       PUSH SI
// 1000:6327      57                       PUSH DI
// 1000:6328      e8 20 00                 CALL 0x1000:634b
// 1000:632b      5f                       POP DI
// 1000:632c      5e                       POP SI
// 1000:632d      5b                       POP BX
// 1000:632e      aa                       STOSB ES:DI
// 1000:632f      b0 00                    MOV AL,0x0
// 1000:6331      aa                       STOSB ES:DI
// 1000:6332      b0 00                    MOV AL,0x0
// 1000:6334      aa                       STOSB ES:DI
// 1000:6335      b0 00                    MOV AL,0x0
// 1000:6337      aa                       STOSB ES:DI
// 1000:6338      b0 01                    MOV AL,0x1
// 1000:633a      aa                       STOSB ES:DI
// 1000:633b      eb 03                    JMP 0x1000:6340
// 1000:633d  LAB_1000_633d:
// 1000:633d      83 c7 05                 ADD DI,0x5
// 1000:6340  LAB_1000_6340:
// 1000:6340      83 c6 0b                 ADD SI,0xb
// 1000:6343      fe c3                    INC BL
// 1000:6345      80 fb 04                 CMP BL,0x4
// 1000:6348      72 cf                    JC 0x1000:6319
// 1000:634a      c3                       RET
fun_6310 :: proc() {
}

// @proc 1000:634b
// listing: FUN_1000_634b
// status: unread
// 1000:634b  FUN_1000_634b:
// 1000:634b      88 1e 74 a2              MOV byte ptr [0xa274],BL
// 1000:634f      e8 7c bb                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:635a  [ptr] 1000:a268 1000:a269 1000:a26a 1000:a26b
// 1000:635a  LAB_1000_635a:
// 1000:635a      8a 07                    MOV AL,byte ptr [BX]
// 1000:635c      22 c0                    AND AL,AL
// 1000:635e      74 05                    JZ 0x1000:6365
// 1000:6360      fe 0f                    DEC byte ptr [BX]
// 1000:6362      32 c0                    XOR AL,AL
// 1000:6364      c3                       RET
// 1000:6365  LAB_1000_6365:
// 1000:6365      a0 0f 00                 MOV AL,[0xf]
// 1000:6368      b4 14                    MOV AH,0x14
// 1000:636a      22 c0                    AND AL,AL
// 1000:636c      74 0e                    JZ 0x1000:637c
// 1000:636e      b4 0d                    MOV AH,0xd
// 1000:6370      fe c8                    DEC AL
// 1000:6372      74 08                    JZ 0x1000:637c
// 1000:6374      fe c8                    DEC AL
// 1000:6376      b4 06                    MOV AH,0x6
// 1000:6378      74 02                    JZ 0x1000:637c
// 1000:637a      b4 00                    MOV AH,0x0
// 1000:637c  LAB_1000_637c:
// 1000:637c      88 27                    MOV byte ptr [BX],AH
// 1000:637e      e8 6b 00                 CALL 0x1000:63ec
// 1000:6381      75 03                    JNZ 0x1000:6386
// 1000:6383      b0 85                    MOV AL,0x85
// 1000:6385      c3                       RET
// 1000:6386  LAB_1000_6386:
// 1000:6386      e8 45 bb                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:6391  [ptr] 1000:a275 1000:a276 1000:a277 1000:a278
// 1000:6391  LAB_1000_6391:
// 1000:6391      8a 07                    MOV AL,byte ptr [BX]
// 1000:6393      22 c0                    AND AL,AL
// 1000:6395      74 04                    JZ 0x1000:639b
// 1000:6397      c6 07 00                 MOV byte ptr [BX],0x0
// 1000:639a      c3                       RET
// 1000:639b  LAB_1000_639b:
// 1000:639b      e8 30 bb                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:63a6  [ptr] 1000:89d4 1000:89d5 1000:89d6 1000:89d7
// 1000:63a6  LAB_1000_63a6:
// 1000:63a6      8a 07                    MOV AL,byte ptr [BX]
// 1000:63a8      b9 04 00                 MOV CX,0x4
// 1000:63ab  LAB_1000_63ab:
// 1000:63ab      51                       PUSH CX
// 1000:63ac      fe c0                    INC AL
// 1000:63ae      24 03                    AND AL,0x3
// 1000:63b0      50                       PUSH AX
// 1000:63b1      e8 58 c6                 CALL 0x1000:2a0c
// 1000:63b4      74 05                    JZ 0x1000:63bb
// 1000:63b6      e8 81 03                 CALL 0x1000:673a
// 1000:63b9      72 07                    JC 0x1000:63c2
// 1000:63bb  LAB_1000_63bb:
// 1000:63bb      58                       POP AX
// 1000:63bc      59                       POP CX
// 1000:63bd      e2 ec                    LOOP 0x1000:63ab
// 1000:63bf      32 c0                    XOR AL,AL
// 1000:63c1      c3                       RET
// 1000:63c2  LAB_1000_63c2:
// 1000:63c2      58                       POP AX
// 1000:63c3      59                       POP CX
// 1000:63c4      53                       PUSH BX
// 1000:63c5      e8 06 bb                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:63d0  [ptr] 1000:89d4 1000:89d5 1000:89d6 1000:89d7
// 1000:63d0  LAB_1000_63d0:
// 1000:63d0      80 27 ec                 AND byte ptr [BX],0xec
// 1000:63d3      08 07                    OR byte ptr [BX],AL
// 1000:63d5      5b                       POP BX
// 1000:63d6      8a e0                    MOV AH,AL
// 1000:63d8      8a c3                    MOV AL,BL
// 1000:63da      50                       PUSH AX
// 1000:63db      53                       PUSH BX
// 1000:63dc      e8 ef ba                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:63e7  [ptr] 1000:a275 1000:a276 1000:a277 1000:a278
// 1000:63e7  LAB_1000_63e7:
// 1000:63e7      58                       POP AX
// 1000:63e8      88 27                    MOV byte ptr [BX],AH
// 1000:63ea      58                       POP AX
// 1000:63eb      c3                       RET
fun_634b :: proc() {
}

// @proc 1000:63ec
// listing: FUN_1000_63ec
// status: unread
// 1000:63ec  FUN_1000_63ec:
// 1000:63ec      80 3e d2 89 0a           CMP byte ptr [0x89d2],0xa
// 1000:63f1      73 01                    JNC 0x1000:63f4
// 1000:63f3      c3                       RET
// 1000:63f4  LAB_1000_63f4:
// 1000:63f4      c6 06 90 a4 00           MOV byte ptr [0xa490],0x0
// 1000:63f9      e8 d2 ba                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:6404  [ptr] 1000:8c64 1000:8d50 1000:8e3c 1000:8f28
// 1000:6404  LAB_1000_6404:
// 1000:6404      8b f3                    MOV SI,BX
// 1000:6406      b1 00                    MOV CL,0x0
// 1000:6408  LAB_1000_6408:
// 1000:6408      f6 04 80                 TEST byte ptr [SI],0x80
// 1000:640b      74 38                    JZ 0x1000:6445
// 1000:640d      fe 06 90 a4              INC byte ptr [0xa490]
// 1000:6411      56                       PUSH SI
// 1000:6412      51                       PUSH CX
// 1000:6413      83 7c 24 00              CMP word ptr [SI + 0x24],0x0
// 1000:6417      75 24                    JNZ 0x1000:643d
// 1000:6419      c6 44 11 00              MOV byte ptr [SI + 0x11],0x0
// 1000:641d      e8 5a df                 CALL 0x1000:437a
// 1000:6420      88 44 0a                 MOV byte ptr [SI + 0xa],AL
// 1000:6423      b8 0c 00                 MOV AX,0xc
// 1000:6426      f6 e1                    MUL CL
// 1000:6428      88 44 23                 MOV byte ptr [SI + 0x23],AL
// 1000:642b      b8 20 03                 MOV AX,0x320
// 1000:642e      33 d2                    XOR DX,DX
// 1000:6430      f7 e1                    MUL CX
// 1000:6432      05 b8 0b                 ADD AX,0xbb8
// 1000:6435      89 44 26                 MOV word ptr [SI + 0x26],AX
// 1000:6438      c7 44 24 55 64           MOV word ptr [SI + 0x24],0x6455
// 1000:643d  LAB_1000_643d:
// 1000:643d      ff 54 24                 CALL word ptr [SI + 0x24]
// 1000:6440      e8 de 02                 CALL 0x1000:6721
// 1000:6443      59                       POP CX
// 1000:6444      5e                       POP SI
// 1000:6445  LAB_1000_6445:
// 1000:6445      83 c6 3b                 ADD SI,0x3b
// 1000:6448      fe c1                    INC CL
// 1000:644a      80 f9 04                 CMP CL,0x4
// 1000:644d      75 b9                    JNZ 0x1000:6408
// 1000:644f      f6 06 90 a4 ff           TEST byte ptr [0xa490],0xff
// 1000:6454      c3                       RET
fun_63ec :: proc() {
}

// @proc 1000:6455
// listing: FUN_1000_6455
// status: unread
// 1000:6455  FUN_1000_6455:
// 1000:6455      e8 76 ba                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:6460  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
// 1000:6460  LAB_1000_6460:
// 1000:6460      83 7f 08 00              CMP word ptr [BX + 0x8],0x0
// 1000:6464      74 25                    JZ 0x1000:648b
// 1000:6466      c6 44 11 00              MOV byte ptr [SI + 0x11],0x0
// 1000:646a      8b 44 08                 MOV AX,word ptr [SI + 0x8]
// 1000:646d      3b 44 26                 CMP AX,word ptr [SI + 0x26]
// 1000:6470      72 18                    JC 0x1000:648a
// 1000:6472      e8 8c 03                 CALL 0x1000:6801
// 1000:6475      3a 44 23                 CMP AL,byte ptr [SI + 0x23]
// 1000:6478      73 11                    JNC 0x1000:648b
// 1000:647a      80 7c 23 00              CMP byte ptr [SI + 0x23],0x0
// 1000:647e      74 0a                    JZ 0x1000:648a
// 1000:6480      f6 06 d2 89 03           TEST byte ptr [0x89d2],0x3
// 1000:6485      75 03                    JNZ 0x1000:648a
// 1000:6487      fe 4c 23                 DEC byte ptr [SI + 0x23]
// 1000:648a  LAB_1000_648a:
// 1000:648a      c3                       RET
// 1000:648b  LAB_1000_648b:
// 1000:648b      c7 44 24 9a 64           MOV word ptr [SI + 0x24],0x649a
// 1000:6490      e8 e7 de                 CALL 0x1000:437a
// 1000:6493      24 0f                    AND AL,0xf
// 1000:6495      04 07                    ADD AL,0x7
// 1000:6497      e9 d2 01                 JMP 0x1000:666c
// 1000:649a      80 7c 14 00              CMP byte ptr [SI + 0x14],0x0
// 1000:649e      74 0b                    JZ 0x1000:64ab
// 1000:64a0      f6 06 12 00 01           TEST byte ptr [0x12],0x1
// 1000:64a5      74 09                    JZ 0x1000:64b0
// 1000:64a7      fe 4c 14                 DEC byte ptr [SI + 0x14]
// 1000:64aa      c3                       RET
// 1000:64ab  LAB_1000_64ab:
// 1000:64ab      c7 44 24 b1 64           MOV word ptr [SI + 0x24],0x64b1
// 1000:64b0  LAB_1000_64b0:
// 1000:64b0      c3                       RET
// 1000:64b1      f6 04 44                 TEST byte ptr [SI],0x44
// 1000:64b4      74 0f                    JZ 0x1000:64c5
// 1000:64b6      81 7c 08 a0 0f           CMP word ptr [SI + 0x8],0xfa0
// 1000:64bb      72 07                    JC 0x1000:64c4
// 1000:64bd      81 7c 08 80 3e           CMP word ptr [SI + 0x8],0x3e80
// 1000:64c2      72 01                    JC 0x1000:64c5
// 1000:64c4  LAB_1000_64c4:
// 1000:64c4      c3                       RET
// 1000:64c5  LAB_1000_64c5:
// 1000:64c5      81 7c 08 a8 61           CMP word ptr [SI + 0x8],0x61a8
// 1000:64ca      72 19                    JC 0x1000:64e5
// 1000:64cc      80 7c 07 08              CMP byte ptr [SI + 0x7],0x8
// 1000:64d0      72 13                    JC 0x1000:64e5
// 1000:64d2      80 7c 2a 06              CMP byte ptr [SI + 0x2a],0x6
// 1000:64d6      72 0d                    JC 0x1000:64e5
// 1000:64d8      e8 26 03                 CALL 0x1000:6801
// 1000:64db      3c 14                    CMP AL,0x14
// 1000:64dd      72 06                    JC 0x1000:64e5
// 1000:64df      c7 44 24 7a 66           MOV word ptr [SI + 0x24],0x667a
// 1000:64e4      c3                       RET
// 1000:64e5  LAB_1000_64e5:
// 1000:64e5      f6 44 28 ff              TEST byte ptr [SI + 0x28],0xff
// 1000:64e9      75 03                    JNZ 0x1000:64ee
// 1000:64eb      e9 e7 00                 JMP 0x1000:65d5
// 1000:64ee  LAB_1000_64ee:
// 1000:64ee      f6 44 28 08              TEST byte ptr [SI + 0x28],0x8
// 1000:64f2      74 0b                    JZ 0x1000:64ff
// 1000:64f4      80 7c 2a 04              CMP byte ptr [SI + 0x2a],0x4
// 1000:64f8      77 05                    JA 0x1000:64ff
// 1000:64fa      b0 03                    MOV AL,0x3
// 1000:64fc      e9 fe 00                 JMP 0x1000:65fd
// 1000:64ff  LAB_1000_64ff:
// 1000:64ff      f6 44 28 20              TEST byte ptr [SI + 0x28],0x20
// 1000:6503      74 0c                    JZ 0x1000:6511
// 1000:6505      81 7c 08 ac 0d           CMP word ptr [SI + 0x8],0xdac
// 1000:650a      77 05                    JA 0x1000:6511
// 1000:650c      b0 0b                    MOV AL,0xb
// 1000:650e      e9 ec 00                 JMP 0x1000:65fd
// 1000:6511  LAB_1000_6511:
// 1000:6511      f6 44 28 02              TEST byte ptr [SI + 0x28],0x2
// 1000:6515      74 0b                    JZ 0x1000:6522
// 1000:6517      80 7c 07 05              CMP byte ptr [SI + 0x7],0x5
// 1000:651b      77 05                    JA 0x1000:6522
// 1000:651d      b0 09                    MOV AL,0x9
// 1000:651f      e9 db 00                 JMP 0x1000:65fd
// 1000:6522  LAB_1000_6522:
// 1000:6522      f6 44 28 01              TEST byte ptr [SI + 0x28],0x1
// 1000:6526      74 0c                    JZ 0x1000:6534
// 1000:6528      81 7c 08 f8 2a           CMP word ptr [SI + 0x8],0x2af8
// 1000:652d      77 05                    JA 0x1000:6534
// 1000:652f      b0 02                    MOV AL,0x2
// 1000:6531      e9 c9 00                 JMP 0x1000:65fd
// 1000:6534  LAB_1000_6534:
// 1000:6534      f6 44 28 04              TEST byte ptr [SI + 0x28],0x4
// 1000:6538      74 0b                    JZ 0x1000:6545
// 1000:653a      80 7c 0f 0a              CMP byte ptr [SI + 0xf],0xa
// 1000:653e      77 05                    JA 0x1000:6545
// 1000:6540      b0 05                    MOV AL,0x5
// 1000:6542      e9 b8 00                 JMP 0x1000:65fd
// 1000:6545  LAB_1000_6545:
// 1000:6545      f6 44 28 80              TEST byte ptr [SI + 0x28],0x80
// 1000:6549      74 24                    JZ 0x1000:656f
// 1000:654b      e8 80 b9                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:6556  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
// 1000:6556  LAB_1000_6556:
// 1000:6556      83 7f 08 00              CMP word ptr [BX + 0x8],0x0
// 1000:655a      74 13                    JZ 0x1000:656f
// 1000:655c      81 7f 08 4c 1d           CMP word ptr [BX + 0x8],0x1d4c
// 1000:6561      77 0c                    JA 0x1000:656f
// 1000:6563      81 7c 08 20 4e           CMP word ptr [SI + 0x8],0x4e20
// 1000:6568      72 05                    JC 0x1000:656f
// 1000:656a      b0 04                    MOV AL,0x4
// 1000:656c      e9 8e 00                 JMP 0x1000:65fd
// 1000:656f  LAB_1000_656f:
// 1000:656f      f6 44 28 02              TEST byte ptr [SI + 0x28],0x2
// 1000:6573      74 0b                    JZ 0x1000:6580
// 1000:6575      80 7c 07 09              CMP byte ptr [SI + 0x7],0x9
// 1000:6579      73 05                    JNC 0x1000:6580
// 1000:657b      b0 09                    MOV AL,0x9
// 1000:657d      eb 7e                    JMP 0x1000:65fd
// 1000:6580  LAB_1000_6580:
// 1000:6580      f6 44 28 40              TEST byte ptr [SI + 0x28],0x40
// 1000:6584      74 0b                    JZ 0x1000:6591
// 1000:6586      f6 44 16 40              TEST byte ptr [SI + 0x16],0x40
// 1000:658a      74 05                    JZ 0x1000:6591
// 1000:658c      b0 0a                    MOV AL,0xa
// 1000:658e      eb 6d                    JMP 0x1000:65fd
// 1000:6591  LAB_1000_6591:
// 1000:6591      f6 44 28 80              TEST byte ptr [SI + 0x28],0x80
// 1000:6595      74 0c                    JZ 0x1000:65a3
// 1000:6597      81 7c 08 d0 07           CMP word ptr [SI + 0x8],0x7d0
// 1000:659c      77 05                    JA 0x1000:65a3
// 1000:659e      b0 04                    MOV AL,0x4
// 1000:65a0      eb 5b                    JMP 0x1000:65fd
// 1000:65a3  LAB_1000_65a3:
// 1000:65a3      f6 44 28 01              TEST byte ptr [SI + 0x28],0x1
// 1000:65a7      74 05                    JZ 0x1000:65ae
// 1000:65a9      b0 02                    MOV AL,0x2
// 1000:65ab      eb 50                    JMP 0x1000:65fd
// 1000:65ae  LAB_1000_65ae:
// 1000:65ae      f6 44 28 04              TEST byte ptr [SI + 0x28],0x4
// 1000:65b2      74 0b                    JZ 0x1000:65bf
// 1000:65b4      80 7c 0f 32              CMP byte ptr [SI + 0xf],0x32
// 1000:65b8      77 05                    JA 0x1000:65bf
// 1000:65ba      b0 05                    MOV AL,0x5
// 1000:65bc      eb 3f                    JMP 0x1000:65fd
// 1000:65bf  LAB_1000_65bf:
// 1000:65bf      f6 44 28 10              TEST byte ptr [SI + 0x28],0x10
// 1000:65c3      74 05                    JZ 0x1000:65ca
// 1000:65c5      b0 01                    MOV AL,0x1
// 1000:65c7      eb 34                    JMP 0x1000:65fd
// 1000:65ca  LAB_1000_65ca:
// 1000:65ca      f6 44 28 40              TEST byte ptr [SI + 0x28],0x40
// 1000:65ce      74 05                    JZ 0x1000:65d5
// 1000:65d0      b0 0a                    MOV AL,0xa
// 1000:65d2      eb 29                    JMP 0x1000:65fd
// 1000:65d5  LAB_1000_65d5:
// 1000:65d5      f6 44 16 40              TEST byte ptr [SI + 0x16],0x40
// 1000:65d9      74 0c                    JZ 0x1000:65e7
// 1000:65db      81 7c 08 40 1f           CMP word ptr [SI + 0x8],0x1f40
// 1000:65e0      77 23                    JA 0x1000:6605
// 1000:65e2      b0 08                    MOV AL,0x8
// 1000:65e4      eb 17                    JMP 0x1000:65fd
// 1000:65e7  LAB_1000_65e7:
// 1000:65e7      f6 06 12 00 01           TEST byte ptr [0x12],0x1
// 1000:65ec      b0 02                    MOV AL,0x2
// 1000:65ee      75 0d                    JNZ 0x1000:65fd
// 1000:65f0      e8 0e 02                 CALL 0x1000:6801
// 1000:65f3      3a 06 00 00              CMP AL,byte ptr [0x0]
// 1000:65f7      b0 02                    MOV AL,0x2
// 1000:65f9      74 02                    JZ 0x1000:65fd
// 1000:65fb      b0 01                    MOV AL,0x1
// 1000:65fd  LAB_1000_65fd:
// 1000:65fd      88 44 11                 MOV byte ptr [SI + 0x11],AL
// 1000:6600      c7 44 24 0a 66           MOV word ptr [SI + 0x24],0x660a
// 1000:6605  LAB_1000_6605:
// 1000:6605      b0 05                    MOV AL,0x5
// 1000:6607      eb 63                    JMP 0x1000:666c
// 1000:660a      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
// 1000:660d      a8 80                    TEST AL,0x80
// 1000:660f      75 48                    JNZ 0x1000:6659
// 1000:6611      24 1f                    AND AL,0x1f
// 1000:6613      3c 04                    CMP AL,0x4
// 1000:6615      74 4b                    JZ 0x1000:6662
// 1000:6617      3c 01                    CMP AL,0x1
// 1000:6619      75 09                    JNZ 0x1000:6624
// 1000:661b      f6 44 28 ef              TEST byte ptr [SI + 0x28],0xef
// 1000:661f      75 38                    JNZ 0x1000:6659
// 1000:6621      eb 10                    JMP 0x1000:6633
// 1000:6624  LAB_1000_6624:
// 1000:6624      3c 06                    CMP AL,0x6
// 1000:6626      74 1c                    JZ 0x1000:6644
// 1000:6628      3c 07                    CMP AL,0x7
// 1000:662a      74 18                    JZ 0x1000:6644
// 1000:662c      81 7c 12 94 11           CMP word ptr [SI + 0x12],0x1194
// 1000:6631      77 26                    JA 0x1000:6659
// 1000:6633  LAB_1000_6633:
// 1000:6633      24 1f                    AND AL,0x1f
// 1000:6635      74 22                    JZ 0x1000:6659
// 1000:6637      3c 08                    CMP AL,0x8
// 1000:6639      75 27                    JNZ 0x1000:6662
// 1000:663b      f6 44 16 42              TEST byte ptr [SI + 0x16],0x42
// 1000:663f      74 18                    JZ 0x1000:6659
// 1000:6641      eb 1f                    JMP 0x1000:6662
// 1000:6644  LAB_1000_6644:
// 1000:6644      81 7c 08 e0 2e           CMP word ptr [SI + 0x8],0x2ee0
// 1000:6649      72 0e                    JC 0x1000:6659
// 1000:664b      80 7c 07 01              CMP byte ptr [SI + 0x7],0x1
// 1000:664f      72 11                    JC 0x1000:6662
// 1000:6651      f6 44 16 63              TEST byte ptr [SI + 0x16],0x63
// 1000:6655      b0 05                    MOV AL,0x5
// 1000:6657      75 13                    JNZ 0x1000:666c
// 1000:6659  LAB_1000_6659:
// 1000:6659      c6 44 11 00              MOV byte ptr [SI + 0x11],0x0
// 1000:665d      c7 44 24 b1 64           MOV word ptr [SI + 0x24],0x64b1
// 1000:6662  LAB_1000_6662:
// 1000:6662      81 7c 08 28 23           CMP word ptr [SI + 0x8],0x2328
// 1000:6667      b0 0a                    MOV AL,0xa
// 1000:6669      77 01                    JA 0x1000:666c
// 1000:666b      c3                       RET
fun_6455 :: proc() {
}

