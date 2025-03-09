FINR: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 FINRhp   equ 8
 FINRat   equ 10
 FINRdf   equ 12
 FINRsp   equ 14
 FINRname equ 16
 
 FINRtarget equ 20
 
 section .data
 
 .tAttack db PS,PSSTR," attacks ",PS,PSSTR,"!",Ln,PS,PSSLP,EM
 .tHurt   db PS,PSSTR," takes ",PS,PSDEC," damage!",Ln,PS,PSSLP,EM
 .tDie    db PS,PSSTR," dies...",Ln,PS,PSSLP,PS,PSSLP,EM
 .tStaats db PS,PSSTR,": ",PS,PSDEC," HP, ",PS,PSDEC," AT, ",PS,PSDEC," DF, ",PS,PSDEC," SP",Ln,EM
 .tRuun   db PS,PSSTR," tries to get away.",PS,PSSLP,".",PS,PSSLP,".",PS,PSSLP,Ln,PS,PSSLP,EM
 .tRuuns  db "...and flees the area!",Ln,PS,PSSLP,EM
 .tRuunf  db "...but can",39,"t!",Ln,PS,PSSLP,EM
 
 .tAttck db "Attack",0
 .tStats db "Stats",0
 .tRun   db "Run",0
 .tNone  db "",0
 
 .menu:
 dd .tAttck
 db "1"
 dd .tStats
 db "2"
 dd .tRun
 db "3"
 dd .tNone
 db "0"
 dd 0
 
 section .text
 
FINRfTurn: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;[esp+4] self
 
 mov  ebx,FDf									;
 mov  eax,[esp+4]								;eax self
 mov  bl,[eax+FINRtarget]						;
 
 cmp  bl,0x20									; if target index is invalid>
 jae  .D										; >D
 test bl,0x03									; if target index is invalid>
 jne  .D										; >D
 
 mov  ebx,[ebx]									;ebx target
 
 cmp  ebx,0										; if target doesn't exist>
 je   .D										; >D
 
 push ebx										;
 
 push dword[ebx+FINRname]						;Print the message
 push dword[eax+FINRname]						;
 mov  eax,FINR.tAttack							;
 call fPrint									;
 
 pop  ebx										;
 mov  eax,[esp+4]								;
 push eax										; self
 mov  ax,[eax+FINRat]							; damage
 push ebx										; target
 
 mov  ebx,[ebx]									;
 and  ebx,0xFFFF
 shl  ebx,2										;
 add  ebx,FIpRecieves							;
 call [ebx]										;Attack
 
 .D:											;
 
 ret 4

