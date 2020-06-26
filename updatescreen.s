UpdateScreen:

    ; db  (192-32), (256/2)-4, 4, 14          ; Player Plane 2nd color
    ; db  (192-32), (256/2)-4, 0, 15          ; Player Plane 1st color
    ; db  (192-32)+8, (256/2)-4+8, 0, 1       ; Player Plane shadow

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

	; Player plane shot
	ld a, (Player_Shot)				;   get indicator of shot fired
    cp 0
    jp z, .continue                 

	ld a, (Player_Shot_Y)			;   get Y position of shot  
    dec a
    jp z, .shotReachesTop           ;   if y=0 disable shot

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



    ; Test colision between shot and enemy
	ld a, (Player_Shot_X)			;   h: x coord
	ld h, a
	ld a, (Player_Shot_Y)			;   l: y coord
	ld l, a

	ld a, (Enemy_1_X)				;   b: x1 coord
	ld b, a
    add a, 16                       ;   d: x2 coord
    ld d, a
	ld a, (Enemy_1_Y)				;   c: y1 coord
	ld c, a
    add a, 16                        ;   e: y2 coord
    ld e, a

    call CheckCollision             ; 
    cp a
    jp nz, .colisionTrue

	; Enemy plane
	ld a, (Enemy_1_X)				;   d: x coord
	ld d, a
	ld a, (Enemy_1_Y)				;   e: y coord
	ld e, a
	ld c, 8;14						;   c: color (0-15)
	ld a, 3							;   a: pattern number (0-63)
	ld b, 5							;   b: layer (0-31)
	call PutSprite16x16				;

    jp .continue1

.colisionTrue:
	ld a, 63					    ;   a: pattern number (0-63)
	ld b, 5							;   b: layer (0-31)
	call PutSprite16x16				;   put non existent sprite at layer, to hide the shot


.continue1:

    jp .continue



.shotReachesTop:
    ld a, 0
	ld (Player_Shot), a			    ;   disable shot

	ld a, 63					    ;   a: pattern number (0-63)
	ld b, 2							;   b: layer (0-31)
	call PutSprite16x16				;   put non existent sprite at layer, to hide the shot

.continue:








    ret