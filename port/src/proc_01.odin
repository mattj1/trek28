package trek

// Procedures 1000:1220 through 1000:1ee6.
// The assembly is the listing. The body is empty until the procedure is translated.
// A notes line is a name already supported by the annotation notes.

// @proc 1000:1220
// listing: FUN_1000_1220
// status: unread
// 1000:1220  FUN_1000_1220:
// 1000:1220      bf 26 a2                 MOV DI,0xa226
// 1000:1223      b9 2c 00                 MOV CX,0x2c
// 1000:1226      32 c0                    XOR AL,AL
// 1000:1228      f3 aa                    STOSB.REP ES:DI
// 1000:122a      c6 06 ed 00 00           MOV byte ptr [0xed],0x0
// 1000:122f      80 3e 0a 00 01           CMP byte ptr [0xa],0x1
// 1000:1234      75 25                    JNZ 0x1000:125b
// 1000:1236      be 07 00                 MOV SI,0x7
// 1000:1239      bf 26 a2                 MOV DI,0xa226
// 1000:123c      b9 03 00                 MOV CX,0x3
// 1000:123f      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:1241      a0 c0 39                 MOV AL,[0x39c0]
// 1000:1244      aa                       STOSB ES:DI
// 1000:1245      a0 10 00                 MOV AL,[0x10]
// 1000:1248      aa                       STOSB ES:DI
// 1000:1249      b9 06 00                 MOV CX,0x6
// 1000:124c      b0 00                    MOV AL,0x0
// 1000:124e      f3 aa                    STOSB.REP ES:DI
// 1000:1250      b0 01                    MOV AL,0x1
// 1000:1252      8a 26 13 00              MOV AH,byte ptr [0x13]
// 1000:1256      fe c4                    INC AH
// 1000:1258      eb 04                    JMP 0x1000:125e
// 1000:125b  LAB_1000_125b:
// 1000:125b      e8 42 47                 CALL 0x1000:59a0
// 1000:125e  LAB_1000_125e:
// 1000:125e      50                       PUSH AX
// 1000:125f      f6 06 12 00 01           TEST byte ptr [0x12],0x1
// 1000:1264      75 28                    JNZ 0x1000:128e
// 1000:1266      e8 92 45                 CALL 0x1000:57fb
//                 ; inline script -> 1000:128b  <c3><clear>         PLAYING LONG GAME   
// 1000:128b  LAB_1000_128b:
// 1000:128b      eb 27                    JMP 0x1000:12b4
// 1000:128e  LAB_1000_128e:
// 1000:128e      e8 6a 45                 CALL 0x1000:57fb
//                 ; inline script -> 1000:12b4  <c3><clear>         PLAYING TIMED GAME   
// 1000:12b4  LAB_1000_12b4:
// 1000:12b4      f6 06 12 00 02           TEST byte ptr [0x12],0x2
// 1000:12b9      74 27                    JZ 0x1000:12e2
// 1000:12bb      e8 3d 45                 CALL 0x1000:57fb
//                 ; inline script -> 1000:12df  <c3>         IN MULTI-GALAXIES   
// 1000:12df  LAB_1000_12df:
// 1000:12df      eb 23                    JMP 0x1000:1304
// 1000:12e2  LAB_1000_12e2:
// 1000:12e2      e8 16 45                 CALL 0x1000:57fb
//                 ; inline script -> 1000:1304  <c3>           IN ONE GALAXY   
// 1000:1304  LAB_1000_1304:
// 1000:1304      58                       POP AX
// 1000:1305      50                       PUSH AX
// 1000:1306      3c 02                    CMP AL,0x2
// 1000:1308      72 5d                    JC 0x1000:1367
// 1000:130a      22 e4                    AND AH,AH
// 1000:130c      75 0f                    JNZ 0x1000:131d
// 1000:130e      e8 ea 44                 CALL 0x1000:57fb
//                 ; inline script -> 1000:131d  <c3>        
// 1000:131d  LAB_1000_131d:
// 1000:131d      e8 db 44                 CALL 0x1000:57fb
//                 ; inline script -> 1000:1330  <c3>    AGAINST 
// 1000:1330  LAB_1000_1330:
// 1000:1330      58                       POP AX
// 1000:1331      50                       PUSH AX
// 1000:1332      fe c8                    DEC AL
// 1000:1334      e8 d7 00                 CALL 0x1000:140e
// 1000:1337      e8 c1 44                 CALL 0x1000:57fb
//                 ; inline script -> 1000:1344  <c3> HUMAN
// 1000:1344  LAB_1000_1344:
// 1000:1344      58                       POP AX
// 1000:1345      50                       PUSH AX
// 1000:1346      3c 02                    CMP AL,0x2
// 1000:1348      76 08                    JBE 0x1000:1352
// 1000:134a      e8 ae 44                 CALL 0x1000:57fb
//                 ; inline script -> 1000:1352  <c3>S
// 1000:1352  LAB_1000_1352:
// 1000:1352      58                       POP AX
// 1000:1353      50                       PUSH AX
// 1000:1354      22 e4                    AND AH,AH
// 1000:1356      74 4c                    JZ 0x1000:13a4
// 1000:1358      e8 a0 44                 CALL 0x1000:57fb
//                 ; inline script -> 1000:1364  <c3> AND 
// 1000:1364  LAB_1000_1364:
// 1000:1364      eb 18                    JMP 0x1000:137e
// 1000:1367  LAB_1000_1367:
// 1000:1367      e8 91 44                 CALL 0x1000:57fb
//                 ; inline script -> 1000:137e  <c3>        AGAINST 
// 1000:137e  LAB_1000_137e:
// 1000:137e      58                       POP AX
// 1000:137f      50                       PUSH AX
// 1000:1380      8a c4                    MOV AL,AH
// 1000:1382      e8 89 00                 CALL 0x1000:140e
// 1000:1385      e8 73 44                 CALL 0x1000:57fb
//                 ; inline script -> 1000:1395  <c3> COMPUTER
// 1000:1395  LAB_1000_1395:
// 1000:1395      58                       POP AX
// 1000:1396      50                       PUSH AX
// 1000:1397      80 fc 01                 CMP AH,0x1
// 1000:139a      74 08                    JZ 0x1000:13a4
// 1000:139c      e8 5c 44                 CALL 0x1000:57fb
//                 ; inline script -> 1000:13a4  <c3>S
// 1000:13a4  LAB_1000_13a4:
// 1000:13a4      58                       POP AX
// 1000:13a5      c6 06 00 00 50           MOV byte ptr [0x0],0x50
// 1000:13aa      c6 06 01 00 04           MOV byte ptr [0x1],0x4
// 1000:13af      b3 01                    MOV BL,0x1
// 1000:13b1      f6 06 12 00 02           TEST byte ptr [0x12],0x2
// 1000:13b6      74 17                    JZ 0x1000:13cf
// 1000:13b8      8a d8                    MOV BL,AL
// 1000:13ba      02 dc                    ADD BL,AH
// 1000:13bc      00 1e 01 00              ADD byte ptr [0x1],BL
// 1000:13c0      8a fb                    MOV BH,BL
// 1000:13c2      d0 e7                    SHL BH,0x1
// 1000:13c4      d0 e7                    SHL BH,0x1
// 1000:13c6      d0 e7                    SHL BH,0x1
// 1000:13c8      80 ef 06                 SUB BH,0x6
// 1000:13cb      28 3e 00 00              SUB byte ptr [0x0],BH
// 1000:13cf  LAB_1000_13cf:
// 1000:13cf      88 1e 02 00              MOV byte ptr [0x2],BL
// 1000:13d3      b3 01                    MOV BL,0x1
// 1000:13d5      3c 01                    CMP AL,0x1
// 1000:13d7      75 04                    JNZ 0x1000:13dd
// 1000:13d9      8a 1e 11 00              MOV BL,byte ptr [0x11]
// 1000:13dd  LAB_1000_13dd:
// 1000:13dd      bf 26 a2                 MOV DI,0xa226
// 1000:13e0      8a cc                    MOV CL,AH
// 1000:13e2      32 ed                    XOR CH,CH
// 1000:13e4      e3 27                    JCXZ 0x1000:140d
// 1000:13e6  LAB_1000_13e6:
// 1000:13e6      83 c7 0b                 ADD DI,0xb
// 1000:13e9      fe c8                    DEC AL
// 1000:13eb      75 f9                    JNZ 0x1000:13e6
// 1000:13ed      32 ed                    XOR CH,CH
// 1000:13ef      b4 30                    MOV AH,0x30
// 1000:13f1  LAB_1000_13f1:
// 1000:13f1      b0 6d                    MOV AL,0x6d
// 1000:13f3      aa                       STOSB ES:DI
// 1000:13f4      b0 65                    MOV AL,0x65
// 1000:13f6      aa                       STOSB ES:DI
// 1000:13f7      8a c4                    MOV AL,AH
// 1000:13f9      aa                       STOSB ES:DI
// 1000:13fa      a0 c0 39                 MOV AL,[0x39c0]
// 1000:13fd      aa                       STOSB ES:DI
// 1000:13fe      8a c3                    MOV AL,BL
// 1000:1400      aa                       STOSB ES:DI
// 1000:1401      b0 00                    MOV AL,0x0
// 1000:1403      aa                       STOSB ES:DI
// 1000:1404      aa                       STOSB ES:DI
// 1000:1405      aa                       STOSB ES:DI
// 1000:1406      aa                       STOSB ES:DI
// 1000:1407      aa                       STOSB ES:DI
// 1000:1408      aa                       STOSB ES:DI
// 1000:1409      fe c4                    INC AH
// 1000:140b      e2 e4                    LOOP 0x1000:13f1
// 1000:140d  LAB_1000_140d:
// 1000:140d      c3                       RET
fun_1220 :: proc() {
}

