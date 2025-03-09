;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 extern _ExitProcess@4
 extern _GetStdHandle@4
 extern _WriteFile@20
 extern _ReadFile@20
 extern _Sleep@4
 extern _FlushFileBuffers@4
 extern _SetConsoleCursorInfo@8
 extern _GetLastError@0
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 %macro line 0									;
  push 0										;line
  push _buffer									;
  push 1										;
  push tChars+Ln								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;
 %endmacro										;
 
 %macro end 0									;
 jmp fShutdown									;
 %endmacro										;
 
 %macro hellotest 0
 push eax
 push ebx
 push ecx
 push edx
 push esi
 push edi
 push 0
 push _buffer
 push 14
 push tHello
 push dword[_hStdoutput]
 call _WriteFile@20
 push 200
 call _Sleep@4
 pop  edi
 pop  esi
 pop  edx
 pop  ecx
 pop  ebx
 pop  eax
 %endmacro
 
 %macro numtest 1
 push eax
 push ebx
 push ecx
 push edx
 push esi
 push edi
 push %1
 call fPrintdec
 push 0
 push _buffer
 push 1
 push tChars+0xA
 push dword[_hStdoutput]
 call _WriteFile@20
 push 200
 call _Sleep@4
 pop  edi
 pop  esi
 pop  edx
 pop  ecx
 pop  ebx
 pop  eax
 %endmacro
 
 %macro hextest 1
 push eax
 push ebx
 push ecx
 push edx
 push esi
 push edi
 push %1
 call fPrinthex32
 push 0
 push _buffer
 push 1
 push tChars+0xA
 push dword[_hStdoutput]
 call _WriteFile@20
 push 200
 call _Sleep@4
 pop  edi
 pop  esi
 pop  edx
 pop  ecx
 pop  ebx
 pop  eax
 %endmacro
 
 section .bss
 _hStdoutput resd 1
 _hStdinput  resd 1
 
 ;_bufferer:
 _buffer     resd 16
 _bufferer   resd 16
 _bufferery  resd 41
 
 nRandom     resq 1
 
 section .data
 tHello db "Hello, World!",0xA,0
 
 nRngseed dq 0x5BDAC52726239CBC,0xEBBFE7B637605289,0xF6F580ECB32631BB,0x89147C0A7B7DEB45
 
 tChars db 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,
  db 31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,
  db 61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,
  db 91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,
  db 116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,
  db 138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,
  db 160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,
  db 182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,
  db 204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,
  db 226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,
  db 248,249,250,251,252,253,254,255,0,0
 fShutdown.t db Ln,"It ends:"
 
 width db 80
 
 section .text
 
fStartup: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 push -11										; STD_OUTPUT
 call _GetStdHandle@4							;
 mov  dword[_hStdoutput],eax					;
 
 push -10										; STD_OUTPUT
 call _GetStdHandle@4							;
 mov  dword[_hStdinput],eax						;
 
 mov  byte[_buffer],1							;
 push _buffer									;
 push dword[_hStdoutput]						;
 call _SetConsoleCursorInfo@8					;make cursor invisible
 
 ret
 
fShutdown: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 push 0											;
 push _buffer									;
 push 9											;
 push .t										; 
 push dword[_hStdoutput]						; 
 call _WriteFile@20								;print the shutdown message
 
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
 
 push dword 0									;
 call _ExitProcess@4							;
 
print: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;eax message
;[esp...] specal parameters
 section .bss
 .string resb 1024
 section .text
 
 xor  edi,edi									;edi recursion count
 
 mov  ebx,.string								;ebx string
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
 
 sub  ebx,.string								;ebx string length
 
 push 0											; overlapped
 push _buffer									; number of bytes written
 push ebx										; number of bytes to write
 push .string									; string
 push dword[_hStdoutput]						; output handle
 call _WriteFile@20								;print
 
 ret
 
 LN   equ 0xA
 PS   equ 0xF7
 PDEC equ 0xFF
 PB08 equ 0xFE
 PB16 equ 0xFD
 PB32 equ 0xFC
 PH08 equ 0xFB
 PH16 equ 0xFA
 PH32 equ 0xF9
 PSTR equ 0xF8
 PCHR equ 0xF7
 
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
 
