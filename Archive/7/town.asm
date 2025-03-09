LT: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 section .data
 
 tHuevul     db "Huevul",0
 tWstreet    db "West Street",0
 tInn        db "Inn",0
 tInnkeeper  db "Innkeeper",0
 tDrink      db "Drink 4g",0
 tCranberry  db "Cranberry",0
 tPlumb      db "Plum",0
 tClapple    db "Clapple",0
 tBeer       db "Beer",0
 tWhiskey    db "Whiskey",0
 tVanilla    db "Vanilla",0
 tHibiscus   db "Hibiscus",0
 tBeans      db "Beans",0
 tLeaves     db "Leaves",0
 tSnowy      db "Snowy",0
 tJelly      db "Jelly",0
 tSpicy      db "Spicy",0
 tSalty      db "Salty",0
 tSparkly    db "Sparkly",0
 tNeapolitan db "Neapolitan",0
 tMilk       db "Milk",0
 tWater      db "Water",0
 tRoom       db "Room 12g",0
 tTalk       db "Talk",0
 tOldwoman   db "Old woman",0
 tHummingdri db "Humming drinker",0
 tWoofer     db "Woofer",0
 tSleepinguy db "Sleeping Guy",0
 tJukebox    db "Jukebox",0
 t1g         db "1g",0
 tOut        db "Out",0
 ;tGate       db "Gate",0
 tFountain   db "Fountain",0
 tMarket     db "Market",0
 tFruities   db "Fruities",0
 tSlapple    db "Slapple",0
 tCrapple    db "Crapple",0
 tNapple     db "Napple",0
 tFishies    db "Fishies",0
 tTwofish    db "Two fish 3g",0
 tFivefish   db "Five fish 5g",0
 tTasties    db "Tasties",0
 tMuffin     db "Muffin 3g",0
 tIcy        db "Icy 1g",0
 tCake       db "Cake 10g",0
 tSparklies  db "Sparklies",0
 tSaphireear db "Saphire Earrings 30g",0
 tOpalbrace  db "Opal Bracelet 15g",0
 tRuby       db "Ruby 60g",0
 tSilverpier db "Sliver Piercing 20g",0
 tInkies     db "Inkies",0
 tOrange     db "Orange 5g",0
 tTurquoise  db "Turquoise 4g",0
 tMagenta    db "Magenta 7g",0
 tGray       db "Gray 3g",0
 tVermillion db "Vermillion 6g",0
 tKitties    db "Kitties",0
 tPet        db "Pet",0
 tPat        db "Pat",0
 tPlop       db "Plop",0
 tParties    db "Parties",0
 tParty      db "Party 3g",0
 tKissies    db "Kissies",0
 tKiss       db "Kiss 1g",0
 tShoppinbud db "Shopping bud",0
 tLaughfarmr db "Laughing farmer",0
 tRobber     db "Robber",0
 tHungryguy  db "Silly guy",0
 tTiredelder db "Sleepy elder",0
 tBrowsegirl db "Browsing girl",0
 tBench      db "Bench",0
 tSit        db "Sit",0
 tHoppers    db "Hopper",0x27,"s Shop",0
 tHopper     db "Hopper",0
 tBuy        db "Buy",0
 tSell       db "Sell",0
 
 tYum        db "Yummy!",0xA,0
 tHelloo     db "Hello!",0xA,0
 
 ;;;;
 
 mWstreet   dd tFountain,0x01,tInn,0x02,tGate,0x100,0
 mFountain  dd tWstreet,0x00,tHoppers,0x05,tMarket,0x03,tBench,0x04,0
 mInn       dd tInnkeeper,0x80000000,tOldwoman,0x200,tHummingdri,0x200,tJukebox,0x80000001,tWoofer,0x200,tSleepinguy,0x200,tOut,0x00,0,    mInnkeeper,mJukebox
 mMarket    dd tFruities,0x80000000,tFishies,0x80000001,tTasties,0x80000002,tSparklies,0x80000003,tInkies,0x80000004,tKitties,0x80000005,tParties,0x80000006,tKissies,0x80000007,tOut,0x01,tShoppinbud,0x200,tLaughfarmr,0x200,tRobber,0x200,tHungryguy,0x200,tTiredelder,0x200,tBrowsegirl,0x200,0,    mFruities,mFishies,mTasties,mSparklies,mInkies,mKitties,mParties,mKissies
 mBench     dd tSit,0x300,tOut,0x01,0
 mHoppers   dd tHopper,0x80000000,tOut,0x01,0,    mHopper
 
 
 mInnkeeper dd tDrink,0x80000000,tRoom,0x300,tTalk,0x200,0,    mDrink
 mDrink     dd tCranberry,0x300,tPlumb,0x300,tClapple,0x300,tBeer,0x300,tWhiskey,0x300,tVanilla,0x300,tHibiscus,0x300,tBeans,0x300,tLeaves,0x300,tSnowy,0x300,tJelly,0x300,tSpicy,0x300,tSalty,0x300,tSparkly,0x300,tNeapolitan,0x300,tMilk,0x300,tWater,0x300,0
 mJukebox   dd t1g,0x300,0
 
 mFruities  dd tClapple,0x300,tSlapple,0x300,tCrapple,0x300,tNapple,0x300,0
 mFishies   dd tTwofish,0x300,tFivefish,0x300,0
 mTasties   dd tMuffin,0x300,tIcy,0x300,tCake,0x300,0
 mSparklies dd tSaphireear,0x300,tOpalbrace,0x300,tRuby,0x300,tSilverpier,0x300,0
 mInkies    dd tOrange,0x300,tTurquoise,0x300,tMagenta,0x300,tGray,0x300,tVermillion,0x300,0
 mKitties   dd tPet,0x300,tPat,0x300,tPlop,0x300,0
 mParties   dd tParty,0x300,0
 mKissies   dd tKiss,0x300,0
 
 mHopper    dd tBuy,0x300,tSell,0x300,tTalk,0x200,0
 
 aHuevul dd mWstreet,mFountain,mInn,mMarket,mBench,mHoppers
 
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 ;Town:
 ;Areas, Sights, Exits
 
 ;Area:
 ;Text
 ;Action value
 ; 0x--ss----: see ss
 ; 0x--ss01aa: go to aa
 ; 0x--ss02ee: exit to ee
 
 ;Exit:
 ;Area, Location
 
 tYourhouse  db "First house",0
 tTwohouse   db "Second house",0
 tThreehouse db "Third house",0
 tFourhouse  db "Fourth house",0
 tFivehouse  db "Fifth house",0
 tFarmland   db "Farmland",0
 
 tGate       db "Gate",0
 tRoad       db "Road",0
 
 tToTheFarm  db "rollings hills...",0
 tOverBridge db "over the bridge",0
 
 
 ltDimuo  dd ltDimuoAreas, ltDimuoSights, ltDimuoExits
 
 ltDimuoAreas dd maDimuo,maDimuofarm
 ltDimuoSights dd .toTheFarm, .overbridge
 .toTheFarm dd 0x000000
 .overbridge dd 0x000000
 ltDimuoExits dd 0x00000000,lrRoad
 
 
 maDimuo     dd tYourhouse,0x020000, tTwohouse,0x0000, tThreehouse,0x0000, tFourhouse,0x0000, tFivehouse,0x0000, tFarmland,0x010101, 0
 maDimuofarm dd tGate,0x0100, tRoad,0x0200, 0
 
 section .text
 
 Lenter:
