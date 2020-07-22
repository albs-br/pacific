
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
	ld	de, NamesTable + 256 + (32 * 4) + 16 - 2        ; VRAM Address
	ld	hl, Msg_Start                                   ;
    call PrintString                                    ; Write string in screen 2 (hl: string addr, de: vram addr)

    ; Write 'v.1.0.0     ANDREBAPTISTA.COM.BR' on screen bottom
	ld	de, NamesTable + 256 + 256 + (32 * 7)           ; VRAM Address
	ld	hl, Msg_TitleBottomLine                         ;
    call PrintString                                    ; Write string in screen 2 (hl: string addr, de: vram addr)

.loop:
    jp .loop

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

    ; Wait some seconds
    ld hl, 3000
    ld b, 255
.wait:
    djnz .wait

    dec hl
    ld a, h
    or l                                                ; h OR l, to check zero

    ld b, 255
    jp nz, .wait

    ret