
ShowEnemyShot:

	; Enemy Shot
	; ld a, (Enemy_Shot_1_Show)		;   get indicator of enemy shot fired
	ld a, (ix + 8)		;   get indicator of enemy shot fired
    cp 0
    jp z, .enemyShotHide                 

	; ld a, (Enemy_Shot_1_X)			;   d: x coord
	ld a, (ix + 9)			;   d: x coord
	; ld d, a
	; ld (SpriteLayer_18_X), a
	ld (iy + 1), a

	; ld a, (Enemy_Shot_1_Y)			;   e: y coord
	ld a, (ix + 10)			;   e: y coord
	; ld e, a
	; ld (SpriteLayer_18_Y), a
	ld (iy), a
	
    ld a, 15						;   color white
	; ld (SpriteLayer_18_Color), a
	ld (iy + 3), a
	
	ld a, 5	* 4						;   a: pattern number (0-63)
	; ld (SpriteLayer_18_Pattern), a
	ld (iy + 2), a
	; ld b, 18						;   b: layer (0-31)
	; call PutSprite16x16				;
	
    ret

.enemyShotHide:
	ld a, 0							;   d: x coord
	; ld (SpriteLayer_18_X), a
	ld (iy + 1), a

	ld a, 256 - 16					;   e: y coord		; place sprite off screen
	; ld (SpriteLayer_18_Y), a
	ld (iy), a

	ld a, 63 * 4				    ;   a: pattern number (0-63)
	; ld (SpriteLayer_18_Pattern), a
	ld (iy + 2), a

	; ld b, 18						;   b: layer (0-31)
	; call PutSprite16x16				;   put non existent sprite at layer, to hide the enemy

    ret