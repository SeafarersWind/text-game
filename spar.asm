section .bss

FIELD_SIZE equ FIELD_SPOT_SIZE*32
;field resd 512

section .data

 field:
  db 11100000b	;exists|conscious|combative
  db 0	; posture
  dw 0	;range / hit|parry
  db 0	;speed
  db 0	;block
  db 0	;power
  db 0	;sharp
  dd hero
  
 FIELD_SPOT_SIZE equ $-field
  
  db 11100000b	;exists|conscious|combative
  db 0	; posture
  dw 0	;range / hit|parry
  db 0	;speed
  db 0	;block
  db 0	;power
  db 0	;sharp
  dd enemy
  
FIELD_END equ $
  times FIELD_SIZE-($-field) db 0

distance db 0, 0

tHero db "Hero",0
tRag db "Rag",0

entities:
ENTITY_SIZE equ enemy-hero
; status name hp at df sp
hero:
 dd tHero	;name
 db 30,30	;hp
 db 4	;reflex
 db 4	;might
 db 4	;fortitude
 db 4	;endurance
enemy:
 dd tRag	;name
 db 20,30	;hp
 db 4	;reflex
 db 4	;might
 db 4	;fortitude
 db 4	;endurance

moves:
 moves.general:
  .evade:
   dd tEvade
   db -2	;posture cost
   db -2	;motion
   db 0,0	;range
   db 5		;speed
   db 0		;block
   db 0		;power
   db 0		;sharpness
 moves.sword:
  .slash:
   dd tSlash
   db 1		;posture cost
   db 1		;motion
   db 1,3	;range
   db 4		;speed
   db 2		;block
   db 3		;power
   db 2		;sharpness
  .stab:
   dd tStab
   db 2		;posture cost
   db 2		;motion
   db 2,4	;range
   db 5		;speed
   db 1		;block
   db 3		;power
   db 3		;sharpness
  .lunge:
   dd tLunge
   db 4		;posture cost
   db 3		;motion
   db 1,4	;range
   db 3		;speed
   db 0		;block
   db 6		;power
   db 4		;sharpness
  .guard:
   dd tGuard
   db -1	;posture cost
   db 0		;motion
   db 1,3	;range
   db 5		;speed
   db 5		;block
   db 0		;power
   db 0		;sharpness
 
 tEvade db "Evade",0
 tSlash db "Slash",0
 tStab  db "Stab",0
 tLunge db "Lunge",0
 tGuard db "Guard",0
 tPremenu db "distance: "
  .num db               0,10,10

section .text

spar: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 mov  al,byte[distance]
 test al,0x80
 jz   .farenough
  not al
  inc al
 .farenough:
 mov  byte[distance],al
 mov  byte[distance+1],al
 
 
 mov  ebx,field
 spar.prepL:
  mov  al,byte[ebx]
  shr  al,5
  cmp  al,00000111b
  jnz  .skip
   
   push ebx
   mov  al,byte[distance+1]
   and  ax,0xFF
   mov  dl,10
   div  dl
   test al,~0
   jnz  .farther
    add  ah,'0'
    mov  [tPremenu.num],ah
    mov  byte[tPremenu.num+1],10
    mov  ecx,12
    jmp  .fartherD
   .farther:
    add  al,'0'
    mov  [tPremenu.num],al
    add  ah,'0'
    mov  [tPremenu.num+1],ah
    mov  ecx,13
    .fartherD:
   push 0
   push buffer
   push ecx
   push tPremenu
   push dword[hStdoutput]
   call _WriteFile@20
   mov  dword[buffer+512],   tEvade
   mov  dword[buffer+512+4], 0
   mov  dword[buffer+512+8], tSlash
   mov  dword[buffer+512+12],1
   mov  dword[buffer+512+16],tStab
   mov  dword[buffer+512+20],2
   mov  dword[buffer+512+24],tLunge
   mov  dword[buffer+512+28],3
   mov  dword[buffer+512+32],tGuard
   mov  dword[buffer+512+36],4
   mov  dword[buffer+512+40],~0
   mov  eax,buffer+512
   call menu
   pop  ebx
   
   shl  eax,2
   mov  edx,eax
   shl  eax,1
   add  eax,edx		;ebx actor
   add  eax,moves	;eax move
   mov  dl,[eax+4]	;posture cost
   sub  [ebx+1],dl
   mov  dl,[eax+5]	;motion
   sub  [distance],dl
   mov  dx,[eax+6]	;range
   mov  [ebx+2],dx
   mov  dl,[eax+8]	;speed
   mov  [ebx+4],dl
   mov  dl,[eax+9]	;block
   mov  [ebx+5],dl
   mov  dl,[eax+10]	;power
   mov  [ebx+6],dl
   mov  dl,[eax+11]	;sharpness
   mov  [ebx+7],dl
   
  .skip:
  add  ebx,FIELD_SPOT_SIZE
  cmp  ebx,FIELD_END
  jb   spar.prepL
  .D:
 
 
 
 mov  ebx,field
 spar.actL:
  mov  al,byte[ebx]	;status
  shr  al,5
  cmp  al,00000111b
  jnz  .skip
   
  mov  ax,[ebx+2]	;range
  mov  word[ebx+2],0
  cmp  ah,[distance]
  jb   .skip
  cmp  al,[distance]
  ja   .skip
   
    mov  ecx,field
   cmp  ebx,field
   jne  .1
    mov  ecx,field+FIELD_SPOT_SIZE
   .1:				;ecx target
   
   mov  al,[ebx+4]	;speed
   mov  ah,al
   shr  ah,1
   add  al,ah
   inc  al
   sub  al,[ecx+4]	;target's speed
   jc   .zerohit
   mov  [ebx+2],al	;hit
   .zerohit:
    
   mov  al,[ebx+5]	;block
   mov  dl,[ecx+6]	;target's power
   sub  al,dl
   jc   .zeroparry
   mov  [ebx+3],al	;parry
   .zeroparry:
   
;push ebx
;mov  al,[ebx+2]
;and  eax,0xFF
;push eax
;mov  eax,tDec
;call print
;pop  ebx
    
  .skip:
  add  ebx,FIELD_SPOT_SIZE
  cmp  ebx,FIELD_END
  jb   spar.actL
  .D:
 
 
 
 mov  ebx,field
 spar.clashL:
  mov  al,byte[ebx]
  shr  al,5
  cmp  al,00000111b
  jnz  .skip
   
    mov  ecx,field
   cmp  ebx,field
   jne  .1
    mov  ecx,field+FIELD_SPOT_SIZE
   .1:				;ecx target
  
  mov  al,[ebx+2]	;hit
  cmp  al,[ecx+3]	;target's parry
  jbe  .skip
   
   mov  ah,[ebx+7]	;sharpness
   add  al,[ebx+6]	;power
   shr  al,1
   inc  al
   mul  ah
   
   push ebx
   push ecx
   and  eax,0x0000FFFF
   push eax
   mov  eax,[ecx+8]		;character data
   push dword[eax+0]	;character name
   mov  eax,tGetsHit
   call print	;"target takes ax damage!"
   pop  ecx
   pop  ebx
   
   mov  al,[ebx+2]	;hit
   mov  ah,[ebx+6]	;power
   mul  ah
   test ah,~0
   jnz  .killposture
   sub  [ecx+1],al	;target's posture
   jae  .killpostureD
   .killposture:
    mov  byte[ecx+1],0
    .killpostureD:
    
  .skip:
  add  ebx,FIELD_SPOT_SIZE
  cmp  ebx,FIELD_END
  jb   spar.clashL
  .D:
 
 jmp beat
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;