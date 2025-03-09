section .bss

heroparty resd 4*16

crtrparty resd 4*16

section .text

spar: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 spar.resetcheck:
  mov  ebx,heroparty
  .heroL:
   test dword[ebx],~0
   jz   .heroL.skip
   test dword[ebx+4],~0
   jz   .heroL.skip
    jmp  .crtr
   .heroL.skip:
    add  ebx,16
    cmp  ebx,heroparty+4*16
    jne  .heroL
   jmp .reset
  
  .crtr:
  mov  ebx,crtrparty
  .crtrL:
   test dword[ebx],~0
   jz   .crtrL.skip
   test dword[ebx+4],~0
   jz   .crtrL.skip
    jmp  spar.select
   .crtrL.skip:
    add  ebx,16
    cmp  ebx,crtrparty+4*16
    jne  .crtrL
   
  .reset:
   mov  dword[heroparty+16*0+0],hero
   mov  dword[crtrparty+16*0+0],creature
   mov  dword[heroparty+16*0+4],1<<31
   mov  dword[crtrparty+16*0+4],1<<31
   mov  eax,tBattleStart
   call print
   push 1024
   call _Sleep@4
 
 spar.select:
  mov  eax,heroparty
  mov  ebx,crtrparty
  .heroL:
   test dword[eax],~0
   jz   .heroL.skip
   test dword[eax+4],~0
   jz   .crtrLskip
    call select
   .heroL.skip:
   add  eax,16
   cmp  eax,heroparty+4*16
   jne  .heroL
  
  mov  eax,crtrparty
  mov  ebx,heroparty
  .crtrL:
   test dword[eax],~0
   jz   .crtrLskip
   test dword[eax+4],~0
   jz   .crtrLskip
    call select
   .crtrLskip:
   add  eax,16
   cmp  eax,crtrparty+4*16
   jne  .crtrL
 
 spar.move:
  .L:
   .L.overcheck:
    mov  ebx,heroparty
    .L.overcheck.heroL:
     test dword[ebx],~0
     jz   .L.overcheck.heroL.skip
     test dword[ebx+4],~0
     jz   .L.overcheck.heroL.skip
      jmp  .L.overcheck.crtr
     .L.overcheck.heroL.skip:
      add  ebx,16
      cmp  ebx,heroparty+4*16
      jne  .L.overcheck.heroL
     jmp  spar.crtrwins
    
    .L.overcheck.crtr:
    mov  ebx,crtrparty
    .L.overcheck.crtrL:
     test dword[ebx],~0
     jz   .L.overcheck.crtrL.skip
     test dword[ebx+4],~0
     jz   .L.overcheck.crtrL.skip
      jmp  .L.overcheckD
     .L.overcheck.crtrL.skip:
      add  ebx,16
      cmp  ebx,crtrparty+4*16
      jne  .L.overcheck.crtrL
      jmp  spar.herowins
    .L.overcheckD:
   
   call random
   mov  ebx,heroparty
   xor  ecx,ecx
   .LcountL:
    test dword[ebx],~0
    je   .LcountLskip
    test dword[ebx+4],~0
    je   .LcountLskip
    test dword[ebx+8],~0
    je   .LcountLskip
     mov  [buffer+ecx],ebx
     add  ecx,4
    .LcountLskip:
    add  ebx,16
    cmp  ebx,heroparty+8*16
    jne  .LcountL
   test ecx,~0
   jz  beat
   shr  eax,24
   shr  ecx,2
   div  cl
   shr  eax,6
   and  eax,0x03C
   mov  eax,[buffer+eax]	;eax figure
   mov  ebx,[eax+8]			;ebx move
   mov  edi,ebx
   and  edi,0xFFFF0000
   shr  edi,14
   add  edi,moves
   mov  dword[eax+8],0
   mov  ecx,[eax+4]			;ecx stance
   call [edi]				; move
   jmp  .L
 
 spar.herowins:
  mov  eax,tHeroWins
  jmp  spar.win
 spar.crtrwins:
  mov  eax,tCrtrWins
 spar.win:
  call print
  push 1024
  call _Sleep@4
  
  jmp beat
 
select: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;eax figure
;ebx field
 
 section .data
 .options:
 dd tAttack, 0x00000000
 dd tDefend, 0x00010000
 dd tItem,   0x00010000
 dd tRun,    0x00020000
 dd ~0
 section .text
  
  push eax
  push ebx
  
  mov  eax,.options
  call menu
  
  push eax
  
  call random
  pop  edx
  pop  ebx
  xor  ecx,ecx
  .countL:
   test dword[ebx],~0
   je   .countLskip
   test dword[ebx+4],~0
   je   .countLskip
    mov  [buffer+ecx],ebx
    add  ecx,4
   .countLskip:
   add  ebx,16
   cmp  ebx,heroparty+8*16
   je   .countLD
   cmp  ebx,crtrparty+8*16
   jne  .countL
   .countLD:
  shr  eax,24
  shr  ecx,2
  div  cl
  shr  eax,6
  and  eax,0x3C
  mov  ebx,[buffer+eax]
  sub  ebx,heroparty
  shr  ebx,4
  or   edx,ebx
  pop  eax
  mov  [eax+8],edx
  
  ret
  
 section .data
 moves:
 dd mAttack
 dd mDefend
 dd mRun
 section .text
 
mAttack: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;figure agent
;figure recipient
 
 jmp shutdown
 
 ret

mItem: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;figure
 
 ret
 
mDefend: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;figure
 
 ret
 
mRun: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;figure
 
 ret
 
damage: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;figure
 
 ret
 
heal: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;figure
 
 ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;