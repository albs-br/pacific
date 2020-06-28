LevelDataChunckSize: equ    6       ; size in bytes

LevelDataStart:
    db  0x00, 0x80          ; counter value (HSB, LSB)
    db  0                   ; action code (0: show enemy)
    db  0                   ; enemy type
    ; db  0                   ; enemy color
    db  180, 0              ; enemy position (x, y)

    db  0x03, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action code (0: show enemy)
    db  0                   ; enemy type
    ; db  0                   ; enemy color
    db  180, 0              ; enemy position (x, y)

    db  0x05, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action code (0: show enemy)
    db  0                   ; enemy type
    ; db  0                   ; enemy color
    db  180, 0              ; enemy position (x, y)



LevelDataEnd:
    db  0