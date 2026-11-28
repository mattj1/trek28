package trek

// Procedures 1000:ac37 through 1000:cfa0.
// The assembly is the listing. The body is empty until the procedure is translated.
// A notes line is a name already supported by the annotation notes.

// @proc 1000:ac37
// listing: FUN_1000_ac37
// status: unread
// 1000:ac37  FUN_1000_ac37:
// 1000:ac37      be 00 a8                 MOV SI,0xa800
// 1000:ac3a      b9 33 02                 MOV CX,0x233
// 1000:ac3d      2b c0                    SUB AX,AX
// 1000:ac3f  LAB_1000_ac3f:
// 1000:ac3f      2e 2b 04                 SUB AX,word ptr CS:[SI]
// 1000:ac42      83 c6 02                 ADD SI,0x2
// 1000:ac45      e2 f8                    LOOP 0x1000:ac3f
// 1000:ac47      23 c0                    AND AX,AX
// 1000:ac49      75 02                    JNZ 0x1000:ac4d
// 1000:ac4b      c3                       RET
// 1000:ac4d  LAB_1000_ac4d:
// 1000:ac4d      fa                       CLI
// 1000:ac4e      33 c0                    XOR AX,AX
// 1000:ac50      50                       PUSH AX
// 1000:ac51      48                       DEC AX
// 1000:ac52      50                       PUSH AX
// 1000:ac53      40                       INC AX
// 1000:ac54      50                       PUSH AX
// 1000:ac55      cf                       IRET
fun_ac37 :: proc() {
}

// @proc 1000:ac56
// listing: FUN_1000_ac56
// status: unread
// 1000:ac56  FUN_1000_ac56:
// 1000:ac56      c7 06 57 a2 00 00        MOV word ptr [0xa257],0x0
// 1000:ac5c      fa                       CLI
// 1000:ac5d      a0 00 a2                 MOV AL,[0xa200]
// 1000:ac60      24 fd                    AND AL,0xfd
// 1000:ac62      e6 21                    OUT 0x21,AL
// 1000:ac64      fb                       STI
// 1000:ac65      c3                       RET
fun_ac56 :: proc() {
}

