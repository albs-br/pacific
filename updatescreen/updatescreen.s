INCLUDE "updatescreen/showenemy.s"
INCLUDE "updatescreen/showenemyshot.s"


UpdateScreen:

    ; db  (192-32), (256/2)-4, 4, 14          ; Player Plane 2nd color
    ; db  (192-32), (256/2)-4, 0, 15          ; Player Plane 1st color
    ; db  (192-32)+8, (256/2)-4+8, 0, 1       ; Player Plane shadow


	ld a, (Player_Y)
	ld (SpriteLayer_1_Y), a				; 1st color

	add 8
	ld (SpriteLayer_31_Y), a			; shadow

	ld a, (Player_X)
	ld (SpriteLayer_1_X), a				; 1st color

	add 8
	ld (SpriteLayer_31_X), a			; shadow



	; Show first (# 0) enemy
	ld hl, Enemy_0_Base_Address		; base addr of enemy variables
    ld ix, SpriteLayer_5_BaseAddr	; base addr of 2nd color layer
	call ShowEnemy

	; Show second (# 1) enemy
	ld hl, Enemy_1_Base_Address		; base addr of enemy variables
    ld ix, SpriteLayer_6_BaseAddr	; base addr of 2nd color layer
	call ShowEnemy

	; Show third (# 2) enemy
	ld hl, Enemy_2_Base_Address		; base addr of enemy variables
    ld ix, SpriteLayer_7_BaseAddr	; base addr of 2nd color layer
	call ShowEnemy

	; Show fourth (# 3) enemy
	ld hl, Enemy_3_Base_Address		; base addr of enemy variables
    ld ix, SpriteLayer_8_BaseAddr	; base addr of 2nd color layer
	call ShowEnemy

	; Show fifth (# 4) enemy
	ld hl, Enemy_4_Base_Address		; base addr of enemy variables
    ld ix, SpriteLayer_9_BaseAddr	; base addr of 2nd color layer
	call ShowEnemy



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
    jp z, .continue            ;   alternate colors of shot at each frame

    ld a, 8						    ;   color red
	ld (Player_Shot_Color), a

    jp .continue



.shotReachesTop:

	call DisableShot

.continue:

	ld ix, Enemy_0_Base_Address
	ld iy, SpriteLayer_18_Y
	call ShowEnemyShot

	ld ix, Enemy_1_Base_Address
	ld iy, SpriteLayer_19_Y
	call ShowEnemyShot

	ld ix, Enemy_2_Base_Address
	ld iy, SpriteLayer_20_Y
	call ShowEnemyShot

	ld ix, Enemy_3_Base_Address
	ld iy, SpriteLayer_21_Y
	call ShowEnemyShot

	ld ix, Enemy_4_Base_Address
	ld iy, SpriteLayer_22_Y
	call ShowEnemyShot



.continue1:


	; rest of logic here



	; copy from buffer to VRAM
	ld	bc, 4 * 32									; Block length
	ld	de, SpriteAttrTable							; VRAM address
	ld	hl, VramSpriteAttrBuffer        			; RAM address
    call BIOS_LDIRVM        						; Block transfer to VRAM from memory

    ret