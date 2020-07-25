INCLUDE "data/leveldata/testlevel.s"
INCLUDE "data/leveldata/level1.s"
INCLUDE "data/leveldata/level2.s"


LevelDataChunckSize: equ    16       ; size in bytes

; enemies on the same layer (enemy number) should be at least 255 counter ticks apart

; Training Mission
; Coral Sea
; Midway
; Guadalcanal
; Iwo Jima
; Okinawa

; level parameters
;    db 'LEVEL 3', 0        ; 
;    db 'MIDWAY', 0         ; 
;    db 0                   ; 0: daylight / 1: nighttime

