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
;   DE: down right corner of box to be checked (D: x2, E: y2)
; Output:
;   A = 0 not collision
;   A = 1 collision
CheckCollision:

;To compare stuff, simply do a CP, and if the zero flag is set,
;A and the argument were equal, else if the carry is set the argument was greater, and finally, if 
;neither is set, then A must be greater (CP does nothing to the registers, only the F (flag) register 
;is changed). 

; if (x >= x1)
    ld a, h
    cp b
    jp c, .false

; if (x <= x2)
    ld a, h
    cp d
    jp nc, .false

; if (y >= y1)
    ld a, l
    cp c
    jp c, .false

; if (y <= y2)
    ld a, l
    cp e
    jp nc, .false


;true:
    ld a, 1
    ret

.false:
    ld a, 0
    ret


{
;if a < d 
    cp d
    call LabelThen
;else
    call LabelElse

}
