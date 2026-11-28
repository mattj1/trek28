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

// @proc 1000:41f0
// listing: FUN_1000_41f0
// status: unread
// 1000:41f0  FUN_1000_41f0:
// 1000:41f0      f6 06 12 00 01           TEST byte ptr [0x12],0x1
// 1000:41f5      74 02                    JZ 0x1000:41f9
// 1000:41f7      0c f0                    OR AL,0xf0
// 1000:41f9  LAB_1000_41f9:
// 1000:41f9      c3                       RET
fun_41f0 :: proc() {
}

// @proc 1000:41fa
// listing: FUN_1000_41fa
// status: unread
// 1000:41fa  FUN_1000_41fa:
// 1000:41fa      e8 9e 00                 CALL 0x1000:429b
// 1000:41fd      89 44 01                 MOV word ptr [SI + 0x1],AX
// 1000:4200      e8 98 00                 CALL 0x1000:429b
// 1000:4203      89 44 03                 MOV word ptr [SI + 0x3],AX
// 1000:4206      e8 52 00                 CALL 0x1000:425b
// 1000:4209      72 ef                    JC 0x1000:41fa
// 1000:420b      bd e8 03                 MOV BP,0x3e8
// 1000:420e      ba 70 17                 MOV DX,0x1770
// 1000:4211      e8 03 00                 CALL 0x1000:4217
// 1000:4214      72 e4                    JC 0x1000:41fa
// 1000:4216      c3                       RET
fun_41fa :: proc() {
}

// @proc 1000:4217
// listing: FUN_1000_4217
// status: unread
// 1000:4217  FUN_1000_4217:
// 1000:4217      51                       PUSH CX
// 1000:4218      f6 06 12 00 02           TEST byte ptr [0x12],0x2
// 1000:421d      74 19                    JZ 0x1000:4238
// 1000:421f      bf 00 01                 MOV DI,0x100
// 1000:4222      b1 05                    MOV CL,0x5
// 1000:4224      52                       PUSH DX
// 1000:4225      e8 a4 e1                 CALL 0x1000:23cc
// 1000:4228      5a                       POP DX
// 1000:4229      3b c2                    CMP AX,DX
// 1000:422b      f5                       CMC
// 1000:422c      72 2b                    JC 0x1000:4259
// 1000:422e      81 fd 7c 15              CMP BP,0x157c
// 1000:4232      f8                       CLC
// 1000:4233      75 03                    JNZ 0x1000:4238
// 1000:4235      bd f4 01                 MOV BP,0x1f4
// 1000:4238  LAB_1000_4238:
// 1000:4238      bf 14 90                 MOV DI,0x9014
// 1000:423b      b9 04 00                 MOV CX,0x4
// 1000:423e  LAB_1000_423e:
// 1000:423e      3b f7                    CMP SI,DI
// 1000:4240      74 11                    JZ 0x1000:4253
// 1000:4242      83 7d 08 00              CMP word ptr [DI + 0x8],0x0
// 1000:4246      74 0b                    JZ 0x1000:4253
// 1000:4248      51                       PUSH CX
// 1000:4249      b1 04                    MOV CL,0x4
// 1000:424b      e8 7e e1                 CALL 0x1000:23cc
// 1000:424e      59                       POP CX
// 1000:424f      3b c5                    CMP AX,BP
// 1000:4251      72 06                    JC 0x1000:4259
// 1000:4253  LAB_1000_4253:
// 1000:4253      83 c7 0e                 ADD DI,0xe
// 1000:4256      e2 e6                    LOOP 0x1000:423e
// 1000:4258      f8                       CLC
// 1000:4259  LAB_1000_4259:
// 1000:4259      59                       POP CX
// 1000:425a      c3                       RET
fun_4217 :: proc() {
}

