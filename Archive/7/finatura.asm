FINR: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 FINRhp   equ 8
 FINRat   equ 10
 FINRdf   equ 12
 FINRsp   equ 14
 FINRname equ 16
 FINRstus equ 20
 
 FINRtarget equ 20
 
 section .data
 
 .tAttack db PS,PSSTR," attacks ",PS,PSSTR,"!",Ln,PS,PSSLP,EM
 .tHurt   db PS,PSSTR," takes ",PS,PSDEC," damage!",Ln,PS,PSSLP,EM
 .tDodge  db "Miss!",Ln,PS,PSSLP,EM
 .tDie    db PS,PSSTR," collapses...",Ln,PS,PSSLP,PS,PSSLP,EM	
 .tStaats db PS,PSSTR,": ",PS,PSDEC," HP, ",PS,PSDEC," AT, ",PS,PSDEC," DF, ",PS,PSDEC," SP",Ln,EM
 .tRuun   db PS,PSSTR," tries to get away.",PS,PSSLP,".",PS,PSSLP,".",PS,PSSLP,Ln,PS,PSSLP,EM
 .tRuuns  db "...and flees the area!",Ln,PS,PSSLP,EM
 .tRuunf  db "...but can",39,"t!",Ln,PS,PSSLP,EM
 
 .tAttck db "Attack",0
 .tStats db "Stats",0
 .tRun   db "Run",0
 .tWait  db "Wait",0
 
 .tMonsters dd .tAbby,.tGob,.tBug
 .tAbby db "Abby",0
 .tGob  db "Gob",0
 .tBug  db "Bug",0
 
 .menu     times 12 dd 0
 .menu.atk times 65 dd 0
 
 section .text
 
FINRfTurn: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;[esp+4] self
 
 mov  ebx,field									;
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
 
 mov  eax,[esp+4]								; clear the target
 mov  byte[eax+FINRtarget],0xFF					;
 
 mov  eax,[esp+4]								;
 test byte[eax+FIfl],FIfl.p						;
 je   .playerstatsD								;
 
 xor  edx,edx									;
 mov  dx,[eax+FINRsp]							;
 push edx										;
 mov  dx,[eax+FINRdf]							;
 push edx										;
 mov  dx,[eax+FINRat]							;
 push edx										;
 mov  dx,[eax+FINRhp]							;
 push edx										;
 mov  edx,[eax+FINRname]						;
 push edx										;
 mov  eax,FINR.tStaats							;
 call fPrint									;
 .playerstatsD:									;
 
 push FINR.menu									;
 
 mov  eax,[esp+8]								;
 mov  eax,[eax+FIhstl]							;eax hostility
 mov  edx,field									;edx fighers
 mov  ebx,FINR.menu.atk							;ebx fighter menu
 
 .L:											;
  mov  ecx,[edx]								;
  cmp  ecx,0									; if fighter is not real>
  jz   .L1										; >skip fighter
  times FIfl inc ecx							;
  test byte[ecx],FIfl.c							; if fighter is unconscious>
  jz   .L1										; >skip fighter
  test eax,0x00000001							; if the fighter is not hostile with
  je   .L1										; >skip fighter
  
  mov  ecx,[edx]								;
  mov  ecx,[ecx+FINRname]						;
  mov  [ebx],ecx								;
  mov  byte[ebx+5],dl							; put fighter index into buffer
  add  ebx,8									;
  
  .L1:											; skip fighter
  shr  eax,1									;
  cmp  eax,0									;
  je   .LD										;
  times 4 inc dl								;
  cmp  dl,0x80									;
  jne  .L										;
  .LD:											;
 
 mov  dword[ebx],0
 
 sub  ebx,FINR.menu.atk							;
 shr  ebx,3										;ebx fighter count
 
 mov  eax,[esp+8]								;Player or computer?
 test byte[eax+FIfl],FIfl.p						;
 jne  .menuatk.p								;
 
 .menuatk.c:									;
  add  esp,4									;
  
  cmp  ebx,0									; if there are no fighters in the menu>
  je   .attackD									; >skip attack menu
  
  push ebx										;reserve fighter count
  call fRandom64								;random
  pop  edx										;restore fighter count
  and  ax,0xFF									;
  div  dl										;ah  target
  
  jmp  .attack									;
 
 .menuatk.p:									;
 
  cmp  ebx,0									; if there are no fighters in the menu>
  je   .menuatk.pD								; >skip attack menu
 
  pop  ebx										;
  mov  dword[ebx],FINR.tAttck					;
  mov  dword[ebx+4],0x80010000					;
  add  ebx,8									;
  push ebx										;
  .menuatk.pD:									;
  
 pop  ebx										;
 mov  dword[ebx],FINR.tStats					;
 mov  dword[ebx+4],0x020000						;
 add  ebx,8										;
 push ebx										;
 
 pop  ebx										;
 mov  dword[ebx],FINR.tRun						;
 mov  dword[ebx+4],0x030000						;
 add  ebx,8										;
 push ebx										;
 
 pop  ebx										;
 mov  dword[ebx],FINR.tWait						;
 mov  dword[ebx+4],0x000000						;
 add  ebx,8										;
 push ebx										;
 
 pop  ebx										;
 mov  dword[ebx],0								;
 mov  dword[ebx+4],FINR.menu.atk				;
 
 mov  eax,FINR.menu								;
 call fMenu										;
 cmp  eax,0x030000								;
 jnb  .run										;
 cmp  eax,0x020000								;
 jnb  .stats									;
 cmp  eax,0x010000								;
 jnb  .attack									;
 jmp  .attackD									;
 
 .attack:										;ah target
  mov  ebx,[esp+4]								;
  mov  [ebx+FINRtarget],ah						;
  .attackD:
  
  ret 4
 
 FINRfPreturn.stats:
  
  mov  ebx,field-4
  jmp  .L
  .L:
   times 4 inc ebx
   cmp  bl,0x80
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
   jmp  FINRfPreturn.attackD
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
 
 push eax										;Miss?
 call fRandom64									;
 pop  eax										;
 push eax										;
 shr  eax,16									;
 cmp  dl,al										;
 ja   .miss										;
 
 pop  eax										;
 push eax
 
 test eax,0x01<<24								;
 jnz  .bind										;
 .bindD:										;
 
 pop  eax										;
 push eax										;
 and  eax,0xFFFF								;
 
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
 
 .miss:											;
  pop  eax										;
  mov  eax,FINR.tDodge							;
  call fPrint									;
  
  ret 8
 
 .bind:											;
  mov  ebx,[esp+8]								;
  or   byte[ebx+FINRstus],0x01					;
  
  jmp  .bindD
 
 .dies:											;Die
  mov  word[ebx+FINRhp],0						;
  and  byte[ebx+FIfl],~FIfl.c					;
  
  push dword[ebx+FINRname]						;
  mov  eax,FINR.tDie							;
  call fPrint									;
 
 ret 8
 
FINRfHurt: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;