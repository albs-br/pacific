{
 Pacific           
 version (refer to data/strings.s)
 developed jun-jul/2020
 for MSX 1 computers

 File to be assembled by tniasm 0.45

 Tested on WebMSX, Emulicious (C-Bios) and openMSX (Gradiente Expert 1.1 bios) emulators

 Acknowledgements:
 -https://datassette.org/
 -Msx.org and users
 -Web MSX
 -Open MSX
 -Emulicious
 -MSX Pen
}

FNAME "pacific.rom"      ; output file

INCLUDE "include/msxbios.s"
INCLUDE "include/vram.s"


RomSize:	equ 0x4000	; For 16kB Rom size.


DEBUG:      equ 255                ; defines debug mode, value is irrelevant (comment out for production version)

; Compilation address
	org 0x4000	; 0x8000 can be also used here if Rom size is 16kB or less.
 
INCLUDE "include/romheader.s"

; Program code entry point
Execute:


    call InitVram

IFDEF DEBUG
    ;call ShowDebugInfo     ; not working anymore
ENDIF


;NewGame:
    ; ld a, 0                             ; test level
    ld a, 5                             ;
    ld (Level), a                       ;

    ld bc, 0
    ld (Player_Score), bc               ;
    ld a, 3                             ;
    ld (Player_Lives), a                ;


    ; call TitleScreen


NewLevel:
    call InitVram


    call InitVariables
 


    ld a, (Level)
    call LoadLevel



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
INCLUDE "initvram.s"
INCLUDE "include/commonroutines.s"
INCLUDE "specificroutines.s"
INCLUDE "constants.s"
INCLUDE "readinput.s"
INCLUDE "sound.s"
INCLUDE "updatescreen/updatescreen.s"
INCLUDE "gamelogic/gamelogic.s"
INCLUDE "title.s"



 ; Data
INCLUDE "data/tiles.s"
INCLUDE "data/colors.s"
INCLUDE "data/names.s"
INCLUDE "data/sprites.s"
INCLUDE "data/strings.s"
INCLUDE "data/spritebufferinit.s"
INCLUDE "data/leveldata/leveldata.s"

End:
; Padding with 255 to make the file of 16K size (can be 4K, 8K, 16k, etc) but
; some MSX emulators or Rom loaders can not load 4K/8K Roms.
; (Alternatively, include macros.asm and use ALIGN 4000H)
 
	ds 0x4000 + RomSize - End, 255	; 8000h + RomSize - End if org 8000h



; Variables (mapped to RAM memory)
	org 0xc000
INCLUDE "variables.s"
INCLUDE 'vramspriteattrbuffer.s'
