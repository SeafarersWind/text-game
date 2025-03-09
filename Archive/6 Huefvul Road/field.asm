FD: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .bss
 
 area  resd 1
 place resd 1
 
 alignb 0x0100
 FDf resd 0x20
 
 section .code
 
FDfGetconsciousfighters: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 mov  edx,FDf									;edx fighters
 mov  ebx,_buffer+1								;ebx figher list
 
 .L:											;
  mov  ecx,[edx]								;
  cmp  ecx,0									; if fighter is not real>
  jz   .L1										; >skip fighter
  times FIfl inc eax							;
  test byte[ecx],FIfl.c							; if fighter is unconscious>
  jz   .L1										; >skip fighter
  
  mov  [ebx],dl									; put fighter index into buffer
  inc  ebx										;
  
  .L1:											; skip fighter
  times 4 inc dl								;
  cmp  dl,0x80									;
  jne  .L										;
 
 sub  ebx,_buffer+1								; put conscious fighter count into buffer
 mov  [_buffer],bl								;
 
 ret
 
FDfGetconscioushostilewithfighters: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;eax hostility
 
 mov  edx,FDf									;edx fighers
 mov  ebx,_bufferer+1							;ebx fighter list
 
 .L:											;
  mov  ecx,[edx]								;
  cmp  ecx,0									; if fighter is not real>
  jz   .L1										; >skip fighter
  times FIfl inc ecx							;
  test byte[ecx],FIfl.c							; if fighter is unconscious>
  jz   .L1										; >skip fighter
  test eax,0x00000001							; if the fighter is not hostile with
  je   .L1										; >skip fighter
  
  mov  byte[ebx],dl								; put fighter index into buffer
  inc  ebx										;
  
  .L1:											; skip fighter
  shr  eax,1b									;
  cmp  eax,0									;
  je   .LD										;
  times 4 inc dl								;
  cmp  dl,0x80									;
  jne  .L										;
  .LD:											;
 
 sub  ebx,_bufferer+1							; put fighter count into buffer
 mov  [_bufferer],bl							;
 
 ret
 
FDaddfighter: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;eax figter
 
 mov  ebx,FDf									;
 .L:											; find an open spot
  cmp  dword[ebx],0								;
  je   .LD										;
  times 4 inc ebx								;
  cmp  ebx,FDf+0x80								;
  jne   .L										;
   or   eax,0xFFFFFFFF							 ; there are too many
   ret
  .LD:
 
 mov  [ebx],eax									; put the fighter in
 
 ret
 
FDremovefighter: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 mov  ebx,FDf
 mov  bl,al
 mov  dword[ebx],0
 
 ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;