LN: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .bss
 
 LNlengthtravelled resw 1
 LNlength          resw 1
 
 section .data
 
 tAppear db 0xA,"Abby is ambushed!",0xA,PS,PSSLP,PS,PSSLP,0
 
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
  
 LNtravel.encounter:							;
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
  
  call fRandom64								;
  push eax										;
  push edx										;
  and  edx,0x03									;
  mov  ebx,6									;
  div  ebx										;
  shl  edx,2									;
  add  edx,dMo.preplenish						;
  mov  eax,dMo.first							;
  call dword[edx]								;
  
  push dMo.first								;
  .constructL:									;
   pop  ecx										;
   pop  edx										;
   pop  eax										;
   add  ecx,dMo.second-dMo.first				;
   mov  ebx,edx									;
   shrd edx,eax,3								;
   shrd eax,ebx,3								;
   push eax										;
   push edx										;
   push ecx										;
   and  eax,0x07								;
   cmp  al,6									;
   jae  .constructD								;
   cmp  ecx,dMo.twentyfirst+(dMo.second-dMo.first)
   je   .constructD								;
   mov  edx,eax									;
   shl  edx,2									;
   add  edx,dMo.preplenish						;
   mov  eax,ecx									;
   call dword[edx]								;
   jmp  .constructL								;
   .constructD:									;
  
  mov  eax,tAppear								;
  call fPrint									;
  
  call BAfFight									;
  
  
  
  mov  eax,4									;
  .removeL:										;
   call FDremovefighter							;
   add  eax,4									;
   cmp  eax,4*22								;
   jbe  .removeL								;
  
  
  
  mov  cx,[LNlengthtravelled]					;
  .L:											;
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
   jnz  .L										;
  
  jmp  LNtravel.L								;
  
  LNtravel.LD:
 
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