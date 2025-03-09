section .data
text: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 t equ $
 %macro tx 2
  %1 equ $
  db %2,0
 %endmacro
 
 tBattleStart db "Battle Start!",0
 tHeroWins    db "Hero Wins!",0
 tCrtrWins    db "Creature Wins!",0
 tAttacks db pSTR," attacks!",0
 tGetsHit db pSTR," takes ",pNUM," damage!",10,0
 tFalls   db pSTR," falls!",0
 tx tCreature, "Creature"
 
 tx tAttack, "Attack"
 tx tDefend, "Defend"
 tx tItem,   "Item"
 tx tRun,    "Run"
 
 tx tExitMeadow,"Exit"
 tx tExitCave,  "Exit"
 tx tPassageEntry, "Through the forest..."
 tx tMeadowEntry, "In the meadow"
 tx tCaveEntry, "In the cave"
 
 tH32 db pH32,10,0
 tH16 db pH16,10,0
 tH8  db pH08,10,0
 tDec db pNUM,10,0
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;