// @proc 1000:140e
// listing: FUN_1000_140e
// status: unread
// 1000:140e  FUN_1000_140e:
// 1000:140e      3c 01                    CMP AL,0x1
// 1000:1410      75 0b                    JNZ 0x1000:141d
// 1000:1412      e8 e6 43                 CALL 0x1000:57fb
//                 ; inline script -> 1000:141c  <c3>ONE
// 1000:141c  LAB_1000_141c:
// 1000:141c      c3                       RET
// 1000:141d  LAB_1000_141d:
// 1000:141d      3c 02                    CMP AL,0x2
// 1000:141f      75 0b                    JNZ 0x1000:142c
// 1000:1421      e8 d7 43                 CALL 0x1000:57fb
//                 ; inline script -> 1000:142b  <c3>TWO
// 1000:142b  LAB_1000_142b:
// 1000:142b      c3                       RET
// 1000:142c  LAB_1000_142c:
// 1000:142c      3c 03                    CMP AL,0x3
// 1000:142e      75 0d                    JNZ 0x1000:143d
// 1000:1430      e8 c8 43                 CALL 0x1000:57fb
//                 ; inline script -> 1000:143c  <c3>THREE
// 1000:143c  LAB_1000_143c:
// 1000:143c      c3                       RET
// 1000:143d  LAB_1000_143d:
// 1000:143d      e8 bb 43                 CALL 0x1000:57fb
//                 ; inline script -> 1000:1448  <c3>FOUR
// 1000:1448  LAB_1000_1448:
// 1000:1448      c3                       RET
fun_140e :: proc() {
}

// @proc 1000:1449
// listing: FUN_1000_1449
// status: unread
// 1000:1449  FUN_1000_1449:
// 1000:1449      b9 04 00                 MOV CX,0x4
// 1000:144c  LAB_1000_144c:
// 1000:144c      33 d2                    XOR DX,DX
// 1000:144e      bb 0a 00                 MOV BX,0xa
// 1000:1451      f7 f3                    DIV BX
// 1000:1453      52                       PUSH DX
// 1000:1454      e2 f6                    LOOP 0x1000:144c
// 1000:1456      b9 04 00                 MOV CX,0x4
// 1000:1459  LAB_1000_1459:
// 1000:1459      58                       POP AX
// 1000:145a      50                       PUSH AX
// 1000:145b      3c 00                    CMP AL,0x0
// 1000:145d      75 09                    JNZ 0x1000:1468
// 1000:145f      58                       POP AX
// 1000:1460      e2 f7                    LOOP 0x1000:1459
// 1000:1462      b0 30                    MOV AL,0x30
// 1000:1464      e8 10 41                 CALL 0x1000:5577
// 1000:1467      c3                       RET
// 1000:1468  LAB_1000_1468:
// 1000:1468      58                       POP AX
// 1000:1469      04 30                    ADD AL,0x30
// 1000:146b      51                       PUSH CX
// 1000:146c      e8 08 41                 CALL 0x1000:5577
// 1000:146f      59                       POP CX
// 1000:1470      e2 f6                    LOOP 0x1000:1468
// 1000:1472      c3                       RET
fun_1449 :: proc() {
}

// @proc 1000:1473
// listing: FUN_1000_1473
// notes: play_game
// status: unread
// 1000:1473  FUN_1000_1473:
// 1000:1473      c6 06 70 a2 07           MOV byte ptr [0xa270],0x7
// 1000:1478      c6 06 6f a2 00           MOV byte ptr [0xa26f],0x0
// 1000:147d      e8 a0 fd                 CALL 0x1000:1220
// 1000:1480      c7 06 55 a2 a2 00        MOV word ptr [0xa255],0xa2
// 1000:1486      e8 72 43                 CALL 0x1000:57fb
//                 ; inline script -> 1000:14ac  <c3>          SETTING UP UNIVERSE #
// 1000:14ac  LAB_1000_14ac:
// 1000:14ac      a1 d0 89                 MOV AX,[0x89d0]
// 1000:14af      33 d2                    XOR DX,DX
// 1000:14b1      bb 1a 00                 MOV BX,0x1a
// 1000:14b4      f7 f3                    DIV BX
// 1000:14b6      50                       PUSH AX
// 1000:14b7      8b c2                    MOV AX,DX
// 1000:14b9      04 41                    ADD AL,0x41
// 1000:14bb      e8 b9 40                 CALL 0x1000:5577
// 1000:14be      b0 2d                    MOV AL,0x2d
// 1000:14c0      e8 b4 40                 CALL 0x1000:5577
// 1000:14c3      58                       POP AX
// 1000:14c4      e8 82 ff                 CALL 0x1000:1449
// 1000:14c7      e8 31 43                 CALL 0x1000:57fb
//                 ; inline script -> 1000:14ef  <c3>             ** PLEASE STANDBY **
// 1000:14ef  LAB_1000_14ef:
// 1000:14ef      e8 df 2a                 CALL 0x1000:3fd1
// 1000:14f2  LAB_1000_14f2:
// 1000:14f2      83 3e 55 a2 00           CMP word ptr [0xa255],0x0
// 1000:14f7      75 f9                    JNZ 0x1000:14f2
// 1000:14f9      e8 a4 4a                 CALL 0x1000:5fa0
// 1000:14fc      8b 26 43 a3              MOV SP,word ptr [0xa343]
// 1000:1500      fa                       CLI
// 1000:1501      bb 7c 0c                 MOV BX,0xc7c
// 1000:1504      bf 12 a2                 MOV DI,0xa212
// 1000:1507      b9 14 00                 MOV CX,0x14
// 1000:150a      b0 00                    MOV AL,0x0
// 1000:150c      f3 aa                    STOSB.REP ES:DI
// 1000:150e      c7 06 e1 00 e5 00        MOV word ptr [0xe1],0xe5
// 1000:1514      c7 06 e3 00 e5 00        MOV word ptr [0xe3],0xe5
// 1000:151a      c6 06 04 a2 12           MOV byte ptr [0xa204],0x12
// 1000:151f      c6 06 05 a2 05           MOV byte ptr [0xa205],0x5
// 1000:1524      c6 06 06 a2 00           MOV byte ptr [0xa206],0x0
// 1000:1529      c6 06 07 a2 00           MOV byte ptr [0xa207],0x0
// 1000:152e      c6 06 08 a2 00           MOV byte ptr [0xa208],0x0
// 1000:1533      f6 06 12 00 01           TEST byte ptr [0x12],0x1
// 1000:1538      74 05                    JZ 0x1000:153f
// 1000:153a      c6 06 07 a2 1e           MOV byte ptr [0xa207],0x1e
// 1000:153f  LAB_1000_153f:
// 1000:153f      fb                       STI
// 1000:1540      ff d3                    CALL BX
// 1000:1542      c6 06 03 a2 01           MOV byte ptr [0xa203],0x1
// 1000:1547      c7 06 57 a2 00 00        MOV word ptr [0xa257],0x0
// 1000:154d  LAB_1000_154d:
// 1000:154d      83 3e 57 a2 00           CMP word ptr [0xa257],0x0
// 1000:1552      75 f9                    JNZ 0x1000:154d
// 1000:1554      8a 26 0d 00              MOV AH,byte ptr [0xd]
// 1000:1558      80 e4 03                 AND AH,0x3
// 1000:155b      b0 09                    MOV AL,0x9
// 1000:155d      74 10                    JZ 0x1000:156f
// 1000:155f      b0 08                    MOV AL,0x8
// 1000:1561      fe cc                    DEC AH
// 1000:1563      74 0a                    JZ 0x1000:156f
// 1000:1565      b0 07                    MOV AL,0x7
// 1000:1567      fe cc                    DEC AH
// 1000:1569      74 04                    JZ 0x1000:156f
// 1000:156b      32 e4                    XOR AH,AH
// 1000:156d      b0 06                    MOV AL,0x6
// 1000:156f  LAB_1000_156f:
// 1000:156f      a3 57 a2                 MOV [0xa257],AX
// 1000:1572      e8 e4 01                 CALL 0x1000:1759
// 1000:1575      c6 06 0c a2 80           MOV byte ptr [0xa20c],0x80
// 1000:157a      ff 06 d2 89              INC word ptr [0x89d2]
// 1000:157e      e8 b6 02                 CALL 0x1000:1837
// 1000:1581      f6 06 6c a2 80           TEST byte ptr [0xa26c],0x80
// 1000:1586      75 15                    JNZ 0x1000:159d
// 1000:1588      e8 5b 09                 CALL 0x1000:1ee6
// 1000:158b      e8 1e 22                 CALL 0x1000:37ac
// 1000:158e      e8 fe 01                 CALL 0x1000:178f
// 1000:1591      e8 e0 15                 CALL 0x1000:2b74
// 1000:1594      e8 dd 23                 CALL 0x1000:3974
// 1000:1597      e8 f5 01                 CALL 0x1000:178f
// 1000:159a      e8 be 15                 CALL 0x1000:2b5b
// 1000:159d  LAB_1000_159d:
// 1000:159d      e8 ef 01                 CALL 0x1000:178f
// 1000:15a0      e8 8d 2f                 CALL 0x1000:4530
// 1000:15a3      e8 e9 01                 CALL 0x1000:178f
// 1000:15a6      e8 d2 03                 CALL 0x1000:197b
// 1000:15a9      e8 26 00                 CALL 0x1000:15d2
// 1000:15ac      e8 4f 01                 CALL 0x1000:16fe
// 1000:15af      e8 02 00                 CALL 0x1000:15b4
// 1000:15b2      eb 99                    JMP 0x1000:154d
fun_1473 :: proc() {
}

