; initvram.s
; depends on:
;   include/msxbios.s
;   include/vram.s



; Set screen 2
	ld	a, 2	               		; Screen Mode (0..3 for MSX 1)
    call BIOS_CHGMOD        		; 

; Initialize VDP registers

; Write to VDP register 5 (define the address of the Sprite Attribute Table)
; Set it to 6912 (128 x 54)
; https://www.msx.org/wiki/VDP_Table_Base_Address_Registers#Control_Registers_5_and_11
	ld	c, 5	               		; VDP Register Number (0..27, 32..46)
	ld	b, 54	               		; Data To Write
    call BIOS_WRTVDP        		; Block transfer to VRAM from memory

; Write to VDP register 6 (defines the address of the Sprite Pattern Table.)
; Set it to 14336 (2048 x 7)
; https://www.msx.org/wiki/VDP_Table_Base_Address_Registers#Control_Registers_5_and_11
	ld	c, 6	               		; VDP Register Number (0..27, 32..46)
	ld	b, 7	               		; Data To Write
    call BIOS_WRTVDP        		; Block transfer to VRAM from memory

; Write to VDP register 1 (Set Screen mode, sprites size, Vblank, Display, VRAM mode setting)
; Set it to 225 (‭1110 0001‬ b)
; bit 7: 4/16K selects VRAM configuration. Write 1 if the VDP is not a V9938 nor V9958.
; bit 6: BL disables the screen display when reseted.VDP's commands work a bit faster as well. Screen display is displayed by default.
; bit 5: IE0 enables (1) or disable (0) the vertical retrace interrupts that occur at just after each display of the screen (foreground).
; bit 4: M2 is one of bits that defines the screen mode. (Write 1 to set the SCREEN 3)
; bit 3: M1 is one of bits that defines the screen mode. (Write 1 to set the SCREEN 0)
; bit 2: not used (always 0)
; bit 1: SI defines the sprite size. Write 1 to use 16x16 sprites, 0 to use 8x8 sprites.
; bit 0: MAG enlarges the sprites when 1 is written. (0 by default)
; https://www.msx.org/wiki/VDP_Mode_Registers#Control_Register_1
	ld	c, 1	               		; VDP Register Number (0..27, 32..46)
	ld	b, 0xe2; ‭% 1110 0010   	 ; Data To Write
    call BIOS_WRTVDP        		; Block transfer to VRAM from memory

; Write to VDP register 2 (determines the base address of the Name Table which constitutes the foreground.)
; Screen 2: set it to 6144 (1024 x 6)
	ld	c, 2	               		; VDP Register Number (0..27, 32..46)
	ld	b, 6	               		; Data To Write
    call BIOS_WRTVDP        		; Block transfer to VRAM from memory





; -----------------------------------------------
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


;-----------------------------------------
; Define sprites

NumberOfSprites:	equ 3			;

	ld	bc, 32 * NumberOfSprites	; Block length
	ld	de, SpritePatternTable		; VRAM address
	ld	hl, Sprite_0        		; RAM address
    call BIOS_LDIRVM        		; Block transfer to VRAM from memory

; Put sprite on screen (test)
{
	ld	bc, 4 * 7               	; Block length
	ld	de, SpriteAttrTable			; VRAM address
	ld	hl, SpriteAttr_0        	; RAM address
    call BIOS_LDIRVM        		; Block transfer to VRAM from memory
}

