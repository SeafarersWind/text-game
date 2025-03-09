BT: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .bss
 
 ;align 0x100
 .f resd 0x20
 
 section .text
 
BTfFight: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 BTfFight.Endcheck: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  xor  cx,cx									;cl  fighter1 index; ch  fighter2 index
  .L:											;Check each fighter to see if any fighters are hostile with them
   mov  eax,BT.f								;
   mov  al,cl									;
   mov  eax,[eax]								;
   add  eax,FIfl								;
   test byte[eax],FIflag.bC						; if fighter1 is unconscious>
   jz   .L1										; >skip fighter1
   
   .LL:											;Check each fighter to see if they are hostile with fighter1
    mov  eax,BT.f								;
    mov  al,ch									;
    mov  eax,[eax]								;
    add  eax,FIflag								;
    test byte[eax],FIflag.bC					; if fighter2 is uconscious>
    jz   .LL1									; >skip fighter2
    
    cmp  ch,cl									; if fighter2 is fighter1>
    jz   .LL1									; >skip fighter2
    
    add  eax,FIhstl-FIflag						; if fighter2 is hostile with fighter1>
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
    cmp  ch,0x80								; if fighter2 is not the last fighter>
    jb   .LL									; >loop
   
   .L1:											; skip figher1
   inc  cl										;
   inc  cl										;
   inc  cl										;
   inc  cl										;
   cmp  cl,0x80									; if fighter1 is not the last fighter>
   jb   .L										; >loop
   
  jmp BTfFight.End								; the fight is over
  
  .D:											; the fight continues
  
 BTfFighter.Turn: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  .L
   mov  edx,BT.f-4								;edx current fighter
   mov  cx,0x0080								;cl  best fighter index; ch  highest initiative
   
   .LL:											;Let each fighter Preturn in the order of their initiative
    cmp  edx,BT.f+0x7C							;
    je   .LLD									;
    inc  edx									;
    inc  edx									;
    inc  edx									;
    inc  edx									;
    mov  eax,[edx]								; if fighter is unconscious>
    add  eax,FIfl								;
    test [eax],FIfl.bc							;
    jz   .LL									; >skip fighter
    
    test [eax],FIfl.br							; if fighter is ready
    jnz	.LL										; >skip fighter
    
    add  eax,FIinit-FIfl						; if fighter has lower or equal initiative>
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
   mov  eax,[edx]								;
   add  eax,FIclss								;
   mov  ebx,[eax]								;
   shl  ebx,2									;
   push edx										;
   push eax										;
   push ebx										; edx fighters+fighter index
   add  ebx,FIpPreturns							; eax fighter+clss
   call [ebx]									;fighter.preturn
   
   pop  ebx										;
   pop  eax										;
   pop  edx										;
   pop  edx										; edx fighters+fighter index
   add  ebx,FIpTurns							; eax fighter+clss
   call [ebx]									;fighter.turn
   .LD:											;
  
 jmp  BTfFight.Endcheck							; >next round
  
 BTfFight.End: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;