; TODO: put the correct header
	; ld b, 5							; sprite layer for 2nd color
	; ld c, 6							; sprite layer for 1st color
	; ld a, 26						    ; sprite layer for shadow
	; ld hl, Enemy_1_Base_Address		; base addr of enemy variables
ShowEnemy:

{
enemy#          layer
------          -----
0               5           2nd color
0               6           1st color
0               26          shadow

1               7           2nd color
1               8           1st color
1               27          shadow

...

5               13           2nd color
5               14           1st color
5               30          shadow
}


    

    push hl

    ; copy all enemy variables to temp enemy memory
    ; ld hl, Enemy_1_Base_Address       ; addr origin
    ld de, Enemy_Temp_Base_Address      ; addr destiny
    ; ld bc, 7                            ; number of bytes
    ; ldir                                ; copy BC bytes from HL to DE
    ldi                                 ; ldi 8 times is faster the ldir
    ldi
    ldi
    ldi
    ldi
    ldi
    ldi
    ldi


	; Enemy plane
	ld a, (Enemy_Temp_Show)			;   get indicator of enemy show/hide
    cp 0
    jp z, .enemyHide                 

	ld a, (Enemy_Temp_Type)			;

    cp 0
    jp z, .enemyType_0                 
    cp 1
    jp z, .enemyType_1
    cp 2
    jp z, .enemyType_2
	jp .next

.enemyType_0:
	ld a, 4	* 4						; pattern number (2nd color)
    ld (Enemy_Temp_2ndColorPattern), a
	jp .enemyTypeCont

.enemyType_1:
	ld a, 7	* 4						; pattern number (2nd color)
    ld (Enemy_Temp_2ndColorPattern), a
	jp .enemyTypeCont

.enemyType_2:
	ld a, 12 * 4					; pattern number (2nd color)
    ld (Enemy_Temp_2ndColorPattern), a
	jp .enemyTypeCont

.enemyTypeCont:

;	push af							; save pattern number

	; Enemy plane 2nd color
	; ld a, (Enemy_Temp_X)			;   d: x coord
	; ld d, a

	; ld a, (Enemy_Temp_Y)			;   e: y coord
	; ld e, a

	; ld a, (Enemy_Temp_2ndColor)		;   c: color (0-15)
	; ld c, a
	
    ; ld c, 6 						;   c: color (0-15)
	; ld a, 4						;   a: pattern number (0-63)
	; ld b, 5							;   b: layer (0-31)
    ; ld a, (Enemy_Temp_Layer2ndColor)
    ; ld b, a                         ;   b: layer (0-31)
	; pop af							; 	retrieve pattern number
	; push af							;   save pattern number
	;call PutSprite16x16				;

    


	; Enemy plane 1st color
	; ld a, (Enemy_1_X)				;   d: x coord
	; ld d, a
	; ld a, (Enemy_1_Y)				;   e: y coord
	; ld e, a

	; ld a, (Enemy_Temp_1stColor)		;   c: color (0-15)
	; ld c, a
	; ld c, 9							;   c: color (0-15)
	; ld a, 3							;   a: pattern number (0-63)
	; ld b, 6							;   b: layer (0-31)
    ; ld a, (Enemy_Temp_Layer1stColor)
    ; ld b, a                         ;   b: layer (0-31)
	; pop af							; 	retrieve pattern number
	; dec a
	; push af							;   save pattern number
	; call PutSprite16x16				;
	

	; Enemy plane shadow
	; ld b, 8
	; ld a, (Enemy_Temp_X)			;   d: x coord
	; add a, b
	; ld d, a

	; ld a, (Enemy_Temp_Y)			;   e: y coord
	; add a, b
	; ld e, a

	; ld c, 1							;   c: color (0-15)
	; ld a, 3							;   a: pattern number (0-63)
	; ld b, 30						;   b: layer (0-31)
    ; ld a, (Enemy_Temp_LayerShadow)
    ; ld b, a                         ;   b: layer (0-31)
	; pop af							; 	retrieve pattern number
	; call PutSprite16x16				;	

	jp .next

.enemyHide:
	;if(enemyState !=0)
	ld a, (Enemy_Temp_State)
	cp 0							; animation runs between 1 and 50
	jp z, .enemyHideCont

	inc a
	cp 50							; counter number of animation end
	ld (Enemy_Temp_State), a
	jp z, .enemyHideCont			; end animation


	;call BIOS_BEEP ; [debug]

	; Show explosion change sprite and color
	; ld hl, SpriteAttrTable + (5 * 4)
	; ld c, 10
	; ld a, 8 * 4
	; call SetSpritePatternAndColor	

	ld a, (Enemy_Temp_X)				;   d: x coord
	ld d, a
	ld a, (Enemy_Temp_Y)				;   e: y coord
	ld e, a
	; ld c, 10 						;   c: color (0-15)
	
	
	ld a, (Enemy_Temp_State)
	cp 40							;if(enemyState >= 40)
	jp nc, .explosion1stFrame
	cp 30							;if(enemyState >= 30)
	jp nc, .explosion2ndFrame
	cp 20							;if(enemyState >= 20)
	jp nc, .explosion3rdFrame
	cp 10							;if(enemyState >= 10)
	jp nc, .explosion2ndFrame
	jp .explosion1stFrame			;else
