UpdateScreen:

    ; db  (192-32), (256/2)-4, 4, 14          ; Player Plane 2nd color
    ; db  (192-32), (256/2)-4, 0, 15          ; Player Plane 1st color
    ; db  (192-32)+8, (256/2)-4+8, 0, 1       ; Player Plane shadow



	; call ShowLives
	; call ShowScore

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


	; Enemy plane
	ld a, (Enemy_1_Show)			;   get indicator of enemy show/hide
    cp 0
    jp z, .enemyHide                 

	ld a, (Enemy_1_Type)			;
    cp 0
    jp z, .enemyType_0                 
    cp 1
    jp z, .enemyType_1
    cp 2
    jp z, .enemyType_2
	jp .next

.enemyType_0:
	ld a, 4							; pattern number (2nd color)
	jp .enemyTypeCont

.enemyType_1:
	ld a, 7							; pattern number (2nd color)
	jp .enemyTypeCont

.enemyType_2:
	ld a, 12							; pattern number (2nd color)
	jp .enemyTypeCont

.enemyTypeCont:

	push af							; save pattern number

	; Enemy plane 2nd color
	ld a, (Enemy_1_X)				;   d: x coord
	ld d, a
	ld a, (Enemy_1_Y)				;   e: y coord
	ld e, a
	ld a, (Enemy_1_2ndColor)		;   c: color (0-15)
	ld c, a
	; ld c, 6 						;   c: color (0-15)
	; ld a, 4						;   a: pattern number (0-63)
	pop af							; 	retrieve pattern number
	push af							; save pattern number
	ld b, 5							;   b: layer (0-31)
	call PutSprite16x16				;


	; Enemy plane 1st color
	; ld a, (Enemy_1_X)				;   d: x coord
	; ld d, a
	; ld a, (Enemy_1_Y)				;   e: y coord
	; ld e, a
	ld a, (Enemy_1_1stColor)		;   c: color (0-15)
	ld c, a
	; ld c, 9							;   c: color (0-15)
	; ld a, 3							;   a: pattern number (0-63)
	pop af							; 	retrieve pattern number
	dec a
	push af							; save pattern number
	ld b, 6							;   b: layer (0-31)
	call PutSprite16x16				;
	

	; Enemy plane shadow
	ld b, 8
	ld a, (Enemy_1_X)				;   d: x coord
	add a, b
	ld d, a
	ld a, (Enemy_1_Y)				;   e: y coord
	add a, b
	ld e, a
	ld c, 1							;   c: color (0-15)
	; ld a, 3							;   a: pattern number (0-63)
	pop af							; 	retrieve pattern number
	ld b, 30						;   b: layer (0-31)
	call PutSprite16x16				;	

	jp .next

.enemyHide:
	;if(enemyState !=0)
	ld a, (Enemy_1_State)
	cp 0							; animation runs between 1 and 255
	jp z, .enemyHideCont

	inc a
	cp 128
	ld (Enemy_1_State), a
	jp z, .enemyHideCont			; end animation


	;call BIOS_BEEP ; [debug]

	; Show explosion change sprite and color
	; ld hl, SpriteAttrTable + (5 * 4)
	; ld c, 10
	; ld a, 8 * 4
	; call SetSpritePatternAndColor	

	ld a, (Enemy_1_X)				;   d: x coord
	ld d, a
	ld a, (Enemy_1_Y)				;   e: y coord
	ld e, a
	ld c, 10 						;   c: color (0-15)
	
	
	ld a, (Enemy_1_State)
	cp 100							;if(enemyState >= 100)
	jp nc, .explosion1stFrame
	cp 75							;if(enemyState >= 75)
	jp nc, .explosion2ndFrame
	cp 50							;if(enemyState >= 50)
	jp nc, .explosion3rdFrame
	cp 25							;if(enemyState >= 25)
	jp nc, .explosion2ndFrame
	jp .explosion1stFrame			;else
.explosion3rdFrame:	
	ld a, 10						;   a: pattern number (0-63)
	jp .explosionCont
.explosion2ndFrame:	
	ld a, 9							;   a: pattern number (0-63)
	jp .explosionCont
.explosion1stFrame:	
	ld a, 8							;   a: pattern number (0-63)
.explosionCont:

	ld b, 5							;   b: layer (0-31)
	call PutSprite16x16				;

	; hide other 2 sprites of enemy
	ld d, 0
	ld e, 0
	ld a, 63
	ld b, 6							;   b: layer (0-31)
	call PutSprite16x16				;   put non existent sprite at layer, to hide the enemy
	ld b, 30						;   b: layer (0-31)
	call PutSprite16x16				;   put non existent sprite at layer, to hide the enemy

	jp .next

.enemyHideCont:
	ld a, 0
	ld (Enemy_1_State), a			; 	disable explosion animation

	ld d, 0							;   d: x coord
	ld e, 256 - 16					;   e: y coord		; place sprite off screen
	ld a, 63					    ;   a: pattern number (0-63)
	ld b, 5							;   b: layer (0-31)
	call PutSprite16x16				;   put non existent sprite at layer, to hide the enemy
	; ld d, 0							;   d: x coord
	; ld e, 256 - 16					;   e: y coord		; place sprite off screen
	; ld a, 63					    ;   a: pattern number (0-63)
	ld b, 6							;   b: layer (0-31)
	call PutSprite16x16				;   put non existent sprite at layer, to hide the enemy
	ld b, 30						;   b: layer (0-31)
	call PutSprite16x16				;   put non existent sprite at layer, to hide the enemy


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
	
    ld c, 14						;   color gray

	ld a, (Counter+4)	    	    ;
    bit 0, a
    jp z, .continueColor            ;   alternate colors of shot at each frame

    ld c, 8						    ;   color red

.continueColor:

	ld a, 2							;   a: pattern number (0-63)
	ld b, 2							;   b: layer (0-31)
	call PutSprite16x16				;






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

    ret