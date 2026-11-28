package trek

// Procedures 1000:202f through 1000:2f9d.
// The assembly is the listing. The body is empty until the procedure is translated.
// A notes line is a name already supported by the annotation notes.

// 1000:1f1c update_side_ships is in ship.odin.

// 1000:2002 spawn_debris is in ship.odin.

// @proc 1000:202f
// listing: FUN_1000_202f
// notes: age_debris
// status: unread
// 1000:202f  FUN_1000_202f:
// 1000:202f      a0 d2 89                 MOV AL,[0x89d2]
// 1000:2032      24 07                    AND AL,0x7
// 1000:2034      3c 04                    CMP AL,0x4
// 1000:2036      74 01                    JZ 0x1000:2039
// 1000:2038      c3                       RET
// 1000:2039  LAB_1000_2039:
// 1000:2039      be 8c a0                 MOV SI,0xa08c
// 1000:203c      b9 30 00                 MOV CX,0x30
// 1000:203f  LAB_1000_203f:
// 1000:203f      80 3c 00                 CMP byte ptr [SI],0x0
// 1000:2042      74 0b                    JZ 0x1000:204f
// 1000:2044      fe 0c                    DEC byte ptr [SI]
// 1000:2046      75 07                    JNZ 0x1000:204f
// 1000:2048      56                       PUSH SI
// 1000:2049      51                       PUSH CX
// 1000:204a      e8 ea 8b                 CALL 0x1000:ac37
// 1000:204d      59                       POP CX
// 1000:204e      5e                       POP SI
// 1000:204f  LAB_1000_204f:
// 1000:204f      83 c6 07                 ADD SI,0x7
// 1000:2052      e2 eb                    LOOP 0x1000:203f
// 1000:2054      c3                       RET
fun_202f :: proc() {
}

// 1000:2055 charge_impulse_and_heal is in ship.odin.

// 1000:20e3 apply_damage_thresholds is in ship.odin.

// 1000:210a apply_energy_charge is in ship.odin.

// 1000:218b slew_impulse and 1000:21af step_impulse are in ship.odin.

// 1000:221e slew_heading is in ship.odin.

// 1000:226c drain_invisibility is in ship.odin.

// 1000:22a2 walk_planets is in planet.odin.

// 1000:2310 relocate_planet is in planet.odin.

// 1000:2343 tick_mine_lifetimes is in ship.odin.

// 1000:237b add_scaled_charge is in ship.odin.

// 1000:239b add_pending_charge is in ship.odin.

// 1000:23b3 read_handicap is in ship.odin.

// 1000:2a0c ship_ptr_from_al is in ship.odin.

