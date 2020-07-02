; commonroutines.s (can be used on other programs)

; depends on:
;   include/msxbios.s
;   include/vram.s



; ---------------------------------------------------------
; Self explanatory
Delay:
    push de
    ld d, 0x00                  ; Two nested loops
    ld e, 0xff              
.loop:                          ; local label
    dec e
    jp nz, .loop                ; inner loop
    ; dec d
    ; jp nz, .loop                ; outer loop
    
    pop de
    ret



; ---------------------------------------------------------
; Scrolling by rotating the tile pattern downwards
; 
; Inputs:
;   none
RotateTile3Thirds:
    ld bc, PatternsTable                            ; first third
    call RotateTile

    ld bc, PatternsTable + (256 * 8)                ; second third
    call RotateTile

    ld bc, PatternsTable + (256 * 8) + (256 * 8)    ; last third
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

.loop:
; VPEEK(C+I-1)
	dec hl                      ; VRAM Address
	call BIOS_RDVRM		        ; Reads data from VRAM, as VPEEK (HL: address, output in A)

;VPOKE C+I, ...
    inc hl
	call BIOS_WRTVRM		; Writes data in VRAM (HL: address, A: value)

    dec hl

    djnz .loop

;VPOKE C, B
    pop bc                      ; Retrieve entry address
	; ld	hl, PatternsTable   ; VRAM Address
	ld	h, b                    ; VRAM Address; ld hl, bc
	ld	l, c
    ld a, e
	call BIOS_WRTVRM		; Writes data in VRAM (HL: address, A: value)

    ret



; ---------------------------------------------------------
; Put sprite 16x16 on screen, similar to BASIC command
; 
; Inputs:
;   d: x coord
;   e: y coord
;   c: color (0-15)
;   a: pattern number (0-63)
;   b: layer (0-31)
; Destroys:
;   hl
PutSprite16x16:
    ld hl, SpriteAttrTable - 4      ; start by - 4 as there will be at least one loop iteration
    inc b
    
.loop:
    inc hl                          ; calc base sprite addr = 6912 + (4 * layer)
    inc hl
    inc hl
    inc hl
    djnz .loop

    sla a                           ; multiply pattern number by 4 (necessary when using 16x16 sprites)
    sla a

    push af

    ; Sprite attributes: y, x, number, color    

    ; y coord    
	ld	a, e        	            ; Value
    dec a                           ; fix bug of -1 on y axis
	call BIOS_WRTVRM		        ; Writes data in VRAM (HL: address, A: value)

    ; x coord    
    inc hl                          ; VRAM address
	ld	a, d        	            ; Value
	call BIOS_WRTVRM		        ; Writes data in VRAM (HL: address, A: value)

    ; pattern number    
    inc hl                          ; VRAM address
	pop af           	            ; Value
	call BIOS_WRTVRM		        ; Writes data in VRAM (HL: address, A: value)

    ; color    
    inc hl                          ; VRAM address
	ld a, c           	            ; Value
	call BIOS_WRTVRM		        ; Writes data in VRAM (HL: address, A: value)

    ret





; ---------------------------------------------------------
; Checks if the point (x, y) is inside the box (x1, y1, x2, y2)
; 
; Destroys:
;   
; Inputs:
;   HL: point to be checked (H: x, L: y)
;   BC: upper left corner of box to be checked (B: x1, C: y1)
;   DE: bottom right corner of box to be checked (D: x2, E: y2)
; Output:
;   Z flag set (Z): not collided
;   Z flag reset (NZ) : collided
CheckCollision:

; TODO (optimization):
; Source: https://www.msx.org/forum/msx-talk/development/collision-detection-in-assembly-not-working-at-all?page=1
; So instead of x>=x1 and x<=x2 (two comparisons) you can check if abs(x-xc)<=w/2 (with xc being the x_center and w being the width; or even better having half the width pre-computed).
; And if there are two overlapping rectangles... well abs(xc - uc)<=(w1+w2)/2 (distance between the centers less than half of the sum of the widths).

;To compare stuff, simply do a CP, and if the zero flag is set,
;A and the argument were equal, else if the carry is set the argument was greater, and finally, if 
;neither is set, then A must be greater (CP does nothing to the registers, only the F (flag) register 
;is changed). 

    ld a, h                 ; get x value

; if (x <= x2)
    cp d
	jp z, .checkY			; if x == x2 there is no need to check against x1
	jp nc, .collisionfalse	; nc: a >= argument

; if (x >= x1)
    cp b
    jp c, .collisionfalse	; c: a < argument

.checkY:
    ld a, l                 ; get y value

; if (y <= y2)
    cp e
    jp z, .collisionTrue			; if y == y2 there is no need to check against y1
    jp nc, .collisionfalse	; nc: a >= argument

; if (y >= y1)
    cp c
    jp c, .collisionfalse	; c: a < argument



.collisionTrue:
    or 1                    ; same as ld a, 1, but faster
    ret

.collisionfalse:
    xor a                   ; same as ld a, 0, but faster
    ret



; ---------------------------------------------------------
; Fills a range of cells in color table with a color pattern in RAM
; 
; Destroys:
;   All registers
;
; Inputs:
;   DE: VRAM color table start address
;   HL: RAM start address of tile patetrn (8 bytes)
;   A: number of cells in color table to be filled by the pattern 
; Output:
;   
FillColorTable:
	; ld	de, ColorsTable+(Tile_Char_0_Number*8)     ; VRAM Address
	; ld	hl, Colors_Char        ; RAM Address
	; ld a, 10				; loop control variable
; .loop:
	ld	bc, 8               ; Block length
	push hl
    push af
	push de
	call BIOS_LDIRVM        ; Block transfer to VRAM from memory
	pop de
	pop af
	
	ld	bc, 8               ; increment register pair de by 8
	ld h, d					; 
	ld l, e					;
	add hl, bc
	ld d, h
	ld e, l
	
	pop hl
	
	dec a
	jr nz, FillColorTable
	
	ret
{
;if a < d 
    cp d
    call LabelThen
;else
    call LabelElse

}

;random number generator:
{
	
;In: nothing
;Out: A with a random number
;Author: Ricardo Bittencourt aka RicBit (BrMSX, Tetrinet and several other projects)
; choose a random number in the set [0,255] with uniform distribution
RAND:
PUSH HL
LD HL,(SEED)
ADD HL,HL
SBC A,A
AND 83h
XOR L
LD L,A
LD (SEED),HL
POP HL
RET

The random number generated will be any number from 0 to FFh.

Despite be a random number generator routine, your results will pass in several statistical tests.

Before the first call, the SEED value must be initiated with a value different of 0.

For a deterministic behavior (the sequence of values will be the same if the program was initiated), use a fixed SEED value.

For a somewhat more random sequence, use:

LD A,(JIFFY);MSX BIOS time variable
OR 80H ;A value different of zero is granted
LD A,(SEED)

The values obtained from this method is much more *random* that what you get from LD A,R.

---------------------

FC9Eh	JIFFY	1	Contains value of the software clock, each interrupt of the VDP it is increased by 1.
The contents can be read or changed by the function 'TIME' or instruction 'TIME'.

}