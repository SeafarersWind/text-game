FNR: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 FNRhp   equ 12;..13
 FNRat   equ 14;..15
 FNRst   equ 16;
 FNRmove equ 20;..23
  FNRmoves equ 24
 FNRwepn equ 32;..35
 
 section .data
 
 tLnequalssign db " "
 tEqualssign db "==========================================================================================",0
 
 tLndashsign db LN
 tDashsign db "---------------------------------------------------------------------------------",0
 
 tStab  db "Stab",0
 tWhack db "Whack",0
 tCut   db "Cut",0
 tAttack db "Attack",0
 tSpear db "Spear",0
 tSword db "Sword",0
 tMove db "Move",0
 tLook db "Look",0
 
 tWhostabswho  db PSTR," stabs ",     PSTR,"!",0
 tWhowhackswho db PSTR," whacks ",    PSTR,"!",0
 tWhocutswho   db PSTR," slashes at ",PSTR,"!",0
 
 FNRMoveNames   dd tStab,tWhack,tCut
 FNRMoveHits    dd 0x08, 0x04,  0x06
 FNRMoveAttacks dd tWhostabswho,tWhowhackswho,tWhocutswho
 
 section .bss
 
 FNRmenu resq 32
 
 section .text
 
FNRprep: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;[esp+4] self
 
 mov  eax,[esp+4]								;
 test byte[eax+FIfl],FIfl.p						;
 jz   .1										;
 
 ;name
 ;health
 ;stead
 ;sight
 
 ;mov  eax,[esp+4]								;
 mov  eax,[eax+FIname]							;
 call print										;Print name
 
 xor  ebx,ebx									;
 mov  eax,[esp+4]								;
 mov  bx,[eax+FNRhp]							;
 shr  bx,2										;
 inc  bx										;
 push 0											; overlapped
 push _buffer									; written
 push ebx										; length
 push tLnequalssign								; string
 push dword[_hStdoutput]						; output handle
 call _WriteFile@20								;Print health
 
 mov  eax,[esp+4]								;
 mov  al,[eax+FNRst]							;
 and  eax,0xFF									;
 cmp  al,7										;
 jbe  .st1										;
  mov  al,7										;
 .st1:											;
 mov  al,[eax+.stlengths]						;
 section .data									;
 .stlengths db 0,1,3,7,11,15,21,27				;
 section .text									;
 push 0											; overlapped
 push _buffer									; written
 push eax										; length
 push tLndashsign								; string
 push dword[_hStdoutput]						; output handle
 call _WriteFile@20								;Print stead
 line											;line
 
 mov  esi,[esp+4]								;
 mov  edi,FNRmenu								;
 
 .1:
 
 ;weapon
 ;move
 ;look
 
 mov  eax,[esi+FNRwepn]							;eax weapon
 mov  ebx,eax									;
 shr  ebx,24									;ebx weapon shape
 and  ebx,0x04									;
 mov  ebx,[ebx+.weaponnames]					;ebx weapon name
 section .data									;
 .weaponnames:									;
 dd tAttack										;
 dd tSpear										;
 dd tSword										;
 dd tAttack										;
 section .text									;
 mov  [edi],ebx									;menu tweapon
 mov  dword[edi+4],0x80010000					;menu attack
 
 mov  dword[edi+8],tMove						;menu tmove
 mov  dword[edi+12],0x00020000					;menu move
 
 mov  dword[edi+16],tLook						;menu tlook
 mov  dword[edi+20],0x00030000					;menu look
 
 mov  dword[edi+24],0							;menu end
 add  edi,32									;
 mov  [edi-4],edi								;menu targets menu
 
 mov  edx,[esi+FIhstl]							;
 mov  eax,field									;
 .meL:											;
  test edx,0x01									;not hostile>
  jz   .meLskip									;>skip fighter
  mov  ecx,[eax]								;
  test ecx,~0									;not real>
  jz   .meLskip									;>skip fighter
  cmp  ecx,esi									;self>
  je   .meLskip									;>skip fighter
  xor  ecx,ecx									;
  or   ecx,0x80000000							;
  mov  cl,al									;
  mov  [edi+4],ecx								;menu fighter
  mov  ecx,[eax]								;
  mov  ecx,[ecx+FIname]							;
  mov  [edi],ecx								;menu tfighter
  add  ebx,8									;
  .meLskip:										;
  add  eax,4									;
  shr  edx,1									;
  jnz  .meL										;
 mov  dword[ebx],0								;menu end
 
 mov  eax,[esi+FNRwepn]							;
 
 
 
 
 
 
 
 mov  eax,[esp+4]
 mov  ebx,FNRmenu
 mov  esi,8
 .mmL:
  xor  edx,edx
  mov  dl,[eax+FNRmoves]
  test dl,~0
  jz   .mmLskip
  shl  edx,8
  or   edx,0x80000000
  mov  [ebx+4],edx
  shr  edx,6
  and  edx,0x000003FC
  add  edx,FNRMoveNames-4
  mov  ecx,[edx]
  mov  [ebx],ecx
  add  ebx,8
  .mmLskip:
  inc  eax
  dec  esi
  jnz  .mmL
 
 ;...
 
 mov  dword[ebx],0
 add  ebx,8
 mov  [ebx-4],ebx
 
 mov  eax,[esp+4]
 mov  edx,[eax+FIhstl]
 mov  eax,field
; .meL:
  test edx,0x01
  jz   .meLskip
  mov  ecx,[eax]
  test ecx,~0
  jz   .meLskip
  cmp  ecx,[esp+4]
  je   .meLskip
  xor  ecx,ecx
  mov  cl,al
  mov  [ebx+4],ecx
  mov  ecx,[eax]
  mov  ecx,[ecx+FIname]
  mov  [ebx],ecx
  add  ebx,8
;  .meLskip:
  add  eax,4
  shr  edx,1
  jnz  .meL
 mov  dword[ebx],0
 
 mov  eax,FNRmenu
 mov  ebx,[esp+4]
 test byte[ebx+FIfl],FIfl.p
 jnz  .player
  
  call fMenuauto
  mov  ebx,[esp+4]
  mov  [ebx+FNRmove],eax
  
  section .bss
  .counts resd 3
  section .text
  
 ret 4
 
 .player:
  call fMenu
  mov  ebx,[esp+4]
  mov  [ebx+FNRmove],eax
 
 ret 4
 
FNRturn: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;[esp+4] self
 
 mov  edx,[esp+4]								;edx self
 mov  eax,[edx+FNRmove]							;
 mov  ecx,field									;
 mov  cl,al										;cl target
 shr  ah,8										;
 and  eax,0xFF									;
 add  ax,[edx+FNRat]							;al damage
 
 pop  ebx										;
 push dword[ecx]								;target
 push ebx										;
 
 push eax										;
 call fRandom64									;
 and  edx,0x03									;
 dec  edx										;
 pop  eax										;
 add  eax,edx									;
 xor  ebx,ebx									;ebx:eax effect
 
 jmp  FIfRecieve
 
FNRrecieve: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;[esp+4] self
;[esp+8] sender
;ebx:eax effect
 
 
 
 ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;