// @proc 1000:2a26
// listing: FUN_1000_2a26
// status: unread
// 1000:2a26  FUN_1000_2a26:
// 1000:2a26      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
// 1000:2a29      3a 45 05                 CMP AL,byte ptr [DI + 0x5]
// 1000:2a2c      74 04                    JZ 0x1000:2a32
// 1000:2a2e      b8 ff ff                 MOV AX,0xffff
// 1000:2a31      c3                       RET
// 1000:2a32  LAB_1000_2a32:
// 1000:2a32      8b 5c 01                 MOV BX,word ptr [SI + 0x1]
// 1000:2a35      2b 5d 01                 SUB BX,word ptr [DI + 0x1]
// 1000:2a38      e8 fb 00                 CALL 0x1000:2b36
// 1000:2a3b      89 1e 83 a2              MOV word ptr [0xa283],BX
// 1000:2a3f      8b 5c 03                 MOV BX,word ptr [SI + 0x3]
// 1000:2a42      2b 5d 03                 SUB BX,word ptr [DI + 0x3]
// 1000:2a45      e8 ee 00                 CALL 0x1000:2b36
// 1000:2a48      89 1e 85 a2              MOV word ptr [0xa285],BX
// 1000:2a4c      e8 03 01                 CALL 0x1000:2b52
// 1000:2a4f      89 1e 89 a2              MOV word ptr [0xa289],BX
// 1000:2a53      b8 0a 00                 MOV AX,0xa
// 1000:2a56      f7 e3                    MUL BX
// 1000:2a58      8b 1e 83 a2              MOV BX,word ptr [0xa283]
// 1000:2a5c      e8 f3 00                 CALL 0x1000:2b52
// 1000:2a5f      89 1e 87 a2              MOV word ptr [0xa287],BX
// 1000:2a63      85 db                    TEST BX,BX
// 1000:2a65      75 0f                    JNZ 0x1000:2a76
// 1000:2a67  LAB_1000_2a67:
// 1000:2a67      b5 00                    MOV CH,0x0
// 1000:2a69      f7 06 85 a2 00 80        TEST word ptr [0xa285],0x8000
// 1000:2a6f      75 02                    JNZ 0x1000:2a73
// 1000:2a71      b5 08                    MOV CH,0x8
// 1000:2a73  LAB_1000_2a73:
// 1000:2a73      e9 9b 00                 JMP 0x1000:2b11
// 1000:2a76  LAB_1000_2a76:
// 1000:2a76      83 fa 00                 CMP DX,0x0
// 1000:2a79      74 05                    JZ 0x1000:2a80
// 1000:2a7b      83 fb 0a                 CMP BX,0xa
// 1000:2a7e      72 e7                    JC 0x1000:2a67
// 1000:2a80  LAB_1000_2a80:
// 1000:2a80      f7 f3                    DIV BX
// 1000:2a82      3d 02 00                 CMP AX,0x2
// 1000:2a85      77 0e                    JA 0x1000:2a95
// 1000:2a87      f7 06 83 a2 00 80        TEST word ptr [0xa283],0x8000
// 1000:2a8d      b5 04                    MOV CH,0x4
// 1000:2a8f      75 02                    JNZ 0x1000:2a93
// 1000:2a91      b5 0c                    MOV CH,0xc
// 1000:2a93  LAB_1000_2a93:
// 1000:2a93      eb 7c                    JMP 0x1000:2b11
// 1000:2a95  LAB_1000_2a95:
// 1000:2a95      3d 07 00                 CMP AX,0x7
// 1000:2a98      77 24                    JA 0x1000:2abe
// 1000:2a9a      f7 06 83 a2 00 80        TEST word ptr [0xa283],0x8000
// 1000:2aa0      75 0e                    JNZ 0x1000:2ab0
// 1000:2aa2      f7 06 85 a2 00 80        TEST word ptr [0xa285],0x8000
// 1000:2aa8      b5 0d                    MOV CH,0xd
// 1000:2aaa      75 10                    JNZ 0x1000:2abc
// 1000:2aac      b5 0b                    MOV CH,0xb
// 1000:2aae      eb 0c                    JMP 0x1000:2abc
// 1000:2ab0  LAB_1000_2ab0:
// 1000:2ab0      f7 06 85 a2 00 80        TEST word ptr [0xa285],0x8000
// 1000:2ab6      b5 03                    MOV CH,0x3
// 1000:2ab8      75 02                    JNZ 0x1000:2abc
// 1000:2aba      b5 05                    MOV CH,0x5
// 1000:2abc  LAB_1000_2abc:
// 1000:2abc      eb 53                    JMP 0x1000:2b11
// 1000:2abe  LAB_1000_2abe:
// 1000:2abe      3d 0f 00                 CMP AX,0xf
// 1000:2ac1      77 24                    JA 0x1000:2ae7
// 1000:2ac3      f7 06 83 a2 00 80        TEST word ptr [0xa283],0x8000
// 1000:2ac9      75 0e                    JNZ 0x1000:2ad9
// 1000:2acb      f7 06 85 a2 00 80        TEST word ptr [0xa285],0x8000
// 1000:2ad1      b5 0e                    MOV CH,0xe
// 1000:2ad3      75 10                    JNZ 0x1000:2ae5
// 1000:2ad5      b5 0a                    MOV CH,0xa
// 1000:2ad7      eb 0c                    JMP 0x1000:2ae5
// 1000:2ad9  LAB_1000_2ad9:
// 1000:2ad9      f7 06 85 a2 00 80        TEST word ptr [0xa285],0x8000
// 1000:2adf      b5 02                    MOV CH,0x2
// 1000:2ae1      75 02                    JNZ 0x1000:2ae5
// 1000:2ae3      b5 06                    MOV CH,0x6
// 1000:2ae5  LAB_1000_2ae5:
// 1000:2ae5      eb 2a                    JMP 0x1000:2b11
// 1000:2ae7  LAB_1000_2ae7:
// 1000:2ae7      3d 32 00                 CMP AX,0x32
// 1000:2aea      72 03                    JC 0x1000:2aef
// 1000:2aec      e9 78 ff                 JMP 0x1000:2a67
// 1000:2aef  LAB_1000_2aef:
// 1000:2aef      f7 06 83 a2 00 80        TEST word ptr [0xa283],0x8000
// 1000:2af5      75 0e                    JNZ 0x1000:2b05
// 1000:2af7      f7 06 85 a2 00 80        TEST word ptr [0xa285],0x8000
// 1000:2afd      b5 0f                    MOV CH,0xf
// 1000:2aff      75 10                    JNZ 0x1000:2b11
// 1000:2b01      b5 09                    MOV CH,0x9
// 1000:2b03      eb 0c                    JMP 0x1000:2b11
// 1000:2b05  LAB_1000_2b05:
// 1000:2b05      f7 06 85 a2 00 80        TEST word ptr [0xa285],0x8000
// 1000:2b0b      b5 01                    MOV CH,0x1
// 1000:2b0d      75 02                    JNZ 0x1000:2b11
// 1000:2b0f      b5 07                    MOV CH,0x7
// 1000:2b11  LAB_1000_2b11:
// 1000:2b11      b1 00                    MOV CL,0x0
// 1000:2b13      a1 87 a2                 MOV AX,[0xa287]
// 1000:2b16      3b 06 89 a2              CMP AX,word ptr [0xa289]
// 1000:2b1a      77 03                    JA 0x1000:2b1f
// 1000:2b1c      a1 89 a2                 MOV AX,[0xa289]
// 1000:2b1f  LAB_1000_2b1f:
// 1000:2b1f      84 e4                    TEST AH,AH
// 1000:2b21      74 06                    JZ 0x1000:2b29
// 1000:2b23      fe c1                    INC CL
// 1000:2b25      d1 e8                    SHR AX,0x1
// 1000:2b27      eb f6                    JMP 0x1000:2b1f
// 1000:2b29  LAB_1000_2b29:
// 1000:2b29      e8 ee f8                 CALL 0x1000:241a
// 1000:2b2c      3d ff ff                 CMP AX,0xffff
// 1000:2b2f      75 04                    JNZ 0x1000:2b35
// 1000:2b31      fe c1                    INC CL
// 1000:2b33      eb f4                    JMP 0x1000:2b29
// 1000:2b35  LAB_1000_2b35:
// 1000:2b35      c3                       RET
fun_2a26 :: proc() {
}

// 1000:2b36 short_delta is in ship.odin.

// 1000:2b52 abs_word is in ship.odin.

// @proc 1000:2b5b
// listing: FUN_1000_2b5b
// status: unread
// 1000:2b5b  FUN_1000_2b5b:
// 1000:2b5b      e8 c0 00                 CALL 0x1000:2c1e
// 1000:2b5e      e8 92 03                 CALL 0x1000:2ef3
// 1000:2b61      e8 9e 02                 CALL 0x1000:2e02
// 1000:2b64      e8 fe 03                 CALL 0x1000:2f65
// 1000:2b67      e8 86 06                 CALL 0x1000:31f0
// 1000:2b6a      e8 7f 05                 CALL 0x1000:30ec
// 1000:2b6d      e8 37 00                 CALL 0x1000:2ba7
// 1000:2b70      e8 42 0b                 CALL 0x1000:36b5
// 1000:2b73      c3                       RET
fun_2b5b :: proc() {
}

// 1000:2b74 clear_frame_scratch is in ship.odin.

