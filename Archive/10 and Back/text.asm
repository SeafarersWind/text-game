section .data
text: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 t equ $
 %macro tx 2
  %1 equ $
  db %2,0
 %endmacro
 
 tx tExitMeadow,"Exit"
 tx tExitCave,  "Exit"
 tx tPassageEntry, "Through the forest..."
 tx tMeadowEntry, "In the meadow"
 tx tCaveEntry, "In the cave"
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;