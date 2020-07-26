; specificroutines.s (can NOT be used on other programs without changes)

; depends on:
;   include/msxbios.s
;   include/vram.s
 


InitVariables:
 ; fill all bytes of counter with 0
    call ResetCounter
;     ld a, 0                             ; value
;     ld hl, Counter
;     ld b, 5                             ; number of bytes
; .loop:
;     ld (hl), a                          ; save value
;     inc hl
;     djnz .loop

    ; ld a, 1                             ;
    ; ld (Level), a                       ;


    ld ix, Player_CollisionBox

    ld a, 120                           ; (256/2) + 8  ; middle of screen minus half of sprite
    ld (Player_X), a                    ;
    ld (ix + Struct_CollisionBox.X), a
    ld a, 160                           ;
    ld (Player_Y), a                    ;
    ld (ix + Struct_CollisionBox.Y), a

    ld a, 16

    ld (ix + Struct_CollisionBox.width), a  ; width and height of plane col box
    ld (ix + Struct_CollisionBox.height), a

    ld ix, EnemyTemp_CollisionBox
    ld (ix + Struct_CollisionBox.width), a
    ld (ix + Struct_CollisionBox.height), a


    ld a, 0                             ; set all to zero
    
    call ResetCounter

    ld (Player_State), a                ;
    ld (Player_Shot), a                 ;
    ld (Enemy_0_Show), a                ;
    ld (Enemy_0_State), a               ;
    ld (Enemy_1_Show), a                ;
    ld (Enemy_1_State), a               ;
    ld (Enemy_2_Show), a                ;
    ld (Enemy_2_State), a               ;
    ld (Enemy_3_Show), a                ;
    ld (Enemy_3_State), a               ;
    ld (Enemy_4_Show), a                ;
    ld (Enemy_4_State), a               ;
    ld (Enemy_Shot_0_Show), a           ;
    ld (Enemy_Shot_1_Show), a           ;
    ld (Enemy_Shot_2_Show), a           ;
    ld (Enemy_Shot_3_Show), a           ;
    ld (Enemy_Shot_4_Show), a           ;
    ld (Player_Trigger_Pressed), a      ;

    ; ld bc, 0
    ; ld (Player_Score), bc               ;
    ; ld a, 3                             ;
    ; ld (Player_Lives), a                ;
    
    ret




; ---------------------------------------------------------
; Increment counter, do some actions based on its value 
; and show it on screen if debug mode = true
IncrementCounter:

	ld hl, Counter+5            ; LSB (5th byte) + 1 (big endian)
    ld b, 6                     ; number of bytes of counter + 1
.loop:
    dec b
    jp z, .continue

    dec hl    
    ld a, (hl)	    			; get value
    inc a
    ld (hl), a                  ; save value

    jp z, .loop

.continue:

    IFDEF DEBUG
        ; Show counter on screen (debug mode)
        ld hl, Counter + 4          ; LSB (5th byte)
        ld d, 2                     ; size in bytes (for now using only 2 bytes, although 5 bytes were reserved)
        ld bc, 35                   ; names table offset (0-255), 35 = 2nd line, 4th column
        call PrintNumber
    ENDIF


    ; do actions based on current counter value
	ld hl, Counter+4            ; LSB (5th byte)
    ld a, (hl)

    push af
    push hl
    
    and 0000 1111 b
    call z, RotateTile3Thirds   ; background scroll at each 16 cycles

    pop hl

    dec hl                      ; (4th byte)
    ld a, (hl)
    ld b, a
    
    pop af

    ; counter value is on BA. eg. counter = 0x0300
    ; b = 0x03 (hi)
    ; a = 0x00 (lo)

    ; ; if (counter == 0x0300)
    ; cp 0x00
    ; jr nz, .continue1           ; checks LSB (5th byte)
    ; ld a, b
    ; cp 0x03                     
    ; jr nz, .continue1           ; checks 4th byte



    ; look for action to be done on current counter value
    ld d, b                         ; hi
    ld e, a                         ; lo
    ld hl, LevelDataStart

    ; TODO: lots of optimizations are possible here
    ; 1 - save the address of last action done, next time start there instead of from the beginning
    ; 2 - after read an addr on chunck, tests if is > than current counter, if so, gives up, as the actions are ordered

