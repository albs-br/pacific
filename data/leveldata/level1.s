MsgLevel_1_Name:
    db 'TRAINING MISSION', 0    ; 16 chars fixed size

Level_1_DataStart:
    ; Enemy plane (type 0)
    ; dw  0xf000              ; counter value as word (little endian, LSB first)
    db  0x00, 0xd0          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  15, 14              ; enemy 1st, 2nd color
    db  180, TOP_SCREEN     ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved






.lastEnemy:


; Padding with 255 to make the level data 1600 bytes
	ds Level_1_DataStart - Level_1_DataEnd - (Level_1_DataStart - .lastEnemy), 255



Level_1_DataEnd:
    db  0