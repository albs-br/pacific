; commonroutines.s (can be used on other programs)

; depends on:
;   include/msxbios.s
;   include/vram.s



; ---------------------------------------------------------
; Self explanatory
Delay:
    ld c, 0x04                  ; 3 nested loops
    ld d, 0xff                  
    ld e, 0x80              
.loop:                          ; 
    dec e
    jp nz, .loop                ; inner loop
    ; dec d
    ; jp nz, .loop                ; 
    ; dec c
    ; jp nz, .loop                ; outer loop
    
    ret



; ---------------------------------------------------------
; Scrolling by rotating the tile pattern downwards
; 
; Inputs:
;   none
; Destroys:
;   hl, a, b, c, e
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
;   bc: Patterns table address
; Destroys:
;   hl, a, b, e
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
    ld e, a                     ; save pattern of the 8th (last) line

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
    pop hl                      ; Retrieve entry address directly to hl
	; ld	h, b                    ; VRAM Address; ld hl, bc
	; ld	l, c
    ld a, e                     ; pattern of the last line will go to the first
	call BIOS_WRTVRM		; Writes data in VRAM (HL: address, A: value)

    ret



; HL: address (should have the bit 6 set), A: value
Vpoke:
    push af

    ld a, l
    out (0x99), a
    ; set 6, h                    ; Set write flag
    ld a, h
    out (0x99), a
    
    pop af
    out (0x98), a

    ; res 6, h                    ; Reset write flag

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
;   a, hl
PutSprite16x16:
    ; TODO: optimization oportunity here (use constants and pass the VRAM sprite address)
    ld hl, SpriteAttrTable
    ; ld hl, 0x4000 OR SpriteAttrTable; Set write flag (bit 6 of high byte)
    ; set 6, h                        ; Set write flag

    sla b                           ; layer * 4
    sla b                           ; 
    ld l, b                         ; since the sprite attr table goes from 0x1b00 to 0x1b80, there is no need to worry with the hi byte, saving cpu clocks

    ; TODO: optimization oportunity here (use constants for sprite number and pass already multiplied by 4)
    sla a                           ; shift left accumulator; multiply pattern number by 4 (necessary when using 16x16 sprites)
    sla a

    ld b, a                         ; saves a (pattern number)

    ; Sprite attributes: y, x, pattern number, color    

    ; y coord    
	ld	a, e        	            ; Value
    dec a                           ; fix bug of -1 on y axis
	call BIOS_WRTVRM		        ; Writes data in VRAM (HL: address, A: value)
    ; call Vpoke

    ; x coord    
    inc l                           ; VRAM address
	ld	a, d        	            ; Value
	call BIOS_WRTVRM		        ; Writes data in VRAM (HL: address, A: value)
    ; call Vpoke

    ; pattern number    
    inc l                           ; VRAM address
    ld a, b                         ; retrieves a (pattern number)
	call BIOS_WRTVRM		        ; Writes data in VRAM (HL: address, A: value)
    ; call Vpoke

    ; color    
    inc l                           ; VRAM address
	ld a, c           	            ; Value
	call BIOS_WRTVRM		        ; Writes data in VRAM (HL: address, A: value)
    ; call Vpoke

    ret





; ---------------------------------------------------------
; xxxxxxxxxx
; 
; Inputs:
;   hl: base sprite addr
;   c: color (0-15)
;   a: pattern number = ((0-63) * 4) + base addd
; Destroys:
;   a, hl
SetSpritePatternAndColor:
    ; Sprite attributes: y, x, pattern number, color    

    inc hl
    inc hl
    
    ; pattern number    
	call BIOS_WRTVRM		        ; Writes data in VRAM (HL: address, A: value)
    ; call Vpoke

    ; color    
    inc hl                          ; VRAM address
	ld a, c           	            ; Value
	call BIOS_WRTVRM		        ; Writes data in VRAM (HL: address, A: value)
    ; call Vpoke

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