.loop1:
; TODO: trade this by a dw
    ld a, (hl)
    
    cp 255                     ; value 255 in the high byte of the counter in level data means end of data
    ret z
    
    push hl


    ; TODO: make this optimization work
    ; DE: current counter value
    ; HL: value on the current position of level data
;     ld c, a
;     inc hl
;     ld a, (hl)
;     ld l, a
;     ld h, c
;     call BIOS_DCOMPR            ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
;     jp z, .equal
;     call nc, .largerThan        ; return if HL > DE
;     jp .next                    ; try next if HL < DE

; .largerThan:
;     pop hl
;     ret




    ; old code, slow, but works
    cp d
    jp nz, .next               ; checks high byte of address
    inc hl
    ld a, (hl)
    cp e
    jp nz, .next               ; checks low byte of address




.equal:
    pop hl

    ; do the action
    inc hl
    inc hl
    ld a, (hl)                  ; get action type
    cp 0                        ; 0 = show enemy
    call z, .showEnemy
    cp 1                        ; 1 = enemy shoots
    call z, .enemyShoots
    cp 200                      ; 200 = level end
    jp z, .levelEnd


    jp .continue1

.showEnemy:

    ; ld ix, Enemy_1_Base_Address
    ; jp .contEnemyNumber

;TODO check enemy number and update correct variables
; if (Enemy_N_Type == 0) ix = Enemy_1_Base_Address
    push hl

    ld bc, 6
    add hl, bc

    ; inc hl
    ; inc hl
    ; inc hl
    ; inc hl
    ; inc hl
    ; inc hl
    ld a, (hl)                  ; get enemy number

    cp 0
    jp z, .enemyNumber_0

    cp 1
    jp z, .enemyNumber_1

    cp 2
    jp z, .enemyNumber_2

    cp 3
    jp z, .enemyNumber_3

    cp 4
    jp z, .enemyNumber_4

    pop hl

; call bios_beep ;debug
; jp .contEnemyNumber

.enemyNumber_0:
    pop hl
    ld ix, Enemy_0_Base_Address
    jp .contEnemyNumber
.enemyNumber_1:
    pop hl
    ld ix, Enemy_1_Base_Address
    jp .contEnemyNumber
.enemyNumber_2:
    pop hl
    ld ix, Enemy_2_Base_Address
    jp .contEnemyNumber
.enemyNumber_3:
    pop hl
    ld ix, Enemy_3_Base_Address
    jp .contEnemyNumber
.enemyNumber_4:
    pop hl
    ld ix, Enemy_4_Base_Address
    jp .contEnemyNumber

.contEnemyNumber:
    ld a, 1
    ; ld (Enemy_1_Show), a        ; show enemy
    ld (ix), a                  ; show enemy

	ld a, 0
	; ld (Enemy_1_State), a	    ; disable explosion animation
	ld (ix + 1), a	            ; disable explosion animation

    inc hl
    ld a, (hl)                  ; get enemy type
    ; ld (Enemy_1_Type), a        ; save value
    ld (ix + 2), a              ; save value

    inc hl
    ld a, (hl)                  ; get 1st color
    ; ld (Enemy_1_1stColor), a    ; save value
    ld (ix + 3), a              ; save value
    
    inc hl
    ld a, (hl)                  ; get 2nd color
    ; ld (Enemy_1_2ndColor), a    ; save value
    ld (ix + 4), a              ; save value
    
    inc hl
    ld a, (hl)                  ; get x coord
    ; ld (Enemy_1_X), a           ; save value
    ld (ix + 5), a              ; save value
    
    inc hl
    ld a, (hl)                  ; get y coord
    ; ld (Enemy_1_Y), a           ; save value
    ld (ix + 6), a              ; save value

    ret

.enemyShoots:

