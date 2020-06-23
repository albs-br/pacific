{
 Pacific v.0.1.0
 for MSX 1 computers

 File to be assembled by tniasm 0.45

 Code adapted from sample from:
 https://www.msx.org/wiki/Assembler_for_Dummies_(Z80)#Program_Samples
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

; Define screen colors
    ld a, 15                ; Foregoung color
    ld (BIOS_FORCLR), a    
    ld a, 4                 ; Backgroung color
    ld (BIOS_BAKCLR), a     
    ld a, 14                ; Border color
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

MainLoop:

; Scrolling by rotating the pattern tile downwards
    call RotateTile3Thirds;

    call Delay

    jp MainLoop

    ;jp Finished

; Halt program execution. Change to "ret" to return to MSX-BASIC.
 
Finished:
	jr	Finished	; Jump to itself endlessly.
 

 ; Routines
INCLUDE "routines.s"



 ; Data
INCLUDE "data/tiles.s"
INCLUDE "data/sprites.s"

End:
; Padding with 255 to make the file of 16K size (can be 4K, 8K, 16k, etc) but
; some MSX emulators or Rom loaders can not load 4K/8K Roms.
; (Alternatively, include macros.asm and use ALIGN 4000H)
 
	ds 4000h+RomSize-End,255	; 8000h+RomSize-End if org 8000h
