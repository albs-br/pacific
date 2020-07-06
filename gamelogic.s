
GameLogic:

	ld a, (Enemy_1_Show)			; if enemy 1 is hide, skip enemy logic/check collision
	cp 0
	jp z, .skipCheckEnemy_1

	; update enemy position
	;if(enemytype == 0)
	ld a, (Enemy_1_Type)			;
	cp 0
	jp z, .enemyType_0

	;elseif(enemytype == 1)
	cp 1
	jp z, .enemyType_1

	;elseif(enemytype == 2)
	cp 2
	jp z, .enemyType_2

	;else
	jp .contGameLogic


.enemyType_0:
	ld a, (Enemy_1_Y)				;
	inc a
	cp 192
	call z, .hideEnemy

	ld (Enemy_1_Y), a				; save updated value

	jp .contGameLogic

.enemyType_1:
	ld a, (Enemy_1_X)				;
	dec a
	cp 0
	call z, .hideEnemy

	ld (Enemy_1_X), a				; save updated value

	jp .contGameLogic

.enemyType_2:
	ld a, (Enemy_1_X)				;
	inc a
	cp 0
	call z, .hideEnemy

	ld (Enemy_1_X), a				; save updated value

	jp .contGameLogic

.hideEnemy:
	ld a, 0
	ld (Enemy_1_Show), a			; hide enemy
	ret

.contGameLogic:

	ld a, (Player_Shot)				; if there is no shot fired skip check collision between shot and enemy
	cp 0
	jp z, .skipCheckEnemy_1

    ; Test colision between shot and enemy
	; TODO: check all 4 points not only one
	ld a, (Player_Shot_X)			;   h: x coord
	add a, 6						;   get the correct upper left pixel
	ld h, a
	ld a, (Player_Shot_Y)			;   l: y coord
	ld l, a

	ld a, (Enemy_1_X)				;   b: x1 coord
	ld b, a
    add a, 15                       ;   d: x2 coord
    ld d, a
	ld a, (Enemy_1_Y)				;   c: y1 coord
	ld c, a
    add a, 15                       ;   e: y2 coord
    ld e, a

    ; ;test
	; ld h, 80
	; ld l, 100
	; ld b, 70
	; ld c, 90
	; ld d, 110
	; ld e, 101

	call CheckCollision             ; 
    ;or a							; same as cp 0, but faster
    jp nz, .colisionTrue


.skipCheckEnemy_1:

	ld a, (Enemy_Shot_1_Show)			;
	cp 0
	jp z, .next

	ld a, (Enemy_Shot_1_X)				;
	ld b, a
	ld a, (Enemy_Shot_1_DeltaX)
	add a, b
    cp 0
    jp z, .disableEnemyShot           	;   if x == 0 disable enemy shot
	
	ld (Enemy_Shot_1_X), a				;

	ld a, (Enemy_Shot_1_Y)				;
	inc a
	cp 192
    jp z, .disableEnemyShot           	;   if y == 192 disable enemy shot

	ld (Enemy_Shot_1_Y), a				;

	jp .next

.disableEnemyShot:
	ld a, 0
	ld (Enemy_Shot_1_Show), a			;


	;rest of logic here
.next:

    ret

.colisionTrue:
	ld a, 0							; hide enemy
	ld (Enemy_1_Show), a

	call DisableShot
    ; ld a, (Player_Shot)
	; dec a                       	; reset flag of shot fired
    ; ld (Player_Shot), a         	; 

	; ld d, 0							;   d: x coord
	; ld e, 192						;   e: y coord		; place sprite off screen
	; ld a, 63					    ;   a: pattern number (0-63)
	; ld b, 2							;   b: layer (0-31)
	; call PutSprite16x16				;   put non existent sprite at layer, to hide the shot


	; add points to the score
	ld hl, (Player_Score)			;
	; attention: BCD constants should always be written in hexa
	ld bc, 0x05						; TODO: get this value correct for each kind of enemy
	;add hl, bc
	ld d, h							; high byte
	ld a, l							; low byte
	add a, c
	daa
	jp nc, .notIncScoreHi
	inc d
.notIncScoreHi:
	ld h, d
	ld l, a
	ld (Player_Score), hl			; save updated score

	call ShowScore

	; call ShowScore
	; ; show updated score on screen
	; ld hl, Player_Score       	; LSB
    ; ld d, 2                     ; size in bytes
    ; ld bc, 10                   ; names table offset (0-255)
    ; call PrintNumber_LittleEndian

    ret