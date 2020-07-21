INCLUDE "updatescreen/showenemy.s"
INCLUDE "updatescreen/showenemyshot.s"


UpdateScreen:

    ; db  (192-32), (256/2)-4, 4, 14          ; Player Plane 2nd color
    ; db  (192-32), (256/2)-4, 0, 15          ; Player Plane 1st color
    ; db  (192-32)+8, (256/2)-4+8, 0, 1       ; Player Plane shadow

	ld a, (Player_State)
	cp 0
	jp nz, .playerExplosion

	ld a, (Player_Y)
	ld (SpriteLayer_1_Y), a				; 1st color

	add 8
	ld (SpriteLayer_31_Y), a			; shadow

	ld a, (Player_X)
	ld (SpriteLayer_1_X), a				; 1st color

	add 8
	ld (SpriteLayer_31_X), a			; shadow

	jp .showEnemies

.playerExplosion:
	inc a
	ld (Player_State), a

	cp 255
	jp z, .restorePlayer			;

	cp 50							; counter number of animation end
	jp nc, .endExplosionPlayer		; if(enemyState >= 50) end animation


	cp 40							;if(enemyState >= 40)
	jp nc, .explosion1stFrame
	cp 30							;if(enemyState >= 30)
	jp nc, .explosion2ndFrame
	cp 20							;if(enemyState >= 20)
	jp nc, .explosion3rdFrame
	cp 10							;if(enemyState >= 10)
	jp nc, .explosion2ndFrame
	jp .explosion1stFrame			;else

.restorePlayer:

	ld a, (Player_Lives)
	cp 0
	jp z, GameOver


	ld a, 0
    ld (Player_State), a

	ld a, 1 * 4					
    ld (Player_Pattern), a
	ld a, 12					
    ld (Player_Color), a
	
	ld a, 0 * 4					
    ld (SpriteLayer_1_Pattern), a
	ld a, 3					
    ld (SpriteLayer_1_Color), a
	
	ld a, 0 * 4					
    ld (SpriteLayer_31_Pattern), a
	ld a, 1
    ld (SpriteLayer_31_Color), a
	
	jp .showEnemies

.explosion3rdFrame:	
	ld a, 10 * 4					;   a: pattern number (0-63)
    ld (Player_Pattern), a
	ld a, 10 						;   c: color (0-15)
    ld (Player_Color), a
	jp .explosionCont
.explosion2ndFrame:	
	ld a, 9	* 4						;   a: pattern number (0-63)
    ld (Player_Pattern), a
	ld a, 8 						;   c: color (0-15)
    ld (Player_Color), a
	jp .explosionCont
.explosion1stFrame:	
	ld a, 8	* 4						;   a: pattern number (0-63)
    ld (Player_Pattern), a
	ld a, 15 						;   c: color (0-15)
    ld (Player_Color), a

.endExplosionPlayer:
	; hide player first sprite
    ld a, 63 * 4                       		; put non existent sprite at layer, to hide the enemy
    ld (Player_Pattern), a           		; Addr 2nd color pattern

.explosionCont:
	; hide other 2 sprites of player
    ld a, 63 * 4                       		; put non existent sprite at layer, to hide the enemy
    ld (SpriteLayer_1_Pattern), a           ; Addr 1st color pattern
    ld (SpriteLayer_31_Pattern), a          ; Addr shadow pattern

    ; ld a, (Enemy_Temp_2ndColorPattern)
    ; ld (ix + 2), a                     ; Addr 2nd color pattern
    ; ld a, (Enemy_Temp_2ndColor)
    ; ld (ix + 3), a                     ; Addr 2nd color


.showEnemies:

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