FINRfPreturnln: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 call fPrintln
 FINRfPreturn:
 ;[esp+4] self
 
 mov  eax,[esp+4]
 test byte[eax+FIfl],FIfl.p
 je   .attack
 
 xor  edx,edx
 mov  dx,[eax+FINRsp]
 push edx
 mov  dx,[eax+FINRdf]
 push edx
 mov  dx,[eax+FINRat]
 push edx
 mov  dx,[eax+FINRhp]
 push edx
 mov  edx,[eax+FINRname]
 push edx
 mov  eax,FINR.tStaats
 call fPrint
 
 mov  eax,FINR.menu
 call fMenu
 cmp  al,"1"
 je   .attack
 cmp  al,"2"
 je   .stats
 cmp  al,"3"
 je   .run
 
 mov  eax,[esp+4]
 mov  byte[eax+FINRtarget],0xFF
 
 ret 4
 
 FINRfPreturn.attack:
  mov  eax,[esp+4]								;Get the set of choices
  mov  eax,[eax+FIhstl]							;
  call FDfGetconscioushostilewithfighters		;
  cmp  byte[_bufferer],0						; check if there are none
  je   .2										;
  
  mov  eax,[esp+4]								;Check if they are a player
  test byte[eax+FIfl],FIfl.p					;
  jne  .p										;
  
  .c:											;Choose a fighter
   call fRandom64								;
   xor  edx,edx									;
   mov  dl,[_bufferer]							;
   and  ax,0xFF									;
   div  dl										;
   mov  dl,ah									;
   jmp  .1										;
  
  .p:											;Choose a fighter
   mov  cl,[_bufferer]							; cl  count
   xor  edx,edx									;
   mov  dl,0									;
   cmp  cl,1									; if there's only one>
   je   .p1										; >skip the menu
   mov  ch,"1"									; ch  char
   mov  esi,_bufferer+1							; esi source
   mov  edi,_bufferery							; edi destination
   .pL:											;
    mov  eax,FDf								; eax name
    mov  al,[esi]								;
    mov  eax,[eax]								;
    mov  eax,[eax+FINRname]						;
    mov  [edi],eax								; name
    times 4 inc edi								;
    mov  [edi],ch								; char
    inc  edi									;
    dec  cl										;
    inc  ch										;
    inc  esi									;
    cmp  cl,0									;
    jne  .pL									;
   mov  dword[edi],FINR.tNone					;
   mov  byte[edi+4],"0"							;
   mov  dword[edi+5],0							;
   mov  eax,_bufferery							;
   call fMenu									;
   cmp  al,"0"									; if 0>
   je   FINRfPreturnln							; >go back
   xor  edx,edx									;
   mov  dl,al									;
   sub  dl,"1"									;
   
   .p1:											;
   
   push edx										;
   call fPrintln								;
   pop  edx										;
   
  .1:											;
  
  mov  ebx,_bufferer+1							;Commit to the target
  add  ebx,edx									;
  mov  edx,FDf									;
  mov  dl,[ebx]									;dl target i
  mov  eax,[esp+4]								;
  mov  [eax+FINRtarget],dl						;
 
  .2:
 
  ret 4
 
 FINRfPreturn.stats:
  call fPrintln
  
  mov  ebx,FDf-4
  jmp  .L
  .L:
   times 4 inc ebx
   cmp  bl,0x20
   je   FINRfPreturnln
   cmp  dword[ebx],0
   je   .L
   push ebx
   mov  eax,[ebx]
   xor  edx,edx
   mov  dx,[eax+FINRsp]
   push edx
   mov  dx,[eax+FINRdf]
   push edx
   mov  dx,[eax+FINRat]
   push edx
   mov  dx,[eax+FINRhp]
   push edx
   mov  edx,[eax+FINRname]
   push edx
   mov  eax,FINR.tStaats
   call fPrint
   mov  eax,250
   call fSleepc
   pop  ebx
   jmp  .L
 
 FINRfPreturn.run:
  call fPrintln
  
  mov  eax,[esp+4]
  push dword[eax+FINRname]
  mov  eax,FINR.tRuun
  call fPrint
  
  call fRandom64
  cmp  ah,0xD0
  jb   .succeed
  .fail:
   mov  eax,FINR.tRuunf
   call fPrint
   jmp  FINRfPreturnln
  .succeed:
   mov  eax,FINR.tRuuns
   call fPrint
   mov  dword[esp],BAfFight.End
   call beat
   
   ret 4
  
FINRfRecieve: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;[esp+4] self
 ;[esp+8] attacker
 ;ax  damage
 
 and  eax,0xFFFF								;
 push eax										;
 
 push eax										;Print the message
 mov  eax,[esp+4+8]								;
 push dword[eax+FINRname]						;
 mov  eax,FINR.tHurt							;
 call fPrint									;
 
 pop  eax										;
 
 mov  ebx,[esp+4]								;Check if it kills
 cmp  [ebx+FINRhp],ax							;
 jbe  .dies										;
 
 sub  [ebx+FINRhp],ax							;Hurt
 
 ret 8
 
 .dies:											;Die
  mov  word[ebx+FINRhp],0						;
  and  byte[ebx+FIfl],~FIfl.c					;
  
  push dword[ebx+FINRname]						;
  mov  eax,FINR.tDie							;
  call fPrint									;
 
 ret 8
 
FINRfHurt: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;