// @proc 1000:15b4
// listing: FUN_1000_15b4
// notes: send_command_packet
// status: unread
// 1000:15b4  FUN_1000_15b4:
// 1000:15b4      80 3e 0a 00 01           CMP byte ptr [0xa],0x1
// 1000:15b9      75 11                    JNZ 0x1000:15cc
// 1000:15bb      bf 12 a2                 MOV DI,0xa212
// 1000:15be      be 0d a2                 MOV SI,0xa20d
// 1000:15c1      b9 04 00                 MOV CX,0x4
// 1000:15c4      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:15c6      b0 01                    MOV AL,0x1
// 1000:15c8      aa                       STOSB ES:DI
// 1000:15c9      eb 04                    JMP 0x1000:15cf
// 1000:15cc  LAB_1000_15cc:
// 1000:15cc      e8 53 47                 CALL 0x1000:5d22
// 1000:15cf  LAB_1000_15cf:
// 1000:15cf      e9 3e 4d                 JMP 0x1000:6310
fun_15b4 :: proc() {
}

// @proc 1000:15d2
// listing: FUN_1000_15d2
// notes: check_game_over
// status: unread
// 1000:15d2  FUN_1000_15d2:
// 1000:15d2      80 3e ed 00 01           CMP byte ptr [0xed],0x1
// 1000:15d7      74 4e                    JZ 0x1000:1627
// 1000:15d9      e8 0d 01                 CALL 0x1000:16e9
// 1000:15dc      b9 04 00                 MOV CX,0x4
// 1000:15df      bb e0 89                 MOV BX,0x89e0
// 1000:15e2      b0 00                    MOV AL,0x0
// 1000:15e4  LAB_1000_15e4:
// 1000:15e4      80 3f 00                 CMP byte ptr [BX],0x0
// 1000:15e7      75 02                    JNZ 0x1000:15eb
// 1000:15e9      fe c0                    INC AL
// 1000:15eb  LAB_1000_15eb:
// 1000:15eb      43                       INC BX
// 1000:15ec      e2 f6                    LOOP 0x1000:15e4
// 1000:15ee      3c 00                    CMP AL,0x0
// 1000:15f0      75 11                    JNZ 0x1000:1603
// 1000:15f2      bb e0 89                 MOV BX,0x89e0
// 1000:15f5      b9 04 00                 MOV CX,0x4
// 1000:15f8  LAB_1000_15f8:
// 1000:15f8      f6 07 80                 TEST byte ptr [BX],0x80
// 1000:15fb      75 03                    JNZ 0x1000:1600
// 1000:15fd      c6 07 04                 MOV byte ptr [BX],0x4
// 1000:1600  LAB_1000_1600:
// 1000:1600      43                       INC BX
// 1000:1601      e2 f5                    LOOP 0x1000:15f8
// 1000:1603  LAB_1000_1603:
// 1000:1603      3c 01                    CMP AL,0x1
// 1000:1605      74 20                    JZ 0x1000:1627
// 1000:1607      bb e0 89                 MOV BX,0x89e0
// 1000:160a      b9 04 00                 MOV CX,0x4
// 1000:160d  LAB_1000_160d:
// 1000:160d      80 3f 00                 CMP byte ptr [BX],0x0
// 1000:1610      74 03                    JZ 0x1000:1615
// 1000:1612      80 0f 80                 OR byte ptr [BX],0x80
// 1000:1615  LAB_1000_1615:
// 1000:1615      43                       INC BX
// 1000:1616      e2 f5                    LOOP 0x1000:160d
// 1000:1618      8a 1e 6f a2              MOV BL,byte ptr [0xa26f]
// 1000:161c      32 ff                    XOR BH,BH
// 1000:161e      8a 87 e0 89              MOV AL,byte ptr [BX + 0x89e0]
// 1000:1622      3c 00                    CMP AL,0x0
// 1000:1624      75 01                    JNZ 0x1000:1627
// 1000:1626      c3                       RET
// 1000:1627  LAB_1000_1627:
// 1000:1627      8a 1e 6f a2              MOV BL,byte ptr [0xa26f]
// 1000:162b      88 1e 74 a2              MOV byte ptr [0xa274],BL
// 1000:162f      e8 46 05                 CALL 0x1000:1b78
// 1000:1632      c7 06 09 a2 00 00        MOV word ptr [0xa209],0x0
// 1000:1638      c6 06 70 a2 04           MOV byte ptr [0xa270],0x4
// 1000:163d      e8 56 00                 CALL 0x1000:1696
// 1000:1640      e8 ed 2e                 CALL 0x1000:4530
// 1000:1643      e8 bc 3a                 CALL 0x1000:5102
// 1000:1646      e8 82 54                 CALL 0x1000:6acb
// 1000:1649      c7 06 55 a2 24 00        MOV word ptr [0xa255],0x24
// 1000:164f  LAB_1000_164f:
// 1000:164f      83 3e 55 a2 00           CMP word ptr [0xa255],0x0
// 1000:1654      75 f9                    JNZ 0x1000:164f
// 1000:1656      e8 a2 41                 CALL 0x1000:57fb
//                 ; inline script -> 1000:1675  <c3><box>HIT Esc TO CONTINUE
// 1000:1675  LAB_1000_1675:
// 1000:1675      c7 06 55 a2 68 01        MOV word ptr [0xa255],0x168
// 1000:167b  LAB_1000_167b:
// 1000:167b      b4 01                    MOV AH,0x1
// 1000:167d      cd 16                    INT 0x16
// 1000:167f      74 08                    JZ 0x1000:1689
// 1000:1681      b4 00                    MOV AH,0x0
// 1000:1683      cd 16                    INT 0x16
// 1000:1685      3c 1b                    CMP AL,0x1b
// 1000:1687      74 07                    JZ 0x1000:1690
// 1000:1689  LAB_1000_1689:
// 1000:1689      83 3e 55 a2 00           CMP word ptr [0xa255],0x0
// 1000:168e      75 eb                    JNZ 0x1000:167b
// 1000:1690  LAB_1000_1690:
// 1000:1690      e8 c3 95                 CALL 0x1000:ac56
// 1000:1693      e9 2f 55                 JMP 0x1000:6bc5
fun_15d2 :: proc() {
}

