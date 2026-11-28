package trek

// Procedures 1000:3066 through 1000:3fc1.
// The assembly is the listing. The body is empty until the procedure is translated.
// A notes line is a name already supported by the annotation notes.

// @proc 1000:3066
// listing: FUN_1000_3066
// status: unread
// 1000:3066  FUN_1000_3066:
// 1000:3066      50                       PUSH AX
// 1000:3067      05 02 00                 ADD AX,0x2
// 1000:306a      3d c4 09                 CMP AX,0x9c4
// 1000:306d      77 33                    JA 0x1000:30a2
// 1000:306f      e8 32 00                 CALL 0x1000:30a4
// 1000:3072      87 f7                    XCHG DI,SI
// 1000:3074      e8 2d 00                 CALL 0x1000:30a4
// 1000:3077      87 f7                    XCHG DI,SI
// 1000:3079      3d 78 00                 CMP AX,0x78
// 1000:307c      77 24                    JA 0x1000:30a2
// 1000:307e      80 45 15 02              ADD byte ptr [DI + 0x15],0x2
// 1000:3082      80 44 15 02              ADD byte ptr [SI + 0x15],0x2
// 1000:3086      8b 45 08                 MOV AX,word ptr [DI + 0x8]
// 1000:3089      d1 e8                    SHR AX,0x1
// 1000:308b      d1 e8                    SHR AX,0x1
// 1000:308d      d1 e8                    SHR AX,0x1
// 1000:308f      e8 e9 f2                 CALL 0x1000:237b
// 1000:3092      87 f7                    XCHG DI,SI
// 1000:3094      8b 45 08                 MOV AX,word ptr [DI + 0x8]
// 1000:3097      d1 e8                    SHR AX,0x1
// 1000:3099      d1 e8                    SHR AX,0x1
// 1000:309b      d1 e8                    SHR AX,0x1
// 1000:309d      e8 db f2                 CALL 0x1000:237b
// 1000:30a0      87 f7                    XCHG DI,SI
// 1000:30a2  LAB_1000_30a2:
// 1000:30a2      58                       POP AX
// 1000:30a3      c3                       RET
fun_3066 :: proc() {
}

// @proc 1000:30a4
// listing: FUN_1000_30a4
// status: unread
// 1000:30a4  FUN_1000_30a4:
// 1000:30a4      8a 1c                    MOV BL,byte ptr [SI]
// 1000:30a6      80 fb 0c                 CMP BL,0xc
// 1000:30a9      77 26                    JA 0x1000:30d1
// 1000:30ab      32 ff                    XOR BH,BH
// 1000:30ad      d1 e3                    SHL BX,0x1
// 1000:30af      2e 8b 8f d2 30           MOV CX,word ptr CS:[BX + 0x30d2]
// 1000:30b4      e3 1b                    JCXZ 0x1000:30d1
// 1000:30b6      52                       PUSH DX
// 1000:30b7      50                       PUSH AX
// 1000:30b8      50                       PUSH AX
// 1000:30b9      bb 32 00                 MOV BX,0x32
// 1000:30bc      f7 e3                    MUL BX
// 1000:30be      e8 af f3                 CALL 0x1000:2470
// 1000:30c1      f7 e1                    MUL CX
// 1000:30c3      5b                       POP BX
// 1000:30c4      f7 f3                    DIV BX
// 1000:30c6      e8 b2 f2                 CALL 0x1000:237b
// 1000:30c9      8a 5c 17                 MOV BL,byte ptr [SI + 0x17]
// 1000:30cc      e8 05 fe                 CALL 0x1000:2ed4
// 1000:30cf      58                       POP AX
// 1000:30d0      5a                       POP DX
// 1000:30d1  LAB_1000_30d1:
// 1000:30d1      c3                       RET
fun_30a4 :: proc() {
}

// @proc 1000:30ec
// listing: FUN_1000_30ec
// status: unread
// 1000:30ec  FUN_1000_30ec:
// 1000:30ec      b9 04 00                 MOV CX,0x4
// 1000:30ef      bf 64 8c                 MOV DI,0x8c64
// 1000:30f2  LAB_1000_30f2:
// 1000:30f2      51                       PUSH CX
// 1000:30f3      b9 04 00                 MOV CX,0x4
// 1000:30f6  LAB_1000_30f6:
// 1000:30f6      f6 05 80                 TEST byte ptr [DI],0x80
// 1000:30f9      74 05                    JZ 0x1000:3100
// 1000:30fb      51                       PUSH CX
// 1000:30fc      e8 0a 00                 CALL 0x1000:3109
// 1000:30ff      59                       POP CX
// 1000:3100  LAB_1000_3100:
// 1000:3100      83 c7 3b                 ADD DI,0x3b
// 1000:3103      e2 f1                    LOOP 0x1000:30f6
// 1000:3105      59                       POP CX
// 1000:3106      e2 ea                    LOOP 0x1000:30f2
// 1000:3108      c3                       RET
fun_30ec :: proc() {
}

// @proc 1000:3109
// listing: FUN_1000_3109
// status: unread
// 1000:3109  FUN_1000_3109:
// 1000:3109      c6 06 82 a2 00           MOV byte ptr [0xa282],0x0
// 1000:310e      be 4c 90                 MOV SI,0x904c
// 1000:3111  LAB_1000_3111:
// 1000:3111      56                       PUSH SI
// 1000:3112      b9 14 00                 MOV CX,0x14
// 1000:3115  LAB_1000_3115:
// 1000:3115      51                       PUSH CX
// 1000:3116      80 3c 00                 CMP byte ptr [SI],0x0
// 1000:3119      74 0f                    JZ 0x1000:312a
// 1000:311b      f6 05 80                 TEST byte ptr [DI],0x80
// 1000:311e      74 0a                    JZ 0x1000:312a
// 1000:3120      b1 02                    MOV CL,0x2
// 1000:3122      e8 9f f2                 CALL 0x1000:23c4
// 1000:3125      3d 58 02                 CMP AX,0x258
// 1000:3128      72 03                    JC 0x1000:312d
// 1000:312a  LAB_1000_312a:
// 1000:312a      e9 83 00                 JMP 0x1000:31b0
// 1000:312d  LAB_1000_312d:
// 1000:312d      8a 5c 07                 MOV BL,byte ptr [SI + 0x7]
// 1000:3130      3a 5d 18                 CMP BL,byte ptr [DI + 0x18]
// 1000:3133      75 2d                    JNZ 0x1000:3162
// 1000:3135      3d 64 00                 CMP AX,0x64
// 1000:3138      77 79                    JA 0x1000:31b3
// 1000:313a      8a 5c 06                 MOV BL,byte ptr [SI + 0x6]
// 1000:313d      3a 5d 17                 CMP BL,byte ptr [DI + 0x17]
// 1000:3140      75 71                    JNZ 0x1000:31b3
// 1000:3142      80 7d 2a 00              CMP byte ptr [DI + 0x2a],0x0
// 1000:3146      74 6b                    JZ 0x1000:31b3
// 1000:3148      f6 45 22 01              TEST byte ptr [DI + 0x22],0x1
// 1000:314c      74 65                    JZ 0x1000:31b3
// 1000:314e      80 7d 06 05              CMP byte ptr [DI + 0x6],0x5
// 1000:3152      72 06                    JC 0x1000:315a
// 1000:3154      c6 45 22 00              MOV byte ptr [DI + 0x22],0x0
// 1000:3158      eb 59                    JMP 0x1000:31b3
// 1000:315a  LAB_1000_315a:
// 1000:315a      c6 04 00                 MOV byte ptr [SI],0x0
// 1000:315d      fe 45 06                 INC byte ptr [DI + 0x6]
// 1000:3160      eb 51                    JMP 0x1000:31b3
// 1000:3162  LAB_1000_3162:
// 1000:3162      80 4d 16 04              OR byte ptr [DI + 0x16],0x4
// 1000:3166      3d 04 01                 CMP AX,0x104
// 1000:3169      77 45                    JA 0x1000:31b0
// 1000:316b      80 3c 02                 CMP byte ptr [SI],0x2
// 1000:316e      76 03                    JBE 0x1000:3173
// 1000:3170      c6 04 02                 MOV byte ptr [SI],0x2
// 1000:3173  LAB_1000_3173:
// 1000:3173      f6 05 44                 TEST byte ptr [DI],0x44
// 1000:3176      75 1a                    JNZ 0x1000:3192
// 1000:3178      80 3c 01                 CMP byte ptr [SI],0x1
// 1000:317b      75 15                    JNZ 0x1000:3192
// 1000:317d      fe 4d 2a                 DEC byte ptr [DI + 0x2a]
// 1000:3180      79 10                    JNS 0x1000:3192
// 1000:3182      c6 45 2a 00              MOV byte ptr [DI + 0x2a],0x0
// 1000:3186      b8 88 13                 MOV AX,0x1388
// 1000:3189      e8 ef f1                 CALL 0x1000:237b
// 1000:318c      8a 5c 06                 MOV BL,byte ptr [SI + 0x6]
// 1000:318f      e8 42 fd                 CALL 0x1000:2ed4
// 1000:3192  LAB_1000_3192:
// 1000:3192      8a 45 0b                 MOV AL,byte ptr [DI + 0xb]
// 1000:3195      25 0f 00                 AND AX,0xf
// 1000:3198      3d 0a 00                 CMP AX,0xa
// 1000:319b      76 03                    JBE 0x1000:31a0
// 1000:319d      b8 14 00                 MOV AX,0x14
// 1000:31a0  LAB_1000_31a0:
// 1000:31a0      b1 06                    MOV CL,0x6
// 1000:31a2      d3 e0                    SHL AX,CL
// 1000:31a4      05 c8 00                 ADD AX,0xc8
// 1000:31a7      e8 d1 f1                 CALL 0x1000:237b
// 1000:31aa      8a 5c 06                 MOV BL,byte ptr [SI + 0x6]
// 1000:31ad      e8 24 fd                 CALL 0x1000:2ed4
// 1000:31b0  LAB_1000_31b0:
// 1000:31b0      e8 1e 00                 CALL 0x1000:31d1
// 1000:31b3  LAB_1000_31b3:
// 1000:31b3      83 c6 08                 ADD SI,0x8
// 1000:31b6      59                       POP CX
// 1000:31b7      49                       DEC CX
// 1000:31b8      74 03                    JZ 0x1000:31bd
// 1000:31ba      e9 58 ff                 JMP 0x1000:3115
// 1000:31bd  LAB_1000_31bd:
// 1000:31bd      5e                       POP SI
// 1000:31be      81 c6 a0 00              ADD SI,0xa0
// 1000:31c2      fe 06 82 a2              INC byte ptr [0xa282]
// 1000:31c6      80 3e 82 a2 04           CMP byte ptr [0xa282],0x4
// 1000:31cb      73 03                    JNC 0x1000:31d0
// 1000:31cd      e9 41 ff                 JMP 0x1000:3111
// 1000:31d0  LAB_1000_31d0:
// 1000:31d0      c3                       RET
fun_3109 :: proc() {
}

