
; Global counter                       ; big endian, LSB: 5th byte
    Counter:            rb 5           ; rb n  = reserve n bytes in RAM

; Player plane
    Player_X:           rb 1           ; rb 1  = reserve one byte in RAM
    Player_Y:           rb 1           ;
    Player_Shot:        rb 1           ; 0: dont shot, 1: shot
    Player_Shot_X:      rb 1           ;
    Player_Shot_Y:      rb 1           ;

; Enemy plane 1
    Enemy_1_Show:       rb 1           ;
    Enemy_1_X:          rb 1           ;
    Enemy_1_Y:          rb 1           ;
