ReadInput:


    ld a, 8                 ; 8th line
    call BIOS_SNSMAT        ; Read Data Of Specified Line From Keyboard Matrix
    bit 4, a                ; 4th bit (key left), table with all keys on MSX Progs em Ling. de Maq. pag 58
    call z, PlanePlayerLeft

    ld a, 8                 ; 8th line
    call BIOS_SNSMAT        ; Read Data Of Specified Line From Keyboard Matrix
    bit 7, a                ; 7th bit (key right)
    call z, PlanePlayerRight

    ld a, 8                 ; 8th line
    call BIOS_SNSMAT        ; Read Data Of Specified Line From Keyboard Matrix
    bit 0, a                ; 0th bit (space bar)
    call z, PlanePlayerShot

    ret




PlanePlayerLeft:
    ld a, (Player_X)            ; player to left
    dec a
    ret z                       ; cancel if x=1
    ld (Player_X), a            ; save value

    ret



PlanePlayerRight:
    ld a, (Player_X)            ; player to left
    inc a
    cp 241
    ret nc                      ; cancel if x >= 231
    ld (Player_X), a            ; save value

    ret


PlanePlayerShot:
    ld a, (Player_Shot)         ; player shot
    cp 0
    ret nz                      ; cancel if already shot

    inc a                       ; set indicator of shot fired
    ld (Player_Shot), a         ; 

    ld a, (Player_X)            ; set X of shot = X of player
    ld (Player_Shot_X), a       ;

    ld a, (Player_Y)            ; set Y of shot = Y of player
    ld (Player_Shot_Y), a       ;

    ret