// 1000:31d1 decay_impulse is in ship.odin.

// @proc 1000:31f0
// listing: FUN_1000_31f0
// status: unread
// 1000:31f0  FUN_1000_31f0:
// 1000:31f0      b9 04 00                 MOV CX,0x4
// 1000:31f3      bf 64 8c                 MOV DI,0x8c64
// 1000:31f6      bd 14 90                 MOV BP,0x9014
// 1000:31f9      c6 06 82 a2 80           MOV byte ptr [0xa282],0x80
// 1000:31fe      c6 06 74 a2 00           MOV byte ptr [0xa274],0x0
// 1000:3203  LAB_1000_3203:
// 1000:3203      51                       PUSH CX
// 1000:3204      b9 04 00                 MOV CX,0x4
// 1000:3207  LAB_1000_3207:
// 1000:3207      f6 05 80                 TEST byte ptr [DI],0x80
// 1000:320a      74 05                    JZ 0x1000:3211
// 1000:320c      51                       PUSH CX
// 1000:320d      e8 37 00                 CALL 0x1000:3247
// 1000:3210      59                       POP CX
// 1000:3211  LAB_1000_3211:
// 1000:3211      83 c7 3b                 ADD DI,0x3b
// 1000:3214      e2 f1                    LOOP 0x1000:3207
// 1000:3216      59                       POP CX
// 1000:3217      83 c5 0e                 ADD BP,0xe
// 1000:321a      d0 2e 82 a2              SHR byte ptr [0xa282],0x1
// 1000:321e      fe 06 74 a2              INC byte ptr [0xa274]
// 1000:3222      e2 df                    LOOP 0x1000:3203
// 1000:3224      c3                       RET
fun_31f0 :: proc() {
}

// 1000:3225 planet_array_for_record is in planet.odin.

// 1000:3228 planet_array_for_level is in ship.odin.

// @proc 1000:3247
// listing: FUN_1000_3247
// status: unread
// 1000:3247  FUN_1000_3247:
// 1000:3247      87 f7                    XCHG DI,SI
// 1000:3249      e8 d9 ff                 CALL 0x1000:3225
// 1000:324c      87 f7                    XCHG DI,SI
// 1000:324e      d1 e9                    SHR CX,0x1
// 1000:3250      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
// 1000:3255      75 03                    JNZ 0x1000:325a
// 1000:3257      83 c6 0b                 ADD SI,0xb
// 1000:325a  LAB_1000_325a:
// 1000:325a      51                       PUSH CX
// 1000:325b      b1 04                    MOV CL,0x4
// 1000:325d      e8 64 f1                 CALL 0x1000:23c4
// 1000:3260      50                       PUSH AX
// 1000:3261      3d 90 01                 CMP AX,0x190
// 1000:3264      77 64                    JA 0x1000:32ca
// 1000:3266      8a 1e 82 a2              MOV BL,byte ptr [0xa282]
// 1000:326a      08 1c                    OR byte ptr [SI],BL
// 1000:326c      3d fa 00                 CMP AX,0xfa
// 1000:326f      77 59                    JA 0x1000:32ca
// 1000:3271      8a 1c                    MOV BL,byte ptr [SI]
// 1000:3273      81 e3 0f 00              AND BX,0xf
// 1000:3277      74 4a                    JZ 0x1000:32c3
// 1000:3279      80 fb 0e                 CMP BL,0xe
// 1000:327c      74 05                    JZ 0x1000:3283
// 1000:327e      80 fb 0d                 CMP BL,0xd
// 1000:3281      77 40                    JA 0x1000:32c3
// 1000:3283  LAB_1000_3283:
// 1000:3283      3d 46 00                 CMP AX,0x46
// 1000:3286      77 42                    JA 0x1000:32ca
// 1000:3288      8a 45 11                 MOV AL,byte ptr [DI + 0x11]
// 1000:328b      24 1f                    AND AL,0x1f
// 1000:328d      3c 01                    CMP AL,0x1
// 1000:328f      74 39                    JZ 0x1000:32ca
// 1000:3291      87 f7                    XCHG DI,SI
// 1000:3293      e8 c1 0c                 CALL 0x1000:3f57
// 1000:3296      87 f7                    XCHG DI,SI
// 1000:3298      75 30                    JNZ 0x1000:32ca
// 1000:329a      80 7d 29 03              CMP byte ptr [DI + 0x29],0x3
// 1000:329e      75 23                    JNZ 0x1000:32c3
// 1000:32a0      8a 04                    MOV AL,byte ptr [SI]
// 1000:32a2      24 0f                    AND AL,0xf
// 1000:32a4      3c 0a                    CMP AL,0xa
// 1000:32a6      72 11                    JC 0x1000:32b9
// 1000:32a8      3c 0d                    CMP AL,0xd
// 1000:32aa      76 17                    JBE 0x1000:32c3
// 1000:32ac      3c 0e                    CMP AL,0xe
// 1000:32ae      75 09                    JNZ 0x1000:32b9
// 1000:32b0      3e 8a 46 05              MOV AL,byte ptr DS:[BP + 0x5]
// 1000:32b4      3a 44 05                 CMP AL,byte ptr [SI + 0x5]
// 1000:32b7      75 0a                    JNZ 0x1000:32c3
// 1000:32b9  LAB_1000_32b9:
// 1000:32b9      c6 45 29 00              MOV byte ptr [DI + 0x29],0x0
// 1000:32bd      8a 45 18                 MOV AL,byte ptr [DI + 0x18]
// 1000:32c0      88 44 0a                 MOV byte ptr [SI + 0xa],AL
// 1000:32c3  LAB_1000_32c3:
// 1000:32c3      03 db                    ADD BX,BX
// 1000:32c5      2e ff 97 1b 33           CALL word ptr CS:[BX + 0x331b]
// 1000:32ca  LAB_1000_32ca:
// 1000:32ca      87 f7                    XCHG DI,SI
// 1000:32cc      e8 88 0c                 CALL 0x1000:3f57
// 1000:32cf      87 f7                    XCHG DI,SI
// 1000:32d1      58                       POP AX
// 1000:32d2      75 03                    JNZ 0x1000:32d7
// 1000:32d4      e8 0e 00                 CALL 0x1000:32e5
// 1000:32d7  LAB_1000_32d7:
// 1000:32d7      83 c6 0b                 ADD SI,0xb
// 1000:32da      83 c6 0b                 ADD SI,0xb
// 1000:32dd      59                       POP CX
// 1000:32de      49                       DEC CX
// 1000:32df      74 03                    JZ 0x1000:32e4
// 1000:32e1      e9 76 ff                 JMP 0x1000:325a
// 1000:32e4  LAB_1000_32e4:
// 1000:32e4      c3                       RET
fun_3247 :: proc() {
}

// @proc 1000:32e5
// listing: FUN_1000_32e5
// status: unread
// 1000:32e5  FUN_1000_32e5:
// 1000:32e5      3d a0 0f                 CMP AX,0xfa0
// 1000:32e8      77 20                    JA 0x1000:330a
// 1000:32ea      8a 1e 82 a2              MOV BL,byte ptr [0xa282]
// 1000:32ee      22 1c                    AND BL,byte ptr [SI]
// 1000:32f0      75 05                    JNZ 0x1000:32f7
// 1000:32f2      80 4d 28 10              OR byte ptr [DI + 0x28],0x10
// 1000:32f6      c3                       RET
// 1000:32f7  LAB_1000_32f7:
// 1000:32f7      3d b8 0b                 CMP AX,0xbb8
// 1000:32fa      77 0e                    JA 0x1000:330a
// 1000:32fc      8a 1c                    MOV BL,byte ptr [SI]
// 1000:32fe      81 e3 0f 00              AND BX,0xf
// 1000:3302      2e 8a 87 0b 33           MOV AL,byte ptr CS:[BX + 0x330b]
// 1000:3307      08 45 28                 OR byte ptr [DI + 0x28],AL
// 1000:330a  LAB_1000_330a:
// 1000:330a      c3                       RET
fun_32e5 :: proc() {
}