// 1000:1696 add_energy_score is in ship.odin.

// 1000:16e9 end_two_player_sides is in ship.odin.

// 1000:16fe update_pause is in ship.odin.

// 1000:1759 drain_key_ring is in ship.odin.

// @proc 1000:178f
// listing: FUN_1000_178f
// status: unread
// 1000:178f  FUN_1000_178f:
// 1000:178f      e8 2f 00                 CALL 0x1000:17c1
// 1000:1792      22 c0                    AND AL,AL
// 1000:1794      75 01                    JNZ 0x1000:1797
// 1000:1796      c3                       RET
// 1000:1797  LAB_1000_1797:
// 1000:1797      53                       PUSH BX
// 1000:1798      56                       PUSH SI
// 1000:1799      8b 1e e3 00              MOV BX,word ptr [0xe3]
// 1000:179d      8b f3                    MOV SI,BX
// 1000:179f      43                       INC BX
// 1000:17a0      81 fb ed 00              CMP BX,0xed
// 1000:17a4      75 03                    JNZ 0x1000:17a9
// 1000:17a6      bb e5 00                 MOV BX,0xe5
// 1000:17a9  LAB_1000_17a9:
// 1000:17a9      3b 1e e1 00              CMP BX,word ptr [0xe1]
// 1000:17ad      74 0a                    JZ 0x1000:17b9
// 1000:17af      89 1e e3 00              MOV word ptr [0xe3],BX
// 1000:17b3      88 04                    MOV byte ptr [SI],AL
// 1000:17b5  LAB_1000_17b5:
// 1000:17b5      5e                       POP SI
// 1000:17b6      5b                       POP BX
// 1000:17b7      eb d6                    JMP 0x1000:178f
// 1000:17b9  LAB_1000_17b9:
// 1000:17b9      c7 06 5a a2 02 00        MOV word ptr [0xa25a],0x2
// 1000:17bf      eb f4                    JMP 0x1000:17b5
fun_178f :: proc() {
}

// @proc 1000:17c1
// listing: FUN_1000_17c1
// status: unread
// 1000:17c1  FUN_1000_17c1:
// 1000:17c1      b4 01                    MOV AH,0x1
// 1000:17c3      cd 16                    INT 0x16
// 1000:17c5      b0 00                    MOV AL,0x0
// 1000:17c7      74 6d                    JZ 0x1000:1836
// 1000:17c9      b4 00                    MOV AH,0x0
// 1000:17cb      cd 16                    INT 0x16
// 1000:17cd      80 fc 52                 CMP AH,0x52
// 1000:17d0      74 09                    JZ 0x1000:17db
// 1000:17d2      80 fc 53                 CMP AH,0x53
// 1000:17d5      74 04                    JZ 0x1000:17db
// 1000:17d7      3c 00                    CMP AL,0x0
// 1000:17d9      75 05                    JNZ 0x1000:17e0
// 1000:17db  LAB_1000_17db:
// 1000:17db      80 cc 80                 OR AH,0x80
// 1000:17de      8a c4                    MOV AL,AH
// 1000:17e0  LAB_1000_17e0:
// 1000:17e0      3c 86                    CMP AL,0x86
// 1000:17e2      74 dd                    JZ 0x1000:17c1
// 1000:17e4      3c 13                    CMP AL,0x13
// 1000:17e6      75 07                    JNZ 0x1000:17ef
// 1000:17e8      80 36 14 00 03           XOR byte ptr [0x14],0x3
// 1000:17ed      eb d2                    JMP 0x1000:17c1
// 1000:17ef  LAB_1000_17ef:
// 1000:17ef      3c 03                    CMP AL,0x3
// 1000:17f1      75 10                    JNZ 0x1000:1803
// 1000:17f3      fe 06 59 a2              INC byte ptr [0xa259]
// 1000:17f7      80 3e 59 a2 02           CMP byte ptr [0xa259],0x2
// 1000:17fc      75 c3                    JNZ 0x1000:17c1
// 1000:17fe      b0 85                    MOV AL,0x85
// 1000:1800      eb 34                    JMP 0x1000:1836
// 1000:1803  LAB_1000_1803:
// 1000:1803      3c 04                    CMP AL,0x4
// 1000:1805      75 02                    JNZ 0x1000:1809
// 1000:1807      eb b8                    JMP 0x1000:17c1
// 1000:1809  LAB_1000_1809:
// 1000:1809      c6 06 59 a2 00           MOV byte ptr [0xa259],0x0
// 1000:180e      3c 06                    CMP AL,0x6
// 1000:1810      75 16                    JNZ 0x1000:1828
// 1000:1812      81 3e 16 00 cd 28        CMP word ptr [0x16],0x28cd
// 1000:1818      c7 06 16 00 cd 28        MOV word ptr [0x16],0x28cd
// 1000:181e      75 06                    JNZ 0x1000:1826
// 1000:1820      c7 06 16 00 1d 31        MOV word ptr [0x16],0x311d
// 1000:1826  LAB_1000_1826:
// 1000:1826      eb 99                    JMP 0x1000:17c1
// 1000:1828  LAB_1000_1828:
// 1000:1828      3c 10                    CMP AL,0x10
// 1000:182a      75 0a                    JNZ 0x1000:1836
// 1000:182c      80 36 15 00 01           XOR byte ptr [0x15],0x1
// 1000:1831      e8 7b f3                 CALL 0x1000:0baf
// 1000:1834      eb 8b                    JMP 0x1000:17c1
// 1000:1836  LAB_1000_1836:
// 1000:1836      c3                       RET
fun_17c1 :: proc() {
}

// @proc 1000:1837
// listing: FUN_1000_1837
// notes: dispatch_ship_keys
// status: unread
// 1000:1837  FUN_1000_1837:
// 1000:1837      c6 06 74 a2 00           MOV byte ptr [0xa274],0x0
// 1000:183c      bb 12 a2                 MOV BX,0xa212
// 1000:183f  LAB_1000_183f:
// 1000:183f      53                       PUSH BX
// 1000:1840      e8 7e 06                 CALL 0x1000:1ec1
// 1000:1843      8a 07                    MOV AL,byte ptr [BX]
// 1000:1845      a8 10                    TEST AL,0x10
// 1000:1847      75 0b                    JNZ 0x1000:1854
// 1000:1849      e8 c0 11                 CALL 0x1000:2a0c
// 1000:184c      f6 04 ff                 TEST byte ptr [SI],0xff
// 1000:184f      75 03                    JNZ 0x1000:1854
// 1000:1851      e8 24 03                 CALL 0x1000:1b78
// 1000:1854  LAB_1000_1854:
// 1000:1854      b9 04 00                 MOV CX,0x4
// 1000:1857      5b                       POP BX
// 1000:1858      53                       PUSH BX
// 1000:1859      89 36 50 a3              MOV word ptr [0xa350],SI
// 1000:185d  LAB_1000_185d:
// 1000:185d      8a 07                    MOV AL,byte ptr [BX]
// 1000:185f      43                       INC BX
// 1000:1860      22 c0                    AND AL,AL
// 1000:1862      74 10                    JZ 0x1000:1874
// 1000:1864      a2 11 a2                 MOV [0xa211],AL
// 1000:1867      53                       PUSH BX
// 1000:1868      51                       PUSH CX
// 1000:1869      e8 18 00                 CALL 0x1000:1884
// 1000:186c      8b 36 50 a3              MOV SI,word ptr [0xa350]
// 1000:1870      59                       POP CX
// 1000:1871      5b                       POP BX
// 1000:1872      e2 e9                    LOOP 0x1000:185d
// 1000:1874  LAB_1000_1874:
// 1000:1874      5b                       POP BX
// 1000:1875      83 c3 05                 ADD BX,0x5
// 1000:1878      fe 06 74 a2              INC byte ptr [0xa274]
// 1000:187c      80 3e 74 a2 04           CMP byte ptr [0xa274],0x4
// 1000:1881      72 bc                    JC 0x1000:183f
// 1000:1883      c3                       RET
fun_1837 :: proc() {
}