// @proc 1000:2ba7
// listing: FUN_1000_2ba7
// status: unread
// 1000:2ba7  FUN_1000_2ba7:
// 1000:2ba7      be 14 90                 MOV SI,0x9014
// 1000:2baa      b9 04 00                 MOV CX,0x4
// 1000:2bad  LAB_1000_2bad:
// 1000:2bad      51                       PUSH CX
// 1000:2bae      bf 64 8c                 MOV DI,0x8c64
// 1000:2bb1      b9 10 00                 MOV CX,0x10
// 1000:2bb4  LAB_1000_2bb4:
// 1000:2bb4      f6 05 80                 TEST byte ptr [DI],0x80
// 1000:2bb7      74 23                    JZ 0x1000:2bdc
// 1000:2bb9      8a 45 18                 MOV AL,byte ptr [DI + 0x18]
// 1000:2bbc      3a 44 0c                 CMP AL,byte ptr [SI + 0xc]
// 1000:2bbf      74 1b                    JZ 0x1000:2bdc
// 1000:2bc1      f6 45 19 ff              TEST byte ptr [DI + 0x19],0xff
// 1000:2bc5      74 15                    JZ 0x1000:2bdc
// 1000:2bc7      80 7c 0d 00              CMP byte ptr [SI + 0xd],0x0
// 1000:2bcb      74 0f                    JZ 0x1000:2bdc
// 1000:2bcd      57                       PUSH DI
// 1000:2bce      51                       PUSH CX
// 1000:2bcf      83 c7 19                 ADD DI,0x19
// 1000:2bd2      b1 01                    MOV CL,0x1
// 1000:2bd4      e8 ed f7                 CALL 0x1000:23c4
// 1000:2bd7      59                       POP CX
// 1000:2bd8      5f                       POP DI
// 1000:2bd9      e8 0c 00                 CALL 0x1000:2be8
// 1000:2bdc  LAB_1000_2bdc:
// 1000:2bdc      83 c7 3b                 ADD DI,0x3b
// 1000:2bdf      e2 d3                    LOOP 0x1000:2bb4
// 1000:2be1      59                       POP CX
// 1000:2be2      83 c6 0e                 ADD SI,0xe
// 1000:2be5      e2 c6                    LOOP 0x1000:2bad
// 1000:2be7      c3                       RET
fun_2ba7 :: proc() {
}

// @proc 1000:2be8
// listing: FUN_1000_2be8
// status: unread
// 1000:2be8  FUN_1000_2be8:
// 1000:2be8      3d a0 00                 CMP AX,0xa0
// 1000:2beb      77 30                    JA 0x1000:2c1d
// 1000:2bed      80 0c 80                 OR byte ptr [SI],0x80
// 1000:2bf0      80 7d 19 04              CMP byte ptr [DI + 0x19],0x4
// 1000:2bf4      72 27                    JC 0x1000:2c1d
// 1000:2bf6      a0 6f a2                 MOV AL,[0xa26f]
// 1000:2bf9      3a 44 0b                 CMP AL,byte ptr [SI + 0xb]
// 1000:2bfc      75 06                    JNZ 0x1000:2c04
// 1000:2bfe      c7 06 62 a2 ee 00        MOV word ptr [0xa262],0xee
// 1000:2c04  LAB_1000_2c04:
// 1000:2c04      8a 5d 17                 MOV BL,byte ptr [DI + 0x17]
// 1000:2c07      b8 88 13                 MOV AX,0x1388
// 1000:2c0a      e8 c7 02                 CALL 0x1000:2ed4
// 1000:2c0d      c6 45 19 03              MOV byte ptr [DI + 0x19],0x3
// 1000:2c11      81 6c 08 f4 01           SUB word ptr [SI + 0x8],0x1f4
// 1000:2c16      79 05                    JNS 0x1000:2c1d
// 1000:2c18      c7 44 08 00 00           MOV word ptr [SI + 0x8],0x0
// 1000:2c1d  LAB_1000_2c1d:
// 1000:2c1d      c3                       RET
fun_2be8 :: proc() {
}

// @proc 1000:2c1e
// listing: FUN_1000_2c1e
// status: unread
// 1000:2c1e  FUN_1000_2c1e:
// 1000:2c1e      bf 64 8c                 MOV DI,0x8c64
// 1000:2c21      b9 10 00                 MOV CX,0x10
// 1000:2c24  LAB_1000_2c24:
// 1000:2c24      f6 05 ff                 TEST byte ptr [DI],0xff
// 1000:2c27      74 3e                    JZ 0x1000:2c67
// 1000:2c29      80 25 fb                 AND byte ptr [DI],0xfb
// 1000:2c2c      51                       PUSH CX
// 1000:2c2d      be 14 90                 MOV SI,0x9014
// 1000:2c30      b9 04 00                 MOV CX,0x4
// 1000:2c33  LAB_1000_2c33:
// 1000:2c33      80 7c 0d 00              CMP byte ptr [SI + 0xd],0x0
// 1000:2c37      74 1d                    JZ 0x1000:2c56
// 1000:2c39      51                       PUSH CX
// 1000:2c3a      8a 4d 18                 MOV CL,byte ptr [DI + 0x18]
// 1000:2c3d      3a 4c 0c                 CMP CL,byte ptr [SI + 0xc]
// 1000:2c40      74 0b                    JZ 0x1000:2c4d
// 1000:2c42      b1 04                    MOV CL,0x4
// 1000:2c44      e8 7d f7                 CALL 0x1000:23c4
// 1000:2c47      e8 23 00                 CALL 0x1000:2c6d
// 1000:2c4a      eb 09                    JMP 0x1000:2c55
// 1000:2c4d  LAB_1000_2c4d:
// 1000:2c4d      b1 00                    MOV CL,0x0
// 1000:2c4f      e8 72 f7                 CALL 0x1000:23c4
// 1000:2c52      e8 a5 00                 CALL 0x1000:2cfa
// 1000:2c55  LAB_1000_2c55:
// 1000:2c55      59                       POP CX
// 1000:2c56  LAB_1000_2c56:
// 1000:2c56      83 c6 0e                 ADD SI,0xe
// 1000:2c59      e2 d8                    LOOP 0x1000:2c33
// 1000:2c5b      8a 05                    MOV AL,byte ptr [DI]
// 1000:2c5d      24 84                    AND AL,0x84
// 1000:2c5f      3c 84                    CMP AL,0x84
// 1000:2c61      74 03                    JZ 0x1000:2c66
// 1000:2c63      80 25 bf                 AND byte ptr [DI],0xbf
// 1000:2c66  LAB_1000_2c66:
// 1000:2c66      59                       POP CX
// 1000:2c67  LAB_1000_2c67:
// 1000:2c67      83 c7 3b                 ADD DI,0x3b
// 1000:2c6a      e2 b8                    LOOP 0x1000:2c24
// 1000:2c6c      c3                       RET
fun_2c1e :: proc() {
}

