LP: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .text
 
LPenter: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; |
LPtravel: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 .step:											;step
  inc  word[area]								;
  
  push 0										;.
  push _buffer									;
  push 1										;
  push tChars+"."								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;
  
  mov  ebx,[location]							;ebx location
  mov  cx,[area]								;cx  position
  mov  eax,[ebx+lp.points]						;eax points
  .pointsL:										;
   cmp  [eax],cx								; here?
   je   .point									;
   add  eax,lp.pointsize						;next point
   test dword[eax],~0							;
   jne  .pointsL								;
  
  jmp  .step									;
  
  LPtravel.point:								;
   mov  ebx,[eax+2]								;ebx point
  .R:											;
   mov  ecx,[ebx]								;ecx [point]
   test ecx,0x80000000							; condition?
   jne  .conditions								;
   test ecx,0x40000000							; entrance?
   jne  .entrance								;
   
   .sight:										;
    mov  ax,cx									; sight
    push [ebx+2]								; next point
    call see									;
    pop  ebx									; next point
    jmp  .R										;
   
   .entrance:									;
    mov  ax,[ecx]								; sight
    mov  ebx,[ecx+4]							; location
    mov  ecx,[ecx+8]							; area
    jmp  enter									;
   
   .conditions:									;
    test  ecx,0x70000000						;
    je    .weathercondition						;
   .localcondition:								;
    jmp  .R										;
   
   .weathercondition:							;
    mov  dx,[weather+0]							;
    cmp  [ecx+4],dx								;
    jb   .conditionf							;
    cmp  [ecx+6],dx								;
    ja   .conditionf							;
    mov  dx,[weather+2]							;
    cmp  [ecx+8],dx								;
    jb   .conditionf							;
    cmp  [ecx+10],dx							;
    ja   .conditionf							;
    mov  dx,[weather+4]							;
    cmp  [ecx+12],dx							;
    jb   .conditionf							;
    cmp  [ecx+14],dx							;
    ja   .conditionf							;
    mov  dx,[weather+6]							;
    cmp  [ecx+16],dx							;
    jb   .conditionf							;
    cmp  [ecx+18],dx							;
    ja   .conditionf							;
    mov  ebx,ecx								;
    add  ebx,20									;
    jmp  .R										;
    
    .conditionf:								;
    mov  ebx,[ebx]								;
    and  ebx,~0x80000000						;
    jmp  .R										;
    
    
    
   
   
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;