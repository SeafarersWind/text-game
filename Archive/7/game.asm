;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .bss
 
 hero resd 1
 vision resd 1
 
 weather resq 1
 
 location resd 1
 area  resd 1
 alignb 0x0100
 field resd 0x100 ;0..7F: fighers  ;80..FF: items
 
 section .data
 
 tMenuitem db "(",PCHR,")",PSTR," ",0
 tMenu0    db "(0) ",0
 tMenu_    db "(-) ",0
 tMenuN    db "(=) ",0
 
 section .text
 
enter: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ax  sight
;ebx location
;ecx area
 
 mov  [location],ebx							;
 mov  [area],ecx								;
 cmp  ebx,lt									;
 jae  .t										;
 .p:											;
  push  LPenter									;
  jmp   see										;
 .t:											;
  push  LTenter									;
 
see: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ax sight
 
 and  eax,0xFFFF								;
 mov  ebx,[vision]								;
 shl  eax,1										;
 add  ebx,eax									;
 
 mov  bl,[eax+3]								;
 cmp  bl,0										;
 je   .D										;
 cmp  bl,1										;
 je   .text										;
 
 .D:
 ret
 
 .text:											;
 push eax										;
 mov  eax,[eax+4]								;
 call print										;
 
 push 0											;line
 push _buffer									;
 push 1											;
 push tChars+Ln									;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;
 
 pop  eax										;
 add  eax,8										;
 
 jmp  see
 
