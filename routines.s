; routines.s
; depends on:
;   include/msxbios.s
;   include/vram.s



; ---------------------------------------------------------
; Self explanatory
Delay:
    push de
    ld d, 0x30              ; Two nested loops
    ld e, 0xff              
DelayLoop:
    dec e
    jp nz, DelayLoop        ; inner loop
    dec d
    jp nz, DelayLoop        ; outer loop
    
    pop de
    ret



; ---------------------------------------------------------
; Scrolling by rotating the pattern tile downwards
; 
; Inputs:
;   none
RotateTile3Thirds:
    ld bc, PatternsTable
    call RotateTile

    ld bc, PatternsTable + (256 * 8)
    call RotateTile

    ld bc, PatternsTable + (256 * 8) + (256 * 8)
    call RotateTile

    ret



; ---------------------------------------------------------
; Scrolling by rotating the pattern tile downwards
; Rotates only one tile pattern, so affects only one third of screen 2
; 
; Inputs:
;   BC: Patterns table address
RotateTile:
{
170 B = VPEEK(C+7)
180 FOR I=7 TO 1 STEP -1
190   VPOKE C+I, VPEEK(C+I-1)
200 NEXT
203 VPOKE C, B
205 GOTO 170
}
; B = VPEEK(C+7)
    push bc                     ; Saves entry address
    
    ld hl, 7                    ; Add 7 to patterns table address; HL = BC + 7
    add hl, bc
	;ld	hl, PatternsTable + 7   ; VRAM Address
	call BIOS_RDVRM		        ; Reads data from VRAM, as VPEEK (HL: address, output in A)
    ld e, a

; FOR I=7 TO 1 STEP -1
    ld b, 7                     ; repeat 7 times

RotateTileLoop:
; VPEEK(C+I-1)
	dec hl                      ; VRAM Address
	call BIOS_RDVRM		        ; Reads data from VRAM, as VPEEK (HL: address, output in A)

;VPOKE C+I, ...
    inc hl
	call BIOS_WRTVRM		; Writes data in VRAM (HL: address, A: value)

    dec hl

    djnz RotateTileLoop

;VPOKE C, B
    pop bc                      ; Retrieve entry address
	; ld	hl, PatternsTable   ; VRAM Address
	ld	h, b                    ; VRAM Address; ld hl, bc
	ld	l, c
    ld a, e
	call BIOS_WRTVRM		; Writes data in VRAM (HL: address, A: value)

    ret

