extern _ExitProcess@4
extern _GetStdHandle@4
extern _WriteFile@20
extern _ReadFile@20
extern _FlushFileBuffers@4
extern _SetConsoleCursorInfo@8
extern _Sleep@4

global TheVeryBeginning

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .bss
 hStdoutput resd 1
 hStdinput  resd 1
 
 buffer resb 65536
section .data
 c db 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,
   db 33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,
   db 63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,
   db 93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,
   db 117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,
   db 139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,
   db 161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,
   db 183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,
   db 205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,
   db 227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,
   db 249,250,251,252,253,254,255
 
section .text
TheVeryBeginning: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

startup:
 push -11	; STD_OUTPUT
 call _GetStdHandle@4
 mov  dword[hStdoutput],eax
 
 push -10	; STD_OUTPUT
 call _GetStdHandle@4
 mov  dword[hStdinput],eax
 
 mov  byte[buffer],1
 push buffer
 push dword[hStdoutput]
 call _SetConsoleCursorInfo@8
 
;go
 
 mov  dword[random.seed],   0xD2A3DD13
 mov  dword[random.seed+4], 0x7FDC9BA8
 mov  dword[random.seed+8], 0x676B7394
 mov  dword[random.seed+12],0xA3FCFB13
 mov  dword[random.seed+16],0xE741ADF5
 mov  dword[random.seed+20],0x60A6D8C6
 mov  dword[random.seed+24],0x8A1FEE4F
 mov  dword[random.seed+28],0x2AA762F1
 mov  dword[random.seed+32],0x3704CC0C
 mov  dword[random.seed+36],0xA5C13B22
 mov  dword[random.seed+40],0xC5052FAD
 mov  dword[random.seed+44],0xA17E6100
 mov  dword[random.seed+48],0x62A980EE
 mov  dword[random.seed+52],0xB9E04F5A
 mov  dword[random.seed+56],0x412D2E9A
 mov  dword[random.seed+60],0xFF8E22AD
 
 ;again:
 ;call random
 ;push eax
 ;mov  eax,tH32
 ;call print
 ;jmp again
 
 mov  dword[location],dojo
 mov  dword[area],0
 
 mov  byte[distance],7
 
 %include "beat.asm"
 %include "navigate.asm"
 %include "travel.asm"
 %include "spar.asm"
 
shutdown:
 section .data
 .t db 0xA,"Quit...",0xA
 section .text
 push 0
 push buffer
 push 9
 push .t 
 push dword[hStdoutput]
 call _WriteFile@20
 
 mov  dword[buffer],10
 mov  dword[buffer+4],1
 push buffer
 push dword[hStdoutput]
 call _SetConsoleCursorInfo@8
 
 push dword[hStdinput]
 call _FlushFileBuffers@4
 push 0
 push buffer
 push 3
 push buffer+4
 push dword[hStdinput]
 call _ReadFile@20
 
 push dword 0
 call _ExitProcess@4
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include "system.asm"
%include "world.asm"
%include "text.asm"