fMenu: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;eax menu
; eax value
 
 push 0											;[esp] pagedata
 
 .r:	;again									;
 push eax										;reserve menu
 
 mov ecx,"1"									;cl  char
 .L:											; Print the menu
  cmp  cl,"9"									;
  ja   .LD										;
  push eax										; reserve menupoint
  push ecx										; reserve char
  push dword[eax]								; text
  push ecx										; char
  mov  eax,tMenuitem							;
  call print									;print menuitem
  pop  ecx										; restore char
  pop  eax										; restore menupoint
  add  eax,8									;
  inc  cl										;
  cmp  dword[eax],0								;
  jne  .L										;
 or   ch,0x01									;
  .LD:											;
 
 push ecx										;reserve top char
 
 cmp  dword[esp+12],.subret						;
 jne  .print0D									;
  push 0										;
  push _buffer									;
  push 4										;
  push tMenu0									;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;print "(0) "
  .print0D:										;
 
 test dword[esp+8],0xFFFFFFFF					;
 jz   .print_D									;
  push 0										;
  push _buffer									;
  push 4										;
  push tMenu_									;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;print "(-) "
  .print_D:										;
 
 test byte[esp+1],0x01							;
 jnz   .printND									;
  push 0										;
  push _buffer									;
  push 4										;
  push tMenuN									;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;print "(=) "
  .printND:										;
 
 ;;;;;;;;;;;;;;;;;;;;;;;
 
 push 0											;
 push _buffer									;
 push 1											;
 push tChars+":"								;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print ":"
 mov  dword[_buffer],10							;
 mov  dword[_buffer+4],1						;
 push _buffer									;
 push dword[_hStdoutput]						;
 call _SetConsoleCursorInfo@8					;make cursor visible
 push dword[_hStdinput]							;
 call _FlushFileBuffers@4						;flush input
 push 0											;
 push _bufferer									;
 push 3											;
 push _bufferer+4								;
 push dword[_hStdinput]							;
 call _ReadFile@20								;read input
 mov  dword[_buffer],1							;
 mov  dword[_buffer+4],0						;
 push _buffer									;
 push dword[_hStdoutput]						;
 call _SetConsoleCursorInfo@8					;make cursor invisible
 
 cmp  word[_bufferer+5],0x0A0D					; if the input is not ok>
 jne  .invalid									; >bad
 
 xor  ebx,ebx									;
 mov  bl,byte[_bufferer+4]						;bl  input
 pop  ecx										;cl  top char
 pop  eax										;eax menu
 test ch,0x01									; =
 jnz  .okcheck1									;
  cmp  bl,"="									;
  je   .validN									;
 .okcheck1:										;
 test dword[esp],0xFFFFFFFF						; -
 jz   .okcheck2									;
  cmp  bl,"-"									;
  je   .valid_									;
 .okcheck2:										;
 cmp  dword[esp+4],.subret						; 0
 jne  .okcheck3									;
  cmp  bl,"0"									;
  je   .valid0									;
 .okcheck3:										;
 cmp  bl,"1"									; 123456789
 jb   .r										;
 cmp  bl,cl										;
 jae  .r										;
 
 ;;;;;;;;;;;;;;;;;;;;;;;
 
 .valid:										;
  mov  edx,eax									;edx menu
  sub  bl,"1"									;
  shl  bl,3										;
  add  eax,ebx									;
  mov  eax,[eax+4]								;eax action value
  
  test eax,0x80000000							; if the action value is a submenu>
  jnz  .sub										; >submenu
  
  push ebx										;
  push eax										;
  
  push 0										;line
  push _buffer									;
  push 1										;
  push tChars+Ln								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;
  
  pop  eax										;
  pop  ebx
  
  add  esp,4
  ret
 
 .sub:											;submenu
  and  eax,~0xFF000000							;
  
  push edx										;reserve menu
  push eax										;reserve action value
  
  add  edx,ebx									; find the end of the menu
  .subL:										;
   add  edx,8									;
   cmp  dword[edx],0							;
   jne  .subL									;
  
  add  edx,4									; get the submenu
  shr  eax,22									;
  and  al,0xFC									;
  add  edx,eax									;
  mov  eax,[edx]								;
  
  call fMenu									;submenu
  .subret:										;
  
  pop  ebx										;restore action value
  
  cmp  eax,0xFFFFFFFF							;
  je   .sub.r									;
  
  or   eax,ebx									;
  
  add  esp,8
  ret
  
  .sub.r:										;
  pop  eax										;restore menu
  mov  edx,[esp]								;
  shl  edx,3									; *9
  mov  ebx,edx									;
  shl  edx,3									;
  add  edx,ebx									;
  sub  eax,edx									;
  mov  dword[esp],0								;
  
  jmp  .r
 
 .validN:										;
  inc  dword[esp]								;
  add  eax,0x08*9								;
  
  jmp  .r
 
 .valid_:										;
  dec  byte[esp]								;
  sub  eax,0x08*9								;
  
  jmp  .r
 
 .valid0:										;
  or   eax,0xFFFFFFFF							;
  
  add  esp,4
  ret
 
 ;;;;;;;;;;;;;;;;;;;;;;;
 
 .invalidL:										; read again
  push 0										;
  push _bufferer								;
  push 3										;
  push _bufferer+4								;
  push dword[_hStdinput]						;
  call _ReadFile@20								;read the input
 .invalid:										; bad
  cmp  dword[_bufferer],2						; if the end is reached>
  jbe  .invalidLD								; >stop reading
  cmp  word[_bufferer+5],0x0A0D					; if a new line is not reached>
  jne  .invalidL								; >keep reading
  .invalidLD:
  
  pop  ecx										; restore
  pop  eax										; restore
  jmp  .r										; try again
 
 ;;;;;;;;;;;;;;;;;;;;;;;
 
 ;Menu
 ; Menuitem[],0xFF
 
 ;Menuitem
 ; str item name
 ; d   action value
 ;  0x0xxxxxxx return value
 ;  0x8xxxxxxx submenu
 
fMenuauto: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;eax menu
; eax value
 
 push eax										;reserve menu
 
 xor  ecx,ecx									;cl menu count
 .L:											;
  test dword[eax],~0							;
  jz   .LD										;
  inc  ecx										;
  add  eax,8									;
  jmp  .L										;
  .LD:											;
 
 push ecx										;reserve menu count
 call fRandom64									;
 xor  edx,edx									;
 pop  ecx										;restore menu count
 div  ecx										;edx choice
 pop  eax										;
 push eax										;
 shl  edx,3										;
 add  edx,eax									;edx menu+offset
 mov  eax,[edx+4]								;eax action value
 
 test eax,0x80000000							; if the action value is a submenu>
 jnz  .sub										; >submenu
 
 add  esp,4
 ret
 
 .sub:											;submenu
  and  eax,~0xFF000000							;
  
  push eax										;reserve action value
  
  .subL:										;
   add  edx,8									;
   cmp  dword[edx],0							;
   jne  .subL									;
  
  add  edx,4									; get the submenu
  shr  eax,22									;
  and  cl,0xFC									;
  add  edx,eax									;
  mov  eax,[edx]								;
  call fMenuauto								;submenu
  
  pop  ebx										;restore action value
  or   eax,ebx									;
  
  add  esp,4
  ret
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
