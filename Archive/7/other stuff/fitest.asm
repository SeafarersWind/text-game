FINR: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 FINRhp equ 8
 FINRat equ 10
 
 section .data
 
 .tAttack db PS,PSDEC," attacks ",PS,PSDEC,"!",PS,PSSLP,Ln,EM
 .tHurt   db PS,PSDEC," takes ",PS,PSDEC," damage from ",PS,PSDEC,"!",PS,PSSLP,Ln,EM
 .tDie    db PS,PSDEC," dies...",PS,PSSLP,PS,PSSLP,Ln,EM
 
 section .text
 
FINRfTurn: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; eax fighter; dl fighter i
 
 push eax
 push edx
 
 times FIhstl inc eax							;
 mov  eax,[eax]									;
 call FDfGetconscioushostilewithfighters		; pick a fighter to attack
 call fRandom64									;
 xor  edx,edx									;
 mov  dl,[_bufferer]							;
 and  ax,0xFF									;
 div  dl										;
 mov  dl,ah										;
 mov  ebx,_bufferer+1							;
 add  ebx,edx									;
 mov  edx,field									;
 mov  dl,[ebx]									;dl target i
 
 pop  ebx										;
 mov  dh,bl										;dh sender i
 
 push edx										;
 xor  ebx,ebx									;
 mov  bl,dl										;
 push ebx										; target i
 mov  bl,dh										;
 push ebx										; sender i
 mov  eax,FINR.tAttack							;
 call fPrint									; print message
 pop  edx										;
 
 pop  ebx										;
 xor  ecx,ecx									;
 add  ebx,FINRat								; get at
 mov  cx,[ebx]									;ecx damage
 sub  ebx,FINRat								;ebx sender
 
 mov  eax,field									;
 mov  al,dl										;
 mov  eax,[eax]									;eax target
 xor  edi,edi									;
 mov  di,[eax]									;
 shl  di,2										;
 add  edi,FIpRecieves							;
 jmp  [edi]										;recieve
 
 ret
 
FINRfPreturn: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 ret
 
FINRfRecieve: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; eax fighter; ebx sender; ecx damage; dl fighter i; dh sender i
 
 push eax										;
 push ecx										;
 xor  ebx,ebx									;
 mov  bl,dh										;
 and  edx,0xFF									;
 push edx										;
 push ebx										; sender
 push ecx										; damage
 push edx										; fighter
 mov  eax,FINR.tHurt							;
 call fPrint									; print the message
 pop  edx										;
 pop  ecx										;
 pop  eax										;
 
 add  eax,FINRhp								;
 cmp  [eax],cx									;
 jbe  .dies										;
 sub  [eax],cx									;
 
 ret
 
 .dies:											;
  mov  word[eax],0								;
  add  eax,FIfl-FINRhp							;
  and  byte[eax],~FIfl.c						;
  
  and  edx,0xFF									;
  push edx										;
  mov  eax,FINR.tDie							;
  call fPrint									;
 
 ret
 
FINRfHurt: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;