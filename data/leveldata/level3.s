Level_3:
.msgLevelName:
    db '     MIDWAY     ', 0    ; 16 chars fixed size

    ; enemy types available:
    ; from top:     db  0                   ; enemy type
    ; from right:   db  1                   ; enemy type
    ; from left:    db  2                   ; enemy type

    ; color schemes available:
    ; white/gray:   db  15, 14              ; enemy 1st, 2nd color
    ; yellow:       db  11, 10              ; enemy 1st, 2nd color
    ; red:          db  9, 6                ; enemy 1st, 2nd color
    ; blue:         db  7, 5                ; enemy 1st, 2nd color
    ; green:        db  3, 12               ; enemy 1st, 2nd color


.levelDataStart:

    ; Enemy plane (type 0)
    db  0x00, 0xd0          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12              ; enemy 1st, 2nd color
    db  232, TOP_SCREEN     ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x00, 0xe0          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12              ; enemy 1st, 2nd color
    db  232, TOP_SCREEN     ; enemy position (x, y)
    db  1                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy shoots
    db  0x01, 0x00          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  0                   ; enemy number who shot this
    db  -1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy shoots
    db  0x01, 0x01          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  1                   ; enemy number who shot this
    db  -1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

;-------------------------

    ; Enemy plane (type 0)
    db  0x02, 0xd0          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12              ; enemy 1st, 2nd color
    db  8, TOP_SCREEN     ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x02, 0xe0          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12              ; enemy 1st, 2nd color
    db  8, TOP_SCREEN     ; enemy position (x, y)
    db  1                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy shoots
    db  0x03, 0x00          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  0                   ; enemy number who shot this
    db  +1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy shoots
    db  0x03, 0x01          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  1                   ; enemy number who shot this
    db  +1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

;-------------------------

    ; Enemy plane (type 2)
    db  0x04, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  2                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  0, TOP_SCREEN+40   ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 2)
    db  0x04, 0x10          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  2                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  0, TOP_SCREEN+64   ; enemy position (x, y)
    db  1                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 2)
    db  0x04, 0x20          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  2                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  0, TOP_SCREEN+88   ; enemy position (x, y)
    db  2                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 2)
    db  0x04, 0x30          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  2                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  0, TOP_SCREEN+112   ; enemy position (x, y)
    db  3                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy shoots
    db  0x04, 0x80          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  2                   ; enemy number who shot this
    db  0                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy shoots
    db  0x04, 0x81          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  3                   ; enemy number who shot this
    db  0                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

;-------------------------

    ; Enemy plane (type 2)
    db  0x05, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  2                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  0, TOP_SCREEN+88   ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 2)
    db  0x05, 0x10          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  2                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  0, TOP_SCREEN+112   ; enemy position (x, y)
    db  1                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 2)
    db  0x05, 0x20          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  2                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  0, TOP_SCREEN+136   ; enemy position (x, y)
    db  2                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 2)
    db  0x05, 0x30          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  2                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  0, TOP_SCREEN+160   ; enemy position (x, y)
    db  3                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy shoots
    db  0x05, 0x80          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  2                   ; enemy number who shot this
    db  0                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy shoots
    db  0x05, 0x81          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  3                   ; enemy number who shot this
    db  0                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

;-------------------------

    ; Enemy plane (type 1)
    db  0x06, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  1                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+16  ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 1)
    db  0x06, 0x10          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  1                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+40  ; enemy position (x, y)
    db  1                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 1)
    db  0x06, 0x20          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  1                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+64  ; enemy position (x, y)
    db  2                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 1)
    db  0x06, 0x30          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  1                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+88  ; enemy position (x, y)
    db  3                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy shoots
    db  0x06, 0x80          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  2                   ; enemy number who shot this
    db  0                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy shoots
    db  0x06, 0x81          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  3                   ; enemy number who shot this
    db  0                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

;-------------------------

    ; Enemy plane (type 1)
    db  0x07, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  1                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+40  ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 1)
    db  0x07, 0x20          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  1                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+64  ; enemy position (x, y)
    db  1                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 1)
    db  0x07, 0x40          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  1                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+88  ; enemy position (x, y)
    db  2                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 1)
    db  0x07, 0x60          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  1                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+112 ; enemy position (x, y)
    db  3                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy shoots
    db  0x07, 0x80          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  2                   ; enemy number who shot this
    db  0                   ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy shoots
    db  0x07, 0x81          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  3                   ; enemy number who shot this
    db  0                   ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