; Struct object:
Struct_CollisionBox:
.X:         equ     0
.Y:         equ     1
.width:     equ     2
.height:    equ     3



; Inputs (both using Struct_CollisionBox):
;   IX: obj 1
;   IY: obj 2
; Out: Carry set if collision
CollisionCheck_Boxes:
    ; check collision on x axis
    ld b, (ix + Struct_CollisionBox.X)
    ld c, (ix + Struct_CollisionBox.width)
    ld d, (iy + Struct_CollisionBox.X)
    ld e, (iy + Struct_CollisionBox.width)
    call CollisionCheck_1d
    ret nc

    ; check collision on y axis
    ld b, (ix + Struct_CollisionBox.Y)
    ld c, (ix + Struct_CollisionBox.height)
    ld d, (iy + Struct_CollisionBox.Y)
    ld e, (iy + Struct_CollisionBox.height)
    call CollisionCheck_1d
    ret


;
; CollisionCheck 1d
;
;   Calculates whether a collision occurs between two objects
;   of a certain size
;
; IN: b = coordinate of object 1
;     c = size of object 1
;     d = coordinate of object 2
;     e = size of object 2
; OUT: Carry set if collision
; CHANGES: AF
;
CollisionCheck_1d:
        ld      a,d             ; get x2                       [5]
        sub     b               ; calculate x2-x1              [5]
        jr      c,.other        ; jump if x2<x1                [13/8]
        sub     c               ; compare with size 1          [5]
        ret                     ; return result                [11]
.other:
        neg                     ; use negative value           [10]
        sub     e               ; compare with size 2          [5]
        ret                     ; return result                [11]



; ---------------------------------------------------------
; Fills a range of cells in color table with a color pattern in RAM
; 
; Destroys:
;   All registers
;
; Inputs:
;   DE: VRAM color table start address
;   HL: RAM start address of tile pattern (8 bytes)
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


; ---------------------------------------------------------
; Write string on screen 2
; 
; Destroys:
;   a
;
; Inputs:
;   DE: VRAM names table start address
;   HL: RAM start address of string (string should end with a zero)
; Output:
;   none
PrintString:
    ld a, (hl)
    cp 0
    ret z                           ; end of string


    push hl
    push de

    cp 65
    jp nc, .alpha                   ; if(a >= 65)

    cp 48
    jp nc, .print                   ; if(a >= 48) code is the same as ASCII

    cp 46
    jp z, .dot

    cp 32
    jp z, .space

    jp .alpha

.dot:
    ld a, 84
    jp .print

.space:
    ld a, 1
    jp .print

.alpha:
    sub 7                           ; convert ASCII code to game's pattern table. eg. A = 65 to 58

.print:
    ld h, d
    ld l, e
	call BIOS_WRTVRM		        ; Writes data in VRAM (HL: address, A: value)
    
    pop de
    pop hl


    inc hl
    inc de
    
    jp PrintString



WaitSomeSeconds:
    ; Wait some seconds
    ld hl, 3000
    ld b, 255
.wait:
    djnz .wait

    dec hl
    ld a, h
    or l                                                ; h OR l, to check zero

    ld b, 255
    jp nz, .wait

    ret


; Fill all VRAM with 0x00
CleanVram:
	ld	hl, 0x0000 			; VRAM start address
    ld  bc, 16768           ; number of bytes
    ld  a, 0x00             ; value
    call BIOS_FILVRM        ; Fill VRAM
    
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

-----------------------

How to know if is 50 or 60 Hz

https://www.msx.org/pt-br/node/50159?page=2

So the best way to know the current refresh frequency is:

1. Check the MSX version number at 002DH of the BIOS
2. If it’s 0, read the frequency from bit 7 of 002BH of the BIOS (0 = 60 Hz)
3. Otherwise, read the frequency from bit 1 of 0FFE8H of the system area (0 = 60 Hz)


}


