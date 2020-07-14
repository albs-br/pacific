INCLUDE "updatescreen/showenemy.s"


UpdateScreen:

    ; db  (192-32), (256/2)-4, 4, 14          ; Player Plane 2nd color
    ; db  (192-32), (256/2)-4, 0, 15          ; Player Plane 1st color
    ; db  (192-32)+8, (256/2)-4+8, 0, 1       ; Player Plane shadow



	; call ShowLives
	; call ShowScore


	ld a, (Player_Y)
	ld (SpriteLayer_1_Y), a				; 1st color

	add 8
	ld (SpriteLayer_31_Y), a			; shadow

	ld a, (Player_X)
	ld (SpriteLayer_1_X), a				; 1st color

	add 8
	ld (SpriteLayer_31_X), a			; shadow




{
	; Player plane 2nd color
	ld a, (Player_X)				;   d: x coord
	ld d, a
	ld a, (Player_Y)				;   e: y coord
	ld e, a
	ld c, 12;14						;   c: color (0-15)
	ld a, 1							;   a: pattern number (0-63)
	ld b, 0							;   b: layer (0-31)
	call PutSprite16x16				;

	; Player plane 1st color
	; ld d, (256/2)-4					;   d: x coord
	; ld e, (192-32)					;   e: y coord
	ld c, 3;15						;   c: color (0-15)
	ld a, 0							;   a: pattern number (0-63)
	ld b, 1							;   b: layer (0-31)
	call PutSprite16x16				;	

	; Player plane shadow
	ld b, 8
	ld a, (Player_X)				;   d: x coord
	add a, b
	ld d, a
	ld a, (Player_Y)				;   e: y coord
	add a, b
	ld e, a
	ld c, 1							;   c: color (0-15)
	ld a, 0							;   a: pattern number (0-63)
	ld b, 31						;   b: layer (0-31)
	call PutSprite16x16				;	
}

	;TODO: pass layers by register (speed)

	; if(Enemy_1_Show != 0)
	; ld a, (Enemy_1_Show)
	; cp 0
	; jp z, .enemy2

	; Show first (# 0) enemy
	; ld a, 5							; sprite layer for 2nd color
    ; ld (Enemy_Temp_Layer2ndColor), a
	; inc a							; sprite layer for 1st color
    ; ld (Enemy_Temp_Layer1stColor), a
	; ld a, 26						; sprite layer shadow
    ; ld (Enemy_Temp_LayerShadow), a
	ld hl, Enemy_1_Base_Address		; base addr of enemy variables
	call ShowEnemy



.enemy2:

	; if(Enemy_2_Show != 0)
	; ld a, (Enemy_2_Show)
	; cp 0
	; jp z, .enemy3

	; Show second (# 1) enemy
	; ld a, 7							; sprite layer for 2nd color
    ; ld (Enemy_Temp_Layer2ndColor), a
	; inc a							; sprite layer for 1st color
    ; ld (Enemy_Temp_Layer1stColor), a
	; ld a, 27						; sprite layer shadow
    ; ld (Enemy_Temp_LayerShadow), a
	; ld hl, Enemy_2_Base_Address		; base addr of enemy variables
	; call ShowEnemy



.enemy3:


.next:

	; TODO: maybe this logic would be on gamelogic.s
	; Player plane shot
	ld a, (Player_Shot)				;   get indicator of shot fired
    cp 0
    jp z, .continue                 

	ld a, (Player_Shot_Y)			;   get Y position of shot  
    dec a
    cp TOP_SCREEN - 1
    jp z, .shotReachesTop           ;   if y=TOP_SCREEN disable shot

	ld (Player_Shot_Y), a			;   saves updated Y position of shot  
	ld e, a                         ;   put in e to call PutSprite later

	ld a, (Player_Shot_X)			;   d: x coord
	ld d, a
	; ld a, (Player_Shot_Y)			;   e: y coord
	; ld e, a
	
    ld a, 14						;   color gray
	ld (Player_Shot_Color), a

	ld a, (Counter+4)	    	    ;
    bit 0, a
    jp z, .continueColor            ;   alternate colors of shot at each frame

    ld a, 8						    ;   color red
	ld (Player_Shot_Color), a

.continueColor:

	; ld a, 2							;   a: pattern number (0-63)
	; ld b, 2							;   b: layer (0-31)
	; call PutSprite16x16				;






    jp .continue



.shotReachesTop:

	call DisableShot

.continue:

	; Enemy Shot
	ld a, (Enemy_Shot_1_Show)		;   get indicator of enemy shot fired
    cp 0
    jp z, .enemyShotHide                 

	ld a, (Enemy_Shot_1_X)			;   d: x coord
	ld d, a
	ld a, (Enemy_Shot_1_Y)			;   e: y coord
	ld e, a
	
    ld c, 15						;   color white
	ld a, 5							;   a: pattern number (0-63)
	ld b, 10						;   b: layer (0-31)
	call PutSprite16x16				;
	jp .continue1

.enemyShotHide:
	ld d, 0							;   d: x coord
	ld e, 256 - 16					;   e: y coord		; place sprite off screen
	ld a, 63					    ;   a: pattern number (0-63)
	ld b, 10						;   b: layer (0-31)
	call PutSprite16x16				;   put non existent sprite at layer, to hide the enemy


.continue1:


	; rest of logic here



	; copy from buffer to VRAM
	ld	bc, 4 * 32									; Block length
	ld	de, SpriteAttrTable							; VRAM address
	ld	hl, VramSpriteAttrBuffer        			; RAM address
    call BIOS_LDIRVM        						; Block transfer to VRAM from memory

    ret