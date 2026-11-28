package trek

// Procedures 1000:3fd1 through 1000:43b1.
// 1000:4530 through 1000:580c are in draw.odin.
// The assembly is the listing. The body is empty until the procedure is translated.
// A notes line is a name already supported by the annotation notes.

// @proc 1000:3fd1
// listing: FUN_1000_3fd1
// notes: build_universe
// status: unread
// 1000:3fd1  FUN_1000_3fd1:
// 1000:3fd1      ff 36 d0 89              PUSH word ptr [0x89d0]
// 1000:3fd5      bf d0 89                 MOV DI,0x89d0
// 1000:3fd8      8b 0e d1 00              MOV CX,word ptr [0xd1]
// 1000:3fdc      b0 00                    MOV AL,0x0
// 1000:3fde      f3 aa                    STOSB.REP ES:DI
// 1000:3fe0      8f 06 d0 89              POP word ptr [0x89d0]
// 1000:3fe4      c6 06 74 a2 00           MOV byte ptr [0xa274],0x0
// 1000:3fe9      c6 06 82 a2 00           MOV byte ptr [0xa282],0x0
// 1000:3fee  LAB_1000_3fee:
// 1000:3fee      e8 dd de                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:3ff9  [ptr] 1000:a226 1000:a231 1000:a23c 1000:a247
// 1000:3ff9  LAB_1000_3ff9:
// 1000:3ff9      8a 07                    MOV AL,byte ptr [BX]
// 1000:3ffb      50                       PUSH AX
// 1000:3ffc      e8 cf de                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:4007  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
// 1000:4007  LAB_1000_4007:
// 1000:4007      8b f3                    MOV SI,BX
// 1000:4009      58                       POP AX
// 1000:400a      22 c0                    AND AL,AL
// 1000:400c      74 36                    JZ 0x1000:4044
// 1000:400e      e8 6c 02                 CALL 0x1000:427d
// 1000:4011      fe 06 d2 89              INC byte ptr [0x89d2]
// 1000:4015      bd 7c 15                 MOV BP,0x157c
// 1000:4018      ba d0 07                 MOV DX,0x7d0
// 1000:401b      e8 f9 01                 CALL 0x1000:4217
// 1000:401e      72 ce                    JC 0x1000:3fee
// 1000:4020      e8 90 e3                 CALL 0x1000:23b3
// 1000:4023      c7 44 08 a8 61           MOV word ptr [SI + 0x8],0x61a8
// 1000:4028      c6 44 07 af              MOV byte ptr [SI + 0x7],0xaf
// 1000:402c      3c 03                    CMP AL,0x3
// 1000:402e      73 09                    JNC 0x1000:4039
// 1000:4030      c7 44 08 20 4e           MOV word ptr [SI + 0x8],0x4e20
// 1000:4035      c6 44 07 7d              MOV byte ptr [SI + 0x7],0x7d
// 1000:4039  LAB_1000_4039:
// 1000:4039      c6 44 06 14              MOV byte ptr [SI + 0x6],0x14
// 1000:403d      d0 e0                    SHL AL,0x1
// 1000:403f      04 04                    ADD AL,0x4
// 1000:4041      88 44 0a                 MOV byte ptr [SI + 0xa],AL
// 1000:4044  LAB_1000_4044:
// 1000:4044      a0 82 a2                 MOV AL,[0xa282]
// 1000:4047      88 44 0c                 MOV byte ptr [SI + 0xc],AL
// 1000:404a      a0 74 a2                 MOV AL,[0xa274]
// 1000:404d      88 44 0b                 MOV byte ptr [SI + 0xb],AL
// 1000:4050      c6 44 0d 04              MOV byte ptr [SI + 0xd],0x4
// 1000:4054      f6 06 12 00 02           TEST byte ptr [0x12],0x2
// 1000:4059      74 03                    JZ 0x1000:405e
// 1000:405b      88 44 05                 MOV byte ptr [SI + 0x5],AL
// 1000:405e  LAB_1000_405e:
// 1000:405e      e8 6d de                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:4069  [ptr] 1000:904c 1000:90ec 1000:918c 1000:922c
// 1000:4069  LAB_1000_4069:
// 1000:4069      8b fb                    MOV DI,BX
// 1000:406b      b9 14 00                 MOV CX,0x14
// 1000:406e      a0 82 a2                 MOV AL,[0xa282]
// 1000:4071      8a 26 74 a2              MOV AH,byte ptr [0xa274]
// 1000:4075  LAB_1000_4075:
// 1000:4075      c6 05 00                 MOV byte ptr [DI],0x0
// 1000:4078      88 65 06                 MOV byte ptr [DI + 0x6],AH
// 1000:407b      88 45 07                 MOV byte ptr [DI + 0x7],AL
// 1000:407e      83 c7 08                 ADD DI,0x8
// 1000:4081      e2 f2                    LOOP 0x1000:4075
// 1000:4083      fe 06 74 a2              INC byte ptr [0xa274]
// 1000:4087      80 3e 74 a2 04           CMP byte ptr [0xa274],0x4
// 1000:408c      73 1e                    JNC 0x1000:40ac
// 1000:408e      e8 3d de                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:4099  [ptr] 1000:a226 1000:a231 1000:a23c 1000:a247
// 1000:4099  LAB_1000_4099:
// 1000:4099      8a 26 74 a2              MOV AH,byte ptr [0xa274]
// 1000:409d      8a 07                    MOV AL,byte ptr [BX]
// 1000:409f      3c 6d                    CMP AL,0x6d
// 1000:40a1      75 02                    JNZ 0x1000:40a5
// 1000:40a3      b4 20                    MOV AH,0x20
// 1000:40a5  LAB_1000_40a5:
// 1000:40a5      88 26 82 a2              MOV byte ptr [0xa282],AH
// 1000:40a9      e9 42 ff                 JMP 0x1000:3fee
// 1000:40ac  LAB_1000_40ac:
// 1000:40ac      80 3e 71 a2 01           CMP byte ptr [0xa271],0x1
// 1000:40b1      75 01                    JNZ 0x1000:40b4
// 1000:40b3      c3                       RET
// 1000:40b4  LAB_1000_40b4:
// 1000:40b4      b0 00                    MOV AL,0x0
// 1000:40b6  LAB_1000_40b6:
// 1000:40b6      50                       PUSH AX
// 1000:40b7      e8 6e f1                 CALL 0x1000:3228
// 1000:40ba      8b f7                    MOV SI,DI
// 1000:40bc      b9 00 00                 MOV CX,0x0
// 1000:40bf  LAB_1000_40bf:
// 1000:40bf      58                       POP AX
// 1000:40c0      50                       PUSH AX
// 1000:40c1      88 44 05                 MOV byte ptr [SI + 0x5],AL
// 1000:40c4      51                       PUSH CX
// 1000:40c5  LAB_1000_40c5:
// 1000:40c5      e8 32 01                 CALL 0x1000:41fa
// 1000:40c8      f6 06 12 00 02           TEST byte ptr [0x12],0x2
// 1000:40cd      74 0c                    JZ 0x1000:40db
// 1000:40cf      3d b8 0b                 CMP AX,0xbb8
// 1000:40d2      77 07                    JA 0x1000:40db
// 1000:40d4      59                       POP CX
// 1000:40d5      51                       PUSH CX
// 1000:40d6      83 f9 06                 CMP CX,0x6
// 1000:40d9      72 ea                    JC 0x1000:40c5
// 1000:40db  LAB_1000_40db:
// 1000:40db      59                       POP CX
// 1000:40dc      51                       PUSH CX
// 1000:40dd      b0 07                    MOV AL,0x7
// 1000:40df      e3 27                    JCXZ 0x1000:4108
// 1000:40e1      b0 0e                    MOV AL,0xe
// 1000:40e3      83 f9 02                 CMP CX,0x2
// 1000:40e6      76 20                    JBE 0x1000:4108
// 1000:40e8      f6 06 12 00 02           TEST byte ptr [0x12],0x2
// 1000:40ed      74 05                    JZ 0x1000:40f4
// 1000:40ef      e8 eb 01                 CALL 0x1000:42dd
// 1000:40f2      72 14                    JC 0x1000:4108
// 1000:40f4  LAB_1000_40f4:
// 1000:40f4      e8 83 02                 CALL 0x1000:437a
// 1000:40f7      24 1f                    AND AL,0x1f
// 1000:40f9      3c 0f                    CMP AL,0xf
// 1000:40fb      8a d0                    MOV DL,AL
// 1000:40fd      74 09                    JZ 0x1000:4108
// 1000:40ff      b2 00                    MOV DL,0x0
// 1000:4101      24 03                    AND AL,0x3
// 1000:4103      74 03                    JZ 0x1000:4108
// 1000:4105      e8 a4 01                 CALL 0x1000:42ac
// 1000:4108  LAB_1000_4108:
// 1000:4108      e8 e5 00                 CALL 0x1000:41f0
// 1000:410b      88 04                    MOV byte ptr [SI],AL
// 1000:410d      c6 44 07 00              MOV byte ptr [SI + 0x7],0x0
// 1000:4111      c6 44 08 00              MOV byte ptr [SI + 0x8],0x0
// 1000:4115      c6 44 06 00              MOV byte ptr [SI + 0x6],0x0
// 1000:4119      c6 44 0a ff              MOV byte ptr [SI + 0xa],0xff
// 1000:411d      24 0f                    AND AL,0xf
// 1000:411f      74 03                    JZ 0x1000:4124
// 1000:4121      e9 89 00                 JMP 0x1000:41ad
// 1000:4124  LAB_1000_4124:
// 1000:4124      8b fe                    MOV DI,SI
// 1000:4126      e8 51 02                 CALL 0x1000:437a
// 1000:4129      25 03 00                 AND AX,0x3
// 1000:412c      ba 00 00                 MOV DX,0x0
// 1000:412f      74 0f                    JZ 0x1000:4140
// 1000:4131      b2 01                    MOV DL,0x1
// 1000:4133      fe c8                    DEC AL
// 1000:4135      74 09                    JZ 0x1000:4140
// 1000:4137      b2 02                    MOV DL,0x2
// 1000:4139      fe c8                    DEC AL
// 1000:413b      74 03                    JZ 0x1000:4140
// 1000:413d      ba 01 02                 MOV DX,0x201
// 1000:4140  LAB_1000_4140:
// 1000:4140      e8 37 02                 CALL 0x1000:437a
// 1000:4143      3c fa                    CMP AL,0xfa
// 1000:4145      77 f9                    JA 0x1000:4140
// 1000:4147      3c 28                    CMP AL,0x28
// 1000:4149      72 f5                    JC 0x1000:4140
// 1000:414b      88 44 06                 MOV byte ptr [SI + 0x6],AL
// 1000:414e  LAB_1000_414e:
// 1000:414e      59                       POP CX
// 1000:414f      80 fa 00                 CMP DL,0x0
// 1000:4152      74 56                    JZ 0x1000:41aa
// 1000:4154      41                       INC CX
// 1000:4155      3a 0e 00 00              CMP CL,byte ptr [0x0]
// 1000:4159      74 60                    JZ 0x1000:41bb
// 1000:415b      51                       PUSH CX
// 1000:415c      83 c7 0b                 ADD DI,0xb
// 1000:415f      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
// 1000:4162      88 45 05                 MOV byte ptr [DI + 0x5],AL
// 1000:4165      8b 44 01                 MOV AX,word ptr [SI + 0x1]
// 1000:4168      89 45 01                 MOV word ptr [DI + 0x1],AX
// 1000:416b      8b 44 03                 MOV AX,word ptr [SI + 0x3]
// 1000:416e      05 c8 00                 ADD AX,0xc8
// 1000:4171      80 fa 01                 CMP DL,0x1
// 1000:4174      74 03                    JZ 0x1000:4179
// 1000:4176      05 c8 00                 ADD AX,0xc8
// 1000:4179  LAB_1000_4179:
// 1000:4179      89 45 03                 MOV word ptr [DI + 0x3],AX
// 1000:417c      c6 45 06 00              MOV byte ptr [DI + 0x6],0x0
// 1000:4180      c6 45 07 00              MOV byte ptr [DI + 0x7],0x0
// 1000:4184      88 55 08                 MOV byte ptr [DI + 0x8],DL
// 1000:4187      c6 45 0a ff              MOV byte ptr [DI + 0xa],0xff
// 1000:418b  LAB_1000_418b:
// 1000:418b      e8 1e 01                 CALL 0x1000:42ac
// 1000:418e      3c 0e                    CMP AL,0xe
// 1000:4190      74 f9                    JZ 0x1000:418b
// 1000:4192      e8 5b 00                 CALL 0x1000:41f0
// 1000:4195      88 05                    MOV byte ptr [DI],AL
// 1000:4197      e8 e0 01                 CALL 0x1000:437a
// 1000:419a      25 3f 00                 AND AX,0x3f
// 1000:419d      8b c8                    MOV CX,AX
// 1000:419f  LAB_1000_419f:
// 1000:419f      e8 0f 02                 CALL 0x1000:43b1
// 1000:41a2      e2 fb                    LOOP 0x1000:419f
// 1000:41a4      8a d6                    MOV DL,DH
// 1000:41a6      b6 00                    MOV DH,0x0
// 1000:41a8      eb a4                    JMP 0x1000:414e
// 1000:41aa  LAB_1000_41aa:
// 1000:41aa      51                       PUSH CX
// 1000:41ab      8b f7                    MOV SI,DI
// 1000:41ad  LAB_1000_41ad:
// 1000:41ad      59                       POP CX
// 1000:41ae      83 c6 0b                 ADD SI,0xb
// 1000:41b1      41                       INC CX
// 1000:41b2      3a 0e 00 00              CMP CL,byte ptr [0x0]
// 1000:41b6      74 03                    JZ 0x1000:41bb
// 1000:41b8      e9 04 ff                 JMP 0x1000:40bf
// 1000:41bb  LAB_1000_41bb:
// 1000:41bb      58                       POP AX
// 1000:41bc      fe c0                    INC AL
// 1000:41be      3a 06 02 00              CMP AL,byte ptr [0x2]
// 1000:41c2      73 03                    JNC 0x1000:41c7
// 1000:41c4      e9 ef fe                 JMP 0x1000:40b6
// 1000:41c7  LAB_1000_41c7:
// 1000:41c7      be 8c 8a                 MOV SI,0x8a8c
// 1000:41ca      8a 0e 01 00              MOV CL,byte ptr [0x1]
// 1000:41ce      32 ed                    XOR CH,CH
// 1000:41d0  LAB_1000_41d0:
// 1000:41d0      e8 3f 01                 CALL 0x1000:4312
// 1000:41d3      83 c6 3b                 ADD SI,0x3b
// 1000:41d6      e2 f8                    LOOP 0x1000:41d0
// 1000:41d8      bb d4 89                 MOV BX,0x89d4
// 1000:41db      b9 04 00                 MOV CX,0x4
// 1000:41de  LAB_1000_41de:
// 1000:41de      e8 99 01                 CALL 0x1000:437a
// 1000:41e1      24 03                    AND AL,0x3
// 1000:41e3      0c 50                    OR AL,0x50
// 1000:41e5      88 07                    MOV byte ptr [BX],AL
// 1000:41e7      43                       INC BX
// 1000:41e8      e2 f4                    LOOP 0x1000:41de
// 1000:41ea      c6 06 d2 89 00           MOV byte ptr [0x89d2],0x0
// 1000:41ef      c3                       RET
fun_3fd1 :: proc() {
}

// 1000:41f0 timed_type is in planet.odin.

// 1000:41fa place_planet_coords is in planet.odin.

// 1000:4217 reject_near_base is in planet.odin.

// 1000:425b reject_near_planet is in planet.odin.

// 1000:427d place_base_coords is in planet.odin.

// 1000:428a random_base_coord is in planet.odin.

// 1000:429b random_planet_coord is in planet.odin.

// 1000:42ac random_planet_type is in planet.odin.

// 1000:42dd satellite_level is in planet.odin.

// 1000:4312 fill_extra_record is in planet.odin.

// 1000:437a mix_rng is in planet.odin.

// 1000:43b1 step_orbit is in planet.odin.

// 1000:4459 spawn_ship is in ship.odin.

// 1000:4530 through 1000:580c are in draw.odin.

