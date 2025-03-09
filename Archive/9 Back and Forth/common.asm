section .text
print: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;eax message
;[esp+4...] specal parameters
;Prints a string. Terminated by 0.
;The special character PS calls a routine specified by the following byte. The number of special
;parameters must match the amount required by each routine called in the string or it will crash
;the program.
PS   equ 0xFF	;parameter size:
PNUM equ 0xFF	;4
PB08 equ 0xFE	;4
PB16 equ 0xFD	;4
PB32 equ 0xFC	;4
PH08 equ 0xFB	;4
PH16 equ 0xFA	;4
PH32 equ 0xF9	;4
PSTR equ 0xF8	;4
PCHR equ 0xF7	;4
 
 xor  edi,edi									;edi recursion count
 
 mov  ebx,buffer+4								;ebx string
 .L:											;
  mov  dl,[eax]									;
  cmp  dl,0										;
  je   .LD										;
  cmp  dl,PS									;
  jae  .special									;
  mov  [ebx],dl									;build the string
  inc  eax										;
  inc  ebx										;
  jmp  .L										;
  .LD:											;
 
 sub  ebx,buffer+4								;ebx string length
 
 push 0											; overlapped
 push buffer									; number of bytes written
 push ebx										; number of bytes to write
 push buffer+4									; string
 push dword[hStdoutput]							; output handle
 call _WriteFile@20								;print
 
 ret
 
 .special:										;
 inc  edi										;recursion count
 inc  eax										;message
 
 pop  esi										;
 pop  edx										;
 push esi										;
 push eax										;reserve message
 
 mov  cl,[eax-1]								;go to special function
 mov  eax,edx									;eax special parameter
 and  ecx,0xFF									;
 sub  cl,PS										;
 shl  ecx,2										;
 add  ecx,.specials								;
 jmp  [ecx]										;
 section .data
 .specials:
 dd .chr
 dd .str
 dd .h32
 dd .h16
 dd .h08
 dd .b32
 dd .b16
 dd .b08
 dd .dec
 section .text
 
 print.str:										;
 ;eax message									;
  
  .L:											;
   mov  dl,[eax]								;
   test dl,~0									;
   jz   .LD										;
   cmp  dl,PS									;
   jae  print.special							;
   mov  [ebx],dl								;build the string
   inc  eax										;
   inc  ebx										;
   jmp  .L										;
   .LD:											;
  
  pop  eax										;restore string
  dec  edi										;recurion count
  jnz  print.str.L
  jmp  print.L
 
 print.chr:										;
 ;al  character									;
  
  mov  [ebx],al									;
  inc  ebx										;
  
  pop  eax										;restore string
  dec  edi										;recurion count
  jnz  print.str.L
  jmp  print.L
 
 print.b08:										;
 ;al  number									;
  
  mov  cl,8										;cl count
  .L:
   test al,0x80									;
   jz   .0D										;
    mov  byte[ebx],"1"							;
    jmp  .1D									;
    .0D:										;
    mov  byte[ebx],"0"							;
    .1D:										;
   inc  ebx										;
   shl  al,1									;
   dec  ch										;
   jnz  .L										;
  
  pop  eax										;restore string
  dec  edi										;recurion count
  jnz  print.str.L
  jmp  print.L
 
 print.b16:										;
 ;ax  number									;
  
  mov  cl,16									;cl count
  .L:
   test ah,0x80									;
   jz   .0D										;
    mov  byte[ebx],"1"							;
    jmp  .1D									;
    .0D:										;
    mov  byte[ebx],"0"							;
    .1D:										;
   inc  ebx										;
   shl  ax,1									;
   dec  cl										;
   jnz  .L										;
  
  pop  eax										;restore string
  dec  edi										;recurion count
  jnz  print.str.L
  jmp  print.L
 
 print.b32:										;
 ;eax number									;
  
  mov  cl,32									;cl count
  .L:											;
   test edx,0x80000000							;
   jz   .0D										;
    mov  byte[ebx],"1"							;
    jmp  .1D									;
    .0D:										;
    mov  byte[ebx],"0"							;
    .1D:										;
   inc  ebx										;
   shl  eax,1									;
   dec  cl										;
   jnz  .L										;
  
  pop  eax										;restore string
  dec  edi										;recurion count
  jnz  print.str.L
  jmp  print.L
 
 print.h08:										;
 ;al  number									;
  
  xor  ah,ah									;
  shl  ax,4										;
  cmp  ah,"9"									;
  ja   .numD									;
   add  ah,"0"									;
   jmp  .letD									;
   .numD:										;
   add  ah,"A"-10								;
   .letD:										;
  mov  [ebx],ah									;
  inc  ebx										;
  xor  ah,ah									;
  shl  ax,4										;
  cmp  ah,"9"									;
  ja   .numD2									;
   add  ah,"0"									;
   jmp  .letD2									;
   .numD2:										;
   add  ah,"A"-10								;
   .letD2:										;
  mov  [ebx],ah									;
  inc  ebx										;
  
  pop  eax										;restore string
  dec  edi										;recurion count
  jnz  print.str.L
  jmp  print.L
 
 print.h16:										;
 ;ax  number									;
  
  mov  ecx,4									;
  .L:											;
   xor  dx,dx									;
   shld dx,ax,4									;
   shl  ax,4									;
   cmp  dl,"9"									;
   ja   .numD									;
    add  dl,"0"									;
    jmp  .letD									;
    .numD:										;
    add  dl,"A"-10								;
    .letD:										;
   mov  [ebx],dl								;
   inc  ebx										;
   dec  ecx										;
   jne  .L										;
  
  pop  eax										;restore string
  dec  edi										;recurion count
  jnz  print.str.L
  jmp  print.L
 
 print.h32:										;
 ;eax number									;
  
  mov  ecx,8									;
  .L:											;
   xor  edx,edx									;
   shld edx,eax,4								;
   shl  eax,4									;
   cmp  dl,"9"									;
   ja   .numD									;
    add  dl,"0"									;
    jmp  .letD									;
    .numD:										;
    add  dl,"A"-10								;
    .letD:										;
   mov  [ebx],dl								;
   inc  ebx										;
   dec  ecx										;
   jne  .L										;
  
  pop  eax										;restore string
  dec  edi										;recurion count
  jnz  print.str.L
  jmp  print.L
 
 print.dec:										;
 ;eax number									;
  
  test eax,0x80000000							; sign
  jns  .signD									;
   mov  byte[ebx],"-"							;
   inc  ebx										;
   not  eax										;
   inc  eax										;
  .signD:										;
  
  cmp  eax,10									; count the digits
  jl   .one										;
  cmp  eax,100									;
  jl   .ten										;
  cmp  eax,1000									;
  jl   .hundred									;
  cmp  eax,10000								;
  jl   .thousand								;
  cmp  eax,100000								;
  jl   .tenthousand								;
  cmp  eax,1000000								;
  jl   .hundredthousand							;
  cmp  eax,10000000								;
  jl   .million									;
  cmp  eax,100000000							;
  jl   .tenmillion								;
  cmp  eax,1000000000							;
  jl   .hundredmillion							;
  
  .billion:										; build the string
   xor  edx,edx									;
   mov  esi,1000000000							;
   div  esi										;
   add  al,"0"									;
   mov  byte[ebx],al							;
   inc  ebx										;
   mov  eax,edx									;
  .hundredmillion:								;
   xor  edx,edx									;
   mov  esi,100000000							;
   div  esi										;
   add  al,"0"									;
   mov  byte[ebx],al							;
   inc  ebx										;
   mov  eax,edx									;
  .tenmillion:									;
   xor  edx,edx									;
   mov  esi,10000000							;
   div  esi										;
   add  al,"0"									;
   mov  byte[ebx],al							;
   inc  ebx										;
   mov  eax,edx									;
  .million:										;
   xor  edx,edx									;
   mov  esi,1000000								;
   div  esi										;
   add  al,"0"									;
   mov  byte[ebx],al							;
   inc  ebx										;
   mov  eax,edx									;
  .hundredthousand:								;
   xor  edx,edx									;
   mov  esi,100000								;
   div  esi										;
   add  al,"0"									;
   mov  byte[ebx],al							;
   inc  ebx										;
   mov  eax,edx									;
  .tenthousand:									;
   xor  edx,edx									;
   mov  esi,10000								;
   div  esi										;
   add  al,"0"									;
   mov  byte[ebx],al							;
   inc  ebx										;
   mov  eax,edx									;
  .thousand:									;
   xor  edx,edx									;
   mov  esi,1000								;
   div  esi										;
   add  al,"0"									;
   mov  byte[ebx],al							;
   inc  ebx										;
   mov  eax,edx									;
  .hundred:										;
   xor  edx,edx									;
   mov  esi,100									;
   div  esi										;
   add  al,"0"									;
   mov  byte[ebx],al							;
   inc  ebx										;
   mov  eax,edx									;
  .ten:											;
   xor  edx,edx									;
   mov  esi,10									;
   div  esi										;
   add  al,"0"									;
   mov  byte[ebx],al							;
   inc  ebx										;
   mov  eax,edx									;
  .one:											;
   add  al,"0"									;
   mov  byte[ebx],al							;
   inc  ebx										;
   mov  eax,edx									;
  
  pop  eax										;restore string
  dec  edi										;recurion count
  jnz  print.str.L
  jmp  print.L
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;