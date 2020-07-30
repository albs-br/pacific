


; Initial values for VRAM Sprite attributes table buffer

; Sprite attributes: y, x, pattern number (* 4 if 16x16), color    

VramSpriteAttrBuffer_Init:
    db      160, 120,   1 * 4,  12          ; Player 2nd color
    db      160, 120,   0 * 4,  3           ; Player 1st color

    db      0,     0,   63 * 4,  0          ; Player shot 0
    db      0,     0,   63 * 4,  0          ; Player shot 1
    db      0,     0,   63 * 4,  0          ; Player shot 2
    
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 

    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 

    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 

    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 
    db      0,     0,   0 * 4,  0           ; 

    db      168, 128,   0 * 4,  1           ; Player shadow
