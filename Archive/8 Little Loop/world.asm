world:
section .data
;w equ $
;%macro wl 1
; %1 equ $-w
;%endmacro

;

passages: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 ; character
 ;point,condition,action... end.
 
 dd 0x00000004
 lCavePassage:
 dd 12,0,0,lHomeVillage, ~0
  .village dd ~0
 
sites: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 ;area... end.
 ;menulabel,action... end...
 
 lHomeVillage:
 dd tExit,0,0,lCavePassage, ~0
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;