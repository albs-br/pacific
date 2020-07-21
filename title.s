; Clear screen (fill screen with all black patterns)

TitleScreen:

	; Fill all 3 names tables
    ld	hl, NamesTable      ; VRAM start address
    ld  bc, 256 * 3      ; number of bytes
    ld  a, 58                ; value
    call BIOS_FILVRM        ; Fill VRAM

    ; write 'START' on midscreen
	ld	bc, 5               ; Block length
	ld	de, NamesTable + 256 + (32 * 4) + 16 - 2 ; VRAM Address
	ld	hl, Msg_Start          ; RAM Address
    call BIOS_LDIRVM        ; Block transfer to VRAM from memory

.loop:
    jp .loop

    ret