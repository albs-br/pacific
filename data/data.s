LevelDataChunckSize: equ    16       ; size in bytes

; enemies on the same layer (enemy number) should be at least 255 counter ticks apart

LevelDataStart:
    ; Enemy plane (type 0)
    ; dw  0xf000              ; counter value as word (little endian, LSB first)
    db  0x00, 0xf0          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  15, 14              ; enemy 1st, 2nd color
    db  180, TOP_SCREEN     ; enemy position (x, y)
    db  0                   ; enemy number
    db  0, 0, 0             ; reserved
    db  0, 0, 0, 0          ; reserved

    ; ; Enemy plane (type 0)
    ; db  0x00, 0xff          ; counter value as bytes (HSB, LSB)
    ; db  0                   ; action type (0: show enemy, 1: enemy shoots)
    ; db  0                   ; enemy type
    ; db  15, 14              ; enemy 1st, 2nd color
    ; db  128, TOP_SCREEN     ; enemy position (x, y)
    ; db  1                   ; enemy number
    ; db  0, 0, 0             ; reserved
    ; db  0, 0, 0, 0          ; reserved

    ; Enemy shoots
    db  0x01, 0x40          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number
    db  0                   ; enemy number who shot this
    db  -1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy plane (type 1)
    db  0x01, 0xe0          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  1                   ; enemy type
    db  15, 14              ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+16  ; enemy position (x, y)
    db  0                   ; enemy number
    db  0, 0, 0             ; reserved
    db  0, 0, 0, 0          ; reserved

    ; Enemy shoots
    db  0x02, 0x80          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number
    db  0                   ; enemy number who shot this
    db  0                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy plane (type 0)
    db  0x03, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy)
    db  0                   ; enemy type
    db  9, 6                ; enemy 1st, 2nd color
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
    db  +1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy plane (type 0)
    db  0x04, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy)
    db  0                   ; enemy type
    db  7, 5                ; enemy 1st, 2nd color
    db  240, TOP_SCREEN     ; enemy position (x, y)
    db  0, 0, 0, 0          ; reserved
    db  0, 0, 0, 0          ; reserved

    ; Enemy plane (type 0)
    db  0x05, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy)
    db  0                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  240, TOP_SCREEN     ; enemy position (x, y)
    db  0, 0, 0, 0          ; reserved
    db  0, 0, 0, 0          ; reserved

    ; Enemy shoots
    db  0x05, 0x01          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number
    db  0                   ; enemy number who shot this
    db  -1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy plane (type 0)
    db  0x06, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy)
    db  0                   ; enemy type
    db  11, 10              ; enemy 1st, 2nd color
    db  240, TOP_SCREEN     ; enemy position (x, y)
    db  0, 0, 0, 0          ; reserved
    db  0, 0, 0, 0          ; reserved

    ; Enemy plane (type 2)
    db  0x07, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  2                   ; enemy type
    db  15, 14              ; enemy 1st, 2nd color
    db  0, 128              ; enemy position (x, y)
    db  0                   ; enemy number
    db  0, 0, 0             ; reserved
    db  0, 0, 0, 0          ; reserved

    ; Enemy shoots
    db  0x07, 0x80          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number
    db  0                   ; enemy number who shot this
    db  +1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy plane (type 1)
    db  0x08, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  1                   ; enemy type
    db  9, 6                ; enemy 1st, 2nd color
    db  255, 128            ; enemy position (x, y)
    db  0                   ; enemy number
    db  0, 0, 0             ; reserved
    db  0, 0, 0, 0          ; reserved

    ; Enemy shoots
    db  0x08, 0x80          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number
    db  0                   ; enemy number who shot this
    db  0                   ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy plane (type 2)
    db  0x09, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  2                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  0, TOP_SCREEN+16    ; enemy position (x, y)
    db  0                   ; enemy number
    db  0, 0, 0             ; reserved
    db  0, 0, 0, 0          ; reserved



LevelDataEnd:
    db  0