// @proc 1000:1884
// listing: FUN_1000_1884
// notes: lookup_key
// status: unread
// 1000:1884  FUN_1000_1884:
// 1000:1884      a0 74 a2                 MOV AL,[0xa274]
// 1000:1887      32 e4                    XOR AH,AH
// 1000:1889      bf 28 00                 MOV DI,0x28
// 1000:188c      f7 e7                    MUL DI
// 1000:188e      8b f8                    MOV DI,AX
// 1000:1890      81 c7 ec 89              ADD DI,0x89ec
// 1000:1894      80 3d 00                 CMP byte ptr [DI],0x0
// 1000:1897      74 0b                    JZ 0x1000:18a4
// 1000:1899      56                       PUSH SI
// 1000:189a      e8 fb 00                 CALL 0x1000:1998
// 1000:189d      5e                       POP SI
// 1000:189e      bb 09 19                 MOV BX,0x1909
// 1000:18a1      72 0a                    JC 0x1000:18ad
// 1000:18a3      c3                       RET
// 1000:18a4  LAB_1000_18a4:
// 1000:18a4      bb c4 18                 MOV BX,0x18c4
// 1000:18a7      a0 11 a2                 MOV AL,[0xa211]
// 1000:18aa      e8 c3 00                 CALL 0x1000:1970
// 1000:18ad  LAB_1000_18ad:
// 1000:18ad      2e 8a 27                 MOV AH,byte ptr CS:[BX]
// 1000:18b0      22 e4                    AND AH,AH
// 1000:18b2      74 0d                    JZ 0x1000:18c1
// 1000:18b4      3a c4                    CMP AL,AH
// 1000:18b6      74 05                    JZ 0x1000:18bd
// 1000:18b8      83 c3 03                 ADD BX,0x3
// 1000:18bb      eb f0                    JMP 0x1000:18ad
// 1000:18bd  LAB_1000_18bd:
// 1000:18bd      2e ff 67 01              JMP word ptr CS:[BX + 0x1]
// 1000:18c1  LAB_1000_18c1:
// 1000:18c1      e9 a4 01                 JMP 0x1000:1a68
fun_1884 :: proc() {
}

// 1000:1970 to_upper is in ship.odin.

// @proc 1000:197b
// listing: FUN_1000_197b
// status: unread
// 1000:197b  FUN_1000_197b:
// 1000:197b      80 3e e0 00 00           CMP byte ptr [0xe0],0x0
// 1000:1980      74 15                    JZ 0x1000:1997
// 1000:1982      fe 0e e0 00              DEC byte ptr [0xe0]
// 1000:1986      75 0f                    JNZ 0x1000:1997
// 1000:1988      e8 c2 00                 CALL 0x1000:1a4d
// 1000:198b      80 3e 9e a2 00           CMP byte ptr [0xa29e],0x0
// 1000:1990      74 05                    JZ 0x1000:1997
// 1000:1992      c6 06 e0 00 14           MOV byte ptr [0xe0],0x14
// 1000:1997  LAB_1000_1997:
// 1000:1997      c3                       RET
fun_197b :: proc() {
}

// @proc 1000:1998
// listing: FUN_1000_1998
// status: unread
// 1000:1998  FUN_1000_1998:
// 1000:1998      a0 11 a2                 MOV AL,[0xa211]
// 1000:199b      3c 0d                    CMP AL,0xd
// 1000:199d      74 37                    JZ 0x1000:19d6
// 1000:199f      3c 08                    CMP AL,0x8
// 1000:19a1      74 21                    JZ 0x1000:19c4
// 1000:19a3      3c 20                    CMP AL,0x20
// 1000:19a5      72 1b                    JC 0x1000:19c2
// 1000:19a7      3c 7e                    CMP AL,0x7e
// 1000:19a9      77 17                    JA 0x1000:19c2
// 1000:19ab      8a 5d 01                 MOV BL,byte ptr [DI + 0x1]
// 1000:19ae      32 ff                    XOR BH,BH
// 1000:19b0      88 41 02                 MOV byte ptr [BX + DI + 0x2],AL
// 1000:19b3      c6 41 03 00              MOV byte ptr [BX + DI + 0x3],0x0
// 1000:19b7      fe 45 01                 INC byte ptr [DI + 0x1]
// 1000:19ba      80 7d 01 16              CMP byte ptr [DI + 0x1],0x16
// 1000:19be      73 16                    JNC 0x1000:19d6
// 1000:19c0      f8                       CLC
// 1000:19c1      c3                       RET
// 1000:19c2  LAB_1000_19c2:
// 1000:19c2      f9                       STC
// 1000:19c3      c3                       RET
// 1000:19c4  LAB_1000_19c4:
// 1000:19c4      47                       INC DI
// 1000:19c5      8a 1d                    MOV BL,byte ptr [DI]
// 1000:19c7      32 ff                    XOR BH,BH
// 1000:19c9      80 3d 00                 CMP byte ptr [DI],0x0
// 1000:19cc      74 06                    JZ 0x1000:19d4
// 1000:19ce      c6 41 01 00              MOV byte ptr [BX + DI + 0x1],0x0
// 1000:19d2      fe 0d                    DEC byte ptr [DI]
// 1000:19d4  LAB_1000_19d4:
// 1000:19d4      f8                       CLC
// 1000:19d5      c3                       RET
// 1000:19d6  LAB_1000_19d6:
// 1000:19d6      57                       PUSH DI
// 1000:19d7      47                       INC DI
// 1000:19d8      8a 0d                    MOV CL,byte ptr [DI]
// 1000:19da      81 e1 ff 00              AND CX,0xff
// 1000:19de      74 63                    JZ 0x1000:1a43
// 1000:19e0      8a 45 02                 MOV AL,byte ptr [DI + 0x2]
// 1000:19e3      3c 3a                    CMP AL,0x3a
// 1000:19e5      75 16                    JNZ 0x1000:19fd
// 1000:19e7      8a 45 01                 MOV AL,byte ptr [DI + 0x1]
// 1000:19ea      2c 41                    SUB AL,0x41
// 1000:19ec      3a 06 6f a2              CMP AL,byte ptr [0xa26f]
// 1000:19f0      75 51                    JNZ 0x1000:1a43
// 1000:19f2      83 e9 02                 SUB CX,0x2
// 1000:19f5      76 4c                    JBE 0x1000:1a43
// 1000:19f7      83 c7 02                 ADD DI,0x2
// 1000:19fa      eb 0a                    JMP 0x1000:1a06
// 1000:19fd  LAB_1000_19fd:
// 1000:19fd      a0 74 a2                 MOV AL,[0xa274]
// 1000:1a00      3a 06 6f a2              CMP AL,byte ptr [0xa26f]
// 1000:1a04      74 3d                    JZ 0x1000:1a43
// 1000:1a06  LAB_1000_1a06:
// 1000:1a06      be 9e a2                 MOV SI,0xa29e
// 1000:1a09      b0 04                    MOV AL,0x4
// 1000:1a0b  LAB_1000_1a0b:
// 1000:1a0b      80 3c 00                 CMP byte ptr [SI],0x0
// 1000:1a0e      74 0c                    JZ 0x1000:1a1c
// 1000:1a10      83 c6 28                 ADD SI,0x28
// 1000:1a13      fe c8                    DEC AL
// 1000:1a15      75 f4                    JNZ 0x1000:1a0b
// 1000:1a17      e8 33 00                 CALL 0x1000:1a4d
// 1000:1a1a      eb ea                    JMP 0x1000:1a06
// 1000:1a1c  LAB_1000_1a1c:
// 1000:1a1c      47                       INC DI
// 1000:1a1d      87 f7                    XCHG DI,SI
// 1000:1a1f      b0 01                    MOV AL,0x1
// 1000:1a21      aa                       STOSB ES:DI
// 1000:1a22      f3 a4                    MOVSB.REP ES:DI,SI
// 1000:1a24      80 3e 0a 00 02           CMP byte ptr [0xa],0x2
// 1000:1a29      76 09                    JBE 0x1000:1a34
// 1000:1a2b      b0 2c                    MOV AL,0x2c
// 1000:1a2d      aa                       STOSB ES:DI
// 1000:1a2e      a0 74 a2                 MOV AL,[0xa274]
// 1000:1a31      04 41                    ADD AL,0x41
// 1000:1a33      aa                       STOSB ES:DI
// 1000:1a34  LAB_1000_1a34:
// 1000:1a34      b0 00                    MOV AL,0x0
// 1000:1a36      aa                       STOSB ES:DI
// 1000:1a37      80 3e e0 00 00           CMP byte ptr [0xe0],0x0
// 1000:1a3c      75 05                    JNZ 0x1000:1a43
// 1000:1a3e      c6 06 e0 00 14           MOV byte ptr [0xe0],0x14
// 1000:1a43  LAB_1000_1a43:
// 1000:1a43      5f                       POP DI
// 1000:1a44      b0 00                    MOV AL,0x0
// 1000:1a46      b9 28 00                 MOV CX,0x28
// 1000:1a49      f3 aa                    STOSB.REP ES:DI
// 1000:1a4b      f8                       CLC
// 1000:1a4c      c3                       RET
fun_1998 :: proc() {
}