// @proc 1000:2c6d
// listing: FUN_1000_2c6d
// status: unread
// 1000:2c6d  FUN_1000_2c6d:
// 1000:2c6d      3d d0 07                 CMP AX,0x7d0
// 1000:2c70      72 02                    JC 0x1000:2c74
// 1000:2c72      f8                       CLC
// 1000:2c73      c3                       RET
// 1000:2c74  LAB_1000_2c74:
// 1000:2c74      80 3d 0c                 CMP byte ptr [DI],0xc
// 1000:2c77      77 2f                    JA 0x1000:2ca8
// 1000:2c79      3d e8 03                 CMP AX,0x3e8
// 1000:2c7c      77 7a                    JA 0x1000:2cf8
// 1000:2c7e      8a 1d                    MOV BL,byte ptr [DI]
// 1000:2c80      32 ff                    XOR BH,BH
// 1000:2c82      83 eb 02                 SUB BX,0x2
// 1000:2c85      72 71                    JC 0x1000:2cf8
// 1000:2c87      d1 e3                    SHL BX,0x1
// 1000:2c89      d1 e3                    SHL BX,0x1
// 1000:2c8b      d1 e3                    SHL BX,0x1
// 1000:2c8d      3d 2c 01                 CMP AX,0x12c
// 1000:2c90      72 09                    JC 0x1000:2c9b
// 1000:2c92      d1 eb                    SHR BX,0x1
// 1000:2c94      3d f4 01                 CMP AX,0x1f4
// 1000:2c97      72 02                    JC 0x1000:2c9b
// 1000:2c99      d1 eb                    SHR BX,0x1
// 1000:2c9b  LAB_1000_2c9b:
// 1000:2c9b      29 5c 08                 SUB word ptr [SI + 0x8],BX
// 1000:2c9e      79 58                    JNS 0x1000:2cf8
// 1000:2ca0      c7 44 08 00 00           MOV word ptr [SI + 0x8],0x0
// 1000:2ca5      eb 51                    JMP 0x1000:2cf8
// 1000:2ca8  LAB_1000_2ca8:
// 1000:2ca8      80 4d 16 01              OR byte ptr [DI + 0x16],0x1
// 1000:2cac      80 0c 01                 OR byte ptr [SI],0x1
// 1000:2caf      3d dc 05                 CMP AX,0x5dc
// 1000:2cb2      77 44                    JA 0x1000:2cf8
// 1000:2cb4      80 0c 02                 OR byte ptr [SI],0x2
// 1000:2cb7      3d ee 02                 CMP AX,0x2ee
// 1000:2cba      77 3c                    JA 0x1000:2cf8
// 1000:2cbc      80 0c 04                 OR byte ptr [SI],0x4
// 1000:2cbf      3d fa 00                 CMP AX,0xfa
// 1000:2cc2      73 34                    JNC 0x1000:2cf8
// 1000:2cc4      bb 2c 01                 MOV BX,0x12c
// 1000:2cc7      2b d8                    SUB BX,AX
// 1000:2cc9      8b c3                    MOV AX,BX
// 1000:2ccb      d1 e0                    SHL AX,0x1
// 1000:2ccd      80 7c 0d 04              CMP byte ptr [SI + 0xd],0x4
// 1000:2cd1      74 02                    JZ 0x1000:2cd5
// 1000:2cd3      d1 e0                    SHL AX,0x1
// 1000:2cd5  LAB_1000_2cd5:
// 1000:2cd5      3d 96 00                 CMP AX,0x96
// 1000:2cd8      72 1b                    JC 0x1000:2cf5
// 1000:2cda      c6 45 15 10              MOV byte ptr [DI + 0x15],0x10
// 1000:2cde      8a 5d 17                 MOV BL,byte ptr [DI + 0x17]
// 1000:2ce1      b8 e8 03                 MOV AX,0x3e8
// 1000:2ce4      e8 ed 01                 CALL 0x1000:2ed4
// 1000:2ce7      b8 f4 01                 MOV AX,0x1f4
// 1000:2cea      83 6c 08 64              SUB word ptr [SI + 0x8],0x64
// 1000:2cee      79 05                    JNS 0x1000:2cf5
// 1000:2cf0      c7 44 08 00 00           MOV word ptr [SI + 0x8],0x0
// 1000:2cf5  LAB_1000_2cf5:
// 1000:2cf5      e8 83 f6                 CALL 0x1000:237b
// 1000:2cf8  LAB_1000_2cf8:
// 1000:2cf8      f9                       STC
// 1000:2cf9      c3                       RET
fun_2c6d :: proc() {
}

// @proc 1000:2cfa
// listing: FUN_1000_2cfa
// status: unread
// 1000:2cfa  FUN_1000_2cfa:
// 1000:2cfa      f6 05 80                 TEST byte ptr [DI],0x80
// 1000:2cfd      74 6f                    JZ 0x1000:2d6e
// 1000:2cff      80 7c 0d 04              CMP byte ptr [SI + 0xd],0x4
// 1000:2d03      74 0d                    JZ 0x1000:2d12
// 1000:2d05      3d fa 00                 CMP AX,0xfa
// 1000:2d08      77 64                    JA 0x1000:2d6e
// 1000:2d0a      c7 45 0c 50 c3           MOV word ptr [DI + 0xc],0xc350
// 1000:2d0f      eb 5d                    JMP 0x1000:2d6e
// 1000:2d12  LAB_1000_2d12:
// 1000:2d12      3d a0 00                 CMP AX,0xa0
// 1000:2d15      77 57                    JA 0x1000:2d6e
// 1000:2d17      83 7d 32 00              CMP word ptr [DI + 0x32],0x0
// 1000:2d1b      74 05                    JZ 0x1000:2d22
// 1000:2d1d      3d 5f 00                 CMP AX,0x5f
// 1000:2d20      77 4c                    JA 0x1000:2d6e
// 1000:2d22  LAB_1000_2d22:
// 1000:2d22      80 0d 04                 OR byte ptr [DI],0x4
// 1000:2d25      8a 55 11                 MOV DL,byte ptr [DI + 0x11]
// 1000:2d28      80 e2 1f                 AND DL,0x1f
// 1000:2d2b      80 fa 04                 CMP DL,0x4
// 1000:2d2e      75 06                    JNZ 0x1000:2d36
// 1000:2d30      b2 00                    MOV DL,0x0
// 1000:2d32      c6 45 11 80              MOV byte ptr [DI + 0x11],0x80
// 1000:2d36  LAB_1000_2d36:
// 1000:2d36      f6 05 40                 TEST byte ptr [DI],0x40
// 1000:2d39      75 27                    JNZ 0x1000:2d62
// 1000:2d3b      3d 3c 00                 CMP AX,0x3c
// 1000:2d3e      72 18                    JC 0x1000:2d58
// 1000:2d40      80 0d 40                 OR byte ptr [DI],0x40
// 1000:2d43      22 d2                    AND DL,DL
// 1000:2d45      75 1b                    JNZ 0x1000:2d62
// 1000:2d47      c6 45 0b 00              MOV byte ptr [DI + 0xb],0x0
// 1000:2d4b      c6 45 11 07              MOV byte ptr [DI + 0x11],0x7
// 1000:2d4f      8a 45 17                 MOV AL,byte ptr [DI + 0x17]
// 1000:2d52      88 45 2b                 MOV byte ptr [DI + 0x2b],AL
// 1000:2d55      eb 0b                    JMP 0x1000:2d62
// 1000:2d58  LAB_1000_2d58:
// 1000:2d58      f6 45 0b ff              TEST byte ptr [DI + 0xb],0xff
// 1000:2d5c      75 04                    JNZ 0x1000:2d62
// 1000:2d5e      c6 45 0b 11              MOV byte ptr [DI + 0xb],0x11
// 1000:2d62  LAB_1000_2d62:
// 1000:2d62      c6 45 0e 00              MOV byte ptr [DI + 0xe],0x0
// 1000:2d66      80 24 7f                 AND byte ptr [SI],0x7f
// 1000:2d69      e8 04 00                 CALL 0x1000:2d70
// 1000:2d6c      f9                       STC
// 1000:2d6d      c3                       RET
// 1000:2d6e  LAB_1000_2d6e:
// 1000:2d6e      f8                       CLC
// 1000:2d6f      c3                       RET
fun_2cfa :: proc() {
}