// @proc 1000:36b5
// listing: FUN_1000_36b5
// status: unread
// 1000:36b5  FUN_1000_36b5:
// 1000:36b5      be 8c 8a                 MOV SI,0x8a8c
// 1000:36b8      8a 0e 01 00              MOV CL,byte ptr [0x1]
// 1000:36bc      32 ed                    XOR CH,CH
// 1000:36be  LAB_1000_36be:
// 1000:36be      ff 4c 08                 DEC word ptr [SI + 0x8]
// 1000:36c1      75 03                    JNZ 0x1000:36c6
// 1000:36c3      e8 4c 0c                 CALL 0x1000:4312
// 1000:36c6  LAB_1000_36c6:
// 1000:36c6      56                       PUSH SI
// 1000:36c7      51                       PUSH CX
// 1000:36c8      bb 80 3e                 MOV BX,0x3e80
// 1000:36cb      b9 10 00                 MOV CX,0x10
// 1000:36ce      bf 64 8c                 MOV DI,0x8c64
// 1000:36d1  LAB_1000_36d1:
// 1000:36d1      51                       PUSH CX
// 1000:36d2      8a 05                    MOV AL,byte ptr [DI]
// 1000:36d4      a8 80                    TEST AL,0x80
// 1000:36d6      74 1b                    JZ 0x1000:36f3
// 1000:36d8      a8 44                    TEST AL,0x44
// 1000:36da      75 17                    JNZ 0x1000:36f3
// 1000:36dc      8a 0c                    MOV CL,byte ptr [SI]
// 1000:36de      80 e1 03                 AND CL,0x3
// 1000:36e1      80 f9 02                 CMP CL,0x2
// 1000:36e4      75 10                    JNZ 0x1000:36f6
// 1000:36e6      81 7d 08 b8 0b           CMP word ptr [DI + 0x8],0xbb8
// 1000:36eb      76 13                    JBE 0x1000:3700
// 1000:36ed      80 7d 0e 09              CMP byte ptr [DI + 0xe],0x9
// 1000:36f1      73 0d                    JNC 0x1000:3700
// 1000:36f3  LAB_1000_36f3:
// 1000:36f3      e9 90 00                 JMP 0x1000:3786
// 1000:36f6  LAB_1000_36f6:
// 1000:36f6      f6 45 19 f0              TEST byte ptr [DI + 0x19],0xf0
// 1000:36fa      75 04                    JNZ 0x1000:3700
// 1000:36fc      a8 10                    TEST AL,0x10
// 1000:36fe      75 f3                    JNZ 0x1000:36f3
// 1000:3700  LAB_1000_3700:
// 1000:3700      e8 b0 08                 CALL 0x1000:3fb3
// 1000:3703      3d 5e 01                 CMP AX,0x15e
// 1000:3706      77 eb                    JA 0x1000:36f3
// 1000:3708      8a 0c                    MOV CL,byte ptr [SI]
// 1000:370a      80 e1 03                 AND CL,0x3
// 1000:370d      80 f9 00                 CMP CL,0x0
// 1000:3710      75 33                    JNZ 0x1000:3745
// 1000:3712      80 4d 16 10              OR byte ptr [DI + 0x16],0x10
// 1000:3716      f6 45 19 80              TEST byte ptr [DI + 0x19],0x80
// 1000:371a      74 0a                    JZ 0x1000:3726
// 1000:371c      83 7c 08 15              CMP word ptr [SI + 0x8],0x15
// 1000:3720      72 1b                    JC 0x1000:373d
// 1000:3722      83 6c 08 14              SUB word ptr [SI + 0x8],0x14
// 1000:3726  LAB_1000_3726:
// 1000:3726      3d 64 00                 CMP AX,0x64
// 1000:3729      77 5b                    JA 0x1000:3786
// 1000:372b      52                       PUSH DX
// 1000:372c      b9 3c 00                 MOV CX,0x3c
// 1000:372f      8b 45 08                 MOV AX,word ptr [DI + 0x8]
// 1000:3732      33 d2                    XOR DX,DX
// 1000:3734      f7 f1                    DIV CX
// 1000:3736      e8 42 ec                 CALL 0x1000:237b
// 1000:3739      5a                       POP DX
// 1000:373a      eb 1b                    JMP 0x1000:3757
// 1000:373d  LAB_1000_373d:
// 1000:373d      c7 44 08 01 00           MOV word ptr [SI + 0x8],0x1
// 1000:3742      eb 42                    JMP 0x1000:3786
// 1000:3745  LAB_1000_3745:
// 1000:3745      80 f9 01                 CMP CL,0x1
// 1000:3748      75 1a                    JNZ 0x1000:3764
// 1000:374a      80 4d 16 08              OR byte ptr [DI + 0x16],0x8
// 1000:374e      3d 55 00                 CMP AX,0x55
// 1000:3751      77 33                    JA 0x1000:3786
// 1000:3753      80 45 15 02              ADD byte ptr [DI + 0x15],0x2
// 1000:3757  LAB_1000_3757:
// 1000:3757      83 7c 08 04              CMP word ptr [SI + 0x8],0x4
// 1000:375b      76 29                    JBE 0x1000:3786
// 1000:375d      83 6c 08 03              SUB word ptr [SI + 0x8],0x3
// 1000:3761      eb 23                    JMP 0x1000:3786
// 1000:3764  LAB_1000_3764:
// 1000:3764      3d 64 00                 CMP AX,0x64
// 1000:3767      77 1d                    JA 0x1000:3786
// 1000:3769      c7 45 08 b8 88           MOV word ptr [DI + 0x8],0x88b8
// 1000:376e      c6 45 07 14              MOV byte ptr [DI + 0x7],0x14
// 1000:3772      c6 45 0f 63              MOV byte ptr [DI + 0xf],0x63
// 1000:3776      c6 45 2a 08              MOV byte ptr [DI + 0x2a],0x8
// 1000:377a      c6 45 0e 00              MOV byte ptr [DI + 0xe],0x0
// 1000:377e      e8 20 00                 CALL 0x1000:37a1
// 1000:3781      c7 44 08 01 00           MOV word ptr [SI + 0x8],0x1
// 1000:3786  LAB_1000_3786:
// 1000:3786      83 c7 3b                 ADD DI,0x3b
// 1000:3789      59                       POP CX
// 1000:378a      49                       DEC CX
// 1000:378b      74 03                    JZ 0x1000:3790
// 1000:378d      e9 41 ff                 JMP 0x1000:36d1
// 1000:3790  LAB_1000_3790:
// 1000:3790      8b fe                    MOV DI,SI
// 1000:3792      e8 89 ea                 CALL 0x1000:221e
// 1000:3795      59                       POP CX
// 1000:3796      5e                       POP SI
// 1000:3797      83 c6 3b                 ADD SI,0x3b
// 1000:379a      49                       DEC CX
// 1000:379b      74 03                    JZ 0x1000:37a0
// 1000:379d      e9 1e ff                 JMP 0x1000:36be
// 1000:37a0  LAB_1000_37a0:
// 1000:37a0      c3                       RET
fun_36b5 :: proc() {
}

// 1000:37a1 cap_weapons_cooldown is in ship.odin.

// 1000:37ac move_ships_and_shots is in ship.odin.

// 1000:382a step_position is in ship.odin.

// @proc 1000:3974
// listing: FUN_1000_3974
// status: unread
// 1000:3974  FUN_1000_3974:
// 1000:3974      b0 00                    MOV AL,0x0
// 1000:3976      b4 80                    MOV AH,0x80
// 1000:3978      e8 16 00                 CALL 0x1000:3991
// 1000:397b      b0 01                    MOV AL,0x1
// 1000:397d      b4 40                    MOV AH,0x40
// 1000:397f      e8 0f 00                 CALL 0x1000:3991
// 1000:3982      b0 02                    MOV AL,0x2
// 1000:3984      b4 20                    MOV AH,0x20
// 1000:3986      e8 08 00                 CALL 0x1000:3991
// 1000:3989      b0 03                    MOV AL,0x3
// 1000:398b      b4 10                    MOV AH,0x10
// 1000:398d      e8 01 00                 CALL 0x1000:3991
// 1000:3990      c3                       RET
fun_3974 :: proc() {
}

// @proc 1000:3991
// listing: FUN_1000_3991
// status: unread
// 1000:3991  FUN_1000_3991:
// 1000:3991      a2 74 a2                 MOV [0xa274],AL
// 1000:3994      b0 00                    MOV AL,0x0
// 1000:3996  LAB_1000_3996:
// 1000:3996      50                       PUSH AX
// 1000:3997      e8 72 f0                 CALL 0x1000:2a0c
// 1000:399a      58                       POP AX
// 1000:399b      50                       PUSH AX
// 1000:399c      80 7c 19 04              CMP byte ptr [SI + 0x19],0x4
// 1000:39a0      72 0b                    JC 0x1000:39ad
// 1000:39a2      80 7c 19 80              CMP byte ptr [SI + 0x19],0x80
// 1000:39a6      73 05                    JNC 0x1000:39ad
// 1000:39a8      e8 da 04                 CALL 0x1000:3e85
// 1000:39ab      58                       POP AX
// 1000:39ac      50                       PUSH AX
// 1000:39ad  LAB_1000_39ad:
// 1000:39ad      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
// 1000:39b0      24 1f                    AND AL,0x1f
// 1000:39b2      74 03                    JZ 0x1000:39b7
// 1000:39b4      e8 08 00                 CALL 0x1000:39bf
// 1000:39b7  LAB_1000_39b7:
// 1000:39b7      58                       POP AX
// 1000:39b8      fe c0                    INC AL
// 1000:39ba      3c 04                    CMP AL,0x4
// 1000:39bc      72 d8                    JC 0x1000:3996
// 1000:39be      c3                       RET
fun_3991 :: proc() {
}

