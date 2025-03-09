;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;setup
 
 extern _ExitProcess@4
 extern _GetStdHandle@4
 extern _WriteFile@20
 extern _ReadFile@20
 extern _Sleep@4
 extern _FlushFileBuffers@4
 
 section .text
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Startup/Shutdown

 STD_OUTPUT_HANDLE EQU -11
 STD_INPUT_HANDLE  EQU -10
 NULL              EQU 0
 
 section .bss
 StdOutHandle resd 1
 StdInHandle  resd 1
 
 section .text
 fStartup:
  push  STD_OUTPUT_HANDLE						; 1st parameter - Handle
  call  _GetStdHandle@4							; call
  mov   dword[StdOutHandle],eax					; to Out Handle
  
  push  STD_INPUT_HANDLE
  call  _GetStdHandle@4
  mov   dword[StdInHandle],eax					; to In Handle
  
  mov   dword[DtRngSeed],0x12345678
  
  ret
 
 fShutdown:
  push  dword 0
  call  _ExitProcess@4
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Print
 
 EM    EQU 0
 LN    EQU 10
 PS    EQU 255
 
 section .bss
 IOBuffer     resd 1
 ReadBuffer   resb 4
 
 section .text
 fPrint:										; eax string to write
  xor   ebx,ebx									; [esp+4] special print parameters
  jmp   fPrintLengthLs
  fPrintLengthL:
   inc   eax
   inc   ebx
  fPrintLengthLs:
   cmp   byte [eax],PS
   je    fPrintSpecial
   cmp   byte [eax],EM
   jne   fPrintLengthL
  sub eax,ebx
  												
  push  NULL									; 5th parameter - overlapped structure (null)
  push  IOBuffer								; 4th parameter - # of bytes written
  push  ebx										; 3rd parameter - # of bytes to write
  push  eax										; 2nd parameter - string to write from
  push  dword[StdOutHandle]						; 1st parameter - handle
  call  _WriteFile@20							; call
  
  ret
  
   section .bss
   fPrintRet  resd 1
   fPrintResa resd 1
   section .text
  
  fPrintSpecial:
   push  eax
   sub   eax,ebx								; print what's so far
   push  NULL									;
   push  IOBuffer								;
   push  ebx									;
   push  eax									;
   push  dword [StdOutHandle]					;
   call  _WriteFile@20							;
   pop   eax
   
   pop   dword [fPrintRet]						; preserve return address
   inc   eax
   mov   [fPrintResa],eax						; preserve string location
   
   xor   ebx,ebx								; table the index
   mov   bl,byte[eax]							;
   shl   bx,2									;
   add   ebx,fPrintSpecialTable					;
   call  dword[ebx]								; call special print function
   
   push  dword [fPrintRet]						; restore return address
   mov   eax,[fPrintResa]						; restore string location
   inc   eax
   
   jmp fPrint									; print the rest

   section .data
   fPrintSpecialTable:
   dd    fPrintstr		;00
   dd    fPrintdec		;01
   dd    fPrinthex32	;02
   dd    fPrintbin32	;03
   dd	fPrinthex16	;04
   dd	fPrintbin16	;05
   dd    fPrinthex8 	;06
   dd    fPrintbin8 	;07
   dd    fSleep			;08
   dd    fPrintchar		;09
   						;...
   						;FE
   PSSTRNG equ 0
   PSDEC   equ 1
   PSHEX32 equ 2
   PSBIN32 equ 3
   PSHEX16 equ 4
   PSBIN16 equ 5
   PSHEX8  equ 6
   PSBIN8  equ 7
   PSSLP   equ 8
   PSCHAR  equ 9
   section .text
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;str
 
 fPrintstr:										; [esp+4] string address
  mov   eax,[esp+4]
  xor   ebx,ebx
  jmp   fPrintstrLengthLs
  fPrintstrLengthL:
   inc   eax
   inc   ebx
  fPrintstrLengthLs:
   cmp   byte [eax],EM
   jne   fPrintstrLengthL
  sub eax,ebx
  
  push  NULL
  push  IOBuffer
  push  ebx
  push  eax
  push  dword[StdOutHandle]
  call  _WriteFile@20
  
  ret   4
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;dec
 
 fPrintdec:										; [esp+4] number
  mov   ebx,fPrintbaseString					;ebx character position
  mov   eax,dword[esp+4]						;eax number
  
  test  eax,2147483648	;sign
  jns   fPrintdecSignD							; sign
   mov   byte[ebx],"-"
   inc   ebx
   not   eax
   inc   eax
  fPrintdecSignD:
  
  mov   ecx,1									; get the digit to divide by
  cmp   eax,10									;
  jl    fPrintdecDivL1							;
   mov   ecx,10									;
  cmp   eax,100									;
  jl    fPrintdecDigitD							;
   mov   ecx,100								;
  cmp   eax,1000								;
  jl    fPrintdecDigitD							;
   mov   ecx,1000								;
  cmp   eax,10000								;
  jl    fPrintdecDigitD							;
   mov   ecx,10000								;
  cmp   eax,100000								;
  jl    fPrintdecDigitD							;
   mov   ecx,100000								;
  cmp   eax,1000000								;
  jl    fPrintdecDigitD							;
   mov   ecx,1000000							;
  cmp   eax,10000000							;
  jl    fPrintdecDigitD							;
   mov   ecx,10000000							;
  cmp   eax,100000000							;
  jl    fPrintdecDigitD							;
   mov   ecx,100000000							;
  cmp   eax,1000000000							;
  jl    fPrintdecDigitD							;
   mov   ecx,1000000000							;
  fPrintdecDigitD:								;
  
  fPrintdecDivL:
   xor   edx,edx								; divide and build the string
   div   ecx									;
  fPrintdecDivL1:
   add   al,"0"									;
   mov   byte[ebx],al							;
   inc   ebx									;
   push  edx									;
   mov   eax,ecx								;
   mov   ecx,10									;
   xor   edx,edx								;
   div   ecx									;
   mov   ecx,eax								;
   pop   eax									;
   cmp   ecx,1									;
   jae   fPrintdecDivL							;
 
  sub ebx,fPrintbaseString
  push  NULL									; print the decimal number
  push  IOBuffer								;
  push  ebx										;
  push  fPrintbaseString						;
  push  dword[StdOutHandle]						;
  call  _WriteFile@20							;
  
  ret   4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;hex/bin
 
 fPrinthex32:									; [esp+4] number
  mov   cl,8									;ecx # of digits
  mov   ebx,fPrintbaseString					;ebx character position
  mov   eax,dword[esp+4]						;eax number
  												
  fPrinthex32L:									; shift and build the string
   xor   dl,dl									;
   shld  edx,eax,4								;
   shl   eax,4									
   cmp   dl,10									; 0-9 or A-F
   jae   fPrinthex32LLet						;
    add   dl,"0"								;
   jmp   fPrinthex32LNumD						;
   fPrinthex32LLet:								;
    add   dl,"A"-10								;
   fPrinthex32LNumD:							;
   mov   byte[ebx],dl							; put character
   inc   ebx									;
   dec   cl										;
   jnz   fPrinthex32L							;
   
   push  NULL
   push  IOBuffer
   push  8
   push  fPrintbaseString
   push  dword[StdOutHandle]
   call  _WriteFile@20
  
  ret   4
 
 
 
 fPrintbin32:									; [esp+4] number
  mov   cl,32									;ecx # of digits
  mov   ebx,fPrintbaseString					;ebx character position
  mov   eax,dword[esp+4]						;eax number
  												
  fPrintbin32L:									; shift and build the string
   xor   dl,dl									;
   shld  edx,eax,1								;
   shl   eax,1									;
   add   dl,"0"									;
   mov   byte[ebx],dl							; put character
   inc   ebx									;
   dec   cl										;
   jnz   fPrintbin32L							;
  
  push  NULL
  push  IOBuffer
  push  32
  push  fPrintbaseString
  push  dword[StdOutHandle]
  call  _WriteFile@20
  
  ret   4
 
 
 
 fPrinthex16:									; [esp+4] number
  mov   cl,4									;ecx # of digits
  mov   ebx,fPrintbaseString					;ebx character position
  mov   ax,word[esp+4]							;eax number
  												
  fPrinthex16L:									; shift and build the string
   xor   dl,dl									;
   shld  dx,ax,4								;
   shl   ax,4									;
   cmp   dl,10									; 0-9 or A-F
   jae   fPrinthex16LLet						;
    add   dl,"0"								;
   jmp   fPrinthex16LNumD						;
   fPrinthex16LLet:								;
    add   dl,"A"-10								;
   fPrinthex16LNumD:							;
   mov   byte[ebx],dl							; put character
   inc   ebx									;
   dec   cl										;
   jnz   fPrinthex16L							;
  
  push  NULL
  push  IOBuffer
  push  4
  push  fPrintbaseString
  push  dword[StdOutHandle]
  call  _WriteFile@20
  
  ret   4



 fPrintbin16:									; [esp+4] number
  mov   cl,16									;ecx # of digits
  mov   ebx,fPrintbaseString					;ebx character position
  mov   ax,word[esp+4]							;eax number
  												
  fPrintbin16L:									; shift and build the string
   xor   dl,dl									;
   shld  dx,ax,1								;
   shl   ax,1									;
   add   dl,"0"									;
   mov   byte[ebx],dl							; put character
   inc   ebx									;
   dec   cl										;
   jnz   fPrintbin16L							;
  
  push  NULL
  push  IOBuffer
  push  16
  push  fPrintbaseString
  push  dword[StdOutHandle]
  call  _WriteFile@20
  
  ret   4
 
 
 
 fPrinthex8:									; [esp+4] number
  mov   cl,2									;ecx # of digits
  mov   ebx,fPrintbaseString					;ebx character position
  mov   al,byte[esp+4]							;eax number
  
  fPrinthex8L:									; shift and build the string
   xor   ah,ah									;
   shl   ax,4									;
   cmp   ah,10									; 0-9 or A-F
   jae   fPrinthex8LLet							;
    add   ah,"0"								;
   jmp   fPrinthex8LNumD						;
   fPrinthex8LLet:								;
    add   ah,"A"-10								;
   fPrinthex8LNumD:								;
   mov   byte[ebx],ah							; put character
   inc   ebx									;
   dec   cl										;
   jnz   fPrinthex8L							;
  
 push  NULL
 push  IOBuffer
 push  2
 push  fPrintbaseString
 push  dword[StdOutHandle]
 call  _WriteFile@20
 
 ret   4
 
 
 
 fPrintbin8:									; [esp+4] number
  mov   cl,8									;ecx # of digits
  mov   ebx,fPrintbaseString					;ebx character position
  mov   al,byte[esp+4]							;eax number
  
  fPrintbin8L:									; shift and build the string
   xor   ah,ah									;
   shl   ax,1									;
   add   ah,"0"									;
   mov   byte[ebx],ah							; put character
   inc   ebx									;
   dec   cl										;
   jnz   fPrintbin8L							;
  
   push  NULL
   push  IOBuffer
   push  8
   push  fPrintbaseString
   push  dword[StdOutHandle]
   call  _WriteFile@20
   
   ret   4
  
   section .bss
   fPrintbaseString resb 32
   section .text
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;char
 
 fPrintchar:
  xor   eax,eax
  mov   al,byte[esp+4]
  add   eax,tChars
  
  push  NULL
  push  IOBuffer
  push  1
  push  eax
  push  dword[StdOutHandle]
  call  _WriteFile@20
  
  ret 4
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Input
 
 fInput1:
  push  NULL
  push  IOBuffer
  push  1
  push  tChars+":"
  push  dword[StdOutHandle]
  call  _WriteFile@20
  
  push  dword[StdInHandle]
  call  _FlushFileBuffers@4
  
  xor   ebx,ebx
  
  fInput1L:
   push  NULL									; 5th parameter - overlapped structure (null)
   push  IOBuffer								; 4th parameter - # of bytes read
   push  dword 3								; 3rd parameter - # of bytes to read
   push  ReadBuffer								; 2nd parameter - string to read to
   push  dword[StdInHandle]						; 1st parameter - handle
   call  _ReadFile@20							; call
   
   cmp   word[ReadBuffer+1],0x0A0D
   je    fInput1LD
   mov   ebx,-1
   cmp   dword[IOBuffer],2
   jbe   fInput1LD
   jmp   fInput1L
   
  fInput1LD:
  mov  eax,-1
  cmp  ebx,-1
  je   fInput1D
  mov  al,byte[ReadBuffer]
  
  fInput1D:
  ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Sleep
 
 SLEEPLEN          EQU 500
 
 fSleep:
  push dword SLEEPLEN
  call _Sleep@4
  
  ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Rand
 
 section .bss
 DtRngSeed    resd 1
 
 section .text
 fRand32:
  mov   eax,dword[DtRngSeed]
  mov   edx,1103515245
  mul   edx
  shl   edx,16
  add   eax,12345
  adc   edx,0xFFFF
  mov   dword[DtRngSeed],eax
  shr   eax, 16
  and   edx,0xFFFF0000
  or    eax,edx
  ret
 
 
 
 fRandCapp8:
  push  eax
  
  mov   eax,dword[DtRngSeed]
  mov   edx,1103515245
  mul   edx
  shl   edx,16
  add   eax,12345
  adc   edx,0xFFFF
  mov   dword[DtRngSeed],eax
  shr   eax, 16
  and   edx,0xFFFF0000
  or    eax,edx
  
  and  eax,0x000000FF
  pop   edx
  div   dl
  mov   al,ah
  
  ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;