; specificroutines.s (can NOT be used on other programs without changes)

; depends on:
;   include/msxbios.s
;   include/vram.s



; ---------------------------------------------------------
; Incrment counter, do some actions based on its value 
; and show it on screen if debug mode = true
IncrementCounter:

	ld hl, Counter+5            ; LSB (5th byte) + 1
    ld b, 6                     ; number of bytes of counter + 1
.loop:
    dec b
    jp z, .continue

    dec hl    
    ld a, (hl)	    			; get value
    inc a
    ld (hl), a                  ; save value

    jp z, .loop

.continue:
    
    push af
    and 0000 1111 b
    call z, RotateTile3Thirds   ; background scroll at each 16 cycles

	; ld hl, Counter+3            ; test counter
    ; ld a, (hl)                  ; get value
    ; cp 25                      ; arbitrary number
    ; call z, PlanePlayerShot

    pop af

    ; show counter on screen (debug mode)
	ld	hl, PatternsTable + (255 * 8) ; VRAM Address
	call BIOS_WRTVRM		    ; Writes data in VRAM, as VPOKE (HL: address, A: value)

	ld	hl, NamesTable          ; VRAM Address
	ld	a, 255                  ; Value
	call BIOS_WRTVRM		    ; Writes data in VRAM, as VPOKE (HL: address, A: value)

    ret
