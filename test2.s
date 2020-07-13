WRTVRM:     equ 0x004D
CHGMOD: 	equ	0x005F
INIGRP: 	equ	0x0072



RomSize:	equ 0x4000	; For 16kB Rom size.


; DEBUG:      equ 255                ; defines debug mode, value is irrelevant (comment out for production version)

; Compilation address
	org 0x4000	; 0x8000 can be also used here if Rom size is 16kB or less.
 
INCLUDE "include/romheader.s"

; Program code entry point
Execute:




			ld a, 2
            call CHGMOD
 
 
    		call INIGRP        ; Screen 2
    
;  10 SCREEN 2
;  20 VPOKE 6144, 0    'names table
;  30 VPOKE 8192, &HF0 'color table
;  40 VPOKE 0, &HFF    'pattern table
;  50 GOTO 50
  

;accessing video memory involved first outputting the low- then the hi-byte of the (14-bit) video memory address to I/O port $99, then one or more bytes of 8-bit data to port $98. After each write, the memory pointer advances to the next address, so consecutive addresses can be written to with repeated OUT instructions to $98

			ld hl, 6144                 ; names table
            ld a, 0
			; call WRTVRM		        ; Writes data in VRAM (HL: address, A: value)
            call vpoke

			ld hl, 8192                 ; color table
            ld a, 0xf0
			; call WRTVRM		        ; Writes data in VRAM (HL: address, A: value)
            call vpoke

			ld hl, 0                    ; pattern table
            ld a, 10101010 b
			; call WRTVRM		        ; Writes data in VRAM (HL: address, A: value)
            call vpoke


            ; ld hl, 0

            ; ld a, l
            ; di
            ; out (0x99), a
			; nop
			; nop
			; nop
            ; set 6, h                    ; Set write flag
            ; ld a, h
            ; out (0x99), a
            
            ; ld a, 0xff
            ; ei
            ; out (0x98), a





Finished:
	jr	Finished	; Jump to itself endlessly.

; HL: address, A: value
Vpoke:
            ld d, a

            ld a, l
            di
            out (0x99), a
			nop
			nop
            set 6, h                    ; Set write flag
            ld a, h
            out (0x99), a
            
            ld a, d
			nop
			nop
			nop
            ei
            out (0x98), a

            ret


End:
; Padding with 255 to make the file of 16K size (can be 4K, 8K, 16k, etc) but
; some MSX emulators or Rom loaders can not load 4K/8K Roms.
; (Alternatively, include macros.asm and use ALIGN 4000H)
 
	ds 4000h+RomSize-End,255	; 8000h+RomSize-End if org 8000h