fPrint: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 EM equ 0x00
 Ln equ 0x0A
 
 ;;;;;;;;;;;;;;;;;;;;;;;
 
 mov  ebx,eax									; scan for spcial characters and the end
 jmp  .scanLs									;
 .scanL:										;
  inc  ebx										;
 .scanLs:										;
  cmp  byte[ebx],PS								;
  je   .ps										;
  cmp  byte[ebx],EM								;
  jne  .scanL									;
 
 sub  ebx,eax									;
 push 0											; overlapped; null
 push _buffer									; number of bytes written
 push ebx										; number of bytes to write
 push eax										; string
 push dword[_hStdoutput]						; output handle
 call _WriteFile@20								;print the message
 
 ret
 
 .ps:											;
  push ebx										;
  
  sub  ebx,eax									;
  push 0										;
  push _buffer									;
  push ebx										;
  push eax										;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;print the message so far
  
  pop  eax										;
  inc  eax										;
  push eax										;
  cmp  byte[eax],PSSLP							;;if there are parameters
  jae  .ps0										;;
   pop  eax										;; string
   pop  ecx										;; return
   pop  ebx										;; param
   push ecx										;; return
   push eax										;; string
   push ebx										;; param
  .ps0:											;
  xor  ebx,ebx									;
  mov  bl,byte[eax]								;
  shl  bx,2										;
  add  ebx,.psT									;
  call dword[ebx]								;call the special function
  
  pop  eax										;
  inc  eax										;
  
  jmp  fPrint									;
  
  section .data
  .psT:
   dd fPrintstring	;00
   dd fPrintdec		;01
   dd fPrinthex32	;02
   dd fPrinthex16	;03
   dd fPrinthex8	;04
   dd fPrintbin32	;05
   dd fPrintbin16 	;06
   dd fPrintbin8 	;07
   dd fPrintchar	;08
   dd fSleepd		;09
   					;...
   PSSTR   equ 0x00	;FF
   PSDEC   equ 0x01
   PSH32   equ 0x02
   PSH16   equ 0x03
   PSH8    equ 0x04
   PSB32   equ 0x05
   PSB16   equ 0x06
   PSB8    equ 0x07
   PSCHR   equ 0x08
   PSSLP   equ 0x09
 
fPrintstring: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 mov  eax,[esp+4]								; scan for the end
 mov  ebx,eax									;
 dec  ebx										;
 .scanL:										;
  inc  ebx										;
  cmp  byte[ebx],EM								;
  jne  .scanL									;
 
 sub  ebx,eax									;
 push 0											;
 push _buffer									;
 push ebx										;
 push eax										;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print the message
 
 ret 4
 
fPrintdec: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 mov  ebx,_buffer+4								;ebx string
 mov  eax,dword[esp+4]							;eax number
 
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
 cmp  eax,10000									;
 jl   .thousand									;
 cmp  eax,100000								;
 jl   .tenthousand								;
 cmp  eax,1000000								;
 jl   .hundredthousand							;
 cmp  eax,10000000								;
 jl   .million									;
 cmp  eax,100000000								;
 jl   .tenmillion								;
 cmp  eax,1000000000							;
 jl   .hundredmillion							;
 
 .billion:										; build the string
  xor  edx,edx									;
  mov  ecx,1000000000							;
  div  ecx										;
  add  al,"0"									;
  mov  byte[ebx],al								;
  inc  ebx										;
  mov  eax,edx									;
 .hundredmillion:								;
  xor  edx,edx									;
  mov  ecx,100000000							;
  div  ecx										;
  add  al,"0"									;
  mov  byte[ebx],al								;
  inc  ebx										;
  mov  eax,edx									;
 .tenmillion:									;
  xor  edx,edx									;
  mov  ecx,10000000								;
  div  ecx										;
  add  al,"0"									;
  mov  byte[ebx],al								;
  inc  ebx										;
  mov  eax,edx									;
 .million:										;
  xor  edx,edx									;
  mov  ecx,1000000								;
  div  ecx										;
  add  al,"0"									;
  mov  byte[ebx],al								;
  inc  ebx										;
  mov  eax,edx									;
 .hundredthousand:								;
  xor  edx,edx;									;
  mov  ecx,100000								;
  div  ecx										;
  add  al,"0"									;
  mov  byte[ebx],al								;
  inc  ebx										;
  mov  eax,edx									;
 .tenthousand:									;
  xor  edx,edx									;
  mov  ecx,10000								;
  div  ecx										;
  add  al,"0"									;
  mov  byte[ebx],al								;
  inc  ebx										;
  mov  eax,edx									;
 .thousand:										;
  xor  edx,edx									;
  mov  ecx,1000									;
  div  ecx										;
  add  al,"0"									;
  mov  byte[ebx],al								;
  inc  ebx										;
  mov  eax,edx									;
 .hundred:										;
  xor  edx,edx									;
  mov  ecx,100									;
  div  ecx										;
  add  al,"0"									;
  mov  byte[ebx],al								;
  inc  ebx										;
  mov  eax,edx									;
 .ten:											;
  xor  edx,edx									;
  mov  ecx,10									;
  div  ecx										;
  add  al,"0"									;
  mov  byte[ebx],al								;
  inc  ebx										;
  mov  eax,edx									;
 .one:											;
  add  al,"0"									;
  mov  byte[ebx],al								;
  inc  ebx										;
  mov  eax,edx									;
 
 sub  ebx,_buffer+4								;
 push 0											;
 push _buffer									;
 push ebx										;
 push _buffer+4									;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print the decimal number
 
 ret 4
 
