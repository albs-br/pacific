ReadInput:


    ; Check for ESC key (pause)
    ld a, 7                 ; 7th line
    call BIOS_SNSMAT        ; Read Data Of Specified Line From Keyboard Matrix
    bit 2, a                ; 6th bit (esc key)
    call z, Pause




    ld a, (Player_State)
    cp 0
    ret nz                  ; return if player isn't alive


    ld ix, Player_CollisionBox



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





    ; check if trigger pressed only after trigger released
    ; to avoid sequencial firing by just keeping trigger pressed
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
    ld (ix + Struct_CollisionBox.X), a      ; set X of collision box

    ret


PlanePlayerRight:
    ld a, (Player_X)            ; player to left
    inc a
    cp 241
    ret nc                      ; cancel if x >= 241

    ld (Player_X), a            ; save value
    ld (ix + Struct_CollisionBox.X), a      ; set X of collision box

    ret


PlanePlayerUp:
    ld a, (Player_Y)            ; player up
    dec a
    cp TOP_SCREEN - 1
    ret z                       ; cancel if y=TOP_SCREEN

    ld (Player_Y), a            ; save value
    ld (ix + Struct_CollisionBox.Y), a      ; set Y of collision box

    ret


PlanePlayerDown:
    ld a, (Player_Y)            ; player down
    inc a
    cp 175
    ret nc                      ; cancel if y >= 175

    ld (Player_Y), a            ; save value
    ld (ix + Struct_CollisionBox.Y), a      ; set Y of collision box

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

    ld ix, Player_Shot_CollisionBox

    add 6
    ld (ix + Struct_CollisionBox.X), a      ; set X of collision box
    ld a, 4
    ld (ix + Struct_CollisionBox.width), a  ; set width of collision box

    ld a, (Player_Y)                        ; set Y of shot = Y of player
    ld (Player_Shot_Y), a                   ;

    ld (ix + Struct_CollisionBox.Y), a      ; set Y of collision box
    ld a, 9
    ld (ix + Struct_CollisionBox.height), a ; set height of collision box

    ld a, 2 * 4                             ; restore shot pattern
    ld (Player_Shot_Pattern), a

    ret



PlaneTriggerReleased:
    ld a, 0                                 ; reset flag of shot fired
    ld (Player_Trigger_Pressed), a          ; trigger pressed flag

    ret



Pause:

    ; write 'PAUSE' on midscreen
	ld	de, NamesTable + 256 + (32 * 4) + 16 - 2        ; VRAM Address
	ld	hl, Msg_Pause                                   ;
    call PrintString                                    ; Write string in screen 2 (hl: string addr, de: vram addr)

    ; wait for ESC to be released
    ld a, 7                 ; 7th line
    call BIOS_SNSMAT        ; Read Data Of Specified Line From Keyboard Matrix
    bit 2, a                ; 6th bit (esc key)
    jp z, Pause

.isPaused:
    ; wait for ESC to be pressed again
    ld a, 7                 ; 7th line
    call BIOS_SNSMAT        ; Read Data Of Specified Line From Keyboard Matrix
    bit 2, a                ; 6th bit (esc key)
    jp nz, .isPaused

.wait:
    ; wait for ESC to be released to unpause
    ld a, 7                 ; 7th line
    call BIOS_SNSMAT        ; Read Data Of Specified Line From Keyboard Matrix
    bit 2, a                ; 6th bit (esc key)
    jp z, .wait


    ; Unpause
    ; remove 'PAUSE' string from screen
	ld	hl, NamesTable + 256 + (32 * 4) + 16 - 2 ; VRAM start address
    ld  bc, 5            ; number of bytes
    ld  a, Tile_Sea_Number                ; value
    call BIOS_FILVRM        ; Fill VRAM

    ret