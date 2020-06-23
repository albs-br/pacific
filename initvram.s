; initvram.s
; depends on:
;   include/msxbios.s
;   include/vram.s





; Define pattern
;	ld	hl, PatternsTable   ; VRAM Address
;	ld	a, 1000 0000 b      ; Value
;	call BIOS_WRTVRM		; Writes data in VRAM, as VPOKE (HL: address, A: value)

; Define pattern (copying 8 bytes from memory to VRAM)
; First third
	ld	bc, 8               ; Block length
	ld	de, PatternsTable   ; VRAM Address
	ld	hl, Tile_0          ; RAM Address
    call BIOS_LDIRVM        ; Block transfer to VRAM from memory

; Second third
	ld	bc, 8               ; Block length
	ld	de, PatternsTable + (256 * 8)
	ld	hl, Tile_0          ; RAM Address
    call BIOS_LDIRVM        ; Block transfer to VRAM from memory

; Last third
	ld	bc, 8               ; Block length
	ld	de, PatternsTable + (256 * 8) + (256 * 8)
	ld	hl, Tile_0          ; RAM Address
    call BIOS_LDIRVM        ; Block transfer to VRAM from memory



; Define colors
;	ld	hl, ColorsTable     ; VRAM Address
;	ld	a, 0xf0             ; Value
;	call BIOS_WRTVRM		; Writes data in VRAM (HL: address, A: value)
 
; Define colors (copying 8 bytes from memory to VRAM)
; First third
	ld	bc, 8               ; Block length
	ld	de, ColorsTable     ; VRAM Address
	ld	hl, Colors_0        ; RAM Address
    call BIOS_LDIRVM        ; Block transfer to VRAM from memory
    
; Second third
	ld	bc, 8               ; Block length
	ld	de, ColorsTable + (256 * 8)
	ld	hl, Colors_0        ; RAM Address
    call BIOS_LDIRVM        ; Block transfer to VRAM from memory

; Last third
	ld	bc, 8               ; Block length
	ld	de, ColorsTable + (256 * 8) + (256 * 8)
	ld	hl, Colors_0        ; RAM Address
    call BIOS_LDIRVM        ; Block transfer to VRAM from memory



; Fill names table
; First third
	ld	hl, NamesTable      ; VRAM start address
    ld  bc, 256             ; number of bytes
    ld  a, 0                ; value
    call BIOS_FILVRM        ; Fill VRAM

; Second third
	ld	hl, NamesTable + 256
    ld  bc, 256             ; number of bytes
    ld  a, 0                ; value
    call BIOS_FILVRM        ; Fill VRAM

; Last third
	ld	hl, NamesTable + 256 + 256
    ld  bc, 256             ; number of bytes
    ld  a, 0                ; value
    call BIOS_FILVRM        ; Fill VRAM
