;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 tMenuitem db "(",PS,PSCHR,")",PS,PSSTR," ",0
 
fMenuln: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;eax Menu
; al  result
 
 push eax
 call fPrintln
 pop  eax
 
 fMenu:
 
 push eax										; preserve
 
 .L:											; Print the menu
  mov  ebx,eax									;
  times 4 inc eax								;
  push eax										; preserve
  push dword[ebx]								; string
  push dword[eax]								; character
  mov  eax,tMenuitem							; 
  call fPrint									;print
  pop  eax										; restore
  inc  eax										;
  cmp  byte[eax],0								;
  jne  .L										;
 
 ;;;;;;;;;;;;;;;;;;;;;;;
 
 push 0											;
 push _buffer									;
 push 1											;
 push tChars+":"								;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print colon
 
 push dword[_hStdinput]							; input handle
 call _FlushFileBuffers@4						;flush input
 
 xor  ebx,ebx									;
 
 mov  dword[_buffer+4],0						; total number of bytes read
 push 0											; overlapped; null
 push _buffer									; number of bytes read
 push 3											; number of bytes to read
 push _buffer+8									; string to read to
 push dword[_hStdinput]							; input handle
 call _ReadFile@20								;read the input
 
 cmp  word[_buffer+9],0x0A0D					; if the result is not ok>
 jne  .invalid									; >bad
 
 mov  al,byte[_buffer+8]						; put the result into al
 pop  ebx										; restore
 mov  ecx,ebx									;
 .okayL:										; if the char is ok>
 times 4 inc ebx
 cmp  al,[ebx]									;
 je   .valid									; >good
 inc ebx										;
 cmp  dword[ebx],0								;
 jne  .okayL									;
 mov  eax,ecx									;
 jmp  fMenu										;
  
  .invalidL:									; read again
   push 0										;
   push _buffer									;
   push 3										;
   push _buffer+8								;
   push dword[_hStdinput]						;
   call _ReadFile@20							;read the input
   .invalid:									; bad
   mov  eax,[_buffer]							;
   add  [_buffer+4],eax							; add bytes read to total bytes read
   cmp  dword[_buffer],2						; if the end is reached>
   jbe  .invalidLD								; >stop reading
   cmp  word[_buffer+9],0x0A0D					; if a new line is not reached>
   jne  .invalidL								; >keep reading
  .invalidLD:
  
  pop  eax										; restore
  jmp  fMenu									; try again
  
 
 
 .valid:										; good
 ;push eax										;
 ;call fPrintln									;
 ;pop  eax										;
 
 ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;OPTION 1
;All actions are the responsibility of the caller
;submenus are manual
;
;OPTION 2
;Menu items point to action data2
;
;OPTION 3
;???
;When the selection is made, a function is called AND a legitimate submenu is run afterwards
