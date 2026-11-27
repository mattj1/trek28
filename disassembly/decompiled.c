/* Decompiled by Ghidra 12.2 from TREK28.COM (x86 real mode).
 * 16-bit DOS code. Types, segment overrides, and calling convention
 * are inferred. INT instructions stay as inline intrinsics or calls.
 */

/* 1000:0018 start */

/* WARNING: Stack frame is not setup normally: Input value of stackpointer is not used */
/* WARNING: This function may have set the stack pointer */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */
/* Relocated program entry (start).
   Incoming DS/ES/SS are still the DOS PSP segment 0FF0.
   Startup then sets DS = CS+0AC7h = 1AC7h (file offset AC70h) and
   SS:SP = (CS+1532h):0200, a stack in the RAM block past the image.
   PSP:0002 supplies the top paragraph of the allocation (A000h). */

void start(void)

{
  undefined1 *puVar1;
  code *pcVar2;
  int iVar3;
  undefined *puVar4;
  undefined2 extraout_DX;
  int iVar5;
  undefined1 *puVar6;
  undefined1 *puVar7;
  
  _LAB_1000_0004 = 0xff0;
  DAT_1000_0002 = 0;
  _LAB_1000_0000 = 0x1ac7;
  DAT_2000_551e = 0x42;
  FUN_1000_0113();
  puVar6 = (undefined1 *)&UNK_0000_0200;
  iVar5 = (DAT_1000_0010 >> 4) + 0x1000;
  puVar7 = (undefined1 *)0x0;
  for (iVar3 = (0x2532 - iVar5) * 0x10; iVar3 != 0; iVar3 = iVar3 + -1) {
    puVar1 = puVar7;
    puVar7 = puVar7 + 1;
    *puVar1 = 0;
  }
  for (puVar4 = puVar6; DAT_2000_4eec = _UNK_0000_0072, DAT_2000_4eea = _UNK_0000_0070,
      puVar4 != (undefined1 *)0x0; puVar4 = puVar4 + -1) {
    puVar1 = puVar7;
    puVar7 = puVar7 + 1;
    *puVar1 = 0;
  }
  DAT_2000_4e70 = in(0x21);
  DAT_2000_4fb3 = (undefined *)&UNK_0000_0200;
                    /* WARNING: Read-only address (ram,0x00000070) is written */
  LOCK();
  _UNK_0000_0070 = (undefined1 *)&DAT_0000_6820;
  UNLOCK();
                    /* WARNING: Read-only address (ram,0x00000072) is written */
  LOCK();
  _UNK_0000_0072 = 0x1000;
  UNLOCK();
                    /* WARNING: Read-only address (ram,0x00000004) is written */
  _UNK_0000_0004 = 0x5fe3;
                    /* WARNING: Read-only address (ram,0x00000006) is written */
  _UNK_0000_0006 = 0x1000;
                    /* WARNING: Read-only address (ram,0x0000000c) is written */
  _UNK_0000_000c = 0x684b;
                    /* WARNING: Read-only address (ram,0x0000000e) is written */
  _UNK_0000_000e = 0x1000;
  pcVar2 = (code *)swi(0x10);
  (*pcVar2)();
  *(undefined2 *)(puVar6 + -2) = 0xac;
  FUN_1000_0baf();
  DAT_1000_ad15 = 0xb5;
  *(undefined2 *)(puVar6 + -2) = 0xb5;
  FUN_1000_a800();
  puVar4 = DAT_2000_4fb3;
  puVar7 = (undefined1 *)0x89d0;
  for (iVar3 = DAT_1000_ad41; iVar3 != 0; iVar3 = iVar3 + -1) {
    puVar1 = puVar7;
    puVar7 = puVar7 + 1;
    *puVar1 = 0;
  }
  DAT_1000_ad15 = 0xd1;
  *(undefined2 *)(puVar4 + -2) = 0xd1;
  FUN_1000_a93e();
  puVar4 = DAT_2000_4fb3;
  puVar7 = (undefined1 *)0x89d0;
  for (iVar3 = DAT_1000_ad41; iVar3 != 0; iVar3 = iVar3 + -1) {
    puVar1 = puVar7;
    puVar7 = puVar7 + 1;
    *puVar1 = 0;
  }
  pcVar2 = (code *)swi(0x1a);
  (*pcVar2)();
  DAT_2000_3640 = CONCAT11((char)extraout_DX,(char)((uint)extraout_DX >> 8));
  DAT_2000_4ee0 = 7;
  *(undefined2 *)(puVar4 + -2) = 0xf2;
  FUN_1000_0585();
  DAT_2000_4ed7 = 0;
  DAT_1000_ad15 = 0x166;
  iVar3 = 2000;
  do {
    *(int *)(puVar4 + -2) = iVar3;
    iVar3 = 0x1996;
    do {
      iVar3 = iVar3 + -1;
    } while (iVar3 != 0);
    DAT_2000_3640 = DAT_2000_3640 + 1;
    *(undefined2 *)(puVar4 + -4) = 0x10d;
    FUN_1000_0b45();
    iVar3 = *(int *)(puVar4 + -2) + -1;
  } while (iVar3 != 0);
  FUN_1000_0166();
  return;
}


/* 1000:0113 FUN_1000_0113 */

void __cdecl16near FUN_1000_0113(void)

{
  code *pcVar1;
  undefined2 uVar2;
  uint uVar3;
  uint unaff_BP;
  int unaff_SS;
  
  if (unaff_SS + 0x32U < unaff_BP) {
    pcVar1 = (code *)swi(0x21);
    uVar2 = (*pcVar1)();
    if (0x1ff < CONCAT11((char)uVar2,(char)((uint)uVar2 >> 8))) {
      pcVar1 = (code *)swi(0x11);
      uVar3 = (*pcVar1)();
      if ((uVar3 & 0x30) == 0x30) {
        DAT_0000_0410 = DAT_0000_0410 & 0xef;
      }
      return;
    }
  }
  FUN_1000_0158();
                    /* WARNING: Could not recover jumptable at 0x00010153. Too many branches */
                    /* WARNING: Treating indirect jump as call */
  (*(code *)(ulong)DAT_1000_0002)();
  return;
}


/* 1000:0158 FUN_1000_0158 */

void __cdecl16near FUN_1000_0158(void)

{
  char *pcVar1;
  code *pcVar2;
  char *unaff_SI;
  undefined2 unaff_DS;
  
  while (pcVar1 = unaff_SI, unaff_SI = unaff_SI + 1, *pcVar1 != '\0') {
    pcVar2 = (code *)swi(0x21);
    (*pcVar2)();
  }
  return;
}


/* 1000:0166 FUN_1000_0166 */

/* WARNING (jumptable): Stack frame is not setup normally: Input value of stackpointer is not used
    */
/* WARNING: Stack frame is not setup normally: Input value of stackpointer is not used */

void __cdecl16near FUN_1000_0166(void)

{
  int *piVar1;
  int iVar2;
  char cVar3;
  undefined2 *puVar4;
  undefined1 *puVar5;
  undefined1 *puVar6;
  undefined2 unaff_SS;
  undefined2 unaff_DS;
  bool bVar7;
  
  *(undefined2 *)0xa209 = 0;
  iVar2 = *(int *)0xa343;
  out(0x21,0xff);
  *(undefined2 *)(iVar2 + -2) = 0x177;
  FUN_1000_0c7c();
  *(undefined2 *)(iVar2 + -2) = 0x17a;
  FUN_1000_6980();
  *(undefined1 *)0xa271 = 0;
  *(undefined2 *)(iVar2 + -2) = 0x182;
  FUN_1000_0393();
  *(undefined2 *)(iVar2 + -2) = 0x185;
  print_inline();
  if (*(char *)0xa272 != '\x01') {
    *(undefined2 *)(iVar2 + -2) = 0x1b9;
    print_inline();
  }
  *(undefined2 *)(iVar2 + -2) = 0x1d2;
  print_inline();
  if (*(char *)&UNK_0000_0007 == ' ') {
    *(undefined2 *)(iVar2 + -2) = 0x1fa;
    print_inline();
  }
  else {
    *(undefined2 *)(iVar2 + -2) = 0x21a;
    print_inline();
    *(undefined2 *)(iVar2 + -2) = 0x239;
    FUN_1000_0562();
    *(undefined2 *)(iVar2 + -2) = 0x23c;
    print_inline();
  }
  *(undefined2 *)(iVar2 + -2) = 0x244;
  print_inline();
  if (*(char *)&UNK_0000_000a == '\x01') {
    *(undefined2 *)(iVar2 + -2) = 0x263;
    print_inline();
    *(undefined2 *)(iVar2 + -2) = 0x274;
    FUN_1000_07ef();
    puVar5 = (undefined1 *)(iVar2 + -2);
    *(undefined2 *)(iVar2 + -2) = 0x279;
    FUN_1000_5577();
    if (*(char *)&UNK_0000_0013 == '\0') {
      *(undefined2 *)(puVar5 + -2) = 0x283;
      print_inline();
    }
    else {
      puVar4 = (undefined2 *)(puVar5 + -2);
      puVar5 = puVar5 + -2;
      *puVar4 = 0x297;
      FUN_1000_5577();
      *(undefined2 *)(puVar5 + -2) = 0x29a;
      print_inline();
    }
  }
  else {
    *(undefined2 *)(iVar2 + -2) = 0x2ad;
    print_inline();
    *(undefined2 *)(iVar2 + -2) = 699;
    FUN_1000_0c6a();
    *(undefined2 *)(iVar2 + -2) = 0x2be;
    print_inline();
    puVar5 = (undefined1 *)(iVar2 + -2);
    *(undefined2 *)(iVar2 + -2) = 0x2d3;
    FUN_1000_5577();
    if (*(char *)&UNK_0000_000e == '\0') {
      *(undefined2 *)(puVar5 + -2) = 0x2dd;
      print_inline();
    }
    else {
      *(undefined2 *)(puVar5 + -2) = 0x2eb;
      print_inline();
    }
  }
  *(undefined2 *)(puVar5 + -2) = 0x2f6;
  print_inline();
  puVar6 = puVar5 + -2;
  *(undefined2 *)(puVar5 + -2) = 0x34c;
  FUN_1000_580c();
  *(undefined2 *)(puVar6 + -2) = 0x351;
  FUN_1000_0bee();
  do {
    piVar1 = (int *)0x89d0;
    *piVar1 = *piVar1 + 1;
    bVar7 = *piVar1 == 0;
    *(undefined2 *)(puVar6 + -2) = 0x358;
    cVar3 = FUN_1000_0b45();
  } while (bVar7);
  bVar7 = cVar3 == '\x06';
  if (!bVar7) {
    *(undefined2 *)(puVar6 + -2) = 0x361;
    FUN_1000_0b07();
    if (bVar7) {
      *(char *)0xa267 = *(char *)0xa267 + '\x01';
      FUN_1000_0166();
      return;
    }
    *(undefined2 *)(puVar6 + -2) = 0x36d;
    cVar3 = FUN_1000_0b0e();
    if (bVar7) {
      *(char *)0xa267 = *(char *)0xa267 + -1;
    }
    if (cVar3 == '\r') {
      if ((*(char *)0xa272 != '\x01') && (*(int *)0xa341 != 0x496)) {
        *(undefined2 *)0xa341 = 28000;
      }
                    /* WARNING: Could not recover jumptable at 0x0001038c. Too many branches */
                    /* WARNING: Treating indirect jump as call */
      (*(code *)*(undefined2 *)0xa341)();
      return;
    }
  }
  FUN_1000_0166();
  return;
}


/* 1000:0393 FUN_1000_0393 */

void __cdecl16near FUN_1000_0393(void)

{
  int iVar1;
  undefined2 unaff_DS;
  
  if (7 < *(byte *)0xa267) {
    if (*(byte *)0xa267 == 8) {
      *(undefined1 *)0xa267 = 0;
    }
    else {
      *(undefined1 *)0xa267 = 7;
    }
  }
  iVar1 = (uint)*(byte *)0xa267 * (CONCAT11(6,*(byte *)0xa267) >> 8);
  *(undefined2 *)&UNK_0000_0091 = *(undefined2 *)(iVar1 + 0x3ca);
  *(undefined2 *)&UNK_0000_0093 = *(undefined2 *)(iVar1 + 0x3cc);
  *(undefined2 *)0xa341 = *(undefined2 *)(iVar1 + 0x3ce);
  return;
}


/* 1000:0496 FUN_1000_0496 */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void FUN_1000_0496(void)

{
  code *pcVar1;
  undefined2 uVar2;
  
  uVar2 = _LAB_1000_0000;
  *(undefined1 *)0xa26e = 0;
  FUN_1000_5e7f();
  _UNK_0000_0070 = *(undefined2 *)0xa27a;
                    /* WARNING (jumptable): Read-only address (ram,0x00000070) is written */
                    /* WARNING: Read-only address (ram,0x00000070) is written */
  _UNK_0000_0072 = *(undefined2 *)0xa27c;
                    /* WARNING (jumptable): Read-only address (ram,0x00000072) is written */
                    /* WARNING: Read-only address (ram,0x00000072) is written */
  pcVar1 = (code *)swi(0x10);
  (*pcVar1)();
                    /* WARNING: Could not recover jumptable at 0x000104c8. Too many branches */
                    /* WARNING: Treating indirect jump as call */
  (*(code *)(ulong)DAT_1000_0002)();
  return;
}


/* 1000:04cd FUN_1000_04cd */

void FUN_1000_04cd(void)

{
  int *piVar1;
  byte bVar2;
  byte *pbVar3;
  undefined2 unaff_DS;
  bool bVar4;
  
  do {
    pbVar3 = (byte *)&UNK_0000_0007;
LAB_1000_04d0:
    do {
      print_inline();
      FUN_1000_0562();
      print_inline();
      do {
        while( true ) {
          do {
            piVar1 = (int *)0x89d0;
            *piVar1 = *piVar1 + 1;
            bVar4 = *piVar1 == 0;
            bVar2 = FUN_1000_0b45();
          } while (bVar4);
          if (bVar2 == 6) goto LAB_1000_04d0;
          if (bVar2 == 0xd) {
            FUN_1000_0166();
            return;
          }
          if (bVar2 != 8) break;
          if (pbVar3 != (byte *)&UNK_0000_0007) {
            pbVar3 = pbVar3 + -1;
          }
        }
      } while (((pbVar3 == (byte *)&UNK_0000_0007) || (bVar2 != 0x20)) &&
              ((bVar2 = bVar2 & 0xdf, bVar2 < 0x41 || (0x5a < bVar2))));
      *pbVar3 = bVar2;
      pbVar3 = pbVar3 + 1;
    } while (pbVar3 < (byte *)&UNK_0000_000a);
  } while( true );
}


/* 1000:0562 FUN_1000_0562 */

void __cdecl16near FUN_1000_0562(void)

{
  FUN_1000_5577();
  FUN_1000_5577();
  FUN_1000_5577();
  return;
}


/* 1000:0585 FUN_1000_0585 */

void __cdecl16near FUN_1000_0585(void)

{
  int iVar1;
  int iVar2;
  undefined2 unaff_DS;
  
  iVar2 = 4;
  do {
    *(byte *)&UNK_0000_000c = *(byte *)&UNK_0000_000c & 3;
    iVar1 = *(int *)((uint)*(byte *)&UNK_0000_000c * 2 + 0x400);
    if (iVar1 != 0) {
      *(int *)&UNK_0000_00a7 = iVar1;
      *(undefined *)&UNK_0000_0003 = 1;
      return;
    }
    *(char *)&UNK_0000_000c = *(char *)&UNK_0000_000c + '\x01';
    *(byte *)&UNK_0000_000c = *(byte *)&UNK_0000_000c & 3;
    iVar2 = iVar2 + -1;
  } while (iVar2 != 0);
  *(undefined *)&UNK_0000_000a = 1;
  return;
}


/* 1000:07ef FUN_1000_07ef */

void __cdecl16near FUN_1000_07ef(void)

{
  char in_AL;
  
  if (in_AL == '\0') {
    print_inline();
    return;
  }
  if (in_AL == '\x01') {
    print_inline();
    return;
  }
  if (in_AL == '\x02') {
    print_inline();
    return;
  }
  print_inline();
  return;
}


/* 1000:0830 FUN_1000_0830 */

void __cdecl16near FUN_1000_0830(void)

{
  undefined2 unaff_DS;
  
  if ((*(byte *)&UNK_0000_0012 & 1) == 0) {
    print_inline();
  }
  else {
    print_inline();
  }
  if ((*(byte *)&UNK_0000_0012 & 2) == 0) {
    print_inline();
    return;
  }
  print_inline();
  return;
}


/* 1000:0882 FUN_1000_0882 */

void __cdecl16near FUN_1000_0882(void)

{
  char in_AL;
  
  if (in_AL == '\x01') {
    print_inline();
    return;
  }
  if (in_AL == '\x02') {
    print_inline();
    return;
  }
  if (in_AL == '\x03') {
    print_inline();
    return;
  }
  print_inline();
  return;
}


/* 1000:08c8 FUN_1000_08c8 */

void FUN_1000_08c8(void)

{
  int *piVar1;
  char cVar2;
  int iVar3;
  byte bVar4;
  undefined2 unaff_DS;
  bool bVar5;
  bool bVar6;
  
  do {
    print_inline();
    FUN_1000_0830();
    print_inline();
    print_inline();
    FUN_1000_0882();
    print_inline();
    FUN_1000_0c6a();
    print_inline();
    FUN_1000_5577();
    print_inline();
    FUN_1000_0c52();
    FUN_1000_0c52();
    print_inline();
    if (*(char *)&UNK_0000_000e == '\0') {
      print_inline();
    }
    else {
      print_inline();
    }
    print_inline();
    FUN_1000_5577();
    print_inline();
    FUN_1000_07ef();
    FUN_1000_580c();
    FUN_1000_0bbe();
    do {
      piVar1 = (int *)0x89d0;
      *piVar1 = *piVar1 + 1;
      bVar5 = *piVar1 == 0;
      cVar2 = FUN_1000_0b45();
    } while (bVar5);
    bVar5 = cVar2 == '\x06';
    if (!bVar5) {
      bVar4 = 8;
      FUN_1000_0b07();
      bVar6 = false;
      if (bVar5) {
        *(char *)0xa33e = *(char *)0xa33e + '\x01';
        bVar6 = *(byte *)0xa33e == bVar4;
        if (bVar4 <= *(byte *)0xa33e) {
          *(undefined1 *)0xa33e = 0;
        }
      }
      cVar2 = FUN_1000_0b0e();
      if ((bVar6) && (*(char *)0xa33e = *(char *)0xa33e + -1, *(char *)0xa33e == -1)) {
        *(char *)0xa33e = bVar4 - 1;
      }
      if (cVar2 == '\r') {
        cVar2 = *(char *)0xa33e;
        if (cVar2 == '\0') {
          FUN_1000_0b15();
          *(undefined1 *)0xa33e = 0;
        }
        else if (cVar2 == '\x01') {
          cVar2 = *(char *)&UNK_0000_0012;
          *(byte *)&UNK_0000_0012 = *(byte *)&UNK_0000_0012 & 0xfc;
          *(byte *)&UNK_0000_0012 = *(byte *)&UNK_0000_0012 | cVar2 + 1U & 3;
        }
        else if (cVar2 == '\x02') {
          *(char *)&UNK_0000_0010 = *(char *)&UNK_0000_0010 + -1;
          *(char *)&UNK_0000_0010 = *(char *)&UNK_0000_0010 + -1;
          *(byte *)&UNK_0000_0010 = *(byte *)&UNK_0000_0010 & 3;
          *(char *)&UNK_0000_0010 = *(char *)&UNK_0000_0010 + '\x01';
        }
        else if (cVar2 == '\x03') {
          *(undefined *)&UNK_0000_0003 = 1;
          *(char *)&UNK_0000_000b = *(char *)&UNK_0000_000b + '\x01';
          *(byte *)&UNK_0000_000b = *(byte *)&UNK_0000_000b & 7;
        }
        else if (cVar2 == '\x04') {
          *(undefined *)&UNK_0000_0003 = 1;
          *(char *)&UNK_0000_000c = *(char *)&UNK_0000_000c + '\x01';
          FUN_1000_0585();
        }
        else if (cVar2 == '\x05') {
          *(byte *)&UNK_0000_000e = *(byte *)&UNK_0000_000e & 1;
          *(byte *)&UNK_0000_000e = *(byte *)&UNK_0000_000e ^ 1;
        }
        else if (cVar2 == '\x06') {
          FUN_1000_0b28();
        }
        else {
          *(char *)&UNK_0000_000d = *(char *)&UNK_0000_000d + '\x01';
          if (3 < *(byte *)&UNK_0000_000d) {
            *(undefined1 *)&UNK_0000_000d = 0;
          }
        }
      }
    }
    while( true ) {
      FUN_1000_0585();
      iVar3 = (uint)*(byte *)0xa33e * (CONCAT11(6,*(byte *)0xa33e) >> 8);
      *(undefined2 *)&UNK_0000_0091 = *(undefined2 *)(iVar3 + 0x3ca);
      *(undefined2 *)&UNK_0000_0093 = *(undefined2 *)(iVar3 + 0x3cc);
      print_inline();
      if (*(char *)&UNK_0000_000a != '\x01') break;
      print_inline();
      FUN_1000_0830();
      print_inline();
      FUN_1000_0882();
      print_inline();
      FUN_1000_0882();
      print_inline();
      FUN_1000_07ef();
      print_inline();
      FUN_1000_5577();
      print_inline();
      FUN_1000_07ef();
      FUN_1000_580c();
      FUN_1000_0bbe();
      do {
        piVar1 = (int *)0x89d0;
        *piVar1 = *piVar1 + 1;
        bVar5 = *piVar1 == 0;
        cVar2 = FUN_1000_0b45();
      } while (bVar5);
      bVar5 = cVar2 == '\x06';
      if (!bVar5) {
        FUN_1000_0b07();
        if (bVar5) {
          *(char *)0xa33e = *(char *)0xa33e + '\x01';
          if (6 < *(byte *)0xa33e) {
            *(undefined1 *)0xa33e = 0;
          }
        }
        else {
          cVar2 = FUN_1000_0b0e();
          if ((bVar5) && (*(char *)0xa33e = *(char *)0xa33e + -1, *(char *)0xa33e == -1)) {
            *(undefined1 *)0xa33e = 6;
          }
          if (cVar2 == '\r') {
            if (*(char *)0xa33e == '\0') {
              FUN_1000_0b15();
              *(undefined1 *)0xa33e = 0;
            }
            else if (*(char *)0xa33e == '\x01') {
              cVar2 = *(char *)&UNK_0000_0012;
              *(byte *)&UNK_0000_0012 = *(byte *)&UNK_0000_0012 & 0xfc;
              *(byte *)&UNK_0000_0012 = *(byte *)&UNK_0000_0012 | cVar2 + 1U & 3;
            }
            else if (*(char *)0xa33e == '\x02') {
              *(char *)&UNK_0000_0010 = *(char *)&UNK_0000_0010 + -2;
              *(byte *)&UNK_0000_0010 = *(byte *)&UNK_0000_0010 & 3;
              *(char *)&UNK_0000_0010 = *(char *)&UNK_0000_0010 + '\x01';
            }
            else if (*(char *)0xa33e == '\x03') {
              *(char *)&UNK_0000_0011 = *(char *)&UNK_0000_0011 + -2;
              *(byte *)&UNK_0000_0011 = *(byte *)&UNK_0000_0011 & 3;
              *(char *)&UNK_0000_0011 = *(char *)&UNK_0000_0011 + '\x01';
            }
            else if (*(char *)0xa33e == '\x04') {
              *(char *)&UNK_0000_000f = *(char *)&UNK_0000_000f + '\x01';
              if (3 < *(byte *)&UNK_0000_000f) {
                *(undefined1 *)&UNK_0000_000f = 0;
              }
            }
            else if (*(char *)0xa33e == '\x05') {
              *(char *)&UNK_0000_0013 = *(char *)&UNK_0000_0013 + '\x01';
              if (2 < *(byte *)&UNK_0000_0013) {
                *(undefined1 *)&UNK_0000_0013 = 0;
              }
            }
            else {
              *(char *)&UNK_0000_000d = *(char *)&UNK_0000_000d + '\x01';
              if (3 < *(byte *)&UNK_0000_000d) {
                *(undefined1 *)&UNK_0000_000d = 0;
              }
            }
          }
        }
      }
    }
  } while( true );
}


/* 1000:0b07 FUN_1000_0b07 */

void __cdecl16near FUN_1000_0b07(void)

{
  return;
}


/* 1000:0b0e FUN_1000_0b0e */

void __cdecl16near FUN_1000_0b0e(void)

{
  return;
}


/* 1000:0b15 FUN_1000_0b15 */

void __cdecl16near FUN_1000_0b15(void)

{
  undefined2 unaff_DS;
  
  if (*(char *)&UNK_0000_000a == '\x01') {
    *(undefined *)&UNK_0000_000a = 2;
    return;
  }
  *(undefined *)&UNK_0000_000a = 1;
  return;
}


/* 1000:0b28 FUN_1000_0b28 */

void __cdecl16near FUN_1000_0b28(void)

{
  byte bVar1;
  undefined2 unaff_DS;
  
  bVar1 = *(byte *)&UNK_0000_0012 & 0xc;
  if (bVar1 == 0) {
    *(byte *)&UNK_0000_0012 = *(byte *)&UNK_0000_0012 | 4;
    return;
  }
  if (bVar1 == 4) {
    *(byte *)&UNK_0000_0012 = *(byte *)&UNK_0000_0012 | 8;
    return;
  }
  *(byte *)&UNK_0000_0012 = *(byte *)&UNK_0000_0012 & 0xf3;
  return;
}


/* 1000:0b45 FUN_1000_0b45 */

byte __cdecl16near FUN_1000_0b45(void)

{
  byte *pbVar1;
  int iVar2;
  code *pcVar3;
  byte bVar4;
  byte extraout_AH;
  undefined2 unaff_DS;
  undefined1 in_ZF;
  
  while( true ) {
    while( true ) {
      pcVar3 = (code *)swi(0x16);
      (*pcVar3)();
      if ((bool)in_ZF) {
        return 0;
      }
      pcVar3 = (code *)swi(0x16);
      bVar4 = (*pcVar3)();
      if (bVar4 == 0x1b) {
        *(undefined1 *)0xa272 = 1;
        *(undefined1 *)0xa26c = 0;
                    /* WARNING: Could not recover jumptable at 0x00010b5f. Too many branches */
                    /* WARNING: Treating indirect jump as call */
        bVar4 = (*(code *)*(undefined2 *)&UNK_0000_00a5)();
        return bVar4;
      }
      if (((extraout_AH == 0x52) || (extraout_AH == 0x53)) || (bVar4 == 0)) {
        bVar4 = extraout_AH | 0x80;
      }
      if (bVar4 != 0x13) break;
      pbVar1 = (byte *)&UNK_0000_0014;
      *pbVar1 = *pbVar1 ^ 3;
      in_ZF = *pbVar1 == 0;
    }
    if (bVar4 == 6) {
      iVar2 = *(int *)&UNK_0000_0016;
      *(undefined2 *)&UNK_0000_0016 = 0x28cd;
      if (iVar2 == 0x28cd) {
        *(undefined2 *)&UNK_0000_0016 = 0x311d;
      }
      return 6;
    }
    if (bVar4 != 0x10) break;
    pbVar1 = (byte *)&UNK_0000_0015;
    *pbVar1 = *pbVar1 ^ 1;
    in_ZF = *pbVar1 == 0;
    FUN_1000_0baf();
  }
  return bVar4;
}


/* 1000:0baf FUN_1000_0baf */

undefined2 __cdecl16near FUN_1000_0baf(undefined2 param_1)

{
  code *pcVar1;
  
  pcVar1 = (code *)swi(0x10);
  (*pcVar1)();
  return param_1;
}


/* 1000:0bbe FUN_1000_0bbe */

/* WARNING: Removing unreachable block (ram,0x00010c1c) */

void FUN_1000_0bbe(void)

{
  print_inline();
  print_inline();
  print_inline();
  print_inline();
  return;
}


/* 1000:0bee FUN_1000_0bee */

void __cdecl16near FUN_1000_0bee(void)

{
  char in_AL;
  
  print_inline();
  if (in_AL == '\0') {
    print_inline();
  }
  else {
    print_inline();
  }
  print_inline();
  return;
}


/* 1000:0c4c FUN_1000_0c4c */

void __cdecl16near FUN_1000_0c4c(void)

{
  FUN_1000_5f7b();
  return;
}


/* 1000:0c52 FUN_1000_0c52 */

void FUN_1000_0c52(void)

{
  thunk_FUN_1000_5577();
  FUN_1000_5577();
  return;
}


/* 1000:0c5f thunk_FUN_1000_5577 */

void thunk_FUN_1000_5577(void)

{
  FUN_1000_5577();
  return;
}


/* 1000:0c6a FUN_1000_0c6a */

void __cdecl16near FUN_1000_0c6a(void)

{
  FUN_1000_580c();
  return;
}


/* 1000:0c7c FUN_1000_0c7c */

uint __cdecl16near FUN_1000_0c7c(void)

{
  int iVar1;
  uint uVar2;
  int iVar3;
  int *piVar4;
  undefined2 unaff_DS;
  
  piVar4 = (int *)&UNK_0000_0006;
  iVar3 = 0x5630;
  iVar1 = 0;
  do {
    iVar1 = iVar1 + *piVar4;
    piVar4 = piVar4 + 1;
    iVar3 = iVar3 + -1;
  } while (iVar3 != 0);
  if (iVar1 == 0) {
    out(0x21,*(byte *)0xa200);
    return (uint)*(byte *)0xa200;
  }
  out(0x21,0xff);
  print_inline();
  uVar2 = FUN_1000_6d17();
  return uVar2;
}


/* 1000:0d60 FUN_1000_0d60 */

void __cdecl16near FUN_1000_0d60(void)

{
  undefined2 unaff_DS;
  
  if (*(char *)&UNK_0000_0003 != '\0') {
    FUN_1000_5dd6();
  }
  *(undefined1 *)&UNK_0000_0003 = 0;
  return;
}


/* 1000:0dbd FUN_1000_0dbd */

void __cdecl16near FUN_1000_0dbd(void)

