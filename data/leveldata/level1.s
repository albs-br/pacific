Level_1:
.msgLevelName:
    db 'TRAINING MISSION', 0    ; 16 chars fixed size

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

;------ 4 planes from left/right, one/two per turn, no shooting

    ; Enemy plane (type 1)
    db  0x02, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  1                   ; enemy type
    db  15, 14              ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+16  ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 2)
    db  0x04, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  2                   ; enemy type
    db  9, 6                ; enemy 1st, 2nd color
    db  0, TOP_SCREEN + 32  ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 1)
    db  0x06, 0x00          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  1                   ; enemy type
    db  11, 10              ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+16  ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 2)
    db  0x06, 0x01          ; counter value (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  2                   ; enemy type
    db  7, 5                ; enemy 1st, 2nd color
    db  0, TOP_SCREEN + 32  ; enemy position (x, y)
    db  1                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved


;------ 3 planes from top, one per turn, no shooting

    ; Enemy plane (type 0)
    db  0x08, 0x00          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  15, 14              ; enemy 1st, 2nd color
    db  128-8, TOP_SCREEN   ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x0a, 0x00          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  9, 6                ; enemy 1st, 2nd color
    db  16, TOP_SCREEN      ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x0c, 0x00          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  7, 5                ; enemy 1st, 2nd color
    db  256-32, TOP_SCREEN  ; enemy position (x, y)
    db  0                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

;------ 10 planes from left/right, five per turn, no shooting

    ; Enemy plane (type 1)
    db  0x0e, 0x00                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  1                           ; enemy type
    db  9, 6                        ; enemy 1st, 2nd color
    db  255, TOP_SCREEN + 16        ; enemy position (x, y)
    db  0                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy plane (type 1)
    db  0x0e, 0x10                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  1                           ; enemy type
    db  9, 6                        ; enemy 1st, 2nd color
    db  255, TOP_SCREEN + 16 + 24   ; enemy position (x, y)
    db  1                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy plane (type 1)
    db  0x0e, 0x20                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  1                           ; enemy type
    db  9, 6                        ; enemy 1st, 2nd color
    db  255, TOP_SCREEN + 16 + 48   ; enemy position (x, y)
    db  2                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy plane (type 1)
    db  0x0e, 0x30                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  1                           ; enemy type
    db  9, 6                        ; enemy 1st, 2nd color
    db  255, TOP_SCREEN + 16 + 72   ; enemy position (x, y)
    db  3                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy plane (type 1)
    db  0x0e, 0x40                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  1                           ; enemy type
    db  9, 6                        ; enemy 1st, 2nd color
    db  255, TOP_SCREEN + 16 + 96   ; enemy position (x, y)
    db  4                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy plane (type 2)
    db  0x10, 0x00                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  2                           ; enemy type
    db  3, 12                       ; enemy 1st, 2nd color
    db  0, TOP_SCREEN + 16          ; enemy position (x, y)
    db  0                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy plane (type 2)
    db  0x10, 0x10                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  2                           ; enemy type
    db  3, 12                       ; enemy 1st, 2nd color
    db  0, TOP_SCREEN + 16 + 24     ; enemy position (x, y)
    db  1                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy plane (type 2)
    db  0x10, 0x20                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  2                           ; enemy type
    db  3, 12                       ; enemy 1st, 2nd color
    db  0, TOP_SCREEN + 16 + 48     ; enemy position (x, y)
    db  2                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy plane (type 2)
    db  0x10, 0x30                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  2                           ; enemy type
    db  3, 12                       ; enemy 1st, 2nd color
    db  0, TOP_SCREEN + 16 + 72     ; enemy position (x, y)
    db  3                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy plane (type 2)
    db  0x10, 0x40                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  2                           ; enemy type
    db  3, 12                       ; enemy 1st, 2nd color
    db  0, TOP_SCREEN + 16 + 96     ; enemy position (x, y)
    db  4                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

;------ planes from left/right, one/many per turn, shooting

    ; Enemy plane (type 1)
    db  0x12, 0x00                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  1                           ; enemy type
    db  3, 12                       ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+16          ; enemy position (x, y)
    db  0                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy shoots      
    db  0x12, 0x80                  ; counter value (HSB, LSB)
    db  1                           ; action type (0: show enemy, 1: enemy shoots)
    db  0                           ; shot type
    db  0, 0                        ; shot 1st, 2nd color (not used yet)
    db  0, 0                        ; shot position (x, y) - not used
    db  0                           ; shot number
    db  0                           ; enemy number who shot this
    db  0                           ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0               ; reserved

    ; Enemy plane (type 1)      
    db  0x14, 0x00                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  1                           ; enemy type
    db  3, 12                       ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+16          ; enemy position (x, y)
    db  0                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy shoots      
    db  0x14, 0x10                  ; counter value (HSB, LSB)
    db  1                           ; action type (0: show enemy, 1: enemy shoots)
    db  0                           ; shot type
    db  0, 0                        ; shot 1st, 2nd color (not used yet)
    db  0, 0                        ; shot position (x, y) - not used
    db  0                           ; shot number
    db  0                           ; enemy number who shot this
    db  -1                          ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0               ; reserved

    ; Enemy plane (type 1)      
    db  0x16, 0x00                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  1                           ; enemy type
    db  3, 12                       ; enemy 1st, 2nd color
    db  255, TOP_SCREEN+16          ; enemy position (x, y)
    db  0                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy shoots      
    db  0x16, 0xe0                  ; counter value (HSB, LSB)
    db  1                           ; action type (0: show enemy, 1: enemy shoots)
    db  0                           ; shot type
    db  0, 0                        ; shot 1st, 2nd color (not used yet)
    db  0, 0                        ; shot position (x, y) - not used
    db  0                           ; shot number
    db  0                           ; enemy number who shot this
    db  +1                          ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0               ; reserved

    ; Enemy plane (type 2)
    db  0x18, 0x00                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  2                           ; enemy type
    db  15, 14                      ; enemy 1st, 2nd color
    db  0, TOP_SCREEN + 32          ; enemy position (x, y)
    db  0                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy shoots      
    db  0x18, 0x10                  ; counter value (HSB, LSB)
    db  1                           ; action type (0: show enemy, 1: enemy shoots)
    db  0                           ; shot type
    db  0, 0                        ; shot 1st, 2nd color (not used yet)
    db  0, 0                        ; shot position (x, y) - not used
    db  0                           ; shot number
    db  0                           ; enemy number who shot this
    db  0                           ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0               ; reserved

    ; Enemy shoots      
    db  0x18, 0xe0                  ; counter value (HSB, LSB)
    db  1                           ; action type (0: show enemy, 1: enemy shoots)
    db  0                           ; shot type
    db  0, 0                        ; shot 1st, 2nd color (not used yet)
    db  0, 0                        ; shot position (x, y) - not used
    db  0                           ; shot number
    db  0                           ; enemy number who shot this
    db  0                           ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0               ; reserved

    ; Enemy plane (type 2)
    db  0x1a, 0x00                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  2                           ; enemy type
    db  7, 5                        ; enemy 1st, 2nd color
    db  0, TOP_SCREEN + 32          ; enemy position (x, y)
    db  0                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy plane (type 2)
    db  0x1a, 0x10                  ; counter value (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  2                           ; enemy type
    db  7, 5                        ; enemy 1st, 2nd color
    db  0, TOP_SCREEN + 32 + 24     ; enemy position (x, y)
    db  1                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy shoots      
    db  0x1a, 0x60                  ; counter value (HSB, LSB)
    db  1                           ; action type (0: show enemy, 1: enemy shoots)
    db  0                           ; shot type
    db  0, 0                        ; shot 1st, 2nd color (not used yet)
    db  0, 0                        ; shot position (x, y) - not used
    db  0                           ; shot number
    db  0                           ; enemy number who shot this
    db  0                           ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0               ; reserved

    ; Enemy shoots      
    db  0x1a, 0xc0                  ; counter value (HSB, LSB)
    db  1                           ; action type (0: show enemy, 1: enemy shoots)
    db  0                           ; shot type
    db  0, 0                        ; shot 1st, 2nd color (not used yet)
    db  0, 0                        ; shot position (x, y) - not used
    db  0                           ; shot number
    db  1                           ; enemy number who shot this
    db  0                           ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0               ; reserved

;------ planes from top, one per turn, shooting

    ; Enemy plane (type 0)
    db  0x1c, 0x00                  ; counter value as bytes (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  0                           ; enemy type
    db  15, 14                      ; enemy 1st, 2nd color
    db  160, TOP_SCREEN           ; enemy position (x, y)
    db  0                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy shoots      
    db  0x1c, 0x40                  ; counter value (HSB, LSB)
    db  1                           ; action type (0: show enemy, 1: enemy shoots)
    db  0                           ; shot type
    db  0, 0                        ; shot 1st, 2nd color (not used yet)
    db  0, 0                        ; shot position (x, y) - not used
    db  0                           ; shot number
    db  0                           ; enemy number who shot this
    db  -1                          ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0               ; reserved

    ; Enemy plane (type 0)
    db  0x1e, 0x00                  ; counter value as bytes (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  0                           ; enemy type
    db  3, 12                       ; enemy 1st, 2nd color
    db  80, TOP_SCREEN              ; enemy position (x, y)
    db  0                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy shoots      
    db  0x1e, 0x40                  ; counter value (HSB, LSB)
    db  1                           ; action type (0: show enemy, 1: enemy shoots)
    db  0                           ; shot type
    db  0, 0                        ; shot 1st, 2nd color (not used yet)
    db  0, 0                        ; shot position (x, y) - not used
    db  0                           ; shot number
    db  0                           ; enemy number who shot this
    db  +1                          ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0               ; reserved

;------ 5 planes from top, all at once, all shooting

    ; Enemy plane (type 0)
    db  0x20, 0x00                  ; counter value as bytes (HSB, LSB)
    db  0                           ; action type (0: show enemy, 1: enemy shoots)
    db  0                           ; enemy type
    db  15, 14                      ; enemy 1st, 2nd color
    db  180, TOP_SCREEN              ; enemy position (x, y)
    db  0                           ; enemy number
    db  0                           ; reserved
    db  0, 0, 0, 0, 0, 0            ; reserved

    ; Enemy plane (type 0)
    db  0x20, 0x10          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  15, 14              ; enemy 1st, 2nd color
    db  156, TOP_SCREEN     ; enemy position (x, y)
    db  1                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x20, 0x20          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  15, 14              ; enemy 1st, 2nd color
    db  132, TOP_SCREEN     ; enemy position (x, y)
    db  2                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x20, 0x30          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  15, 14              ; enemy 1st, 2nd color
    db  108, TOP_SCREEN     ; enemy position (x, y)
    db  3                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy plane (type 0)
    db  0x20, 0x40          ; counter value as bytes (HSB, LSB)
    db  0                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; enemy type
    db  15, 14              ; enemy 1st, 2nd color
    db  84, TOP_SCREEN      ; enemy position (x, y)
    db  4                   ; enemy number
    db  0                   ; reserved
    db  0, 0, 0, 0, 0, 0    ; reserved

    ; Enemy shoots
    db  0x20, 0x70          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  0                   ; enemy number who shot this
    db  -1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy shoots
    db  0x20, 0x80          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  1                   ; enemy number who shot this
    db  -1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy shoots
    db  0x20, 0x90          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  2                   ; enemy number who shot this
    db  -1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy shoots
    db  0x20, 0xa0          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  3                   ; enemy number who shot this
    db  -1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Enemy shoots
    db  0x20, 0xb0          ; counter value (HSB, LSB)
    db  1                   ; action type (0: show enemy, 1: enemy shoots)
    db  0                   ; shot type
    db  0, 0                ; shot 1st, 2nd color (not used yet)
    db  0, 0                ; shot position (x, y) - not used
    db  0                   ; shot number (unused)
    db  4                   ; enemy number who shot this
    db  -1                  ; delta x (-1 to +1) signed byte
    db  0, 0, 0, 0, 0       ; reserved

    ; Level finished
    db  0x22, 0x00          ; counter value (HSB, LSB)
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