// @proc 1000:2d70
// listing: FUN_1000_2d70
// status: unread
// 1000:2d70  FUN_1000_2d70:
// 1000:2d70      a0 d2 89                 MOV AL,[0x89d2]
// 1000:2d73      24 07                    AND AL,0x7
// 1000:2d75      75 7e                    JNZ 0x1000:2df5
// 1000:2d77      c6 06 9c a2 00           MOV byte ptr [0xa29c],0x0
// 1000:2d7c      81 7d 08 10 27           CMP word ptr [DI + 0x8],0x2710
// 1000:2d81      77 11                    JA 0x1000:2d94
// 1000:2d83      83 7c 08 64              CMP word ptr [SI + 0x8],0x64
// 1000:2d87      76 0b                    JBE 0x1000:2d94
// 1000:2d89      83 6c 08 32              SUB word ptr [SI + 0x8],0x32
// 1000:2d8d      81 45 08 f4 01           ADD word ptr [DI + 0x8],0x1f4
// 1000:2d92      eb 2b                    JMP 0x1000:2dbf
// 1000:2d94  LAB_1000_2d94:
// 1000:2d94      81 7d 08 98 3a           CMP word ptr [DI + 0x8],0x3a98
// 1000:2d99      72 1f                    JC 0x1000:2dba
// 1000:2d9b      81 7c 08 20 4e           CMP word ptr [SI + 0x8],0x4e20
// 1000:2da0      73 18                    JNC 0x1000:2dba
// 1000:2da2      83 7c 08 19              CMP word ptr [SI + 0x8],0x19
// 1000:2da6      72 12                    JC 0x1000:2dba
// 1000:2da8      83 44 08 64              ADD word ptr [SI + 0x8],0x64
// 1000:2dac      81 6d 08 e8 03           SUB word ptr [DI + 0x8],0x3e8
// 1000:2db1      80 7c 07 63              CMP byte ptr [SI + 0x7],0x63
// 1000:2db5      77 03                    JA 0x1000:2dba
// 1000:2db7      fe 44 07                 INC byte ptr [SI + 0x7]
// 1000:2dba  LAB_1000_2dba:
// 1000:2dba      80 0e 9c a2 01           OR byte ptr [0xa29c],0x1
// 1000:2dbf  LAB_1000_2dbf:
// 1000:2dbf      80 7d 07 0a              CMP byte ptr [DI + 0x7],0xa
// 1000:2dc3      73 0f                    JNC 0x1000:2dd4
// 1000:2dc5      f6 44 07 ff              TEST byte ptr [SI + 0x7],0xff
// 1000:2dc9      74 09                    JZ 0x1000:2dd4
// 1000:2dcb      fe 4c 07                 DEC byte ptr [SI + 0x7]
// 1000:2dce      fe 45 07                 INC byte ptr [DI + 0x7]
// 1000:2dd1      eb 06                    JMP 0x1000:2dd9
// 1000:2dd4  LAB_1000_2dd4:
// 1000:2dd4      80 0e 9c a2 02           OR byte ptr [0xa29c],0x2
// 1000:2dd9  LAB_1000_2dd9:
// 1000:2dd9      f6 06 d2 89 08           TEST byte ptr [0x89d2],0x8
// 1000:2dde      75 1a                    JNZ 0x1000:2dfa
// 1000:2de0      80 7d 06 05              CMP byte ptr [DI + 0x6],0x5
// 1000:2de4      73 0f                    JNC 0x1000:2df5
// 1000:2de6      80 7c 06 00              CMP byte ptr [SI + 0x6],0x0
// 1000:2dea      74 09                    JZ 0x1000:2df5
// 1000:2dec      fe 4c 06                 DEC byte ptr [SI + 0x6]
// 1000:2def      fe 45 06                 INC byte ptr [DI + 0x6]
// 1000:2df2      eb 06                    JMP 0x1000:2dfa
// 1000:2df5  LAB_1000_2df5:
// 1000:2df5      80 0e 9c a2 04           OR byte ptr [0xa29c],0x4
// 1000:2dfa  LAB_1000_2dfa:
// 1000:2dfa      80 3e 9c a2 07           CMP byte ptr [0xa29c],0x7
// 1000:2dff      75 00                    JNZ 0x1000:2e01
// 1000:2e01  LAB_1000_2e01:
// 1000:2e01      c3                       RET
fun_2d70 :: proc() {
}