// 1000:1a4d scroll_message_queue is in ship.odin.

// 1000:1a68 beep is in ship.odin.

// 1000:1a97 store_if_local_ship is in ship.odin.

// @proc 1000:1b78
// listing: FUN_1000_1b78
// status: unread
// 1000:1b78  FUN_1000_1b78:
// 1000:1b78      e8 46 03                 CALL 0x1000:1ec1
// 1000:1b7b      80 0f 10                 OR byte ptr [BX],0x10
// 1000:1b7e      c3                       RET
// 1000:1b7f      e8 10 03                 CALL 0x1000:1e92
// 1000:1b82      e8 49 03                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:1b8d  [ptr] 1000:9014 1000:9022 1000:9030 1000:903e
// 1000:1b8d  LAB_1000_1b8d:
// 1000:1b8d      8a 47 05                 MOV AL,byte ptr [BX + 0x5]
// 1000:1b90      3a 44 17                 CMP AL,byte ptr [SI + 0x17]
// 1000:1b93      75 0f                    JNZ 0x1000:1ba4
// 1000:1b95      88 44 31                 MOV byte ptr [SI + 0x31],AL
// 1000:1b98      8b 44 01                 MOV AX,word ptr [SI + 0x1]
// 1000:1b9b      89 44 2d                 MOV word ptr [SI + 0x2d],AX
// 1000:1b9e      8b 44 03                 MOV AX,word ptr [SI + 0x3]
// 1000:1ba1      89 44 2f                 MOV word ptr [SI + 0x2f],AX
// 1000:1ba4  LAB_1000_1ba4:
// 1000:1ba4      c3                       RET
// 1000:1ba5      e8 ea 02                 CALL 0x1000:1e92
// 1000:1ba8      fe 44 2b                 INC byte ptr [SI + 0x2b]
// 1000:1bab      80 64 2b 03              AND byte ptr [SI + 0x2b],0x3
// 1000:1baf      c3                       RET
// 1000:1bb0      e8 0e 03                 CALL 0x1000:1ec1
// 1000:1bb3      80 07 40                 ADD byte ptr [BX],0x40
// 1000:1bb6      c3                       RET
// 1000:1bb7  LAB_1000_1bb7:
// 1000:1bb7      e8 d8 02                 CALL 0x1000:1e92
// 1000:1bba      80 0c 20                 OR byte ptr [SI],0x20
// 1000:1bbd      8b 74 32                 MOV SI,word ptr [SI + 0x32]
// 1000:1bc0      23 f6                    AND SI,SI
// 1000:1bc2      75 f3                    JNZ 0x1000:1bb7
// 1000:1bc4      c3                       RET
// 1000:1bc5  LAB_1000_1bc5:
// 1000:1bc5      e8 ca 02                 CALL 0x1000:1e92
// 1000:1bc8      80 24 df                 AND byte ptr [SI],0xdf
// 1000:1bcb      8b 74 32                 MOV SI,word ptr [SI + 0x32]
// 1000:1bce      23 f6                    AND SI,SI
// 1000:1bd0      75 f3                    JNZ 0x1000:1bc5
// 1000:1bd2      c3                       RET
// 1000:1bd3      e8 bc 02                 CALL 0x1000:1e92
// 1000:1bd6      c6 44 11 00              MOV byte ptr [SI + 0x11],0x0
// 1000:1bda      80 44 0a 10              ADD byte ptr [SI + 0xa],0x10
// 1000:1bde      c3                       RET
// 1000:1bdf      e8 b0 02                 CALL 0x1000:1e92
// 1000:1be2      c6 44 11 00              MOV byte ptr [SI + 0x11],0x0
// 1000:1be6      80 6c 0a 10              SUB byte ptr [SI + 0xa],0x10
// 1000:1bea      c3                       RET
// 1000:1beb      e8 a4 02                 CALL 0x1000:1e92
// 1000:1bee      80 64 11 7f              AND byte ptr [SI + 0x11],0x7f
// 1000:1bf2      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
// 1000:1bf5      24 f0                    AND AL,0xf0
// 1000:1bf7      3c a0                    CMP AL,0xa0
// 1000:1bf9      73 04                    JNC 0x1000:1bff
// 1000:1bfb      80 44 0b 10              ADD byte ptr [SI + 0xb],0x10
// 1000:1bff  LAB_1000_1bff:
// 1000:1bff      c3                       RET
// 1000:1c00      e8 8f 02                 CALL 0x1000:1e92
// 1000:1c03      80 64 11 7f              AND byte ptr [SI + 0x11],0x7f
// 1000:1c07      8a 44 0b                 MOV AL,byte ptr [SI + 0xb]
// 1000:1c0a      24 f0                    AND AL,0xf0
// 1000:1c0c      74 08                    JZ 0x1000:1c16
// 1000:1c0e      80 6c 0b 10              SUB byte ptr [SI + 0xb],0x10
// 1000:1c12      c6 44 14 00              MOV byte ptr [SI + 0x14],0x0
// 1000:1c16  LAB_1000_1c16:
// 1000:1c16      c3                       RET
// 1000:1c17  LAB_1000_1c17:
// 1000:1c17      e8 78 02                 CALL 0x1000:1e92
// 1000:1c1a      8a 44 19                 MOV AL,byte ptr [SI + 0x19]
// 1000:1c1d      22 c0                    AND AL,AL
// 1000:1c1f      78 0a                    JS 0x1000:1c2b
// 1000:1c21      74 08                    JZ 0x1000:1c2b
// 1000:1c23      3c 04                    CMP AL,0x4
// 1000:1c25      72 04                    JC 0x1000:1c2b
// 1000:1c27      c6 44 19 03              MOV byte ptr [SI + 0x19],0x3
// 1000:1c2b  LAB_1000_1c2b:
// 1000:1c2b      8b 74 32                 MOV SI,word ptr [SI + 0x32]
// 1000:1c2e      23 f6                    AND SI,SI
// 1000:1c30      75 e5                    JNZ 0x1000:1c17
// 1000:1c32      c3                       RET
// 1000:1c33  LAB_1000_1c33:
// 1000:1c33      e8 5c 02                 CALL 0x1000:1e92
// 1000:1c36      e8 08 00                 CALL 0x1000:1c41
// 1000:1c39      8b 74 32                 MOV SI,word ptr [SI + 0x32]
// 1000:1c3c      23 f6                    AND SI,SI
// 1000:1c3e      75 f3                    JNZ 0x1000:1c33
// 1000:1c40      c3                       RET
fun_1b78 :: proc() {
}

