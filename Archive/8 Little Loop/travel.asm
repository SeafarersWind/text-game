section .text
travel: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;eax location
 
 mov  eax,[eax-4]
 and  eax,0xF
 shl  eax,8
 push eax
 call _Sleep@4
 
 inc  word[area]
 
 mov  ebx,[location]		;ebx location
 mov  ecx,[area]			;ecx area
 mov  eax,ebx				;eax points
 cmp  [eax],ecx
 je   .happen
 ja   .pointsLD
 .pointsL:
  add  eax,12
  cmp  [eax],ecx
  je   happen
  jb   .pointsL
  .pointsLD:
 
 push 0
 push buffer
 push 1
 push c+"."
 push dword[hStdoutput]
 call _WriteFile@20
 
 jmp beat
 
 .happen:
  push eax
  section .data
  .oh db '!',10
  section .text
  push 0
  push buffer
  push 2
  push .oh
  push dword[hStdoutput]
  call _WriteFile@20
  push 2048
  call _Sleep@4
  
  pop  eax
  
  jmp happen
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;