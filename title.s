; Clear screen (fill screen with all black patterns)

TitleScreen:

	; Fill all 3 names tables
    ld	hl, NamesTable                                  ; VRAM start address
    ld  bc, 256 * 3                                     ; number of bytes
    ld  a, 1                                            ; value
    call BIOS_FILVRM                                    ; Fill VRAM

    ; Write 'START' on midscreen
	ld	de, NamesTable + 256 + (32 * 4) + 16 - 2        ; VRAM Address
	ld	hl, Msg_Start                                   ;
    call PrintString                                    ; Write string in screen 2 (hl: string addr, de: vram addr)

    ; Write 'v.1.0.0   2020  ANDREBAPTISTA.COM.BR' on screen bottom
	ld	de, NamesTable + 256 + 256 + (32 * 7)           ; VRAM Address
	ld	hl, Msg_TitleBottomLine                         ;
    call PrintString                                    ; Write string in screen 2 (hl: string addr, de: vram addr)

.loop:
    jp .loop

    ret