;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Do

 section .text
 BTfDo:
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Wincheck
  
  BTfDoWincheck:								
   mov   eax,FId								 ;eax fighter1
   BTfDoWincheckL:								 ;Check each fighter to see if any fighters are hostile with them
    mov   al,FIFl								 ;
    test  byte[eax],FIFlCNS						 ; if fighter1 is unconscious>
    jz    BTfDoWincheckL1						 ; >skip fighter1
    											 
    mov   ebx,FId+FIFl							  ;ebx fighter2
    BTfDoWincheckLL:							  ;Check each fighter to see if they are hostile with fighter1
     mov   bl,FIFl								  ;
     test  byte[ebx],FIFlCNS					  ; if fighter2 is unconscious>
     jz    BTfDoWincheckLL1						  ; >skip fighter2
     											  
     cmp   bh,ah								  ; if fighter2 is fighter1>
     je    BTfDoWincheckLL1						  ; >skip fighter2
     											  
     mov   bl,FIHostl							  ; if fighter2 is hostl with fighter1>
     mov   ecx,dword[ebx]						  ;
     mov   dl,ah								  ;
     cmp   dl,0									  ;
     jz    BTfDoWincheckLL2b					  ;
     BTfDoWincheckLL2a:							  ;
     shr   ecx,1								  ;
     dec   dl									  ;
     jnz   BTfDoWincheckLL2a					  ;
     BTfDoWincheckLL2b:							  ;
     test  ecx,0x01								  ;
     jnz   BTfDoWincheckD						  ; >the fight continues
    											  
     BTfDoWincheckLL1:							  ; skip fighter2
     inc   bh									  ;
     cmp   bh,FIdCOUNT							  ; if figther2 is not the last fighter>
     jb    BTfDoWincheckLL						  ;>loop
    											 
    BTfDoWincheckL1:							 ; skip fighter1
    inc   ah									 ;
    cmp   ah,FIdCOUNT							 ; if fighter1 is not the last fighter>
    jb    BTfDoWincheckL						 ;>loop
   												
   jmp   BTfDoEndL								; the fight is over
   												
   BTfDoWincheckD:								; the fight continues
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Preturn
  
  BTfDoPreturn:									
   BTfDoPreturnL:								 ;Let each ready figher Preturn in the order of their speed
   mov   edx,0x01								 ;edx currentFIflag
   mov   ecx,FId								 ;ecx fighter
   mov   ebx,0xFFFFFFFF							 ;ebx FIflags
   mov   eax,FId								 ;al  bestspeed; ah  bestfighterindex
   												 
    BTfDoPreturnLLa:							  ;Reset ready fighters in FIflags
     											 
     mov   cl,FIFl								  ; if fighter is unconscious>
     test  byte[ecx],FIFlCNS					  ;
     jz    BTfDoPreturnLL1						  ; >skip fighter
     											  
     mov   cl,FIFl								  ; if fighter is ready>
     test  byte[ecx],FIFlRDY					  ;
     jnz   BTfDoPreturnLL1						  ; >skip fighter
     											  
     not   edx									  ; reset fighter flag
     and   ebx,edx								  ;
     not   edx									  ;
     											  
     BTfDoPreturnLL1:							  ; skip fighter
     inc   ch									  ;
     shl   edx,1								  ; if currentFIflag is not complete>
     jnz   BTfDoPreturnLLa						  ;>loop
    											 
    cmp   ebx,0xFFFFFFFF						 ; if every fighter is ready> 
    je    BTfDoTurn								 ;>end preturn
    											  
    mov   edx,0x01								  ;edx currentFIflag
    xor   ch,ch									  ;ch  fighterindex
    BTfDoPreturnLLb:							  ;Find the ready fighter with the most speed
     											  
     test  ebx,edx								  ; if FIflags contains currentFIflag>
     jnz   BTfDoPreturnLLb1						  ; >skip fighter
     											  
     mov   cl,FIFl								  ; if fighter is unconscious>
     test  byte[ecx],FIFlCNS					  ;
     jz    BTfDoPreturnLLb1						  ; >skip fighter
     											  
     mov   cl,FISpeed							  ; if fighterspeed is less than bestspeed>
     cmp   byte[ecx],al							  ;
     jb    BTfDoPreturnLLb1						  ; >skip fighter
     											  
     mov   al,byte[ecx]							  ; bestspeed
     mov   ah,ch								  ; bestfighterindex
     											 
     BTfDoPreturnLLb1:							  ; skip fighter
     inc   ch									  ; fighterindex
     shl   edx,1								  ; currentFIflag; if complete>
     jnz   BTfDoPreturnLLb						  ;>loop
    											 
    mov   al,FIFl								 ; set bestfighter rdy
    or    byte[eax],FIFlRDY						 ;
    											 
    mov   ebx,FIpPreturn						 ;Fighter Preturn
    xor   ecx,ecx								 ;
    mov   al,FICl								 ;;move FICl to ecx
    mov   cl,byte[eax]							 ;;
    mov   al,FIFl								 ;;
    mov   ch,byte[eax]							 ;;
    and   ch,0x3F								 ;;
    shl   ecx,2									 ;
    add   ebx,ecx								 ;
    push  eax									 ;fighter
    call  [ebx]									 ; Preturn
    											 
    jmp   BTfDoPreturnL							 ;>loop
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Turn
  
  BTfDoTurn:
   BTfDoTurnL:									 ;Let each ready figher Turn in the order of their speed
   mov   edx,0x01								 ;edx currentFIflag
   mov   ecx,FId								 ;ecx fighter
   mov   ebx,0xFFFFFFFF							 ;ebx FIflags
   mov   eax,FId								 ;al  bestspeed; ah  bestfighterindex
   												 
    BTfDoTurnLLa:								  ;Reset ready fighters in FIflags
     											 
     mov   cl,FIFl								  ; if fighter is unconscious>
     test  byte[ecx],FIFlCNS					  ;
     jz    BTfDoTurnLL1							  ; >skip fighter
     											  
     mov   cl,FIFl								  ; if fighter is not ready>
     test  byte[ecx],FIFlRDY					  ;
     jz    BTfDoTurnLL1							  ; >skip fighter
     											  
     not   edx									  ; reset fighter flag
     and   ebx,edx								  ;
     not   edx									  ;
     											  
     BTfDoTurnLL1:								  ; skip fighter
     inc   ch									  ;
     shl   edx,1								  ; if currentFIflag is not complete>
     jnz   BTfDoTurnLLa							  ;>loop
    											 
    cmp   ebx,0xFFFFFFFF						 ; if no fighter is ready> 
    je    BTfDoWincheck							 ;>end turn
    											  
    mov   edx,0x01								  ;edx currentFIflag
    xor   ch,ch									  ;ch  fighterindex
    BTfDoTurnLLb:								  ;Find the ready fighter with the most speed
     											  
     test  ebx,edx								  ; if FIflags contains currentFIflag>
     jnz   BTfDoTurnLLb1						  ; >skip fighter
     											 
     mov   cl,FIFl								  ; if fighter is unconscious>
     test  byte[ecx],FIFlCNS					  ;
     jz    BTfDoTurnLLb1						  ; >skip fighter
     											 
     mov   cl,FISpeed							  ; if fighterspeed is less than bestspeed>
     cmp   byte[ecx],al							  ;
     jb    BTfDoTurnLLb1						  ; >skip fighter
     											  
     mov   al,byte[ecx]							  ; bestspeed
     mov   ah,ch								  ; bestfighterindex
     											 
     BTfDoTurnLLb1:								  ; skip fighter
     inc   ch									  ; fighterindex
     shl   edx,1								  ; currentFIflag; if complete>
     jnz   BTfDoTurnLLb							  ;>loop
    											 
    mov   al,FIFl								 ; reset bestfighter rdy
    and   byte[eax],~FIFlRDY					 ;
    											 
    mov   ebx,FIpTurn							 ;Fighter Turn
    xor   ecx,ecx								 ;
    mov   al,FICl								 ;;move FICl to ecx
    mov   cl,byte[eax]							 ;;
    mov   al,FIFl								 ;;
    mov   ch,byte[eax]							 ;;
    and   ch,0x3F								 ;;
    shl   ecx,2									 ;
    add   ebx,ecx								 ;
    push  eax									 ;fighter
    call  [ebx]									 ; Turn
    											 
    jmp   BTfDoTurnL							 ;>loop
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;End
 
 BTfDoEndL:
  mov  eax,tEnd
  call fPrint
  
  ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;