// @proc 1000:39bf
// listing: FUN_1000_39bf
// status: unread
// 1000:39bf  FUN_1000_39bf:
// 1000:39bf      c7 44 12 ff ff           MOV word ptr [SI + 0x12],0xffff
// 1000:39c4      3c 01                    CMP AL,0x1
// 1000:39c6      75 3b                    JNZ 0x1000:3a03
// 1000:39c8      e8 5a f8                 CALL 0x1000:3225
// 1000:39cb      bb 40 9c                 MOV BX,0x9c40
// 1000:39ce  LAB_1000_39ce:
// 1000:39ce      51                       PUSH CX
// 1000:39cf      50                       PUSH AX
// 1000:39d0      22 25                    AND AH,byte ptr [DI]
// 1000:39d2      75 1d                    JNZ 0x1000:39f1
// 1000:39d4      81 fb 40 9c              CMP BX,0x9c40
// 1000:39d8      75 01                    JNZ 0x1000:39db
// 1000:39da      4b                       DEC BX
// 1000:39db  LAB_1000_39db:
// 1000:39db      53                       PUSH BX
// 1000:39dc      e8 47 f0                 CALL 0x1000:2a26
// 1000:39df      5b                       POP BX
// 1000:39e0      3b c3                    CMP AX,BX
// 1000:39e2      77 0d                    JA 0x1000:39f1
// 1000:39e4      3d 0f 27                 CMP AX,0x270f
// 1000:39e7      77 08                    JA 0x1000:39f1
// 1000:39e9      89 44 12                 MOV word ptr [SI + 0x12],AX
// 1000:39ec      8b d8                    MOV BX,AX
// 1000:39ee      e8 d0 05                 CALL 0x1000:3fc1
// 1000:39f1  LAB_1000_39f1:
// 1000:39f1      58                       POP AX
// 1000:39f2      59                       POP CX
// 1000:39f3      83 c7 0b                 ADD DI,0xb
// 1000:39f6      e2 d6                    LOOP 0x1000:39ce
// 1000:39f8      81 fb 40 9c              CMP BX,0x9c40
// 1000:39fc      75 04                    JNZ 0x1000:3a02
// 1000:39fe      c6 44 11 80              MOV byte ptr [SI + 0x11],0x80
// 1000:3a02  LAB_1000_3a02:
// 1000:3a02      c3                       RET
// 1000:3a03  LAB_1000_3a03:
// 1000:3a03      3c 02                    CMP AL,0x2
// 1000:3a05      75 24                    JNZ 0x1000:3a2b
// 1000:3a07      e8 1b f8                 CALL 0x1000:3225
// 1000:3a0a      bb 80 3e                 MOV BX,0x3e80
// 1000:3a0d  LAB_1000_3a0d:
// 1000:3a0d      51                       PUSH CX
// 1000:3a0e      50                       PUSH AX
// 1000:3a0f      22 25                    AND AH,byte ptr [DI]
// 1000:3a11      74 10                    JZ 0x1000:3a23
// 1000:3a13      8a 05                    MOV AL,byte ptr [DI]
// 1000:3a15      24 0f                    AND AL,0xf
// 1000:3a17      3c 02                    CMP AL,0x2
// 1000:3a19      75 08                    JNZ 0x1000:3a23
// 1000:3a1b      e8 39 05                 CALL 0x1000:3f57
// 1000:3a1e      75 03                    JNZ 0x1000:3a23
// 1000:3a20      e8 47 05                 CALL 0x1000:3f6a
// 1000:3a23  LAB_1000_3a23:
// 1000:3a23      58                       POP AX
// 1000:3a24      59                       POP CX
// 1000:3a25      83 c7 0b                 ADD DI,0xb
// 1000:3a28      e2 e3                    LOOP 0x1000:3a0d
// 1000:3a2a      c3                       RET
// 1000:3a2b  LAB_1000_3a2b:
// 1000:3a2b      3c 03                    CMP AL,0x3
// 1000:3a2d      75 24                    JNZ 0x1000:3a53
// 1000:3a2f      e8 f3 f7                 CALL 0x1000:3225
// 1000:3a32      bb 80 3e                 MOV BX,0x3e80
// 1000:3a35  LAB_1000_3a35:
// 1000:3a35      51                       PUSH CX
// 1000:3a36      50                       PUSH AX
// 1000:3a37      22 25                    AND AH,byte ptr [DI]
// 1000:3a39      74 10                    JZ 0x1000:3a4b
// 1000:3a3b      8a 05                    MOV AL,byte ptr [DI]
// 1000:3a3d      24 0f                    AND AL,0xf
// 1000:3a3f      3c 03                    CMP AL,0x3
// 1000:3a41      75 08                    JNZ 0x1000:3a4b
// 1000:3a43      e8 11 05                 CALL 0x1000:3f57
// 1000:3a46      75 03                    JNZ 0x1000:3a4b
// 1000:3a48      e8 1f 05                 CALL 0x1000:3f6a
// 1000:3a4b  LAB_1000_3a4b:
// 1000:3a4b      58                       POP AX
// 1000:3a4c      59                       POP CX
// 1000:3a4d      83 c7 0b                 ADD DI,0xb
// 1000:3a50      e2 e3                    LOOP 0x1000:3a35
// 1000:3a52      c3                       RET
// 1000:3a53  LAB_1000_3a53:
// 1000:3a53      3c 04                    CMP AL,0x4
// 1000:3a55      75 4e                    JNZ 0x1000:3aa5
// 1000:3a57      50                       PUSH AX
// 1000:3a58      e8 73 e4                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:3a63  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
// 1000:3a63  LAB_1000_3a63:
// 1000:3a63      58                       POP AX
// 1000:3a64      83 7f 08 00              CMP word ptr [BX + 0x8],0x0
// 1000:3a68      75 05                    JNZ 0x1000:3a6f
// 1000:3a6a      c6 44 11 80              MOV byte ptr [SI + 0x11],0x80
// 1000:3a6e      c3                       RET
// 1000:3a6f  LAB_1000_3a6f:
// 1000:3a6f      50                       PUSH AX
// 1000:3a70      8b fb                    MOV DI,BX
// 1000:3a72      e8 b1 ef                 CALL 0x1000:2a26
// 1000:3a75      89 44 12                 MOV word ptr [SI + 0x12],AX
// 1000:3a78      8b d8                    MOV BX,AX
// 1000:3a7a      81 fb 80 3e              CMP BX,0x3e80
// 1000:3a7e      77 03                    JA 0x1000:3a83
// 1000:3a80      e8 3e 05                 CALL 0x1000:3fc1
// 1000:3a83  LAB_1000_3a83:
// 1000:3a83      e8 9f f7                 CALL 0x1000:3225
// 1000:3a86      58                       POP AX
// 1000:3a87  LAB_1000_3a87:
// 1000:3a87      51                       PUSH CX
// 1000:3a88      50                       PUSH AX
// 1000:3a89      22 25                    AND AH,byte ptr [DI]
// 1000:3a8b      74 10                    JZ 0x1000:3a9d
// 1000:3a8d      8a 05                    MOV AL,byte ptr [DI]
// 1000:3a8f      24 0f                    AND AL,0xf
// 1000:3a91      3c 04                    CMP AL,0x4
// 1000:3a93      75 08                    JNZ 0x1000:3a9d
// 1000:3a95      e8 bf 04                 CALL 0x1000:3f57
// 1000:3a98      75 03                    JNZ 0x1000:3a9d
// 1000:3a9a      e8 cd 04                 CALL 0x1000:3f6a
// 1000:3a9d  LAB_1000_3a9d:
// 1000:3a9d      58                       POP AX
// 1000:3a9e      59                       POP CX
// 1000:3a9f      83 c7 0b                 ADD DI,0xb
// 1000:3aa2      e2 e3                    LOOP 0x1000:3a87
// 1000:3aa4      c3                       RET
// 1000:3aa5  LAB_1000_3aa5:
// 1000:3aa5      3c 05                    CMP AL,0x5
// 1000:3aa7      75 24                    JNZ 0x1000:3acd
// 1000:3aa9      e8 79 f7                 CALL 0x1000:3225
// 1000:3aac      bb 80 3e                 MOV BX,0x3e80
// 1000:3aaf  LAB_1000_3aaf:
// 1000:3aaf      51                       PUSH CX
// 1000:3ab0      50                       PUSH AX
// 1000:3ab1      22 25                    AND AH,byte ptr [DI]
// 1000:3ab3      74 10                    JZ 0x1000:3ac5
// 1000:3ab5      8a 05                    MOV AL,byte ptr [DI]
// 1000:3ab7      24 0f                    AND AL,0xf
// 1000:3ab9      3c 01                    CMP AL,0x1
// 1000:3abb      75 08                    JNZ 0x1000:3ac5
// 1000:3abd      e8 97 04                 CALL 0x1000:3f57
// 1000:3ac0      75 03                    JNZ 0x1000:3ac5
// 1000:3ac2      e8 a5 04                 CALL 0x1000:3f6a
// 1000:3ac5  LAB_1000_3ac5:
// 1000:3ac5      58                       POP AX
// 1000:3ac6      59                       POP CX
// 1000:3ac7      83 c7 0b                 ADD DI,0xb
// 1000:3aca      e2 e3                    LOOP 0x1000:3aaf
// 1000:3acc      c3                       RET
// 1000:3acd  LAB_1000_3acd:
// 1000:3acd      3c 06                    CMP AL,0x6
// 1000:3acf      75 68                    JNZ 0x1000:3b39
// 1000:3ad1      bf 14 90                 MOV DI,0x9014
// 1000:3ad4      b9 04 00                 MOV CX,0x4
// 1000:3ad7      bb 80 3e                 MOV BX,0x3e80
// 1000:3ada      80 64 11 3f              AND byte ptr [SI + 0x11],0x3f
// 1000:3ade  LAB_1000_3ade:
// 1000:3ade      8a 44 18                 MOV AL,byte ptr [SI + 0x18]
// 1000:3ae1      38 45 0c                 CMP byte ptr [DI + 0xc],AL
// 1000:3ae4      74 4d                    JZ 0x1000:3b33
// 1000:3ae6      83 7d 08 00              CMP word ptr [DI + 0x8],0x0
// 1000:3aea      74 47                    JZ 0x1000:3b33
// 1000:3aec      8a 44 2b                 MOV AL,byte ptr [SI + 0x2b]
// 1000:3aef      3a 44 17                 CMP AL,byte ptr [SI + 0x17]
// 1000:3af2      74 05                    JZ 0x1000:3af9
// 1000:3af4      3a 45 0b                 CMP AL,byte ptr [DI + 0xb]
// 1000:3af7      75 3a                    JNZ 0x1000:3b33
// 1000:3af9  LAB_1000_3af9:
// 1000:3af9      51                       PUSH CX
// 1000:3afa      53                       PUSH BX
// 1000:3afb      e8 28 ef                 CALL 0x1000:2a26
// 1000:3afe      5b                       POP BX
// 1000:3aff      3b c3                    CMP AX,BX
// 1000:3b01      77 2f                    JA 0x1000:3b32
// 1000:3b03      89 44 12                 MOV word ptr [SI + 0x12],AX
// 1000:3b06      8b d8                    MOV BX,AX
// 1000:3b08      e8 1f 03                 CALL 0x1000:3e2a
// 1000:3b0b      3d 84 03                 CMP AX,0x384
// 1000:3b0e      77 1c                    JA 0x1000:3b2c
// 1000:3b10      80 4c 11 c0              OR byte ptr [SI + 0x11],0xc0
// 1000:3b14      3d bc 02                 CMP AX,0x2bc
// 1000:3b17      77 13                    JA 0x1000:3b2c
// 1000:3b19      80 c5 04                 ADD CH,0x4
// 1000:3b1c      3d f4 01                 CMP AX,0x1f4
// 1000:3b1f      77 0b                    JA 0x1000:3b2c
// 1000:3b21      80 c5 02                 ADD CH,0x2
// 1000:3b24      3d db 01                 CMP AX,0x1db
// 1000:3b27      77 03                    JA 0x1000:3b2c
// 1000:3b29      80 c5 01                 ADD CH,0x1
// 1000:3b2c  LAB_1000_3b2c:
// 1000:3b2c      80 e5 0f                 AND CH,0xf
// 1000:3b2f      e8 8f 04                 CALL 0x1000:3fc1
// 1000:3b32  LAB_1000_3b32:
// 1000:3b32      59                       POP CX
// 1000:3b33  LAB_1000_3b33:
// 1000:3b33      83 c7 0e                 ADD DI,0xe
// 1000:3b36      e2 a6                    LOOP 0x1000:3ade
// 1000:3b38      c3                       RET
// 1000:3b39  LAB_1000_3b39:
// 1000:3b39      3c 07                    CMP AL,0x7
// 1000:3b3b      74 03                    JZ 0x1000:3b40
// 1000:3b3d      e9 94 00                 JMP 0x1000:3bd4
// 1000:3b40  LAB_1000_3b40:
// 1000:3b40      bf 64 8c                 MOV DI,0x8c64
// 1000:3b43      b9 10 00                 MOV CX,0x10
// 1000:3b46      bb 4c 1d                 MOV BX,0x1d4c
// 1000:3b49      80 64 11 3f              AND byte ptr [SI + 0x11],0x3f
// 1000:3b4d  LAB_1000_3b4d:
// 1000:3b4d      8a 44 18                 MOV AL,byte ptr [SI + 0x18]
// 1000:3b50      38 45 18                 CMP byte ptr [DI + 0x18],AL
// 1000:3b53      74 75                    JZ 0x1000:3bca
// 1000:3b55      f6 05 80                 TEST byte ptr [DI],0x80
// 1000:3b58      74 70                    JZ 0x1000:3bca
// 1000:3b5a      f6 05 44                 TEST byte ptr [DI],0x44
// 1000:3b5d      75 6b                    JNZ 0x1000:3bca
// 1000:3b5f      81 7c 08 40 9c           CMP word ptr [SI + 0x8],0x9c40
// 1000:3b64      77 0b                    JA 0x1000:3b71
// 1000:3b66      f6 05 10                 TEST byte ptr [DI],0x10
// 1000:3b69      74 06                    JZ 0x1000:3b71
// 1000:3b6b      f6 45 19 f0              TEST byte ptr [DI + 0x19],0xf0
// 1000:3b6f      74 59                    JZ 0x1000:3bca
// 1000:3b71  LAB_1000_3b71:
// 1000:3b71      8a 44 2b                 MOV AL,byte ptr [SI + 0x2b]
// 1000:3b74      3a 44 17                 CMP AL,byte ptr [SI + 0x17]
// 1000:3b77      74 05                    JZ 0x1000:3b7e
// 1000:3b79      3a 45 17                 CMP AL,byte ptr [DI + 0x17]
// 1000:3b7c      75 4c                    JNZ 0x1000:3bca
// 1000:3b7e  LAB_1000_3b7e:
// 1000:3b7e      51                       PUSH CX
// 1000:3b7f      53                       PUSH BX
// 1000:3b80      e8 a3 ee                 CALL 0x1000:2a26
// 1000:3b83      5b                       POP BX
// 1000:3b84      3b c3                    CMP AX,BX
// 1000:3b86      77 41                    JA 0x1000:3bc9
// 1000:3b88      89 44 12                 MOV word ptr [SI + 0x12],AX
// 1000:3b8b      8b d8                    MOV BX,AX
// 1000:3b8d      3d 84 03                 CMP AX,0x384
// 1000:3b90      77 31                    JA 0x1000:3bc3
// 1000:3b92      80 4c 11 c0              OR byte ptr [SI + 0x11],0xc0
// 1000:3b96      3d 90 01                 CMP AX,0x190
// 1000:3b99      77 28                    JA 0x1000:3bc3
// 1000:3b9b      8a 4c 0b                 MOV CL,byte ptr [SI + 0xb]
// 1000:3b9e      d0 e9                    SHR CL,0x1
// 1000:3ba0      d0 e9                    SHR CL,0x1
// 1000:3ba2      d0 e9                    SHR CL,0x1
// 1000:3ba4      d0 e9                    SHR CL,0x1
// 1000:3ba6  LAB_1000_3ba6:
// 1000:3ba6      80 e1 0f                 AND CL,0xf
// 1000:3ba9      74 0a                    JZ 0x1000:3bb5
// 1000:3bab      fe c9                    DEC CL
// 1000:3bad      05 32 00                 ADD AX,0x32
// 1000:3bb0      3d 90 01                 CMP AX,0x190
// 1000:3bb3      72 f1                    JC 0x1000:3ba6
// 1000:3bb5  LAB_1000_3bb5:
// 1000:3bb5      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
// 1000:3bb8      3a c1                    CMP AL,CL
// 1000:3bba      72 07                    JC 0x1000:3bc3
// 1000:3bbc      80 64 0b f0              AND byte ptr [SI + 0xb],0xf0
// 1000:3bc0      08 4c 0b                 OR byte ptr [SI + 0xb],CL
// 1000:3bc3  LAB_1000_3bc3:
// 1000:3bc3      80 e5 0f                 AND CH,0xf
// 1000:3bc6      e8 f8 03                 CALL 0x1000:3fc1
// 1000:3bc9  LAB_1000_3bc9:
// 1000:3bc9      59                       POP CX
// 1000:3bca  LAB_1000_3bca:
// 1000:3bca      83 c7 3b                 ADD DI,0x3b
// 1000:3bcd      49                       DEC CX
// 1000:3bce      74 03                    JZ 0x1000:3bd3
// 1000:3bd0      e9 7a ff                 JMP 0x1000:3b4d
// 1000:3bd3  LAB_1000_3bd3:
// 1000:3bd3      c3                       RET
// 1000:3bd4  LAB_1000_3bd4:
// 1000:3bd4      3c 08                    CMP AL,0x8
// 1000:3bd6      75 4f                    JNZ 0x1000:3c27
// 1000:3bd8      bf 64 8c                 MOV DI,0x8c64
// 1000:3bdb      b9 10 00                 MOV CX,0x10
// 1000:3bde      bb 70 17                 MOV BX,0x1770
// 1000:3be1  LAB_1000_3be1:
// 1000:3be1      8a 44 18                 MOV AL,byte ptr [SI + 0x18]
// 1000:3be4      38 45 18                 CMP byte ptr [DI + 0x18],AL
// 1000:3be7      74 38                    JZ 0x1000:3c21
// 1000:3be9      f6 05 80                 TEST byte ptr [DI],0x80
// 1000:3bec      74 33                    JZ 0x1000:3c21
// 1000:3bee      51                       PUSH CX
// 1000:3bef      81 7c 08 40 9c           CMP word ptr [SI + 0x8],0x9c40
// 1000:3bf4      77 0b                    JA 0x1000:3c01
// 1000:3bf6      f6 45 19 f0              TEST byte ptr [DI + 0x19],0xf0
// 1000:3bfa      75 05                    JNZ 0x1000:3c01
// 1000:3bfc      f6 05 10                 TEST byte ptr [DI],0x10
// 1000:3bff      75 1f                    JNZ 0x1000:3c20
// 1000:3c01  LAB_1000_3c01:
// 1000:3c01      53                       PUSH BX
// 1000:3c02      e8 21 ee                 CALL 0x1000:2a26
// 1000:3c05      5b                       POP BX
// 1000:3c06      3b c3                    CMP AX,BX
// 1000:3c08      77 16                    JA 0x1000:3c20
// 1000:3c0a      89 44 12                 MOV word ptr [SI + 0x12],AX
// 1000:3c0d      8b d8                    MOV BX,AX
// 1000:3c0f      8b 44 01                 MOV AX,word ptr [SI + 0x1]
// 1000:3c12      8a c4                    MOV AL,AH
// 1000:3c14      24 07                    AND AL,0x7
// 1000:3c16      04 04                    ADD AL,0x4
// 1000:3c18      02 e8                    ADD CH,AL
// 1000:3c1a      80 e5 0f                 AND CH,0xf
// 1000:3c1d      e8 a1 03                 CALL 0x1000:3fc1
// 1000:3c20  LAB_1000_3c20:
// 1000:3c20      59                       POP CX
// 1000:3c21  LAB_1000_3c21:
// 1000:3c21      83 c7 3b                 ADD DI,0x3b
// 1000:3c24      e2 bb                    LOOP 0x1000:3be1
// 1000:3c26      c3                       RET
// 1000:3c27  LAB_1000_3c27:
// 1000:3c27      3c 09                    CMP AL,0x9
// 1000:3c29      75 24                    JNZ 0x1000:3c4f
// 1000:3c2b      e8 f7 f5                 CALL 0x1000:3225
// 1000:3c2e      bb 80 3e                 MOV BX,0x3e80
// 1000:3c31  LAB_1000_3c31:
// 1000:3c31      51                       PUSH CX
// 1000:3c32      50                       PUSH AX
// 1000:3c33      22 25                    AND AH,byte ptr [DI]
// 1000:3c35      74 10                    JZ 0x1000:3c47
// 1000:3c37      8a 05                    MOV AL,byte ptr [DI]
// 1000:3c39      24 0f                    AND AL,0xf
// 1000:3c3b      3c 05                    CMP AL,0x5
// 1000:3c3d      75 08                    JNZ 0x1000:3c47
// 1000:3c3f      e8 15 03                 CALL 0x1000:3f57
// 1000:3c42      75 03                    JNZ 0x1000:3c47
// 1000:3c44      e8 23 03                 CALL 0x1000:3f6a
// 1000:3c47  LAB_1000_3c47:
// 1000:3c47      58                       POP AX
// 1000:3c48      59                       POP CX
// 1000:3c49      83 c7 0b                 ADD DI,0xb
// 1000:3c4c      e2 e3                    LOOP 0x1000:3c31
// 1000:3c4e      c3                       RET
// 1000:3c4f  LAB_1000_3c4f:
// 1000:3c4f      3c 0a                    CMP AL,0xa
// 1000:3c51      75 24                    JNZ 0x1000:3c77
// 1000:3c53      e8 cf f5                 CALL 0x1000:3225
// 1000:3c56      bb 80 3e                 MOV BX,0x3e80
// 1000:3c59  LAB_1000_3c59:
// 1000:3c59      51                       PUSH CX
// 1000:3c5a      50                       PUSH AX
// 1000:3c5b      22 25                    AND AH,byte ptr [DI]
// 1000:3c5d      74 10                    JZ 0x1000:3c6f
// 1000:3c5f      8a 05                    MOV AL,byte ptr [DI]
// 1000:3c61      24 0f                    AND AL,0xf
// 1000:3c63      3c 06                    CMP AL,0x6
// 1000:3c65      75 08                    JNZ 0x1000:3c6f
// 1000:3c67      e8 ed 02                 CALL 0x1000:3f57
// 1000:3c6a      75 03                    JNZ 0x1000:3c6f
// 1000:3c6c      e8 fb 02                 CALL 0x1000:3f6a
// 1000:3c6f  LAB_1000_3c6f:
// 1000:3c6f      58                       POP AX
// 1000:3c70      59                       POP CX
// 1000:3c71      83 c7 0b                 ADD DI,0xb
// 1000:3c74      e2 e3                    LOOP 0x1000:3c59
// 1000:3c76      c3                       RET
// 1000:3c77  LAB_1000_3c77:
// 1000:3c77      3c 0b                    CMP AL,0xb
// 1000:3c79      75 2b                    JNZ 0x1000:3ca6
// 1000:3c7b      e8 a7 f5                 CALL 0x1000:3225
// 1000:3c7e      bb 20 4e                 MOV BX,0x4e20
// 1000:3c81      81 7c 08 b8 0b           CMP word ptr [SI + 0x8],0xbb8
// 1000:3c86      77 1d                    JA 0x1000:3ca5
// 1000:3c88  LAB_1000_3c88:
// 1000:3c88      51                       PUSH CX
// 1000:3c89      50                       PUSH AX
// 1000:3c8a      22 25                    AND AH,byte ptr [DI]
// 1000:3c8c      74 10                    JZ 0x1000:3c9e
// 1000:3c8e      8a 05                    MOV AL,byte ptr [DI]
// 1000:3c90      24 0f                    AND AL,0xf
// 1000:3c92      3c 07                    CMP AL,0x7
// 1000:3c94      75 08                    JNZ 0x1000:3c9e
// 1000:3c96      e8 be 02                 CALL 0x1000:3f57
// 1000:3c99      75 03                    JNZ 0x1000:3c9e
// 1000:3c9b      e8 cc 02                 CALL 0x1000:3f6a
// 1000:3c9e  LAB_1000_3c9e:
// 1000:3c9e      58                       POP AX
// 1000:3c9f      59                       POP CX
// 1000:3ca0      83 c7 0b                 ADD DI,0xb
// 1000:3ca3      e2 e3                    LOOP 0x1000:3c88
// 1000:3ca5  LAB_1000_3ca5:
// 1000:3ca5      c3                       RET
// 1000:3ca6  LAB_1000_3ca6:
// 1000:3ca6      3c 0c                    CMP AL,0xc
// 1000:3ca8      75 53                    JNZ 0x1000:3cfd
// 1000:3caa      bb 80 3e                 MOV BX,0x3e80
// 1000:3cad      e8 75 f5                 CALL 0x1000:3225
// 1000:3cb0  LAB_1000_3cb0:
// 1000:3cb0      51                       PUSH CX
// 1000:3cb1      50                       PUSH AX
// 1000:3cb2      22 25                    AND AH,byte ptr [DI]
// 1000:3cb4      74 3f                    JZ 0x1000:3cf5
// 1000:3cb6      e8 9e 02                 CALL 0x1000:3f57
// 1000:3cb9      75 3a                    JNZ 0x1000:3cf5
// 1000:3cbb      8a 05                    MOV AL,byte ptr [DI]
// 1000:3cbd      24 0f                    AND AL,0xf
// 1000:3cbf      2c 0a                    SUB AL,0xa
// 1000:3cc1      72 32                    JC 0x1000:3cf5
// 1000:3cc3      3c 03                    CMP AL,0x3
// 1000:3cc5      77 2e                    JA 0x1000:3cf5
// 1000:3cc7      50                       PUSH AX
// 1000:3cc8      8a 44 2b                 MOV AL,byte ptr [SI + 0x2b]
// 1000:3ccb      3a 44 17                 CMP AL,byte ptr [SI + 0x17]
// 1000:3cce      58                       POP AX
// 1000:3ccf      74 05                    JZ 0x1000:3cd6
// 1000:3cd1      3a 44 2b                 CMP AL,byte ptr [SI + 0x2b]
// 1000:3cd4      75 1f                    JNZ 0x1000:3cf5
// 1000:3cd6  LAB_1000_3cd6:
// 1000:3cd6      86 06 74 a2              XCHG byte ptr [0xa274],AL
// 1000:3cda      50                       PUSH AX
// 1000:3cdb      53                       PUSH BX
// 1000:3cdc      e8 ef e1                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:3ce7  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
// 1000:3ce7  LAB_1000_3ce7:
// 1000:3ce7      83 7f 08 00              CMP word ptr [BX + 0x8],0x0
// 1000:3ceb      5b                       POP BX
// 1000:3cec      58                       POP AX
// 1000:3ced      a2 74 a2                 MOV [0xa274],AL
// 1000:3cf0      74 03                    JZ 0x1000:3cf5
// 1000:3cf2      e8 75 02                 CALL 0x1000:3f6a
// 1000:3cf5  LAB_1000_3cf5:
// 1000:3cf5      58                       POP AX
// 1000:3cf6      59                       POP CX
// 1000:3cf7      83 c7 0b                 ADD DI,0xb
// 1000:3cfa      e2 b4                    LOOP 0x1000:3cb0
// 1000:3cfc      c3                       RET
// 1000:3cfd  LAB_1000_3cfd:
// 1000:3cfd      3c 0d                    CMP AL,0xd
// 1000:3cff      75 23                    JNZ 0x1000:3d24
// 1000:3d01      8b fe                    MOV DI,SI
// 1000:3d03      83 c7 2c                 ADD DI,0x2c
// 1000:3d06      e8 1d ed                 CALL 0x1000:2a26
// 1000:3d09      83 fb f0                 CMP BX,-0x10
// 1000:3d0c      77 11                    JA 0x1000:3d1f
// 1000:3d0e      89 44 12                 MOV word ptr [SI + 0x12],AX
// 1000:3d11      8b d8                    MOV BX,AX
// 1000:3d13      e8 ab 02                 CALL 0x1000:3fc1
// 1000:3d16      83 fb 28                 CMP BX,0x28
// 1000:3d19      77 08                    JA 0x1000:3d23
// 1000:3d1b      c6 44 0b 00              MOV byte ptr [SI + 0xb],0x0
// 1000:3d1f  LAB_1000_3d1f:
// 1000:3d1f      c6 44 11 80              MOV byte ptr [SI + 0x11],0x80
// 1000:3d23  LAB_1000_3d23:
// 1000:3d23      c3                       RET
// 1000:3d24  LAB_1000_3d24:
// 1000:3d24      3c 0e                    CMP AL,0xe
// 1000:3d26      75 24                    JNZ 0x1000:3d4c
// 1000:3d28      e8 fa f4                 CALL 0x1000:3225
// 1000:3d2b      bb 20 4e                 MOV BX,0x4e20
// 1000:3d2e  LAB_1000_3d2e:
// 1000:3d2e      51                       PUSH CX
// 1000:3d2f      50                       PUSH AX
// 1000:3d30      22 25                    AND AH,byte ptr [DI]
// 1000:3d32      74 10                    JZ 0x1000:3d44
// 1000:3d34      8a 05                    MOV AL,byte ptr [DI]
// 1000:3d36      24 0f                    AND AL,0xf
// 1000:3d38      3c 0e                    CMP AL,0xe
// 1000:3d3a      75 08                    JNZ 0x1000:3d44
// 1000:3d3c      e8 18 02                 CALL 0x1000:3f57
// 1000:3d3f      75 03                    JNZ 0x1000:3d44
// 1000:3d41      e8 26 02                 CALL 0x1000:3f6a
// 1000:3d44  LAB_1000_3d44:
// 1000:3d44      58                       POP AX
// 1000:3d45      59                       POP CX
// 1000:3d46      83 c7 0b                 ADD DI,0xb
// 1000:3d49      e2 e3                    LOOP 0x1000:3d2e
// 1000:3d4b      c3                       RET
// 1000:3d4c  LAB_1000_3d4c:
// 1000:3d4c      a8 10                    TEST AL,0x10
// 1000:3d4e      75 01                    JNZ 0x1000:3d51
// 1000:3d50      c3                       RET
// 1000:3d51  LAB_1000_3d51:
// 1000:3d51      e8 7a e1                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:3d5c  [ptr] 1000:8c64 1000:8d50 1000:8e3c 1000:8f28
// 1000:3d5c  LAB_1000_3d5c:
// 1000:3d5c      8a 44 11                 MOV AL,byte ptr [SI + 0x11]
// 1000:3d5f      24 03                    AND AL,0x3
// 1000:3d61      74 07                    JZ 0x1000:3d6a
// 1000:3d63  LAB_1000_3d63:
// 1000:3d63      83 c3 3b                 ADD BX,0x3b
// 1000:3d66      fe c8                    DEC AL
// 1000:3d68      75 f9                    JNZ 0x1000:3d63
// 1000:3d6a  LAB_1000_3d6a:
// 1000:3d6a      8b fb                    MOV DI,BX
// 1000:3d6c      f6 05 80                 TEST byte ptr [DI],0x80
// 1000:3d6f      75 05                    JNZ 0x1000:3d76
// 1000:3d71      c6 44 11 80              MOV byte ptr [SI + 0x11],0x80
// 1000:3d75      c3                       RET
// 1000:3d76  LAB_1000_3d76:
// 1000:3d76      e8 ad ec                 CALL 0x1000:2a26
// 1000:3d79      89 44 12                 MOV word ptr [SI + 0x12],AX
// 1000:3d7c      8b d8                    MOV BX,AX
// 1000:3d7e      e8 40 02                 CALL 0x1000:3fc1
// 1000:3d81      81 fb fa 00              CMP BX,0xfa
// 1000:3d85      76 01                    JBE 0x1000:3d88
// 1000:3d87      c3                       RET
// 1000:3d88  LAB_1000_3d88:
// 1000:3d88      b1 04                    MOV CL,0x4
// 1000:3d8a      c6 44 34 01              MOV byte ptr [SI + 0x34],0x1
// 1000:3d8e      c6 45 34 01              MOV byte ptr [DI + 0x34],0x1
// 1000:3d92      56                       PUSH SI
// 1000:3d93      57                       PUSH DI
// 1000:3d94      87 f7                    XCHG DI,SI
// 1000:3d96      8b 44 01                 MOV AX,word ptr [SI + 0x1]
// 1000:3d99      89 45 01                 MOV word ptr [DI + 0x1],AX
// 1000:3d9c      8b 44 03                 MOV AX,word ptr [SI + 0x3]
// 1000:3d9f      89 45 03                 MOV word ptr [DI + 0x3],AX
// 1000:3da2      8a 44 14                 MOV AL,byte ptr [SI + 0x14]
// 1000:3da5      88 45 14                 MOV byte ptr [DI + 0x14],AL
// 1000:3da8      8b 44 0a                 MOV AX,word ptr [SI + 0xa]
// 1000:3dab      89 45 0a                 MOV word ptr [DI + 0xa],AX
// 1000:3dae      8b de                    MOV BX,SI
// 1000:3db0      83 7f 32 00              CMP word ptr [BX + 0x32],0x0
// 1000:3db4      74 12                    JZ 0x1000:3dc8
// 1000:3db6      8b 5f 32                 MOV BX,word ptr [BX + 0x32]
// 1000:3db9      80 c1 08                 ADD CL,0x8
// 1000:3dbc      83 7f 32 00              CMP word ptr [BX + 0x32],0x0
// 1000:3dc0      74 06                    JZ 0x1000:3dc8
// 1000:3dc2      8b 5f 32                 MOV BX,word ptr [BX + 0x32]
// 1000:3dc5      80 e9 04                 SUB CL,0x4
// 1000:3dc8  LAB_1000_3dc8:
// 1000:3dc8      89 7f 32                 MOV word ptr [BX + 0x32],DI
// 1000:3dcb      c7 45 32 00 00           MOV word ptr [DI + 0x32],0x0
// 1000:3dd0      02 c1                    ADD AL,CL
// 1000:3dd2      b4 0b                    MOV AH,0xb
// 1000:3dd4      e8 53 fa                 CALL 0x1000:382a
// 1000:3dd7      8b 44 08                 MOV AX,word ptr [SI + 0x8]
// 1000:3dda      3b 45 08                 CMP AX,word ptr [DI + 0x8]
// 1000:3ddd      77 02                    JA 0x1000:3de1
// 1000:3ddf      87 f7                    XCHG DI,SI
// 1000:3de1  LAB_1000_3de1:
// 1000:3de1      8b 44 08                 MOV AX,word ptr [SI + 0x8]
// 1000:3de4      2b 45 08                 SUB AX,word ptr [DI + 0x8]
// 1000:3de7      d1 e8                    SHR AX,0x1
// 1000:3de9      d1 e8                    SHR AX,0x1
// 1000:3deb      d1 e8                    SHR AX,0x1
// 1000:3ded      d1 e8                    SHR AX,0x1
// 1000:3def      29 44 08                 SUB word ptr [SI + 0x8],AX
// 1000:3df2      01 45 08                 ADD word ptr [DI + 0x8],AX
// 1000:3df5      8a 44 07                 MOV AL,byte ptr [SI + 0x7]
// 1000:3df8      3a 45 07                 CMP AL,byte ptr [DI + 0x7]
// 1000:3dfb      77 02                    JA 0x1000:3dff
// 1000:3dfd      87 f7                    XCHG DI,SI
// 1000:3dff  LAB_1000_3dff:
// 1000:3dff      8a 44 07                 MOV AL,byte ptr [SI + 0x7]
// 1000:3e02      2a 45 07                 SUB AL,byte ptr [DI + 0x7]
// 1000:3e05      3c 02                    CMP AL,0x2
// 1000:3e07      72 06                    JC 0x1000:3e0f
// 1000:3e09      fe 4c 07                 DEC byte ptr [SI + 0x7]
// 1000:3e0c      fe 45 07                 INC byte ptr [DI + 0x7]
// 1000:3e0f  LAB_1000_3e0f:
// 1000:3e0f      8a 44 0f                 MOV AL,byte ptr [SI + 0xf]
// 1000:3e12      3a 45 0f                 CMP AL,byte ptr [DI + 0xf]
// 1000:3e15      77 02                    JA 0x1000:3e19
// 1000:3e17      87 f7                    XCHG DI,SI
// 1000:3e19  LAB_1000_3e19:
// 1000:3e19      8a 44 0f                 MOV AL,byte ptr [SI + 0xf]
// 1000:3e1c      2a 45 0f                 SUB AL,byte ptr [DI + 0xf]
// 1000:3e1f      d0 e8                    SHR AL,0x1
// 1000:3e21      28 44 0f                 SUB byte ptr [SI + 0xf],AL
// 1000:3e24      00 45 0f                 ADD byte ptr [DI + 0xf],AL
// 1000:3e27      5f                       POP DI
// 1000:3e28      5e                       POP SI
// 1000:3e29      c3                       RET
fun_39bf :: proc() {
}

