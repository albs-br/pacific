
; Global counter                                ; big endian, LSB: 5th byte
    Counter:                    rb 5            ; rb n  = reserve n bytes in RAM

; Player plane
    Player_X:                   rb 1            ; rb 1  = reserve one byte in RAM
    Player_Y:                   rb 1            ;
    Player_Shot:                rb 1            ; 0: dont shot, 1: shot (in future may be used to count number of simultaneous shots)
    Player_Shot_X:              rb 1            ;
    Player_Shot_Y:              rb 1            ;
    Player_Lives:               rb 1            ;
    Player_Score:               rb 2            ; 2 bytes using BCD code, so the max score is 9999 (shown on screen as 99990
    Player_Trigger_Pressed:     rb 1            ;


; Enemy temp memory space
    Enemy_Temp_Base_Address:
    Enemy_Temp_Show:               rb 1            ;
    Enemy_Temp_State:              rb 1            ; State, to control the explosion animation
    Enemy_Temp_Type:               rb 1            ;
    Enemy_Temp_1stColor:           rb 1            ;
    Enemy_Temp_2ndColor:           rb 1            ;
    Enemy_Temp_X:                  rb 1            ;
    Enemy_Temp_Y:                  rb 1            ;

    Enemy_Temp_Layer2ndColor:      rb 1            ;
    Enemy_Temp_Layer1stColor:      rb 1            ;
    Enemy_Temp_LayerShadow:        rb 1            ;


; Enemy plane 1
    Enemy_1_Base_Address:
    Enemy_1_Show:               rb 1            ;
    Enemy_1_State:              rb 1            ; State, to control the explosion animation
    Enemy_1_Type:               rb 1            ;
    Enemy_1_1stColor:           rb 1            ;
    Enemy_1_2ndColor:           rb 1            ;
    Enemy_1_X:                  rb 1            ;
    Enemy_1_Y:                  rb 1            ;

; Enemy shot 1
    Enemy_Shot_1_Show:          rb 1            ;
    Enemy_Shot_1_X:             rb 1            ;
    Enemy_Shot_1_Y:             rb 1            ;
    Enemy_Shot_1_DeltaX:        rb 1            ;



; Enemy plane 2
    Enemy_2_Base_Address:
    Enemy_2_Show:               rb 1            ;
    Enemy_2_State:              rb 1            ; State, to control the explosion animation
    Enemy_2_Type:               rb 1            ;
    Enemy_2_1stColor:           rb 1            ;
    Enemy_2_2ndColor:           rb 1            ;
    Enemy_2_X:                  rb 1            ;
    Enemy_2_Y:                  rb 1            ;

; Enemy shot 2
    Enemy_Shot_2_Show:          rb 1            ;
    Enemy_Shot_2_X:             rb 1            ;
    Enemy_Shot_2_Y:             rb 1            ;
    Enemy_Shot_2_DeltaX:        rb 1            ;



