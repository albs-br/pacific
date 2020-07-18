{
 Pacific v.0.22.0           jun-jul/2020
 for MSX 1 computers

 File to be assembled by tniasm 0.45

 Tested on WebMSX, Emulicious and openMSX emulators

 Acknowledgements:
 -https://datassette.org/
 -Msx.org and users
 -Web MSX
 -Open MSX
 -MSX Pen
}

FNAME "pacific.rom"      ; output file

INCLUDE "include/msxbios.s"
INCLUDE "include/vram.s"


RomSize:	equ 0x4000	; For 16kB Rom size.


; DEBUG:      equ 255                ; defines debug mode, value is irrelevant (comment out for production version)

; Compilation address
	org 0x4000	; 0x8000 can be also used here if Rom size is 16kB or less.
 
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

    ld a, 0
    ld (ADDR_CLIKSW), a     ; Key Press Click Switch 0:Off 1:On (1B/RW)

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

IFDEF DEBUG
    call ShowDebugInfo
ENDIF


    call InitVariables
 

; Show initial values of lives and score
    call ShowScore
    call ShowLives



MainLoop:

    call ReadInput

    call UpdateScreen

    call GameLogic

    ; call Delay

    call IncrementCounter

    jp MainLoop

    ;jp Finished

; Halt program execution. Change to "ret" to return to MSX-BASIC.
 
Finished:
	jr	Finished	; Jump to itself endlessly.
 

 ; Routines
INCLUDE "include/commonroutines.s"
INCLUDE "specificroutines.s"
INCLUDE "constants.s"
INCLUDE "readinput.s"
INCLUDE "sound.s"
INCLUDE "updatescreen/updatescreen.s"
INCLUDE "gamelogic/gamelogic.s"



 ; Data
INCLUDE "data/tiles.s"
INCLUDE "data/sprites.s"
INCLUDE "data/data.s"
INCLUDE "data/spritebufferinit.s"

End:
; Padding with 255 to make the file of 16K size (can be 4K, 8K, 16k, etc) but
; some MSX emulators or Rom loaders can not load 4K/8K Roms.
; (Alternatively, include macros.asm and use ALIGN 4000H)
 
	ds 0x4000 + RomSize - End, 255	; 8000h + RomSize - End if org 8000h



; Variables (mapped to RAM memory)
	org 0xc000
INCLUDE "variables.s"
INCLUDE 'vramspriteattrbuffer.s'
