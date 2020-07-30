INCLUDE "gamelogic/enemylogic.s"

GameLogic:

   ld iy, Player_Shot_0_Obj                  ; First shot

   ld b, 3                                   ; number of shots
.loop:
   push bc

   ld a, (iy + Struct_PlayerShot.Enabled)    ;   get indicator of shot fired
	; ld a, (Player_Shot)				            ;   get indicator of shot fired
   cp 0
   jp z, .nextShot

	; ld a, (Player_Shot_Y)			            ;   get Y position of shot
	ld a, (iy + Struct_PlayerShot.Y)          ;   get Y position of shot
   dec a
   cp TOP_SCREEN - 1
   call z, .ShotReachesTop                   ;   if y=TOP_SCREEN disable shot

	; ld (Player_Shot_Y), a			            ;   saves updated Y position of shot
	ld (iy + Struct_PlayerShot.Y), a          ;   saves updated Y position of shot

   ld ix, Player_Shot_CollisionBox
   ld (ix + Struct_CollisionBox.Y), a        ; update Y of collision box

   ;no need to update X collision box, as it is always the same
	; ld a, (Player_Shot_X)			            ;   d: x coord
   ; ld (ix + Struct_CollisionBox.X), a      ; update X of collision box

.nextShot:
   ld bc, Struct_PlayerShot_Size
   add iy, bc
   pop bc
   djnz .loop



   ld a, 14						                  ;   color gray
	ld (Player_Shot_Color), a
	ld (Player_Shot_1_Color), a
	ld (Player_Shot_2_Color), a

	ld a, (Counter+4)	    	                  ;
   bit 0, a
   jp z, .continue                           ;   alternate colors of shots at each frame

   ld a, 8						                  ;   color red
	ld (Player_Shot_Color), a
	ld (Player_Shot_1_Color), a
	ld (Player_Shot_2_Color), a

   jp .continue



.ShotReachesTop:
   call DisableShot
   ret



.continue:

; check item
	ld a, (Item_Show)				               ;   
   cp 0
   jp z, .enemies                 



	; Check collision between player plane and item
	ld a, (Player_State)
	cp 0
	jp nz, .skipCheckCollPlaneItem				; skip if player isn't alive

	ld a, (Item_X)				; enemy X + 7
	add 7
	ld h, a
	ld a, (Item_Y)				; enemy Y + 7
	add 7
	ld l, a

	ld a, (Player_X)
	ld b, a						; player x1
	add 16
	ld d, a						; player x2

	ld a, (Player_Y)
	ld c, a						; player y1
	add 16
	ld e, a						; player y2
	
	call CheckCollision             ; 
   jp nz, .playerPlaneGotItem



.skipCheckCollPlaneItem:
	ld a, (Counter+4)	    	      ;
   ld b, a

   bit 0, b
   jp z, .skipDecY               ; dec Y only at each two frames

	ld a, (Item_Y)			
   inc a
   cp 0
   jp z, .itemReachesBottom

	ld (Item_Y), a

.skipDecY:
   ; ld ix, Player_Shot_CollisionBox
   ; ld (ix + Struct_CollisionBox.Y), a

   ld a, 7						      ;   color 1
	ld (Item_Color), a

   bit 0, b
   jp z, .enemies                ;   alternate colors of item at each frame

   ld a, 8						      ;   color 2
	ld (Item_Color), a

   jp .enemies

.itemReachesBottom:

   call DisableItem
   jp .enemies

.playerPlaneGotItem:
   ld a, (Player_Lives)
   inc a
   ld (Player_Lives), a
   call ShowLives
   
   call SoundGetItem
   
   call DisableItem

   jp .enemies

.enemies:
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
