FI: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 FIclss equ 0	; class
 FIfl   equ 2	; flags
  FIfl.c equ 0x01 ; conscious
  FIfl.r equ 0x02 ; ready
  FIfl.p equ 0x04 ; player
 FIinit equ 3	; initiative
 FIhstl equ 4	; hostility
 FIname equ 8	; name
 
 section .data
 
FIpTurns: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 dd FNRturn
 dd FNRturn
 dd FIBGfTurn
 
FIpPreturns: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 dd FNRprep
 dd FNRprep
 dd FIBGfPreturn
 
FIpRecieves: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 dd FNRrecieve
 dd FNRrecieve
 dd FIBGfRecieve
 
 section .text
 
FIfRecieve: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;[esp+4] self
 ;[esp+8] sender
 ;ebx:eax effect
 
 mov  ecx,[esp+4]								;
 xor  edx,edx									;
 mov  dx,[ecx+FIclss]							;
 shl  edx,2										;
 
 jmp [edx+FIpRecieves]
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;in-battle stats
; stability
; position
;
;
;out-of-battle stats
; equipment
; abilities
;
;