LTwalk: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 push 0											;line
 push _buffer									;
 push 1											;
 push tChars+Ln									;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;
 
 mov  ebx,[location]							;
 mov  ebx,[ebx+0]								;
 mov  eax,[area]								;
 shl  eax,2										;
 add  ebx,eax									;
 mov  eax,[ebx]									;find the area
 call fMenu										;open the menu
 
 push eax										;reserve option
 
 shr  eax,14									;Get spot and see
 and  eax,0x000000FC							;
 sub  eax,4										;
 jc   .1										;
 mov  ebx,[location]							;
 mov  ebx,[ebx+4]								;
 add  ebx,eax									;
 mov  eax,[ebx]									;
 call see										; see
 .1:											;
 
 pop  eax										;restore option
 
 cmp  ah,0x01									;go somewhere?
 je   .go										;
 cmp  ah,0x02									;exit location?
 je   .exit										;
 
 jmp  LTwalk
 
 .go:											;
  push eax										;
  
  push 0										;----
  push _buffer									;
  push 1										;
  push tChars+"-"								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;
  push 180										;
  call _Sleep@4									;
  push 0										;
  push _buffer									;
  push 1										;
  push tChars+"-"								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;
  push 180										;
  call _Sleep@4									;
  push 0										;
  push _buffer									;
  push 1										;
  push tChars+"-"								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;
  push 180										;
  call _Sleep@4									;
  push 0										;
  push _buffer									;
  push 1										;
  push tChars+"-"								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;
  push 180										;
  call _Sleep@4									;
  push 0										;
  push _buffer									;
  push 1										;
  push tChars+Ln								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;
  
  pop  eax										;
  
  mov  [area],al								;Go to area
  
  jmp  LTwalk
 
 .exit:											;
  push eax										;
  
  push 0										;----
  push _buffer									;
  push 1										;
  push tChars+"-"								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;
  push 180										;
  call _Sleep@4									;
  push 0										;
  push _buffer									;
  push 1										;
  push tChars+"-"								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;
  push 180										;
  call _Sleep@4									;
  push 0										;
  push _buffer									;
  push 1										;
  push tChars+"-"								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;
  push 180										;
  call _Sleep@4									;
  push 0										;
  push _buffer									;
  push 1										;
  push tChars+"-"								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;
  push 180										;
  call _Sleep@4									;
  push 0										;
  push _buffer									;
  push 1										;
  push tChars+Ln								;
  push dword[_hStdoutput]						;
  call _WriteFile@20							;
  
  pop  eax										;
  
  and  eax,0x000000FF							;Go to location
  shl  eax,3									;
  mov  ebx,[location]							;
  mov  ebx,[ebx+8]								;
  add  ebx,eax									;
  mov  eax,[ebx]								;
  mov  [area],eax								;
  mov  eax,[ebx+4]								;
  mov  [location],eax							;
  
  jmp  LPtravel
 