fPrinthex32: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 mov  cl,8										;cl  digit
 mov  ebx,_buffer+4								;ebx string
 mov  eax,dword[esp+4]							;eax number
 
 .L:											; build the string
  xor  dl,dl									;
  shld edx,eax,4								;
  shl  eax,4									;
  cmp  dl,10									;
  jae  .Lletter									;
   add  dl,"0"									;
  jmp  .Lnumber									;
  .Lletter:										;
   add  dl,"A"-10								;
  .Lnumber:										;
  mov  byte[ebx],dl								;
  inc  ebx										;
  dec  cl										;
  jnz  .L										;
  
 push 0											;
 push _buffer									;
 push 8											;
 push _buffer+4									;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print the 32-bit hexadecimal number
  
 ret 4
 
fPrinthex16: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 mov  cl,4										;cl  digit
 mov  ebx,_buffer+4								;ebx string
 mov  ax,word[esp+4]							;ax number
 
 .L:											; build the string
  xor  dl,dl									;
  shld dx,ax,4									;
  shl  ax,4										;
  cmp  dl,10									;
  jae  .Lletter									;
   add  dl,"0"									;
  jmp  .Lnumber									;
  .Lletter:										;
   add  dl,"A"-10								;
  .Lnumber:										;
  mov  byte[ebx],dl								;
  inc  ebx										;
  dec  cl										;
  jnz  .L										;
  
 push 0											;
 push _buffer									;
 push 4											;
 push _buffer+4									;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print the 16-bit hexadecimal number
  
 ret 4
 
fPrinthex8: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 mov  cl,2										;cl  digit
 mov  ebx,_buffer+4								;ebx string
 mov  al,byte[esp+4]							;al number
 
 .L:											; build the string
  xor  ah,ah									;
  shl  ax,4										;
  cmp  ah,10									;
  jae  .Lletter									;
   add  ah,"0"									;
  jmp  .Lnumber									;
  .Lletter:										;
   add  ah,"A"-10								;
  .Lnumber:										;
  mov  byte[ebx],ah								;
  inc  ebx										;
  dec  cl										;
  jnz  .L										;
  
 push 0											;
 push _buffer									;
 push 2											;
 push _buffer+4									;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print the 8-bit hexadecimal number
  
 ret 4
 
fPrintbin32: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 mov  cl,32										;cl  digit
 mov  ebx,_buffer+4								;ebx string
 mov  eax,dword[esp+4]							;eax number
 
 .L:											; build the string
  xor  dl,dl									;
  shld edx,eax,1								;
  shl  eax,1									;
  add  dl,"0"									;
  mov  byte[ebx],dl								;
  inc  ebx										;
  dec  cl										;
  jnz  .L										;
 
 push 0											;
 push _buffer									;
 push 32										;
 push _buffer+4									;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print the 32-bit binary number
 
 ret 4
 
