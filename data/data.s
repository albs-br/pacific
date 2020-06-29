LevelDataChunckSize: equ    16       ; size in bytes

LevelDataStart:
    db  0x00, 0xf0          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy)
    db  0                   ; enemy type
    db  0, 0                ; enemy 1st, 2nd color (not used yet)
    db  180, 0              ; enemy position (x, y)
    db  0, 0, 0, 0          ; reserved
    db  0, 0, 0, 0          ; reserved

    db  0x03, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy)
    db  0                   ; enemy type
    db  0, 0                ; enemy 1st, 2nd color (not used yet)
    db  40, 0              ; enemy position (x, y)
    db  0, 0, 0, 0          ; reserved
    db  0, 0, 0, 0          ; reserved

    db  0x04, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy)
    db  0                   ; enemy type
    db  0, 0                ; enemy 1st, 2nd color (not used yet)
    db  240, 0              ; enemy position (x, y)
    db  0, 0, 0, 0          ; reserved
    db  0, 0, 0, 0          ; reserved


LevelDataEnd:
    db  0