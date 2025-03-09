DT: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .data
 
Dhero: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 .visions:
  dd 0
  dd 0
  dd 0
  dd 0
  
  times 0x4000-($-.visions) db 0
  .visionsD:
 
 .k:
 
dFI: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 .one:
  dw 0x0001				;class
  db 00000101b			;flags
  db 0xFF				;initiative
  dd 0xFFFFFFFE			;hostility
  dd tAbby				;name
  dw 0x0032				;hp
  dw 0x0006				;at
  dd 0					;st
  dd 0					;move
  db 1,2,0,3,0,0,0,0	;moves
  dd 0					;weapon
 
 .replenish:
  mov  dword[.one],    0xFF050001
  mov  dword[.one+4],  0xFFFFFFFE
  mov  dword[.one+8],  tAbby
  mov  dword[.one+12], 0x00060032
  mov  dword[.one+16], 0x00000000
  mov  dword[.one+20], 0x00000000
  mov  dword[.one+24], 0x03000201
  mov  dword[.one+28], 0x00000000
  
  ret
 
Dmons: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .bss
 
 .first:
  resd 9
 
 .second:
  resd 9
 
 .third:
  resd 9
 
 .fourth:
  resd 9
 
 .fifth:
  resd 9
 
 .sixth:
  resd 9
 
 .seventh:
  resd 9
 
 .eighth:
  resd 9
 
 .ninth:
  resd 9
 
 .tenth:
  resd 9
 
 .eleventh:
  resd 9
 
 .twelfth:
  resd 9
 
 .thirteenth:
  resd 9
 
 .fourteenth:
  resd 9
 
 .fifteenth:
  resd 9
 
 .sixteenth:
  resd 9
 
 .seventeenth:
  resd 9
 
 .eighteenth:
  resd 9
 
 .nineteenth:
  resd 9
 
 .twentieth:
  resd 9
 
 .twentyfirst:
  resd 9
 
 .twentysecond:
  resd 9
 
 .twentythird:
  resd 9
 
 .twentyfourth:
  resd 9
 
 .twentyfifth:
  resd 9
 
 .twentysixth:
  resd 9
 
 .twentyseventh:
  resd 9
 
 .twentyeighth:
  resd 9
 
 .twentyninth:
  resd 9
 
 .thirtieth:
  resd 9
 
 .thirtyfirst:
  resd 9
 
 .thirtysecond:
  resd 9
 
 section .text
 
 Drepl:
 .replenishsweet:
  mov  dword[eax],    0x01010001
  mov  dword[eax+4],  0x00000001
  mov  dword[eax+8],  tGokeblen
  mov  dword[eax+12], 0x0003000A
  mov  dword[eax+16], 0x00000000
  mov  dword[eax+20], 0x00000000
  mov  dword[eax+24], 0x00030201
  mov  dword[eax+28], 0x00000000
  
  call FDaddfighter
  
  ret
  
 .replenishsour:
  mov  dword[eax],    0x01010001
  mov  dword[eax+4],  0x00000001
  mov  dword[eax+8],  tGokeblen
  mov  dword[eax+12], 0x0005000A
  mov  dword[eax+16], 0x00000000
  mov  dword[eax+20], 0x00000000
  mov  dword[eax+24], 0x00030201
  mov  dword[eax+28], 0x00000000
  
  call FDaddfighter
  
  ret
  
 .replenishspicy:
  mov  dword[eax],    0x01010001
  mov  dword[eax+4],  0x00000001
  mov  dword[eax+8],  0x000A0006
  mov  dword[eax+12], 0x00000000
  mov  dword[eax+16], tGoblin3
  
  call FDaddfighter
  
  ret
  
 .replenishsalty:
  mov  dword[eax],    0x01010001
  mov  dword[eax+4],  0x00000001
  mov  dword[eax+8],  0x00090003
  mov  dword[eax+12], 0x00000000
  mov  dword[eax+16], tGoblin4
  
  call FDaddfighter
  
  ret
  
 .replenishsavoury:
  mov  dword[eax],    0x01010001
  mov  dword[eax+4],  0x00000001
  mov  dword[eax+8],  0x00020015
  mov  dword[eax+12], 0x00000000
  mov  dword[eax+16], tGoblin5
  
  call FDaddfighter
  
  ret
  
 .replenishbitter:
  mov  dword[eax],    0x01010001
  mov  dword[eax+4],  0x00000001
  mov  dword[eax+8],  0x0005000D
  mov  dword[eax+12], 0x00000000
  mov  dword[eax+16], tGoblin6
  
  call FDaddfighter
  
  ret
  
 .gokleben:
  mov  dword[eax],    0x01010001
  mov  dword[eax+4],  0x00000001
  mov  dword[eax+8],  0x000B000E
  mov  dword[eax+12], 0x00000000
  mov  dword[eax+16], tGokleben
  
  call FDaddfighter
  
  ret
 
 .pincer:
  mov  dword[eax],    0x01010002
  mov  dword[eax+4],  0x00000001
  mov  dword[eax+8],  0x00090013
  mov  dword[eax+12], 0x00000000
  mov  dword[eax+16], tPincer
  
  call FDaddfighter
  
  ret
   
 
 section .data
 .preplenish:
  dd .replenishsweet,.replenishsour
  dd .replenishspicy,.replenishsalty
  dd .replenishsavoury,.replenishbitter
 section .text
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 tAbby db "Abby",0
 tGoblin1 db "Sweet Goblin",0
 tGoblin2 db "Sour Goblin",0
 tGoblin3 db "Spicy Goblin",0
 tGoblin4 db "Salty Goblin",0
 tGoblin5 db "Savoury Goblin",0
 tGoblin6 db "Bitter Goblin",0
 tGokeblen db "Gokeblen",0
 tGokleben db "Gokeblin",0
 tKoblogel db "Koblogel",0
 tGokebel db "Gokebel",0
 tPincer db "Pincer",0
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;