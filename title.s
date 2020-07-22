
TitleScreen:

    ; Clear screen (fill screen with all black patterns)
	; Fill all 3 names tables
    ld	hl, NamesTable                                  ; VRAM start address
    ld  bc, 256 * 3                                     ; number of bytes
    ld  a, 1                                            ; value
    call BIOS_FILVRM                                    ; Fill VRAM

    ; Title 'PACIFIC'
	ld	bc, 32 * 5                                      ; Block length
	ld	de, NamesTable + 128                            ; VRAM start address
	ld	hl, TitleTiles                                  ; RAM start address
    call BIOS_LDIRVM                                    ; Block transfer to VRAM from memory


    ; Write 'START' on midscreen
	ld	de, NamesTable + 256 + (32 * 4) + 16 - 10       ; VRAM Address
	ld	hl, Msg_Start                                   ;
    call PrintString                                    ; Write string in screen 2 (hl: string addr, de: vram addr)

    ; Write 'v.1.0.0     ANDREBAPTISTA.COM.BR' on screen bottom
	ld	de, NamesTable + 256 + 256 + (32 * 7)           ; VRAM Address
	ld	hl, Msg_TitleBottomLine                         ;
    call PrintString                                    ; Write string in screen 2 (hl: string addr, de: vram addr)



.titleloop:

    ld a, 0x51                                          ; a: color pattern for upper  
    ld d, 0x71                                          ; d: color pattern for bottom
    call ChangeColorTitle
    call .delay
    ret nz

    ld a, 0x41                                          ; a: color pattern for upper  
    ld d, 0x71                                          ; d: color pattern for bottom
    call ChangeColorTitle
    call .delay
    ret nz

    jp .titleloop


.delay:
    ;ld c, 0x04                  ; 3 nested loops
    ld d, 0x60                  
    ld e, 0xff              
.loop:                          ; 
    ; check if spacebar is pressed
    ld a, 8                 ; 8th line
    call BIOS_SNSMAT        ; Read Data Of Specified Line From Keyboard Matrix
    bit 0, a                ; 0th bit (space bar)
    jp z, .spacebarPressed

    dec e
    jp nz, .loop                ; inner loop
    dec d
    jp nz, .loop                ; 
    ; dec c
    ; jp nz, .loop                ; outer loop
    
    xor a                       ; same as ld a, 0, but faster
    ret

.spacebarPressed:
    or 1                        ; same as ld a, 1, but faster
    ret



; Input:
;    a: Level Number (1-6)
LevelTitleScreen:
    push hl
    push af

    ; Clear screen (fill screen with all black patterns)
	; Fill all 3 names tables
    ld	hl, NamesTable                                  ; VRAM start address
    ld  bc, 256 * 3                                     ; number of bytes
    ld  a, 1                                            ; value
    call BIOS_FILVRM                                    ; Fill VRAM

    ; Write 'LEVEL ' on midscreen
	ld	de, NamesTable + 256 + (32 * 3) + 16 - 3        ; VRAM Address
	ld	hl, Msg_Level                                   ;
    call PrintString                                    ; Write string in screen 2 (hl: string addr, de: vram addr)
    
    ; Write level number
    pop af
    add 48
    ld h, d
    ld l, e
	call BIOS_WRTVRM		                            ; Writes data in VRAM (HL: address, A: value)


    ; Write level name on midscreen
	ld	de, NamesTable + 256 + (32 * 4) + 16 - 8        ; VRAM Address
    pop hl
    call PrintString                                    ; Write string in screen 2 (hl: string addr, de: vram addr)


    call WaitSomeSeconds

    ret