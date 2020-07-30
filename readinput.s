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



    ; read joystick
    ld a, 1                 ; 1: joystick 1
    call BIOS_GTSTCK
    cp 0
    jp nz, .readJoystick    ; if joystick status is <> 0 (no direction), skip to check joystick



    ; read keyboard
    ld a, 8                 ; 8th line
    call BIOS_SNSMAT        ; Read Data Of Specified Line From Keyboard Matrix
    ld c, a                 ; save keyboard status

    ; ld a, c
    bit 4, a                ; 4th bit (key left), table with all keys on MSX Progs em Ling. de Maq. pag 58
    jp z, .keyboardLeft

    ; ld a, c
    bit 7, a                ; 7th bit (key right)
    jp z, .keyboardRight
.checkKeyboardUpDown:
    ld a, c
    bit 5, a                ; 5th bit (key up)
    jp z, .keyboardUp

    ; ld a, c
    bit 6, a                ; 6th bit (key down)
    jp z, .keyboardDown
    
    jp ReadInput.checkTrigger

.readJoystick:
    ld d, a                 ; save joystick direction

    ;ld a, d
    cp 7                    ; joystick to left
    jp z, .joystickLeft

    ;ld a, d
    cp 3                    ; joystick to right
    jp z, .joystickRight

    ; ld a, d
    cp 1                    ; joystick to up
    jp z, .joystickUp

    ; ld a, d
    cp 5                    ; joystick to down
    jp z, .joystickDown

; .checkJoystickDiagonals:
    ; ld a, d
    cp 2                    ; joystick to up-right
    jp z, .joystickUpRight

    cp 8                    ; joystick to up-left
    jp z, .joystickUpLeft

    cp 6                    ; joystick to down-left
    jp z, .joystickDownLeft

    cp 4                    ; joystick to down-right
    jp z, .joystickDownRight


    jp ReadInput.checkTrigger

.keyboardLeft:
    call DoPlaneLeft
    jp .checkKeyboardUpDown

.keyboardRight:
    call DoPlaneRight
    jp .checkKeyboardUpDown

.keyboardUp:
    call DoPlaneUp
    jp .checkTrigger

.keyboardDown:
    call DoPlaneDown
    jp .checkTrigger



.joystickLeft:
    call DoPlaneLeft
    jp .checkTrigger

.joystickRight:
    call DoPlaneRight
    jp .checkTrigger

.joystickUp:
    call DoPlaneUp
    jp .checkTrigger

.joystickDown:
    call DoPlaneDown
    jp .checkTrigger

.joystickUpRight:
    call DoPlaneUp
    call DoPlaneRight
    jp .checkTrigger

.joystickUpLeft:
    call DoPlaneUp
    call DoPlaneLeft
    jp .checkTrigger

.joystickDownLeft:
    call DoPlaneDown
    call DoPlaneLeft
    jp .checkTrigger

.joystickDownRight:
    call DoPlaneDown
    call DoPlaneRight
    jp .checkTrigger

.checkTrigger:
    ; check if trigger pressed only after trigger released
    ; to avoid sequencial firing by just keeping trigger pressed
    ld a, (Player_Trigger_Pressed)          ; get trigger pressed flag
    cp 0
    call z, .CheckTriggerPressed              
    call .CheckTriggerReleased


    ret                     ; ret of ReadInput

.CheckTriggerPressed:
    ld a, 8                 ; 8th line
    call BIOS_SNSMAT        ; Read Data Of Specified Line From Keyboard Matrix
    bit 0, a                ; 0th bit (space bar)
    jp z, .spacebarPressed

    ld a, 1                 ; 1=JOY 1, TRIGGER A
    call BIOS_GTTRIG        ; Output: A=255 button pressed, A=0 button released
    jp nz, .joystickButtonPressed

    ret

.spacebarPressed:
    ld a, 1
    ld (TypeLastShotTriggered), a
    jp planePlayerShot
    ret

.joystickButtonPressed:
    ld a, 2
    ld (TypeLastShotTriggered), a
    jp planePlayerShot
    ret

.checkTriggerPressedReturn:
    ret