;-------------------------

    ; Enemy plane (type 1)
    db  0x08, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  1                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+16  ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 2)
    db  0x08, 0x01          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  2                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  0, TOP_SCREEN+64   ; enemy position (x, y)
    db  1                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x08, 0x02          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12              ; enemy 1st, 2nd color
    db  85, TOP_SCREEN     ; enemy position (x, y)
    db  2                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x08, 0x12          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12              ; enemy 1st, 2nd color
    db  170, TOP_SCREEN     ; enemy position (x, y)
    db  3                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy shoots
    db  0x08, 0x10          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  0                   ; enemy number who shot this
    db  0                   ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy shoots
    db  0x08, 0xc0          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  1                   ; enemy number who shot this
    db  0                   ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

;-------------------------

    ; Enemy plane (type 1)
    db  0x09, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  1                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+88  ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 2)
    db  0x09, 0x01          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  2                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  0, TOP_SCREEN+128   ; enemy position (x, y)
    db  1                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x09, 0x02          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12              ; enemy 1st, 2nd color
    db  85, TOP_SCREEN     ; enemy position (x, y)
    db  2                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x09, 0x12          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12              ; enemy 1st, 2nd color
    db  170, TOP_SCREEN     ; enemy position (x, y)
    db  3                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy shoots
    db  0x09, 0x10          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  2                   ; enemy number who shot this
    db  +1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy shoots
    db  0x09, 0x20          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  3                   ; enemy number who shot this
    db  -1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

; --------------------------

    ; Enemy plane (type 0)
    db  0x0a, 0x00          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  232, TOP_SCREEN     ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x0a, 0x10          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  208, TOP_SCREEN     ; enemy position (x, y)
    db  1                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x0a, 0x20          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  184, TOP_SCREEN      ; enemy position (x, y)
    db  2                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy shoots
    db  0x0a, 0x30          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  0                   ; enemy number who shot this
    db  -1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy shoots
    db  0x0a, 0x40          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  1                   ; enemy number who shot this
    db  -1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

; --------------------------

    ; Enemy plane (type 0)
    db  0x0b, 0x00          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  0, TOP_SCREEN     ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x0b, 0x10          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  24, TOP_SCREEN     ; enemy position (x, y)
    db  1                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x0b, 0x20          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  48, TOP_SCREEN      ; enemy position (x, y)
    db  2                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy shoots
    db  0x0b, 0x30          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  0                   ; enemy number who shot this
    db  +1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy shoots
    db  0x0b, 0x40          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  1                   ; enemy number who shot this
    db  +1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

; --------------------------

    ; Enemy plane (type 0)
    db  0x0d, 0x00          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  0, TOP_SCREEN       ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x0d, 0x10          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  24, TOP_SCREEN      ; enemy position (x, y)
    db  1                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x0d, 0x20          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  232, TOP_SCREEN     ; enemy position (x, y)
    db  2                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x0d, 0x30          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  3, 12               ; enemy 1st, 2nd color
    db  208, TOP_SCREEN     ; enemy position (x, y)
    db  3                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy shoots
    db  0x0d, 0x40          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  0                   ; enemy number who shot this
    db  +1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy shoots
    db  0x0d, 0x50          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  3                   ; enemy number who shot this
    db  -1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved





    ; Level finished
    db  0x0f, 0x00          ; counter value (HSB, LSB)
    db  200                 ; action type (200: level finished)
    db  0                   ; not used 
    db  0, 0                ; not used 
    db  0, 0                ; not used 
    db  0                   ; not used 
    db  0                   ; not used 
    db  0                   ; not used 
    db  0, 0, 0, 0, 0       ; not used 






.lastEnemy:


; Padding with 255 to make the level data 1600 bytes
	; ds .levelDataStart - .levelDataEnd - (.levelDataStart - .lastEnemy), 255
    ; ds .levelDataEnd - .levelDataStart - (.lastEnemy - .levelDataStart), 255
    ds 1600 - (.lastEnemy - .levelDataStart), 255


.levelDataEnd:
    db  0