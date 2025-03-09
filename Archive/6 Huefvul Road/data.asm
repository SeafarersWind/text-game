DT: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .data
 
dFI: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 .one:
  dw 0x0001
  db 00000101b
  db 0xFF
  dd 0xFFFFFFFE
  dw 0x0100
  dw 0x0008
  dw 0x0008
  dw 0x0008
  dd tAbby
  db 0
 
 .replenish:
  mov  dword[.one],    0xFF050001
  mov  dword[.one+4],  0xFFFFFFFE
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
 
 .fourth:
  resd 6
 
 .fifth:
  resd 6
 
 .sixth:
  resd 6
 
 .seventh:
  resd 6
 
 .eighth:
  resd 6
 
 .ninth:
  resd 6
 
 .tenth:
  resd 6
 
 .eleventh:
  resd 6
 
 .twelfth:
  resd 6
 
 .thirteenth:
  resd 6
 
 .fourteenth:
  resd 6
 
 .fifteenth:
  resd 6
 
 .sixteenth:
  resd 6
 
 .seventeenth:
  resd 6
 
 .eighteenth:
  resd 6
 
 .nineteenth:
  resd 6
 
 .twentieth:
  resd 6
 
 .twentyfirst:
  resd 6
 
 section .text
 
 .replenish:
 .replenishsweet:
  mov  dword[eax],    0x01010001
  mov  dword[eax+4],  0x00000001
  mov  dword[eax+8],  0x0003000A
  mov  dword[eax+12], 0x00000000
  mov  dword[eax+16], tGoblin1
  
  call FDaddfighter
  
  ret
  
 .replenishsour:
  mov  dword[eax],   0x01010001
  mov  dword[eax+4], 0x00000001
  mov  dword[eax+8], 0x0006000A
  mov  dword[eax+12],0x00000000
  mov  dword[eax+16],tGoblin2
  
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
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;