// @proc 1000:3e2a
// listing: FUN_1000_3e2a
// status: unread
// 1000:3e2a  FUN_1000_3e2a:
// 1000:3e2a      81 7c 08 a8 61           CMP word ptr [SI + 0x8],0x61a8
// 1000:3e2f      77 53                    JA 0x1000:3e84
// 1000:3e31      3d 2c 01                 CMP AX,0x12c
// 1000:3e34      72 4e                    JC 0x1000:3e84
// 1000:3e36      2d 2c 01                 SUB AX,0x12c
// 1000:3e39      81 7c 08 20 4e           CMP word ptr [SI + 0x8],0x4e20
// 1000:3e3e      77 44                    JA 0x1000:3e84
// 1000:3e40      3d 2c 01                 CMP AX,0x12c
// 1000:3e43      72 3f                    JC 0x1000:3e84
// 1000:3e45      2d 2c 01                 SUB AX,0x12c
// 1000:3e48      81 7c 08 98 3a           CMP word ptr [SI + 0x8],0x3a98
// 1000:3e4d      77 35                    JA 0x1000:3e84
// 1000:3e4f      3d 2c 01                 CMP AX,0x12c
// 1000:3e52      72 30                    JC 0x1000:3e84
// 1000:3e54      2d 2c 01                 SUB AX,0x12c
// 1000:3e57      81 7c 08 10 27           CMP word ptr [SI + 0x8],0x2710
// 1000:3e5c      77 26                    JA 0x1000:3e84
// 1000:3e5e      3d 2c 01                 CMP AX,0x12c
// 1000:3e61      72 21                    JC 0x1000:3e84
// 1000:3e63      2d 2c 01                 SUB AX,0x12c
// 1000:3e66      81 7c 08 4c 1d           CMP word ptr [SI + 0x8],0x1d4c
// 1000:3e6b      77 17                    JA 0x1000:3e84
// 1000:3e6d      3d 2c 01                 CMP AX,0x12c
// 1000:3e70      72 12                    JC 0x1000:3e84
// 1000:3e72      2d 2c 01                 SUB AX,0x12c
// 1000:3e75      81 7c 08 a0 0f           CMP word ptr [SI + 0x8],0xfa0
// 1000:3e7a      77 08                    JA 0x1000:3e84
// 1000:3e7c      3d 2c 01                 CMP AX,0x12c
// 1000:3e7f      72 03                    JC 0x1000:3e84
// 1000:3e81      2d 2c 01                 SUB AX,0x12c
// 1000:3e84  LAB_1000_3e84:
// 1000:3e84      c3                       RET
fun_3e2a :: proc() {
}

