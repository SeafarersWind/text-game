section .bss
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 player   resd 1
 
 location resd 1
 area     resd 1
 
 weather  resd 1
 day      resd 1
 
 field    resd 32
 
section .text
print: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;eax message
;[esp+4...] specal parameters
;Prints a string. Terminated by 0.
;The special character PS calls a routine specified by the following byte. The number of special
;parameters must match the amount required by each routine called in the string or it will crash
;the program.
pS   equ 0xF7	;parameter size:
pNUM equ 0xFF	;4
pB08 equ 0xFE	;4
pB16 equ 0xFD	;4
pB32 equ 0xFC	;4
pH08 equ 0xFB	;4
pH16 equ 0xFA	;4
pH32 equ 0xF9	;4
pSTR equ 0xF8	;4
pCHR equ 0xF7	;4
 
 xor  edi,edi									;edi recursion count
 
 mov  ebx,buffer+4								;ebx string
 .L:											;
  mov  dl,[eax]									;
  cmp  dl,0										;
  je   .LD										;
  cmp  dl,pS									;
  jae  .special									;
  mov  [ebx],dl									;build the string
  inc  eax										;
  inc  ebx										;
  jmp  .L										;
  .LD:											;
 mov  byte[ebx],10								;line
 
 sub  ebx,buffer+3								;ebx string length
 
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
 sub  cl,pS										;
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
   cmp  dl,pS									;
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
 
happen: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;[eax+4] condition
;[eax+8] action
 
 push eax
 push 0
 push buffer
 push 1
 push c+10
 push dword[hStdoutput]
 call _WriteFile@20
 pop  eax
 
 mov  edx,[eax+12]
 cmp  edx,world
 jb   .multi
 cmp  edx,text
 jb   .enter
 
 .text:
  mov eax,edx
  call print
  
  jmp beat
 
 .enter:
  mov  [location],edx
  mov  ecx,[eax+8]
  mov  [area],ecx
  
  mov  eax,[edx-8]
  call print
  
  jmp beat
 
 .multi:
  jmp beat
 
menu: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 push 0				;preserve page number
 
 .r:
 push eax			;preserve menu
 
 mov  ebx,buffer+3	;ebx text
 mov  ecx,' (1)'	;ecx number label	;ct next page marker
 .L:
  cmp  dword[eax],~0
  je   .LD
  ; condition
  cmp  ecx,':)'<<16
  jae  .LD1
  push ecx
  push eax
  mov  [ebx],ecx			;write a menu item
  mov  esi,[eax]
  .LL:
   mov  edx,[esi]
   mov  [ebx+4],edx
   test edx,0x000000FF
   jz   .LLD1
   test edx,0x0000FF00
   jz   .LLD2
   test edx,0x00FF0000
   jz   .LLD3
   test edx,0xFF000000
   jz   .LLD4
   add  esi,4
   add  ebx,4
   jmp  .LL
   .LLD4:
   inc  ebx
   .LLD3:
   inc  ebx
   .LLD2:
   inc  ebx
   .LLD1:
   add  ebx,4
  pop  eax
  pop  ecx
  add  eax,16
  add  ecx,0x10000
  jmp  .L
  .LD1:
  and  ecx,0x00FFFFFF
  .LD:
 
 push ecx			;preserve last number label
 
 ;submenu?
 
 test  dword[esp+8],~0
 jz   .noPrev
  mov  dword[ebx],' (-)'	;write ' (-)'
  add  ebx,4
 .noPrev:
 
 test byte[esp+3],~0
 jnz  .noNext
  mov  dword[ebx],' (=)'	;write ' (=)'
  add  ebx,4
 .noNext:
 
 mov  word[ebx],' :'		;write ' :'
 
 sub  ebx,buffer+2
 push 0
 push buffer
 push ebx
 push buffer+4
 push dword[hStdoutput]
 call _WriteFile@20			;print the menu
 
 mov  dword[buffer],10
 mov  dword[buffer+4],1
 push buffer
 push dword[hStdoutput]
 call _SetConsoleCursorInfo@8	;make cursor visible
 push dword[hStdinput]
 call _FlushFileBuffers@4		;flush input
 push 0
 push buffer+16
 push 3
 push buffer+16+4
 push dword[hStdinput]
 call _ReadFile@20				;read input
 mov  dword[buffer],1
 mov  dword[buffer+4],0
 push buffer
 push dword[hStdoutput]
 call _SetConsoleCursorInfo@8	;make cursor invisible
 
 cmp  word[buffer+16+5],0x0A0D		; if the input is not a single character
 jne  .invalid
 
 xor  ebx,ebx
 mov  bl,byte[buffer+16+4]	;bl  input
 pop  ecx
 bswap ecx					;ch  last label number	;cl next page marker
 pop  eax					;eax menu
 test cl,0xFF					; =
 jnz  .noEquals
  cmp  bl,"="
  je   .inputNext
 .noEquals:
 test dword[esp],~0				; -
 jz   .noMinus
  cmp  bl,"-"
  je   .inputPrev
 .noMinus:
 ;submenu?				; 0
 jmp  .noZero
  cmp  bl,"0"
  je   .inputBack
 .noZero:
 cmp  bl,"1"					; 123456789
 jb   .r
 cmp  bl,ch
 jae  .r
 
 .input123456789:
  mov  edx,eax
  sub  bl,'1'
  shl  bl,4
  add  eax,ebx
  
  add  esp,4
  
  ;submenu?
  
  jmp happen
 
 .inputNext:
  add  eax,144
  inc  dword[esp]
  jmp  .r
 
 .inputPrev:
  sub  eax,144
  dec  dword[esp]
  jmp  .r
 
 .inputBack:
  ;submenu...
  
  jmp  .r
 
 ;;;;;;;;;;;;;;;;;;;;;;;
 
 .invalidL:
  push 0
  push buffer+16
  push 3
  push buffer+16+4
  push dword[hStdinput]
  call _ReadFile@20
 .invalid:
  cmp  dword[buffer+16],2
  jbe  .invalidLD
  cmp  word[buffer+16+5],0x0A0D
  jne  .invalidL
  .invalidLD:
  
  pop  ecx	; restore
  pop  eax	; restore
  jmp  .r
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