// @proc 1000:425b
// listing: FUN_1000_425b
// status: unread
// 1000:425b  FUN_1000_425b:
// 1000:425b      51                       PUSH CX
// 1000:425c      e8 c6 ef                 CALL 0x1000:3225
// 1000:425f  LAB_1000_425f:
// 1000:425f      83 7d 01 00              CMP word ptr [DI + 0x1],0x0
// 1000:4263      74 10                    JZ 0x1000:4275
// 1000:4265      3b f7                    CMP SI,DI
// 1000:4267      74 0c                    JZ 0x1000:4275
// 1000:4269      51                       PUSH CX
// 1000:426a      b1 02                    MOV CL,0x2
// 1000:426c      e8 55 e1                 CALL 0x1000:23c4
// 1000:426f      59                       POP CX
// 1000:4270      3d 8a 02                 CMP AX,0x28a
// 1000:4273      72 06                    JC 0x1000:427b
// 1000:4275  LAB_1000_4275:
// 1000:4275      83 c7 0b                 ADD DI,0xb
// 1000:4278      e2 e5                    LOOP 0x1000:425f
// 1000:427a      f8                       CLC
// 1000:427b  LAB_1000_427b:
// 1000:427b      59                       POP CX
// 1000:427c      c3                       RET
fun_425b :: proc() {
}

// @proc 1000:427d
// listing: FUN_1000_427d
// status: unread
// 1000:427d  FUN_1000_427d:
// 1000:427d      e8 0a 00                 CALL 0x1000:428a
// 1000:4280      89 44 01                 MOV word ptr [SI + 0x1],AX
// 1000:4283      e8 04 00                 CALL 0x1000:428a
// 1000:4286      89 44 03                 MOV word ptr [SI + 0x3],AX
// 1000:4289      c3                       RET
fun_427d :: proc() {
}

// @proc 1000:428a
// listing: FUN_1000_428a
// status: unread
// 1000:428a  FUN_1000_428a:
// 1000:428a      e8 ed 00                 CALL 0x1000:437a
// 1000:428d      25 ff 3f                 AND AX,0x3fff
// 1000:4290      3d dc 05                 CMP AX,0x5dc
// 1000:4293      72 f5                    JC 0x1000:428a
// 1000:4295      3d 24 3a                 CMP AX,0x3a24
// 1000:4298      77 f0                    JA 0x1000:428a
// 1000:429a      c3                       RET
fun_428a :: proc() {
}

// @proc 1000:429b
// listing: FUN_1000_429b
// status: unread
// 1000:429b  FUN_1000_429b:
// 1000:429b      e8 dc 00                 CALL 0x1000:437a
// 1000:429e      25 ff 3f                 AND AX,0x3fff
// 1000:42a1      3d f4 01                 CMP AX,0x1f4
// 1000:42a4      72 f5                    JC 0x1000:429b
// 1000:42a6      3d 0c 3e                 CMP AX,0x3e0c
// 1000:42a9      77 f0                    JA 0x1000:429b
// 1000:42ab      c3                       RET
fun_429b :: proc() {
}

// @proc 1000:42ac
// listing: FUN_1000_42ac
// status: unread
// 1000:42ac  FUN_1000_42ac:
// 1000:42ac      e8 cb 00                 CALL 0x1000:437a
// 1000:42af      53                       PUSH BX
// 1000:42b0      25 1f 00                 AND AX,0x1f
// 1000:42b3      bb bd 42                 MOV BX,0x42bd
// 1000:42b6      03 d8                    ADD BX,AX
// 1000:42b8      2e 8a 07                 MOV AL,byte ptr CS:[BX]
// 1000:42bb      5b                       POP BX
// 1000:42bc      c3                       RET
fun_42ac :: proc() {
}

// @proc 1000:42dd
// listing: FUN_1000_42dd
// status: unread
// 1000:42dd  FUN_1000_42dd:
// 1000:42dd      83 e9 03                 SUB CX,0x3
// 1000:42e0      8b d9                    MOV BX,CX
// 1000:42e2      83 fb 06                 CMP BX,0x6
// 1000:42e5      73 1d                    JNC 0x1000:4304
// 1000:42e7      81 e3 06 00              AND BX,0x6
// 1000:42eb      d1 e3                    SHL BX,0x1
// 1000:42ed      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
// 1000:42f0      25 03 00                 AND AX,0x3
// 1000:42f3      03 d8                    ADD BX,AX
// 1000:42f5      2e 8a 87 06 43           MOV AL,byte ptr CS:[BX + 0x4306]
// 1000:42fa      3a 06 02 00              CMP AL,byte ptr [0x2]
// 1000:42fe      73 04                    JNC 0x1000:4304
// 1000:4300      04 0a                    ADD AL,0xa
// 1000:4302      f9                       STC
// 1000:4303      c3                       RET
// 1000:4304  LAB_1000_4304:
// 1000:4304      f8                       CLC
// 1000:4305      c3                       RET
fun_42dd :: proc() {
}