// @proc 1000:3e85
// listing: FUN_1000_3e85
// status: unread
// 1000:3e85  FUN_1000_3e85:
// 1000:3e85      8a 44 1f                 MOV AL,byte ptr [SI + 0x1f]
// 1000:3e88      a2 81 a2                 MOV [0xa281],AL
// 1000:3e8b      b9 04 00                 MOV CX,0x4
// 1000:3e8e      bf 14 90                 MOV DI,0x9014
// 1000:3e91      56                       PUSH SI
// 1000:3e92      bb b8 0b                 MOV BX,0xbb8
// 1000:3e95  LAB_1000_3e95:
// 1000:3e95      83 7d 08 00              CMP word ptr [DI + 0x8],0x0
// 1000:3e99      74 2b                    JZ 0x1000:3ec6
// 1000:3e9b      8a 44 18                 MOV AL,byte ptr [SI + 0x18]
// 1000:3e9e      38 45 0c                 CMP byte ptr [DI + 0xc],AL
// 1000:3ea1      74 23                    JZ 0x1000:3ec6
// 1000:3ea3      8a 44 2b                 MOV AL,byte ptr [SI + 0x2b]
// 1000:3ea6      3a 44 17                 CMP AL,byte ptr [SI + 0x17]
// 1000:3ea9      74 05                    JZ 0x1000:3eb0
// 1000:3eab      3a 45 0b                 CMP AL,byte ptr [DI + 0xb]
// 1000:3eae      75 16                    JNZ 0x1000:3ec6
// 1000:3eb0  LAB_1000_3eb0:
// 1000:3eb0      51                       PUSH CX
// 1000:3eb1      56                       PUSH SI
// 1000:3eb2      83 c6 19                 ADD SI,0x19
// 1000:3eb5      53                       PUSH BX
// 1000:3eb6      e8 6d eb                 CALL 0x1000:2a26
// 1000:3eb9      5b                       POP BX
// 1000:3eba      5e                       POP SI
// 1000:3ebb      3b c3                    CMP AX,BX
// 1000:3ebd      77 06                    JA 0x1000:3ec5
// 1000:3ebf      8b d8                    MOV BX,AX
// 1000:3ec1      88 2e 81 a2              MOV byte ptr [0xa281],CH
// 1000:3ec5  LAB_1000_3ec5:
// 1000:3ec5      59                       POP CX
// 1000:3ec6  LAB_1000_3ec6:
// 1000:3ec6      83 c7 0e                 ADD DI,0xe
// 1000:3ec9      e2 ca                    LOOP 0x1000:3e95
// 1000:3ecb      5e                       POP SI
// 1000:3ecc      bf 64 8c                 MOV DI,0x8c64
// 1000:3ecf      b9 10 00                 MOV CX,0x10
// 1000:3ed2  LAB_1000_3ed2:
// 1000:3ed2      8a 44 18                 MOV AL,byte ptr [SI + 0x18]
// 1000:3ed5      38 45 18                 CMP byte ptr [DI + 0x18],AL
// 1000:3ed8      74 34                    JZ 0x1000:3f0e
// 1000:3eda      f6 05 80                 TEST byte ptr [DI],0x80
// 1000:3edd      74 2f                    JZ 0x1000:3f0e
// 1000:3edf      f6 05 10                 TEST byte ptr [DI],0x10
// 1000:3ee2      74 07                    JZ 0x1000:3eeb
// 1000:3ee4      f6 06 d2 89 01           TEST byte ptr [0x89d2],0x1
// 1000:3ee9      75 23                    JNZ 0x1000:3f0e
// 1000:3eeb  LAB_1000_3eeb:
// 1000:3eeb      8a 44 2b                 MOV AL,byte ptr [SI + 0x2b]
// 1000:3eee      3a 44 17                 CMP AL,byte ptr [SI + 0x17]
// 1000:3ef1      74 05                    JZ 0x1000:3ef8
// 1000:3ef3      3a 45 17                 CMP AL,byte ptr [DI + 0x17]
// 1000:3ef6      75 16                    JNZ 0x1000:3f0e
// 1000:3ef8  LAB_1000_3ef8:
// 1000:3ef8      51                       PUSH CX
// 1000:3ef9      56                       PUSH SI
// 1000:3efa      83 c6 19                 ADD SI,0x19
// 1000:3efd      53                       PUSH BX
// 1000:3efe      e8 25 eb                 CALL 0x1000:2a26
// 1000:3f01      5b                       POP BX
// 1000:3f02      5e                       POP SI
// 1000:3f03      3b c3                    CMP AX,BX
// 1000:3f05      77 06                    JA 0x1000:3f0d
// 1000:3f07      8b d8                    MOV BX,AX
// 1000:3f09      88 2e 81 a2              MOV byte ptr [0xa281],CH
// 1000:3f0d  LAB_1000_3f0d:
// 1000:3f0d      59                       POP CX
// 1000:3f0e  LAB_1000_3f0e:
// 1000:3f0e      83 c7 3b                 ADD DI,0x3b
// 1000:3f11      e2 bf                    LOOP 0x1000:3ed2
// 1000:3f13      f6 44 19 44              TEST byte ptr [SI + 0x19],0x44
// 1000:3f17      74 04                    JZ 0x1000:3f1d
// 1000:3f19      d1 eb                    SHR BX,0x1
// 1000:3f1b      d1 eb                    SHR BX,0x1
// 1000:3f1d  LAB_1000_3f1d:
// 1000:3f1d      8a 2e 81 a2              MOV CH,byte ptr [0xa281]
// 1000:3f21      8a 4c 1f                 MOV CL,byte ptr [SI + 0x1f]
// 1000:3f24      81 fb 90 01              CMP BX,0x190
// 1000:3f28      77 02                    JA 0x1000:3f2c
// 1000:3f2a      8a cd                    MOV CL,CH
// 1000:3f2c  LAB_1000_3f2c:
// 1000:3f2c      80 e1 0f                 AND CL,0xf
// 1000:3f2f      2a e9                    SUB CH,CL
// 1000:3f31      74 1d                    JZ 0x1000:3f50
// 1000:3f33      79 03                    JNS 0x1000:3f38
// 1000:3f35      80 c5 10                 ADD CH,0x10
// 1000:3f38  LAB_1000_3f38:
// 1000:3f38      fe c1                    INC CL
// 1000:3f3a      80 fd 04                 CMP CH,0x4
// 1000:3f3d      76 11                    JBE 0x1000:3f50
// 1000:3f3f      fe c1                    INC CL
// 1000:3f41      80 fd 08                 CMP CH,0x8
// 1000:3f44      76 0a                    JBE 0x1000:3f50
// 1000:3f46      80 e9 04                 SUB CL,0x4
// 1000:3f49      80 fd 0b                 CMP CH,0xb
// 1000:3f4c      76 02                    JBE 0x1000:3f50
// 1000:3f4e      fe c1                    INC CL
// 1000:3f50  LAB_1000_3f50:
// 1000:3f50      80 e1 0f                 AND CL,0xf
// 1000:3f53      88 4c 1f                 MOV byte ptr [SI + 0x1f],CL
// 1000:3f56      c3                       RET
fun_3e85 :: proc() {
}

