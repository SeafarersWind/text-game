;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Include
 
 %include "main.asm"
 %include "fighter.asm"
 %include "action.asm"
 %include "text.asm"
 %include "battle.asm"
 %include "encyclopedia.asm"
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Start
 
 global Start
 section .text
 Start:
  call  fStartup
  
  ;mov  eax,FId
  ;push eax
  ;call fPrinthex32
  ;call fShutdown
  
  mov  eax,FId
  mov  ah,0
  mov  al,FIId
  mov  byte[eax],0
  mov  al,FICl
  mov  byte[eax],0
  mov  al,FIFl
  mov  byte[eax],FIFlCNS|FIFlPLR
  mov  al,FIHostl
  mov  dword[eax],0x00000006
  
  mov  ah,1
  mov  al,FIId
  mov  byte[eax],1
  mov  al,FICl
  mov  byte[eax],1
  mov  al,FIFl
  mov  byte[eax],FIFlCNS|FIFlPLR
  mov  al,FIHostl
  mov  dword[eax],0x0000000D
  
  mov  ah,2
  mov  al,FIId
  mov  byte[eax],2
  mov  al,FICl
  mov  byte[eax],2
  mov  al,FIFl
  mov  byte[eax],FIFlCNS|FIFlPLR
  mov  al,FIHostl
  mov  dword[eax],0x00000002
  
  mov  ah,3
  mov  al,FIId
  mov  byte[eax],3
  mov  al,FICl
  mov  byte[eax],3
  mov  al,FIFl
  mov  byte[eax],FIFlCNS|FIFlPLR
  mov  al,FIHostl
  mov  dword[eax],0x00000008
  
  call BTfDo
  
  call  fShutdown
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;