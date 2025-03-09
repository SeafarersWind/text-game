FIBG: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 FIBGhp   equ 8
 FIBGtrgt equ 14
 FIBGmove equ 15
 FIBGname equ 16
 
 FIBGtarget equ 20
 
 section .data
 
 .tLunge  db PS,PSSTR," lunges at ",PS,PSSTR,"!",Ln,PS,PSSLP,EM
 .tHurt   db PS,PSSTR," takes ",PS,PSDEC," damage!",Ln,PS,PSSLP,EM
 .tDodge  db "Miss!",Ln,PS,PSSLP,EM
 .tDie    db PS,PSSTR," collapses...",Ln,PS,PSSLP,PS,PSSLP,EM
 
 section .text
 
FIBGfTurn: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;[esp+4] self
 
 mov  ebx,[esp+4]								;Move table
 mov  eax,[eax+FIBGmove]						;ebx self
 cmp  eax,.movesD-.moves						;eax move
jmp .lunge
 ja   .movesF									;
 jmp  [eax+.moves]								;
  section .data									;
  .moves:										;
  dd .lunge	;1									;
  .movesF equ .nomove							;
  .movesD:										;
  section .text									;
 
 .lunge:										;Lunge!
 pop  eax										; ret
 mov  edx,field									;
 mov  dl,[ebx+FIBGtrgt]							;
 push dword[edx]								;[esp+4] target
 push eax										; ret
 
 mov  edx,[edx]									;
 push dword[edx+FINRname]						;
 mov  edx,[esp+12]								;
 push dword[edx+FINRname]						;
 mov  eax,FIBG.tLunge							;
 call fPrint									;
 
 mov  eax,20|(172<<16)|(0x01<<24)				;ax damage ;ual precision
 
 ;distance
 ;direction
 ;target's agility
 
 ;hit
 
 
 ;attack
 ;react
 ;resolve
 ; hit
 ; resolve
 
 ;ebx:eax
 ;.... .... .... .... .... .... .... .... .... .... .... .... .... .... .... ....
 ;                                                            precision damage---
 
 jmp  FIfRecieve
 
 .nomove:										;...
 
 ret 4

FIBGfPreturnln: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 call fPrintln
 FIBGfPreturn:
 ;[esp+4] self
 
 ret 4
  
FIBGfRecieve: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;[esp+4] self
 ;[esp+8] sender
 ;ebx:eax effect
 
 push eax										;Miss?
 call fRandom64									;
 pop  eax										;
 push eax										;
 shr  eax,16									;
 cmp  ax,dx										;
 ja   .miss										;
 
 pop  eax										;
 and  eax,0xFFFF								;
 push eax										;
 
 push eax										;Print the message
 mov  eax,[esp+4+8]								;
 push dword[eax+FIBGname]						;
 mov  eax,FIBG.tHurt							;
 call fPrint									;
 
 pop  eax										;
 
 mov  ebx,[esp+4]								;Check if it kills
 cmp  [ebx+FIBGhp],ax							;
 jbe  .dies										;
 
 sub  [ebx+FIBGhp],ax							;Hurt
 
 ret 8
 
 .miss:											;
  pop  eax										;
  mov  eax,FIBG.tDodge							;
  call fPrint									;
  
  ret 8
 
 .dies:											;Die
  mov  word[ebx+FIBGhp],0						;
  and  byte[ebx+FIfl],~FIfl.c					;
  
  push dword[ebx+FIBGname]						;
  mov  eax,FIBG.tDie							;
  call fPrint									;
 
 ret 8
 
 
 
 ; eax ................................
 ; ebx ................................
 ; ...?
 ;
 ; approach
 ;  speed
 ;  direction
 ;  visuality
 ; force
 ;  nature
 ;  magnitude
 
 ret 8
 
FIBGfHurt: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;