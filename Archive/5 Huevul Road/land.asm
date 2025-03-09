LN: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .bss
 
 LNlengthtravelled resw 1
 LNlength          resw 1
 
 section .text
 
LNtravel: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 ;...................................................................................
 
 xor  ecx,ecx									;
 
 .L:											;
  mov  cx,[LNlengthtravelled]					;
  cmp  cx,[LNlength]							;
  jae  .LD										;
  inc  word[LNlengthtravelled]					;
  
  push 0										;
  push _buffer									;
  push 1										;
  push tChars+"."								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;print dot
  
  call fSleepd									;pause
  
  call fRandom64								;
  cmp  ah,0x04									;
  jnb  .L										; ?c
  
 .encounter:									;
  push ecx										;
  
  push "!"										;
  call fPrintchar								;
  mov  eax,125									;
  call fSleepc									;
  push "!"										;
  call fPrintchar								;
  mov  eax,125									;
  call fSleepc									;
  push "!"										;
  call fPrintchar								;
  call fSleepd									;
  call fPrintln									;
  
  call dMo.replenish
  mov  eax,dMo.first
  call FDaddfighter
  mov  eax,dMo.second
  call FDaddfighter
  mov  eax,dMo.third
  call FDaddfighter
  call BAfFight
  mov  eax,4
  call FDremovefighter
  mov  eax,8
  call FDremovefighter
  mov  eax,12
  call FDremovefighter
  
  mov  cx,[LNlengthtravelled]					;
  .encounterL:									;
   push ecx										;
   push 0										;
   push _buffer									;
   push 1										;
   push tChars+"."								;
   push dword[_hStdoutput]						;
   call _WriteFile@20							;print dot
   pop  ecx										;
   dec  cx										;
   cmp  cx,0									;
   jnz  .encounterL								;
  
  pop  ecx										;
  jmp  .L										;
  
  .LD:
 
 push 0											;
 push _buffer									;
 push 1											;
 push tChars+"!"								;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print dot
 call fSleepd									;pause
 call fSleepd									;pause
 call fSleepd									;pause
 push 0											;
 push _buffer									;
 push 1											;
 push tChars+0xA								;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;println
 
 jmp TNwalk
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;