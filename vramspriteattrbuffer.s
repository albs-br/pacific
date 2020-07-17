; VRAM Sprite attributes table buffer
    VramSpriteAttrBuffer:

    ; Player 2nd color
    SpriteLayer_0_Y:         Player_Y:                   rb 1            ;
    SpriteLayer_0_X:         Player_X:                   rb 1            ;
    SpriteLayer_0_Pattern:                               rb 1            ;
    SpriteLayer_0_Color:                                 rb 1            ;

    ; Player 1st color
    SpriteLayer_1_Y:                                     rb 1            ;
    SpriteLayer_1_X:                                     rb 1            ;
    SpriteLayer_1_Pattern:                               rb 1            ;
    SpriteLayer_1_Color:                                 rb 1            ;

    ; Player shot
    SpriteLayer_2_Y:         Player_Shot_Y:              rb 1            ;
    SpriteLayer_2_X:         Player_Shot_X:              rb 1            ;
    SpriteLayer_2_Pattern:   Player_Shot_Pattern:        rb 1            ;
    SpriteLayer_2_Color:     Player_Shot_Color:          rb 1            ;

                                                         rb (2*4)

    ; Enemy 0 2nd color
    SpriteLayer_5_BaseAddr:
    SpriteLayer_5_Y:                                     rb 1            ;
    SpriteLayer_5_X:                                     rb 1            ;
    SpriteLayer_5_Pattern:                               rb 1            ;
    SpriteLayer_5_Color:                                 rb 1            ;

    ; Enemy 0 1st color
    SpriteLayer_6_Y:                                     rb 1            ;
    SpriteLayer_6_X:                                     rb 1            ;
    SpriteLayer_6_Pattern:                               rb 1            ;
    SpriteLayer_6_Color:                                 rb 1            ;

    ; Enemy 1 2nd color
    SpriteLayer_7_BaseAddr:
    SpriteLayer_7_Y:                                     rb 1            ;
    SpriteLayer_7_X:                                     rb 1            ;
    SpriteLayer_7_Pattern:                               rb 1            ;
    SpriteLayer_7_Color:                                 rb 1            ;

    ; Enemy 1 1st color
    SpriteLayer_8_Y:                                     rb 1            ;
    SpriteLayer_8_X:                                     rb 1            ;
    SpriteLayer_8_Pattern:                               rb 1            ;
    SpriteLayer_8_Color:                                 rb 1            ;

                                                         rb (8*4)


    ; Enemy shot 0
    SpriteLayer_18_Y:                                     rb 1            ;
    SpriteLayer_18_X:                                     rb 1            ;
    SpriteLayer_18_Pattern:                               rb 1            ;
    SpriteLayer_18_Color:                                 rb 1            ;

    ; Enemy shot 1
    SpriteLayer_19_Y:                                     rb 1            ;
    SpriteLayer_19_X:                                     rb 1            ;
    SpriteLayer_19_Pattern:                               rb 1            ;
    SpriteLayer_19_Color:                                 rb 1            ;


                                                         rb (6*4)

    ; Enemy 0 Shadow
    SpriteLayer_26_Y:                                     rb 1            ;
    SpriteLayer_26_X:                                     rb 1            ;
    SpriteLayer_26_Pattern:                               rb 1            ;
    SpriteLayer_26_Color:                                 rb 1            ;

    ; Enemy 1 Shadow
    SpriteLayer_27_Y:                                     rb 1            ;
    SpriteLayer_27_X:                                     rb 1            ;
    SpriteLayer_27_Pattern:                               rb 1            ;
    SpriteLayer_27_Color:                                 rb 1            ;

                                                         rb (4*4)


    ; Player shadow
    SpriteLayer_31_Y:                                    rb 1            ;
    SpriteLayer_31_X:                                    rb 1            ;
    SpriteLayer_31_Pattern:                              rb 1            ;
    SpriteLayer_31_Color:                                rb 1            ;
