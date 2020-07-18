
GameLogicEnemy:

	; ld a, (Enemy_1_Show)			; if enemy 1 is hidden, skip enemy logic/check collision
	ld a, (ix)			; if enemy 1 is hidden, skip enemy logic/check collision
	cp 0
	jp z, .skipCheckEnemy_1

	; update enemy position
	;if(enemytype == 0)
	; ld a, (Enemy_1_Type)			;
	ld a, (ix + 2)			;

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
	; ld a, (Enemy_1_Y)				;
	ld a, (ix + 6)				;
	inc a
	cp 192
	call z, .hideEnemy

	; ld (Enemy_1_Y), a				; save updated value
	ld (ix + 6), a				; save updated value

	jp .contGameLogic

.enemyType_1:
	; ld a, (Enemy_1_X)				;
	ld a, (ix + 5)				;
	dec a
	cp 0
	call z, .hideEnemy

	; ld (Enemy_1_X), a				; save updated value
	ld (ix + 5), a				; save updated value

	jp .contGameLogic

.enemyType_2:
	; ld a, (Enemy_1_X)				;
	ld a, (ix + 5)				;
	inc a
	cp 0
	call z, .hideEnemy

	; ld (Enemy_1_X), a				; save updated value
	ld (ix + 5), a				; save updated value

	jp .contGameLogic

.hideEnemy:
	ld a, 0
	; ld (Enemy_1_Show), a			; hide enemy
	ld (ix), a			; hide enemy
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

	; ld a, (Enemy_1_X)				;   b: x1 coord
	ld a, (ix + 5)				;   b: x1 coord
	ld b, a
    add a, 15                       ;   d: x2 coord
    ld d, a
	; ld a, (Enemy_1_Y)				;   c: y1 coord
	ld a, (ix + 6)				;   c: y1 coord
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

	; ld a, (Enemy_Shot_1_Show)			;
	ld a, (ix + 8)			;
	cp 0
	jp z, .next

	; ld a, (Enemy_Shot_1_X)				;
	ld a, (ix + 9)				;
	ld b, a
	; ld a, (Enemy_Shot_1_DeltaX)
	ld a, (ix + 11)
	add a, b
    cp 0
    jp z, .disableEnemyShot           	;   if x == 0 disable enemy shot
	
	; ld (Enemy_Shot_1_X), a				;
	ld (ix + 9), a				;

	; ld a, (Enemy_Shot_1_Y)				;
	ld a, (ix + 10)				;
	inc a
	cp 192
    jp z, .disableEnemyShot           	;   if y == 192 disable enemy shot

	; ld (Enemy_Shot_1_Y), a				;
	ld (ix + 10), a				;

	jp .next

.disableEnemyShot:
	ld a, 0
	; ld (Enemy_Shot_1_Show), a			;
	ld (ix + 8), a			;


	;rest of logic here
.next:

    ret

.colisionTrue:
	ld a, 0							; hide enemy
	; ld (Enemy_1_Show), a
	ld (ix), a
	inc a							; start animation
	; ld (Enemy_1_State), a
	ld (ix + 1), a

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

    ret