.explosion3rdFrame:	
	ld a, 10						;   a: pattern number (0-63)
	ld c, 10 						;   c: color (0-15)
	jp .explosionCont
.explosion2ndFrame:	
	ld a, 9							;   a: pattern number (0-63)
	ld c, 8 						;   c: color (0-15)
	jp .explosionCont
.explosion1stFrame:	
	ld a, 8							;   a: pattern number (0-63)
	ld c, 15 						;   c: color (0-15)
.explosionCont:

    call .DoHideEnemy



{
	push af
    ; ld b, 5							;   b: layer (0-31)
    ld a, (Enemy_Temp_Layer2ndColor)
    ld b, a                         ;   b: layer (0-31)
    pop af
	; call PutSprite16x16				;

	; hide other 2 sprites of enemy
	ld d, 0							;   d: x coord
	ld e, 256 - 16					;   e: y coord		; place sprite off screen
	; ld b, 6							;   b: layer (0-31)
    ld a, (Enemy_Temp_Layer1stColor)
    ld b, a                         ;   b: layer (0-31)
	ld a, 63
	; call PutSprite16x16				;   put non existent sprite at layer, to hide the enemy
	; ld b, 30						;   b: layer (0-31)
    ld a, (Enemy_Temp_LayerShadow)
    ld b, a                         ;   b: layer (0-31)
	ld a, 63
	; call PutSprite16x16				;   put non existent sprite at layer, to hide the enemy
}
	jp .next

.enemyHideCont:
	ld a, 0
	ld (Enemy_Temp_State), a		; 	disable explosion animation
	ld (Enemy_Temp_Show), a			; 	hide enemy

    call .DoHideEnemy

{
	ld d, 0							;   d: x coord
	ld e, 256 - 16					;   e: y coord		; place sprite off screen
	; ld b, 5							;   b: layer (0-31)
    ld a, (Enemy_Temp_Layer2ndColor)
    ld b, a                         ;   b: layer (0-31)
	ld a, 63					    ;   a: pattern number (0-63)
	; call PutSprite16x16				;   put non existent sprite at layer, to hide the enemy
	; ld d, 0							;   d: x coord
	; ld e, 256 - 16					;   e: y coord		; place sprite off screen
	; ld a, 63					    ;   a: pattern number (0-63)
	; ld b, 6							;   b: layer (0-31)
    ld a, (Enemy_Temp_Layer1stColor)
    ld b, a                         ;   b: layer (0-31)
	ld a, 63					    ;   a: pattern number (0-63)
	; call PutSprite16x16				;   put non existent sprite at layer, to hide the enemy
	; ld b, 30						;   b: layer (0-31)
    ld a, (Enemy_Temp_LayerShadow)
    ld b, a                         ;   b: layer (0-31)
	ld a, 63					    ;   a: pattern number (0-63)
	; call PutSprite16x16				;   put non existent sprite at layer, to hide the enemy
}


.next:


  

    
    ; copy all enemy variables from temp enemy memory back to the correct enemy
    ld hl, Enemy_Temp_Base_Address      ; addr origin
    pop de                              ; addr destiny
    ;ld bc, 7                            ; number of bytes
    ;ldir                                ; copy BC bytes from HL to DE
    ldi                                 ; ldi x8, faster than ldir
    ldi
    ldi
    ldi
    ldi
    ldi
    ldi
    ldi

                  
    ; set sprite attributes

;TODO: if (enemy number == 0) hl = SpriteLayer_5_BaseAddr
;      elseif (enemy number == 1) hl = SpriteLayer_7_BaseAddr
    ld hl, SpriteLayer_5_BaseAddr

    call .UpdateSpriteAttr

    ret




.DoHideEnemy:
	ld a, 0							;   d: x coord
    ld (Enemy_Temp_X), a
	ld a, 256 - 16					;   e: y coord		; place sprite off screen
    ld (Enemy_Temp_Y), a
    ld a, 63                        ;   put non existent sprite at layer, to hide the enemy
    ld (Enemy_Temp_2ndColorPattern), a

    ret



.UpdateSpriteAttr:

    push hl

; Y coord
    ld a, (Enemy_Temp_Y)
    call .updateAttr3Layers


; X coord
    pop hl
    inc hl
    push hl

    ld a, (Enemy_Temp_X)
    call .updateAttr3Layers


; pattern
    pop hl
    inc hl
    push hl

    ld a, (Enemy_Temp_2ndColorPattern)
    ld (hl), a                          ; Addr 2nd color

    sub 4
    ld bc, 4
    add hl, bc
    ld (hl), a                          ; Addr 1st color

    ld bc, 20 * 4
    add hl, bc
    ld (hl), a                          ; Addr shadow


; color
    pop hl
    inc hl

    ld a, (Enemy_Temp_2ndColor)
    ld (hl), a                          ; Addr 2nd color
    
    ld a, (Enemy_Temp_1stColor)
    ld bc, 4
    add hl, bc
    ld (hl), a                          ; Addr 1st color

    ld a, 1
    ld bc, 20 * 4
    add hl, bc
    ld (hl), a                          ; Addr shadow

    ret

.updateAttr3Layers:
    ld (hl), a                          ; Addr 2nd color

    ld bc, 4
    add hl, bc
    ld (hl), a                          ; Addr 1st color

    add 8                             
    ld bc, 20 * 4
    add hl, bc
    ld (hl), a                          ; Addr shadow

    ret