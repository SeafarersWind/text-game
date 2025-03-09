LP: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .data
 
 tAppear db 0xA,"Abby is ambushed!",0xA,PS,PSSLP,PS,PSSLP,0
 
 ;;;;;;;;;;;;;;;;;;;;;;;
 
 lrRoad dd 0x0050, lrRoadPoints, lrRoadaLandmarks, lrRoadlLandmarks lrRoadSights, lrRoadExits
 
 lrRoadPoints    dd 0x00,  0x10, ~0
 lrRoadaLandmarks dd 0x00,  0x00
 lrRoadlLandmarks dd ltDimuo,ltDimuo
 
 lrRoadSights dd 0
 
 lrRoadExits dd 0x00000000,ltDimuo
 
 section .text
 
LPtravel: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 push 0											;line
 push _buffer									;
 push 1											;
 push tChars+Ln									;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;
 
 ;...................................................................................
 
 test dword[area],0x80000000					;backwards or forwards
 jnz  .bL										;
 
 .fL:											;
  inc  dword[area]								;step
  jmp  .step
 
 .bL:											;
  dec  dword[area]								;step
  .step:										;
  push 0										;.
  push _buffer									;
  push 1										;
  push tChars+"."								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;
  push 1000										;
  call _Sleep@4									;
  
  mov  ecx,[area]								;
  mov  eax,ecx									;
  and  eax,0x7FFFFFFF							;
  
  mov  ebx,[location]							;see anything?
  mov  ebx,[ebx+4]								;
  .LL:											;
   cmp  dword[ebx],~0							;
   je   .LLD									;
   cmp  ecx,[ebx]								;
   je   .landmark								;
   add  ebx,4									;
   jmp  .LL										;
   .LLD:										;
  
  cmp  ecx,[lrRoad+0]							;dead end?
  ja   .deadend									;
  
  test eax,0x80000000
  jnz  .bL
  jmp  .fL
 
 .landmark:										;
  mov  eax,[location]							;go to location
  sub  ebx,[eax+4]								;
  mov  edx,ebx									;
  add  ebx,[eax+8]								;
  mov  ecx,[ebx]								;
  mov  [area],ecx								;
  add  edx,[eax+12]								;
  mov  eax,[edx]								;
  mov  [location],eax							;
  
  push 0										;line
  push _buffer									;
  push 1										;
  push tChars+Ln								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;
  
  jmp  Lenter
 
 .deadend:										;
  xor  dword[area],0x80000000					;
  
  jmp  LPtravel
  
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 ;...................................................................................
 
 xor  ecx,ecx									;
 
 .L:											;
  call fRandom64								;
  cmp  ah,0x04									;
  jnb  .L										; ?c
  
 LPtravel.encounter:							;
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
  add  edx,Drepl.preplenish						;
  mov  eax,Dmons.first							;
  call dword[edx]								;
  
  push Dmons.first								;
  .constructL:									;
   pop  ecx										;
   pop  edx										;
   pop  eax										;
   add  ecx,Dmons.second-Dmons.first			;
   mov  ebx,edx									;
   shrd edx,eax,3								;
   shrd eax,ebx,3								;
   push eax										;
   push edx										;
   push ecx										;
   and  eax,0x07								;
   cmp  al,6									;
   jae  .constructD								;
   cmp  ecx,Dmons.twentyfirst+(Dmons.second-Dmons.first)
   je   .constructD								;
   mov  edx,eax									;
   shl  edx,2									;
   add  edx,Drepl.preplenish					;
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
  
  jmp  LPtravel.L								;
  
  LPtravel.LD:
 
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
 
 jmp LTwalk
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;