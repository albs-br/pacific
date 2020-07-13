WRTVRM:     equ 0x004D
CHGMOD: 	equ	0x005F
INIGRP: 	equ	0x0072

            ; the address of our program
            org 0xD000

start:

			ld a, 2
            call CHGMOD
 
 
    		call INIGRP        ; Screen 2
    
;  10 SCREEN 2
;  20 VPOKE 6144, 0    'names table
;  30 VPOKE 8192, &HF0 'color table
;  40 VPOKE 0, &HFF    'pattern table
;  50 GOTO 50
  

;accessing video memory involved first outputting the low- then the hi-byte of the (14-bit) video memory address to I/O port $99, then one or more bytes of 8-bit data to port $98. After each write, the memory pointer advances to the next address, so consecutive addresses can be written to with repeated OUT instructions to $98



{
Writing port #0	Writing Data into the VRAM	Writing port #98h
Writing port #1	VRAM address and register set-up	Writing port #99h
}
			
			ld hl, 6144
            ld a, 0
			call WRTVRM		        ; Writes data in VRAM (HL: address, A: value)

			ld hl, 8192
            ld a, 0xf0
			call WRTVRM		        ; Writes data in VRAM (HL: address, A: value)

			; ld hl, 0
            ; ld a, 0xff
			; call WRTVRM		        ; Writes data in VRAM (HL: address, A: value)

            ld hl, 0

            di
            out (0x99), l
			nop
			nop
			nop
            set 6, h                    ; Set write flag
            out (0x99), h
            
            ld a, 0xff
            ei
            out (0x98), a



;			ld a,value
;            di
;            out (#99),a
;            ld a,regnr + 128
;            ei
;            out (#99),a
    

endloop:
			jp endloop

			ret

;
; Set VDP address counter to write from address AHL (17-bit)
; Enables the interrupts
;
;SetVdp_Write:
;    rlc h
;    rla
;    rlc h
;    rla
;    srl h
;    srl h
;    di
;    out (#99),a
;    ld a,14 + 128
;    out (#99),a
;    ld a,l			
;    nop
;    out (#99),a			; vram addr lo byte 
;    ld a,h
;    or 64				; set R/W flag to write
;    ei
;    out (#99),a			; vram addr hi byte 
;    ret
    
    

;			ld hl, vram_buffer		; RAM addr (origin)
;			ld c, port				; VDP port number
;			ld b, 4 ;128				; number of bytes
;Loop:
;            outi
;            jr nz,Loop






            
;vram_buffer:
;			db		128, 80