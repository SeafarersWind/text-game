lp: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .data
 
 .points  equ 0
 .terrain equ 4
 .length  equ 8
 .flags   equ 10
 
 .pointsize equ 6
 
 ;area ----------------dppppppppppppppp
 
 ;points, terrain, length, flags...
 lpPassageway dd .p, 0x00000000, 0x0000
 ;       position
 ;       point
 ;
 ;      D
 .p dw 0x0090
    dd pBirdsong
    dw 0x0000
    dd 0x00000000
    
    dw ~0
 
 pBirdsong:
  ;    t        f    ssssSSSS   ddddDDDD   wwwwWWWW   wwwwWWWW
  dd 0x80000000|.1,0x0000FFFF,0x0000FFFF,0x0000FFFF,0x0000FFFF
  dd 0x40000000
  .1:
  dd 0x00000000
 
 ;Point
 ; condition 0x8
 ; sight     0x0
 ; entrance  0x4
 
 ;Condition
 ; 8: weather
 ;  sssSSSSttttTTTTwwwwwwwwWWWWWWWW
 ; 9+: locals
 
 lpD:
 
lt: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 
 ltD:
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 