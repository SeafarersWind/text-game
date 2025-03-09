;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FId
 
 section .ubsct algin 4096
 ;resb 0xB9F8
 FId:
  FIdSIZE  equ 256	;address al $00..$FF
  FIdCOUNT equ 32	;address ah $00..$1F
  resb FIdSIZE*FIdCOUNT
  
  FIId    equ 0		;2 bytes
  FICl    equ 2		;2 bytes
  FIFl    equ 4		;1 byte
   FIFlCNS equ 0x80	 ;conscious
   FIFlRDY equ 0x40	 ;ready
   FIFlPLR equ 0x20	 ;player
  FISpeed equ 5		;1 byte
  FIHostl equ 6		;4 bytes
  ;...				;246 left
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FIp
 
 section .data
 FICLASSdCOUNT equ 0x0100
 FIpPreturn:
  dd FIHMfPreturn
  dd FIHMfPreturn
  ;...
  times (FICLASSdCOUNT*4-($-FIpPreturn)) db 0
 
 FIpTurn:
  dd FIHMfTurn
  dd FIBKfTurn
  ;...
  times (FICLASSdCOUNT*4-($-FIpTurn)) db 0
 
 FIpHit:
  dd FIHMfHit
  dd FIHMfHit
  ;...
  times (FICLASSdCOUNT*4-($-FIpHit)) db 0
 
 FIpGetname:
  dd FIGetnamestraight
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;0 HM
 
 section .text
 FIHMHp  equ 10	;2 bytes
 FIHMWpn equ 12	;4 bytes
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;f
 
 FIHMfPreturn:									;ebp+4 fighter
  push ebp										;
  mov  ebp,esp									;
  
  ;where are you
  
  ;I'm fighting an enemy!
  ;;Got a weapon?
  ;;;How do you use it?
  ;;Your equipment!
  ;;Natural Actions!
  
  ;I'm on the sidelines of battle!
  ;;Anything you can use from here?
  ;;What's around you?
  ;;Your equipment!
  ;;Natural Actions!
  
  pop  ebp										;
  ret 4											;
 
 FIHMfTurn:										;ebp+4 fighter
  push ebp										;
  mov  ebp,esp									;
  
  
  
  pop  ebp										;
  ret 4											;
 
 FIHMfHit:										;ebp+4 fighter
  push ebp										;eax hit
  mov  ebp,esp									;
  
  
  
  pop  ebp										;
  ret 4											;
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;