// @proc 1000:1c41
// listing: FUN_1000_1c41
// status: unread
// 1000:1c41  FUN_1000_1c41:
// 1000:1c41      f6 44 15 ff              TEST byte ptr [SI + 0x15],0xff
// 1000:1c45      75 4e                    JNZ 0x1000:1c95
// 1000:1c47      8a 44 19                 MOV AL,byte ptr [SI + 0x19]
// 1000:1c4a      22 c0                    AND AL,AL
// 1000:1c4c      75 47                    JNZ 0x1000:1c95
// 1000:1c4e      8b 44 0a                 MOV AX,word ptr [SI + 0xa]
// 1000:1c51      25 0f 0f                 AND AX,0xf0f
// 1000:1c54      f6 04 04                 TEST byte ptr [SI],0x4
// 1000:1c57      74 04                    JZ 0x1000:1c5d
// 1000:1c59      b4 18                    MOV AH,0x18
// 1000:1c5b      eb 11                    JMP 0x1000:1c6e
// 1000:1c5d  LAB_1000_1c5d:
// 1000:1c5d      80 c4 09                 ADD AH,0x9
// 1000:1c60      80 fc 13                 CMP AH,0x13
// 1000:1c63      72 09                    JC 0x1000:1c6e
// 1000:1c65      f6 44 14 ff              TEST byte ptr [SI + 0x14],0xff
// 1000:1c69      74 03                    JZ 0x1000:1c6e
// 1000:1c6b      80 c4 07                 ADD AH,0x7
// 1000:1c6e  LAB_1000_1c6e:
// 1000:1c6e      89 44 1f                 MOV word ptr [SI + 0x1f],AX
// 1000:1c71      f6 44 07 ff              TEST byte ptr [SI + 0x7],0xff
// 1000:1c75      74 1e                    JZ 0x1000:1c95
// 1000:1c77      fe 4c 07                 DEC byte ptr [SI + 0x7]
// 1000:1c7a      c6 44 19 26              MOV byte ptr [SI + 0x19],0x26
// 1000:1c7e      c6 44 15 06              MOV byte ptr [SI + 0x15],0x6
// 1000:1c82      8b 44 01                 MOV AX,word ptr [SI + 0x1]
// 1000:1c85      89 44 1a                 MOV word ptr [SI + 0x1a],AX
// 1000:1c88      8b 44 03                 MOV AX,word ptr [SI + 0x3]
// 1000:1c8b      89 44 1c                 MOV word ptr [SI + 0x1c],AX
// 1000:1c8e      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
// 1000:1c91      88 44 1e                 MOV byte ptr [SI + 0x1e],AL
// 1000:1c94      c3                       RET
// 1000:1c95  LAB_1000_1c95:
// 1000:1c95      b8 04 00                 MOV AX,0x4
// 1000:1c98      bb 5a a2                 MOV BX,0xa25a
// 1000:1c9b      e8 f9 fd                 CALL 0x1000:1a97
// 1000:1c9e      c3                       RET
// 1000:1c9f      e8 f0 01                 CALL 0x1000:1e92
// 1000:1ca2      80 7c 2a 00              CMP byte ptr [SI + 0x2a],0x0
// 1000:1ca6      74 04                    JZ 0x1000:1cac
// 1000:1ca8      80 74 22 01              XOR byte ptr [SI + 0x22],0x1
// 1000:1cac  LAB_1000_1cac:
// 1000:1cac      c3                       RET
// 1000:1cad      e8 e2 01                 CALL 0x1000:1e92
// 1000:1cb0      80 74 29 02              XOR byte ptr [SI + 0x29],0x2
// 1000:1cb4      c3                       RET
// 1000:1cb5  LAB_1000_1cb5:
// 1000:1cb5      e8 da 01                 CALL 0x1000:1e92
// 1000:1cb8      e8 08 00                 CALL 0x1000:1cc3
// 1000:1cbb      8b 74 32                 MOV SI,word ptr [SI + 0x32]
// 1000:1cbe      23 f6                    AND SI,SI
// 1000:1cc0      75 f3                    JNZ 0x1000:1cb5
// 1000:1cc2      c3                       RET
fun_1c41 :: proc() {
}

// 1000:1cc3 set_invisible_bit is in ship.odin.

// 1000:1cdb apply_warp is in ship.odin.

// 1000:1d0f emergency_stop is in ship.odin.

// 1000:1d64 fill_mine_slot is in ship.odin.

// 1000:1d97  LAB_1000_1d97:
// 1000:1d97      e8 f8 00                 CALL 0x1000:1e92
// 1000:1d9a      e8 08 00                 CALL 0x1000:1da5
// 1000:1d9d      8b 74 32                 MOV SI,word ptr [SI + 0x32]
// 1000:1da0      23 f6                    AND SI,SI
// 1000:1da2      75 f3                    JNZ 0x1000:1d97
// 1000:1da4      c3                       RET

// @proc 1000:1da5
// listing: FUN_1000_1da5
// status: unread
// 1000:1da5  FUN_1000_1da5:
// 1000:1da5      f6 44 15 ff              TEST byte ptr [SI + 0x15],0xff
// 1000:1da9      75 43                    JNZ 0x1000:1dee
// 1000:1dab      f6 44 19 80              TEST byte ptr [SI + 0x19],0x80
// 1000:1daf      75 3d                    JNZ 0x1000:1dee
// 1000:1db1      b8 c8 00                 MOV AX,0xc8
// 1000:1db4      8b fe                    MOV DI,SI
// 1000:1db6      e8 e2 05                 CALL 0x1000:239b
// 1000:1db9      8b 44 0a                 MOV AX,word ptr [SI + 0xa]
// 1000:1dbc      25 0f 0f                 AND AX,0xf0f
// 1000:1dbf      80 c4 09                 ADD AH,0x9
// 1000:1dc2      80 fc 13                 CMP AH,0x13
// 1000:1dc5      72 09                    JC 0x1000:1dd0
// 1000:1dc7      f6 44 14 ff              TEST byte ptr [SI + 0x14],0xff
// 1000:1dcb      74 03                    JZ 0x1000:1dd0
// 1000:1dcd      80 c4 07                 ADD AH,0x7
// 1000:1dd0  LAB_1000_1dd0:
// 1000:1dd0      89 44 1f                 MOV word ptr [SI + 0x1f],AX
// 1000:1dd3      c6 44 19 8c              MOV byte ptr [SI + 0x19],0x8c
// 1000:1dd7      c6 44 15 0c              MOV byte ptr [SI + 0x15],0xc
// 1000:1ddb      8b 44 01                 MOV AX,word ptr [SI + 0x1]
// 1000:1dde      89 44 1a                 MOV word ptr [SI + 0x1a],AX
// 1000:1de1      8b 44 03                 MOV AX,word ptr [SI + 0x3]
// 1000:1de4      89 44 1c                 MOV word ptr [SI + 0x1c],AX
// 1000:1de7      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
// 1000:1dea      88 44 1e                 MOV byte ptr [SI + 0x1e],AL
// 1000:1ded      c3                       RET
// 1000:1dee  LAB_1000_1dee:
// 1000:1dee      b8 04 00                 MOV AX,0x4
// 1000:1df1      bb 5a a2                 MOV BX,0xa25a
// 1000:1df4      e8 a0 fc                 CALL 0x1000:1a97
// 1000:1df7      c3                       RET
// 1000:1df8  LAB_1000_1df8:
// 1000:1df8      e8 97 00                 CALL 0x1000:1e92
// 1000:1dfb      e8 08 00                 CALL 0x1000:1e06
// 1000:1dfe      8b 74 32                 MOV SI,word ptr [SI + 0x32]
// 1000:1e01      23 f6                    AND SI,SI
// 1000:1e03      75 f3                    JNZ 0x1000:1df8
// 1000:1e05      c3                       RET
fun_1da5 :: proc() {
}