// @proc 1000:2e02
// listing: FUN_1000_2e02
// status: unread
// 1000:2e02  FUN_1000_2e02:
// 1000:2e02      be 64 8c                 MOV SI,0x8c64
// 1000:2e05      b9 10 00                 MOV CX,0x10
// 1000:2e08  LAB_1000_2e08:
// 1000:2e08      f6 44 19 ff              TEST byte ptr [SI + 0x19],0xff
// 1000:2e0c      74 29                    JZ 0x1000:2e37
// 1000:2e0e      bf 64 8c                 MOV DI,0x8c64
// 1000:2e11      51                       PUSH CX
// 1000:2e12      b9 10 00                 MOV CX,0x10
// 1000:2e15  LAB_1000_2e15:
// 1000:2e15      f6 05 80                 TEST byte ptr [DI],0x80
// 1000:2e18      74 17                    JZ 0x1000:2e31
// 1000:2e1a      3b f7                    CMP SI,DI
// 1000:2e1c      74 13                    JZ 0x1000:2e31
// 1000:2e1e      80 7d 34 00              CMP byte ptr [DI + 0x34],0x0
// 1000:2e22      74 08                    JZ 0x1000:2e2c
// 1000:2e24      8a 45 18                 MOV AL,byte ptr [DI + 0x18]
// 1000:2e27      3a 44 18                 CMP AL,byte ptr [SI + 0x18]
// 1000:2e2a      74 05                    JZ 0x1000:2e31
// 1000:2e2c  LAB_1000_2e2c:
// 1000:2e2c      51                       PUSH CX
// 1000:2e2d      e8 0d 00                 CALL 0x1000:2e3d
// 1000:2e30      59                       POP CX
// 1000:2e31  LAB_1000_2e31:
// 1000:2e31      83 c7 3b                 ADD DI,0x3b
// 1000:2e34      e2 df                    LOOP 0x1000:2e15
// 1000:2e36      59                       POP CX
// 1000:2e37  LAB_1000_2e37:
// 1000:2e37      83 c6 3b                 ADD SI,0x3b
// 1000:2e3a      e2 cc                    LOOP 0x1000:2e08
// 1000:2e3c      c3                       RET
fun_2e02 :: proc() {
}

// @proc 1000:2e3d
// listing: FUN_1000_2e3d
// status: unread
// 1000:2e3d  FUN_1000_2e3d:
// 1000:2e3d      f6 05 44                 TEST byte ptr [DI],0x44
// 1000:2e40      74 09                    JZ 0x1000:2e4b
// 1000:2e42      8a 45 18                 MOV AL,byte ptr [DI + 0x18]
// 1000:2e45      3a 44 18                 CMP AL,byte ptr [SI + 0x18]
// 1000:2e48      75 01                    JNZ 0x1000:2e4b
// 1000:2e4a      c3                       RET
// 1000:2e4b  LAB_1000_2e4b:
// 1000:2e4b      56                       PUSH SI
// 1000:2e4c      83 c6 19                 ADD SI,0x19
// 1000:2e4f      b1 02                    MOV CL,0x2
// 1000:2e51      e8 70 f5                 CALL 0x1000:23c4
// 1000:2e54      5e                       POP SI
// 1000:2e55      f6 44 19 80              TEST byte ptr [SI + 0x19],0x80
// 1000:2e59      74 31                    JZ 0x1000:2e8c
// 1000:2e5b      3d 58 02                 CMP AX,0x258
// 1000:2e5e      77 73                    JA 0x1000:2ed3
// 1000:2e60      80 4d 16 20              OR byte ptr [DI + 0x16],0x20
// 1000:2e64      3d c2 01                 CMP AX,0x1c2
// 1000:2e67      77 6a                    JA 0x1000:2ed3
// 1000:2e69      ba ea 01                 MOV DX,0x1ea
// 1000:2e6c      2b d0                    SUB DX,AX
// 1000:2e6e      8b c2                    MOV AX,DX
// 1000:2e70      d1 e0                    SHL AX,0x1
// 1000:2e72      03 d0                    ADD DX,AX
// 1000:2e74      03 d0                    ADD DX,AX
// 1000:2e76      f6 44 19 40              TEST byte ptr [SI + 0x19],0x40
// 1000:2e7a      74 05                    JZ 0x1000:2e81
// 1000:2e7c      03 d0                    ADD DX,AX
// 1000:2e7e      83 c2 19                 ADD DX,0x19
// 1000:2e81  LAB_1000_2e81:
// 1000:2e81      8a 44 19                 MOV AL,byte ptr [SI + 0x19]
// 1000:2e84      24 0f                    AND AL,0xf
// 1000:2e86      2c 04                    SUB AL,0x4
// 1000:2e88      78 49                    JS 0x1000:2ed3
// 1000:2e8a      eb 3c                    JMP 0x1000:2ec8
// 1000:2e8c  LAB_1000_2e8c:
// 1000:2e8c      3d 58 02                 CMP AX,0x258
// 1000:2e8f      77 42                    JA 0x1000:2ed3
// 1000:2e91      8a 55 18                 MOV DL,byte ptr [DI + 0x18]
// 1000:2e94      3a 54 18                 CMP DL,byte ptr [SI + 0x18]
// 1000:2e97      74 04                    JZ 0x1000:2e9d
// 1000:2e99      80 4d 16 02              OR byte ptr [DI + 0x16],0x2
// 1000:2e9d  LAB_1000_2e9d:
// 1000:2e9d      3d 8c 00                 CMP AX,0x8c
// 1000:2ea0      77 31                    JA 0x1000:2ed3
// 1000:2ea2      ba c8 00                 MOV DX,0xc8
// 1000:2ea5      2b d0                    SUB DX,AX
// 1000:2ea7      d1 e2                    SHL DX,0x1
// 1000:2ea9      d1 e2                    SHL DX,0x1
// 1000:2eab      d1 e2                    SHL DX,0x1
// 1000:2ead      81 c2 96 00              ADD DX,0x96
// 1000:2eb1      8a 44 19                 MOV AL,byte ptr [SI + 0x19]
// 1000:2eb4      3c 04                    CMP AL,0x4
// 1000:2eb6      72 0c                    JC 0x1000:2ec4
// 1000:2eb8      f6 05 44                 TEST byte ptr [DI],0x44
// 1000:2ebb      75 16                    JNZ 0x1000:2ed3
// 1000:2ebd      c6 44 19 03              MOV byte ptr [SI + 0x19],0x3
// 1000:2ec1      ba 41 00                 MOV DX,0x41
// 1000:2ec4  LAB_1000_2ec4:
// 1000:2ec4      f7 e2                    MUL DX
// 1000:2ec6      8b d0                    MOV DX,AX
// 1000:2ec8  LAB_1000_2ec8:
// 1000:2ec8      8b c2                    MOV AX,DX
// 1000:2eca      e8 ae f4                 CALL 0x1000:237b
// 1000:2ecd      8a 5c 17                 MOV BL,byte ptr [SI + 0x17]
// 1000:2ed0      e8 01 00                 CALL 0x1000:2ed4
// 1000:2ed3  LAB_1000_2ed3:
// 1000:2ed3      c3                       RET
fun_2e3d :: proc() {
}