// 1000:3f57 planet_team_flag is in ship.odin.

// @proc 1000:3f6a
// listing: FUN_1000_3f6a
// status: unread
// 1000:3f6a  FUN_1000_3f6a:
// 1000:3f6a      53                       PUSH BX
// 1000:3f6b      e8 b8 ea                 CALL 0x1000:2a26
// 1000:3f6e      5b                       POP BX
// 1000:3f6f      3b c3                    CMP AX,BX
// 1000:3f71      73 3f                    JNC 0x1000:3fb2
// 1000:3f73      89 44 12                 MOV word ptr [SI + 0x12],AX
// 1000:3f76      8b d8                    MOV BX,AX
// 1000:3f78      3d c8 00                 CMP AX,0xc8
// 1000:3f7b      77 2d                    JA 0x1000:3faa
// 1000:3f7d      c6 44 14 00              MOV byte ptr [SI + 0x14],0x0
// 1000:3f81      b4 05                    MOV AH,0x5
// 1000:3f83      3c 96                    CMP AL,0x96
// 1000:3f85      77 1a                    JA 0x1000:3fa1
// 1000:3f87      fe cc                    DEC AH
// 1000:3f89      3c 6e                    CMP AL,0x6e
// 1000:3f8b      77 14                    JA 0x1000:3fa1
// 1000:3f8d      fe cc                    DEC AH
// 1000:3f8f      3c 55                    CMP AL,0x55
// 1000:3f91      77 0e                    JA 0x1000:3fa1
// 1000:3f93      fe cc                    DEC AH
// 1000:3f95      3c 3c                    CMP AL,0x3c
// 1000:3f97      77 08                    JA 0x1000:3fa1
// 1000:3f99      fe cc                    DEC AH
// 1000:3f9b      3c 28                    CMP AL,0x28
// 1000:3f9d      77 02                    JA 0x1000:3fa1
// 1000:3f9f      fe cc                    DEC AH
// 1000:3fa1  LAB_1000_3fa1:
// 1000:3fa1      80 64 0b f0              AND byte ptr [SI + 0xb],0xf0
// 1000:3fa5      08 64 0b                 OR byte ptr [SI + 0xb],AH
// 1000:3fa8      32 e4                    XOR AH,AH
// 1000:3faa  LAB_1000_3faa:
// 1000:3faa      80 e5 0f                 AND CH,0xf
// 1000:3fad      3d 0a 00                 CMP AX,0xa
// 1000:3fb0      77 0f                    JA 0x1000:3fc1
// 1000:3fb2  LAB_1000_3fb2:
// 1000:3fb2      c3                       RET
fun_3f6a :: proc() {
}

// @proc 1000:3fb3
// listing: FUN_1000_3fb3
// status: unread
// 1000:3fb3  FUN_1000_3fb3:
// 1000:3fb3      53                       PUSH BX
// 1000:3fb4      e8 6f ea                 CALL 0x1000:2a26
// 1000:3fb7      5b                       POP BX
// 1000:3fb8      3b c3                    CMP AX,BX
// 1000:3fba      77 14                    JA 0x1000:3fd0
// 1000:3fbc      89 44 12                 MOV word ptr [SI + 0x12],AX
// 1000:3fbf      8b d8                    MOV BX,AX
fun_3fb3 :: proc() {
}

// 1000:3fc1 store_desired_heading is in ship.odin.