{
  int iVar1;
  undefined2 unaff_DS;
  
  *(undefined1 *)&UNK_0000_009b = 0;
  *(undefined1 *)&UNK_0000_009c = 0;
  *(undefined1 *)&UNK_0000_00a0 = 0;
  *(undefined1 *)&UNK_0000_00a1 = 0;
  *(undefined1 *)&UNK_0000_0096 = 0;
  *(undefined1 *)&UNK_0000_0097 = 0;
  iVar1 = 200;
  do {
    FUN_1000_0e91();
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  print_encoded();
  iVar1 = 0x168;
  do {
    FUN_1000_0e91();
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  print_encoded();
  iVar1 = 0x168;
  do {
    FUN_1000_0e91();
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  FUN_1000_0f5c();
  FUN_1000_0f5c();
  return;
}


/* 1000:0e70 print_encoded */

/* Pops the return address and prints an encoded string that follows
   the CALL. Uses the same key and cipher as print_inline. 00 ends
   the string. 01-03 set an attribute. Every other plain byte is one
   character. Execution resumes at the next byte (jmp bx). */

void print_encoded(void)

{
  byte bVar1;
  undefined2 unaff_DS;
  code *in_stack_00000000;
  
  *(undefined1 *)0xa264 = 1;
  while( true ) {
    bVar1 = decode_script_byte();
    in_stack_00000000 = in_stack_00000000 + 1;
    if (bVar1 == 0) break;
    if (3 < bVar1) {
      FUN_1000_0e91();
    }
  }
                    /* WARNING: Could not recover jumptable at 0x00010e8f. Too many branches */
                    /* WARNING: Treating indirect jump as call */
  (*in_stack_00000000)();
  return;
}


/* 1000:0e91 FUN_1000_0e91 */

void __cdecl16near FUN_1000_0e91(void)

{
  byte bVar1;
  byte *in_BX;
  undefined2 unaff_DS;
  
  FUN_1000_0f5c();
  bVar1 = FUN_1000_0f40();
  if (bVar1 == 0xd) {
    *in_BX = 0;
    goto LAB_1000_0ef7;
  }
  if (bVar1 == 10) {
    in_BX[1] = in_BX[1] + 1;
  }
  else {
    if (bVar1 == 7) {
      *(undefined2 *)0xa25a = 4;
      goto LAB_1000_0ef7;
    }
    if (bVar1 == 8) {
      if (*in_BX != 0) {
        *in_BX = *in_BX - 1;
        FUN_1000_11eb();
      }
      goto LAB_1000_0ef7;
    }
    if (bVar1 < 0x20) goto LAB_1000_0ef7;
    FUN_1000_11eb();
    *in_BX = *in_BX + 1;
    if (0x27 < *in_BX) {
      *in_BX = 0;
      in_BX[1] = in_BX[1] + 1;
    }
  }
  if (in_BX[2] <= in_BX[1]) {
    in_BX[1] = in_BX[2] - 1;
    FUN_1000_0efb();
  }
LAB_1000_0ef7:
  FUN_1000_0f5c();
  return;
}


/* 1000:0efb FUN_1000_0efb */

undefined2 __cdecl16near FUN_1000_0efb(void)

{
  undefined2 *puVar1;
  undefined2 *puVar2;
  undefined2 in_AX;
  int iVar3;
  int in_BX;
  undefined2 *puVar4;
  undefined2 *puVar5;
  undefined2 *puVar6;
  undefined2 unaff_DS;
  
  puVar5 = (undefined2 *)*(undefined2 *)(in_BX + 3);
  puVar4 = puVar5 + 0xa0;
  puVar6 = puVar5;
  for (iVar3 = 0x500; iVar3 != 0; iVar3 = iVar3 + -1) {
    puVar2 = puVar6;
    puVar6 = puVar6 + 1;
    puVar1 = puVar4;
    puVar4 = puVar4 + 1;
    *puVar2 = *puVar1;
  }
  for (iVar3 = 0xa0; iVar3 != 0; iVar3 = iVar3 + -1) {
    puVar1 = puVar6;
    puVar6 = puVar6 + 1;
    *puVar1 = 0;
  }
  puVar4 = puVar5 + 0x1000;
  puVar5 = puVar5 + 0x10a0;
  for (iVar3 = 0x500; iVar3 != 0; iVar3 = iVar3 + -1) {
    puVar2 = puVar4;
    puVar4 = puVar4 + 1;
    puVar1 = puVar5;
    puVar5 = puVar5 + 1;
    *puVar2 = *puVar1;
  }
  for (iVar3 = 0xa0; iVar3 != 0; iVar3 = iVar3 + -1) {
    puVar1 = puVar4;
    puVar4 = puVar4 + 1;
    *puVar1 = 0;
  }
  return in_AX;
}


/* 1000:0f40 FUN_1000_0f40 */

undefined4 __cdecl16near FUN_1000_0f40(void)

{
  undefined2 in_AX;
  int in_BX;
  undefined2 unaff_DS;
  
  return CONCAT22(*(byte *)(in_BX + 1) / 0xcd,in_AX);
}


/* 1000:0f5c FUN_1000_0f5c */

void __cdecl16near FUN_1000_0f5c(void)

{
  int iVar1;
  int in_BX;
  uint *unaff_DI;
  
  if (in_BX != 0x96) {
    FUN_1000_0f40();
    iVar1 = 4;
    do {
      *unaff_DI = *unaff_DI ^ 0x5555;
      unaff_DI[0x1000] = unaff_DI[0x1000] ^ 0x5555;
      unaff_DI = unaff_DI + 0x28;
      iVar1 = iVar1 + -1;
    } while (iVar1 != 0);
  }
  return;
}


/* 1000:0f85 FUN_1000_0f85 */

void __cdecl16near FUN_1000_0f85(void)

{
  char cVar1;
  undefined2 unaff_DS;
  bool bVar2;
  
  *(undefined1 *)&UNK_0000_0096 = 0;
  *(undefined1 *)&UNK_0000_0097 = 0;
  bVar2 = false;
  if (*(char *)&UNK_0000_000e == '\0') {
    FUN_1000_5ed7();
    if (bVar2) {
      LOCK();
      cVar1 = *(char *)0xa340;
      *(char *)0xa340 = '\x01';
      UNLOCK();
      if (cVar1 != *(char *)0xa340) {
        print_encoded();
      }
    }
    else {
      LOCK();
      cVar1 = *(char *)0xa340;
      *(char *)0xa340 = '\0';
      UNLOCK();
      if (cVar1 != *(char *)0xa340) {
        print_encoded();
      }
    }
  }
  else {
    FUN_1000_5ed7();
    if (bVar2) {
      LOCK();
      cVar1 = *(char *)0xa340;
      *(char *)0xa340 = '\x01';
      UNLOCK();
      if (cVar1 != *(char *)0xa340) {
        print_encoded();
      }
    }
    else {
      LOCK();
      cVar1 = *(char *)0xa340;
      *(char *)0xa340 = '\0';
      UNLOCK();
      if (cVar1 != *(char *)0xa340) {
        print_encoded();
      }
    }
  }
  return;
}


/* 1000:11eb FUN_1000_11eb */

uint __cdecl16near FUN_1000_11eb(void)

{
  undefined2 *puVar1;
  uint in_AX;
  int iVar2;
  undefined2 *puVar3;
  undefined2 *unaff_DI;
  undefined2 unaff_DS;
  
  iVar2 = 4;
  puVar3 = (undefined2 *)(*(int *)&UNK_0000_0016 + (in_AX & 0x7f) * 0x10);
  do {
    puVar1 = puVar3 + 1;
    *unaff_DI = *puVar3;
    puVar3 = puVar3 + 2;
    unaff_DI[0x1000] = *puVar1;
    unaff_DI = unaff_DI + 0x28;
    iVar2 = iVar2 + -1;
  } while (iVar2 != 0);
  return in_AX;
}


/* 1000:1220 FUN_1000_1220 */

void __cdecl16near FUN_1000_1220(void)

{
  undefined *puVar1;
  undefined1 *puVar2;
  byte extraout_AL;
  byte bVar3;
  byte bVar4;
  byte extraout_AH;
  int iVar5;
  uint uVar6;
  char cVar7;
  undefined1 uVar8;
  undefined *puVar9;
  undefined1 *puVar10;
  undefined1 *puVar11;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  
  puVar10 = (undefined1 *)0xa226;
  for (iVar5 = 0x2c; iVar5 != 0; iVar5 = iVar5 + -1) {
    puVar2 = puVar10;
    puVar10 = puVar10 + 1;
    *puVar2 = 0;
  }
  *(undefined1 *)&UNK_0000_00ed = 0;
  if (*(char *)&UNK_0000_000a == '\x01') {
    puVar9 = (undefined *)&UNK_0000_0007;
    puVar10 = (undefined1 *)0xa226;
    for (iVar5 = 3; iVar5 != 0; iVar5 = iVar5 + -1) {
      puVar2 = puVar10;
      puVar10 = puVar10 + 1;
      puVar1 = puVar9;
      puVar9 = puVar9 + 1;
      *puVar2 = *puVar1;
    }
    *puVar10 = *(undefined1 *)0x39c0;
    puVar11 = puVar10 + 2;
    puVar10[1] = *(undefined *)&UNK_0000_0010;
    for (iVar5 = 6; iVar5 != 0; iVar5 = iVar5 + -1) {
      puVar2 = puVar11;
      puVar11 = puVar11 + 1;
      *puVar2 = 0;
    }
    bVar4 = *(char *)&UNK_0000_0013 + 1;
    bVar3 = 1;
  }
  else {
    FUN_1000_59a0();
    bVar3 = extraout_AL;
    bVar4 = extraout_AH;
  }
  if ((*(byte *)&UNK_0000_0012 & 1) == 0) {
    print_inline();
  }
  else {
    print_inline();
  }
  if ((*(byte *)&UNK_0000_0012 & 2) == 0) {
    print_inline();
  }
  else {
    print_inline();
  }
  if (bVar3 < 2) {
    print_inline();
  }
  else {
    if (bVar4 == 0) {
      print_inline();
    }
    print_inline();
    FUN_1000_140e();
    print_inline();
    if (2 < bVar3) {
      print_inline();
    }
    if (bVar4 == 0) goto LAB_1000_13a4;
    print_inline();
  }
  FUN_1000_140e();
  print_inline();
  if (bVar4 != 1) {
    print_inline();
  }
LAB_1000_13a4:
  *(undefined1 *)0x0 = 0x50;
  *(undefined *)&UNK_0000_0001 = 4;
  cVar7 = '\x01';
  if ((*(byte *)&UNK_0000_0012 & 2) != 0) {
    cVar7 = bVar3 + bVar4;
    *(char *)&UNK_0000_0001 = *(char *)&UNK_0000_0001 + cVar7;
    *(char *)0x0 = *(char *)0x0 - (cVar7 * '\b' + -6);
  }
  *(char *)&UNK_0000_0002 = cVar7;
  uVar8 = 1;
  if (bVar3 == 1) {
    uVar8 = *(undefined *)&UNK_0000_0011;
  }
  puVar10 = (undefined1 *)0xa226;
  if (bVar4 != 0) {
    do {
      puVar10 = puVar10 + 0xb;
      bVar3 = bVar3 - 1;
    } while (bVar3 != 0);
    uVar6 = (uint)bVar4;
    cVar7 = '0';
    do {
      *puVar10 = 0x6d;
      puVar10[1] = 0x65;
      puVar10[2] = cVar7;
      puVar10[3] = *(undefined1 *)0x39c0;
      puVar10[4] = uVar8;
      puVar10[5] = 0;
      puVar10[6] = 0;
      puVar10[7] = 0;
      puVar10[8] = 0;
      puVar11 = puVar10 + 10;
      puVar10[9] = 0;
      puVar10 = puVar10 + 0xb;
      *puVar11 = 0;
      cVar7 = cVar7 + '\x01';
      uVar6 = uVar6 - 1;
    } while (uVar6 != 0);
  }
  return;
}


/* 1000:140e FUN_1000_140e */

void __cdecl16near FUN_1000_140e(void)

{
  char in_AL;
  
  if (in_AL == '\x01') {
    print_inline();
    return;
  }
  if (in_AL == '\x02') {
    print_inline();
    return;
  }
  if (in_AL == '\x03') {
    print_inline();
    return;
  }
  print_inline();
  return;
}


/* 1000:1449 FUN_1000_1449 */

/* WARNING: Removing unreachable block (ram,0x00011472) */

void __cdecl16near FUN_1000_1449(void)

{
  uint in_AX;
  int iVar1;
  uint uVar2;
  
  iVar1 = 4;
  do {
    uVar2 = in_AX % 10;
    iVar1 = iVar1 + -1;
    in_AX = in_AX / 10;
  } while (iVar1 != 0);
  iVar1 = 4;
  do {
    if ((char)uVar2 != '\0') {
      do {
        FUN_1000_5577();
      } while( true );
    }
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  FUN_1000_5577();
  return;
}


/* 1000:1473 FUN_1000_1473 */

/* WARNING: Unable to track spacebase fully for stack */

void FUN_1000_1473(void)

{
  undefined1 *puVar1;
  int iVar2;
  byte bVar4;
  undefined2 uVar3;
  int iVar5;
  undefined1 *puVar6;
  undefined2 unaff_ES;
  undefined2 unaff_SS;
  undefined2 unaff_DS;
  
  *(undefined1 *)0xa270 = 7;
  *(undefined1 *)0xa26f = 0;
  FUN_1000_1220();
  *(undefined2 *)0xa255 = 0xa2;
  print_inline();
  FUN_1000_5577(*(uint *)0x89d0 / 0x1a);
  FUN_1000_5577();
  FUN_1000_1449();
  print_inline();
  FUN_1000_3fd1();
  do {
  } while (*(int *)0xa255 != 0);
  FUN_1000_5fa0();
  iVar2 = *(int *)0xa343;
  puVar6 = (undefined1 *)0xa212;
  for (iVar5 = 0x14; iVar5 != 0; iVar5 = iVar5 + -1) {
    puVar1 = puVar6;
    puVar6 = puVar6 + 1;
    *puVar1 = 0;
  }
  *(undefined2 *)&UNK_0000_00e1 = 0xe5;
  *(undefined2 *)&UNK_0000_00e3 = 0xe5;
  *(undefined1 *)0xa204 = 0x12;
  *(undefined1 *)0xa205 = 5;
  *(undefined1 *)0xa206 = 0;
  *(undefined1 *)0xa207 = 0;
  *(undefined1 *)0xa208 = 0;
  if ((*(byte *)&UNK_0000_0012 & 1) != 0) {
    *(undefined1 *)0xa207 = 0x1e;
  }
  *(undefined2 *)(iVar2 + -2) = 0x1542;
  FUN_1000_0c7c();
  *(undefined1 *)0xa203 = 1;
  *(undefined2 *)0xa257 = 0;
  do {
    do {
    } while (*(int *)0xa257 != 0);
    bVar4 = *(byte *)&UNK_0000_000d & 3;
    uVar3 = CONCAT11(bVar4,9);
    if ((((*(byte *)&UNK_0000_000d & 3) != 0) &&
        (uVar3 = CONCAT11(bVar4 - 1,8), (byte)(bVar4 - 1) != '\0')) &&
       (uVar3 = CONCAT11(bVar4 - 2,7), (byte)(bVar4 - 2) != '\0')) {
      uVar3 = 6;
    }
    *(undefined2 *)0xa257 = uVar3;
    *(undefined2 *)(iVar2 + -2) = 0x1575;
    FUN_1000_1759();
    *(undefined1 *)0xa20c = 0x80;
    *(int *)0x89d2 = *(int *)0x89d2 + 1;
    *(undefined2 *)(iVar2 + -2) = 0x1581;
    FUN_1000_1837();
    if ((*(byte *)0xa26c & 0x80) == 0) {
      *(undefined2 *)(iVar2 + -2) = 0x158b;
      FUN_1000_1ee6();
      *(undefined2 *)(iVar2 + -2) = 0x158e;
      FUN_1000_37ac();
      *(undefined2 *)(iVar2 + -2) = 0x1591;
      FUN_1000_178f();
      *(undefined2 *)(iVar2 + -2) = 0x1594;
      FUN_1000_2b74();
      *(undefined2 *)(iVar2 + -2) = 0x1597;
      FUN_1000_3974();
      *(undefined2 *)(iVar2 + -2) = 0x159a;
      FUN_1000_178f();
      *(undefined2 *)(iVar2 + -2) = 0x159d;
      FUN_1000_2b5b();
    }
    *(undefined2 *)(iVar2 + -2) = 0x15a0;
    FUN_1000_178f();
    *(undefined2 *)(iVar2 + -2) = 0x15a3;
    FUN_1000_4530();
    *(undefined2 *)(iVar2 + -2) = 0x15a6;
    FUN_1000_178f();
    *(undefined2 *)(iVar2 + -2) = 0x15a9;
    FUN_1000_197b();
    *(undefined2 *)(iVar2 + -2) = 0x15ac;
    FUN_1000_15d2();
    *(undefined2 *)(iVar2 + -2) = 0x15af;
    FUN_1000_16fe();
    *(undefined2 *)(iVar2 + -2) = 0x15b2;
    FUN_1000_15b4();
  } while( true );
}


/* 1000:15b4 FUN_1000_15b4 */

void FUN_1000_15b4(void)

{
  undefined1 *puVar1;
  undefined1 *puVar2;
  int iVar3;
  undefined1 *puVar4;
  undefined1 *puVar5;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  
  if (*(char *)&UNK_0000_000a == '\x01') {
    puVar5 = (undefined1 *)0xa212;
    puVar4 = (undefined1 *)0xa20d;
    for (iVar3 = 4; iVar3 != 0; iVar3 = iVar3 + -1) {
      puVar2 = puVar5;
      puVar5 = puVar5 + 1;
      puVar1 = puVar4;
      puVar4 = puVar4 + 1;
      *puVar2 = *puVar1;
    }
    *puVar5 = 1;
  }
  else {
    FUN_1000_5d22();
  }
  FUN_1000_6310();
  return;
}


/* 1000:15d2 FUN_1000_15d2 */

void __cdecl16near FUN_1000_15d2(void)

{
  code *pcVar1;
  char cVar2;
  int iVar3;
  char *pcVar4;
  byte *pbVar5;
  undefined2 unaff_DS;
  undefined1 uVar6;
  
  if (*(char *)&UNK_0000_00ed != '\x01') {
    FUN_1000_16e9();
    iVar3 = 4;
    pcVar4 = (char *)0x89e0;
    cVar2 = '\0';
    do {
      if (*pcVar4 == '\0') {
        cVar2 = cVar2 + '\x01';
      }
      pcVar4 = pcVar4 + 1;
      iVar3 = iVar3 + -1;
    } while (iVar3 != 0);
    if (cVar2 == '\0') {
      pbVar5 = (byte *)0x89e0;
      iVar3 = 4;
      do {
        if ((*pbVar5 & 0x80) == 0) {
          *pbVar5 = 4;
        }
        pbVar5 = pbVar5 + 1;
        iVar3 = iVar3 + -1;
      } while (iVar3 != 0);
    }
    if (cVar2 != '\x01') {
      pbVar5 = (byte *)0x89e0;
      iVar3 = 4;
      do {
        if (*pbVar5 != 0) {
          *pbVar5 = *pbVar5 | 0x80;
        }
        pbVar5 = pbVar5 + 1;
        iVar3 = iVar3 + -1;
      } while (iVar3 != 0);
      if (*(char *)(*(byte *)0xa26f + 0x89e0) == '\0') {
        return;
      }
    }
  }
  *(undefined1 *)0xa274 = *(undefined1 *)0xa26f;
  FUN_1000_1b78();
  *(undefined2 *)0xa209 = 0;
  *(undefined1 *)0xa270 = 4;
  FUN_1000_1696();
  FUN_1000_4530();
  FUN_1000_5102();
  FUN_1000_6acb();
  *(undefined2 *)0xa255 = 0x24;
  do {
    uVar6 = *(int *)0xa255 == 0;
  } while (!(bool)uVar6);
  print_inline();
  *(undefined2 *)0xa255 = 0x168;
  do {
    pcVar1 = (code *)swi(0x16);
    (*pcVar1)();
    if (!(bool)uVar6) {
      pcVar1 = (code *)swi(0x16);
      cVar2 = (*pcVar1)();
      if (cVar2 == '\x1b') break;
    }
    uVar6 = *(int *)0xa255 == 0;
  } while (!(bool)uVar6);
  FUN_1000_ac56();
  FUN_1000_6bc5();
  return;
}


/* 1000:1696 FUN_1000_1696 */

void __cdecl16near FUN_1000_1696(void)

{
  uint uVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int *piVar5;
  byte *pbVar6;
  int iVar7;
  undefined2 unaff_DS;
  
  pbVar6 = (byte *)0x8c64;
  iVar7 = -0x6fec;
  piVar5 = (int *)0x89e4;
  iVar2 = 4;
  do {
    iVar3 = 4;
    iVar4 = 0;
    do {
      if ((*pbVar6 & 0x80) != 0) {
        uVar1 = *(uint *)(pbVar6 + 8) / 100;
        if (0x31 < *(uint *)(pbVar6 + 8) % 100) {
          uVar1 = uVar1 + 1;
        }
        iVar4 = iVar4 + uVar1;
      }
      pbVar6 = pbVar6 + 0x3b;
      iVar3 = iVar3 + -1;
    } while (iVar3 != 0);
    uVar1 = *(uint *)(iVar7 + 8) / 10;
    if (4 < *(uint *)(iVar7 + 8) % 10) {
      uVar1 = uVar1 + 1;
    }
    *piVar5 = *piVar5 + uVar1 + iVar4;
    piVar5 = piVar5 + 1;
    iVar7 = iVar7 + 0xe;
    iVar2 = iVar2 + -1;
  } while (iVar2 != 0);
  return;
}


/* 1000:16e9 FUN_1000_16e9 */

void __cdecl16near FUN_1000_16e9(void)

{
  undefined2 unaff_DS;
  
  if ((*(char *)&UNK_0000_000a == '\x02') && (*(int *)0x89e0 != 0)) {
    *(undefined2 *)0x89e2 = 0x303;
  }
  return;
}


/* 1000:16fe FUN_1000_16fe */

void __cdecl16near FUN_1000_16fe(void)

{
  byte bVar1;
  char *pcVar2;
  char *pcVar3;
  undefined2 unaff_DS;
  
  if (*(char *)0xa26c == '\0') {
    *(undefined1 *)0xa26d = 0;
    return;
  }
  if ((*(byte *)0xa26c & 0x80) == 0) {
    if (*(char *)0xa26d == '\0') {
      *(byte *)0xa26c = *(byte *)0xa26c | 0x8f;
      return;
    }
    *(char *)0xa26d = *(char *)0xa26d + -1;
    return;
  }
  pcVar2 = (char *)0x89e0;
  pcVar3 = (char *)0xa226;
  bVar1 = 0;
  do {
    if ((*pcVar2 != '\0') || (*pcVar3 == 'm')) {
      *(byte *)0xa26c = *(byte *)0xa26c & ~('\x01' << (bVar1 & 0x1f));
    }
    bVar1 = bVar1 + 1;
    pcVar2 = pcVar2 + 1;
    pcVar3 = pcVar3 + 0xb;
  } while (bVar1 < 4);
  if ((*(byte *)0xa26c & 0xf) == 0) {
    *(undefined1 *)0xa26c = 0;
  }
  return;
}


/* 1000:1759 FUN_1000_1759 */

void __cdecl16near FUN_1000_1759(void)

{
  char *pcVar1;
  char cVar2;
  int iVar3;
  char *pcVar4;
  char *pcVar5;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  
  pcVar5 = (char *)0xa20d;
  iVar3 = 4;
  while( true ) {
    pcVar4 = (char *)*(undefined2 *)&UNK_0000_00e1;
    if (pcVar4 == (char *)*(undefined2 *)&UNK_0000_00e3) break;
    cVar2 = *pcVar4;
    pcVar4 = pcVar4 + 1;
    if (pcVar4 == (char *)&UNK_0000_00ed) {
      pcVar4 = (char *)&UNK_0000_00e5;
    }
    *(undefined2 *)&UNK_0000_00e1 = pcVar4;
    if (cVar2 == '\0') break;
    pcVar1 = pcVar5;
    pcVar5 = pcVar5 + 1;
    *pcVar1 = cVar2;
    iVar3 = iVar3 + -1;
    if (iVar3 == 0) {
      return;
    }
  }
  cVar2 = '\0';
  if (*(char *)0xa203 == '\0') {
    cVar2 = -0x7a;
  }
  for (; iVar3 != 0; iVar3 = iVar3 + -1) {
    pcVar1 = pcVar5;
    pcVar5 = pcVar5 + 1;
    *pcVar1 = cVar2;
  }
  return;
}


/* 1000:178f FUN_1000_178f */

void __cdecl16near FUN_1000_178f(void)

{
  char *pcVar1;
  char cVar2;
  char *pcVar3;
  undefined2 unaff_DS;
  
  while (cVar2 = FUN_1000_17c1(), cVar2 != '\0') {
    pcVar1 = (char *)*(int *)&UNK_0000_00e3;
    pcVar3 = pcVar1 + 1;
    if (pcVar3 == (char *)&UNK_0000_00ed) {
      pcVar3 = (char *)&UNK_0000_00e5;
    }
    if (pcVar3 == (char *)*(undefined2 *)&UNK_0000_00e1) {
      *(undefined2 *)0xa25a = 2;
    }
    else {
      *(undefined2 *)&UNK_0000_00e3 = pcVar3;
      *pcVar1 = cVar2;
    }
  }
  return;
}


/* 1000:17c1 FUN_1000_17c1 */

byte __cdecl16near FUN_1000_17c1(void)

{
  byte *pbVar1;
  code *pcVar2;
  byte bVar3;
  byte extraout_AH;
  undefined2 unaff_DS;
  undefined1 in_ZF;
  
  while( true ) {
    while( true ) {
      while( true ) {
        while( true ) {
          while( true ) {
            do {
              pcVar2 = (code *)swi(0x16);
              (*pcVar2)();
              if ((bool)in_ZF) {
                return 0;
              }
              pcVar2 = (code *)swi(0x16);
              bVar3 = (*pcVar2)();
              if (((extraout_AH == 0x52) || (extraout_AH == 0x53)) || (bVar3 == 0)) {
                bVar3 = extraout_AH | 0x80;
              }
              in_ZF = 1;
            } while (bVar3 == 0x86);
            if (bVar3 != 0x13) break;
            pbVar1 = (byte *)&UNK_0000_0014;
            *pbVar1 = *pbVar1 ^ 3;
            in_ZF = *pbVar1 == 0;
          }
          if (bVar3 != 3) break;
          *(char *)0xa259 = *(char *)0xa259 + '\x01';
          in_ZF = 0;
          if (*(char *)0xa259 == '\x02') {
            return 0x85;
          }
        }
        if (bVar3 != 4) break;
        in_ZF = 1;
      }
      *(undefined1 *)0xa259 = 0;
      if (bVar3 != 6) break;
      in_ZF = *(int *)&UNK_0000_0016 == 0x28cd;
      *(undefined2 *)&UNK_0000_0016 = 0x28cd;
      if ((bool)in_ZF) {
        *(undefined2 *)&UNK_0000_0016 = 0x311d;
      }
    }
    if (bVar3 != 0x10) break;
    pbVar1 = (byte *)&UNK_0000_0015;
    *pbVar1 = *pbVar1 ^ 1;
    in_ZF = *pbVar1 == 0;
    FUN_1000_0baf();
  }
  return bVar3;
}


/* 1000:1837 FUN_1000_1837 */

void __cdecl16near FUN_1000_1837(void)

{
  byte *pbVar1;
  int iVar2;
  byte *pbVar3;
  byte *pbVar4;
  char *unaff_SI;
  undefined2 unaff_DS;
  
  *(undefined1 *)0xa274 = 0;
  pbVar3 = (byte *)0xa212;
  do {
    pbVar4 = pbVar3;
    FUN_1000_1ec1();
    if ((*pbVar4 & 0x10) == 0) {
      FUN_1000_2a0c();
      if (*unaff_SI == '\0') {
        FUN_1000_1b78();
      }
    }
    iVar2 = 4;
    *(undefined2 *)0xa350 = unaff_SI;
    pbVar4 = pbVar3;
    do {
      pbVar1 = pbVar4;
      pbVar4 = pbVar4 + 1;
      if (*pbVar1 == 0) break;
      *(byte *)0xa211 = *pbVar1;
      FUN_1000_1884();
      unaff_SI = (char *)*(undefined2 *)0xa350;
      iVar2 = iVar2 + -1;
    } while (iVar2 != 0);
    pbVar3 = pbVar3 + 5;
    *(char *)0xa274 = *(char *)0xa274 + '\x01';
    if (3 < *(byte *)0xa274) {
      return;
    }
  } while( true );
}


/* 1000:1884 FUN_1000_1884 */

void __cdecl16near FUN_1000_1884(void)

{
  char cVar1;
  char *pcVar2;
  undefined2 unaff_DS;
  bool bVar3;
  
  bVar3 = false;
  if (*(char *)((uint)*(byte *)0xa274 * 0x28 + -0x7614) == '\0') {
    pcVar2 = (char *)0x18c4;
    cVar1 = FUN_1000_1970();
  }
  else {
    cVar1 = FUN_1000_1998();
    pcVar2 = (char *)0x1909;
    if (!bVar3) {
      return;
    }
  }
  while( true ) {
    if (*pcVar2 == '\0') {
      FUN_1000_1a68();
      return;
    }
    if (cVar1 == *pcVar2) break;
    pcVar2 = pcVar2 + 3;
  }
                    /* WARNING: Could not recover jumptable at 0x000118bd. Too many branches */
                    /* WARNING: Treating indirect jump as call */
  (**(code **)(pcVar2 + 1))();
  return;
}


/* 1000:1970 FUN_1000_1970 */

void __cdecl16near FUN_1000_1970(void)

{
  return;
}


/* 1000:197b FUN_1000_197b */

void __cdecl16near FUN_1000_197b(void)

{
  char *pcVar1;
  undefined2 unaff_DS;
  
  if (*(char *)&UNK_0000_00e0 != '\0') {
    pcVar1 = (char *)&UNK_0000_00e0;
    *pcVar1 = *pcVar1 + -1;
    if (*pcVar1 == '\0') {
      FUN_1000_1a4d();
      if (*(char *)0xa29e != '\0') {
        *(undefined *)&UNK_0000_00e0 = 0x14;
      }
    }
  }
  return;
}


/* 1000:1998 FUN_1000_1998 */

void __cdecl16near FUN_1000_1998(void)

{
  byte bVar1;
  undefined1 *puVar2;
  byte bVar3;
  char cVar4;
  uint uVar5;
  int iVar6;
  byte *pbVar7;
  undefined1 *unaff_DI;
  byte *pbVar8;
  byte *pbVar9;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  bool bVar10;
  
  bVar1 = *(byte *)0xa211;
  if (bVar1 != 0xd) {
    if (bVar1 == 8) {
      pbVar8 = unaff_DI + 1;
      if (*pbVar8 != 0) {
        pbVar8[*pbVar8 + 1] = 0;
        *pbVar8 = *pbVar8 - 1;
      }
      return;
    }
    if ((bVar1 < 0x20) || (0x7e < bVar1)) {
      return;
    }
    bVar3 = unaff_DI[1];
    unaff_DI[bVar3 + 2] = bVar1;
    unaff_DI[bVar3 + 3] = 0;
    unaff_DI[1] = unaff_DI[1] + '\x01';
    if ((byte)unaff_DI[1] < 0x16) {
      return;
    }
  }
  pbVar8 = unaff_DI + 1;
  uVar5 = (uint)*pbVar8;
  if (uVar5 != 0) {
    if (unaff_DI[3] == ':') {
      if (((char)(unaff_DI[2] + -0x41) == *(char *)0xa26f) &&
         (bVar10 = 1 < uVar5, uVar5 = uVar5 - 2, bVar10 && uVar5 != 0)) {
        pbVar8 = unaff_DI + 3;
LAB_1000_1a06:
        do {
          pbVar7 = (byte *)0xa29e;
          cVar4 = '\x04';
          do {
            if (*pbVar7 == 0) {
              *pbVar7 = 1;
              while( true ) {
                pbVar9 = pbVar7 + 1;
                pbVar8 = pbVar8 + 1;
                if (uVar5 == 0) break;
                uVar5 = uVar5 - 1;
                *pbVar9 = *pbVar8;
                pbVar7 = pbVar9;
              }
              if (2 < *(byte *)&UNK_0000_000a) {
                *pbVar9 = 0x2c;
                pbVar9 = pbVar7 + 3;
                pbVar7[2] = *(char *)0xa274 + 0x41;
              }
              *pbVar9 = 0;
              if (*(char *)&UNK_0000_00e0 == '\0') {
                *(undefined *)&UNK_0000_00e0 = 0x14;
              }
              goto LAB_1000_1a43;
            }
            pbVar7 = pbVar7 + 0x28;
            cVar4 = cVar4 + -1;
          } while (cVar4 != '\0');
          FUN_1000_1a4d();
        } while( true );
      }
    }
    else if (*(char *)0xa274 != *(char *)0xa26f) goto LAB_1000_1a06;
  }
LAB_1000_1a43:
  for (iVar6 = 0x28; iVar6 != 0; iVar6 = iVar6 + -1) {
    puVar2 = unaff_DI;
    unaff_DI = unaff_DI + 1;
    *puVar2 = 0;
  }
  return;
}


/* 1000:1a4d FUN_1000_1a4d */

void __cdecl16near FUN_1000_1a4d(void)

{
  undefined1 *puVar1;
  undefined1 *puVar2;
  int iVar3;
  undefined1 *puVar4;
  undefined1 *puVar5;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  
  puVar5 = (undefined1 *)0xa29e;
  puVar4 = (undefined1 *)0xa2c6;
  for (iVar3 = 0x78; iVar3 != 0; iVar3 = iVar3 + -1) {
    puVar2 = puVar5;
    puVar5 = puVar5 + 1;
    puVar1 = puVar4;
    puVar4 = puVar4 + 1;
    *puVar2 = *puVar1;
  }
  for (iVar3 = 0x28; iVar3 != 0; iVar3 = iVar3 + -1) {
    puVar1 = puVar5;
    puVar5 = puVar5 + 1;
    *puVar1 = 0;
  }
  return;
}


/* 1000:1a68 FUN_1000_1a68 */

void FUN_1000_1a68(void)

{
  FUN_1000_1a97();
  return;
}


/* 1000:1a97 FUN_1000_1a97 */

void __cdecl16near FUN_1000_1a97(void)

{
  undefined2 in_AX;
  undefined2 *in_BX;
  undefined2 unaff_DS;
  
  if (((*(byte *)0xa274 ^ *(byte *)0xa26f) & 3) == 0) {
    *in_BX = in_AX;
  }
  return;
}


/* 1000:1b78 FUN_1000_1b78 */

void __cdecl16near FUN_1000_1b78(void)

{
  byte *in_BX;
  undefined2 unaff_DS;
  
  FUN_1000_1ec1();
  *in_BX = *in_BX | 0x10;
  return;
}


/* 1000:1c41 FUN_1000_1c41 */

void __cdecl16near FUN_1000_1c41(void)

{
  undefined1 uVar1;
  undefined2 uVar2;
  char cVar4;
  byte bVar3;
  byte *unaff_SI;
  undefined2 unaff_DS;
  
  if ((unaff_SI[0x15] == 0) && (unaff_SI[0x19] == 0)) {
    uVar1 = (undefined1)(*(uint *)(unaff_SI + 10) & 0xf0f);
    if ((*unaff_SI & 4) == 0) {
      cVar4 = (char)((*(uint *)(unaff_SI + 10) & 0xf0f) >> 8);
      bVar3 = cVar4 + 9;
      uVar2 = CONCAT11(bVar3,uVar1);
      if ((0x12 < bVar3) && (unaff_SI[0x14] != 0)) {
        uVar2 = CONCAT11(cVar4 + '\x10',uVar1);
      }
    }
    else {
      uVar2 = CONCAT11(0x18,uVar1);
    }
    *(undefined2 *)(unaff_SI + 0x1f) = uVar2;
    if (unaff_SI[7] != 0) {
      unaff_SI[7] = unaff_SI[7] - 1;
      unaff_SI[0x19] = 0x26;
      unaff_SI[0x15] = 6;
      *(undefined2 *)(unaff_SI + 0x1a) = *(undefined2 *)(unaff_SI + 1);
      *(undefined2 *)(unaff_SI + 0x1c) = *(undefined2 *)(unaff_SI + 3);
      unaff_SI[0x1e] = unaff_SI[5];
      return;
    }
  }
  FUN_1000_1a97();
  return;
}


/* 1000:1cc3 FUN_1000_1cc3 */

void __cdecl16near FUN_1000_1cc3(void)

{
  byte *unaff_SI;
  undefined2 unaff_DS;
  
  if (unaff_SI[0xf] != 0) {
    *unaff_SI = *unaff_SI | 0x10;
  }
  return;
}


/* 1000:1cdb FUN_1000_1cdb */

void __cdecl16near FUN_1000_1cdb(void)

{
  byte bVar1;
  byte *unaff_SI;
  undefined2 unaff_DS;
  
  unaff_SI[0x11] = unaff_SI[0x11] & 0x7f;
  bVar1 = unaff_SI[0xb] & 0xf;
  if ((*unaff_SI & 0x44) != 0) {
    bVar1 = 0xb;
  }
  unaff_SI[0xb] = bVar1 | 0xb0;
  if (unaff_SI[0x14] < 0x5b) {
    unaff_SI[0x14] = unaff_SI[0x14] + 10;
    return;
  }
  unaff_SI[0x14] = 100;
  return;
}


/* 1000:1d0f FUN_1000_1d0f */

void __cdecl16near FUN_1000_1d0f(void)

{
  int unaff_SI;
  undefined2 unaff_DS;
  
  *(undefined1 *)(unaff_SI + 0x14) = 0;
  *(undefined1 *)(unaff_SI + 0xb) = 0;
  FUN_1000_239b();
  return;
}


/* 1000:1d64 FUN_1000_1d64 */

void __cdecl16near FUN_1000_1d64(void)

{
  int iVar1;
  char *unaff_SI;
  int unaff_DI;
  undefined2 unaff_DS;
  
  iVar1 = 0x14;
  do {
    if (*unaff_SI == '\0') {
      *(char *)(unaff_DI + 6) = *(char *)(unaff_DI + 6) + -1;
      *unaff_SI = -6;
      *(undefined2 *)(unaff_SI + 1) = *(undefined2 *)(unaff_DI + 1);
      *(undefined2 *)(unaff_SI + 3) = *(undefined2 *)(unaff_DI + 3);
      unaff_SI[5] = *(char *)(unaff_DI + 5);
      unaff_SI[7] = *(char *)(unaff_DI + 0x18);
      unaff_SI[6] = *(char *)(unaff_DI + 0x17);
      return;
    }
    unaff_SI = unaff_SI + 8;
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  return;
}


/* 1000:1da5 FUN_1000_1da5 */

void __cdecl16near FUN_1000_1da5(void)

{
  undefined1 uVar1;
  uint uVar2;
  char cVar5;
  byte bVar4;
  undefined2 uVar3;
  int unaff_SI;
  undefined2 unaff_DS;
  
  if ((*(char *)(unaff_SI + 0x15) != '\0') || ((*(byte *)(unaff_SI + 0x19) & 0x80) != 0)) {
    FUN_1000_1a97();
    return;
  }
  FUN_1000_239b();
  uVar2 = *(uint *)(unaff_SI + 10) & 0xf0f;
  cVar5 = (char)(uVar2 >> 8);
  uVar1 = (undefined1)uVar2;
  bVar4 = cVar5 + 9;
  uVar3 = CONCAT11(bVar4,uVar1);
  if ((0x12 < bVar4) && (*(char *)(unaff_SI + 0x14) != '\0')) {
    uVar3 = CONCAT11(cVar5 + '\x10',uVar1);
  }
  *(undefined2 *)(unaff_SI + 0x1f) = uVar3;
  *(undefined1 *)(unaff_SI + 0x19) = 0x8c;
  *(undefined1 *)(unaff_SI + 0x15) = 0xc;
  *(undefined2 *)(unaff_SI + 0x1a) = *(undefined2 *)(unaff_SI + 1);
  *(undefined2 *)(unaff_SI + 0x1c) = *(undefined2 *)(unaff_SI + 3);
  *(undefined1 *)(unaff_SI + 0x1e) = *(undefined1 *)(unaff_SI + 5);
  return;
}


/* 1000:1e06 FUN_1000_1e06 */

void __cdecl16near FUN_1000_1e06(void)

{
  undefined1 uVar1;
  char cVar3;
  uint uVar2;
  int unaff_SI;
  undefined2 unaff_DS;
  
  if ((*(char *)(unaff_SI + 0x15) != '\0') || ((*(byte *)(unaff_SI + 0x19) & 0x80) != 0)) {
    FUN_1000_1a97();
    return;
  }
  FUN_1000_239b();
  uVar2 = *(uint *)(unaff_SI + 10) & 0xfff;
  uVar1 = (undefined1)uVar2;
  cVar3 = (char)(uVar2 >> 8) + -9;
  uVar2 = CONCAT11(cVar3,uVar1);
  if (cVar3 < '\0') {
    uVar2 = CONCAT11(-cVar3,uVar1) ^ 8;
  }
  *(uint *)(unaff_SI + 0x1f) = uVar2 & 0xf0f;
  *(undefined1 *)(unaff_SI + 0x19) = 0xca;
  *(undefined1 *)(unaff_SI + 0x15) = 10;
  *(undefined2 *)(unaff_SI + 0x1a) = *(undefined2 *)(unaff_SI + 1);
  *(undefined2 *)(unaff_SI + 0x1c) = *(undefined2 *)(unaff_SI + 3);
  *(undefined1 *)(unaff_SI + 0x1e) = *(undefined1 *)(unaff_SI + 5);
  return;
}


/* 1000:1e92 FUN_1000_1e92 */

void __cdecl16near FUN_1000_1e92(void)

{
  byte *in_BX;
  byte *unaff_SI;
  undefined2 unaff_DS;
  
  if (((((*unaff_SI & 0x80) == 0) || ((*(byte *)0xa26c & 0x80) != 0)) ||
      (('\x01' << (*(byte *)0xa274 & 0x1f) & *(byte *)0xa26c) != 0)) ||
     (FUN_1000_1ec1(), (*in_BX & 0x10) != 0)) {
    FUN_1000_1a97();
    return;
  }
  return;
}


/* 1000:1ec1 FUN_1000_1ec1 */

void __cdecl16near FUN_1000_1ec1(void)

{
  return;
}


/* 1000:1ece pick_ptr */

/* Pops the return address. The next 8 bytes are four near pointers.
   ([A274] & 3) selects one, returned in BX. Execution resumes at
   return address + 8. */

undefined2 __cdecl16near pick_ptr(void)

{
  undefined2 in_AX;
  
  return in_AX;
}


/* 1000:1ee6 FUN_1000_1ee6 */

void __cdecl16near FUN_1000_1ee6(void)

{
  undefined2 unaff_DS;
  
  FUN_1000_22a2();
  FUN_1000_202f();
  FUN_1000_2343();
  *(undefined1 *)0xa274 = 0;
  FUN_1000_1f1c();
  *(undefined1 *)0xa274 = 1;
  FUN_1000_1f1c();
  *(undefined1 *)0xa274 = 2;
  FUN_1000_1f1c();
  *(undefined1 *)0xa274 = 3;
  FUN_1000_1f1c();
  return;
}


/* 1000:1f1c FUN_1000_1f1c */

void __cdecl16near FUN_1000_1f1c(void)

{
  byte *pbVar1;
  byte bVar2;
  byte bVar3;
  int iVar4;
  int in_BX;
  byte *pbVar5;
  byte *unaff_DI;
  undefined2 unaff_DS;
  bool bVar6;
  
  bVar3 = 0;
  *(undefined1 *)0xa295 = 0;
  do {
    *(char *)0xa295 = *(char *)0xa295 + '\x01';
    if ((*unaff_DI & 0x80) == 0) {
LAB_1000_1f41:
      *(char *)0xa295 = *(char *)0xa295 + -1;
      bVar6 = false;
      if (*unaff_DI == 0) {
        FUN_1000_4459();
        if (!bVar6) {
          *(char *)0xa295 = *(char *)0xa295 + '\x01';
        }
      }
      else {
        pbVar1 = unaff_DI;
        *pbVar1 = *pbVar1 - 1;
        if (*pbVar1 == 0) {
          FUN_1000_2002();
        }
      }
    }
    else {
      FUN_1000_2055();
      FUN_1000_218b();
      FUN_1000_226c();
      FUN_1000_20e3();
      FUN_1000_210a();
      if ((*unaff_DI & 0x80) == 0) goto LAB_1000_1f41;
    }
    unaff_DI = unaff_DI + 0x3b;
    bVar3 = bVar3 + 1;
    if (3 < bVar3) {
      pick_ptr();
      pbVar5 = (byte *)(uint)*(byte *)0xa274;
      if (pbVar5[-0x7620] == 0) {
        if (pbVar5[-0x7628] == 1) {
          bVar2 = 3;
        }
        else {
          if ((*(int *)(in_BX + 8) == 0) &&
             (*(undefined1 *)(in_BX + 10) = 0, *(char *)(in_BX + 0xd) != '\0')) {
            *(char *)(in_BX + 0xd) = *(char *)(in_BX + 0xd) + -1;
          }
          bVar3 = *(char *)0xa295 + *(char *)(in_BX + 10);
          pbVar5[-0x7624] = bVar3;
          bVar2 = 1;
          if (bVar3 != 0) {
            bVar2 = 0;
          }
        }
        pbVar5[-0x7620] = bVar2;
        if (bVar2 != 0) {
          *(undefined1 *)(in_BX + 10) = 0;
          *(undefined2 *)(in_BX + 8) = 0;
          *(undefined1 *)(in_BX + 0xd) = 0;
          pick_ptr();
          iVar4 = 4;
          do {
            if ((*pbVar5 & 0x80) != 0) {
              *pbVar5 = 0;
            }
            pbVar5 = pbVar5 + 0x3b;
            iVar4 = iVar4 + -1;
          } while (iVar4 != 0);
          pick_ptr();
          pbVar5[5] = 0;
          *(undefined2 *)((uint)*(byte *)0xa274 * 2 + -0x761c) = 0;
        }
      }
      return;
    }
  } while( true );
}


/* 1000:2002 FUN_1000_2002 */

void __cdecl16near FUN_1000_2002(void)

{
  int iVar1;
  char *pcVar2;
  int unaff_DI;
  undefined2 unaff_DS;
  
  pcVar2 = (char *)0xa08c;
  iVar1 = 0x30;
  do {
    if (*pcVar2 == '\0') {
      *pcVar2 = -0x38;
      *(undefined2 *)(pcVar2 + 1) = *(undefined2 *)(unaff_DI + 1);
      *(undefined2 *)(pcVar2 + 3) = *(undefined2 *)(unaff_DI + 3);
      pcVar2[6] = *(char *)(unaff_DI + 0x18);
      pcVar2[5] = *(char *)(unaff_DI + 5);
      return;
    }
    pcVar2 = pcVar2 + 7;
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  return;
}


/* 1000:202f FUN_1000_202f */

void __cdecl16near FUN_1000_202f(void)

{
  char *pcVar1;
  int iVar2;
  char *pcVar3;
  undefined2 unaff_DS;
  
  if ((*(byte *)0x89d2 & 7) != 4) {
    return;
  }
  pcVar3 = (char *)0xa08c;
  iVar2 = 0x30;
  do {
    if (*pcVar3 != '\0') {
      pcVar1 = pcVar3;
      *pcVar1 = *pcVar1 + -1;
      if (*pcVar1 == '\0') {
        FUN_1000_ac37();
      }
    }
    pcVar3 = pcVar3 + 7;
    iVar2 = iVar2 + -1;
  } while (iVar2 != 0);
  return;
}


/* 1000:2055 FUN_1000_2055 */

void __cdecl16near FUN_1000_2055(void)

{
  int unaff_DI;
  undefined2 unaff_DS;
  
  if (*(char *)(*(byte *)0xa274 + 0x89d8) == '\x01') {
    *(undefined2 *)(unaff_DI + 8) = 0;
    return;
  }
  if (*(char *)(unaff_DI + 0x15) != '\0') {
    *(char *)(unaff_DI + 0x15) = *(char *)(unaff_DI + 0x15) + -1;
  }
  if (*(uint *)(unaff_DI + 8) < 0x7d1) {
    *(undefined1 *)(unaff_DI + 0x14) = 0;
  }
  if (((((*(byte *)0x89d2 & 3) == 0) && (FUN_1000_239b(), (*(byte *)0x89d2 & 3) == 0)) &&
      (((*(byte *)0x89d2 & 4) != 0 || ((*(byte *)(unaff_DI + 0xb) & 0xf) < 3)))) &&
     (*(char *)(unaff_DI + 0xe) != '\0')) {
    *(char *)(unaff_DI + 0xe) = *(char *)(unaff_DI + 0xe) + -1;
  }
  return;
}


/* 1000:20e3 FUN_1000_20e3 */

void __cdecl16near FUN_1000_20e3(void)

{
  byte bVar1;
  byte *unaff_DI;
  undefined2 unaff_DS;
  
  bVar1 = unaff_DI[0xe];
  if ((((7 < bVar1) && (*unaff_DI = *unaff_DI & 0xcf, 0xb < bVar1)) &&
      (unaff_DI[0x11] = 0, 0xf < bVar1)) && (unaff_DI[0x15] = 0x18, 0x13 < bVar1)) {
    unaff_DI[0x2a] = 0;
    unaff_DI[0x22] = 0;
  }
  return;
}


/* 1000:210a FUN_1000_210a */

void __cdecl16near FUN_1000_210a(void)

{
  byte bVar1;
  uint uVar2;
  uint uVar3;
  uint uVar4;
  byte *unaff_DI;
  undefined2 unaff_DS;
  
  bVar1 = FUN_1000_23b3();
  uVar2 = *(uint *)(unaff_DI + 0xc);
  if (2 < bVar1) {
    uVar2 = uVar2 >> 1;
  }
  uVar4 = *(uint *)(unaff_DI + 8);
  if ((*unaff_DI & 0x44) == 0) {
    if (((*(byte *)0x89d2 & 3) == 0) && (uVar4 < 0x88b9)) {
      uVar4 = uVar4 + 10;
    }
    uVar3 = uVar4 - uVar2;
    if (uVar4 < uVar2 || uVar3 == 0) {
      while( true ) {
        pick_ptr();
        if (unaff_DI[6] == 0) break;
        FUN_1000_1d64();
      }
      bVar1 = 8;
      if (49999 < *(uint *)(unaff_DI + 0xc)) {
        bVar1 = 0xc;
      }
      *unaff_DI = bVar1;
      goto LAB_1000_2185;
    }
  }
  else {
    uVar3 = uVar2 >> 2;
    if (7999 < uVar3) {
      uVar3 = uVar2 >> 4;
    }
    if (uVar4 < 10000) goto LAB_1000_2185;
    uVar3 = uVar4 - uVar3;
    if (uVar3 < 0x2711) {
      uVar3 = 10000;
    }
  }
  *(uint *)(unaff_DI + 8) = uVar3;
  if (uVar3 < 0xc9) {
    *unaff_DI = *unaff_DI & 0xef;
  }
LAB_1000_2185:
  (unaff_DI + 0xc)[0] = 0;
  (unaff_DI + 0xc)[1] = 0;
  return;
}


/* 1000:218b FUN_1000_218b */

void __cdecl16near FUN_1000_218b(void)

{
  byte in_BL;
  byte bVar1;
  int unaff_DI;
  undefined2 unaff_DS;
  
  FUN_1000_221e();
  if ((*(char *)(unaff_DI + 0x14) == '\0') && (0xaf < *(byte *)(unaff_DI + 0xb))) {
    *(char *)(unaff_DI + 0xb) = *(char *)(unaff_DI + 0xb) + -0x10;
  }
  bVar1 = *(byte *)(unaff_DI + 0xb) & 0xf0;
  FUN_1000_21af();
  *(byte *)(unaff_DI + 0xb) = in_BL | bVar1;
  return;
}


/* 1000:21af FUN_1000_21af */

void __cdecl16near FUN_1000_21af(void)

{
  char *pcVar1;
  byte in_AL;
  byte bVar2;
  char cVar3;
  byte bVar4;
  int unaff_DI;
  undefined2 unaff_DS;
  
  bVar4 = in_AL & 0xf;
  bVar2 = in_AL >> 4;
  if (bVar2 == bVar4) {
    *(undefined1 *)(unaff_DI + 0x10) = 0;
    return;
  }
  if (*(char *)(unaff_DI + 0x10) == '\0') {
    cVar3 = bVar2 - bVar4;
    if (cVar3 < '\0') {
      cVar3 = -cVar3;
    }
    *(char *)(unaff_DI + 0x10) = ((byte)(0xcU - cVar3) >> 2) + 1;
    return;
  }
  pcVar1 = (char *)(unaff_DI + 0x10);
  *pcVar1 = *pcVar1 + -1;
  if (*pcVar1 == '\0') {
    cVar3 = bVar2 - bVar4;
    if (cVar3 < '\0') {
      cVar3 = -cVar3;
    }
    *(char *)(unaff_DI + 0x10) = ((byte)(0xcU - cVar3) >> 1) + 1;
    FUN_1000_239b();
    return;
  }
  cVar3 = bVar2 - bVar4;
  if (cVar3 < '\0') {
    cVar3 = -cVar3;
  }
  if ((byte)(0xcU - cVar3) <= *(byte *)(unaff_DI + 0x10)) {
    *(char *)(unaff_DI + 0x10) = ((byte)(0xcU - cVar3) >> 1) + 1;
  }
  return;
}


/* 1000:221e FUN_1000_221e */

void __cdecl16near FUN_1000_221e(void)

{
  byte bVar1;
  byte bVar2;
  byte bVar3;
  int unaff_DI;
  undefined2 unaff_DS;
  
  bVar1 = *(byte *)(unaff_DI + 10) >> 4;
  bVar2 = *(byte *)(unaff_DI + 10);
  *(byte *)(unaff_DI + 10) = *(byte *)(unaff_DI + 10) & 0xf0;
  bVar2 = bVar2 & 0xf;
  if (((*(byte *)(unaff_DI + 0x11) & 0x1f) != 0) && (*(uint *)(unaff_DI + 0x12) < 0xfb)) {
    bVar2 = bVar1;
  }
  bVar1 = bVar1 - bVar2;
  bVar3 = bVar2;
  if (bVar1 != 0) {
    if ((char)bVar1 < '\0') {
      bVar1 = bVar1 + 0x10;
    }
    bVar3 = bVar2 + 1;
    if (((4 < bVar1) && (bVar3 = bVar2 + 2, 8 < bVar1)) && (bVar3 = bVar2 - 2, 0xb < bVar1)) {
      bVar3 = bVar2 - 1;
    }
  }
  *(byte *)(unaff_DI + 10) = *(byte *)(unaff_DI + 10) | bVar3 & 0xf;
  return;
}


/* 1000:226c FUN_1000_226c */

void __cdecl16near FUN_1000_226c(void)

{
  byte *pbVar1;
  byte bVar2;
  byte *unaff_DI;
  undefined2 unaff_DS;
  
  if (((((*(byte *)0x89d2 & 1) == 0) && (unaff_DI[0x19] == 0)) && ((*unaff_DI & 0x10) != 0)) &&
     ((*unaff_DI & 0x44) == 0)) {
    if (unaff_DI[0xf] == 0) {
LAB_1000_229d:
      *unaff_DI = *unaff_DI & 0xef;
      return;
    }
    bVar2 = FUN_1000_23b3();
    if ((bVar2 < 4) || ((*(byte *)0x89d2 & 3) != 0)) {
      pbVar1 = unaff_DI + 0xf;
      *pbVar1 = *pbVar1 - 1;
      if (*pbVar1 == 0) goto LAB_1000_229d;
    }
  }
  return;
}


/* 1000:22a2 FUN_1000_22a2 */

void __cdecl16near FUN_1000_22a2(void)

{
  byte *pbVar1;
  byte bVar2;
  byte bVar3;
  int in_CX;
  byte *unaff_DI;
  undefined2 unaff_DS;
  
  bVar3 = 0;
  do {
    FUN_1000_3228();
    *(undefined1 *)0xa280 = 0;
    do {
      if ((*unaff_DI & 0xf) == 0) {
        *(undefined1 *)0xa280 = 0;
        if (((*(byte *)0x89d2 & 0x7f) == 0) && (unaff_DI[6] != 0)) {
          pbVar1 = unaff_DI + 6;
          *pbVar1 = *pbVar1 - 1;
          if (*pbVar1 == 0) {
            *(undefined1 *)0xa280 = 1;
            goto LAB_1000_22f2;
          }
        }
      }
      else if (((*unaff_DI & 0xf) < 0xb) && (*(char *)0xa280 == '\x01')) {
LAB_1000_22f2:
        bVar2 = FUN_1000_437a();
        if ((bVar2 & 0xf) == 0) {
          FUN_1000_2310();
        }
        else {
          *unaff_DI = *unaff_DI | 0xf;
        }
      }
      else if ((*(char *)0x89d2 + (char)in_CX & 7U) == 0) {
        FUN_1000_43b1();
        if (unaff_DI[6] != 0) {
          unaff_DI[6] = unaff_DI[6] - 1;
        }
      }
      unaff_DI = unaff_DI + 0xb;
      in_CX = in_CX + -1;
    } while (in_CX != 0);
    bVar3 = bVar3 + 1;
    if (*(byte *)&UNK_0000_0002 <= bVar3) {
      return;
    }
  } while( true );
}


/* 1000:2310 FUN_1000_2310 */

void __cdecl16near FUN_1000_2310(void)

{
  undefined1 uVar1;
  undefined2 uVar2;
  undefined1 *unaff_DI;
  undefined2 unaff_DS;
  undefined1 in_CF;
  
  do {
    uVar1 = in_CF;
    uVar2 = FUN_1000_429b();
    *(undefined2 *)(unaff_DI + 1) = uVar2;
    uVar2 = FUN_1000_429b();
    *(undefined2 *)(unaff_DI + 3) = uVar2;
    FUN_1000_4217();
    in_CF = 1;
  } while ((bool)uVar1);
  uVar1 = FUN_1000_41f0();
  *unaff_DI = uVar1;
  unaff_DI[7] = 0;
  unaff_DI[8] = 0;
  unaff_DI[6] = 0;
  unaff_DI[10] = 0xff;
  return;
}


/* 1000:2343 FUN_1000_2343 */

void __cdecl16near FUN_1000_2343(void)

{
  char cVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  char *pcVar5;
  undefined2 unaff_DS;
  
  iVar4 = -0x6fec;
  pcVar5 = (char *)0x904c;
  iVar2 = 4;
  do {
    iVar3 = 0x14;
    do {
      cVar1 = *pcVar5;
      if (cVar1 != '\0') {
        if (cVar1 == '\x01') {
          *pcVar5 = '\0';
          *(char *)(iVar4 + 6) = *(char *)(iVar4 + 6) + '\x01';
        }
        else if ((cVar1 == '\x02') || ((*(byte *)0x89d2 & 7) == 0)) {
          *pcVar5 = *pcVar5 + -1;
        }
      }
      pcVar5 = pcVar5 + 8;
      iVar3 = iVar3 + -1;
    } while (iVar3 != 0);
    iVar4 = iVar4 + 0xe;
    iVar2 = iVar2 + -1;
  } while (iVar2 != 0);
  return;
}


/* 1000:237b FUN_1000_237b */

uint FUN_1000_237b(void)

{
  uint *puVar1;
  uint uVar2;
  uint in_AX;
  byte bVar3;
  byte *unaff_DI;
  undefined2 unaff_DS;
  
  if (unaff_DI[0x34] != 0) {
    in_AX = in_AX >> 2;
  }
  if (((*unaff_DI & 0x20) != 0) && ((unaff_DI[0x19] & 0x80) == 0)) {
    in_AX = in_AX / 3;
  }
  puVar1 = (uint *)(unaff_DI + 0xc);
  uVar2 = *puVar1;
  *puVar1 = *puVar1 + in_AX;
  if (CARRY2(uVar2,in_AX)) {
    (unaff_DI + 0xc)[0] = 0xff;
    (unaff_DI + 0xc)[1] = 0xff;
  }
  bVar3 = (byte)(in_AX >> 10);
  if (bVar3 != 0) {
    unaff_DI[0xe] = unaff_DI[0xe] + bVar3;
  }
  return in_AX;
}


/* 1000:239b FUN_1000_239b */

uint __cdecl16near FUN_1000_239b(void)

{
  uint *puVar1;
  uint uVar2;
  uint in_AX;
  byte bVar3;
  int unaff_DI;
  undefined2 unaff_DS;
  
  puVar1 = (uint *)(unaff_DI + 0xc);
  uVar2 = *puVar1;
  *puVar1 = *puVar1 + in_AX;
  if (CARRY2(uVar2,in_AX)) {
    *(undefined2 *)(unaff_DI + 0xc) = 0xffff;
  }
  bVar3 = (byte)(in_AX >> 10);
  if (bVar3 != 0) {
    *(char *)(unaff_DI + 0xe) = *(char *)(unaff_DI + 0xe) + bVar3;
  }
  return in_AX;
}


/* 1000:23b3 FUN_1000_23b3 */

undefined1 __cdecl16near FUN_1000_23b3(void)

{
  int in_BX;
  undefined2 unaff_DS;
  
  pick_ptr();
  return *(undefined1 *)(in_BX + 4);
}


/* 1000:23c4 FUN_1000_23c4 */

int __cdecl16near FUN_1000_23c4(void)

{
  uint uVar1;
  uint uVar2;
  int iVar3;
  byte in_CL;
  int unaff_SI;
  int unaff_DI;
  undefined2 unaff_DS;
  
  if (*(char *)(unaff_SI + 5) != *(char *)(unaff_DI + 5)) {
    return -2;
  }
  uVar1 = *(int *)(unaff_SI + 1) - *(int *)(unaff_DI + 1);
  if ((int)uVar1 < 0) {
    uVar1 = -uVar1;
  }
  if (0x1f < (byte)(uVar1 >> 8)) {
    uVar1 = -(uVar1 + 0xc000);
  }
  uVar1 = uVar1 >> (in_CL & 0x1f);
  if ((char)(uVar1 >> 8) == '\0') {
    uVar2 = *(int *)(unaff_SI + 3) - *(int *)(unaff_DI + 3);
    if ((int)uVar2 < 0) {
      uVar2 = -uVar2;
    }
    if (0x1f < (byte)(uVar2 >> 8)) {
      uVar2 = -(uVar2 + 0xc000);
    }
    uVar2 = uVar2 >> (in_CL & 0x1f);
    if (((char)(uVar2 >> 8) == '\0') &&
       (!CARRY2((uVar2 & 0xff) * (uVar2 & 0xff),(uVar1 & 0xff) * (uVar1 & 0xff)))) {
      iVar3 = FUN_1000_2470();
      return iVar3 << (in_CL & 0x1f);
    }
  }
  return -1;
}


/* 1000:23cc FUN_1000_23cc */

int __cdecl16near FUN_1000_23cc(void)

{
  uint uVar1;
  uint uVar2;
  int iVar3;
  byte in_CL;
  int unaff_SI;
  int unaff_DI;
  undefined2 unaff_DS;
  
  uVar1 = *(int *)(unaff_SI + 1) - *(int *)(unaff_DI + 1);
  if ((int)uVar1 < 0) {
    uVar1 = -uVar1;
  }
  if (0x1f < (byte)(uVar1 >> 8)) {
    uVar1 = -(uVar1 + 0xc000);
  }
  uVar1 = uVar1 >> (in_CL & 0x1f);
  if ((char)(uVar1 >> 8) == '\0') {
    uVar2 = *(int *)(unaff_SI + 3) - *(int *)(unaff_DI + 3);
    if ((int)uVar2 < 0) {
      uVar2 = -uVar2;
    }
    if (0x1f < (byte)(uVar2 >> 8)) {
      uVar2 = -(uVar2 + 0xc000);
    }
    uVar2 = uVar2 >> (in_CL & 0x1f);
    if (((char)(uVar2 >> 8) == '\0') &&
       (!CARRY2((uVar2 & 0xff) * (uVar2 & 0xff),(uVar1 & 0xff) * (uVar1 & 0xff)))) {
      iVar3 = FUN_1000_2470();
      return iVar3 << (in_CL & 0x1f);
    }
  }
  return -1;
}


/* 1000:241a FUN_1000_241a */

int __cdecl16near FUN_1000_241a(void)

{
  uint uVar1;
  uint uVar2;
  int iVar3;
  byte in_CL;
  int unaff_SI;
  int unaff_DI;
  undefined2 unaff_DS;
  
  if (*(char *)(unaff_SI + 5) != *(char *)(unaff_DI + 5)) {
    return -2;
  }
  uVar1 = *(int *)(unaff_SI + 1) - *(int *)(unaff_DI + 1);
  if ((int)uVar1 < 0) {
    uVar1 = -uVar1;
  }
  if (0x1f < (byte)(uVar1 >> 8)) {
    uVar1 = -(uVar1 + 0xc000);
  }
  uVar1 = uVar1 >> (in_CL & 0x1f);
  if ((char)(uVar1 >> 8) == '\0') {
    uVar2 = *(int *)(unaff_SI + 3) - *(int *)(unaff_DI + 3);
    if ((int)uVar2 < 0) {
      uVar2 = -uVar2;
    }
    if (0x1f < (byte)(uVar2 >> 8)) {
      uVar2 = -(uVar2 + 0xc000);
    }
    uVar2 = uVar2 >> (in_CL & 0x1f);
    if (((char)(uVar2 >> 8) == '\0') &&
       (!CARRY2((uVar2 & 0xff) * (uVar2 & 0xff),(uVar1 & 0xff) * (uVar1 & 0xff)))) {
      iVar3 = FUN_1000_2470();
      return iVar3 << (in_CL & 0x1f);
    }
  }
  return -1;
}


/* 1000:2470 FUN_1000_2470 */

undefined1 __cdecl16near FUN_1000_2470(void)

{
  uint in_AX;
  
  if (0x7fff < in_AX) {
    return *(undefined1 *)(ulong)(((byte)(in_AX >> 8) & 0x7f) + 0x298c);
  }
  if (0x3fff < in_AX) {
    return *(undefined1 *)(ulong)(((in_AX & 0x3f80) >> 7) + 0x290d);
  }
  if (0x1fff < in_AX) {
    return *(undefined1 *)(ulong)(((in_AX & 0x1fc0) >> 6) + 0x288d);
  }
  if (0xfff < in_AX) {
    return *(undefined1 *)(ulong)(((in_AX & 0xfe0) >> 5) + 0x280d);
  }
  if (0x7ff < in_AX) {
    return *(undefined1 *)(ulong)(((in_AX & 0x7ff) >> 4) + 0x278d);
  }
  if (0x3ff < in_AX) {
    return *(undefined1 *)(ulong)(((in_AX & 0x3ff) >> 3) + 0x270d);
  }
  if (0x1ff < in_AX) {
    return *(undefined1 *)(ulong)(((in_AX & 0x1ff) >> 2) + 0x268d);
  }
  if (in_AX < 0x100) {
    return *(undefined1 *)(ulong)((in_AX & 0xff) + 0x250d);
  }
  return *(undefined1 *)(ulong)(((in_AX & 0xff) >> 1) + 0x260d);
}


/* 1000:2a0c FUN_1000_2a0c */

uint __cdecl16near FUN_1000_2a0c(void)

{
  undefined1 in_AL;
  byte bVar1;
  uint uVar2;
  int iVar3;
  undefined2 unaff_DS;
  
  uVar2 = CONCAT11(*(undefined1 *)0xa274,in_AL) & 0xff03;
  bVar1 = (byte)uVar2 | (char)(uVar2 >> 8) << 2;
  iVar3 = (uint)bVar1 * (CONCAT11(0x3b,bVar1) >> 8);
  return CONCAT11((char)((uint)iVar3 >> 8),*(undefined1 *)(iVar3 + -0x739c)) & 0xff80;
}


/* 1000:2a26 FUN_1000_2a26 */

int __cdecl16near FUN_1000_2a26(void)

{
  uint uVar1;
  int iVar2;
  undefined2 uVar3;
  int unaff_SI;
  int unaff_DI;
  undefined2 unaff_DS;
  
  if (*(char *)(unaff_SI + 5) != *(char *)(unaff_DI + 5)) {
    return -1;
  }
  iVar2 = *(int *)(unaff_SI + 1) - *(int *)(unaff_DI + 1);
  FUN_1000_2b36();
  *(int *)0xa283 = iVar2;
  iVar2 = *(int *)(unaff_SI + 3) - *(int *)(unaff_DI + 3);
  FUN_1000_2b36();
  *(int *)0xa285 = iVar2;
  FUN_1000_2b52();
  *(int *)0xa289 = iVar2;
  uVar3 = *(undefined2 *)0xa283;
  FUN_1000_2b52();
  *(undefined2 *)0xa287 = uVar3;
  uVar1 = *(uint *)0xa287;
  if (uVar1 <= *(uint *)0xa289) {
    uVar1 = *(uint *)0xa289;
  }
  for (; (char)(uVar1 >> 8) != '\0'; uVar1 = uVar1 >> 1) {
  }
  do {
    iVar2 = FUN_1000_241a();
  } while (iVar2 == -1);
  return iVar2;
}


/* 1000:2b36 FUN_1000_2b36 */

void __cdecl16near FUN_1000_2b36(void)

{
  uint in_BX;
  bool in_SF;
  
  if ((in_SF) || (in_BX < 0x2000)) {
    return;
  }
  return;
}


/* 1000:2b52 FUN_1000_2b52 */

void __cdecl16near FUN_1000_2b52(void)

{
  return;
}


/* 1000:2b5b FUN_1000_2b5b */

void __cdecl16near FUN_1000_2b5b(void)

{
  FUN_1000_2c1e();
  FUN_1000_2ef3();
  FUN_1000_2e02();
  FUN_1000_2f65();
  FUN_1000_31f0();
  FUN_1000_30ec();
  FUN_1000_2ba7();
  FUN_1000_36b5();
  return;
}


/* 1000:2b74 FUN_1000_2b74 */

void __cdecl16near FUN_1000_2b74(void)

{
  int iVar1;
  byte *pbVar2;
  undefined2 unaff_DS;
  
  iVar1 = 0x10;
  pbVar2 = (byte *)0x8c64;
  do {
    pbVar2[0x16] = 0;
    pbVar2[0x28] = 0;
    (pbVar2 + 0x32)[0] = 0;
    (pbVar2 + 0x32)[1] = 0;
    pbVar2[0x34] = 0;
    if ((*pbVar2 & 0x80) != 0) {
      *pbVar2 = *pbVar2 & 0xfc;
    }
    pbVar2 = pbVar2 + 0x3b;
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  iVar1 = 4;
  pbVar2 = (byte *)0x9014;
  do {
    *pbVar2 = *pbVar2 & 0xf8;
    pbVar2 = pbVar2 + 0xe;
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  return;
}


/* 1000:2ba7 FUN_1000_2ba7 */

void __cdecl16near FUN_1000_2ba7(void)

{
  int iVar1;
  int iVar2;
  int iVar3;
  byte *pbVar4;
  undefined2 unaff_DS;
  
  iVar3 = -0x6fec;
  iVar1 = 4;
  do {
    pbVar4 = (byte *)0x8c64;
    iVar2 = 0x10;
    do {
      if (((((*pbVar4 & 0x80) != 0) && (pbVar4[0x18] != *(byte *)(iVar3 + 0xc))) &&
          (pbVar4[0x19] != 0)) && (*(char *)(iVar3 + 0xd) != '\0')) {
        FUN_1000_23c4();
        FUN_1000_2be8();
      }
      pbVar4 = pbVar4 + 0x3b;
      iVar2 = iVar2 + -1;
    } while (iVar2 != 0);
    iVar3 = iVar3 + 0xe;
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  return;
}


/* 1000:2be8 FUN_1000_2be8 */

void __cdecl16near FUN_1000_2be8(void)

{
  byte *pbVar1;
  uint in_AX;
  byte *unaff_SI;
  int unaff_DI;
  undefined2 unaff_DS;
  
  if ((in_AX < 0xa1) && (*unaff_SI = *unaff_SI | 0x80, 3 < *(byte *)(unaff_DI + 0x19))) {
    if (*(byte *)0xa26f == unaff_SI[0xb]) {
      *(undefined2 *)0xa262 = 0xee;
    }
    FUN_1000_2ed4();
    *(undefined1 *)(unaff_DI + 0x19) = 3;
    pbVar1 = unaff_SI + 8;
    *(int *)pbVar1 = *(int *)pbVar1 + -500;
    if (*(int *)pbVar1 < 0) {
      (unaff_SI + 8)[0] = 0;
      (unaff_SI + 8)[1] = 0;
    }
  }
  return;
}


/* 1000:2c1e FUN_1000_2c1e */

void __cdecl16near FUN_1000_2c1e(void)

{
  int iVar1;
  int iVar2;
  int iVar3;
  byte *pbVar4;
  undefined2 unaff_DS;
  
  pbVar4 = (byte *)0x8c64;
  iVar1 = 0x10;
  do {
    if (*pbVar4 != 0) {
      *pbVar4 = *pbVar4 & 0xfb;
      iVar3 = -0x6fec;
      iVar2 = 4;
      do {
        if (*(char *)(iVar3 + 0xd) != '\0') {
          if (pbVar4[0x18] == *(byte *)(iVar3 + 0xc)) {
            FUN_1000_23c4();
            FUN_1000_2cfa();
          }
          else {
            FUN_1000_23c4();
            FUN_1000_2c6d();
          }
        }
        iVar3 = iVar3 + 0xe;
        iVar2 = iVar2 + -1;
      } while (iVar2 != 0);
      if ((*pbVar4 & 0x84) != 0x84) {
        *pbVar4 = *pbVar4 & 0xbf;
      }
    }
    pbVar4 = pbVar4 + 0x3b;
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  return;
}


/* 1000:2c6d FUN_1000_2c6d */

void __cdecl16near FUN_1000_2c6d(void)

{
  byte *pbVar1;
  uint in_AX;
  uint uVar2;
  int iVar3;
  byte *unaff_SI;
  byte *unaff_DI;
  undefined2 unaff_DS;
  
  if (1999 < in_AX) {
    return;
  }
  if (*unaff_DI < 0xd) {
    if ((in_AX < 0x3e9) && (uVar2 = *unaff_DI - 2, 1 < *unaff_DI)) {
      iVar3 = uVar2 * 8;
      if ((299 < in_AX) && (iVar3 = (uVar2 & 0x1fff) << 2, 499 < in_AX)) {
        iVar3 = (uVar2 & 0x1fff) << 1;
      }
      pbVar1 = unaff_SI + 8;
      *(int *)pbVar1 = *(int *)pbVar1 - iVar3;
      if (*(int *)pbVar1 < 0) {
        (unaff_SI + 8)[0] = 0;
        (unaff_SI + 8)[1] = 0;
      }
    }
  }
  else {
    unaff_DI[0x16] = unaff_DI[0x16] | 1;
    *unaff_SI = *unaff_SI | 1;
    if (((in_AX < 0x5dd) && (*unaff_SI = *unaff_SI | 2, in_AX < 0x2ef)) &&
       (*unaff_SI = *unaff_SI | 4, in_AX < 0xfa)) {
      uVar2 = (300 - in_AX) * 2;
      if (unaff_SI[0xd] != 4) {
        uVar2 = (300 - in_AX) * 4;
      }
      if (0x95 < uVar2) {
        unaff_DI[0x15] = 0x10;
        FUN_1000_2ed4();
        pbVar1 = unaff_SI + 8;
        *(undefined **)pbVar1 = (undefined *)&UNK_0000_ff9c + *(int *)pbVar1;
        if (*(int *)pbVar1 < 0) {
          (unaff_SI + 8)[0] = 0;
          (unaff_SI + 8)[1] = 0;
        }
      }
      FUN_1000_237b();
    }
  }
  return;
}


/* 1000:2cfa FUN_1000_2cfa */

void __cdecl16near FUN_1000_2cfa(void)

{
  uint in_AX;
  byte bVar1;
  byte *unaff_SI;
  byte *unaff_DI;
  undefined2 unaff_DS;
  
  if ((*unaff_DI & 0x80) != 0) {
    if (unaff_SI[0xd] == 4) {
      if ((in_AX < 0xa1) && ((*(int *)(unaff_DI + 0x32) == 0 || (in_AX < 0x60)))) {
        *unaff_DI = *unaff_DI | 4;
        bVar1 = unaff_DI[0x11] & 0x1f;
        if (bVar1 == 4) {
          bVar1 = 0;
          unaff_DI[0x11] = 0x80;
        }
        if ((*unaff_DI & 0x40) == 0) {
          if (in_AX < 0x3c) {
            if (unaff_DI[0xb] == 0) {
              unaff_DI[0xb] = 0x11;
            }
          }
          else {
            *unaff_DI = *unaff_DI | 0x40;
            if (bVar1 == 0) {
              unaff_DI[0xb] = 0;
              unaff_DI[0x11] = 7;
              unaff_DI[0x2b] = unaff_DI[0x17];
            }
          }
        }
        unaff_DI[0xe] = 0;
        *unaff_SI = *unaff_SI & 0x7f;
        FUN_1000_2d70();
        return;
      }
    }
    else if (in_AX < 0xfb) {
      (unaff_DI + 0xc)[0] = 0x50;
      (unaff_DI + 0xc)[1] = 0xc3;
    }
  }
  return;
}


/* 1000:2d70 FUN_1000_2d70 */

void __cdecl16near FUN_1000_2d70(void)

{
  int unaff_SI;
  int unaff_DI;
  undefined2 unaff_DS;
  
  if ((*(byte *)0x89d2 & 7) == 0) {
    *(undefined1 *)0xa29c = 0;
    if ((*(uint *)(unaff_DI + 8) < 0x2711) && (100 < *(uint *)(unaff_SI + 8))) {
      *(int *)(unaff_SI + 8) = (int)((undefined *)&UNK_0000_ffce + *(int *)(unaff_SI + 8));
      *(int *)(unaff_DI + 8) = *(int *)(unaff_DI + 8) + 500;
    }
    else {
      if ((14999 < *(uint *)(unaff_DI + 8)) &&
         ((*(uint *)(unaff_SI + 8) < 20000 && (0x18 < *(uint *)(unaff_SI + 8))))) {
        *(int *)(unaff_SI + 8) = *(int *)(unaff_SI + 8) + 100;
        *(int *)(unaff_DI + 8) = *(int *)(unaff_DI + 8) + -1000;
        if (*(byte *)(unaff_SI + 7) < 100) {
          *(char *)(unaff_SI + 7) = *(char *)(unaff_SI + 7) + '\x01';
        }
      }
      *(byte *)0xa29c = *(byte *)0xa29c | 1;
    }
    if ((*(byte *)(unaff_DI + 7) < 10) && (*(char *)(unaff_SI + 7) != '\0')) {
      *(char *)(unaff_SI + 7) = *(char *)(unaff_SI + 7) + -1;
      *(char *)(unaff_DI + 7) = *(char *)(unaff_DI + 7) + '\x01';
    }
    else {
      *(byte *)0xa29c = *(byte *)0xa29c | 2;
    }
    if ((*(byte *)0x89d2 & 8) != 0) {
      return;
    }
    if ((*(byte *)(unaff_DI + 6) < 5) && (*(char *)(unaff_SI + 6) != '\0')) {
      *(char *)(unaff_SI + 6) = *(char *)(unaff_SI + 6) + -1;
      *(char *)(unaff_DI + 6) = *(char *)(unaff_DI + 6) + '\x01';
      return;
    }
  }
  *(byte *)0xa29c = *(byte *)0xa29c | 4;
  return;
}


/* 1000:2e02 FUN_1000_2e02 */

void __cdecl16near FUN_1000_2e02(void)

{
  int iVar1;
  int iVar2;
  byte *pbVar3;
  byte *pbVar4;
  undefined2 unaff_DS;
  
  pbVar3 = (byte *)0x8c64;
  iVar1 = 0x10;
  do {
    if (pbVar3[0x19] != 0) {
      pbVar4 = (byte *)0x8c64;
      iVar2 = 0x10;
      do {
        if ((((*pbVar4 & 0x80) != 0) && (pbVar3 != pbVar4)) &&
           ((pbVar4[0x34] == 0 || (pbVar4[0x18] != pbVar3[0x18])))) {
          FUN_1000_2e3d();
        }
        pbVar4 = pbVar4 + 0x3b;
        iVar2 = iVar2 + -1;
      } while (iVar2 != 0);
    }
    pbVar3 = pbVar3 + 0x3b;
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  return;
}


/* 1000:2e3d FUN_1000_2e3d */

void __cdecl16near FUN_1000_2e3d(void)

{
  uint uVar1;
  int unaff_SI;
  byte *unaff_DI;
  undefined2 unaff_DS;
  
  if (((*unaff_DI & 0x44) != 0) && (unaff_DI[0x18] == *(byte *)(unaff_SI + 0x18))) {
    return;
  }
  uVar1 = FUN_1000_23c4();
  if ((*(byte *)(unaff_SI + 0x19) & 0x80) == 0) {
    if (600 < uVar1) {
      return;
    }
    if (unaff_DI[0x18] != *(byte *)(unaff_SI + 0x18)) {
      unaff_DI[0x16] = unaff_DI[0x16] | 2;
    }
    if (0x8c < uVar1) {
      return;
    }
    if (3 < *(byte *)(unaff_SI + 0x19)) {
      if ((*unaff_DI & 0x44) != 0) {
        return;
      }
      *(undefined1 *)(unaff_SI + 0x19) = 3;
    }
  }
  else {
    if (600 < uVar1) {
      return;
    }
    unaff_DI[0x16] = unaff_DI[0x16] | 0x20;
    if (0x1c2 < uVar1) {
      return;
    }
    if ((char)((*(byte *)(unaff_SI + 0x19) & 0xf) - 4) < '\0') {
      return;
    }
  }
  FUN_1000_237b();
  FUN_1000_2ed4();
  return;
}


/* 1000:2ed4 FUN_1000_2ed4 */

void __cdecl16near FUN_1000_2ed4(void)

{
  int *piVar1;
  uint in_AX;
  uint uVar2;
  uint in_BX;
  undefined2 unaff_DS;
  
  if ((in_BX & 0xff) < 4) {
    uVar2 = in_AX / 100;
    if (0x31 < in_AX % 100) {
      uVar2 = uVar2 + 1;
    }
    piVar1 = (int *)((in_BX & 0xff) * 2 + -0x761c);
    *piVar1 = *piVar1 + uVar2;
  }
  return;
}


/* 1000:2ef3 FUN_1000_2ef3 */

void __cdecl16near FUN_1000_2ef3(void)

{
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  
  iVar4 = -0x739c;
  iVar5 = -0x72b0;
  iVar1 = 0xc;
  do {
    iVar3 = iVar1;
    iVar6 = iVar4;
    do {
      iVar2 = 4;
      do {
        FUN_1000_2f24(iVar4,iVar3,iVar6,iVar5);
        iVar2 = iVar2 + -1;
      } while (iVar2 != 0);
      iVar3 = iVar3 + -1;
    } while (iVar3 != 0);
    iVar4 = iVar6 + 0xec;
    iVar5 = iVar5 + 0xec;
    iVar1 = iVar1 + -4;
  } while (iVar1 != 0);
  return;
}


/* 1000:2f24 FUN_1000_2f24 */

void __cdecl16near FUN_1000_2f24(void)

{
  uint uVar1;
  int unaff_SI;
  int unaff_DI;
  undefined2 unaff_DS;
  
  if ((((2 < *(byte *)(unaff_SI + 0x19)) && (*(byte *)(unaff_SI + 0x19) < 0x80)) &&
      (2 < *(byte *)(unaff_DI + 0x19))) && (*(byte *)(unaff_DI + 0x19) < 0x80)) {
    uVar1 = FUN_1000_23c4();
    if (uVar1 < 0x5b) {
      if (3 < *(byte *)(unaff_SI + 0x19)) {
        *(undefined1 *)(unaff_SI + 0x19) = 3;
      }
      if (3 < *(byte *)(unaff_DI + 0x19)) {
        *(undefined1 *)(unaff_DI + 0x19) = 3;
      }
    }
  }
  return;
}


/* 1000:2f65 FUN_1000_2f65 */

void __cdecl16near FUN_1000_2f65(void)

{
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  char *pcVar6;
  char *pcVar7;
  undefined2 unaff_DS;
  
  iVar4 = -0x739c;
  pcVar6 = (char *)0x8d50;
  iVar1 = 0xc;
  pcVar7 = pcVar6;
  iVar5 = iVar4;
  iVar2 = iVar1;
  do {
    do {
      if (*pcVar6 != '\0') {
        iVar3 = 4;
        do {
          FUN_1000_2f9d(iVar3,iVar4);
          iVar3 = iVar3 + -1;
        } while (iVar3 != 0);
      }
      pcVar6 = pcVar6 + 0x3b;
      iVar1 = iVar1 + -1;
    } while (iVar1 != 0);
    iVar4 = iVar5 + 0xec;
    pcVar6 = pcVar7 + 0xec;
    iVar1 = iVar2 + -4;
    pcVar7 = pcVar6;
    iVar5 = iVar4;
    iVar2 = iVar1;
  } while (iVar1 != 0);
  return;
}


/* 1000:2f9d FUN_1000_2f9d */

void __cdecl16near FUN_1000_2f9d(void)

{
  uint uVar1;
  uint uVar2;
  uint uVar3;
  byte bVar4;
  byte bVar5;
  byte *unaff_SI;
  byte *unaff_DI;
  undefined2 unaff_DS;
  
  if (*unaff_SI != 0) {
    uVar1 = FUN_1000_23c4();
    if (uVar1 < 0x7d1) {
      if (unaff_DI[0x18] != unaff_SI[0x18]) {
        uVar2 = FUN_1000_3066();
        uVar3 = 2000;
        if (((*(uint *)(unaff_DI + 8) < 0x9c41) && ((unaff_SI[0x19] & 0xf0) == 0)) &&
           ((*unaff_SI & 0x10) != 0)) {
          uVar3 = 1000;
        }
        if (uVar2 <= uVar3) {
          unaff_DI[0x16] = unaff_DI[0x16] | 0x40;
          if ((char)(*unaff_DI & 0xfc) < '\0') {
            bVar4 = *unaff_DI & 0xfc | 1;
            bVar5 = bVar4;
            if ((uVar2 <= uVar3 >> 1) && (bVar5 = bVar4 + 1, uVar2 <= uVar3 >> 2)) {
              bVar5 = bVar4 + 2;
            }
            if (*unaff_DI < bVar5) {
              *unaff_DI = bVar5;
            }
          }
        }
        uVar2 = 2000;
        if (((*(uint *)(unaff_SI + 8) < 0x9c41) && ((unaff_DI[0x19] & 0xf0) == 0)) &&
           ((*unaff_DI & 0x10) != 0)) {
          uVar2 = 1000;
        }
        if (uVar1 <= uVar2) {
          unaff_SI[0x16] = unaff_SI[0x16] | 0x40;
          if ((char)(*unaff_SI & 0xfc) < '\0') {
            bVar4 = *unaff_SI & 0xfc | 1;
            bVar5 = bVar4;
            if ((uVar1 <= uVar2 >> 1) && (bVar5 = bVar4 + 1, uVar1 <= uVar2 >> 2)) {
              bVar5 = bVar4 + 2;
            }
            if (*unaff_SI < bVar5) {
              *unaff_SI = bVar5;
            }
          }
        }
        return;
      }
      if (((uVar1 < 0x12d) && (unaff_DI[0x18] == 0x20)) && ((*unaff_DI & 0x44) == 0)) {
        unaff_DI[0x15] = 2;
        unaff_SI[0x15] = 2;
        if (6 < (unaff_DI[0xb] & 0xf)) {
          unaff_DI[0xb] = unaff_DI[0xb] - 1;
          unaff_DI[0xb] = unaff_DI[0xb] - 1;
          return;
        }
      }
    }
  }
  return;
}


/* 1000:3066 FUN_1000_3066 */

int __cdecl16near FUN_1000_3066(void)

{
  int in_AX;
  uint uVar1;
  int unaff_SI;
  int unaff_DI;
  undefined2 unaff_DS;
  int iStack_2;
  
  iStack_2 = in_AX;
  if (in_AX + 2U < 0x9c5) {
    FUN_1000_30a4();
    uVar1 = FUN_1000_30a4();
    if (uVar1 < 0x79) {
      *(char *)(unaff_DI + 0x15) = *(char *)(unaff_DI + 0x15) + '\x02';
      *(char *)(unaff_SI + 0x15) = *(char *)(unaff_SI + 0x15) + '\x02';
      FUN_1000_237b();
      iStack_2 = 0x30a0;
      FUN_1000_237b();
    }
  }
  return iStack_2;
}


/* 1000:30a4 FUN_1000_30a4 */

void __cdecl16near FUN_1000_30a4(void)

{
  byte *unaff_SI;
  undefined2 unaff_DS;
  
  if ((*unaff_SI < 0xd) && (*(int *)((uint)*unaff_SI * 2 + 0x30d2) != 0)) {
    FUN_1000_2470();
    FUN_1000_237b();
    FUN_1000_2ed4();
  }
  return;
}


/* 1000:30ec FUN_1000_30ec */

void __cdecl16near FUN_1000_30ec(void)

{
  int iVar1;
  int iVar2;
  byte *pbVar3;
  undefined2 unaff_DS;
  
  iVar1 = 4;
  pbVar3 = (byte *)0x8c64;
  do {
    iVar2 = 4;
    do {
      if ((*pbVar3 & 0x80) != 0) {
        FUN_1000_3109();
      }
      pbVar3 = pbVar3 + 0x3b;
      iVar2 = iVar2 + -1;
    } while (iVar2 != 0);
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  return;
}


/* 1000:3109 FUN_1000_3109 */

void __cdecl16near FUN_1000_3109(void)

{
  byte *pbVar1;
  uint uVar2;
  int iVar3;
  byte *pbVar4;
  byte *pbVar5;
  byte *unaff_DI;
  undefined2 unaff_DS;
  
  *(undefined1 *)0xa282 = 0;
  pbVar4 = (byte *)0x904c;
  do {
    iVar3 = 0x14;
    pbVar5 = pbVar4;
    do {
      if (((*pbVar5 == 0) || ((*unaff_DI & 0x80) == 0)) || (uVar2 = FUN_1000_23c4(), 599 < uVar2)) {
LAB_1000_31b0:
        FUN_1000_31d1();
      }
      else {
        if (pbVar5[7] != unaff_DI[0x18]) {
          unaff_DI[0x16] = unaff_DI[0x16] | 4;
          if (uVar2 < 0x105) {
            if (2 < *pbVar5) {
              *pbVar5 = 2;
            }
            if (((*unaff_DI & 0x44) == 0) && (*pbVar5 == 1)) {
              pbVar1 = unaff_DI + 0x2a;
              *pbVar1 = *pbVar1 - 1;
              if ((char)*pbVar1 < '\0') {
                unaff_DI[0x2a] = 0;
                FUN_1000_237b();
                FUN_1000_2ed4();
              }
            }
            FUN_1000_237b();
            FUN_1000_2ed4();
          }
          goto LAB_1000_31b0;
        }
        if (((uVar2 < 0x65) && (pbVar5[6] == unaff_DI[0x17])) &&
           ((unaff_DI[0x2a] != 0 && ((unaff_DI[0x22] & 1) != 0)))) {
          if (unaff_DI[6] < 5) {
            *pbVar5 = 0;
            unaff_DI[6] = unaff_DI[6] + 1;
          }
          else {
            unaff_DI[0x22] = 0;
          }
        }
      }
      pbVar5 = pbVar5 + 8;
      iVar3 = iVar3 + -1;
    } while (iVar3 != 0);
    pbVar4 = pbVar4 + 0xa0;
    *(char *)0xa282 = *(char *)0xa282 + '\x01';
    if (3 < *(byte *)0xa282) {
      return;
    }
  } while( true );
}


/* 1000:31d1 FUN_1000_31d1 */

void __cdecl16near FUN_1000_31d1(void)

{
  int unaff_DI;
  undefined2 unaff_DS;
  
  if (((((*(byte *)(unaff_DI + 0x11) & 0x1f) == 0) && ((*(byte *)(unaff_DI + 0x16) & 4) != 0)) &&
      (2 < *(byte *)(unaff_DI + 0x2a))) && (6 < (*(byte *)(unaff_DI + 0xb) & 0xf))) {
    *(char *)(unaff_DI + 0xb) = *(char *)(unaff_DI + 0xb) + -1;
  }
  return;
}


/* 1000:31f0 FUN_1000_31f0 */

void __cdecl16near FUN_1000_31f0(void)

{
  int iVar1;
  int iVar2;
  byte *pbVar3;
  undefined2 unaff_DS;
  
  iVar1 = 4;
  pbVar3 = (byte *)0x8c64;
  *(undefined1 *)0xa282 = 0x80;
  *(undefined1 *)0xa274 = 0;
  do {
    iVar2 = 4;
    do {
      if ((*pbVar3 & 0x80) != 0) {
        FUN_1000_3247();
      }
      pbVar3 = pbVar3 + 0x3b;
      iVar2 = iVar2 + -1;
    } while (iVar2 != 0);
    *(byte *)0xa282 = *(byte *)0xa282 >> 1;
    *(char *)0xa274 = *(char *)0xa274 + '\x01';
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  return;
}


/* 1000:3225 FUN_1000_3225 */

void FUN_1000_3225(void)

{
  return;
}


/* 1000:3228 FUN_1000_3228 */

void __cdecl16near FUN_1000_3228(void)

{
  return;
}


/* 1000:3247 FUN_1000_3247 */

uint __cdecl16near FUN_1000_3247(void)

{
  byte bVar1;
  uint uVar2;
  uint in_CX;
  uint uVar3;
  int unaff_BP;
  byte *unaff_SI;
  int unaff_DI;
  undefined2 unaff_DS;
  bool bVar4;
  undefined1 uVar5;
  
  FUN_1000_3225();
  in_CX = in_CX >> 1;
  if ((*(byte *)0x89d2 & 1) == 0) {
    unaff_SI = unaff_SI + 0xb;
  }
  do {
    uVar2 = FUN_1000_23c4();
    uVar5 = uVar2 == 400;
    if (uVar2 < 0x191) {
      *unaff_SI = *unaff_SI | *(byte *)0xa282;
      uVar5 = uVar2 == 0xfa;
      if (uVar2 < 0xfb) {
        uVar3 = *unaff_SI & 0xf;
        if (((*unaff_SI & 0xf) == 0) || (((byte)uVar3 != 0xe && (0xd < (byte)uVar3)))) {
LAB_1000_32c3:
          uVar5 = uVar3 * 2 == 0;
          (*(code *)*(undefined2 *)(uVar3 * 2 + 0x331b))();
        }
        else {
          uVar5 = uVar2 == 0x46;
          if ((uVar2 < 0x47) &&
             (bVar4 = (*(byte *)(unaff_DI + 0x11) & 0x1f) == 1, uVar5 = bVar4, !bVar4)) {
            FUN_1000_3f57();
            uVar5 = 0;
            if (bVar4) {
              if ((*(char *)(unaff_DI + 0x29) == '\x03') &&
                 ((bVar1 = *unaff_SI & 0xf, bVar1 < 10 ||
                  ((0xd < bVar1 && ((bVar1 != 0xe || (*(byte *)(unaff_BP + 5) == unaff_SI[5]))))))))
              {
                *(undefined1 *)(unaff_DI + 0x29) = 0;
                unaff_SI[10] = *(byte *)(unaff_DI + 0x18);
              }
              goto LAB_1000_32c3;
            }
          }
        }
      }
    }
    FUN_1000_3f57();
    if ((bool)uVar5) {
      uVar2 = FUN_1000_32e5();
    }
    unaff_SI = unaff_SI + 0x16;
    in_CX = in_CX - 1;
    if (in_CX == 0) {
      return uVar2;
    }
  } while( true );
}


/* 1000:32e5 FUN_1000_32e5 */

void __cdecl16near FUN_1000_32e5(void)

{
  uint in_AX;
  byte *unaff_SI;
  int unaff_DI;
  undefined2 unaff_DS;
  
  if (in_AX < 0xfa1) {
    if ((*(byte *)0xa282 & *unaff_SI) == 0) {
      *(byte *)(unaff_DI + 0x28) = *(byte *)(unaff_DI + 0x28) | 0x10;
      return;
    }
    if (in_AX < 0xbb9) {
      *(byte *)(unaff_DI + 0x28) =
           *(byte *)(unaff_DI + 0x28) | *(byte *)((*unaff_SI & 0xf) + 0x330b);
    }
  }
  return;
}


/* 1000:36b5 FUN_1000_36b5 */

void __cdecl16near FUN_1000_36b5(void)

{
  byte *pbVar1;
  byte bVar2;
  uint uVar3;
  int iVar4;
  uint uVar5;
  byte *pbVar6;
  byte *pbVar7;
  undefined2 unaff_DS;
  undefined4 uVar8;
  
  pbVar6 = (byte *)0x8a8c;
  uVar5 = (uint)*(byte *)&UNK_0000_0001;
  do {
    pbVar1 = pbVar6 + 8;
    *(int *)pbVar1 = *(int *)pbVar1 + -1;
    if (*(int *)pbVar1 == 0) {
      FUN_1000_4312();
    }
    iVar4 = 0x10;
    pbVar7 = (byte *)0x8c64;
    do {
      bVar2 = *pbVar7;
      if (((bVar2 & 0x80) != 0) && ((bVar2 & 0x44) == 0)) {
        if ((*pbVar6 & 3) == 2) {
          if ((*(uint *)(pbVar7 + 8) < 0xbb9) || (8 < pbVar7[0xe])) {
LAB_1000_3700:
            uVar8 = FUN_1000_3fb3();
            uVar3 = (uint)uVar8;
            if (uVar3 < 0x15f) {
              if ((*pbVar6 & 3) == 0) {
                pbVar7[0x16] = pbVar7[0x16] | 0x10;
                if ((pbVar7[0x19] & 0x80) != 0) {
                  if (*(uint *)(pbVar6 + 8) < 0x15) {
                    (pbVar6 + 8)[0] = 1;
                    (pbVar6 + 8)[1] = 0;
                    goto LAB_1000_3786;
                  }
                  *(undefined **)(pbVar6 + 8) = (undefined *)&UNK_0000_ffec + *(int *)(pbVar6 + 8);
                }
                if (uVar3 < 0x65) {
                  FUN_1000_237b((int)((ulong)uVar8 >> 0x10));
LAB_1000_3757:
                  if (4 < *(uint *)(pbVar6 + 8)) {
                    *(int *)(pbVar6 + 8) = *(int *)(pbVar6 + 8) + -3;
                  }
                }
              }
              else if ((*pbVar6 & 3) == 1) {
                pbVar7[0x16] = pbVar7[0x16] | 8;
                if (uVar3 < 0x56) {
                  pbVar7[0x15] = pbVar7[0x15] + 2;
                  goto LAB_1000_3757;
                }
              }
              else if (uVar3 < 0x65) {
                (pbVar7 + 8)[0] = 0xb8;
                (pbVar7 + 8)[1] = 0x88;
                pbVar7[7] = 0x14;
                pbVar7[0xf] = 99;
                pbVar7[0x2a] = 8;
                pbVar7[0xe] = 0;
                FUN_1000_37a1();
                (pbVar6 + 8)[0] = 1;
                (pbVar6 + 8)[1] = 0;
              }
            }
          }
        }
        else if (((pbVar7[0x19] & 0xf0) != 0) || ((bVar2 & 0x10) == 0)) goto LAB_1000_3700;
      }
LAB_1000_3786:
      pbVar7 = pbVar7 + 0x3b;
      iVar4 = iVar4 + -1;
    } while (iVar4 != 0);
    FUN_1000_221e();
    pbVar6 = pbVar6 + 0x3b;
    uVar5 = uVar5 - 1;
    if (uVar5 == 0) {
      return;
    }
  } while( true );
}


/* 1000:37a1 FUN_1000_37a1 */

void __cdecl16near FUN_1000_37a1(void)

{
  int unaff_DI;
  undefined2 unaff_DS;
  
  if (0xc < *(byte *)(unaff_DI + 0x15)) {
    *(undefined1 *)(unaff_DI + 0x15) = 0xc;
  }
  return;
}


/* 1000:37ac FUN_1000_37ac */

void __cdecl16near FUN_1000_37ac(void)

{
  uint uVar1;
  byte bVar2;
  int iVar3;
  byte *pbVar4;
  undefined2 unaff_DS;
  
  pbVar4 = (byte *)0x8a8c;
  iVar3 = 0x18;
  do {
    if ((*pbVar4 & 0x80) != 0) {
      uVar1 = *(uint *)(pbVar4 + 10) & 0xfff;
      bVar2 = (byte)(uVar1 >> 8);
      if (((10 < bVar2) && (pbVar4[0x14] != 0)) && (1999 < *(uint *)(pbVar4 + 8))) {
        pbVar4[0x14] = pbVar4[0x14] - 1;
        FUN_1000_239b();
        uVar1 = (uint)(byte)(bVar2 + 9) << 8;
      }
      if ((uVar1 & 0x1f00) != 0) {
        FUN_1000_382a();
      }
    }
    bVar2 = pbVar4[0x19];
    if (bVar2 != 0) {
      if (bVar2 < 4) {
        pbVar4[0x20] = bVar2 * '\x04';
      }
      if ((*(uint *)(pbVar4 + 0x1f) & 0x1f00) != 0) {
        FUN_1000_382a();
      }
      pbVar4[0x19] = pbVar4[0x19] - 1;
      if ((pbVar4[0x19] == 0x80) || (pbVar4[0x19] == 0xc0)) {
        pbVar4[0x19] = 0;
      }
    }
    pbVar4 = pbVar4 + 0x3b;
    iVar3 = iVar3 + -1;
  } while (iVar3 != 0);
  return;
}


/* 1000:382a FUN_1000_382a */

void __cdecl16near FUN_1000_382a(void)

{
  uint uVar1;
  uint in_AX;
  uint uVar2;
  uint uVar3;
  uint uVar4;
  byte bVar5;
  int unaff_DI;
  undefined2 unaff_DS;
  
  uVar2 = *(uint *)((uint)(byte)((char)(in_AX >> 8) - 1) * 8 + 0x387c + (in_AX & 3) * 2);
  uVar1 = uVar2 >> 8;
  uVar2 = uVar2 & 0xff;
  bVar5 = (byte)in_AX & 0xc;
  uVar3 = uVar2;
  uVar4 = uVar1;
  if ((((in_AX & 0xc) != 0) && (uVar3 = uVar1, uVar4 = -uVar2, bVar5 != 4)) &&
     (uVar3 = -uVar2, uVar4 = -uVar1, bVar5 != 8)) {
    uVar3 = -uVar1;
    uVar4 = uVar2;
  }
  *(int *)(unaff_DI + 1) = *(int *)(unaff_DI + 1) + uVar3;
  *(uint *)(unaff_DI + 1) = *(uint *)(unaff_DI + 1) & 0x3fff;
  *(int *)(unaff_DI + 3) = *(int *)(unaff_DI + 3) + uVar4;
  *(uint *)(unaff_DI + 3) = *(uint *)(unaff_DI + 3) & 0x3fff;
  return;
}


/* 1000:3974 FUN_1000_3974 */

void __cdecl16near FUN_1000_3974(void)

{
  FUN_1000_3991();
  FUN_1000_3991();
  FUN_1000_3991();
  FUN_1000_3991();
  return;
}


/* 1000:3991 FUN_1000_3991 */

void __cdecl16near FUN_1000_3991(void)

{
  undefined1 in_AL;
  byte bVar1;
  int unaff_SI;
  undefined2 unaff_DS;
  
  *(undefined1 *)0xa274 = in_AL;
  bVar1 = 0;
  do {
    FUN_1000_2a0c();
    if ((3 < *(byte *)(unaff_SI + 0x19)) && (*(byte *)(unaff_SI + 0x19) < 0x80)) {
      FUN_1000_3e85();
    }
    if ((*(byte *)(unaff_SI + 0x11) & 0x1f) != 0) {
      FUN_1000_39bf();
    }
    bVar1 = bVar1 + 1;
  } while (bVar1 < 4);
  return;
}


/* 1000:39bf FUN_1000_39bf */

void __cdecl16near FUN_1000_39bf(void)

{
  char cVar1;
  byte bVar2;
  uint in_AX;
  undefined2 uVar3;
  uint uVar4;
  int in_CX;
  int iVar5;
  byte *in_BX;
  uint uVar6;
  byte *unaff_SI;
  byte *pbVar7;
  byte *unaff_DI;
  int iVar8;
  byte *pbVar9;
  undefined2 unaff_DS;
  bool bVar10;
  undefined2 in_stack_00000000;
  byte bVar11;
  
  (unaff_SI + 0x12)[0] = 0xff;
  (unaff_SI + 0x12)[1] = 0xff;
  cVar1 = (char)in_AX;
  if (cVar1 == '\x01') {
    uVar3 = FUN_1000_3225();
    uVar6 = 40000;
    do {
      if (((byte)((uint)uVar3 >> 8) & *unaff_DI) == 0) {
        if (uVar6 == 40000) {
          uVar6 = 39999;
        }
        uVar4 = FUN_1000_2a26();
        if ((uVar4 <= uVar6) && (uVar4 < 10000)) {
          *(uint *)(unaff_SI + 0x12) = uVar4;
          FUN_1000_3fc1();
          uVar6 = uVar4;
        }
      }
      unaff_DI = unaff_DI + 0xb;
      in_CX = in_CX + -1;
    } while (in_CX != 0);
    if (uVar6 == 40000) {
      unaff_SI[0x11] = 0x80;
    }
    return;
  }
  if (cVar1 == '\x02') {
    uVar3 = FUN_1000_3225();
    do {
      if (((((byte)((uint)uVar3 >> 8) & *unaff_DI) != 0) &&
          (bVar10 = (*unaff_DI & 0xf) == 2, bVar10)) && (FUN_1000_3f57(), bVar10)) {
        FUN_1000_3f6a();
      }
      unaff_DI = unaff_DI + 0xb;
      in_CX = in_CX + -1;
    } while (in_CX != 0);
    return;
  }
  if (cVar1 == '\x03') {
    uVar3 = FUN_1000_3225();
    do {
      if (((((byte)((uint)uVar3 >> 8) & *unaff_DI) != 0) &&
          (bVar10 = (*unaff_DI & 0xf) == 3, bVar10)) && (FUN_1000_3f57(), bVar10)) {
        FUN_1000_3f6a();
      }
      unaff_DI = unaff_DI + 0xb;
      in_CX = in_CX + -1;
    } while (in_CX != 0);
    return;
  }
  if (cVar1 == '\x04') {
    pick_ptr();
    if (*(int *)(in_BX + 8) == 0) {
      unaff_SI[0x11] = 0x80;
      return;
    }
    uVar6 = FUN_1000_2a26(in_AX);
    *(uint *)(unaff_SI + 0x12) = uVar6;
    if (uVar6 < 0x3e81) {
      FUN_1000_3fc1();
    }
    FUN_1000_3225();
    do {
      if (((((byte)((uint)in_stack_00000000 >> 8) & *in_BX) != 0) &&
          (bVar10 = (*in_BX & 0xf) == 4, bVar10)) && (FUN_1000_3f57(), bVar10)) {
        FUN_1000_3f6a();
      }
      in_BX = in_BX + 0xb;
      in_CX = in_CX + -1;
    } while (in_CX != 0);
    return;
  }
  if (cVar1 == '\x05') {
    uVar3 = FUN_1000_3225();
    do {
      if (((((byte)((uint)uVar3 >> 8) & *unaff_DI) != 0) &&
          (bVar10 = (*unaff_DI & 0xf) == 1, bVar10)) && (FUN_1000_3f57(), bVar10)) {
        FUN_1000_3f6a();
      }
      unaff_DI = unaff_DI + 0xb;
      in_CX = in_CX + -1;
    } while (in_CX != 0);
    return;
  }
  if (cVar1 == '\x06') {
    iVar8 = -0x6fec;
    iVar5 = 4;
    uVar6 = 16000;
    unaff_SI[0x11] = unaff_SI[0x11] & 0x3f;
    do {
      if (((*(byte *)(iVar8 + 0xc) != unaff_SI[0x18]) && (*(int *)(iVar8 + 8) != 0)) &&
         ((unaff_SI[0x2b] == unaff_SI[0x17] || (unaff_SI[0x2b] == *(byte *)(iVar8 + 0xb))))) {
        uVar4 = FUN_1000_2a26();
        if (uVar4 <= uVar6) {
          *(uint *)(unaff_SI + 0x12) = uVar4;
          uVar6 = FUN_1000_3e2a();
          if (uVar6 < 0x385) {
            unaff_SI[0x11] = unaff_SI[0x11] | 0xc0;
          }
          FUN_1000_3fc1();
          uVar6 = uVar4;
        }
      }
      iVar8 = iVar8 + 0xe;
      iVar5 = iVar5 + -1;
    } while (iVar5 != 0);
    return;
  }
  if (cVar1 != '\a') {
    if (cVar1 == '\b') {
      pbVar9 = (byte *)0x8c64;
      iVar5 = 0x10;
      uVar6 = 6000;
      do {
        if (((pbVar9[0x18] != unaff_SI[0x18]) && ((*pbVar9 & 0x80) != 0)) &&
           ((40000 < *(uint *)(unaff_SI + 8) ||
            (((pbVar9[0x19] & 0xf0) != 0 || ((*pbVar9 & 0x10) == 0)))))) {
          uVar4 = FUN_1000_2a26();
          if (uVar4 <= uVar6) {
            *(uint *)(unaff_SI + 0x12) = uVar4;
            FUN_1000_3fc1();
            uVar6 = uVar4;
          }
        }
        pbVar9 = pbVar9 + 0x3b;
        iVar5 = iVar5 + -1;
      } while (iVar5 != 0);
      return;
    }
    if (cVar1 == '\t') {
      uVar3 = FUN_1000_3225();
      do {
        if (((((byte)((uint)uVar3 >> 8) & *unaff_DI) != 0) &&
            (bVar10 = (*unaff_DI & 0xf) == 5, bVar10)) && (FUN_1000_3f57(), bVar10)) {
          FUN_1000_3f6a();
        }
        unaff_DI = unaff_DI + 0xb;
        in_CX = in_CX + -1;
      } while (in_CX != 0);
      return;
    }
    if (cVar1 == '\n') {
      uVar3 = FUN_1000_3225();
      do {
        if (((((byte)((uint)uVar3 >> 8) & *unaff_DI) != 0) &&
            (bVar10 = (*unaff_DI & 0xf) == 6, bVar10)) && (FUN_1000_3f57(), bVar10)) {
          FUN_1000_3f6a();
        }
        unaff_DI = unaff_DI + 0xb;
        in_CX = in_CX + -1;
      } while (in_CX != 0);
      return;
    }
    if (cVar1 == '\v') {
      uVar3 = FUN_1000_3225();
      if (*(uint *)(unaff_SI + 8) < 0xbb9) {
        do {
          if (((((byte)((uint)uVar3 >> 8) & *unaff_DI) != 0) &&
              (bVar10 = (*unaff_DI & 0xf) == 7, bVar10)) && (FUN_1000_3f57(), bVar10)) {
            FUN_1000_3f6a();
          }
          unaff_DI = unaff_DI + 0xb;
          in_CX = in_CX + -1;
        } while (in_CX != 0);
      }
      return;
    }
    if (cVar1 == '\f') {
      iVar5 = 16000;
      uVar3 = FUN_1000_3225();
      do {
        bVar10 = ((byte)((uint)uVar3 >> 8) & *unaff_DI) == 0;
        if (((((!bVar10) && (FUN_1000_3f57(), bVar10)) &&
             (bVar2 = (*unaff_DI & 0xf) - 10, 9 < (*unaff_DI & 0xf))) && (bVar2 < 4)) &&
           ((unaff_SI[0x2b] == unaff_SI[0x17] || (bVar2 == unaff_SI[0x2b])))) {
          LOCK();
          bVar11 = *(byte *)0xa274;
          *(byte *)0xa274 = bVar2;
          UNLOCK();
          iVar8 = iVar5;
          pick_ptr();
          iVar8 = *(int *)(iVar8 + 8);
          *(byte *)0xa274 = bVar11;
          if (iVar8 != 0) {
            FUN_1000_3f6a();
          }
        }
        unaff_DI = unaff_DI + 0xb;
        in_CX = in_CX + -1;
      } while (in_CX != 0);
      return;
    }
    if (cVar1 == '\r') {
      uVar6 = FUN_1000_2a26();
      if (in_BX < (byte *)&UNK_0000_fff1) {
        *(uint *)(unaff_SI + 0x12) = uVar6;
        FUN_1000_3fc1();
        if (0x28 < uVar6) {
          return;
        }
        unaff_SI[0xb] = 0;
      }
      unaff_SI[0x11] = 0x80;
      return;
    }
    if (cVar1 == '\x0e') {
      uVar3 = FUN_1000_3225();
      do {
        if (((((byte)((uint)uVar3 >> 8) & *unaff_DI) != 0) &&
            (bVar10 = (*unaff_DI & 0xf) == 0xe, bVar10)) && (FUN_1000_3f57(), bVar10)) {
          FUN_1000_3f6a();
        }
        unaff_DI = unaff_DI + 0xb;
        in_CX = in_CX + -1;
      } while (in_CX != 0);
      return;
    }
    if ((in_AX & 0x10) == 0) {
      return;
    }
    pick_ptr();
    for (bVar2 = unaff_SI[0x11] & 3; bVar2 != 0; bVar2 = bVar2 - 1) {
      in_BX = in_BX + 0x3b;
    }
    if ((*in_BX & 0x80) == 0) {
      unaff_SI[0x11] = 0x80;
      return;
    }
    uVar6 = FUN_1000_2a26();
    *(uint *)(unaff_SI + 0x12) = uVar6;
    FUN_1000_3fc1();
    if (0xfa < uVar6) {
      return;
    }
    unaff_SI[0x34] = 1;
    in_BX[0x34] = 1;
    *(undefined2 *)(unaff_SI + 1) = *(undefined2 *)(in_BX + 1);
    *(undefined2 *)(unaff_SI + 3) = *(undefined2 *)(in_BX + 3);
    unaff_SI[0x14] = in_BX[0x14];
    *(undefined2 *)(unaff_SI + 10) = *(undefined2 *)(in_BX + 10);
    pbVar9 = in_BX;
    if ((*(int *)(in_BX + 0x32) != 0) &&
       (pbVar9 = *(byte **)(in_BX + 0x32), *(int *)(pbVar9 + 0x32) != 0)) {
      pbVar9 = *(byte **)(pbVar9 + 0x32);
    }
    *(byte **)(pbVar9 + 0x32) = unaff_SI;
    (unaff_SI + 0x32)[0] = 0;
    (unaff_SI + 0x32)[1] = 0;
    FUN_1000_382a(in_BX);
    pbVar9 = in_BX;
    if (*(uint *)(in_BX + 8) <= *(uint *)(unaff_SI + 8)) {
      pbVar9 = unaff_SI;
      unaff_SI = in_BX;
    }
    uVar6 = (uint)(*(int *)(pbVar9 + 8) - *(int *)(unaff_SI + 8)) >> 4;
    *(uint *)(pbVar9 + 8) = *(int *)(pbVar9 + 8) - uVar6;
    *(uint *)(unaff_SI + 8) = *(int *)(unaff_SI + 8) + uVar6;
    pbVar7 = pbVar9;
    if (pbVar9[7] <= unaff_SI[7]) {
      pbVar7 = unaff_SI;
      unaff_SI = pbVar9;
    }
    if (1 < (byte)(pbVar7[7] - unaff_SI[7])) {
      pbVar7[7] = pbVar7[7] - 1;
      unaff_SI[7] = unaff_SI[7] + 1;
    }
    pbVar9 = pbVar7;
    if (pbVar7[0xf] <= unaff_SI[0xf]) {
      pbVar9 = unaff_SI;
      unaff_SI = pbVar7;
    }
    bVar2 = (byte)(pbVar9[0xf] - unaff_SI[0xf]) >> 1;
    pbVar9[0xf] = pbVar9[0xf] - bVar2;
    unaff_SI[0xf] = unaff_SI[0xf] + bVar2;
    return;
  }
  pbVar9 = (byte *)0x8c64;
  iVar5 = 0x10;
  uVar6 = 0x1d4c;
  unaff_SI[0x11] = unaff_SI[0x11] & 0x3f;
  do {
    if (((((pbVar9[0x18] != unaff_SI[0x18]) && ((*pbVar9 & 0x80) != 0)) && ((*pbVar9 & 0x44) == 0))
        && (((40000 < *(uint *)(unaff_SI + 8) || ((*pbVar9 & 0x10) == 0)) ||
            ((pbVar9[0x19] & 0xf0) != 0)))) &&
       ((unaff_SI[0x2b] == unaff_SI[0x17] || (unaff_SI[0x2b] == pbVar9[0x17])))) {
      uVar4 = FUN_1000_2a26();
      if (uVar4 <= uVar6) {
        *(uint *)(unaff_SI + 0x12) = uVar4;
        if ((uVar4 < 0x385) && (unaff_SI[0x11] = unaff_SI[0x11] | 0xc0, uVar4 < 0x191)) {
          bVar2 = unaff_SI[0xb] >> 4;
          uVar6 = uVar4;
          do {
            bVar2 = bVar2 & 0xf;
            if (bVar2 == 0) break;
            bVar2 = bVar2 - 1;
            uVar6 = uVar6 + 0x32;
          } while (uVar6 < 400);
          if (bVar2 <= unaff_SI[0xb]) {
            unaff_SI[0xb] = unaff_SI[0xb] & 0xf0;
            unaff_SI[0xb] = unaff_SI[0xb] | bVar2;
          }
        }
        FUN_1000_3fc1();
        uVar6 = uVar4;
      }
    }
    pbVar9 = pbVar9 + 0x3b;
    iVar5 = iVar5 + -1;
    if (iVar5 == 0) {
      return;
    }
  } while( true );
}


/* 1000:3e2a FUN_1000_3e2a */

void __cdecl16near FUN_1000_3e2a(void)

{
  return;
}


/* 1000:3e85 FUN_1000_3e85 */

void __cdecl16near FUN_1000_3e85(void)

{
  uint uVar1;
  undefined1 uVar2;
  byte bVar3;
  byte bVar4;
  int iVar5;
  int iVar6;
  byte bVar7;
  uint uVar8;
  int unaff_SI;
  int iVar9;
  byte *pbVar10;
  undefined2 unaff_DS;
  
  *(undefined1 *)0xa281 = *(undefined1 *)(unaff_SI + 0x1f);
  iVar5 = 4;
  iVar9 = -0x6fec;
  uVar8 = 3000;
  do {
    if ((((*(int *)(iVar9 + 8) != 0) && (*(char *)(iVar9 + 0xc) != *(char *)(unaff_SI + 0x18))) &&
        ((*(char *)(unaff_SI + 0x2b) == *(char *)(unaff_SI + 0x17) ||
         (*(char *)(unaff_SI + 0x2b) == *(char *)(iVar9 + 0xb))))) &&
       (iVar6 = iVar5, uVar1 = FUN_1000_2a26(), uVar1 <= uVar8)) {
      *(undefined1 *)0xa281 = (char)((uint)iVar6 >> 8);
      uVar8 = uVar1;
    }
    iVar9 = iVar9 + 0xe;
    iVar5 = iVar5 + -1;
  } while (iVar5 != 0);
  pbVar10 = (byte *)0x8c64;
  iVar5 = 0x10;
  do {
    if ((((pbVar10[0x18] != *(byte *)(unaff_SI + 0x18)) && ((*pbVar10 & 0x80) != 0)) &&
        (((*pbVar10 & 0x10) == 0 || ((*(byte *)0x89d2 & 1) == 0)))) &&
       (((*(byte *)(unaff_SI + 0x2b) == *(byte *)(unaff_SI + 0x17) ||
         (*(byte *)(unaff_SI + 0x2b) == pbVar10[0x17])) &&
        (iVar9 = iVar5, uVar1 = FUN_1000_2a26(), uVar1 <= uVar8)))) {
      *(undefined1 *)0xa281 = (char)((uint)iVar9 >> 8);
      uVar8 = uVar1;
    }
    pbVar10 = pbVar10 + 0x3b;
    iVar5 = iVar5 + -1;
  } while (iVar5 != 0);
  if ((*(byte *)(unaff_SI + 0x19) & 0x44) != 0) {
    uVar8 = uVar8 >> 2;
  }
  uVar2 = *(undefined1 *)(unaff_SI + 0x1f);
  if (uVar8 < 0x191) {
    uVar2 = *(undefined1 *)0xa281;
  }
  uVar8 = CONCAT11(*(undefined1 *)0xa281,uVar2) & 0xff0f;
  bVar3 = (byte)uVar8;
  bVar7 = (char)(uVar8 >> 8) - bVar3;
  bVar4 = bVar3;
  if (bVar7 != 0) {
    if ((char)bVar7 < '\0') {
      bVar7 = bVar7 + 0x10;
    }
    bVar4 = bVar3 + 1;
    if (((4 < bVar7) && (bVar4 = bVar3 + 2, 8 < bVar7)) && (bVar4 = bVar3 - 2, 0xb < bVar7)) {
      bVar4 = bVar3 - 1;
    }
  }
  *(byte *)(unaff_SI + 0x1f) = bVar4 & 0xf;
  return;
}


/* 1000:3f57 FUN_1000_3f57 */

void __cdecl16near FUN_1000_3f57(void)

{
  return;
}


/* 1000:3f6a FUN_1000_3f6a */

void __cdecl16near FUN_1000_3f6a(void)

{
  byte bVar1;
  uint uVar2;
  byte bVar3;
  char in_CH;
  uint in_BX;
  int unaff_SI;
  undefined2 unaff_DS;
  
  uVar2 = FUN_1000_2a26();
  if (uVar2 < in_BX) {
    *(uint *)(unaff_SI + 0x12) = uVar2;
    if (uVar2 < 0xc9) {
      *(undefined1 *)(unaff_SI + 0x14) = 0;
      bVar1 = (byte)uVar2;
      bVar3 = 5;
      if ((((bVar1 < 0x97) && (bVar3 = 4, bVar1 < 0x6f)) && (bVar3 = 3, bVar1 < 0x56)) &&
         ((bVar3 = 2, bVar1 < 0x3d && (bVar3 = 1, bVar1 < 0x29)))) {
        bVar3 = 0;
      }
      *(byte *)(unaff_SI + 0xb) = *(byte *)(unaff_SI + 0xb) & 0xf0;
      *(byte *)(unaff_SI + 0xb) = *(byte *)(unaff_SI + 0xb) | bVar3;
      uVar2 = uVar2 & 0xff;
    }
    if (10 < uVar2) {
      *(byte *)(unaff_SI + 10) = *(byte *)(unaff_SI + 10) & 0xf;
      *(byte *)(unaff_SI + 10) = *(byte *)(unaff_SI + 10) | in_CH * '\x10';
      return;
    }
  }
  return;
}


/* 1000:3fb3 FUN_1000_3fb3 */

void __cdecl16near FUN_1000_3fb3(void)

{
  uint uVar1;
  char in_CH;
  uint in_BX;
  int unaff_SI;
  undefined2 unaff_DS;
  
  uVar1 = FUN_1000_2a26();
  if (uVar1 <= in_BX) {
    *(uint *)(unaff_SI + 0x12) = uVar1;
    *(byte *)(unaff_SI + 10) = *(byte *)(unaff_SI + 10) & 0xf;
    *(byte *)(unaff_SI + 10) = *(byte *)(unaff_SI + 10) | in_CH * '\x10';
  }
  return;
}


/* 1000:3fc1 FUN_1000_3fc1 */

void __cdecl16near FUN_1000_3fc1(void)

{
  char in_CH;
  int unaff_SI;
  undefined2 unaff_DS;
  
  *(byte *)(unaff_SI + 10) = *(byte *)(unaff_SI + 10) & 0xf;
  *(byte *)(unaff_SI + 10) = *(byte *)(unaff_SI + 10) | in_CH * '\x10';
  return;
}


/* 1000:3fd1 FUN_1000_3fd1 */

void __cdecl16near FUN_1000_3fd1(void)

{
  undefined1 *puVar1;
  undefined2 uVar2;
  byte bVar3;
  byte bVar4;
  char cVar5;
  uint uVar6;
  int iVar7;
  uint extraout_DX;
  byte extraout_DH;
  byte *in_BX;
  undefined1 *puVar8;
  byte *pbVar9;
  byte *pbVar10;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  undefined1 uVar11;
  bool bVar12;
  uint uStack_4;
  
  uVar2 = *(undefined2 *)0x89d0;
  puVar8 = (undefined1 *)0x89d0;
  for (iVar7 = *(int *)&UNK_0000_00d1; iVar7 != 0; iVar7 = iVar7 + -1) {
    puVar1 = puVar8;
    puVar8 = puVar8 + 1;
    *puVar1 = 0;
  }
  *(undefined2 *)0x89d0 = uVar2;
  *(undefined1 *)0xa274 = 0;
  *(undefined1 *)0xa282 = 0;
LAB_1000_3fee:
  pbVar9 = in_BX;
  pick_ptr();
  bVar3 = *pbVar9;
  pick_ptr();
  uVar11 = 0;
  in_BX = pbVar9;
  if (bVar3 != 0) goto code_r0x0001400e;
  goto LAB_1000_4044;
code_r0x0001400e:
  FUN_1000_427d();
  *(char *)0x89d2 = *(char *)0x89d2 + '\x01';
  FUN_1000_4217();
  if (!(bool)uVar11) {
    bVar3 = FUN_1000_23b3();
    (pbVar9 + 8)[0] = 0xa8;
    (pbVar9 + 8)[1] = 0x61;
    pbVar9[7] = 0xaf;
    if (bVar3 < 3) {
      (pbVar9 + 8)[0] = 0x20;
      (pbVar9 + 8)[1] = 0x4e;
      pbVar9[7] = 0x7d;
    }
    pbVar9[6] = 0x14;
    pbVar9[10] = bVar3 * '\x02' + 4;
LAB_1000_4044:
    pbVar9[0xc] = *(byte *)0xa282;
    bVar3 = *(byte *)0xa274;
    pbVar9[0xb] = bVar3;
    pbVar9[0xd] = 4;
    if ((*(byte *)&UNK_0000_0012 & 2) != 0) {
      pbVar9[5] = bVar3;
    }
    pick_ptr();
    iVar7 = 0x14;
    bVar3 = *(byte *)0xa282;
    bVar4 = *(byte *)0xa274;
    pbVar9 = in_BX;
    do {
      *pbVar9 = 0;
      pbVar9[6] = bVar4;
      pbVar9[7] = bVar3;
      pbVar9 = pbVar9 + 8;
      iVar7 = iVar7 + -1;
    } while (iVar7 != 0);
    *(char *)0xa274 = *(char *)0xa274 + '\x01';
    if (3 < *(byte *)0xa274) {
      if (*(char *)0xa271 == '\x01') {
        return;
      }
      bVar3 = 0;
      do {
        FUN_1000_3228();
        uStack_4 = 0;
        pbVar10 = pbVar9;
        do {
          pbVar9[5] = bVar3;
          do {
            uVar6 = FUN_1000_41fa();
            if (((*(byte *)&UNK_0000_0012 & 2) == 0) || (3000 < uVar6)) break;
          } while (uStack_4 < 6);
          if ((((uStack_4 != 0) && (2 < uStack_4)) &&
              ((bVar12 = false, (*(byte *)&UNK_0000_0012 & 2) == 0 || (FUN_1000_42dd(), !bVar12))))
             && ((bVar4 = FUN_1000_437a(), (bVar4 & 0x1f) != 0xf && ((bVar4 & 3) != 0)))) {
            FUN_1000_42ac();
          }
          bVar4 = FUN_1000_41f0();
          *pbVar9 = bVar4;
          pbVar9[7] = 0;
          pbVar9[8] = 0;
          pbVar9[6] = 0;
          pbVar9[10] = 0xff;
          if ((bVar4 & 0xf) == 0) {
            FUN_1000_437a();
            do {
              do {
                bVar4 = FUN_1000_437a();
              } while (0xfa < bVar4);
            } while (bVar4 < 0x28);
            pbVar9[6] = bVar4;
            uVar6 = extraout_DX;
            pbVar10 = pbVar9;
            while (bVar4 = (byte)uVar6, bVar4 != 0) {
              uStack_4 = uStack_4 + 1;
              if ((char)uStack_4 == *(char *)0x0) goto LAB_1000_41bb;
              pbVar10[0x10] = pbVar9[5];
              *(undefined2 *)(pbVar10 + 0xc) = *(undefined2 *)(pbVar9 + 1);
              iVar7 = *(int *)(pbVar9 + 3) + 200;
              if (bVar4 != 1) {
                iVar7 = *(int *)(pbVar9 + 3) + 400;
              }
              *(int *)(pbVar10 + 0xe) = iVar7;
              pbVar10[0x11] = 0;
              pbVar10[0x12] = 0;
              pbVar10[0x13] = bVar4;
              pbVar10[0x15] = 0xff;
              do {
                cVar5 = FUN_1000_42ac();
              } while (cVar5 == '\x0e');
              bVar4 = FUN_1000_41f0();
              pbVar10[0xb] = bVar4;
              uVar6 = FUN_1000_437a();
              uVar6 = uVar6 & 0x3f;
              do {
                FUN_1000_43b1();
                uVar6 = uVar6 - 1;
              } while (uVar6 != 0);
              pbVar10 = pbVar10 + 0xb;
              uVar6 = (uint)extraout_DH;
            }
            pbVar9 = pbVar10;
          }
          pbVar9 = pbVar9 + 0xb;
          uStack_4 = uStack_4 + 1;
        } while ((char)uStack_4 != *(char *)0x0);
LAB_1000_41bb:
        bVar3 = bVar3 + 1;
        pbVar9 = pbVar10;
        if (*(byte *)&UNK_0000_0002 <= bVar3) {
          uVar6 = (uint)*(byte *)&UNK_0000_0001;
          do {
            FUN_1000_4312();
            uVar6 = uVar6 - 1;
          } while (uVar6 != 0);
          pbVar9 = (byte *)0x89d4;
          iVar7 = 4;
          do {
            bVar3 = FUN_1000_437a();
            *pbVar9 = bVar3 & 3 | 0x50;
            pbVar9 = pbVar9 + 1;
            iVar7 = iVar7 + -1;
          } while (iVar7 != 0);
          *(undefined1 *)0x89d2 = 0;
          return;
        }
      } while( true );
    }
    pick_ptr();
    uVar11 = *(undefined1 *)0xa274;
    if (*in_BX == 0x6d) {
      uVar11 = 0x20;
    }
    *(undefined1 *)0xa282 = uVar11;
  }
  goto LAB_1000_3fee;
}


/* 1000:41f0 FUN_1000_41f0 */

void __cdecl16near FUN_1000_41f0(void)

{
  return;
}


/* 1000:41fa FUN_1000_41fa */

void __cdecl16near FUN_1000_41fa(void)

{
  undefined2 uVar1;
  int unaff_SI;
  undefined2 unaff_DS;
  undefined1 in_CF;
  undefined1 uVar2;
  
  do {
    do {
      uVar2 = in_CF;
      uVar1 = FUN_1000_429b();
      *(undefined2 *)(unaff_SI + 1) = uVar1;
      uVar1 = FUN_1000_429b();
      *(undefined2 *)(unaff_SI + 3) = uVar1;
      FUN_1000_425b();
      in_CF = 1;
    } while ((bool)uVar2);
    FUN_1000_4217();
    in_CF = 1;
  } while ((bool)uVar2);
  return;
}


/* 1000:4217 FUN_1000_4217 */

void __cdecl16near FUN_1000_4217(void)

{
  uint uVar1;
  int iVar2;
  uint in_DX;
  uint unaff_BP;
  int unaff_SI;
  int iVar3;
  undefined2 unaff_DS;
  
  if ((*(byte *)&UNK_0000_0012 & 2) != 0) {
    uVar1 = FUN_1000_23cc();
    if (in_DX <= uVar1) {
      return;
    }
    if (unaff_BP == 0x157c) {
      unaff_BP = 500;
    }
  }
  iVar3 = -0x6fec;
  iVar2 = 4;
  while (((unaff_SI == iVar3 || (*(int *)(iVar3 + 8) == 0)) ||
         (uVar1 = FUN_1000_23cc(), unaff_BP <= uVar1))) {
    iVar3 = iVar3 + 0xe;
    iVar2 = iVar2 + -1;
    if (iVar2 == 0) {
      return;
    }
  }
  return;
}


/* 1000:425b FUN_1000_425b */

void __cdecl16near FUN_1000_425b(void)

{
  uint uVar1;
  int in_CX;
  int unaff_SI;
  int unaff_DI;
  undefined2 unaff_DS;
  
  FUN_1000_3225();
  while (((*(int *)(unaff_DI + 1) == 0 || (unaff_SI == unaff_DI)) ||
         (uVar1 = FUN_1000_23c4(), 0x289 < uVar1))) {
    unaff_DI = unaff_DI + 0xb;
    in_CX = in_CX + -1;
    if (in_CX == 0) {
      return;
    }
  }
  return;
}


/* 1000:427d FUN_1000_427d */

void __cdecl16near FUN_1000_427d(void)

{
  undefined2 uVar1;
  int unaff_SI;
  undefined2 unaff_DS;
  
  uVar1 = FUN_1000_428a();
  *(undefined2 *)(unaff_SI + 1) = uVar1;
  uVar1 = FUN_1000_428a();
  *(undefined2 *)(unaff_SI + 3) = uVar1;
  return;
}


/* 1000:428a FUN_1000_428a */

void __cdecl16near FUN_1000_428a(void)

{
  uint uVar1;
  
  do {
    do {
      uVar1 = FUN_1000_437a();
    } while ((uVar1 & 0x3fff) < 0x5dc);
  } while (0x3a24 < (uVar1 & 0x3fff));
  return;
}


/* 1000:429b FUN_1000_429b */

void __cdecl16near FUN_1000_429b(void)

{
  uint uVar1;
  
  do {
    do {
      uVar1 = FUN_1000_437a();
    } while ((uVar1 & 0x3fff) < 500);
  } while (0x3e0c < (uVar1 & 0x3fff));
  return;
}


/* 1000:42ac FUN_1000_42ac */

undefined1 __cdecl16near FUN_1000_42ac(void)

{
  uint uVar1;
  
  uVar1 = FUN_1000_437a();
  return *(undefined1 *)((uVar1 & 0x1f) + 0x42bd);
}


/* 1000:42dd FUN_1000_42dd */

uint __cdecl16near FUN_1000_42dd(void)

{
  byte bVar1;
  uint in_AX;
  int in_CX;
  int unaff_SI;
  undefined2 unaff_DS;
  
  if (in_CX - 3U < 6) {
    bVar1 = *(byte *)((in_CX - 3U & 6) * 2 + (*(byte *)(unaff_SI + 5) & 3) + 0x4306);
    in_AX = (uint)bVar1;
    if (bVar1 < *(byte *)&UNK_0000_0002) {
      return (uint)(byte)(bVar1 + 10);
    }
  }
  return in_AX;
}


/* 1000:4312 FUN_1000_4312 */

void __cdecl16near FUN_1000_4312(void)

{
  byte bVar1;
  byte bVar2;
  uint uVar3;
  byte *unaff_SI;
  undefined2 unaff_DS;
  bool bVar4;
  
  bVar1 = FUN_1000_437a();
  bVar2 = 2;
  if ((bVar1 & 7) != 0) {
    bVar2 = FUN_1000_437a();
    bVar2 = bVar2 & 1;
  }
  *unaff_SI = bVar2 | 0x80;
  do {
    uVar3 = FUN_1000_437a();
    *(uint *)(unaff_SI + 1) = uVar3 & 0x3fff;
    uVar3 = FUN_1000_437a();
    bVar4 = false;
    *(uint *)(unaff_SI + 3) = uVar3 & 0x3fff;
    FUN_1000_4217();
  } while (bVar4);
  bVar1 = FUN_1000_437a();
  unaff_SI[10] = bVar1;
  bVar1 = FUN_1000_437a();
  bVar2 = (bVar1 & 7) + 5;
  if (*unaff_SI == 0x82) {
    bVar2 = (bVar1 & 7) + 10;
  }
  unaff_SI[0xb] = bVar2;
  uVar3 = FUN_1000_437a();
  *(uint *)(unaff_SI + 8) = (uVar3 & 0xff) + 100;
  if ((*(byte *)&UNK_0000_0012 & 2) != 0) {
    do {
      bVar1 = FUN_1000_437a();
    } while (*(byte *)&UNK_0000_0002 <= (bVar1 & 3));
    unaff_SI[5] = bVar1 & 3;
  }
  return;
}


/* 1000:437a FUN_1000_437a */

undefined4 __cdecl16near FUN_1000_437a(void)

{
  uint uVar1;
  uint uVar2;
  byte bVar3;
  undefined1 uVar4;
  undefined2 in_DX;
  undefined2 uVar5;
  undefined2 unaff_DS;
  bool bVar6;
  
  uVar4 = 0;
  bVar3 = *(byte *)0x89d2 ^ 0xa5 ^ (byte)((uint)*(undefined2 *)0x89d0 >> 8);
  bVar6 = (POPCOUNT(bVar3) & 1U) != 0;
  if (bVar6) {
    uVar4 = 2;
  }
  uVar1 = CONCAT11(bVar6,bVar3);
  uVar2 = CONCAT11((bVar3 & 1) != 0,uVar4) >> 1;
  uVar5 = CONCAT11((byte)(((uint)((bVar3 & 2) != 0) << 8 | uVar2) >> 1) ^ (byte)uVar2 ^
                   (byte)*(undefined2 *)0x89d0,(byte)(uVar1 >> 2) ^ (byte)(uVar1 >> 1));
  *(undefined2 *)0x89d0 = uVar5;
  return CONCAT22(in_DX,uVar5);
}


/* 1000:43b1 FUN_1000_43b1 */

void __cdecl16near FUN_1000_43b1(void)

{
  byte bVar1;
  byte bVar2;
  char cVar3;
  int iVar4;
  int unaff_DI;
  undefined2 unaff_DS;
  
  if (*(char *)(unaff_DI + 8) != '\0') {
    iVar4 = 0x43f9;
    cVar3 = '\b';
    bVar2 = 0x1f;
    if (*(char *)(unaff_DI + 8) != '\x01') {
      iVar4 = 0x4419;
      cVar3 = '\x10';
      bVar2 = 0x3f;
    }
    bVar1 = *(byte *)(unaff_DI + 7);
    *(char *)(unaff_DI + 7) = *(char *)(unaff_DI + 7) + '\x01';
    *(int *)(unaff_DI + 1) = *(int *)(unaff_DI + 1) + (int)*(char *)(iVar4 + (uint)(bVar1 & bVar2));
    *(int *)(unaff_DI + 3) =
         *(int *)(unaff_DI + 3) + (int)*(char *)(iVar4 + (uint)(bVar1 + cVar3 & bVar2));
  }
  return;
}


/* 1000:4459 FUN_1000_4459 */

void __cdecl16near FUN_1000_4459(void)

{
  undefined1 *puVar1;
  undefined1 uVar2;
  undefined2 uVar3;
  char cVar4;
  char in_CL;
  int iVar5;
  int in_BX;
  undefined1 *unaff_DI;
  undefined1 *puVar6;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  
  *(undefined2 *)(unaff_DI + 0x32) = 0;
  unaff_DI[0x34] = 0;
  unaff_DI[0x11] = 0;
  pick_ptr();
  if (*(char *)(in_BX + 10) == '\0') {
    return;
  }
  if (*(uint *)(in_BX + 8) < 0xc9) {
    return;
  }
  *(char *)(in_BX + 10) = *(char *)(in_BX + 10) + -1;
  *(int *)(in_BX + 8) = (int)((undefined *)&UNK_0000_ff9c + *(int *)(in_BX + 8));
  puVar6 = unaff_DI;
  for (iVar5 = 0x3b; iVar5 != 0; iVar5 = iVar5 + -1) {
    puVar1 = puVar6;
    puVar6 = puVar6 + 1;
    *puVar1 = 0;
  }
  uVar2 = *(undefined1 *)(in_BX + 0xb);
  unaff_DI[0x17] = uVar2;
  unaff_DI[0x2b] = uVar2;
  unaff_DI[0x18] = *(undefined1 *)(in_BX + 0xc);
  uVar2 = *(undefined1 *)(in_BX + 5);
  unaff_DI[5] = uVar2;
  unaff_DI[0x31] = uVar2;
  *unaff_DI = 0x80;
  unaff_DI[0x2c] = 0;
  uVar3 = *(undefined2 *)(in_BX + 1);
  *(undefined2 *)(unaff_DI + 1) = uVar3;
  *(undefined2 *)(unaff_DI + 0x2d) = uVar3;
  uVar3 = *(undefined2 *)(in_BX + 3);
  *(undefined2 *)(unaff_DI + 3) = uVar3;
  *(undefined2 *)(unaff_DI + 0x2f) = uVar3;
  unaff_DI[6] = 0;
  unaff_DI[0x2a] = 0;
  cVar4 = FUN_1000_23b3();
  unaff_DI[7] = 5;
  *(undefined2 *)(unaff_DI + 8) = 0x1d4c;
  unaff_DI[0xf] = 99;
  if ((cVar4 != '\x04') && ((*(byte *)&UNK_0000_0012 & 1) == 0)) {
    unaff_DI[7] = 2;
    *(undefined2 *)(unaff_DI + 8) = 3000;
    unaff_DI[0xf] = 0x32;
    if (cVar4 != '\x03') {
      unaff_DI[7] = 0;
      *(undefined2 *)(unaff_DI + 8) = 1000;
      unaff_DI[0xf] = 0x14;
    }
  }
  unaff_DI[10] = in_CL * 'D';
  unaff_DI[0xb] = 0x11;
  unaff_DI[0x29] = 1;
  return;
}


/* 1000:4530 FUN_1000_4530 */

void __cdecl16near FUN_1000_4530(void)

{
  char cVar1;
  byte bVar2;
  byte *in_BX;
  int unaff_SI;
  undefined2 unaff_DS;
  
  if (*(char *)0xa271 != '\x01') {
    FUN_1000_5450();
  }
  *(undefined1 *)0xa274 = *(undefined1 *)0xa26f;
  thunk_FUN_1000_1ec1();
  if ((*in_BX & 0x10) == 0) {
    FUN_1000_2a0c();
    *(int *)0xa297 = unaff_SI;
    *(undefined1 *)0xa360 = *(undefined1 *)(unaff_SI + 5);
    FUN_1000_5464();
    cVar1 = *(char *)(unaff_SI + 0xe);
    *(byte *)0xa299 = *(byte *)0xa299 & 3;
    *(byte *)0xa299 = *(byte *)0xa299 | cVar1 << 2;
    FUN_1000_5711();
    FUN_1000_56b0();
    FUN_1000_575e();
    FUN_1000_5778();
    FUN_1000_57af();
    FUN_1000_57af();
    FUN_1000_568c();
    FUN_1000_5678();
  }
  else {
    *(undefined1 *)0xa299 = 0;
    pick_ptr();
    bVar2 = 0x10;
    if (in_BX[0xd] != 0) {
      bVar2 = in_BX[5];
    }
    *(byte *)0xa360 = bVar2;
    FUN_1000_5464();
  }
  FUN_1000_466f();
  FUN_1000_4c17();
  FUN_1000_50a9();
  FUN_1000_511b();
  blit_screen();
  return;
}


/* 1000:4649 FUN_1000_4649 */

byte __cdecl16near FUN_1000_4649(void)

{
  byte bVar1;
  undefined2 unaff_DS;
  
  bVar1 = *(byte *)&UNK_0000_0015 & 1;
  if (bVar1 == 0) {
    bVar1 = 0x10;
    if ((*(char *)0xa299 != '\0') &&
       (*(char *)0xa299 = *(char *)0xa299 + -1, (*(byte *)0xa299 & 1) != 0)) {
      bVar1 = 0x14;
    }
    out(0x3d9,bVar1);
  }
  return bVar1;
}


/* 1000:466f FUN_1000_466f */

void __cdecl16near FUN_1000_466f(void)

{
  byte bVar1;
  byte *in_BX;
  undefined2 unaff_DS;
  
  thunk_FUN_1000_1ec1();
  if ((*in_BX & 0x10) == 0) {
    FUN_1000_5669();
                    /* WARNING: Subroutine does not return */
    print_cstr();
  }
  FUN_1000_5669();
  pick_ptr();
  if (in_BX[0xd] == 0) {
                    /* WARNING: Subroutine does not return */
    print_cstr();
  }
  if ((*in_BX & 0x80) == 0) {
    bVar1 = *in_BX & 7;
    if (bVar1 == 0) {
                    /* WARNING: Subroutine does not return */
      print_cstr();
    }
    if (bVar1 == 1) {
                    /* WARNING: Subroutine does not return */
      print_cstr();
    }
  }
  else if ((*(byte *)0x89d2 & 1) == 0) {
                    /* WARNING: Subroutine does not return */
    print_cstr();
  }
                    /* WARNING: Subroutine does not return */
  print_cstr();
}


/* 1000:491f FUN_1000_491f */

void __cdecl16near FUN_1000_491f(void)

{
  undefined2 unaff_DS;
  
  *(undefined1 *)0xa29b = 3;
  if ((*(byte *)&UNK_0000_0012 & 1) == 0) {
    FUN_1000_5669();
    FUN_1000_5423();
                    /* WARNING: Subroutine does not return */
    print_cstr();
  }
  FUN_1000_5669();
  if (*(char *)0xa207 == '\0') {
    *(undefined1 *)0xa29b = 2;
  }
  FUN_1000_5423();
                    /* WARNING: Subroutine does not return */
  print_cstr();
}


/* 1000:496e FUN_1000_496e */

void __cdecl16near FUN_1000_496e(void)

{
  char cVar1;
  byte *in_BX;
  undefined2 unaff_DS;
  
  pick_ptr();
  cVar1 = '\0';
  do {
    if ((*in_BX & 0x80) != 0) {
      FUN_1000_5669();
      FUN_1000_557b();
      FUN_1000_557b();
      *(undefined1 *)0xa29b = 1;
      FUN_1000_540e();
      FUN_1000_557b();
      FUN_1000_4b83();
      FUN_1000_4b93();
      FUN_1000_557b();
      FUN_1000_557b();
    }
    cVar1 = cVar1 + '\x01';
    in_BX = in_BX + 0x3b;
  } while (cVar1 != '\x04');
  return;
}


/* 1000:4a3f FUN_1000_4a3f */

/* WARNING: Removing unreachable block (ram,0x00014aed) */
/* WARNING: Removing unreachable block (ram,0x00014ac2) */
/* WARNING: Removing unreachable block (ram,0x00014ad7) */
/* WARNING: Removing unreachable block (ram,0x00014ae9) */
/* WARNING: Removing unreachable block (ram,0x00014aff) */
/* WARNING: Removing unreachable block (ram,0x00014adb) */
/* WARNING: Removing unreachable block (ram,0x00014ac8) */

uint __cdecl16near FUN_1000_4a3f(undefined2 param_1,int param_2)

{
  undefined1 uVar1;
  int iVar2;
  char *pcVar3;
  undefined2 unaff_DS;
  uint uVar4;
  
  *(undefined2 *)&UNK_0000_0128 = 0;
  uVar4 = 0;
  uVar1 = 1;
  if (*(char *)0xa274 != '\0') {
    uVar1 = 2;
  }
  *(undefined1 *)0xa29b = uVar1;
  FUN_1000_5669();
  pcVar3 = (char *)((uVar4 & 0xff) * 0xb + -0x5dda);
  if (*pcVar3 == '\0') {
    return uVar4;
  }
  FUN_1000_5577(pcVar3,uVar4);
  FUN_1000_5577();
  iVar2 = 3;
  do {
    FUN_1000_5577();
    iVar2 = iVar2 + -1;
  } while (iVar2 != 0);
  FUN_1000_5577();
  if (*(char *)(param_2 + -0x7620) == '\0') {
    FUN_1000_540e();
    *(int *)&UNK_0000_0128 = *(int *)&UNK_0000_0128 + 8;
    FUN_1000_5669();
                    /* WARNING: Subroutine does not return */
    print_cstr();
  }
                    /* WARNING: Subroutine does not return */
  print_cstr();
}


/* 1000:4b83 FUN_1000_4b83 */

void FUN_1000_4b83(void)

{
  FUN_1000_557b();
  return;
}


/* 1000:4b93 FUN_1000_4b93 */

void FUN_1000_4b93(void)

{
  uint uVar1;
  int unaff_SI;
  undefined2 unaff_DS;
  
  FUN_1000_557b();
  FUN_1000_557b();
  if (*(byte *)(unaff_SI + 0x16) == 0) {
    FUN_1000_557b();
    return;
  }
  uVar1 = (uint)*(byte *)0xa296;
  do {
    uVar1 = (byte)((char)uVar1 + 2) & 0xe;
  } while ((*(byte *)(uVar1 + 0x4bff) & *(byte *)(unaff_SI + 0x16)) == 0);
  *(undefined1 *)0xa296 = (char)uVar1;
  FUN_1000_557b();
  return;
}


/* 1000:4c17 FUN_1000_4c17 */

void __cdecl16near FUN_1000_4c17(void)

{
  FUN_1000_5236();
  FUN_1000_5026();
  FUN_1000_4d83();
  FUN_1000_4ea6();
  FUN_1000_4ceb();
  FUN_1000_4c33();
  FUN_1000_4eea();
  FUN_1000_4f8e();
  FUN_1000_5058();
  return;
}


/* 1000:4c33 FUN_1000_4c33 */

void __cdecl16near FUN_1000_4c33(void)

{
  byte bVar1;
  int iVar2;
  int iVar3;
  undefined2 unaff_DS;
  
  iVar3 = -0x739c;
  iVar2 = 0x10;
  do {
    bVar1 = *(byte *)(iVar3 + 0x19);
    if (bVar1 != 0) {
      if (3 < bVar1) {
        if ((bVar1 & 0x80) == 0) {
          FUN_1000_4cc6();
        }
        else {
          if (bVar1 < 0x84) goto LAB_1000_4c7a;
          FUN_1000_4c80();
        }
      }
      FUN_1000_535f();
    }
LAB_1000_4c7a:
    iVar3 = iVar3 + 0x3b;
    iVar2 = iVar2 + -1;
    if (iVar2 == 0) {
      return;
    }
  } while( true );
}


/* 1000:4c80 FUN_1000_4c80 */

void __cdecl16near FUN_1000_4c80(void)

{
  byte in_AL;
  
  if ((in_AL < 0x8d) || ((0xc4 < in_AL && (in_AL < 0xca)))) {
    return;
  }
  return;
}


/* 1000:4cc6 FUN_1000_4cc6 */

void __cdecl16near FUN_1000_4cc6(void)

{
  int unaff_DI;
  undefined2 unaff_DS;
  
  if ((*(char *)(unaff_DI + 0x17) == *(char *)0xa274) || ((*(byte *)0x89d2 & 1) == 0)) {
    return;
  }
  return;
}


/* 1000:4ceb FUN_1000_4ceb */

void __cdecl16near FUN_1000_4ceb(void)

{
  byte bVar1;
  int iVar2;
  undefined2 unaff_DS;
  
  bVar1 = 0;
  iVar2 = -0x6fec;
  do {
    if (*(char *)(iVar2 + 0xd) != '\0') {
      if ((*(char *)(iVar2 + 0xd) == '\x04') && (bVar1 != *(byte *)0xa274)) {
        if ((4 < *(byte *)0xa270) || (FUN_1000_535f(), (*(byte *)0x89d2 & 1) != 0)) {
          FUN_1000_535f();
        }
      }
      else {
        FUN_1000_535f();
      }
    }
    iVar2 = iVar2 + 0xe;
    bVar1 = bVar1 + 1;
  } while (bVar1 < 4);
  return;
}


/* 1000:4d83 FUN_1000_4d83 */

void __cdecl16near FUN_1000_4d83(void)

{
  byte bVar1;
  byte bVar2;
  int in_CX;
  byte *unaff_DI;
  undefined2 unaff_DS;
  
  FUN_1000_3225();
  do {
    bVar1 = *(byte *)0xa274 & 3;
    bVar2 = 0x80;
    if (((bVar1 != 0) && (bVar2 = 0x40, bVar1 != 1)) && (bVar2 = 0x20, bVar1 != 2)) {
      bVar2 = 0x10;
    }
    if ((bVar2 & *unaff_DI) != 0) {
      if ((((*unaff_DI & 0xf) != 0) && ((*unaff_DI & 0xf) != 0xf)) && (unaff_DI[6] == 0)) {
        FUN_1000_4e30();
        FUN_1000_535f();
        if (unaff_DI[10] == 0xff) goto LAB_1000_4e25;
      }
      FUN_1000_535f();
    }
LAB_1000_4e25:
    unaff_DI = unaff_DI + 0xb;
    in_CX = in_CX + -1;
    if (in_CX == 0) {
      return;
    }
  } while( true );
}


/* 1000:4e30 FUN_1000_4e30 */

void __cdecl16near FUN_1000_4e30(void)

{
  return;
}


/* 1000:4ea6 FUN_1000_4ea6 */

void __cdecl16near FUN_1000_4ea6(void)

{
  byte bVar1;
  int iVar2;
  char *pcVar3;
  undefined2 unaff_DS;
  
  if (4 < *(byte *)0xa270) {
    return;
  }
  bVar1 = 0;
  pcVar3 = (char *)0x904c;
  do {
    iVar2 = 0x14;
    do {
      if (*pcVar3 != '\0') {
        FUN_1000_535f();
      }
      pcVar3 = pcVar3 + 8;
      iVar2 = iVar2 + -1;
    } while (iVar2 != 0);
    bVar1 = bVar1 + 1;
  } while (bVar1 < 4);
  return;
}


/* 1000:4eea FUN_1000_4eea */

void __cdecl16near FUN_1000_4eea(void)

{
  byte bVar1;
  char cVar2;
  byte *in_BX;
  byte *pbVar3;
  undefined2 unaff_DS;
  undefined1 in_ZF;
  
  pick_ptr();
  cVar2 = '\0';
  pbVar3 = in_BX;
  do {
    FUN_1000_51dd();
    if (((bool)in_ZF) ||
       ((thunk_FUN_1000_1ec1(), (*in_BX & 0xc0) == 0x40 && ((*(byte *)0x89d2 & 1) != 0)))) {
LAB_1000_4f63:
      FUN_1000_535f();
    }
    else {
      FUN_1000_535f();
      thunk_FUN_1000_1ec1();
      bVar1 = *in_BX & 0xc0;
      if (bVar1 != 0) {
        if (bVar1 != 0x80) {
          if ((*(byte *)0x89d2 & 1) == 0) goto LAB_1000_4f66;
          if (bVar1 != 0xc0) goto LAB_1000_4f63;
        }
        if (*(char *)0xa270 == '\a') goto LAB_1000_4f63;
        FUN_1000_52a4();
      }
    }
LAB_1000_4f66:
    if ((((*pbVar3 & 0x80) != 0) && ((*pbVar3 & 0x20) != 0)) && ((pbVar3[0x19] & 0x80) == 0)) {
      FUN_1000_535f();
    }
    pbVar3 = pbVar3 + 0x3b;
    cVar2 = cVar2 + '\x01';
    if (cVar2 == '\x04') {
      return;
    }
    in_ZF = 0;
  } while( true );
}


/* 1000:4f8e FUN_1000_4f8e */

void __cdecl16near FUN_1000_4f8e(void)

{
  int iVar1;
  byte *pbVar2;
  undefined2 unaff_DS;
  bool bVar3;
  
  pbVar2 = (byte *)0x8c64;
  iVar1 = 0x10;
  do {
    bVar3 = *(byte *)0xa274 == pbVar2[0x17];
    if ((!bVar3) &&
       ((FUN_1000_51dd(), bVar3 ||
        (((*(char *)0xa270 != '\a' && (((pbVar2[0x19] & 0xf0) != 0 || ((*pbVar2 & 0x10) == 0)))) &&
         (((*(uint *)(pbVar2 + 8) < 0x3e9 && ((*(byte *)0x89d2 & 2) != 0)) ||
          ((*pbVar2 & 0x44) == 0)))))))) {
      FUN_1000_535f();
      if ((((*pbVar2 & 0x80) != 0) && ((*pbVar2 & 0x20) != 0)) && ((pbVar2[0x19] & 0x80) == 0)) {
        FUN_1000_535f();
      }
    }
    pbVar2 = pbVar2 + 0x3b;
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  return;
}


/* 1000:5026 FUN_1000_5026 */

void __cdecl16near FUN_1000_5026(void)

{
  int iVar1;
  char *pcVar2;
  undefined2 unaff_DS;
  
  if (*(byte *)0xa270 < 5) {
    pcVar2 = (char *)0xa08c;
    iVar1 = 0x30;
    do {
      if (*pcVar2 != '\0') {
        FUN_1000_535f();
      }
      pcVar2 = pcVar2 + 7;
      iVar1 = iVar1 + -1;
    } while (iVar1 != 0);
  }
  return;
}


/* 1000:5058 FUN_1000_5058 */

void __cdecl16near FUN_1000_5058(void)

{
  char cVar1;
  undefined2 unaff_DS;
  
  cVar1 = '\0';
  do {
    FUN_1000_535f();
    cVar1 = cVar1 + '\x01';
  } while (cVar1 != *(char *)&UNK_0000_0001);
  return;
}


/* 1000:50a9 FUN_1000_50a9 */

void __cdecl16near FUN_1000_50a9(void)

{
  byte bVar1;
  char *pcVar2;
  char *pcVar3;
  undefined2 unaff_DS;
  
  bVar1 = *(byte *)0xa274;
  if (*(char *)((uint)bVar1 * 0x28 + -0x7614) != '\0') {
    FUN_1000_5669();
    pcVar3 = (char *)((uint)bVar1 * 0x28 + -0x7612);
    while (pcVar2 = pcVar3, pcVar3 = pcVar3 + 1, *pcVar2 != '\0') {
      FUN_1000_557b();
    }
    FUN_1000_557b();
  }
  pcVar3 = (char *)0xa29f;
  if (*(char *)0xa29e != '\0') {
    FUN_1000_5669();
    while (pcVar2 = pcVar3, pcVar3 = pcVar3 + 1, *pcVar2 != '\0') {
      FUN_1000_557b();
    }
  }
  return;
}


/* 1000:5102 FUN_1000_5102 */

void __cdecl16near FUN_1000_5102(void)

{
  FUN_1000_5188();
  print_inline();
  return;
}


/* 1000:511b FUN_1000_511b */

void __cdecl16near FUN_1000_511b(void)

{
  undefined2 unaff_DS;
  
  if (*(char *)0xa26c == '\0') {
    return;
  }
  if ((*(byte *)0xa26c & 0x80) == 0) {
    if ((*(byte *)0x89d2 & 1) != 0) {
      FUN_1000_5188();
      print_inline();
    }
    return;
  }
  FUN_1000_5188();
  print_inline();
  if (*(char *)0xa271 != '\x01') {
    print_inline();
  }
  return;
}


/* 1000:5188 FUN_1000_5188 */

void __cdecl16near FUN_1000_5188(void)

{
  print_inline();
  return;
}


/* 1000:51dd FUN_1000_51dd */

byte __cdecl16near FUN_1000_51dd(void)

{
  byte bVar1;
  byte *unaff_DI;
  undefined2 unaff_DS;
  
  bVar1 = *unaff_DI;
  if ((bVar1 & 0x80) == 0) {
    bVar1 = 0;
  }
  return bVar1;
}


/* 1000:5236 FUN_1000_5236 */

void __cdecl16near FUN_1000_5236(void)

{
  int iVar1;
  int iVar2;
  byte *in_BX;
  byte *unaff_SI;
  undefined2 unaff_DS;
  
  if (*(char *)0xa270 == '\a') {
    *(undefined2 *)0xa28b = 0;
    *(undefined2 *)0xa28f = 0;
    *(undefined2 *)0xa28d = 0x3fff;
    *(undefined2 *)0xa291 = 0x3fff;
    return;
  }
  thunk_FUN_1000_1ec1();
  if ((*in_BX & 0x10) == 0) {
    FUN_1000_2a0c();
  }
  else {
    pick_ptr();
    unaff_SI = in_BX;
  }
  iVar2 = 100 << (*(byte *)0xa270 & 0x1f);
  iVar1 = *(int *)(unaff_SI + 1);
  *(int *)0xa28b = iVar1 - iVar2;
  *(int *)0xa28d = (iVar1 - iVar2) + iVar2 * 2 + -1;
  iVar1 = *(int *)(unaff_SI + 3);
  *(int *)0xa28f = iVar1 - iVar2;
  *(int *)0xa291 = (iVar1 - iVar2) + iVar2 * 2 + -1;
  return;
}


/* 1000:52a4 FUN_1000_52a4 */

void __cdecl16near FUN_1000_52a4(void)

{
  byte bVar1;
  undefined1 uVar2;
  uint in_AX;
  uint uVar3;
  uint in_CX;
  uint extraout_DX;
  undefined1 in_CF;
  
  FUN_1000_536e();
  if ((bool)in_CF) {
    return;
  }
  uVar3 = in_AX & 0xff;
  bVar1 = (byte)in_AX;
  if (((bVar1 < 6) && (uVar3 = CONCAT11(1,bVar1), 1 < bVar1)) &&
     (uVar3 = CONCAT11(2,bVar1), bVar1 < 4)) {
    uVar3 = CONCAT11(3,bVar1);
  }
  uVar2 = (undefined1)uVar3;
  if (in_CX < 0x14) {
    if (extraout_DX < 0x14) {
      uVar3 = CONCAT11(3,uVar2);
    }
    else if (extraout_DX < 0xb4) {
      uVar3 = uVar3 | 0x100;
    }
    else {
      uVar3 = CONCAT11(1,uVar2);
    }
  }
  else if (in_CX < 0xb4) {
    if (extraout_DX < 0x14) {
      uVar3 = uVar3 | 0x200;
    }
    else if (0xb3 < extraout_DX) {
      uVar3 = uVar3 & 0x1ff;
    }
  }
  else if (extraout_DX < 0x14) {
    uVar3 = CONCAT11(2,uVar2);
  }
  else if (extraout_DX < 0xb4) {
    uVar3 = uVar3 & 0x2ff;
  }
  else {
    uVar3 = uVar3 & 0xff;
  }
  FUN_1000_54ea(uVar3,extraout_DX,in_CX);
  FUN_1000_54ea();
  return;
}


/* 1000:535c thunk_FUN_1000_1ec1 */

void __cdecl16near thunk_FUN_1000_1ec1(void)

{
  return;
}


/* 1000:535f FUN_1000_535f */

void __cdecl16near FUN_1000_535f(void)

{
  int unaff_SI;
  undefined1 in_CF;
  
  FUN_1000_536e();
  if ((!(bool)in_CF) && (unaff_SI != 0x2837)) {
    FUN_1000_54ea();
  }
  return;
}


/* 1000:536e FUN_1000_536e */

void __cdecl16near FUN_1000_536e(void)

{
  int unaff_DI;
  undefined2 unaff_DS;
  bool bVar1;
  
  bVar1 = true;
  if ((*(char *)(unaff_DI + 5) == *(char *)0xa360) && (FUN_1000_53ef(), !bVar1)) {
    FUN_1000_53ef();
  }
  return;
}


/* 1000:53ef FUN_1000_53ef */

void __cdecl16near FUN_1000_53ef(void)

{
  byte bVar1;
  undefined2 in_CX;
  uint in_DX;
  byte bVar2;
  uint in_BX;
  byte bVar3;
  
  bVar2 = (byte)(in_DX >> 8);
  bVar3 = (byte)(in_BX >> 8);
  bVar1 = bVar2 ^ bVar3;
  if ((char)bVar1 < '\0') {
    if (-1 < (char)(bVar1 & bVar2)) {
      return;
    }
  }
  else if (in_BX < in_DX) {
    return;
  }
  if ((char)((byte)((uint)in_CX >> 8) ^ bVar3) < '\0') {
    return;
  }
  return;
}


/* 1000:540e FUN_1000_540e */

void __cdecl16near FUN_1000_540e(void)

{
  int iVar1;
  
  iVar1 = 5;
  do {
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  iVar1 = 5;
  do {
    FUN_1000_5577();
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  return;
}


/* 1000:5415 FUN_1000_5415 */

void __cdecl16near FUN_1000_5415(void)

{
  int iVar1;
  
  iVar1 = 4;
  do {
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  iVar1 = 4;
  do {
    FUN_1000_5577();
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  return;
}


/* 1000:541c FUN_1000_541c */

void __cdecl16near FUN_1000_541c(void)

{
  int iVar1;
  
  iVar1 = 3;
  do {
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  iVar1 = 3;
  do {
    FUN_1000_5577();
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  return;
}


/* 1000:5423 FUN_1000_5423 */

void __cdecl16near FUN_1000_5423(void)

{
  int iVar1;
  
  iVar1 = 2;
  do {
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  iVar1 = 2;
  do {
    FUN_1000_5577();
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  return;
}


/* 1000:5450 FUN_1000_5450 */

void __cdecl16near FUN_1000_5450(void)

{
  undefined2 *puVar1;
  int iVar2;
  undefined2 *puVar3;
  undefined2 unaff_DS;
  
  puVar3 = (undefined2 *)0x39c1;
  for (iVar2 = 0x2370; iVar2 != 0; iVar2 = iVar2 + -1) {
    puVar1 = puVar3;
    puVar3 = puVar3 + 1;
    *puVar1 = 0;
  }
  return;
}


/* 1000:5464 FUN_1000_5464 */

void __cdecl16near FUN_1000_5464(void)

{
  uint *puVar1;
  uint in_AX;
  uint uVar2;
  int iVar3;
  uint *puVar4;
  undefined1 *puVar5;
  uint *puVar6;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  
  puVar4 = (uint *)((in_AX & 3) * 2 + 0x54a8);
  puVar5 = (undefined1 *)0x3f05;
  uVar2 = *puVar4 & 0xf00f;
  iVar3 = 200;
  do {
    *puVar5 = (char)(uVar2 >> 8);
    puVar5[0x31] = (char)uVar2;
    puVar5 = puVar5 + 0x54;
    iVar3 = iVar3 + -1;
  } while (iVar3 != 0);
  puVar6 = (uint *)0x3f05;
  uVar2 = *puVar4;
  for (iVar3 = 0x19; iVar3 != 0; iVar3 = iVar3 + -1) {
    puVar1 = puVar6;
    puVar6 = puVar6 + 1;
    *puVar1 = uVar2;
  }
  puVar4 = (uint *)0x3f59;
  for (iVar3 = 0x19; iVar3 != 0; iVar3 = iVar3 + -1) {
    puVar1 = puVar4;
    puVar4 = puVar4 + 1;
    *puVar1 = uVar2;
  }
  puVar4 = (uint *)0x7ffd;
  for (iVar3 = 0x19; iVar3 != 0; iVar3 = iVar3 + -1) {
    puVar1 = puVar4;
    puVar4 = puVar4 + 1;
    *puVar1 = uVar2;
  }
  puVar4 = (uint *)0x8051;
  for (iVar3 = 0x19; iVar3 != 0; iVar3 = iVar3 + -1) {
    puVar1 = puVar4;
    puVar4 = puVar4 + 1;
    *puVar1 = uVar2;
  }
  return;
}


/* 1000:54b0 blit_screen */

void __cdecl16near blit_screen(void)

{
  undefined2 *puVar1;
  undefined2 *puVar2;
  int iVar3;
  int iVar4;
  undefined2 *puVar5;
  undefined2 *puVar6;
  undefined2 *puVar7;
  undefined2 unaff_DS;
  
  puVar5 = (undefined2 *)0x3f05;
  puVar6 = (undefined2 *)0x0;
  iVar3 = 100;
  do {
    puVar7 = puVar6;
    for (iVar4 = 0x28; iVar4 != 0; iVar4 = iVar4 + -1) {
      puVar2 = puVar7;
      puVar7 = puVar7 + 1;
      puVar1 = puVar5;
      puVar5 = puVar5 + 1;
      *puVar2 = *puVar1;
    }
    puVar5 = puVar5 + 2;
    puVar6 = (undefined2 *)((uint)puVar6 | 0x2000);
    for (iVar4 = 0x28; iVar4 != 0; iVar4 = iVar4 + -1) {
      puVar2 = puVar6;
      puVar6 = puVar6 + 1;
      puVar1 = puVar5;
      puVar5 = puVar5 + 1;
      *puVar2 = *puVar1;
    }
    puVar5 = puVar5 + 2;
    puVar6 = (undefined2 *)((uint)puVar6 ^ 0x2000);
    iVar3 = iVar3 + -1;
  } while (iVar3 != 0);
  return;
}


/* 1000:54e5 FUN_1000_54e5 */

void FUN_1000_54e5(void)

{
  FUN_1000_54ed();
  return;
}


/* 1000:54ea FUN_1000_54ea */

void FUN_1000_54ea(void)

{
  byte *pbVar1;
  byte bVar2;
  byte bVar3;
  uint uVar4;
  uint in_CX;
  byte bVar5;
  uint in_DX;
  uint uVar6;
  char cVar8;
  uint uVar7;
  int iVar9;
  uint *unaff_SI;
  uint *puVar10;
  uint uVar11;
  undefined2 unaff_DS;
  
  bVar2 = ((in_CX >> 1 & 1) != 0) << 1 | (in_CX & 1) != 0;
  iVar9 = (in_DX & 0xff) * 0x54 + 0x39c1;
  uVar7 = *unaff_SI;
  puVar10 = unaff_SI + 1;
  do {
    uVar6 = uVar7;
    uVar11 = in_CX >> 2;
    do {
      uVar4 = CONCAT11((char)*puVar10,0xff);
      uVar4 = uVar4 >> bVar2 * '\x02' | uVar4 << bVar2 * -2 + 0x10;
      if (uVar11 < *(uint *)&UNK_0000_0005) {
        pbVar1 = (byte *)(iVar9 + uVar11 + 1);
        *pbVar1 = *pbVar1 & (byte)uVar4;
        bVar3 = *(byte *)((int)puVar10 + 1) << (bVar2 * -2 + 8 & 0x1f);
        uVar4 = CONCAT11((char)(uVar4 >> 8),bVar3);
        pbVar1 = (byte *)(iVar9 + uVar11 + 1);
        *pbVar1 = *pbVar1 | bVar3;
      }
      if (uVar11 <= *(uint *)&UNK_0000_0005) {
        *(byte *)(iVar9 + uVar11) = *(byte *)(iVar9 + uVar11) & (byte)(uVar4 >> 8);
        *(byte *)(iVar9 + uVar11) =
             *(byte *)(iVar9 + uVar11) | *(byte *)((int)puVar10 + 1) >> bVar2 * '\x02';
      }
      puVar10 = puVar10 + 1;
      uVar11 = uVar11 + 1;
      bVar5 = (byte)uVar6;
      bVar3 = bVar5 - 4;
      uVar6 = (uint)bVar3;
    } while (3 < bVar5 && bVar3 != 0);
    iVar9 = iVar9 + 0x54;
    cVar8 = (char)(uVar7 >> 8) + -1;
    uVar7 = CONCAT11(cVar8,(char)uVar7);
  } while (cVar8 != '\0');
  return;
}


/* 1000:54ed FUN_1000_54ed */

void __cdecl16near FUN_1000_54ed(void)

{
  byte *pbVar1;
  byte bVar2;
  byte bVar3;
  uint uVar4;
  uint in_CX;
  byte bVar5;
  uint in_DX;
  uint uVar6;
  char cVar8;
  uint uVar7;
  int in_BX;
  int iVar9;
  uint *unaff_SI;
  uint *puVar10;
  uint uVar11;
  undefined2 unaff_DS;
  
  bVar2 = ((in_CX >> 1 & 1) != 0) << 1 | (in_CX & 1) != 0;
  iVar9 = in_BX + (in_DX & 0xff) * 0x54;
  uVar7 = *unaff_SI;
  puVar10 = unaff_SI + 1;
  do {
    uVar6 = uVar7;
    uVar11 = in_CX >> 2;
    do {
      uVar4 = CONCAT11((char)*puVar10,0xff);
      uVar4 = uVar4 >> bVar2 * '\x02' | uVar4 << bVar2 * -2 + 0x10;
      if (uVar11 < *(uint *)&UNK_0000_0005) {
        pbVar1 = (byte *)(iVar9 + uVar11 + 1);
        *pbVar1 = *pbVar1 & (byte)uVar4;
        bVar3 = *(byte *)((int)puVar10 + 1) << (bVar2 * -2 + 8 & 0x1f);
        uVar4 = CONCAT11((char)(uVar4 >> 8),bVar3);
        pbVar1 = (byte *)(iVar9 + uVar11 + 1);
        *pbVar1 = *pbVar1 | bVar3;
      }
      if (uVar11 <= *(uint *)&UNK_0000_0005) {
        *(byte *)(iVar9 + uVar11) = *(byte *)(iVar9 + uVar11) & (byte)(uVar4 >> 8);
        *(byte *)(iVar9 + uVar11) =
             *(byte *)(iVar9 + uVar11) | *(byte *)((int)puVar10 + 1) >> bVar2 * '\x02';
      }
      puVar10 = puVar10 + 1;
      uVar11 = uVar11 + 1;
      bVar5 = (byte)uVar6;
      bVar3 = bVar5 - 4;
      uVar6 = (uint)bVar3;
    } while (3 < bVar5 && bVar3 != 0);
    iVar9 = iVar9 + 0x54;
    cVar8 = (char)(uVar7 >> 8) + -1;
    uVar7 = CONCAT11(cVar8,(char)uVar7);
  } while (cVar8 != '\0');
  return;
}


/* 1000:5554 print_cstr */

/* Pops the return address and prints the raw bytes that follow the
   CALL. 00 ends the string. 01-03 set an attribute. Any other byte
   is a character. Execution resumes after the 00. */

void __cdecl16near print_cstr(void)

{
  byte bVar1;
  undefined2 unaff_DS;
  byte *in_stack_00000000;
  
  while( true ) {
    bVar1 = *in_stack_00000000;
    in_stack_00000000 = in_stack_00000000 + 1;
    if (bVar1 == 0) break;
    if (bVar1 < 4) {
      *(byte *)0xa29b = bVar1;
    }
    else {
      FUN_1000_557b();
    }
  }
  return;
}


/* 1000:5577 FUN_1000_5577 */

void FUN_1000_5577(void)

{
  char cVar1;
  uint *puVar2;
  int iVar3;
  byte in_AL;
  uint uVar4;
  uint *puVar5;
  int *piVar6;
  undefined2 unaff_DS;
  
  cVar1 = *(char *)0xa29b;
  puVar2 = (uint *)*(undefined2 *)0xa293;
  *(int *)0xa293 = *(int *)0xa293 + 2;
  iVar3 = *(int *)&UNK_0000_0016;
  if (0x8f < in_AL) {
    FUN_1000_0496();
    return;
  }
  uVar4 = CONCAT11(cVar1 + -1,in_AL);
  if ((char)(cVar1 + -1) != '\0') {
    if ((char)(cVar1 + -2) == '\0') {
      piVar6 = (int *)(iVar3 + CONCAT11(cVar1 + -2,in_AL) * 0x10);
      *puVar2 = *piVar6 << 1;
      puVar2[0x2a] = piVar6[1] << 1;
      puVar2[0x54] = piVar6[2] << 1;
      puVar2[0x7e] = piVar6[3] << 1;
      puVar2[0xa8] = piVar6[4] << 1;
      puVar2[0xd2] = piVar6[5] << 1;
      puVar2[0xfc] = piVar6[6] << 1;
      puVar2[0x126] = piVar6[7] << 1;
      return;
    }
    uVar4 = CONCAT11(cVar1 + -3,in_AL);
    if ((char)(cVar1 + -3) == '\0') {
      puVar5 = (uint *)(iVar3 + uVar4 * 0x10);
      *puVar2 = *puVar5 << 1 | *puVar5;
      puVar2[0x2a] = puVar5[1] << 1 | puVar5[1];
      puVar2[0x54] = puVar5[2] << 1 | puVar5[2];
      puVar2[0x7e] = puVar5[3] << 1 | puVar5[3];
      puVar2[0xa8] = puVar5[4] << 1 | puVar5[4];
      puVar2[0xd2] = puVar5[5] << 1 | puVar5[5];
      puVar2[0xfc] = puVar5[6] << 1 | puVar5[6];
      puVar2[0x126] = puVar5[7] << 1 | puVar5[7];
      return;
    }
  }
  puVar5 = (uint *)(iVar3 + (uVar4 & 0xff) * 0x10);
  *puVar2 = *puVar5;
  puVar2[0x2a] = puVar5[1];
  puVar2[0x54] = puVar5[2];
  puVar2[0x7e] = puVar5[3];
  puVar2[0xa8] = puVar5[4];
  puVar2[0xd2] = puVar5[5];
  puVar2[0xfc] = puVar5[6];
  puVar2[0x126] = puVar5[7];
  return;
}


/* 1000:557b FUN_1000_557b */

void __cdecl16near FUN_1000_557b(void)

{
  uint *puVar1;
  int iVar2;
  byte bVar3;
  undefined2 in_AX;
  char cVar5;
  uint uVar4;
  uint *puVar6;
  int *piVar7;
  undefined2 unaff_DS;
  
  puVar1 = (uint *)*(undefined2 *)0xa293;
  *(int *)0xa293 = *(int *)0xa293 + 2;
  iVar2 = *(int *)&UNK_0000_0016;
  bVar3 = (byte)in_AX;
  if (0x8f < bVar3) {
    FUN_1000_0496();
    return;
  }
  cVar5 = (char)((uint)in_AX >> 8);
  uVar4 = CONCAT11(cVar5 + -1,bVar3);
  if ((char)(cVar5 + -1) != '\0') {
    if ((char)(cVar5 + -2) == '\0') {
      piVar7 = (int *)(iVar2 + CONCAT11(cVar5 + -2,bVar3) * 0x10);
      *puVar1 = *piVar7 << 1;
      puVar1[0x2a] = piVar7[1] << 1;
      puVar1[0x54] = piVar7[2] << 1;
      puVar1[0x7e] = piVar7[3] << 1;
      puVar1[0xa8] = piVar7[4] << 1;
      puVar1[0xd2] = piVar7[5] << 1;
      puVar1[0xfc] = piVar7[6] << 1;
      puVar1[0x126] = piVar7[7] << 1;
      return;
    }
    uVar4 = CONCAT11(cVar5 + -3,bVar3);
    if ((char)(cVar5 + -3) == '\0') {
      puVar6 = (uint *)(iVar2 + uVar4 * 0x10);
      *puVar1 = *puVar6 << 1 | *puVar6;
      puVar1[0x2a] = puVar6[1] << 1 | puVar6[1];
      puVar1[0x54] = puVar6[2] << 1 | puVar6[2];
      puVar1[0x7e] = puVar6[3] << 1 | puVar6[3];
      puVar1[0xa8] = puVar6[4] << 1 | puVar6[4];
      puVar1[0xd2] = puVar6[5] << 1 | puVar6[5];
      puVar1[0xfc] = puVar6[6] << 1 | puVar6[6];
      puVar1[0x126] = puVar6[7] << 1 | puVar6[7];
      return;
    }
  }
  puVar6 = (uint *)(iVar2 + (uVar4 & 0xff) * 0x10);
  *puVar1 = *puVar6;
  puVar1[0x2a] = puVar6[1];
  puVar1[0x54] = puVar6[2];
  puVar1[0x7e] = puVar6[3];
  puVar1[0xa8] = puVar6[4];
  puVar1[0xd2] = puVar6[5];
  puVar1[0xfc] = puVar6[6];
  puVar1[0x126] = puVar6[7];
  return;
}


/* 1000:5669 FUN_1000_5669 */

undefined2 __cdecl16near FUN_1000_5669(void)

{
  undefined2 in_AX;
  int in_CX;
  byte in_DL;
  undefined2 unaff_DS;
  
  *(int *)0xa293 = (uint)in_DL * 0x54 + in_CX + 0x3f01;
  return in_AX;
}


/* 1000:5678 FUN_1000_5678 */

void __cdecl16near FUN_1000_5678(void)

{
  undefined2 unaff_DS;
  
  if ((*(byte *)&UNK_0000_0014 & 3) != 0) {
    FUN_1000_54e5();
  }
  return;
}


/* 1000:568c FUN_1000_568c */

void __cdecl16near FUN_1000_568c(void)

{
  undefined2 unaff_DS;
  
  if (((*(byte *)(*(int *)0xa297 + 0x29) & 1) != 0) &&
     (((*(byte *)(*(int *)0xa297 + 0x29) & 2) == 0 || ((*(byte *)0x89d2 & 1) != 0)))) {
    FUN_1000_54e5();
  }
  return;
}


/* 1000:56b0 FUN_1000_56b0 */

void __cdecl16near FUN_1000_56b0(void)

{
  FUN_1000_54e5();
  FUN_1000_54e5();
  FUN_1000_54e5();
  return;
}


/* 1000:5711 FUN_1000_5711 */

void __cdecl16near FUN_1000_5711(void)

{
  undefined2 in_AX;
  
  FUN_1000_54e5();
  FUN_1000_54e5(in_AX);
  FUN_1000_54e5();
  return;
}


/* 1000:575e FUN_1000_575e */

void __cdecl16near FUN_1000_575e(void)

{
  char in_AL;
  
  do {
    if (in_AL == '\0') {
      return;
    }
    FUN_1000_54e5();
    in_AL = in_AL + -1;
  } while (in_AL != '\0');
  return;
}


/* 1000:5778 FUN_1000_5778 */

void __cdecl16near FUN_1000_5778(void)

{
  byte in_AL;
  byte bVar1;
  int iVar2;
  
  bVar1 = in_AL;
  if (10 < in_AL) {
    bVar1 = 9;
  }
  iVar2 = 0x4b;
  do {
    if (bVar1 == 0) break;
    FUN_1000_54e5();
    iVar2 = iVar2 + 8;
    if (iVar2 == 0x73) {
      iVar2 = 0x4b;
    }
    bVar1 = bVar1 - 1;
  } while (bVar1 != 0);
  if (10 < in_AL) {
    FUN_1000_54e5();
  }
  return;
}


/* 1000:57af FUN_1000_57af */

void __cdecl16near FUN_1000_57af(void)

{
  byte bVar1;
  uint in_AX;
  int iVar2;
  int in_DX;
  int iVar3;
  
  FUN_1000_54e5();
  iVar3 = in_DX + 1;
  iVar2 = 10;
  while (bVar1 = (byte)in_AX, bVar1 != 0) {
    if (bVar1 < 4) {
      in_AX = 0;
    }
    else {
      in_AX = (uint)(byte)(bVar1 - 4);
    }
    FUN_1000_54e5(iVar2,iVar3,in_AX,in_DX);
    iVar2 = iVar2 + 4;
  }
  FUN_1000_54e5();
  return;
}


/* 1000:57fb print_inline */

/* Pops the return address and executes an encoded screen script that
   follows the CALL. The first word is a key. Each later byte is
   decoded as plain = byte - key, key = key - plain.
   00 and FF end the script. Bytes above 10h are characters.
   04 and 05 consume 6 and 4 raw operand bytes. Execution resumes
   at the byte after the terminator (fallthrough is overridden). */

void __cdecl16near print_inline(void)

{
  undefined2 unaff_DS;
  
  *(undefined1 *)0xa264 = 1;
  exec_script();
  return;
}


/* 1000:580c FUN_1000_580c */

void FUN_1000_580c(void)

{
  undefined2 *puVar1;
  undefined2 *puVar2;
  byte bVar3;
  int iVar4;
  undefined2 *puVar5;
  undefined2 *puVar6;
  undefined2 unaff_DS;
  
  *(undefined1 *)0xa264 = 2;
  while( true ) {
    bVar3 = decode_script_byte();
    if (bVar3 == 0xff) {
      return;
    }
    if (bVar3 == 0) break;
    if (bVar3 < 0x11) {
      if (bVar3 < 4) {
        *(byte *)0xa29b = bVar3;
      }
      else if (bVar3 == 4) {
        *(undefined2 *)&UNK_0000_0005 = 0x50;
        FUN_1000_54ed();
        *(undefined2 *)&UNK_0000_0005 = 0x35;
      }
      else if (bVar3 == 5) {
        FUN_1000_5669();
      }
      else if (bVar3 == 7) {
        FUN_1000_58ff();
      }
      else if (bVar3 == 0xd) {
        *(int *)0xa293 = ((*(int *)0xa293 + 0xc0fbU) / 0x2f4) * 0x2f4 + 0x3f05;
      }
      else if (bVar3 == 10) {
        if (*(int *)0xa293 + 0x2f4U < 0x7e05) {
          *(uint *)0xa293 = *(int *)0xa293 + 0x2f4U;
        }
        else {
          puVar5 = (undefined2 *)0x41f5;
          puVar6 = (undefined2 *)0x3f01;
          for (iVar4 = 0x1f02; iVar4 != 0; iVar4 = iVar4 + -1) {
            puVar2 = puVar6;
            puVar6 = puVar6 + 1;
            puVar1 = puVar5;
            puVar5 = puVar5 + 1;
            *puVar2 = *puVar1;
          }
          for (iVar4 = 0x17a; iVar4 != 0; iVar4 = iVar4 + -1) {
            puVar1 = puVar6;
            puVar6 = puVar6 + 1;
            *puVar1 = 0;
          }
        }
      }
      else if (bVar3 == 0xb) {
        FUN_1000_5450();
        *(undefined2 *)0xa293 = 0x3f05;
      }
      else if (bVar3 == 0xc) {
        *(undefined2 *)0xa293 = 0x3f05;
      }
    }
    else {
      FUN_1000_557b();
    }
  }
  blit_screen();
  return;
}


/* 1000:5815 exec_script */

void __cdecl16near exec_script(void)

{
  undefined2 *puVar1;
  undefined2 *puVar2;
  byte bVar3;
  int iVar4;
  undefined2 *puVar5;
  undefined2 *puVar6;
  undefined2 unaff_DS;
  
  while( true ) {
    bVar3 = decode_script_byte();
    if (bVar3 == 0xff) {
      return;
    }
    if (bVar3 == 0) break;
    if (bVar3 < 0x11) {
      if (bVar3 < 4) {
        *(byte *)0xa29b = bVar3;
      }
      else if (bVar3 == 4) {
        *(undefined2 *)&UNK_0000_0005 = 0x50;
        FUN_1000_54ed();
        *(undefined2 *)&UNK_0000_0005 = 0x35;
      }
      else if (bVar3 == 5) {
        FUN_1000_5669();
      }
      else if (bVar3 == 7) {
        FUN_1000_58ff();
      }
      else if (bVar3 == 0xd) {
        *(int *)0xa293 = ((*(int *)0xa293 + 0xc0fbU) / 0x2f4) * 0x2f4 + 0x3f05;
      }
      else if (bVar3 == 10) {
        if (*(int *)0xa293 + 0x2f4U < 0x7e05) {
          *(uint *)0xa293 = *(int *)0xa293 + 0x2f4U;
        }
        else {
          puVar5 = (undefined2 *)0x41f5;
          puVar6 = (undefined2 *)0x3f01;
          for (iVar4 = 0x1f02; iVar4 != 0; iVar4 = iVar4 + -1) {
            puVar2 = puVar6;
            puVar6 = puVar6 + 1;
            puVar1 = puVar5;
            puVar5 = puVar5 + 1;
            *puVar2 = *puVar1;
          }
          for (iVar4 = 0x17a; iVar4 != 0; iVar4 = iVar4 + -1) {
            puVar1 = puVar6;
            puVar6 = puVar6 + 1;
            *puVar1 = 0;
          }
        }
      }
      else if (bVar3 == 0xb) {
        FUN_1000_5450();
        *(undefined2 *)0xa293 = 0x3f05;
      }
      else if (bVar3 == 0xc) {
        *(undefined2 *)0xa293 = 0x3f05;
      }
    }
    else {
      FUN_1000_557b();
    }
  }
  blit_screen();
  return;
}


/* 1000:58ff FUN_1000_58ff */

void __cdecl16near FUN_1000_58ff(void)

{
  FUN_1000_1a97();
  return;
}


/* 1000:596c decode_script_byte */

void __cdecl16near decode_script_byte(void)

{
  int iVar1;
  char in_AL;
  int *in_BX;
  undefined2 unaff_DS;
  
  if (*(char *)0xa264 != '\x02') {
    if (*(char *)0xa264 == '\x01') {
      *(undefined1 *)0xa264 = 0;
      iVar1 = *in_BX;
      *(undefined1 *)0xa265 = (char)((int)in_BX + iVar1);
      *(uint *)0xa201 = *(uint *)0xa201 | (int)in_BX + iVar1 + 0x1357U;
      in_AL = (char)in_BX[1];
    }
    *(char *)0xa265 = *(char *)0xa265 - (in_AL - *(char *)0xa265);
  }
  return;
}


/* 1000:59a0 FUN_1000_59a0 */

undefined2 __cdecl16near FUN_1000_59a0(void)

{
  undefined *puVar1;
  char *pcVar2;
  undefined1 *puVar3;
  char *pcVar4;
  byte bVar5;
  char cVar6;
  int iVar7;
  undefined1 extraout_DL;
  undefined1 extraout_DL_00;
  undefined2 uVar8;
  byte bVar9;
  undefined *puVar10;
  char *pcVar11;
  undefined1 *puVar12;
  char *pcVar13;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  undefined1 uVar14;
  undefined1 uVar15;
  bool bVar16;
  
code_r0x000159a0:
  print_inline();
  FUN_1000_5cfb();
  do {
    FUN_1000_0c4c();
    *(undefined1 *)0xa26f = 0;
    uVar8 = 0x415a;
    uVar15 = 0;
    if ((*(byte *)0xa486 & 1) != 0) {
      *(undefined1 *)0xa26f = 1;
      uVar8 = 0x5a41;
    }
    while( true ) {
      do {
        uVar14 = uVar15;
        FUN_1000_5cfb();
        FUN_1000_0b45();
        FUN_1000_5eb8();
        bVar5 = FUN_1000_5e8c();
        uVar15 = 1;
      } while ((bool)uVar14);
      if (bVar5 == (byte)uVar8) {
        FUN_1000_5eb8();
        *(undefined1 *)0xa254 = 0x36;
        goto LAB_1000_5a2b;
      }
      bVar9 = (byte)((uint)uVar8 >> 8);
      uVar15 = bVar5 < bVar9;
      if (bVar5 == bVar9) break;
      FUN_1000_0c4c();
    }
LAB_1000_5a06:
    print_inline();
  } while( true );
LAB_1000_5a2b:
  uVar15 = 0;
  if (*(char *)0xa254 == '\0') goto LAB_1000_5a06;
  FUN_1000_0b45();
  bVar5 = FUN_1000_5e8c();
  if (((bool)uVar15) || (uVar15 = bVar5 < 0xa0, bVar5 != 0xa0)) goto LAB_1000_5a2b;
  FUN_1000_5eb8();
  do {
    uVar14 = uVar15;
    FUN_1000_0b45();
    bVar5 = FUN_1000_5e8c();
    uVar15 = 1;
  } while ((bool)uVar14);
  if (bVar5 != *(byte *)0x39c0) {
    if (*(byte *)0x39c0 < bVar5) {
      print_inline();
    }
    else {
      print_inline();
    }
    print_inline();
    goto LAB_1000_5cf6;
  }
  if ((*(byte *)0xa26f & 1) == 0) {
    FUN_1000_5d0c();
    FUN_1000_5d0c();
    FUN_1000_5d0c();
    FUN_1000_5d0c();
    FUN_1000_5d0c();
    FUN_1000_5d0c();
    FUN_1000_5d0c();
    FUN_1000_5eb8();
    FUN_1000_5eb8();
    uVar8 = 0;
    uVar15 = FUN_1000_5d14();
    *(undefined1 *)0xa483 = uVar15;
    FUN_1000_5d14();
    uVar15 = FUN_1000_5d14();
    *(undefined2 *)0xa484 = CONCAT11(uVar15,extraout_DL_00);
    puVar12 = (undefined1 *)0xa226;
    puVar10 = (undefined *)&UNK_0000_0007;
    for (iVar7 = 3; iVar7 != 0; iVar7 = iVar7 + -1) {
      puVar3 = puVar12;
      puVar12 = puVar12 + 1;
      puVar1 = puVar10;
      puVar10 = puVar10 + 1;
      *puVar3 = *puVar1;
    }
    puVar12[1] = *(undefined *)&UNK_0000_0010;
    uVar15 = FUN_1000_5d14();
    *(undefined1 *)0xa231 = uVar15;
    uVar15 = FUN_1000_5d14();
    *(undefined1 *)0xa232 = uVar15;
    uVar15 = FUN_1000_5d14();
    *(undefined1 *)0xa233 = uVar15;
    uVar15 = FUN_1000_5d14();
    *(undefined1 *)0xa235 = uVar15;
    cVar6 = FUN_1000_5d14();
    if ((cVar6 != (char)uVar8) || (cVar6 = FUN_1000_5d14(), cVar6 != (char)((uint)uVar8 >> 8)))
    goto code_r0x000159a0;
    FUN_1000_5eb8();
  }
  else {
    uVar8 = 0;
    uVar15 = FUN_1000_5d14();
    *(undefined1 *)0xa483 = uVar15;
    FUN_1000_5d14();
    uVar15 = FUN_1000_5d14();
    *(undefined2 *)0x89d0 = CONCAT11(uVar15,extraout_DL);
    *(undefined2 *)0xa484 = CONCAT11(uVar15,extraout_DL);
    puVar12 = (undefined1 *)0xa231;
    puVar10 = (undefined *)&UNK_0000_0007;
    for (iVar7 = 3; iVar7 != 0; iVar7 = iVar7 + -1) {
      puVar3 = puVar12;
      puVar12 = puVar12 + 1;
      puVar1 = puVar10;
      puVar10 = puVar10 + 1;
      *puVar3 = *puVar1;
    }
    puVar12[1] = *(undefined *)&UNK_0000_0010;
    uVar15 = FUN_1000_5d14();
    *(undefined1 *)0xa226 = uVar15;
    uVar15 = FUN_1000_5d14();
    *(undefined1 *)0xa227 = uVar15;
    uVar15 = FUN_1000_5d14();
    *(undefined1 *)0xa228 = uVar15;
    uVar15 = FUN_1000_5d14();
    *(undefined1 *)0xa22a = uVar15;
    cVar6 = FUN_1000_5d14();
    if ((cVar6 != (char)uVar8) || (cVar6 = FUN_1000_5d14(), cVar6 != (char)((uint)uVar8 >> 8)))
    goto code_r0x000159a0;
    FUN_1000_5d0c();
    FUN_1000_5d0c();
    FUN_1000_5d0c();
    FUN_1000_5d0c();
    FUN_1000_5d0c();
    FUN_1000_5d0c();
    FUN_1000_5d0c();
    FUN_1000_5eb8();
    FUN_1000_5eb8();
    cVar6 = FUN_1000_5d14();
    if (cVar6 != '@') goto code_r0x000159a0;
  }
  if (*(int *)0x89d0 != *(int *)0xa484) goto code_r0x000159a0;
  pcVar11 = (char *)0xa226;
  pcVar13 = (char *)0xa231;
  iVar7 = 3;
  bVar16 = true;
  do {
    if (iVar7 == 0) break;
    iVar7 = iVar7 + -1;
    pcVar4 = pcVar13;
    pcVar13 = pcVar13 + 1;
    pcVar2 = pcVar11;
    pcVar11 = pcVar11 + 1;
    bVar16 = *pcVar2 == *pcVar4;
  } while (bVar16);
  if (!bVar16) {
    *(byte *)&UNK_0000_0012 = *(byte *)&UNK_0000_0012 & *(byte *)0xa483;
    uVar8 = 0x202;
    if (((*(byte *)&UNK_0000_0012 & 8) == 0) && (uVar8 = 0x102, (*(byte *)&UNK_0000_0012 & 4) == 0))
    {
      uVar8 = 2;
    }
    return uVar8;
  }
  print_inline();
LAB_1000_5cf6:
  do {
    FUN_1000_0b45();
  } while( true );
}


/* 1000:5cfb FUN_1000_5cfb */

void __cdecl16near FUN_1000_5cfb(void)

{
  undefined2 unaff_DS;
  
  *(undefined1 *)0xa254 = 10;
  do {
    *(char *)0xa486 = *(char *)0xa486 + '\x01';
  } while (*(char *)0xa254 != '\0');
  return;
}


/* 1000:5d0c FUN_1000_5d0c */

void FUN_1000_5d0c(void)

{
  FUN_1000_62e9();
  FUN_1000_5eb8();
  return;
}


/* 1000:5d14 FUN_1000_5d14 */

undefined2 __cdecl16near FUN_1000_5d14(void)

{
  undefined2 uVar1;
  undefined1 in_CF;
  undefined1 uVar2;
  
  do {
    uVar2 = in_CF;
    FUN_1000_0b45();
    uVar1 = FUN_1000_5e8c();
    in_CF = 1;
  } while ((bool)uVar2);
  FUN_1000_62e9();
  return uVar1;
}


/* 1000:5d22 FUN_1000_5d22 */

void __cdecl16near FUN_1000_5d22(void)

{
  undefined1 *puVar1;
  undefined1 *puVar2;
  int iVar3;
  undefined1 *puVar4;
  undefined1 *puVar5;
  undefined1 *puVar6;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  
  *(undefined2 *)0xa255 = 0x21c;
  do {
    FUN_1000_178f();
    if ((*(byte *)0xa20c & 1) != 0) {
      puVar5 = (undefined1 *)0xa20d;
      puVar4 = (undefined1 *)0xa47c;
      if ((*(byte *)0xa26f & 1) != 0) {
        puVar5 = (undefined1 *)0xa47c;
        puVar4 = (undefined1 *)0xa20d;
      }
      puVar6 = (undefined1 *)0xa212;
      for (iVar3 = 4; iVar3 != 0; iVar3 = iVar3 + -1) {
        puVar2 = puVar6;
        puVar6 = puVar6 + 1;
        puVar1 = puVar5;
        puVar5 = puVar5 + 1;
        *puVar2 = *puVar1;
      }
      *puVar6 = 1;
      for (iVar3 = 4; puVar6 = puVar6 + 1, iVar3 != 0; iVar3 = iVar3 + -1) {
        puVar1 = puVar4;
        puVar4 = puVar4 + 1;
        *puVar6 = *puVar1;
      }
      *puVar6 = 1;
      return;
    }
  } while (*(int *)0xa255 != 0);
  print_inline();
  do {
    FUN_1000_0b45();
  } while( true );
}


/* 1000:5dd6 FUN_1000_5dd6 */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void __cdecl16near FUN_1000_5dd6(void)

{
  undefined2 unaff_CS;
  undefined2 unaff_DS;
  
  if (*(int *)&UNK_0000_00a7 == 0) {
    return;
  }
  if ((*(byte *)&UNK_0000_000c & 1) == 0) {
                    /* WARNING: Read-only address (ram,0x00000030) is written */
    _UNK_0000_0030 = 0x5eea;
    _UNK_0000_0032 = unaff_CS;
                    /* WARNING: Read-only address (ram,0x00000032) is written */
  }
  else {
                    /* WARNING: Read-only address (ram,0x0000002c) is written */
    _UNK_0000_002c = 0x5eea;
                    /* WARNING: Read-only address (ram,0x0000002e) is written */
    _UNK_0000_002e = unaff_CS;
  }
  FUN_1000_5e0e();
  FUN_1000_5f7b();
  return;
}


/* 1000:5e0e FUN_1000_5e0e */

void __cdecl16near FUN_1000_5e0e(void)

{
  int iVar1;
  byte bVar2;
  int iVar3;
  undefined2 unaff_DS;
  
  out(*(int *)&UNK_0000_00a7 + 3,0x80);
  iVar3 = (*(byte *)&UNK_0000_000b & 7) * 4;
  iVar1 = *(int *)&UNK_0000_00a7;
  out(iVar1 + 1,*(undefined1 *)(iVar3 + 0x3977));
  out(iVar1,*(undefined1 *)(iVar3 + 0x3976));
  out(iVar1 + 3,3);
  iVar3 = 0;
  do {
    in(iVar1);
    iVar3 = iVar3 + -1;
  } while (iVar3 != 0);
  in(iVar1 + 6);
  in(iVar1 + 6);
  out(iVar1 + 4,0xb);
  out(iVar1 + 1,3);
  in(iVar1 + 2);
  if ((*(byte *)&UNK_0000_000c & 1) == 0) {
    bVar2 = (*(byte *)0xa200 | 0x18) & 0xef;
  }
  else {
    bVar2 = (*(byte *)0xa200 | 0x18) & 0xf7;
  }
  *(byte *)0xa200 = bVar2;
  out(0x21,bVar2);
  return;
}


/* 1000:5e7f FUN_1000_5e7f */

void __cdecl16near FUN_1000_5e7f(void)

{
  byte bVar1;
  undefined2 unaff_DS;
  
  bVar1 = *(byte *)0xa200;
  *(byte *)0xa200 = bVar1 | 0x18;
  out(0x21,bVar1 | 0x18);
  return;
}


/* 1000:5e8c FUN_1000_5e8c */

void __cdecl16near FUN_1000_5e8c(void)

{
  FUN_1000_5e92();
  return;
}


/* 1000:5e92 FUN_1000_5e92 */

undefined1 __cdecl16near FUN_1000_5e92(void)

{
  undefined1 uVar1;
  undefined1 *puVar2;
  undefined2 unaff_DS;
  
  uVar1 = 0;
  if (*(int *)0x3970 != 0) {
    puVar2 = (undefined1 *)*(undefined2 *)0x3974 + 1;
    uVar1 = *(undefined1 *)*(undefined2 *)0x3974;
    *(int *)0x3970 = *(int *)0x3970 + -1;
    if (puVar2 == (undefined1 *)0xa470) {
      puVar2 = (undefined1 *)0xa370;
    }
    *(int *)0x3974 = (int)puVar2;
  }
  return uVar1;
}


/* 1000:5eb8 FUN_1000_5eb8 */

void __cdecl16near FUN_1000_5eb8(void)

{
  undefined1 in_CF;
  undefined1 uVar1;
  
  do {
    uVar1 = in_CF;
    FUN_1000_5ebe();
    in_CF = 1;
  } while ((bool)uVar1);
  return;
}


/* 1000:5ebe FUN_1000_5ebe */

undefined4 __cdecl16near FUN_1000_5ebe(void)

{
  byte bVar1;
  undefined2 in_AX;
  undefined2 in_DX;
  undefined2 unaff_DS;
  
  bVar1 = in(*(int *)&UNK_0000_00a7 + 5);
  if ((bVar1 & 0x20) != 0) {
    out(*(int *)&UNK_0000_00a7,(char)in_AX);
  }
  return CONCAT22(in_DX,in_AX);
}


/* 1000:5ed7 FUN_1000_5ed7 */

undefined4 __cdecl16near FUN_1000_5ed7(void)

{
  undefined2 in_AX;
  undefined2 in_DX;
  undefined2 unaff_DS;
  
  in(*(int *)&UNK_0000_00a7 + 6);
  return CONCAT22(in_DX,in_AX);
}


/* 1000:5f7b FUN_1000_5f7b */

undefined4 __cdecl16near FUN_1000_5f7b(void)

{
  undefined2 in_AX;
  int iVar1;
  undefined2 in_DX;
  undefined2 unaff_DS;
  
  *(undefined2 *)0x3974 = 0xa370;
  *(undefined2 *)0x3972 = 0xa370;
  *(undefined2 *)0x3970 = 0;
  iVar1 = 500;
  do {
    in(*(undefined2 *)&UNK_0000_00a7);
    iVar1 = iVar1 + -1;
  } while (iVar1 != 0);
  return CONCAT22(in_DX,in_AX);
}


/* 1000:5fa0 FUN_1000_5fa0 */

void __cdecl16near FUN_1000_5fa0(void)

{
  undefined1 *puVar1;
  undefined1 *puVar2;
  char cVar3;
  byte bVar4;
  int iVar5;
  undefined2 uVar6;
  byte bVar7;
  undefined1 *puVar8;
  undefined1 *puVar9;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  undefined1 uVar10;
  
  if (*(char *)&UNK_0000_000a != '\x02') {
    *(undefined2 *)0xa209 = 0;
    return;
  }
  *(undefined1 *)0xa470 = 0;
  iVar5 = (*(byte *)&UNK_0000_000b & 7) * 4;
  if ((*(byte *)0xa26f & 1) == 0) {
    *(undefined1 *)0xa482 = *(undefined1 *)(iVar5 + 0x3979);
    *(undefined1 *)0xa481 = 0x1e;
LAB_1000_5ff1:
    *(undefined2 *)0xa209 = 0x5ff1;
    if (*(char *)0xa20c != -0x80) {
      return;
    }
    do {
      uVar10 = false;
      puVar8 = (undefined1 *)0xa20d;
      puVar9 = (undefined1 *)0xa474;
      for (iVar5 = 4; iVar5 != 0; iVar5 = iVar5 + -1) {
        puVar2 = puVar9;
        puVar9 = puVar9 + 1;
        puVar1 = puVar8;
        puVar8 = puVar8 + 1;
        *puVar2 = *puVar1;
      }
      *(undefined1 *)0xa20c = 0;
      *(undefined2 *)0xa209 = 0x600f;
      FUN_1000_5ebe();
      if ((bool)uVar10) {
        return;
      }
      *(undefined2 *)0xa471 = 0;
      FUN_1000_62dd();
      *(undefined2 *)0xa209 = 0x6026;
      FUN_1000_5ebe();
      if ((bool)uVar10) {
        return;
      }
      FUN_1000_62dd();
      *(undefined2 *)0xa209 = 0x6037;
      FUN_1000_5ebe();
      if ((bool)uVar10) {
        return;
      }
      FUN_1000_62dd();
      *(undefined2 *)0xa209 = 0x6048;
      FUN_1000_5ebe();
      if ((bool)uVar10) {
        return;
      }
      FUN_1000_62dd();
      *(undefined2 *)0xa209 = 0x6059;
      FUN_1000_5ebe();
      if ((bool)uVar10) {
        return;
      }
      FUN_1000_62dd();
      *(undefined2 *)0xa209 = 0x606a;
      FUN_1000_5ebe();
      if ((bool)uVar10) {
        return;
      }
      FUN_1000_62dd();
      *(undefined2 *)0xa209 = 0x607b;
      FUN_1000_5ebe();
      if ((bool)uVar10) {
        return;
      }
      *(undefined2 *)0xa209 = 0x6089;
      FUN_1000_5ebe();
      if ((bool)uVar10) {
        return;
      }
      *(undefined1 *)0xa254 = *(undefined1 *)0xa481;
      *(undefined1 *)0xa481 = *(undefined1 *)0xa482;
      *(undefined2 *)0xa209 = 0x60a3;
      bVar4 = FUN_1000_5e92();
      if ((bool)uVar10) {
        uVar10 = 0;
        if (*(char *)0xa254 != '\0') {
          return;
        }
      }
      else {
        uVar10 = bVar4 < *(byte *)0xa470;
        if (bVar4 == *(byte *)0xa470) {
          *(undefined2 *)0xa209 = 0x60bf;
          uVar10 = 0;
          if (*(char *)0xa254 != '\0') {
            if (*(uint *)0x3970 < 7) {
              return;
            }
            uVar6 = 0;
            FUN_1000_62e9();
            uVar10 = FUN_1000_5e92();
            *(undefined1 *)0xa478 = uVar10;
            FUN_1000_62e9();
            uVar10 = FUN_1000_5e92();
            *(undefined1 *)0xa479 = uVar10;
            FUN_1000_62e9();
            uVar10 = FUN_1000_5e92();
            *(undefined1 *)0xa47a = uVar10;
            FUN_1000_62e9();
            uVar10 = FUN_1000_5e92();
            *(undefined1 *)0xa47b = uVar10;
            FUN_1000_62e9();
            uVar10 = FUN_1000_5e92();
            *(undefined1 *)0xa480 = uVar10;
            FUN_1000_62e9();
            bVar4 = FUN_1000_5e92();
            uVar10 = bVar4 < (byte)uVar6;
            if (bVar4 == (byte)uVar6) {
              bVar4 = FUN_1000_5e92();
              bVar7 = (byte)((uint)uVar6 >> 8);
              uVar10 = bVar4 < bVar7;
              if ((bVar4 == bVar7) &&
                 (uVar10 = *(byte *)0xa26f < *(byte *)0xa480, *(byte *)0xa26f != *(byte *)0xa480))
              goto code_r0x00016120;
            }
          }
        }
      }
      do {
        *(undefined2 *)0xa209 = 0x6138;
        FUN_1000_62cf();
        FUN_1000_5e92();
      } while (!(bool)uVar10);
      if (*(char *)0xa254 != '\0') {
        return;
      }
    } while( true );
  }
  uVar10 = *(undefined1 *)(iVar5 + 0x3978);
  *(undefined1 *)0xa482 = uVar10;
  *(undefined1 *)0xa481 = uVar10;
LAB_1000_6151:
  do {
    while( true ) {
      *(undefined2 *)0xa209 = 0x6151;
      if (*(int *)0x3970 == 0) {
        return;
      }
      *(undefined1 *)0xa254 = *(undefined1 *)0xa481;
      *(undefined2 *)0xa209 = 0x6164;
      if (7 < *(uint *)0x3970) break;
      if (*(char *)0xa254 != '\0') {
        return;
      }
    }
    uVar6 = 0;
    cVar3 = FUN_1000_5e92();
    *(undefined1 *)0xa473 = 0;
    if (cVar3 == *(char *)0xa470) {
LAB_1000_619c:
      FUN_1000_62e9();
      uVar10 = FUN_1000_5e92();
      *(undefined1 *)0xa478 = uVar10;
      FUN_1000_62e9();
      uVar10 = FUN_1000_5e92();
      *(undefined1 *)0xa479 = uVar10;
      FUN_1000_62e9();
      uVar10 = FUN_1000_5e92();
      *(undefined1 *)0xa47a = uVar10;
      FUN_1000_62e9();
      uVar10 = FUN_1000_5e92();
      *(undefined1 *)0xa47b = uVar10;
      FUN_1000_62e9();
      uVar10 = FUN_1000_5e92();
      *(undefined1 *)0xa480 = uVar10;
      FUN_1000_62e9();
      bVar4 = FUN_1000_5e92();
      uVar10 = bVar4 < (byte)uVar6;
      if (bVar4 == (byte)uVar6) {
        bVar4 = FUN_1000_5e92();
        bVar7 = (byte)((uint)uVar6 >> 8);
        uVar10 = bVar4 < bVar7;
        if ((bVar4 == bVar7) &&
           (uVar10 = *(byte *)0xa26f < *(byte *)0xa480, *(byte *)0xa26f != *(byte *)0xa480)) {
          if (*(char *)0xa473 == '\0') {
            *(undefined2 *)0xa209 = 0x61ea;
            if (*(char *)0xa20c != -0x80) {
              return;
            }
            puVar8 = (undefined1 *)0xa20d;
            puVar9 = (undefined1 *)0xa474;
            for (iVar5 = 4; iVar5 != 0; iVar5 = iVar5 + -1) {
              puVar2 = puVar9;
              puVar9 = puVar9 + 1;
              puVar1 = puVar8;
              puVar8 = puVar8 + 1;
              *puVar2 = *puVar1;
            }
            *(undefined1 *)0xa20c = 0;
          }
          *(undefined2 *)0xa209 = 0x6207;
          uVar10 = *(byte *)0xa470 < *(byte *)0xa473;
          FUN_1000_5ebe();
          if ((bool)uVar10) {
            return;
          }
          *(undefined2 *)0xa471 = 0;
          FUN_1000_62dd();
          *(undefined2 *)0xa209 = 0x6223;
          FUN_1000_5ebe();
          if ((bool)uVar10) {
            return;
          }
          FUN_1000_62dd();
          *(undefined2 *)0xa209 = 0x6234;
          FUN_1000_5ebe();
          if ((bool)uVar10) {
            return;
          }
          FUN_1000_62dd();
          *(undefined2 *)0xa209 = 0x6245;
          FUN_1000_5ebe();
          if ((bool)uVar10) {
            return;
          }
          FUN_1000_62dd();
          *(undefined2 *)0xa209 = 0x6256;
          FUN_1000_5ebe();
          if ((bool)uVar10) {
            return;
          }
          FUN_1000_62dd();
          *(undefined2 *)0xa209 = 0x6267;
          FUN_1000_5ebe();
          if ((bool)uVar10) {
            return;
          }
          FUN_1000_62dd();
          *(undefined2 *)0xa209 = 0x6278;
          FUN_1000_5ebe();
          if ((bool)uVar10) {
            return;
          }
          *(undefined2 *)0xa209 = 0x6286;
          FUN_1000_5ebe();
          if ((bool)uVar10) {
            return;
          }
          if (*(char *)0xa473 == '\0') {
            *(char *)0xa470 = *(char *)0xa470 + '\x01';
            puVar8 = (undefined1 *)0xa478;
            puVar9 = (undefined1 *)0xa47c;
            for (iVar5 = 4; iVar5 != 0; iVar5 = iVar5 + -1) {
              puVar2 = puVar9;
              puVar9 = puVar9 + 1;
              puVar1 = puVar8;
              puVar8 = puVar8 + 1;
              *puVar2 = *puVar1;
            }
            *(undefined1 *)0xa20c = 1;
          }
          goto LAB_1000_6151;
        }
      }
    }
    else {
      uVar10 = (byte)(cVar3 + 1U) < *(byte *)0xa470;
      if ((byte)(cVar3 + 1U) == *(byte *)0xa470) {
        *(undefined1 *)0xa473 = 1;
        goto LAB_1000_619c;
      }
    }
    do {
      *(undefined2 *)0xa209 = 0x62b7;
      FUN_1000_62cf();
      FUN_1000_5e92();
    } while (!(bool)uVar10);
    if (*(char *)0xa254 != '\0') {
      return;
    }
  } while( true );
code_r0x00016120:
  *(char *)0xa470 = *(char *)0xa470 + '\x01';
  puVar8 = (undefined1 *)0xa478;
  puVar9 = (undefined1 *)0xa47c;
  for (iVar5 = 4; iVar5 != 0; iVar5 = iVar5 + -1) {
    puVar2 = puVar9;
    puVar9 = puVar9 + 1;
    puVar1 = puVar8;
    puVar8 = puVar8 + 1;
    *puVar2 = *puVar1;
  }
  *(undefined1 *)0xa20c = 1;
  goto LAB_1000_5ff1;
}


/* 1000:62cf FUN_1000_62cf */

void __cdecl16near FUN_1000_62cf(void)

{
  undefined2 unaff_DS;
  
  if (*(int *)0xa25e == 0) {
    *(undefined2 *)0xa25e = 1;
  }
  return;
}


/* 1000:62dd FUN_1000_62dd */

void __cdecl16near FUN_1000_62dd(void)

{
  undefined2 uVar1;
  undefined2 unaff_DS;
  
  uVar1 = *(undefined2 *)0xa471;
  FUN_1000_62e9();
  *(undefined2 *)0xa471 = uVar1;
  return;
}


/* 1000:62e9 FUN_1000_62e9 */

byte __cdecl16near FUN_1000_62e9(void)

{
  byte bVar1;
  byte in_AL;
  byte bVar2;
  undefined1 uVar3;
  byte in_BL;
  byte in_BH;
  
  uVar3 = 0;
  bVar2 = in_AL ^ in_BH;
  if ((POPCOUNT(bVar2) & 1U) != 0) {
    uVar3 = 2;
  }
  bVar1 = (byte)(CONCAT11((bVar2 & 1) != 0,uVar3) >> 1);
  return (byte)(CONCAT11((bVar2 & 2) != 0,bVar1) >> 1) ^ bVar1 ^ in_BL;
}


/* 1000:6310 FUN_1000_6310 */

void __cdecl16near FUN_1000_6310(void)

{
  undefined1 uVar1;
  byte bVar2;
  uint uVar3;
  char *pcVar4;
  undefined1 *puVar5;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  
  puVar5 = (undefined1 *)0xa212;
  pcVar4 = (char *)0xa226;
  uVar3 = 0;
  do {
    if ((*pcVar4 == 'm') && (*(char *)(uVar3 + 0x89e0) == '\0')) {
      uVar1 = FUN_1000_634b();
      *puVar5 = uVar1;
      puVar5[1] = 0;
      puVar5[2] = 0;
      puVar5[3] = 0;
      puVar5[4] = 1;
    }
    puVar5 = puVar5 + 5;
    pcVar4 = pcVar4 + 0xb;
    bVar2 = (char)uVar3 + 1;
    uVar3 = (uint)bVar2;
  } while (bVar2 < 4);
  return;
}


/* 1000:634b FUN_1000_634b */

byte __cdecl16near FUN_1000_634b(void)

{
  char cVar1;
  byte bVar2;
  byte bVar3;
  int iVar4;
  byte *in_BX;
  byte *pbVar5;
  undefined2 unaff_DS;
  undefined1 uVar6;
  bool bVar7;
  
  *(undefined1 *)0xa274 = (char)in_BX;
  pick_ptr();
  if (*in_BX != 0) {
    *in_BX = *in_BX - 1;
    return 0;
  }
  cVar1 = *(char *)&UNK_0000_000f;
  bVar3 = 0x14;
  bVar7 = cVar1 == '\0';
  if (!bVar7) {
    bVar3 = 0xd;
    bVar7 = cVar1 == '\x01';
    if (!bVar7) {
      bVar7 = cVar1 == '\x02';
      bVar3 = 6;
      if (!bVar7) {
        bVar3 = 0;
      }
    }
  }
  *in_BX = bVar3;
  FUN_1000_63ec();
  if (bVar7) {
    return 0x85;
  }
  pick_ptr();
  bVar3 = *in_BX;
  if (bVar3 != 0) {
    *in_BX = 0;
    return bVar3;
  }
  pick_ptr();
  bVar3 = *in_BX;
  iVar4 = 4;
  do {
    bVar2 = bVar3 + 1;
    uVar6 = 0;
    bVar3 = bVar2 & 3;
    bVar7 = (bVar2 & 3) == 0;
    FUN_1000_2a0c();
    if (!bVar7) {
      FUN_1000_673a();
      if ((bool)uVar6) {
        pbVar5 = in_BX;
        bVar3 = pick_ptr();
        *pbVar5 = *pbVar5 & 0xec;
        *pbVar5 = *pbVar5 | bVar3;
        pbVar5 = in_BX;
        pick_ptr();
        *pbVar5 = (byte)((uint)in_BX >> 8);
        return (byte)in_BX;
      }
    }
    iVar4 = iVar4 + -1;
  } while (iVar4 != 0);
  return 0;
}


/* 1000:63ec FUN_1000_63ec */

void __cdecl16near FUN_1000_63ec(void)

{
  byte bVar1;
  char cVar2;
  undefined2 in_CX;
  int iVar3;
  int iVar4;
  byte *in_BX;
  undefined2 unaff_DS;
  
  bVar1 = (byte)((uint)in_CX >> 8);
  if (*(byte *)0x89d2 < 10) {
    return;
  }
  *(undefined1 *)0xa490 = 0;
  pick_ptr();
  iVar3 = (uint)bVar1 << 8;
  do {
    if ((*in_BX & 0x80) != 0) {
      *(char *)0xa490 = *(char *)0xa490 + '\x01';
      if (*(int *)(in_BX + 0x24) == 0) {
        in_BX[0x11] = 0;
        iVar4 = iVar3;
        bVar1 = FUN_1000_437a();
        in_BX[10] = bVar1;
        in_BX[0x23] = (char)iVar4 * '\f';
        *(int *)(in_BX + 0x26) = iVar4 * 800 + 3000;
        (in_BX + 0x24)[0] = 0x55;
        (in_BX + 0x24)[1] = 100;
      }
      (**(code **)(in_BX + 0x24))();
      FUN_1000_6721();
    }
    in_BX = in_BX + 0x3b;
    cVar2 = (char)iVar3 + '\x01';
    iVar3 = CONCAT11((char)((uint)iVar3 >> 8),cVar2);
  } while (cVar2 != '\x04');
  return;
}


/* 1000:6455 FUN_1000_6455 */

void __cdecl16near FUN_1000_6455(void)

{
  byte bVar1;
  int in_BX;
  int unaff_SI;
  undefined2 unaff_DS;
  
  pick_ptr();
  if (*(int *)(in_BX + 8) == 0) {
LAB_1000_648b:
    *(undefined2 *)(unaff_SI + 0x24) = 0x649a;
    FUN_1000_437a();
    FUN_1000_666c();
    return;
  }
  *(undefined1 *)(unaff_SI + 0x11) = 0;
  if (*(uint *)(unaff_SI + 0x26) <= *(uint *)(unaff_SI + 8)) {
    bVar1 = FUN_1000_6801();
    if (*(byte *)(unaff_SI + 0x23) <= bVar1) goto LAB_1000_648b;
    if ((*(char *)(unaff_SI + 0x23) != '\0') && ((*(byte *)0x89d2 & 3) == 0)) {
      *(char *)(unaff_SI + 0x23) = *(char *)(unaff_SI + 0x23) + -1;
    }
  }
  return;
}


/* 1000:666c FUN_1000_666c */

void __cdecl16near FUN_1000_666c(void)

{
  undefined1 in_AL;
  int unaff_SI;
  undefined2 unaff_DS;
  
  *(undefined1 *)(unaff_SI + 0x14) = in_AL;
  *(byte *)(unaff_SI + 0xb) = *(byte *)(unaff_SI + 0xb) & 0xf | 0xb0;
  return;
}


/* 1000:6721 FUN_1000_6721 */

void __cdecl16near FUN_1000_6721(void)

{
  int unaff_SI;
  undefined2 unaff_DS;
  
  if ((((*(byte *)(unaff_SI + 0x16) & 4) != 0) && (*(byte *)(unaff_SI + 0x2a) < 4)) &&
     (3 < (*(byte *)(unaff_SI + 0xb) & 0xf))) {
    *(char *)(unaff_SI + 0xb) = *(char *)(unaff_SI + 0xb) + -1;
  }
  return;
}


/* 1000:673a FUN_1000_673a */

void __cdecl16near FUN_1000_673a(void)

{
  byte bVar1;
  byte *unaff_SI;
  undefined2 unaff_DS;
  
  if ((unaff_SI[0x16] & 0x42) == 0) {
LAB_1000_675e:
    if (((unaff_SI[7] == 0) ||
        ((unaff_SI[0x19] == 0 &&
         ((((unaff_SI[0x11] & 0x1f) != 6 || (3999 < *(uint *)(unaff_SI + 0x12))) &&
          ((unaff_SI[0x16] & 99) == 0)))))) && (unaff_SI[0x19] == 0)) {
      if ((unaff_SI[0x16] & 0x50) == 0) {
        *unaff_SI = *unaff_SI & 0xcf;
        goto LAB_1000_67a8;
      }
      if (unaff_SI[0x15] == 0) goto LAB_1000_67a8;
    }
  }
  else {
    if (((unaff_SI[0x16] & 0x40) != 0) && (*(uint *)(unaff_SI + 8) < 0x1f5)) {
      return;
    }
    if (7000 < *(uint *)(unaff_SI + 8)) goto LAB_1000_675e;
  }
  FUN_1000_67ed();
LAB_1000_67a8:
  unaff_SI[0x29] = unaff_SI[0x29] | 2;
  bVar1 = unaff_SI[0x11];
  if (((bVar1 != 2) && (bVar1 != 3)) && ((bVar1 != 10 && (bVar1 != 0xb)))) {
    unaff_SI[0x29] = unaff_SI[0x29] & 0xfd;
  }
  return;
}


/* 1000:67ed FUN_1000_67ed */

void __cdecl16near FUN_1000_67ed(void)

{
  byte *unaff_SI;
  int unaff_DI;
  undefined2 unaff_DS;
  
  if (unaff_SI[0xf] != 0) {
    *unaff_SI = *unaff_SI | 0x10;
  }
  if (*(uint *)(unaff_DI + 8) < 0x7531) {
    *unaff_SI = *unaff_SI | 0x20;
  }
  return;
}


/* 1000:6801 FUN_1000_6801 */

char __cdecl16near FUN_1000_6801(void)

{
  char cVar1;
  int in_CX;
  byte *unaff_DI;
  undefined2 unaff_DS;
  
  FUN_1000_3225();
  cVar1 = '\0';
  do {
    if ((*unaff_DI & 0x80U >> (*(byte *)0xa274 & 0x1f)) != 0) {
      cVar1 = cVar1 + '\x01';
    }
    unaff_DI = unaff_DI + 0xb;
    in_CX = in_CX + -1;
  } while (in_CX != 0);
  return cVar1;
}


/* 1000:686d FUN_1000_686d */

void __cdecl16near FUN_1000_686d(void)

{
  undefined2 unaff_DS;
  
  if ((DAT_0000_0417 & 8) == 0) {
    *(undefined1 *)0xa266 = 0xc;
    return;
  }
  if (*(char *)0xa266 != '\0') {
    *(char *)0xa266 = *(char *)0xa266 + -1;
  }
  return;
}


/* 1000:688e FUN_1000_688e */

uint __cdecl16near FUN_1000_688e(void)

{
  undefined1 uVar1;
  byte bVar2;
  undefined1 uVar3;
  undefined2 in_AX;
  int iVar4;
  uint uVar5;
  undefined2 unaff_DS;
  
  uVar1 = (undefined1)((uint)in_AX >> 8);
  if (*(int *)0xa25a == 0) {
    if (*(int *)0xa262 == 0) {
      if (*(int *)0xa25c == 0) {
        if (*(int *)0xa25e == 0) goto LAB_1000_68fc;
        *(int *)0xa25e = *(int *)0xa25e + -1;
        iVar4 = 0x6000;
      }
      else {
        *(int *)0xa25c = *(int *)0xa25c + -1;
        iVar4 = 0x600;
      }
    }
    else {
      iVar4 = *(int *)*(undefined2 *)0xa262;
      *(int *)0xa262 = *(int *)0xa262 + 2;
      if (iVar4 == -1) {
        *(undefined2 *)0xa262 = 0;
        uVar1 = 0xff;
LAB_1000_68fc:
        uVar3 = in(0x61);
        uVar5 = CONCAT11(uVar1,uVar3) & 0xfffc;
        out(0x61,(char)uVar5);
        return uVar5;
      }
    }
  }
  else {
    iVar4 = 0x300;
    *(int *)0xa25a = *(int *)0xa25a + -1;
  }
  out(0x42,(char)iVar4);
  uVar3 = (undefined1)((uint)iVar4 >> 8);
  out(0x42,uVar3);
  uVar1 = in(0x61);
  uVar5 = CONCAT11(uVar3,uVar1) & 0xfffc;
  bVar2 = (byte)uVar5 | *(byte *)&UNK_0000_0014;
  out(0x61,bVar2);
  return CONCAT11((char)(uVar5 >> 8),bVar2);
}


/* 1000:6903 FUN_1000_6903 */

void __cdecl16near FUN_1000_6903(void)

{
  char *pcVar1;
  undefined2 unaff_DS;
  
  if (((*(byte *)0xa26c & 0x80) == 0) && (*(char *)0xa203 == '\x01')) {
    pcVar1 = (char *)0xa204;
    *pcVar1 = *pcVar1 + -1;
    if (*pcVar1 == '\0') {
      *(undefined1 *)0xa204 = 0x12;
      pcVar1 = (char *)0xa205;
      *pcVar1 = *pcVar1 + -1;
      if (*pcVar1 == '\0') {
        *(char *)0xa204 = *(char *)0xa204 + '\x01';
        *(undefined1 *)0xa205 = 5;
      }
      if ((*(byte *)&UNK_0000_0012 & 1) == 0) {
        *(char *)0xa206 = *(char *)0xa206 + '\x01';
        if (0x3b < *(byte *)0xa206) {
          *(undefined1 *)0xa206 = 0;
          *(char *)0xa207 = *(char *)0xa207 + '\x01';
          if (0x3b < *(byte *)0xa207) {
            *(undefined1 *)0xa207 = 0;
            *(char *)0xa208 = *(char *)0xa208 + '\x01';
          }
        }
      }
      else {
        pcVar1 = (char *)0xa206;
        *pcVar1 = *pcVar1 + -1;
        if (*pcVar1 < '\0') {
          *(undefined1 *)0xa206 = 0x3b;
          pcVar1 = (char *)0xa207;
          *pcVar1 = *pcVar1 + -1;
          if (*pcVar1 < '\0') {
            *(undefined1 *)0xa207 = 0;
            *(undefined1 *)0xa206 = 0;
            *(undefined1 *)0xa203 = 0;
            return;
          }
        }
      }
    }
  }
  return;
}


/* 1000:6980 FUN_1000_6980 */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void __cdecl16near FUN_1000_6980(void)

{
  undefined1 *puVar1;
  code *pcVar2;
  undefined2 uVar3;
  int iVar4;
  undefined1 *puVar5;
  undefined2 unaff_CS;
  undefined2 unaff_DS;
  bool bVar6;
  
  *(undefined1 *)0xa273 = 0;
  bVar6 = false;
  if ((*(byte *)0xa4a9 & 1) != 0) {
    return;
  }
                    /* WARNING: Read-only address (ram,0x00000090) is written */
  _UNK_0000_0090 = 0x6a0c;
                    /* WARNING: Read-only address (ram,0x00000092) is written */
  pcVar2 = (code *)swi(0x21);
  _UNK_0000_0092 = unaff_CS;
  uVar3 = (*pcVar2)();
  if (bVar6) {
    pcVar2 = (code *)swi(0x21);
    uVar3 = (*pcVar2)();
    if (!bVar6) {
      *(undefined2 *)0xa4ab = uVar3;
      FUN_1000_6d4c();
      puVar5 = (undefined1 *)0xa4ad;
      for (iVar4 = 0x200; iVar4 != 0; iVar4 = iVar4 + -1) {
        puVar1 = puVar5;
        puVar5 = puVar5 + 1;
        *puVar1 = 0;
      }
      FUN_1000_6c8c();
      return;
    }
  }
  else {
    *(undefined2 *)0xa4ab = uVar3;
    pcVar2 = (code *)swi(0x21);
    iVar4 = (*pcVar2)();
    if (((!bVar6) && (*(char *)0xa273 == '\0')) && (iVar4 == 0x200)) {
      *(byte *)0xa4a9 = *(byte *)0xa4a9 | 1;
      if (*(int *)0xa4ad != 0) {
        *(undefined1 *)0xa272 = 1;
      }
      FUN_1000_6d4c();
      FUN_1000_6c9d();
      return;
    }
  }
  *(undefined1 *)0xa273 = 1;
  return;
}


/* 1000:6acb FUN_1000_6acb */

uint __cdecl16near FUN_1000_6acb(void)

{
  char *pcVar1;
  char *pcVar2;
  uint uVar3;
  int iVar4;
  int iVar5;
  char *pcVar6;
  char *pcVar7;
  char *pcVar8;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  bool bVar9;
  
  *(int *)0xa4ad = *(int *)0xa4ad + 1;
  *(int *)0xa257 = (int)((undefined *)&UNK_0000_ff9c + *(int *)0xa257);
  uVar3 = FUN_1000_6b1d();
  iVar4 = 0x24;
  pcVar7 = (char *)0xa4c3;
  while (pcVar6 = (char *)0xa4a3, *pcVar7 != '\0') {
    iVar5 = 6;
    bVar9 = false;
    pcVar8 = pcVar7;
    do {
      if (iVar5 == 0) break;
      iVar5 = iVar5 + -1;
      pcVar2 = pcVar8;
      pcVar8 = pcVar8 + 1;
      pcVar1 = pcVar6;
      pcVar6 = pcVar6 + 1;
      bVar9 = *pcVar1 == *pcVar2;
    } while (bVar9);
    if (bVar9) goto LAB_1000_6af9;
    pcVar7 = pcVar7 + 10;
    iVar4 = iVar4 + -1;
    if (iVar4 == 0) {
      return uVar3;
    }
  }
  pcVar8 = pcVar7;
  for (iVar4 = 6; iVar4 != 0; iVar4 = iVar4 + -1) {
    pcVar2 = pcVar8;
    pcVar8 = pcVar8 + 1;
    pcVar1 = pcVar6;
    pcVar6 = pcVar6 + 1;
    *pcVar2 = *pcVar1;
  }
  for (iVar4 = 4; iVar4 != 0; iVar4 = iVar4 + -1) {
    pcVar1 = pcVar8;
    pcVar8 = pcVar8 + 1;
    *pcVar1 = '\0';
  }
LAB_1000_6af9:
  if ((uVar3 & 1) != 0) {
    *(int *)(pcVar7 + 6) = *(int *)(pcVar7 + 6) + 1;
  }
  if ((uVar3 & 2) != 0) {
    *(int *)(pcVar7 + 8) = *(int *)(pcVar7 + 8) + 1;
  }
  uVar3 = FUN_1000_6d27();
  return uVar3;
}


/* 1000:6b1d FUN_1000_6b1d */

undefined2 __cdecl16near FUN_1000_6b1d(void)

{
  byte bVar1;
  byte bVar2;
  byte bVar3;
  undefined1 uVar6;
  undefined2 uVar4;
  uint uVar5;
  byte bVar7;
  byte bVar8;
  byte bVar9;
  byte bVar10;
  byte bVar11;
  byte bVar12;
  undefined2 unaff_DS;
  bool bVar13;
  bool bVar14;
  
  if (*(char *)0xa231 == 'm') {
    uVar5 = *(uint *)0x89e6;
    bVar10 = 0x31;
    if (*(char *)0xa23c == 'm') {
      if (uVar5 < *(uint *)0x89e8) {
        uVar5 = *(uint *)0x89e8;
      }
      bVar10 = 0x32;
      if ((*(char *)0xa247 == 'm') && (bVar10 = 0x33, uVar5 < *(uint *)0x89ea)) {
        uVar5 = *(uint *)0x89ec;
      }
    }
    bVar13 = *(uint *)0x89e4 < uVar5;
    bVar14 = *(uint *)0x89e4 == uVar5;
    bVar12 = 0x6d;
    bVar8 = 0x65;
  }
  else {
    bVar12 = *(byte *)0xa231;
    bVar8 = *(byte *)0xa232;
    bVar10 = *(byte *)0xa233;
    bVar13 = *(uint *)0x89e4 < *(uint *)0x89e6;
    bVar14 = *(uint *)0x89e4 == *(uint *)0x89e6;
  }
  uVar6 = 1;
  if ((bVar13 || bVar14) && (uVar6 = 2, !bVar13)) {
    uVar6 = 3;
  }
  uVar4 = CONCAT11(uVar6,uVar6);
  bVar1 = *(byte *)0xa226;
  bVar2 = *(byte *)0xa227;
  bVar3 = *(byte *)0xa228;
  if ((bVar12 < bVar1) ||
     ((bVar7 = bVar2, bVar9 = bVar3, bVar11 = bVar1, bVar12 <= bVar1 &&
      ((bVar8 < bVar2 || ((bVar8 <= bVar2 && (bVar10 < bVar3)))))))) {
    uVar5 = CONCAT11(uVar6,uVar6) & 0x201;
    bVar7 = (byte)(uVar5 >> 9);
    uVar4 = CONCAT11(bVar7,(char)uVar5 << 1 | bVar7);
    bVar7 = bVar8;
    bVar8 = bVar2;
    bVar9 = bVar10;
    bVar10 = bVar3;
    bVar11 = bVar12;
    bVar12 = bVar1;
  }
  *(byte *)0xa4a3 = bVar11;
  *(byte *)0xa4a4 = bVar7;
  *(byte *)0xa4a5 = bVar9;
  *(byte *)0xa4a6 = bVar12;
  *(byte *)0xa4a7 = bVar8;
  *(byte *)0xa4a8 = bVar10;
  return uVar4;
}


/* 1000:6bc5 FUN_1000_6bc5 */

void FUN_1000_6bc5(void)

{
  undefined1 *puVar1;
  byte bVar2;
  int iVar3;
  undefined1 *puVar4;
  undefined2 unaff_ES;
  undefined1 in_ZF;
  undefined1 uVar5;
  bool bVar6;
  
  do {
    print_inline();
    FUN_1000_5415();
    print_inline();
    iVar3 = 0x12;
    do {
      FUN_1000_6cae();
      print_inline();
      FUN_1000_6cae();
      print_inline();
      iVar3 = iVar3 + -1;
    } while (iVar3 != 0);
    print_inline();
    while( true ) {
      do {
        do {
          do {
            uVar5 = in_ZF;
            bVar2 = FUN_1000_0b45();
            in_ZF = 1;
          } while ((bool)uVar5);
          if (bVar2 == 6) goto LAB_1000_6c89;
          in_ZF = (bVar2 & 0xdf) == 0x5a;
        } while (!(bool)in_ZF);
        do {
          bVar6 = (bool)in_ZF;
          bVar2 = FUN_1000_0b45();
          in_ZF = true;
        } while (bVar6);
        if (bVar2 == 6) goto LAB_1000_6c89;
        in_ZF = (bVar2 & 0xdf) == 0x41;
      } while (!(bool)in_ZF);
      do {
        bVar6 = (bool)in_ZF;
        bVar2 = FUN_1000_0b45();
        in_ZF = true;
      } while (bVar6);
      if (bVar2 == 6) break;
      in_ZF = 0;
      if ((bVar2 & 0xdf) == 0x50) {
        *(undefined2 *)0xa4ad = 0;
        puVar4 = (undefined1 *)0xa4bd;
        for (iVar3 = 0x168; iVar3 != 0; iVar3 = iVar3 + -1) {
          puVar1 = puVar4;
          puVar4 = puVar4 + 1;
          *puVar1 = 0;
        }
        FUN_1000_6d27();
        FUN_1000_0166();
        return;
      }
    }
LAB_1000_6c89:
    in_ZF = 1;
  } while( true );
}


/* 1000:6c8c FUN_1000_6c8c */

void FUN_1000_6c8c(void)

{
  undefined *puVar1;
  undefined1 *puVar2;
  int iVar3;
  undefined *puVar4;
  undefined1 *puVar5;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  
  puVar5 = (undefined1 *)0xa4af;
  puVar4 = (undefined *)&UNK_0000_0007;
  for (iVar3 = 0x14; iVar3 != 0; iVar3 = iVar3 + -1) {
    puVar2 = puVar5;
    puVar5 = puVar5 + 1;
    puVar1 = puVar4;
    puVar4 = puVar4 + 1;
    *puVar2 = *puVar1;
  }
  FUN_1000_6d27();
  FUN_1000_0166();
  return;
}


/* 1000:6c9d FUN_1000_6c9d */

void __cdecl16near FUN_1000_6c9d(void)

{
  undefined1 *puVar1;
  undefined *puVar2;
  int iVar3;
  undefined1 *puVar4;
  undefined *puVar5;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  
  puVar4 = (undefined1 *)0xa4af;
  puVar5 = (undefined *)&UNK_0000_0007;
  for (iVar3 = 0x14; iVar3 != 0; iVar3 = iVar3 + -1) {
    puVar2 = puVar5;
    puVar5 = puVar5 + 1;
    puVar1 = puVar4;
    puVar4 = puVar4 + 1;
    *puVar2 = *puVar1;
  }
  *(undefined1 *)0xa267 = 5;
  return;
}


/* 1000:6cae FUN_1000_6cae */

void __cdecl16near FUN_1000_6cae(void)

{
  char *unaff_SI;
  undefined2 unaff_DS;
  
  if (*unaff_SI == '\0') {
    print_inline();
    return;
  }
  FUN_1000_6d0f();
  FUN_1000_6d0f();
  FUN_1000_6d0f();
  FUN_1000_5415();
  print_inline();
  FUN_1000_6d0f();
  FUN_1000_6d0f();
  FUN_1000_6d0f();
  FUN_1000_5415(unaff_SI);
  return;
}


/* 1000:6d0f FUN_1000_6d0f */

void __cdecl16near FUN_1000_6d0f(void)

{
  FUN_1000_557b();
  return;
}


/* 1000:6d17 FUN_1000_6d17 */

void FUN_1000_6d17(void)

{
  undefined2 unaff_DS;
  
  *(undefined2 *)0xa255 = 0xb4;
  do {
  } while (*(int *)0xa255 != 0);
  FUN_1000_0496();
  return;
}


/* 1000:6d27 FUN_1000_6d27 */

void FUN_1000_6d27(void)

{
  code *pcVar1;
  undefined2 uVar2;
  undefined2 unaff_DS;
  
  pcVar1 = (code *)swi(0x21);
  uVar2 = (*pcVar1)();
  *(undefined2 *)0xa4ab = uVar2;
  pcVar1 = (code *)swi(0x21);
  (*pcVar1)();
  pcVar1 = (code *)swi(0x21);
  (*pcVar1)();
  pcVar1 = (code *)swi(0x21);
  (*pcVar1)();
  return;
}


/* 1000:6d4c FUN_1000_6d4c */

void __cdecl16near FUN_1000_6d4c(void)

{
  code *pcVar1;
  
  pcVar1 = (code *)swi(0x21);
  (*pcVar1)();
  return;
}


/* 1000:6f19 FUN_1000_6f19 */

void __cdecl16near FUN_1000_6f19(void)

{
  undefined2 unaff_DS;
  
  *(undefined1 *)0x89d4 = 0x40;
  *(undefined1 *)0x39b1 = 2;
  print_inline();
  if (*(char *)0xa272 == '\x01') {
    print_inline();
    return;
  }
  print_inline();
  return;
}


/* 1000:7079 FUN_1000_7079 */

void __cdecl16near FUN_1000_7079(void)

{
  print_inline();
  return;
}


/* 1000:a800 FUN_1000_a800 */

void __cdecl16near FUN_1000_a800(void)

{
  byte *pbVar1;
  undefined1 *puVar2;
  undefined *puVar3;
  uint uVar4;
  int iVar5;
  uint uVar6;
  undefined1 *puVar7;
  undefined *puVar8;
  undefined2 unaff_DS;
  
  puVar7 = (undefined1 *)0x39c1;
  puVar8 = (undefined *)&UNK_0000_03d0;
  do {
    for (iVar5 = 0x2f; iVar5 != 0; iVar5 = iVar5 + -1) {
      puVar3 = puVar8;
      puVar8 = puVar8 + 1;
      puVar2 = puVar7;
      puVar7 = puVar7 + 1;
      *puVar3 = *puVar2;
    }
    puVar8 = puVar8 + 0x1fd1;
    for (iVar5 = 0x2f; iVar5 != 0; iVar5 = iVar5 + -1) {
      puVar3 = puVar8;
      puVar8 = puVar8 + 1;
      puVar2 = puVar7;
      puVar7 = puVar7 + 1;
      *puVar3 = *puVar2;
    }
    puVar8 = puVar8 + -0x1fdf;
  } while (puVar7 < (undefined1 *)0x4c1d);
  *(undefined1 *)0x89d0 = 0x67;
  uVar6 = 700;
  do {
    uVar4 = FUN_1000_437a();
    if ((*(byte *)(uVar4 & 0x3fff) & 0xaa) == 0) {
      pbVar1 = (byte *)(uVar4 & 0x3fff);
      *pbVar1 = *pbVar1 ^ '\x03' << ((byte)(uVar4 >> 0xd) & 6) & 0x11U;
    }
    FUN_1000_a874();
    if (uVar6 < 0x227) {
      FUN_1000_0b45();
    }
    iVar5 = 0x50;
    do {
      iVar5 = iVar5 + -1;
    } while (iVar5 != 0);
    uVar6 = uVar6 - 1;
  } while (uVar6 != 0);
  return;
}


/* 1000:a874 FUN_1000_a874 */

void __cdecl16near FUN_1000_a874(void)

{
  FUN_1000_a899();
  FUN_1000_a899();
  FUN_1000_a899();
  FUN_1000_a899();
  return;
}


/* 1000:a899 FUN_1000_a899 */

void __cdecl16near FUN_1000_a899(void)

{
  undefined2 *puVar1;
  byte bVar2;
  int iVar3;
  undefined2 *puVar4;
  undefined2 *unaff_DI;
  undefined2 *puVar5;
  undefined2 unaff_ES;
  undefined2 unaff_DS;
  
  *(undefined1 *)0xa264 = 1;
  while( true ) {
    bVar2 = decode_script_byte();
    if (bVar2 == 0) break;
    if (3 < bVar2) {
      iVar3 = 4;
      puVar4 = (undefined2 *)(*(int *)&UNK_0000_0016 + (uint)bVar2 * 0x10);
      puVar5 = unaff_DI;
      do {
        puVar1 = puVar4 + 1;
        *puVar5 = *puVar4;
        puVar4 = puVar4 + 2;
        puVar5[0x1000] = *puVar1;
        puVar5 = puVar5 + 0x28;
        iVar3 = iVar3 + -1;
      } while (iVar3 != 0);
      unaff_DI = unaff_DI + 1;
    }
  }
  return;
}


/* 1000:a93e FUN_1000_a93e */

void __cdecl16near FUN_1000_a93e(void)

{
  undefined2 unaff_DS;
  
  print_inline();
  *(undefined2 *)0xa255 = 0x48;
  do {
  } while (*(int *)0xa255 != 0);
  return;
}


/* 1000:ac37 FUN_1000_ac37 */

void __cdecl16near FUN_1000_ac37(void)

{
  int iVar1;
  int iVar2;
  int *piVar3;
  
  piVar3 = (int *)0xa800;
  iVar2 = 0x233;
  iVar1 = 0;
  do {
    iVar1 = iVar1 - *piVar3;
    piVar3 = piVar3 + 1;
    iVar2 = iVar2 + -1;
  } while (iVar2 != 0);
  if (iVar1 == 0) {
    return;
  }
  return;
}


/* 1000:ac56 FUN_1000_ac56 */

byte __cdecl16near FUN_1000_ac56(void)

{
  undefined2 unaff_DS;
  
  *(undefined2 *)0xa257 = 0;
  out(0x21,*(byte *)0xa200 & 0xfd);
  return *(byte *)0xa200 & 0xfd;
}


/* 1000:cfa0 FUN_1000_cfa0 */

int FUN_1000_cfa0(void)

{
  char *pcVar1;
  undefined1 *puVar2;
  byte bVar3;
  byte bVar4;
  byte bVar5;
  byte bVar6;
  byte bVar7;
  byte bVar8;
  byte bVar9;
  byte bVar10;
  byte bVar11;
  byte bVar12;
  byte bVar13;
  undefined2 in_AX;
  char cVar15;
  int iVar14;
  char in_CL;
  char in_CH;
  char in_DL;
  char in_DH;
  char cVar16;
  char *in_BX;
  char cVar19;
  char *pcVar17;
  undefined1 *puVar18;
  int unaff_BP;
  int unaff_SI;
  byte *unaff_DI;
  undefined2 unaff_SS;
  undefined2 unaff_DS;
  byte in_AF;
  
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  in_BX[unaff_SI] = in_BX[unaff_SI] + in_CH;
  bVar3 = (byte)in_AX;
  *in_BX = *in_BX + bVar3;
  bVar12 = 9 < (bVar3 & 0xf) | in_AF;
  bVar4 = bVar3 + bVar12 * -6 & 0xf;
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  in_BX[unaff_SI] = in_BX[unaff_SI] + bVar4;
  *in_BX = *in_BX + bVar4;
  bVar3 = 9 < bVar4 | bVar12;
  bVar5 = bVar4 + bVar3 * -6 & 0xf;
  in_BX[unaff_SI] = in_BX[unaff_SI] + -0x4b;
  *unaff_DI = *unaff_DI + in_DL;
  bVar4 = 9 < bVar5 | bVar3;
  bVar6 = bVar5 + bVar4 * -6 & 0xf;
  in_BX[unaff_SI] = in_BX[unaff_SI] + -0x41;
  cVar19 = (char)((uint)in_BX >> 8);
  cVar16 = (char)in_BX;
  iVar14 = CONCAT11(cVar19 * '\x04',cVar16);
  bVar5 = 9 < bVar6 | bVar4;
  bVar7 = bVar6 + bVar5 * -6 & 0xf;
  pcVar1 = (char *)(iVar14 + unaff_SI);
  *pcVar1 = *pcVar1 + -0x56;
  pcVar1 = (char *)(unaff_BP + unaff_SI + -0x5600);
  *pcVar1 = *pcVar1 + in_CH;
  bVar6 = 9 < bVar7 | bVar5;
  bVar8 = bVar7 + bVar6 * -6 & 0xf;
  *unaff_DI = *unaff_DI | 0xd;
  pcVar1 = (char *)(unaff_BP + unaff_SI + -0x5600);
  *pcVar1 = *pcVar1 + in_CH;
  pcVar1 = (char *)(unaff_BP + unaff_SI + -0x7fc1);
  *pcVar1 = *pcVar1 + in_CH;
  pcVar1 = (char *)(iVar14 + -0x100);
  *pcVar1 = *pcVar1 + cVar19 * '\x04';
  pcVar17 = (char *)CONCAT11(cVar19 * '\b',cVar16);
  bVar7 = 9 < bVar8 | bVar6;
  bVar9 = bVar8 + bVar7 * -6 & 0xf;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + -0x4b;
  *unaff_DI = *unaff_DI + in_DL;
  bVar8 = 9 < bVar9 | bVar7;
  bVar10 = bVar9 + bVar8 * -6 & 0xf;
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + bVar10;
  *pcVar17 = *pcVar17 + bVar10;
  bVar9 = 9 < bVar10 | bVar8;
  bVar11 = bVar10 + bVar9 * -6 & 0xf;
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  *(char *)(unaff_BP + unaff_SI) = *(char *)(unaff_BP + unaff_SI) + in_CH;
  *pcVar17 = *pcVar17 + bVar11;
  bVar10 = 9 < bVar11 | bVar9;
  bVar11 = bVar11 + bVar10 * -6 & 0xf;
  cVar15 = (((((((((char)((uint)in_AX >> 8) - bVar12) - bVar3) - bVar4) - bVar5) - bVar6) - bVar7) -
            bVar8) - bVar9) - bVar10;
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + cVar15;
  *pcVar17 = *pcVar17 + bVar11;
  bVar10 = 9 < bVar11 | bVar10;
  bVar12 = bVar11 + bVar10 * -6 & 0xf;
  cVar15 = cVar15 - bVar10;
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + cVar15;
  *pcVar17 = *pcVar17 + bVar12;
  bVar10 = 9 < bVar12 | bVar10;
  bVar12 = bVar12 + bVar10 * -6 & 0xf;
  cVar15 = cVar15 - bVar10;
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + cVar15;
  *pcVar17 = *pcVar17 + bVar12;
  bVar10 = 9 < bVar12 | bVar10;
  bVar3 = bVar12 + bVar10 * -6 & 0xf;
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  *(char *)(unaff_BP + unaff_SI) = *(char *)(unaff_BP + unaff_SI) + in_CH;
  *pcVar17 = *pcVar17 + bVar3;
  bVar12 = 9 < bVar3 | bVar10;
  bVar4 = bVar3 + bVar12 * -6 & 0xf;
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + bVar4;
  *pcVar17 = *pcVar17 + bVar4;
  bVar3 = 9 < bVar4 | bVar12;
  bVar5 = bVar4 + bVar3 * -6 & 0xf;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + -0x4b;
  *unaff_DI = *unaff_DI + in_DL;
  bVar4 = 9 < bVar5 | bVar3;
  bVar6 = bVar5 + bVar4 * -6 & 0xf;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + -0x41;
  iVar14 = CONCAT11(cVar19 * ' ',cVar16);
  bVar5 = 9 < bVar6 | bVar4;
  bVar7 = bVar6 + bVar5 * -6 & 0xf;
  pcVar1 = (char *)(iVar14 + unaff_SI);
  *pcVar1 = *pcVar1 + -0x56;
  pcVar1 = (char *)(unaff_BP + unaff_SI + -0x5600);
  *pcVar1 = *pcVar1 + in_CH;
  bVar6 = 9 < bVar7 | bVar5;
  bVar8 = bVar7 + bVar6 * -6 & 0xf;
  *unaff_DI = *unaff_DI | 0xd;
  pcVar1 = (char *)(unaff_BP + unaff_SI + -0x5600);
  *pcVar1 = *pcVar1 + in_CH;
  pcVar1 = (char *)(unaff_BP + unaff_SI + -0x7fc1);
  *pcVar1 = *pcVar1 + in_CH;
  pcVar1 = (char *)(iVar14 + -0x100);
  *pcVar1 = *pcVar1 + cVar19 * ' ';
  pcVar17 = (char *)CONCAT11(cVar19 * '@',cVar16);
  bVar7 = 9 < bVar8 | bVar6;
  bVar9 = bVar8 + bVar7 * -6 & 0xf;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + -0x4b;
  *unaff_DI = *unaff_DI + in_DL;
  bVar8 = 9 < bVar9 | bVar7;
  bVar11 = bVar9 + bVar8 * -6 & 0xf;
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + bVar11;
  *pcVar17 = *pcVar17 + bVar11;
  bVar9 = 9 < bVar11 | bVar8;
  bVar13 = bVar11 + bVar9 * -6 & 0xf;
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + in_CH;
  *pcVar17 = *pcVar17 + bVar13;
  bVar11 = 9 < bVar13 | bVar9;
  bVar13 = bVar13 + bVar11 * -6 & 0xf;
  cVar15 = (((((((((cVar15 - bVar10) - bVar12) - bVar3) - bVar4) - bVar5) - bVar6) - bVar7) - bVar8)
           - bVar9) - bVar11;
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  *(char *)(unaff_BP + unaff_SI) = *(char *)(unaff_BP + unaff_SI) + cVar15;
  *pcVar17 = *pcVar17 + bVar13;
  bVar11 = 9 < bVar13 | bVar11;
  bVar12 = bVar13 + bVar11 * -6 & 0xf;
  cVar15 = cVar15 - bVar11;
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  *(char *)(unaff_BP + unaff_SI) = *(char *)(unaff_BP + unaff_SI) + cVar15;
  *pcVar17 = *pcVar17 + bVar12;
  bVar11 = 9 < bVar12 | bVar11;
  bVar12 = bVar12 + bVar11 * -6 & 0xf;
  cVar15 = cVar15 - bVar11;
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  *(char *)(unaff_BP + unaff_SI) = *(char *)(unaff_BP + unaff_SI) + cVar15;
  *pcVar17 = *pcVar17 + bVar12;
  bVar11 = 9 < bVar12 | bVar11;
  bVar3 = bVar12 + bVar11 * -6 & 0xf;
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + in_CH;
  *pcVar17 = *pcVar17 + bVar3;
  bVar12 = 9 < bVar3 | bVar11;
  bVar4 = bVar3 + bVar12 * -6 & 0xf;
  unaff_DI[unaff_BP] = unaff_DI[unaff_BP] + 0xb4;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + bVar4;
  *pcVar17 = *pcVar17 + bVar4;
  bVar3 = 9 < bVar4 | bVar12;
  bVar5 = bVar4 + bVar3 * -6 & 0xf;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + -0x4b;
  *unaff_DI = *unaff_DI + in_DL;
  bVar4 = 9 < bVar5 | bVar3;
  bVar6 = bVar5 + bVar4 * -6 & 0xf;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + -0x41;
  puVar18 = (undefined1 *)((uint)in_BX & 0xff);
  bVar5 = 9 < bVar6 | bVar4;
  bVar7 = bVar6 + bVar5 * -6 & 0xf;
  puVar18[unaff_SI] = puVar18[unaff_SI] + -0x56;
  pcVar1 = (char *)(unaff_BP + unaff_SI + -0x5600);
  *pcVar1 = *pcVar1 + in_CH;
  bVar6 = 9 < bVar7 | bVar5;
  bVar8 = bVar7 + bVar6 * -6 & 0xf;
  puVar18[(int)unaff_DI] = puVar18[(int)unaff_DI] | 9;
  puVar18[unaff_SI] = puVar18[unaff_SI] + bVar8;
  bVar8 = bVar8 * '\x02';
  bVar7 = 9 < (bVar8 & 0xf) | bVar6;
  bVar9 = bVar8 + bVar7 * -6 & 0xf;
  puVar18[unaff_SI] = puVar18[unaff_SI] + bVar9;
  puVar18[unaff_SI] = puVar18[unaff_SI] + bVar9;
  *puVar18 = *puVar18;
  puVar18[unaff_SI] = puVar18[unaff_SI] + bVar9;
  puVar18[unaff_SI] = puVar18[unaff_SI] + bVar9;
  *puVar18 = *puVar18;
  puVar18[unaff_SI] = puVar18[unaff_SI] + bVar9;
  *puVar18 = *puVar18;
  bVar8 = 9 < (bVar9 + in_DH & 0xf) | bVar7;
  bVar10 = bVar9 + in_DH + bVar8 * -6 & 0xf;
  puVar2 = (undefined1 *)((uint)(byte)(cVar16 + bVar9) + unaff_SI);
  *puVar2 = *puVar2;
  pcVar17 = (char *)CONCAT11(in_CL,cVar16 + bVar9);
  bVar9 = 9 < bVar10 | bVar8;
  bVar10 = bVar10 + bVar9 * -6;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + (bVar10 & 0xf);
  iVar14 = (CONCAT11(((((((((cVar15 - bVar11) - bVar12) - bVar3) - bVar4) - bVar5) - bVar6) - bVar7)
                     - bVar8) - bVar9,bVar10) & 0xff0f) + *(int *)(pcVar17 + unaff_SI);
  *pcVar17 = *pcVar17 + in_CL;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + (char)iVar14;
  iVar14 = iVar14 + *(int *)(pcVar17 + unaff_SI);
  *pcVar17 = *pcVar17 + in_CL;
  cVar15 = (char)iVar14;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + cVar15;
  pcVar17[unaff_SI] = pcVar17[unaff_SI] + cVar15;
  *pcVar17 = *pcVar17;
  return iVar14 + *(int *)(unaff_DI + unaff_BP);
}


