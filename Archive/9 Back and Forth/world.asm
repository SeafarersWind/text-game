world:
section .data
;w equ $
;%macro wl 1
; %1 equ $-w
;%endmacro

;

passages: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 %macro point 6
 dw %1	;area l
 dw %2	;area h
 dd %3	;condition
 dw %4	;area l
 dw %5	;area h
 dd %6	;location
 %endmacro
 
 dd 0x00000004
 lPassage:
 point 0, 0,0,0,0,lMeadow
 point 40,0,0,0,0,lCave
 dd ~0
 
sites: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 %macro entry 5
 dd %1	;label
 dd %2	;condition
 dw %3	;area l
 dw %4	;area h
 dd %5	;location
 %endmacro
 
 lMeadow:
 entry tExitMeadow,0,0,  0,lPassage
 dd       ~0
 
 lCave:
 entry tExitCave,0,-40,0,lPassage
 dd       ~0
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;