// @proc 1000:1e06
// listing: FUN_1000_1e06
// status: unread
// 1000:1e06  FUN_1000_1e06:
// 1000:1e06      f6 44 15 ff              TEST byte ptr [SI + 0x15],0xff
// 1000:1e0a      75 3e                    JNZ 0x1000:1e4a
// 1000:1e0c      f6 44 19 80              TEST byte ptr [SI + 0x19],0x80
// 1000:1e10      75 38                    JNZ 0x1000:1e4a
// 1000:1e12      b8 64 00                 MOV AX,0x64
// 1000:1e15      8b fe                    MOV DI,SI
// 1000:1e17      e8 81 05                 CALL 0x1000:239b
// 1000:1e1a      8b 44 0a                 MOV AX,word ptr [SI + 0xa]
// 1000:1e1d      80 e4 0f                 AND AH,0xf
// 1000:1e20      80 ec 09                 SUB AH,0x9
// 1000:1e23      79 04                    JNS 0x1000:1e29
// 1000:1e25      f6 dc                    NEG AH
// 1000:1e27      34 08                    XOR AL,0x8
// 1000:1e29  LAB_1000_1e29:
// 1000:1e29      25 0f 0f                 AND AX,0xf0f
// 1000:1e2c      89 44 1f                 MOV word ptr [SI + 0x1f],AX
// 1000:1e2f      c6 44 19 ca              MOV byte ptr [SI + 0x19],0xca
// 1000:1e33      c6 44 15 0a              MOV byte ptr [SI + 0x15],0xa
// 1000:1e37      8b 44 01                 MOV AX,word ptr [SI + 0x1]
// 1000:1e3a      89 44 1a                 MOV word ptr [SI + 0x1a],AX
// 1000:1e3d      8b 44 03                 MOV AX,word ptr [SI + 0x3]
// 1000:1e40      89 44 1c                 MOV word ptr [SI + 0x1c],AX
// 1000:1e43      8a 44 05                 MOV AL,byte ptr [SI + 0x5]
// 1000:1e46      88 44 1e                 MOV byte ptr [SI + 0x1e],AL
// 1000:1e49      c3                       RET
// 1000:1e4a  LAB_1000_1e4a:
// 1000:1e4a      b8 04 00                 MOV AX,0x4
// 1000:1e4d      bb 5a a2                 MOV BX,0xa25a
// 1000:1e50      e8 44 fc                 CALL 0x1000:1a97
// 1000:1e53      c3                       RET
// 1000:1e54  LAB_1000_1e54:
// 1000:1e54      e8 3b 00                 CALL 0x1000:1e92
// 1000:1e57      80 24 ef                 AND byte ptr [SI],0xef
// 1000:1e5a      8b 74 32                 MOV SI,word ptr [SI + 0x32]
// 1000:1e5d      23 f6                    AND SI,SI
// 1000:1e5f      75 f3                    JNZ 0x1000:1e54
// 1000:1e61      c3                       RET
// 1000:1e62      e8 2d 00                 CALL 0x1000:1e92
// 1000:1e65      8b 44 08                 MOV AX,word ptr [SI + 0x8]
// 1000:1e68      3d 88 13                 CMP AX,0x1388
// 1000:1e6b      72 0a                    JC 0x1000:1e77
// 1000:1e6d      b8 04 00                 MOV AX,0x4
// 1000:1e70      bb 5a a2                 MOV BX,0xa25a
// 1000:1e73      e8 21 fc                 CALL 0x1000:1a97
// 1000:1e76      c3                       RET
// 1000:1e77  LAB_1000_1e77:
// 1000:1e77      c7 44 0c 50 c3           MOV word ptr [SI + 0xc],0xc350
// 1000:1e7c      c3                       RET
// 1000:1e7d      e8 4e 00                 CALL 0x1000:1ece
//                 ; ptr table -> 1000:1e88  [ptr] 1000:89d8 1000:89d9 1000:89da 1000:89db
// 1000:1e88  LAB_1000_1e88:
// 1000:1e88      80 0f 01                 OR byte ptr [BX],0x1
// 1000:1e8b      c3                       RET
// 1000:1e8c      c6 06 ed 00 01           MOV byte ptr [0xed],0x1
// 1000:1e91      c3                       RET
fun_1e06 :: proc() {
}

// @proc 1000:1e92
// listing: FUN_1000_1e92
// notes: command_gate
// status: unread
// 1000:1e92  FUN_1000_1e92:
// 1000:1e92      f6 04 80                 TEST byte ptr [SI],0x80
// 1000:1e95      74 1f                    JZ 0x1000:1eb6
// 1000:1e97      f6 06 6c a2 80           TEST byte ptr [0xa26c],0x80
// 1000:1e9c      75 18                    JNZ 0x1000:1eb6
// 1000:1e9e      51                       PUSH CX
// 1000:1e9f      8a 0e 74 a2              MOV CL,byte ptr [0xa274]
// 1000:1ea3      b5 01                    MOV CH,0x1
// 1000:1ea5      d2 e5                    SHL CH,CL
// 1000:1ea7      22 2e 6c a2              AND CH,byte ptr [0xa26c]
// 1000:1eab      59                       POP CX
// 1000:1eac      75 08                    JNZ 0x1000:1eb6
// 1000:1eae      e8 10 00                 CALL 0x1000:1ec1
// 1000:1eb1      f6 07 10                 TEST byte ptr [BX],0x10
// 1000:1eb4      74 0a                    JZ 0x1000:1ec0
// 1000:1eb6  LAB_1000_1eb6:
// 1000:1eb6      b8 06 00                 MOV AX,0x6
// 1000:1eb9      bb 5a a2                 MOV BX,0xa25a
// 1000:1ebc      e8 d8 fb                 CALL 0x1000:1a97
// 1000:1ebf      5b                       POP BX
// 1000:1ec0  LAB_1000_1ec0:
// 1000:1ec0      c3                       RET
fun_1e92 :: proc() {
}

// 1000:1ec1 ship_flag_ptr is in ship.odin.

// @proc 1000:1ece
// listing: pick_ptr
// status: unread
// 1000:1ece  pick_ptr:
// 1000:1ece      5b                       POP BX
// 1000:1ecf      83 c3 08                 ADD BX,0x8
// 1000:1ed2      53                       PUSH BX
// 1000:1ed3      50                       PUSH AX
// 1000:1ed4      83 eb 08                 SUB BX,0x8
// 1000:1ed7      a0 74 a2                 MOV AL,[0xa274]
// 1000:1eda      25 03 00                 AND AX,0x3
// 1000:1edd      d1 e0                    SHL AX,0x1
// 1000:1edf      03 d8                    ADD BX,AX
// 1000:1ee1      58                       POP AX
// 1000:1ee2      2e 8b 1f                 MOV BX,word ptr CS:[BX]
// 1000:1ee5      c3                       RET
fun_1ece :: proc() {
}

// @proc 1000:1ee6
// listing: FUN_1000_1ee6
// notes: update_all_ships
// status: unread
// 1000:1ee6  FUN_1000_1ee6:
// 1000:1ee6      e8 b9 03                 CALL 0x1000:22a2
// 1000:1ee9      e8 43 01                 CALL 0x1000:202f
// 1000:1eec      e8 54 04                 CALL 0x1000:2343
// 1000:1eef      bf 64 8c                 MOV DI,0x8c64
// 1000:1ef2      c6 06 74 a2 00           MOV byte ptr [0xa274],0x0
// 1000:1ef7      e8 22 00                 CALL 0x1000:1f1c
// 1000:1efa      bf 50 8d                 MOV DI,0x8d50
// 1000:1efd      c6 06 74 a2 01           MOV byte ptr [0xa274],0x1
// 1000:1f02      e8 17 00                 CALL 0x1000:1f1c
// 1000:1f05      bf 3c 8e                 MOV DI,0x8e3c
// 1000:1f08      c6 06 74 a2 02           MOV byte ptr [0xa274],0x2
// 1000:1f0d      e8 0c 00                 CALL 0x1000:1f1c
// 1000:1f10      bf 28 8f                 MOV DI,0x8f28
// 1000:1f13      c6 06 74 a2 03           MOV byte ptr [0xa274],0x3
// 1000:1f18      e8 01 00                 CALL 0x1000:1f1c
// 1000:1f1b      c3                       RET
fun_1ee6 :: proc() {
}

