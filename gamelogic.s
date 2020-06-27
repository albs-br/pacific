
GameLogic:

    ; Test colision between shot and enemy
	ld a, (Player_Shot_X)			;   h: x coord
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

    ;test
	ld h, 80
	ld l, 100
	ld b, 70
	ld c, 90
	ld d, 110
	ld e, 101

	call CheckCollision             ; 
    cp a
    jp nz, .colisionTrue

    ret

.colisionTrue:
	ld a, 0							; hide enemy
	ld (Enemy_1_Show), a

    ret