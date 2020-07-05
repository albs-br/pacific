LevelDataChunckSize: equ    16       ; size in bytes

LevelDataStart:
    ; Enemy plane
    db  0x00, 0xf0          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  0, 0                ; enemy 1st, 2nd color (not used yet)
    db  180, TOP_SCREEN     ; enemy position (x, y)
    db  0                   ; enemy number
    db  0, 0, 0             ; reserved
    db  0, 0, 0, 0          ; reserved

    ; Enemy shoots
    db  0x01, 0x20          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number
    db  0                   ; enemy number who shot this
    db  -1                  ; delta x (-1 to +1)
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy plane
    db  0x03, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy)
    db  0                   ; enemy type
    db  0, 0                ; enemy 1st, 2nd color (not used yet)
    db  40, TOP_SCREEN      ; enemy position (x, y)
    db  0, 0, 0, 0          ; reserved
    db  0, 0, 0, 0          ; reserved

    ; Enemy shoots
    db  0x03, 0x10          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number
    db  0                   ; enemy number who shot this
    db  +1                  ; delta x (-1 to +1)
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy plane
    db  0x04, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy)
    db  0                   ; enemy type
    db  0, 0                ; enemy 1st, 2nd color (not used yet)
    db  240, TOP_SCREEN     ; enemy position (x, y)
    db  0, 0, 0, 0          ; reserved
    db  0, 0, 0, 0          ; reserved

    ; Enemy plane
    db  0x05, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy)
    db  0                   ; enemy type
    db  0, 0                ; enemy 1st, 2nd color (not used yet)
    db  240, TOP_SCREEN     ; enemy position (x, y)
    db  0, 0, 0, 0          ; reserved
    db  0, 0, 0, 0          ; reserved

    ; Enemy plane
    db  0x06, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy)
    db  0                   ; enemy type
    db  0, 0                ; enemy 1st, 2nd color (not used yet)
    db  240, TOP_SCREEN     ; enemy position (x, y)
    db  0, 0, 0, 0          ; reserved
    db  0, 0, 0, 0          ; reserved


LevelDataEnd:
    db  0