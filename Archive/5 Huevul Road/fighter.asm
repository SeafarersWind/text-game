FI: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 FIclss equ 0	; class
 FIfl   equ 2	; flags
  FIfl.c equ 0x01 ; conscious
  FIfl.r equ 0x02 ; ready
  FIfl.p equ 0x04 ; player
 FIinit equ 3	; initiative
 FIhstl equ 4	; hostility
 
 section .data
 
FIpTurns: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 dd FINRfTurn
 dd FINRfTurn
 
FIpPreturns: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 dd FINRfPreturn
 dd FINRfPreturn
 
FIpRecieves: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 dd FINRfRecieve
 dd FINRfRecieve
 
 section .text
 
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