LTtravel: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 push 0											;
 push _buffer									;
 push 1											;
 push tChars+"-"								;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print dash
 push 180										;
 call _Sleep@4									;z
 push 0											;
 push _buffer									;
 push 1											;
 push tChars+"-"								;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print dash
 push 180										;
 call _Sleep@4									;z
 push 0											;
 push _buffer									;
 push 1											;
 push tChars+"-"								;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print dash
 push 180										;
 call _Sleep@4									;z
 push 0											;
 push _buffer									;
 push 1											;
 push tChars+"-"								;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print dash
 push 180										;
 call _Sleep@4									;z
 push 0											;
 push _buffer									;
 push 1											;
 push tChars+Ln									;
 push dword[_hStdoutput]						;
 call _WriteFile@20								;print ln
 
 ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 ; huevil
 ;  entryway
 ;   inkling's tavern
 ;    bar
 ;     drink 5g
 ;    inn
 ;     night 20g
 ;   square
 ;    market plaza
 ;     fruit stall
 ;     fish stall
 ;     meat stall
 ;     trinket stall
 ;     kissing stall
 ;     veggie stall
 ;     candy stall
 ;     mystery stall
 ;     spice stall
 ;    dorothy's trinkets and pretties
 ;     buy
 ;      red earings
 ;      blue rock
 ;      dragon tooth
 ;      painted bowl
 ;     talk
 ;     pawn
 ;    bleeder's wear
 ;     buy
 ;      leather shirt
 ;      leather pants
 ;      cloth shorts
 ;      etc.
 ;     talk
 ;     pawn
 ;    fountain
 ;     bench
 ;     old lady
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 ; a place has its places and a place has its placement
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;