; TODO: fix bug both button and spacebar pressed continuously are shoting
; the reason is this routine, if one of the two are released, the flag is reset
.CheckTriggerReleased:

    ; if(TypeLastShotTriggered == Spacebar) checkSpacebarReleased;
    ; else if(TypeLastShotTriggered == Spacebar) checkJoystickButtonReleased;
    ld a, (TypeLastShotTriggered)
    cp 1
    jp z, .checkSpacebarReleased
    cp 2
    jp z, .checkJoystickButtonReleased
    ret

.checkSpacebarReleased:
    ld a, 8                 ; 8th line
    call BIOS_SNSMAT        ; Read Data Of Specified Line From Keyboard Matrix
    bit 0, a                ; 0th bit (space bar)
    jp nz, planeTriggerReleased
    ret

.checkJoystickButtonReleased:
    ld a, 1                 ; 1=JOY 1, TRIGGER A
    call BIOS_GTTRIG        ; Output: A=255 button pressed, A=0 button released
    jp z, planeTriggerReleased
    ret
.checkTriggerReleasedReturn:
    ret



DoPlaneLeft:
    ld a, (Player_X)            ; player to left
    dec a
    ret z                       ; cancel if x=1

    ld (Player_X), a            ; save value
    ld (ix + Struct_CollisionBox.X), a      ; set X of collision box

    ret


DoPlaneRight:
    ld a, (Player_X)            ; player to right
    inc a
    cp 241
    ret nc                      ; cancel if x >= 241

    ld (Player_X), a            ; save value
    ld (ix + Struct_CollisionBox.X), a      ; set X of collision box

    ret


DoPlaneUp:
    ld a, (Player_Y)            ; player up
    dec a
    cp TOP_SCREEN - 1
    ret z                       ; cancel if y=TOP_SCREEN

    ld (Player_Y), a            ; save value
    ld (ix + Struct_CollisionBox.Y), a      ; set Y of collision box

    ret


DoPlaneDown:
    ld a, (Player_Y)            ; player down
    inc a
    cp 175
    ret nc                      ; cancel if y >= 175

    ld (Player_Y), a            ; save value
    ld (ix + Struct_CollisionBox.Y), a      ; set Y of collision box

    ret

planePlayerShot:
    ; ld a, (Player_Shot)                             ; get player shot counter
    ; cp 0
    ; ; ret nz                                        ; cancel if already shot
    ; jp nz, ReadInput.checkTriggerPressedReturn      ; cancel if already shot


    call GetFirstAvailableShot

    jp z, ReadInput.checkTriggerPressedReturn       ; cancel if no shot avaliable



    ld a, (Player_Trigger_Pressed)                  ; get trigger pressed flag
    cp 0
    ; ret nz                                        ; cancel if already pressed
    jp nz, ReadInput.checkTriggerPressedReturn      ; cancel if already pressed




    ld a, 1                                         ; set flag of shot fired
    ; ld (Player_Shot), a                             ; 
    ld (iy + Struct_PlayerShot.Enabled), a
    ld (Player_Trigger_Pressed), a                  ; trigger pressed flag

    
    

    ld a, (Player_X)                                ; set X of shot = X of player
    ld (iy + Struct_PlayerShot.X), a
    ;ld (Player_Shot_X), a                           ;



    ld ix, Player_Shot_CollisionBox     

    add 6       
    ld (ix + Struct_CollisionBox.X), a              ; set X of collision box
    ld a, 4     
    ld (ix + Struct_CollisionBox.width), a          ; set width of collision box

    ld a, (Player_Y)                                ; set Y of shot = Y of player
    ; ld (Player_Shot_Y), a                           ;
    ld (iy + Struct_PlayerShot.Y), a

    ld (ix + Struct_CollisionBox.Y), a              ; set Y of collision box
    ld a, 9     
    ld (ix + Struct_CollisionBox.height), a         ; set height of collision box

    ld a, 2 * 4                                     ; restore shot pattern
    ; ld (Player_Shot_Pattern), a     
    ld (iy + Struct_PlayerShot.Pattern), a

    ; and 0                                         ; force Z flag
    ; ret
    jp ReadInput.checkTriggerPressedReturn



planeTriggerReleased:
    ld a, 0                                 ; reset flag of shot fired
    ld (Player_Trigger_Pressed), a          ; trigger pressed flag

    jp ReadInput.checkTriggerReleasedReturn



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