// @proc 1000:4312
// listing: FUN_1000_4312
// status: unread
// 1000:4312  FUN_1000_4312:
// 1000:4312      e8 65 00                 CALL 0x1000:437a
// 1000:4315      24 07                    AND AL,0x7
// 1000:4317      b0 02                    MOV AL,0x2
// 1000:4319      74 05                    JZ 0x1000:4320
// 1000:431b      e8 5c 00                 CALL 0x1000:437a
// 1000:431e      24 01                    AND AL,0x1
// 1000:4320  LAB_1000_4320:
// 1000:4320      0c 80                    OR AL,0x80
// 1000:4322      88 04                    MOV byte ptr [SI],AL
// 1000:4324  LAB_1000_4324:
// 1000:4324      e8 53 00                 CALL 0x1000:437a
// 1000:4327      25 ff 3f                 AND AX,0x3fff
// 1000:432a      89 44 01                 MOV word ptr [SI + 0x1],AX
// 1000:432d      e8 4a 00                 CALL 0x1000:437a
// 1000:4330      25 ff 3f                 AND AX,0x3fff
// 1000:4333      89 44 03                 MOV word ptr [SI + 0x3],AX
// 1000:4336      bd 32 00                 MOV BP,0x32
// 1000:4339      ba 88 13                 MOV DX,0x1388
// 1000:433c      e8 d8 fe                 CALL 0x1000:4217
// 1000:433f      72 e3                    JC 0x1000:4324
// 1000:4341      e8 36 00                 CALL 0x1000:437a
// 1000:4344      88 44 0a                 MOV byte ptr [SI + 0xa],AL
// 1000:4347      e8 30 00                 CALL 0x1000:437a
// 1000:434a      24 07                    AND AL,0x7
// 1000:434c      04 05                    ADD AL,0x5
// 1000:434e      80 3c 82                 CMP byte ptr [SI],0x82
// 1000:4351      75 02                    JNZ 0x1000:4355
// 1000:4353      04 05                    ADD AL,0x5
// 1000:4355  LAB_1000_4355:
// 1000:4355      88 44 0b                 MOV byte ptr [SI + 0xb],AL
// 1000:4358      e8 1f 00                 CALL 0x1000:437a
// 1000:435b      25 ff 00                 AND AX,0xff
// 1000:435e      05 64 00                 ADD AX,0x64
// 1000:4361      89 44 08                 MOV word ptr [SI + 0x8],AX
// 1000:4364      f6 06 12 00 02           TEST byte ptr [0x12],0x2
// 1000:4369      74 0e                    JZ 0x1000:4379
// 1000:436b  LAB_1000_436b:
// 1000:436b      e8 0c 00                 CALL 0x1000:437a
// 1000:436e      24 03                    AND AL,0x3
// 1000:4370      3a 06 02 00              CMP AL,byte ptr [0x2]
// 1000:4374      73 f5                    JNC 0x1000:436b
// 1000:4376      88 44 05                 MOV byte ptr [SI + 0x5],AL
// 1000:4379  LAB_1000_4379:
// 1000:4379      c3                       RET
fun_4312 :: proc() {
}

