INCLUDE "gamelogic/enemylogic.s"

GameLogic:



	ld a, (Player_Shot)				;   get indicator of shot fired
   cp 0
   jp z, .continue                 

	ld a, (Player_Shot_Y)			;   get Y position of shot  
   dec a
   cp TOP_SCREEN - 1
   jp z, .shotReachesTop           ;   if y=TOP_SCREEN disable shot

	ld (Player_Shot_Y), a			;   saves updated Y position of shot  

   ld ix, Player_Shot_CollisionBox
   ld (ix + Struct_CollisionBox.Y), a      ; update Y of collision box

	ld a, (Player_Shot_X)			;   d: x coord

   ;no need to update X collision box, as it is always the same
;   ld (ix + Struct_CollisionBox.X), a      ; update X of collision box



   ld a, 14						;   color gray
	ld (Player_Shot_Color), a

	ld a, (Counter+4)	    	    ;
   bit 0, a
   jp z, .continue            ;   alternate colors of shot at each frame

   ld a, 8						    ;   color red
	ld (Player_Shot_Color), a

   jp .continue



.shotReachesTop:

	call DisableShot



.continue:

   ld ix, Enemy_0_Base_Address
   call GameLogicEnemy

   ld ix, Enemy_1_Base_Address
   call GameLogicEnemy

   ld ix, Enemy_2_Base_Address
   call GameLogicEnemy

   ld ix, Enemy_3_Base_Address
   call GameLogicEnemy

   ld ix, Enemy_4_Base_Address
   call GameLogicEnemy

   ret