;TODO check enemy number and update correct variables
    ; ld ix, Enemy_1_Base_Address

    ld bc, 7
    add hl, bc
    ; inc hl                      ;TODO: use add hl, bc
    ; inc hl
    ; inc hl
    ; inc hl
    ; inc hl
    ; inc hl
    ; inc hl
    ld a, (hl)                  ; get number of related enemy
    
    cp 0                        ; TODO: optimize
    jp z, .enemy_0_shots

    cp 1
    jp z, .enemy_1_shots

    cp 2
    jp z, .enemy_2_shots

    cp 3
    jp z, .enemy_3_shots

    cp 4
    jp z, .enemy_4_shots

    ret

.enemy_0_shots:
    ld ix, Enemy_0_Base_Address
    jp .checkIfEnemy_IsAlive

.enemy_1_shots:
    ld ix, Enemy_1_Base_Address
    jp .checkIfEnemy_IsAlive

.enemy_2_shots:
    ld ix, Enemy_2_Base_Address
    jp .checkIfEnemy_IsAlive

.enemy_3_shots:
    ld ix, Enemy_3_Base_Address
    jp .checkIfEnemy_IsAlive

.enemy_4_shots:
    ld ix, Enemy_4_Base_Address
    jp .checkIfEnemy_IsAlive

.checkIfEnemy_IsAlive:
    ; ld a, (Enemy_1_Show)
    ld a, (ix)
    cp 0
    ret z

    ld a, 1
    ; ld (Enemy_Shot_1_Show), a
    ld (ix + 8), a

    inc hl
    ld a, (hl)                  ; get delta x (-1 to +1)
    ; ld (Enemy_Shot_1_DeltaX), a ; save
    ld (ix + 11), a ; save
    
    ; ld a, (Enemy_1_X)           ; get x coord of enemy
    ld a, (ix + 5)              ; get x coord of enemy
    add a, 6                    ; add 6
    ; ld (Enemy_Shot_1_X), a      ; save as x coord of shot
    ld (ix + 9), a      ; save as x coord of shot
    
    ; ld a, (Enemy_1_Y)           ; get y coord of enemy
    ld a, (ix + 6)              ; get y coord of enemy
    add a, 16                   ; add 16
    ; ld (Enemy_Shot_1_Y), a      ; save as y coord of shot
    ld (ix + 10), a      ; save as y coord of shot
    
    ret

.levelEnd:

    ; write 'LEVEL  FINISHED' on midscreen
	ld	de, NamesTable + 256 + (32 * 4) + 16 - 7        ; VRAM Address
	ld	hl, Msg_LevelFinished                           ;
    call PrintString                                    ; Write string in screen 2 (hl: string addr, de: vram addr)
    ; write 'CONGRATULATIONS' on midscreen
	ld	de, NamesTable + 256 + (32 * 5) + 16 - 7        ; VRAM Address
	ld	hl, Msg_LevelFinished_1                         ;
    call PrintString                                    ; Write string in screen 2 (hl: string addr, de: vram addr)

    
    call WaitSomeSeconds
    
    ld hl, Level
    inc (hl)

    pop bc              ; release SP
    jp NewLevel

.next:
    pop hl
    ld bc, LevelDataChunckSize
    add hl, bc                  ; go to next chunk start
    push de
    ld de, LevelDataEnd
    
    ; if hl >= LevelDataEnd then get out loop
    call BIOS_DCOMPR            ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    pop de
    jp nc, .continue1

    jp .loop1


.continue1:




    ; IFDEF DEBUG
    ;     ; Show counter on screen (debug mode)
    ;     ld hl, Counter + 4          ; LSB (5th byte)
    ;     ld d, 2                     ; size in bytes (for now using only 2 bytes, although 5 bytes were reserved)
    ;     ld bc, 35                   ; names table offset (0-255), 35 = 2nd line, 4th column
    ;     call PrintNumber
    ; ENDIF


    ret



;   hl: address of LSB
;   d: size of number in bytes
;   bc: names table offset (0-255)
PrintNumber:
    ld a, (hl)	    			; get value
    push hl
    ld	hl, NamesTable          ; VRAM Address
    add hl, bc                  ;

