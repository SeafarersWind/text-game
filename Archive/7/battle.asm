BA: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .data
 
 tVictory db "Whew!",Ln,PS,PSSLP,PS,PSSLP,Ln,0
 tDefeat  db "Abby is done for...",Ln,PS,PSSLP,PS,PSSLP,Ln,0
 
 section .text
 
BAfFight: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 call beat									;
 call BAfEndcheck							;
 
 mov  ebx,field-4							;
 .L:										;
  times 4 inc ebx							;
  cmp  ebx,0x20								;
  je   .LD									;
  cmp  ebx,0								;
  je   .L									;
  mov  eax,[ebx]							;
  and  byte[eax+FIfl],~FIfl.r				;
  .LD:										;
 
 BAfFight.Preturn: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  .L:
   mov  edx,field+0xFC							;edx current fighter
   mov  cx,0x0080								;cl  best fighter index; ch  highest initiative
   
   .LL:											;Let each fighter Preturn in the order of their initiative
    cmp  dl,0x7C								;
    je   .LLD									;
    inc  dl										;
    inc  dl										;
    inc  dl										;
    inc  dl										;
    mov  eax,[edx]								;
    cmp  eax,0									; if fighter is not real>
    jz   .LL									; >skip fighter
    times FIfl inc eax							;
    test byte[eax],FIfl.c						; if fighter is unconscious>
    jz   .LL									; >skip fighter
    test byte[eax],FIfl.r						; if fighter is ready
    jnz	.LL										; >skip fighter
    times FIinit-FIfl inc eax					; if fighter has lower or equal initiative>
    mov  bl,[eax]								; 
    cmp  bl,ch									; 
    jbe  .LL									; >skip fighter
    
    mov  ch,bl									; replace highest initiative
    mov  cl,dl									; replace best fighter index
    jmp  .LL									; >skip fighter
    .LLD:										;
   
   cmp  cl,0x80									; if all fighters are ready>
   je   .LD										; >move on
   
   mov  dl,cl									;
   xor ebx,ebx									;
   mov  eax,[edx]								;
   push eax										; fighter
   or   byte[eax+FIfl],FIfl.r					; ready the fighter
   mov  bx,[eax]								;
   shl  bx,2									; edx fighters+fighter index
   add  ebx,FIpPreturns							; eax fighter+clss
   call [ebx]									;fighter.preturn
   
   jmp  .L										; >loop
   .LD:											;
  
 BAfFight.Turn: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  .L:
   mov  edx,field+0xFC							;edx current fighter
   mov  cx,0x0080								;cl  best fighter index; ch  highest initiative
   
   .LL:											;Let each fighter Turn in the order of their initiative
    cmp  dl,0x7C								;
    je   .LLD									;
    inc  dl										;
    inc  dl										;
    inc  dl										;
    inc  dl										;
    mov  eax,[edx]								;
    cmp  eax,0									; if fighter is not real>
    jz   .LL									; >skip fighter
    times FIfl inc eax							;
    test byte[eax],FIfl.c						; if fighter is unconscious>
    jz   .LL									; >skip fighter
    
    test byte[eax],FIfl.r						; if fighter is not ready
    jz 	.LL										; >skip fighter
    
    times FIinit-FIfl inc eax					; if fighter has lower or equal initiative>
    mov  bl,[eax]								; 
    cmp  bl,ch									; 
    jbe  .LL									; >skip fighter
    
    mov  ch,bl									; replace highest initiative
    mov  cl,dl									; replace best fighter index
    jmp  .LL									; >skip fighter
    .LLD:										;
   
   cmp  cl,0x80									; if all fighters are ready>
   je   .LD										; >move on
   
   mov  dl,cl									;
   xor  ebx,ebx									;
   mov  eax,[edx]								;
   push eax										; fighter
   and  byte[eax+FIfl],~FIfl.r					; unready the fighter
   mov  bx,[eax]								;
   shl  bx,2									; edx fighters+fighter index
   add  ebx,FIpTurns							; eax fighter+clss
   call [ebx]									;fighter.turn
   
   call beat									;
   call BAfEndcheck								;
   
   jmp  .L										;
   .LD:											;
  
 jmp  BAfFight.Preturn							; >next round
 
BAfEndcheck: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
 xor  cx,cx										;cl  fighter1 index; ch  fighter2 index
 .L:											;Check each fighter to see if any fighters are hostile with them
  mov  eax,field								;
  mov  al,cl									;
  mov  eax,[eax]								;
  cmp  eax,0									; if fighter1 is not real>
  jz   .L1										; >skip fighter1
  times FIfl inc eax							;
  test byte[eax],FIfl.c							; if fighter1 is unconscious>
  jz   .L1										; >skip fighter1
  
  .LL:											;Check each fighter to see if they are hostile with fighter1
   mov  eax,field								;
   mov  al,ch									;
   mov  eax,[eax]								;
   cmp  eax,0									; if fighter2 is not real>
   jz   .LL1									; >skip fighter2
   times FIfl inc eax							;
   test byte[eax],FIfl.c						; if fighter2 is uconscious>
   jz   .LL1									; >skip fighter2
   
   cmp  ch,cl									; if fighter2 is fighter1>
   jz   .LL1									; >skip fighter2
   
   add  eax,FIhstl-FIfl							; if fighter2 is hostile with fighter1>
   mov  ebx,[eax]								;
   mov  dl,cl									;
   cmp  dl,0									;
   jz   .LL2b									;
   .LL2a:										;
   shr  ebx,1									;
   dec  dl										;
   jnz  .LL2a									;
   .LL2b:										;
   test ebx,0x01								;
   jnz  .D										; >the fight continues
   
   .LL1:										; skip figher2
   inc  ch										;
   inc  ch										;
   inc  ch										;
   inc  ch										;
   cmp  ch,0x80									; if fighter2 is not the last fighter>
   jb   .LL										; >loop
  
  .L1:											; skip figher1
  xor  ch,ch									;
  inc  cl										;
  inc  cl										;
  inc  cl										;
  inc  cl										;
  cmp  cl,0x80									; if fighter1 is not the last fighter>
  jb   .L										; >loop
  
 inc esp
 inc esp
 inc esp
 inc esp
 jmp BAfFight.End								; the fight is over
 
 .D:											; the fight continues
 ret


 BAfFight.End: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 test byte[dFI.one+FIfl],FIfl.c
 je   .defeat
 
 mov  eax,tVictory
 call fPrint
 
 ret
 
 .defeat:
 mov  eax,tDefeat
 call fPrint
 
 jmp  fShutdown
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;