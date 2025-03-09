DT: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .data
 
dFI: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 .one:
  dw 0x0001
  db 00000101b
  db 0xFF
  dd 0x0000000E
  dw 0x0100
  dw 0x0008
  dw 0x0008
  dw 0x0008
  dd tAbby
  db 0
 
 .replenish:
  mov  dword[.one],    0xFF050001
  mov  dword[.one+4],  0x0000000E
  mov  dword[.one+8],  0x00080100
  mov  dword[.one+12], 0x00080008
  mov  dword[.one+16], tAbby
  
  ret
 
dMo: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .bss
 
 .first:
  resd 6
 
 .second:
  resd 6
 
 .third:
  resd 6
 
 section .text
 
 .replenish:
  mov  dword[.first],    0x01010001
  mov  dword[.first+4],  0x00000001
  mov  dword[.first+8],  0x0003000A
  mov  dword[.first+12], 0x00000000
  mov  dword[.first+16], tGoblin1
  
  mov  dword[.second],   0x01010001
  mov  dword[.second+4], 0x00000001
  mov  dword[.second+8], 0x0002000C
  mov  dword[.second+12],0x00000000
  mov  dword[.second+16],tGoblin2
  
  mov  dword[.third],    0x01010001
  mov  dword[.third+4],  0x00000001
  mov  dword[.third+8],  0x00040007
  mov  dword[.third+12], 0x00000000
  mov  dword[.third+16], tGoblin3
  
  ret
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 tAbby db "Abby",0
 tGoblin1 db "Sweet Goblin",0
 tGoblin2 db "Sour Goblin",0
 tGoblin3 db "Spicy Goblin",0
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;