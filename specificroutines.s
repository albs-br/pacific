; specificroutines.s (can NOT be used on other programs without changes)

; depends on:
;   include/msxbios.s
;   include/vram.s
 


InitVariables:
 ; fill all bytes of counter with 0
    ld a, 0                             ; value
    ld hl, Counter
    ld b, 5                             ; number of bytes
.loop:
    ld (hl), a                          ; save value
    inc hl
    djnz .loop

    ld a, 120                           ; (256/2) + 8  ; middle of screen minus half of sprite
    ld (Player_X), a                    ; save value
    ld a, 160                           ;
    ld (Player_Y), a                    ; save value
    ld a, 0                             ;
    ld (Player_Shot), a                 ; save value

    ld (Enemy_1_Show), a                ; save value
    ld (Enemy_1_State), a               ; save value
    
    ld (Enemy_Shot_1_Show), a           ; save value

    ld (Player_Trigger_Pressed), a      ; save value
    ld bc, 0
    ld (Player_Score), bc               ; save value
    ld a, 3                             ;
    ld (Player_Lives), a                ; save value

    
    ; ld a, 120               ;
    ; ld (Enemy_1_X), a       ; save value
    ; ld a, 20                ;
    ; ld (Enemy_1_Y), a       ; save value
    
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
    ; daa                       ; decimal adjust accumulator
    ld (hl), a                  ; save value

    jp z, .loop

.continue:
    

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

    ; counter value is on AB. eg. counter = 0x0300
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
    push hl
    ld a, (hl)
    cp d
    jp nz, .next               ; checks high byte of address
    inc hl
    ld a, (hl)
    cp e
    jp nz, .next               ; checks low byte of address

    pop hl
    
    ; do the action
    ; call PlanePlayerShot
    inc hl
    inc hl
    ld a, (hl)                  ; get action type
    cp 0                        ; 0 = show enemy
    call z, .showEnemy
    cp 1                        ; 1 = enemy shoots
    call z, .enemyShoots

    jp .continue1

.showEnemy:
    ld a, 1
    ld (Enemy_1_Show), a        ; show enemy

	ld a, 0
	ld (Enemy_1_State), a	    ; disable explosion animation

    inc hl
    ld a, (hl)                  ; get enemy type
    ld (Enemy_1_Type), a        ; save value

    inc hl
    ld a, (hl)                  ; get 1st color
    ld (Enemy_1_1stColor), a    ; save value
    
    inc hl
    ld a, (hl)                  ; get 2nd color
    ld (Enemy_1_2ndColor), a    ; save value
    
    inc hl
    ld a, (hl)                  ; get x coord
    ld (Enemy_1_X), a           ; save value
    
    inc hl
    ld a, (hl)                  ; get y coord
    ld (Enemy_1_Y), a           ; save value

    ret

.enemyShoots:
    inc hl                      ;TODO: use add hl, bc
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, (hl)                  ; get number of related enemy
    cp 0                        ; TODO: optimize
    jp z, .checkIfEnemy_1_IsAlive
    ret

.checkIfEnemy_1_IsAlive:
    ld a, (Enemy_1_Show)
    cp 0
    ret z

    ld a, 1
    ld (Enemy_Shot_1_Show), a

    inc hl
    ld a, (hl)                  ; get delta x (-1 to +1)
    ld (Enemy_Shot_1_DeltaX), a ; save
    
    ld a, (Enemy_1_X)           ; get x coord of enemy
    add a, 6                    ; add 6
    ld (Enemy_Shot_1_X), a      ; save as x coord of shot
    
    ld a, (Enemy_1_Y)           ; get y coord of enemy
    add a, 16                   ; add 16
    ld (Enemy_Shot_1_Y), a      ; save as y coord of shot
    
    ret

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




    IFDEF DEBUG
        ; Show counter on screen (debug mode)
        ld hl, Counter+4            ; LSB (5th byte)
        ld d, 2                     ; size in bytes (for now using only 2 bytes, although 5 bytes were reserved)
        ld bc, 35                   ; names table offset (0-255), 35 = 2nd line, 4th column
        call PrintNumber
    ENDIF


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

	ld d, 0							;   d: x coord
	ld e, 256 - 16					;   e: y coord		; place sprite off screen
	ld a, 63					    ;   a: pattern number (0-63)
	ld b, 2							;   b: layer (0-31)
	call PutSprite16x16				;   put non existent sprite at layer, to hide the shot

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
		ld a, 10							;   a: pattern number (0-63)
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