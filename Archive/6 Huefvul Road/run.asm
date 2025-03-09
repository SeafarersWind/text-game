;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 global TheVeryBeginning
 
 %include "common.asm"
 %include "game.asm"
 %include "fighter.asm"
 %include "finatural.asm"
 %include "field.asm"
 %include "data.asm"
 %include "beat.asm"
 %include "land.asm"
 %include "battle.asm"
 %include "town.asm"
 
 section .text
 
TheVeryBeginning: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 call fStartup
 ;We begin.
 
 
 
 mov  eax,dFI.one								;
 call FDaddfighter								;
 
 mov  dword[area],aHuevul
 mov  dword[place],0
 call TNwalk
 
 
 
 ;We end.
 call fShutdown
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .data
 
 tHello db "Hello, world!",Ln,0
 tOne	      db "One",0
 tTwo	      db "Two",0
 tThree	      db "Three",0
 tFour	      db "Four",0
 tFive	      db "Five",0
 tSix	      db "Six",0
 tSeven       db "Seven",0
 tEight       db "Eight",0
 tNine        db "Nine",0
 tTen         db "Ten",0
 tEleven      db "Eleven",0
 tTwelve      db "Twelve",0
 tThirteen    db "Thirteen",0
 tFourteen    db "Fourteen",0
 tFifteen     db "Fifteen",0
 tSixteen     db "Sixteen",0
 tSeventeen   db "Seventeen",0
 tEighteen    db "Eighteen",0
 tNineteen    db "Nineteen",0
 tTwenty      db "Twenty",0
 tTwentyone   db "Twentyone",0
 tTwentytwo   db "Twentytwo",0
 tTwentythree db "Twentythree",0
 tTwentyfour  db "Twentyfour",0
 tTwentyfive  db "Twentyfive",0
 tTwentysix   db "Twentysix",0
 tTwentyseven db "Twentyseven",0
 tTwentyeight db "Twentyeight",0
 tTwentynine  db "Twentynine",0
 tThirty      db "Thirty",0
 tThirtyone   db "Thirtyone",0
 tThirtytwo   db "Thirtytwo",0
 
 ptNums:
 dd tOne
 dd tTwo
 dd tThree
 dd tFour
 dd tFive
 dd tSix
 dd tSeven
 dd tEight
 dd tNine
 dd tTen
 dd tEleven
 dd tTwelve
 dd tThirteen
 dd tFourteen
 dd tFifteen
 dd tSixteen
 dd tSeventeen
 dd tEighteen
 dd tNineteen
 dd tTwenty
 dd tTwentyone
 dd tTwentytwo
 dd tTwentythree
 dd tTwentyfour
 dd tTwentyfive
 dd tTwentysix
 dd tTwentyseven
 dd tTwentyeight
 dd tTwentynine
 dd tThirty
 dd tThirtyone
 dd tThirtytwo
 
 menutest dd tOne
 db "1"
 dd tTwo
 db "2"
 dd tThree
 db "3"
 dd tFour
 db "4"
 dd tFive
 db "5"
 dd tSix
 db "6"
 db 0
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;