; .loop:
	push af
    and 0000 1111 b             ; masking to get the low nibble
    add a, 48                   ; convert it to ASCII char (0-9)
	call BIOS_WRTVRM		    ; Writes data in VRAM, as VPOKE (HL: address, A: value)

    pop af
    dec hl                      ; go to previous char position on screen
    and 1111 0000 b             ; masking to get the high nibble
    srl a                       ; shift right 4 times
    srl a
    srl a
    srl a
    add a, 48                   ; convert it to ASCII char (0-9)
	call BIOS_WRTVRM		    ; Writes data in VRAM, as VPOKE (HL: address, A: value)

    pop hl
    dec hl                      ; go to next byte on value
    
    dec bc                      ; go to previous char position on screen (it's necessary 2x)
    dec bc

    dec d
    jp nz, PrintNumber

    ret

;   hl: address of LSB
;   d: size of number in bytes
;   bc: names table offset (0-255)
PrintNumber_LittleEndian:
    ld a, (hl)	    			; get value
    push hl
    ld	hl, NamesTable          ; VRAM Address
    add hl, bc                  ;

; .loop:
	push af
    and 0000 1111 b             ; masking to get the low nibble
    add a, 48                   ; convert it to ASCII char (0-9)
	call BIOS_WRTVRM		    ; Writes data in VRAM, as VPOKE (HL: address, A: value)

    pop af
    dec hl                      ; go to previous char position on screen
    and 1111 0000 b             ; masking to get the high nibble
    srl a                       ; shift right 4 times
    srl a
    srl a
    srl a
    add a, 48                   ; convert it to ASCII char (0-9)
	call BIOS_WRTVRM		    ; Writes data in VRAM, as VPOKE (HL: address, A: value)

    pop hl
    inc hl                      ; go to next byte on value
    
    dec bc                      ; go to previous char position on screen (it's necessary 2x)
    dec bc

    dec d
    jp nz, PrintNumber_LittleEndian

    ret



DisableShot:
    ; ld a, (Player_Shot)
	; dec a                       	; reset flag of shot fired ; CAUSING BUG
    ld a, 0
    ld (Player_Shot), a         	; 

	; ld d, 0							;   d: x coord
	; ld e, 256 - 16					;   e: y coord		; place sprite off screen
	; ld a, 63					    ;   a: pattern number (0-63)
	; ld b, 2							;   b: layer (0-31)
	; call PutSprite16x16				;   put non existent sprite at layer, to hide the shot

    ld a, 0
    ld (Player_Shot_X), a
    ld a, 256 - 16
    ld (Player_Shot_Y), a
    ld a, 63 * 4
    ld (Player_Shot_Pattern), a

    ret



ShowLives:
	; show current number of lives on top of screen
    ld hl, NamesTable + 1	    ; VRAM address
    ld a, (Player_Lives)
    add a, 48	                ; convert number to chars
    call BIOS_WRTVRM	        ; write to VRAM

    ret 



ShowScore:
	; show current score on top of screen
	ld hl, Player_Score       	; LSB
    ld d, 2                     ; size in bytes
    ld bc, 17                   ; names table offset (0-255); position of least significant digit
    call PrintNumber_LittleEndian

    ; add 0 to number at right (score is shown on screen multiplied by ten)
    ld hl, NamesTable + 18	    ; VRAM address
    ld a, 48	                ; char '0'
    call BIOS_WRTVRM	        ; write to VRAM

    ret



GameOver:
    ; write 'GAME OVER' on midscreen
	ld	de, NamesTable + 256 + (32 * 4) + 16 - 4        ; VRAM Address
	ld	hl, Msg_GameOver                                ;
    call PrintString                                    ; Write string in screen 2 (hl: string addr, de: vram addr)

    call WaitSomeSeconds

    jp Execute                                          ; restart game



; Input:
;    a: Level Number (1-6, 0=test level)
LoadLevel:
	
    cp 0
    jp z, .testLevel

    cp 1
    jp z, .level1

    cp 2
    jp z, .level2

    cp 3
    jp z, .level3

    cp 4
    jp z, .level4

    ; else
    jp .testLevel

.testLevel:
    ; ld hl, MsgLevel_Test_Name
    ld hl, Level_Test.msgLevelName
    ; ld de, Level_Test_DataStart
    ld de, Level_Test.levelDataStart
    jp .showLevelTitle

.level1:
    ld hl, Level_1.msgLevelName
    ld de, Level_1.levelDataStart
    jp .showLevelTitle

.level2:
    ld hl, Level_2.msgLevelName
    ld de, Level_2.levelDataStart
    jp .showLevelTitle

.level3:
    ld hl, Level_3.msgLevelName
    ld de, Level_3.levelDataStart
    jp .showLevelTitle

.level4:
    ld hl, Level_4.msgLevelName
    ld de, Level_4.levelDataStart
    jp .showLevelTitle

.showLevelTitle:
    push de

    call LevelTitleScreen


    ; ld hl, Level_Test_DataStart
    pop hl                          ; from DE to HL
    call LoadLevelData

    call LoadNamesTable

    ret



; LoadLevelData
; Input: HL addr of level data to be loaded
LoadLevelData:
    ;ld hl, addr                            ; addr origin
    ld de, LevelDataStart                   ; addr destiny
    ld bc, LevelDataEnd - LevelDataStart    ; number of bytes
    ldir                                    ; copy BC bytes from HL to DE
    
    call ResetCounter
    ret


ResetCounter:
    ;ld a, 0
    xor a                               ; same as ld a, 0 but faster
    ld (Counter), a                     ;
    ld (Counter + 1), a                 ;
    ld (Counter + 2), a                 ;
    ld (Counter + 3), a                 ;
    ld (Counter + 4), a                 ;
    ret

ShowDebugInfo:
    IFDEF DEBUG
		; test sprite (plane type 2 1st color)
		ld d, 128
		ld e, 80
		ld c, 15						;   c: color (0-15)
		ld a, 6							;   a: pattern number (0-63)
		ld b, 20						;   b: layer (0-31)
		call PutSprite16x16				;
		; test sprite (plane type 2 2nd color)
		ld d, 128
		ld e, 80
		ld c, 14						;   c: color (0-15)
		ld a, 7							;   a: pattern number (0-63)
		ld b, 19						;   b: layer (0-31)
		call PutSprite16x16				;
		; test sprite (plane type 2 shadow)
		ld d, 128+8
		ld e, 80+8
		ld c, 1							;   c: color (0-15)
		ld a, 6							;   a: pattern number (0-63)
		ld b, 21						;   b: layer (0-31)
		call PutSprite16x16				;
		; test sprite (explosion frame 1)
		ld d, 160
		ld e, 100
		ld c, 15						;   c: color (0-15)
		ld a, 8							;   a: pattern number (0-63)
		ld b, 22						;   b: layer (0-31)
		call PutSprite16x16				;
		; test sprite (explosion frame 2)
		ld d, 160+16
		ld e, 100
		ld c, 15						;   c: color (0-15)
		ld a, 9							;   a: pattern number (0-63)
		ld b, 23						;   b: layer (0-31)
		call PutSprite16x16				;
		; test sprite (explosion frame 3)
		ld d, 160+32
		ld e, 100
		ld c, 15						;   c: color (0-15)
		ld a, 10						;   a: pattern number (0-63)
		ld b, 24						;   b: layer (0-31)
		call PutSprite16x16				;
		; test sprite (plane type 3 1st color)
		ld d, 128
		ld e, 128
		ld c, 15						;   c: color (0-15)
		ld a, 11						;   a: pattern number (0-63)
		ld b, 15						;   b: layer (0-31)
		call PutSprite16x16				;
		; test sprite (plane type 3 2nd color)
		ld d, 128
		ld e, 128
		ld c, 14						;   c: color (0-15)
		ld a, 12						;   a: pattern number (0-63)
		ld b, 14						;   b: layer (0-31)
		call PutSprite16x16				;
    ENDIF

    ret