// @proc 1000:437a
// listing: FUN_1000_437a
// status: unread
// 1000:437a  FUN_1000_437a:
// 1000:437a      a0 d2 89                 MOV AL,[0x89d2]
// 1000:437d      34 a5                    XOR AL,0xa5
// 1000:437f      52                       PUSH DX
// 1000:4380      53                       PUSH BX
// 1000:4381      8b 1e d0 89              MOV BX,word ptr [0x89d0]
// 1000:4385      33 d2                    XOR DX,DX
// 1000:4387      32 c7                    XOR AL,BH
// 1000:4389      7a 03                    JP 0x1000:438e
// 1000:438b      b2 02                    MOV DL,0x2
// 1000:438d      f9                       STC
// 1000:438e  LAB_1000_438e:
// 1000:438e      d0 d8                    RCR AL,0x1
// 1000:4390      8a f0                    MOV DH,AL
// 1000:4392      d0 da                    RCR DL,0x1
// 1000:4394      8a e2                    MOV AH,DL
// 1000:4396      d0 d8                    RCR AL,0x1
// 1000:4398      d0 da                    RCR DL,0x1
// 1000:439a      32 c6                    XOR AL,DH
// 1000:439c      8a f0                    MOV DH,AL
// 1000:439e      8a c2                    MOV AL,DL
// 1000:43a0      32 c4                    XOR AL,AH
// 1000:43a2      32 c3                    XOR AL,BL
// 1000:43a4      8a f8                    MOV BH,AL
// 1000:43a6      8a de                    MOV BL,DH
// 1000:43a8      89 1e d0 89              MOV word ptr [0x89d0],BX
// 1000:43ac      8b c3                    MOV AX,BX
// 1000:43ae      5b                       POP BX
// 1000:43af      5a                       POP DX
// 1000:43b0      c3                       RET
fun_437a :: proc() {
}

// @proc 1000:43b1
// listing: FUN_1000_43b1
// notes: step_orbit
// status: unread
// 1000:43b1  FUN_1000_43b1:
// 1000:43b1      56                       PUSH SI
// 1000:43b2      53                       PUSH BX
// 1000:43b3      51                       PUSH CX
// 1000:43b4      52                       PUSH DX
// 1000:43b5      8a 45 08                 MOV AL,byte ptr [DI + 0x8]
// 1000:43b8      22 c0                    AND AL,AL
// 1000:43ba      74 38                    JZ 0x1000:43f4
// 1000:43bc      bb f9 43                 MOV BX,0x43f9
// 1000:43bf      b2 08                    MOV DL,0x8
// 1000:43c1      b1 1f                    MOV CL,0x1f
// 1000:43c3      fe c8                    DEC AL
// 1000:43c5      74 07                    JZ 0x1000:43ce
// 1000:43c7      bb 19 44                 MOV BX,0x4419
// 1000:43ca      b2 10                    MOV DL,0x10
// 1000:43cc      b1 3f                    MOV CL,0x3f
// 1000:43ce  LAB_1000_43ce:
// 1000:43ce      8a 45 07                 MOV AL,byte ptr [DI + 0x7]
// 1000:43d1      fe 45 07                 INC byte ptr [DI + 0x7]
// 1000:43d4      8a e8                    MOV CH,AL
// 1000:43d6      22 c1                    AND AL,CL
// 1000:43d8      32 e4                    XOR AH,AH
// 1000:43da      8b f0                    MOV SI,AX
// 1000:43dc      2e 8a 00                 MOV AL,byte ptr CS:[BX + SI]
// 1000:43df      98                       CBW
// 1000:43e0      01 45 01                 ADD word ptr [DI + 0x1],AX
// 1000:43e3      8a c5                    MOV AL,CH
// 1000:43e5      02 c2                    ADD AL,DL
// 1000:43e7      22 c1                    AND AL,CL
// 1000:43e9      32 e4                    XOR AH,AH
// 1000:43eb      8b f0                    MOV SI,AX
// 1000:43ed      2e 8a 00                 MOV AL,byte ptr CS:[BX + SI]
// 1000:43f0      98                       CBW
// 1000:43f1      01 45 03                 ADD word ptr [DI + 0x3],AX
// 1000:43f4  LAB_1000_43f4:
// 1000:43f4      5a                       POP DX
// 1000:43f5      59                       POP CX
// 1000:43f6      5b                       POP BX
// 1000:43f7      5e                       POP SI
// 1000:43f8      c3                       RET
fun_43b1 :: proc() {
}

// 1000:4459 spawn_ship is in ship.odin.

// 1000:4530 through 1000:580c are in draw.odin.