fPrintbin16: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 mov  cl,16										;cl  digit
 mov  ebx,_buffer+4								;ebx string
 mov  ax,word[esp+4]							;ax number
 
 .L:											; build the string
  xor  dl,dl									;
  shld dx,ax,1									;
  shl  ax,1										;
  add  dl,"0"									;
  mov  byte[ebx],dl								;
  inc  ebx										;
  dec  cl										;
  jnz  .L										;
 
 push 0											;
 push _buffer									;
 push 16										;
 push _buffer+4									;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print the 16-bit binary number
 
 ret 4
 
fPrintbin8: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 mov  cl,8										;cl  digit
 mov  ebx,_buffer+4								;ebx string
 mov  al,byte[esp+4]							;ax number
 
 .L:											; build the string
  xor  ah,ah									;
  shl  ax,1										;
  add  ah,"0"									;
  mov  byte[ebx],ah								;
  inc  ebx										;
  dec  cl										;
  jnz  .L										;
 
 push 0											;
 push _buffer									;
 push 8											;
 push _buffer+4									;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print the 8-bit binary number
 
 ret 4
 
fPrintchar: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 xor  eax,eax									; get the character string
 mov  al,byte[esp+4]							;
 add  eax,tChars								;
 
 push 0											;
 push _buffer									;
 push 1											;
 push eax										;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;Print the character
 
 ret 4
 
fPrintln: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 push 0											;
 push _buffer									;
 push 1											;
 push tChars+Ln									;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;Print the character
 
 ret
 
fSleepd: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 push 750										; 750 miliseconds
 call _Sleep@4									;Zzz
 
 ret
 
fSleepc: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 push eax										; eax miliseconds
 call _Sleep@4									;Zzz
 
 ret
 
fRandom64: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
;return (s1 * 5 <<< 7) * 9			; x*5 = x<<2+x    x*7 = x<<3+x
;
;t == s1<<17
;s2 xor s0
;s3 xor s1
;s1 xor s2
;s0 xor s3
;s2 xor t
;s3 <<< 45
 
 mov  eax,dword[nRngseed+8]						;eax num_low
 mov  ebx,dword[nRngseed+12]					;ebx num_high
 mov  ecx,eax									; * 5
 mov  edx,ebx									;
 shld ebx,eax,2									;
 shl  eax,2										;
 add  eax,ecx									;
 adc  ebx,edx									;
 mov  edi,ebx									; << 7
 shld ebx,eax,7									;
 shld eax,edi,7									;
 mov  esi,eax									; * 9
 mov  edi,ebx									;
 shld ebx,eax,3									;
 shl  eax,3										;
 add  eax,esi									;
 adc  ebx,edi									;
 mov  dword[nRandom],eax						;num = (s1 * 5 << 7) * 9
 mov  dword[nRandom+4],ebx						;
 
;2 <  17 -> t
;3 x  1
;4 x  2
;2 x  3
;1 x  4
;3 x  t
;4 << 45
 
 mov  eax,[nRngseed+16]							; randomize seed
 mov  ebx,[nRngseed+20]							; 2 -> B
 mov  esi,[nRngseed+24]							; 3 -> A
 mov  edi,[nRngseed+28]							; 4 -> C
 xor  eax,[nRngseed]							;
 xor  ebx,[nRngseed+4]							; A x  1
 xor  esi,ecx									; C x  B
 xor  edi,edx									;
 xor  [nRngseed+8],eax							; 2 x  A
 xor  [nRngseed+12],ebx							;
 xor  [nRngseed],esi							; 1 x  C
 xor  [nRngseed+4],edi							;
 shld edx,ecx,17								; B <  17
 shl  ecx,17									;
 xor  eax,ecx									; A x  B
 xor  ebx,edx									;
 mov  [nRngseed+16],eax							; A -> 3
 mov  [nRngseed+20],ebx							;
 mov  eax,edi									;
 shld edi,esi,45								; C << 45
 shld esi,eax,45								; 
 mov  [nRngseed+24],esi							; C -> 3
 mov  [nRngseed+28],edi							;
 
 mov  eax,[nRandom]
 mov  edx,[nRandom+4]
 
 ret
 
fRand32: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 mov  eax,dword[nRngseed]						;
 mov  edx,1103515245							;
 mul  edx										;
 shl  edx,16									;
 add  eax,12345									;
 adc  edx,0xFFFF								;
 mov  dword[nRngseed],eax						;
 shr  eax,16									;
 and  edx,0xFFFF0000							;
 or   eax,edx									;
 
 ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;