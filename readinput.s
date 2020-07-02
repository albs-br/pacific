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
    bit 5, a                ; 5th bit (key up)
    call z, PlanePlayerUp

    ld a, 8                 ; 8th line
    call BIOS_SNSMAT        ; Read Data Of Specified Line From Keyboard Matrix
    bit 6, a                ; 6th bit (key down)
    call z, PlanePlayerDown





    ld a, (Player_Trigger_Pressed)          ; get trigger pressed flag
    cp 0
    call z, .checkTriggerPressed              
    call .checkTriggerReleased

    ret

.checkTriggerPressed:
    ld a, 8                 ; 8th line
    call BIOS_SNSMAT        ; Read Data Of Specified Line From Keyboard Matrix
    bit 0, a                ; 0th bit (space bar)
    call z, PlanePlayerShot
    ret

.checkTriggerReleased:
    ld a, 8                 ; 8th line
    call BIOS_SNSMAT        ; Read Data Of Specified Line From Keyboard Matrix
    bit 0, a                ; 0th bit (space bar)
    call nz, PlaneTriggerReleased
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
    ret nc                      ; cancel if x >= 241
    ld (Player_X), a            ; save value

    ret


PlanePlayerUp:
    ld a, (Player_Y)            ; player up
    dec a
    cp TOP_SCREEN - 1
    ret z                       ; cancel if y=TOP_SCREEN
    ld (Player_Y), a            ; save value

    ret


PlanePlayerDown:
    ld a, (Player_Y)            ; player down
    inc a
    cp 175
    ret nc                      ; cancel if y >= 175
    ld (Player_Y), a            ; save value

    ret


PlanePlayerShot:
    ld a, (Player_Shot)                     ; get player shot flag
    cp 0
    ret nz                                  ; cancel if already shot

    ld a, (Player_Trigger_Pressed)          ; get trigger pressed flag
    cp 0
    ret nz                                  ; cancel if already pressed

    ; call SoundExplosion

    inc a                                   ; set flag of shot fired
    ld (Player_Shot), a                     ; 
    ld (Player_Trigger_Pressed), a          ; trigger pressed flag

    ld a, (Player_X)                        ; set X of shot = X of player
    ld (Player_Shot_X), a                   ;

    ld a, (Player_Y)                        ; set Y of shot = Y of player
    ld (Player_Shot_Y), a                   ;

    ret



PlaneTriggerReleased:
    ld a, 0                                 ; reset flag of shot fired
    ld (Player_Trigger_Pressed), a          ; trigger pressed flag

    ret