// 1000:2ed4 add_score_div100 is in ship.odin.

// @proc 1000:2ef3
// listing: FUN_1000_2ef3
// status: unread
// 1000:2ef3  FUN_1000_2ef3:
// 1000:2ef3      be 64 8c                 MOV SI,0x8c64
// 1000:2ef6      bf 50 8d                 MOV DI,0x8d50
// 1000:2ef9      b9 0c 00                 MOV CX,0xc
// 1000:2efc  LAB_1000_2efc:
// 1000:2efc      51                       PUSH CX
// 1000:2efd      57                       PUSH DI
// 1000:2efe      56                       PUSH SI
// 1000:2eff  LAB_1000_2eff:
// 1000:2eff      51                       PUSH CX
// 1000:2f00      56                       PUSH SI
// 1000:2f01      b9 04 00                 MOV CX,0x4
// 1000:2f04  LAB_1000_2f04:
// 1000:2f04      e8 1d 00                 CALL 0x1000:2f24
// 1000:2f07      83 c6 3b                 ADD SI,0x3b
// 1000:2f0a      e2 f8                    LOOP 0x1000:2f04
// 1000:2f0c      5e                       POP SI
// 1000:2f0d      59                       POP CX
// 1000:2f0e      83 c7 3b                 ADD DI,0x3b
// 1000:2f11      e2 ec                    LOOP 0x1000:2eff
// 1000:2f13      5e                       POP SI
// 1000:2f14      5f                       POP DI
// 1000:2f15      59                       POP CX
// 1000:2f16      81 c6 ec 00              ADD SI,0xec
// 1000:2f1a      81 c7 ec 00              ADD DI,0xec
// 1000:2f1e      83 e9 04                 SUB CX,0x4
// 1000:2f21      75 d9                    JNZ 0x1000:2efc
// 1000:2f23      c3                       RET
fun_2ef3 :: proc() {
}

// @proc 1000:2f24
// listing: FUN_1000_2f24
// status: unread
// 1000:2f24  FUN_1000_2f24:
// 1000:2f24      8a 44 19                 MOV AL,byte ptr [SI + 0x19]
// 1000:2f27      3c 03                    CMP AL,0x3
// 1000:2f29      72 39                    JC 0x1000:2f64
// 1000:2f2b      3c 80                    CMP AL,0x80
// 1000:2f2d      73 35                    JNC 0x1000:2f64
// 1000:2f2f      8a 45 19                 MOV AL,byte ptr [DI + 0x19]
// 1000:2f32      3c 03                    CMP AL,0x3
// 1000:2f34      72 2e                    JC 0x1000:2f64
// 1000:2f36      3c 80                    CMP AL,0x80
// 1000:2f38      73 2a                    JNC 0x1000:2f64
// 1000:2f3a      51                       PUSH CX
// 1000:2f3b      56                       PUSH SI
// 1000:2f3c      57                       PUSH DI
// 1000:2f3d      83 c6 19                 ADD SI,0x19
// 1000:2f40      83 c7 19                 ADD DI,0x19
// 1000:2f43      b1 01                    MOV CL,0x1
// 1000:2f45      e8 7c f4                 CALL 0x1000:23c4
// 1000:2f48      5f                       POP DI
// 1000:2f49      5e                       POP SI
// 1000:2f4a      59                       POP CX
// 1000:2f4b      3d 5a 00                 CMP AX,0x5a
// 1000:2f4e      77 14                    JA 0x1000:2f64
// 1000:2f50      80 7c 19 04              CMP byte ptr [SI + 0x19],0x4
// 1000:2f54      72 04                    JC 0x1000:2f5a
// 1000:2f56      c6 44 19 03              MOV byte ptr [SI + 0x19],0x3
// 1000:2f5a  LAB_1000_2f5a:
// 1000:2f5a      80 7d 19 04              CMP byte ptr [DI + 0x19],0x4
// 1000:2f5e      72 04                    JC 0x1000:2f64
// 1000:2f60      c6 45 19 03              MOV byte ptr [DI + 0x19],0x3
// 1000:2f64  LAB_1000_2f64:
// 1000:2f64      c3                       RET
fun_2f24 :: proc() {
}

// @proc 1000:2f65
// listing: FUN_1000_2f65
// status: unread
// 1000:2f65  FUN_1000_2f65:
// 1000:2f65      be 64 8c                 MOV SI,0x8c64
// 1000:2f68      bf 50 8d                 MOV DI,0x8d50
// 1000:2f6b      b9 0c 00                 MOV CX,0xc
// 1000:2f6e  LAB_1000_2f6e:
// 1000:2f6e      51                       PUSH CX
// 1000:2f6f      57                       PUSH DI
// 1000:2f70      56                       PUSH SI
// 1000:2f71  LAB_1000_2f71:
// 1000:2f71      f6 05 ff                 TEST byte ptr [DI],0xff
// 1000:2f74      74 11                    JZ 0x1000:2f87
// 1000:2f76      51                       PUSH CX
// 1000:2f77      56                       PUSH SI
// 1000:2f78      b9 04 00                 MOV CX,0x4
// 1000:2f7b  LAB_1000_2f7b:
// 1000:2f7b      51                       PUSH CX
// 1000:2f7c      e8 1e 00                 CALL 0x1000:2f9d
// 1000:2f7f      59                       POP CX
// 1000:2f80      83 c6 3b                 ADD SI,0x3b
// 1000:2f83      e2 f6                    LOOP 0x1000:2f7b
// 1000:2f85      5e                       POP SI
// 1000:2f86      59                       POP CX
// 1000:2f87  LAB_1000_2f87:
// 1000:2f87      83 c7 3b                 ADD DI,0x3b
// 1000:2f8a      e2 e5                    LOOP 0x1000:2f71
// 1000:2f8c      5e                       POP SI
// 1000:2f8d      5f                       POP DI
// 1000:2f8e      59                       POP CX
// 1000:2f8f      81 c6 ec 00              ADD SI,0xec
// 1000:2f93      81 c7 ec 00              ADD DI,0xec
// 1000:2f97      83 e9 04                 SUB CX,0x4
// 1000:2f9a      75 d2                    JNZ 0x1000:2f6e
// 1000:2f9c      c3                       RET
fun_2f65 :: proc() {
}

