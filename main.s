{
 Pacific v.0.3.0
 for MSX 1 computers

 File to be assembled by tniasm 0.45

 Tested on WebMSX and openMSX emulators
}

FNAME "pacific.rom"      ; output file

INCLUDE "include/msxbios.s"
INCLUDE "include/vram.s"


RomSize:	equ 4000h	; For 16kB Rom size.



; Compilation address
	org 4000h	; 8000h can be also used here if Rom size is 16kB or less.
 
INCLUDE "include/romheader.s"

; Program code entry point
Execute:


; Define screen colors and mode
    ld a, 15                ; Foregoung color
    ld (BIOS_FORCLR), a    
    ld a, 4                 ; Backgroung color
    ld (BIOS_BAKCLR), a     
    ld a, 5                 ; Border color
    ld (BIOS_BDRCLR), a    
    ld a, 2                 ; Screen mode (0 to 3 for MSX1)
    call BIOS_CHGCLR        ; Change Screen Color

    call BIOS_INIGRP        ; Screen 2



INCLUDE "initvram.s"




; Loop 255 to 0
{
    ld b, 255
	ld	hl, NamesTable      ; VRAM Address
 Loop:
    inc hl

; Place pattern on screen
	ld	a, 0                ; Value
	call BIOS_WRTVRM		; Writes data in VRAM (HL: address, A: value)
 
    djnz Loop
}

; call InitVariables
    ld a, 0                 ;
    ld (Counter), a         ; save value

    ld a, 120               ; (256/2) + 8  ; middle of screen minus half of sprite
    ld (Player_X), a        ; save value

    ld a, 160               ;
    ld (Player_Y), a        ; save value

    ld a, 0                 ;
    ld (Player_Shot), a        ; save value



MainLoop:

    call ReadInput

    ; call UpdateVariables

    call UpdateScreen


    call Delay

    ; increment counter
	ld a, (Counter)				;
    inc a
    
    and 0000 1111 b
    call z, RotateTile3Thirds   ; background scroll at each 16 cycles

    ld (Counter), a        ; save value

    jp MainLoop

    ;jp Finished

; Halt program execution. Change to "ret" to return to MSX-BASIC.
 
Finished:
	jr	Finished	; Jump to itself endlessly.
 

 ; Routines
INCLUDE "routines.s"
INCLUDE "readinput.s"
; INCLUDE "updatevariables.s"
INCLUDE "updatescreen.s"



 ; Data
INCLUDE "data/tiles.s"
INCLUDE "data/sprites.s"

End:
; Padding with 255 to make the file of 16K size (can be 4K, 8K, 16k, etc) but
; some MSX emulators or Rom loaders can not load 4K/8K Roms.
; (Alternatively, include macros.asm and use ALIGN 4000H)
 
	ds 4000h+RomSize-End,255	; 8000h+RomSize-End if org 8000h



; Variables mapped to RAM memory
	org 0xc000
INCLUDE "variables.s"