// @proc 1000:cfa0
// listing: FUN_1000_cfa0
// status: unread
// 1000:cfa0  FUN_1000_cfa0:
// 1000:cfa0      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:cfa3      00 28                    ADD byte ptr [BX + SI],CH
// 1000:cfa5      00 07                    ADD byte ptr [BX],AL
// 1000:cfa7      3f                       AAS
// 1000:cfa8      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:cfab      00 00                    ADD byte ptr [BX + SI],AL
// 1000:cfad      00 07                    ADD byte ptr [BX],AL
// 1000:cfaf      3f                       AAS
// 1000:cfb0      80 00 b5                 ADD byte ptr [BX + SI],0xb5
// 1000:cfb3      00 55 00                 ADD byte ptr [DI + 0x0],DL
// 1000:cfb6      57                       PUSH DI
// 1000:cfb7      3f                       AAS
// 1000:cfb8      80 00 bf                 ADD byte ptr [BX + SI],0xbf
// 1000:cfbb      00 ff                    ADD BH,BH
// 1000:cfbd      00 ff                    ADD BH,BH
// 1000:cfbf      3f                       AAS
// 1000:cfc0      80 00 aa                 ADD byte ptr [BX + SI],0xaa
// 1000:cfc3      00 aa 00 aa              ADD byte ptr [BP + SI + 0xaa00],CH
// 1000:cfc7      3f                       AAS
// 1000:cfc8      80 0d 0d                 OR byte ptr [DI],0xd
// 1000:cfcb      00 aa 00 aa              ADD byte ptr [BP + SI + 0xaa00],CH
// 1000:cfcf      00 aa 3f 80              ADD byte ptr [BP + SI + 0x803f],CH
// 1000:cfd3      00 bf 00 ff              ADD byte ptr [BX + 0xff00],BH
// 1000:cfd7      00 ff                    ADD BH,BH
// 1000:cfd9      3f                       AAS
// 1000:cfda      80 00 b5                 ADD byte ptr [BX + SI],0xb5
// 1000:cfdd      00 55 00                 ADD byte ptr [DI + 0x0],DL
// 1000:cfe0      57                       PUSH DI
// 1000:cfe1      3f                       AAS
// 1000:cfe2      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:cfe5      00 00                    ADD byte ptr [BX + SI],AL
// 1000:cfe7      00 07                    ADD byte ptr [BX],AL
// 1000:cfe9      3f                       AAS
// 1000:cfea      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:cfed      00 2a                    ADD byte ptr [BP + SI],CH
// 1000:cfef      00 07                    ADD byte ptr [BX],AL
// 1000:cff1      3f                       AAS
// 1000:cff2      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:cff5      00 20                    ADD byte ptr [BX + SI],AH
// 1000:cff7      00 07                    ADD byte ptr [BX],AL
// 1000:cff9      3f                       AAS
// 1000:cffa      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:cffd      00 20                    ADD byte ptr [BX + SI],AH
// 1000:cfff      00 07                    ADD byte ptr [BX],AL
// 1000:d001      3f                       AAS
// 1000:d002      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:d005      00 20                    ADD byte ptr [BX + SI],AH
// 1000:d007      00 07                    ADD byte ptr [BX],AL
// 1000:d009      3f                       AAS
// 1000:d00a      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:d00d      00 2a                    ADD byte ptr [BP + SI],CH
// 1000:d00f      00 07                    ADD byte ptr [BX],AL
// 1000:d011      3f                       AAS
// 1000:d012      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:d015      00 00                    ADD byte ptr [BX + SI],AL
// 1000:d017      00 07                    ADD byte ptr [BX],AL
// 1000:d019      3f                       AAS
// 1000:d01a      80 00 b5                 ADD byte ptr [BX + SI],0xb5
// 1000:d01d      00 55 00                 ADD byte ptr [DI + 0x0],DL
// 1000:d020      57                       PUSH DI
// 1000:d021      3f                       AAS
// 1000:d022      80 00 bf                 ADD byte ptr [BX + SI],0xbf
// 1000:d025      00 ff                    ADD BH,BH
// 1000:d027      00 ff                    ADD BH,BH
// 1000:d029      3f                       AAS
// 1000:d02a      80 00 aa                 ADD byte ptr [BX + SI],0xaa
// 1000:d02d      00 aa 00 aa              ADD byte ptr [BP + SI + 0xaa00],CH
// 1000:d031      3f                       AAS
// 1000:d032      80 0d 0d                 OR byte ptr [DI],0xd
// 1000:d035      00 aa 00 aa              ADD byte ptr [BP + SI + 0xaa00],CH
// 1000:d039      00 aa 3f 80              ADD byte ptr [BP + SI + 0x803f],CH
// 1000:d03d      00 bf 00 ff              ADD byte ptr [BX + 0xff00],BH
// 1000:d041      00 ff                    ADD BH,BH
// 1000:d043      3f                       AAS
// 1000:d044      80 00 b5                 ADD byte ptr [BX + SI],0xb5
// 1000:d047      00 55 00                 ADD byte ptr [DI + 0x0],DL
// 1000:d04a      57                       PUSH DI
// 1000:d04b      3f                       AAS
// 1000:d04c      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:d04f      00 00                    ADD byte ptr [BX + SI],AL
// 1000:d051      00 07                    ADD byte ptr [BX],AL
// 1000:d053      3f                       AAS
// 1000:d054      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:d057      00 28                    ADD byte ptr [BX + SI],CH
// 1000:d059      00 07                    ADD byte ptr [BX],AL
// 1000:d05b      3f                       AAS
// 1000:d05c      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:d05f      00 22                    ADD byte ptr [BP + SI],AH
// 1000:d061      00 07                    ADD byte ptr [BX],AL
// 1000:d063      3f                       AAS
// 1000:d064      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:d067      00 22                    ADD byte ptr [BP + SI],AH
// 1000:d069      00 07                    ADD byte ptr [BX],AL
// 1000:d06b      3f                       AAS
// 1000:d06c      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:d06f      00 22                    ADD byte ptr [BP + SI],AH
// 1000:d071      00 07                    ADD byte ptr [BX],AL
// 1000:d073      3f                       AAS
// 1000:d074      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:d077      00 28                    ADD byte ptr [BX + SI],CH
// 1000:d079      00 07                    ADD byte ptr [BX],AL
// 1000:d07b      3f                       AAS
// 1000:d07c      80 03 b4                 ADD byte ptr [BP + DI],0xb4
// 1000:d07f      00 00                    ADD byte ptr [BX + SI],AL
// 1000:d081      00 07                    ADD byte ptr [BX],AL
// 1000:d083      3f                       AAS
// 1000:d084      80 00 b5                 ADD byte ptr [BX + SI],0xb5
// 1000:d087      00 55 00                 ADD byte ptr [DI + 0x0],DL
// 1000:d08a      57                       PUSH DI
// 1000:d08b      3f                       AAS
// 1000:d08c      80 00 bf                 ADD byte ptr [BX + SI],0xbf
// 1000:d08f      00 ff                    ADD BH,BH
// 1000:d091      00 ff                    ADD BH,BH
// 1000:d093      3f                       AAS
// 1000:d094      80 00 aa                 ADD byte ptr [BX + SI],0xaa
// 1000:d097      00 aa 00 aa              ADD byte ptr [BP + SI + 0xaa00],CH
// 1000:d09b      3f                       AAS
// 1000:d09c      80 09 09                 OR byte ptr [BX + DI],0x9
// 1000:d09f      00 00                    ADD byte ptr [BX + SI],AL
// 1000:d0a1      00 c0                    ADD AL,AL
// 1000:d0a3      3f                       AAS
// 1000:d0a4      00 00                    ADD byte ptr [BX + SI],AL
// 1000:d0a6      00 00                    ADD byte ptr [BX + SI],AL
// 1000:d0a8      30 3f                    XOR byte ptr [BX],BH
// 1000:d0aa      00 00                    ADD byte ptr [BX + SI],AL
// 1000:d0ac      00 00                    ADD byte ptr [BX + SI],AL
// 1000:d0ae      30 3f                    XOR byte ptr [BX],BH
// 1000:d0b0      00 00                    ADD byte ptr [BX + SI],AL
// 1000:d0b2      3c 00                    CMP AL,0x0
// 1000:d0b4      c0 3f 00                 SAR byte ptr [BX],0x0
// 1000:d0b7      00 c3                    ADD BL,AL
// 1000:d0b9      00 f0                    ADD AL,DH
// 1000:d0bb      3f                       AAS
// 1000:d0bc      c0 00 00                 ROL byte ptr [BX + SI],0x0
// 1000:d0bf      00 cf                    ADD BH,CL
// 1000:d0c1      3f                       AAS
// 1000:d0c2      00 00                    ADD byte ptr [BX + SI],AL
// 1000:d0c4      03 00                    ADD AX,word ptr [BX + SI]
// 1000:d0c6      00 3f                    ADD byte ptr [BX],BH
// 1000:d0c8      00 00                    ADD byte ptr [BX + SI],AL
// 1000:d0ca      03 00                    ADD AX,word ptr [BX + SI]
// 1000:d0cc      00 3f                    ADD byte ptr [BX],BH
// 1000:d0ce      00 00                    ADD byte ptr [BX + SI],AL
// 1000:d0d0      00 00                    ADD byte ptr [BX + SI],AL
// 1000:d0d2      c0 3f 00                 SAR byte ptr [BX],0x0
// 1000:d0d5      03 03                    ADD AX,word ptr [BP + DI]
// 1000:d0d7      cf                       IRET
fun_cfa0 :: proc() {
}