// @proc 1000:2f9d
// listing: FUN_1000_2f9d
// status: unread
// 1000:2f9d  FUN_1000_2f9d:
// 1000:2f9d      f6 04 ff                 TEST byte ptr [SI],0xff
// 1000:2fa0      75 01                    JNZ 0x1000:2fa3
// 1000:2fa2  LAB_1000_2fa2:
// 1000:2fa2      c3                       RET
// 1000:2fa3  LAB_1000_2fa3:
// 1000:2fa3      51                       PUSH CX
// 1000:2fa4      b1 03                    MOV CL,0x3
// 1000:2fa6      e8 1b f4                 CALL 0x1000:23c4
// 1000:2fa9      59                       POP CX
// 1000:2faa      3d d0 07                 CMP AX,0x7d0
// 1000:2fad      77 f3                    JA 0x1000:2fa2
// 1000:2faf      8a 5d 18                 MOV BL,byte ptr [DI + 0x18]
// 1000:2fb2      3a 5c 18                 CMP BL,byte ptr [SI + 0x18]
// 1000:2fb5      75 27                    JNZ 0x1000:2fde
// 1000:2fb7      3d 2c 01                 CMP AX,0x12c
// 1000:2fba      77 e6                    JA 0x1000:2fa2
// 1000:2fbc      80 fb 20                 CMP BL,0x20
// 1000:2fbf      75 e1                    JNZ 0x1000:2fa2
// 1000:2fc1      f6 05 44                 TEST byte ptr [DI],0x44
// 1000:2fc4      75 dc                    JNZ 0x1000:2fa2
// 1000:2fc6      c6 45 15 02              MOV byte ptr [DI + 0x15],0x2
// 1000:2fca      c6 44 15 02              MOV byte ptr [SI + 0x15],0x2
// 1000:2fce      8a 45 0b                 MOV AL,byte ptr [DI + 0xb]
// 1000:2fd1      24 0f                    AND AL,0xf
// 1000:2fd3      3c 06                    CMP AL,0x6
// 1000:2fd5      76 cb                    JBE 0x1000:2fa2
// 1000:2fd7      fe 4d 0b                 DEC byte ptr [DI + 0xb]
// 1000:2fda      fe 4d 0b                 DEC byte ptr [DI + 0xb]
// 1000:2fdd      c3                       RET
// 1000:2fde  LAB_1000_2fde:
// 1000:2fde      50                       PUSH AX
// 1000:2fdf      e8 84 00                 CALL 0x1000:3066
// 1000:2fe2      ba d0 07                 MOV DX,0x7d0
// 1000:2fe5      81 7d 08 40 9c           CMP word ptr [DI + 0x8],0x9c40
// 1000:2fea      77 0d                    JA 0x1000:2ff9
// 1000:2fec      f6 44 19 f0              TEST byte ptr [SI + 0x19],0xf0
// 1000:2ff0      75 07                    JNZ 0x1000:2ff9
// 1000:2ff2      f6 04 10                 TEST byte ptr [SI],0x10
// 1000:2ff5      74 02                    JZ 0x1000:2ff9
// 1000:2ff7      d1 ea                    SHR DX,0x1
// 1000:2ff9  LAB_1000_2ff9:
// 1000:2ff9      3b c2                    CMP AX,DX
// 1000:2ffb      77 26                    JA 0x1000:3023
// 1000:2ffd      80 4d 16 40              OR byte ptr [DI + 0x16],0x40
// 1000:3001      8a 1d                    MOV BL,byte ptr [DI]
// 1000:3003      80 e3 fc                 AND BL,0xfc
// 1000:3006      79 1b                    JNS 0x1000:3023
// 1000:3008      80 cb 01                 OR BL,0x1
// 1000:300b      d1 ea                    SHR DX,0x1
// 1000:300d      3b c2                    CMP AX,DX
// 1000:300f      77 0a                    JA 0x1000:301b
// 1000:3011      fe c3                    INC BL
// 1000:3013      d1 ea                    SHR DX,0x1
// 1000:3015      3b c2                    CMP AX,DX
// 1000:3017      77 02                    JA 0x1000:301b
// 1000:3019      fe c3                    INC BL
// 1000:301b  LAB_1000_301b:
// 1000:301b      8a 05                    MOV AL,byte ptr [DI]
// 1000:301d      3a c3                    CMP AL,BL
// 1000:301f      73 02                    JNC 0x1000:3023
// 1000:3021      88 1d                    MOV byte ptr [DI],BL
// 1000:3023  LAB_1000_3023:
// 1000:3023      58                       POP AX
// 1000:3024      ba d0 07                 MOV DX,0x7d0
// 1000:3027      81 7c 08 40 9c           CMP word ptr [SI + 0x8],0x9c40
// 1000:302c      77 0d                    JA 0x1000:303b
// 1000:302e      f6 45 19 f0              TEST byte ptr [DI + 0x19],0xf0
// 1000:3032      75 07                    JNZ 0x1000:303b
// 1000:3034      f6 05 10                 TEST byte ptr [DI],0x10
// 1000:3037      74 02                    JZ 0x1000:303b
// 1000:3039      d1 ea                    SHR DX,0x1
// 1000:303b  LAB_1000_303b:
// 1000:303b      3b c2                    CMP AX,DX
// 1000:303d      77 26                    JA 0x1000:3065
// 1000:303f      80 4c 16 40              OR byte ptr [SI + 0x16],0x40
// 1000:3043      8a 1c                    MOV BL,byte ptr [SI]
// 1000:3045      80 e3 fc                 AND BL,0xfc
// 1000:3048      79 1b                    JNS 0x1000:3065
// 1000:304a      80 cb 01                 OR BL,0x1
// 1000:304d      d1 ea                    SHR DX,0x1
// 1000:304f      3b c2                    CMP AX,DX
// 1000:3051      77 0a                    JA 0x1000:305d
// 1000:3053      fe c3                    INC BL
// 1000:3055      d1 ea                    SHR DX,0x1
// 1000:3057      3b c2                    CMP AX,DX
// 1000:3059      77 02                    JA 0x1000:305d
// 1000:305b      fe c3                    INC BL
// 1000:305d  LAB_1000_305d:
// 1000:305d      8a 04                    MOV AL,byte ptr [SI]
// 1000:305f      3a c3                    CMP AL,BL
// 1000:3061      73 02                    JNC 0x1000:3065
// 1000:3063      88 1c                    MOV byte ptr [SI],BL
// 1000:3065  LAB_1000_3065:
// 1000:3065      c3                       RET
fun_2f9d :: proc() {
}

