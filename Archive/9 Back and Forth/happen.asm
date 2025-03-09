section .text
happen: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;[eax] action
eSGT equ 0x00000000
eETR equ 0x20000000
eENC equ 0x40000000
eCON equ 0x80000000
eMEN equ 0xC0000000
eEND equ 0xFFFFFFFF
 
 mov  edx,[eax]
 cmp  edx,0xFFFFFFFF
 je   beat
 
 test edx,0x80000000
 jnz  .condition
 
 test edx,0x40000000
 jnz  .encounter
 
 test edx,0x20000000
 jnz  .entry
 
 .sight:
  push eax
  mov  eax,edx
  call print
  pop  eax
  
  add  eax,4
  jmp  happen
 
 .entry:
  and  edx,~0x20000000
  add  edx,w
  mov  [location],edx
  mov  edx,[eax+4]
  mov  [area],edx
  
  add  eax,8
  jmp  happen
 
 .encounter:
  
  add  eax,4
  jmp  happen
 
 .condition:
  test edx,0x40000000
  jnz  .menu
  
  add  eax,4
  jmp  happen
 
 .menu:
;|
menu: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;eax menu
 
 add  eax,4
 jmp  happen
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;