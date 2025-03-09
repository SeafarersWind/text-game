;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 tMenuitem db "(",PS,PSCHR,")",PS,PSSTR," ",0
 tMenu0    db "(0) ",0
 tMenu_    db "(-) ",0
 tMenuN    db "(=) ",0
 
fMenuln: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;eax Menu
; eax return
 
 push eax
 call fPrintln
 pop  eax
 
 fMenu:
 
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
  call fPrint									;print menuitem
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
  times 4 inc eax								;
  mov  eax,[eax]								;eax action value
  
  test eax,0x80000000							; if the action value is a submenu>
  jnz  .sub										; >submenu
  
  push eax										;
  
  push 0										;
  push _buffer									;
  push 1										;
  push tChars+Ln								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;print ln
  
  pop  eax										;
  
  times 4 inc esp
  ret
 
 .sub:											;submenu
  and  eax,~0x80000000							;
  
  push edx										;reserve menu
  push eax										;reserve action value
  
  add  edx,ebx									; find the end of the menu
  .subL:										;
   add  edx,8									;
   cmp  dword[edx],0							;
   jne  .subL									;
  
  add  edx,4									; get the submenu
  and  eax,0xFFFF								;
  shl  ax,2										;
  add  edx,eax									;
  mov  eax,[edx]								;
  
  call fMenu									;submenu
  .subret:										;
  
  pop  ebx										;restore action value
  
  cmp  eax,0xFFFFFFFF							;
  je   .sub.r									;
  
  and  ebx,0xFFFFC000							;
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
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
