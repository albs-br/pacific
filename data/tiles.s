Tile_Sea_Number:	equ 0
Tile_Sea:                     ; Sea
	db  10000000 b 		; 
	db  00000000 b 		; 
	db  00000000 b 		; 
	db  00000000 b 		; 
	db  00000000 b 		; 
	db  00000100 b 		; 
	db  00000000 b 		; 
	db  00000000 b 		; 

Tile_Black:                 ; 
	db  00000000 b 		; 
	db  00000000 b 		; 
	db  00000000 b 		; 
	db  00000000 b 		; 
	db  00000000 b 		; 
	db  00000000 b 		; 
	db  00000000 b 		; 
	db  00000000 b 		; 

Tile_Plane_Lives:                 ; 
	db  00001000 b 		; 
	db  00001000 b 		; 
	db  01111111 b 		; 
	db  00111110 b 		; 
	db  00001000 b 		; 
	db  00001000 b 		; 
	db  00011100 b 		; 
	db  00000000 b 		; 

Colors_Sea_Daylight:        ; Sea daylight
    db 0x74                 ;   high nibble: foreground color; low nibble: background color
    db 0x74                 ;
    db 0x74                 ;
    db 0x74                 ;
    db 0x74                 ;
    db 0x74                 ;
    db 0x74                 ;
    db 0x74                 ;

; Colors_Sea_Nighttime:       ; Sea nighttime
;     db 0x41               ;
;     db 0x41               ;
;     db 0x41               ;
;     db 0x41               ;
;     db 0x41               ;
;     db 0x41               ;
;     db 0x41               ;
;     db 0x41               ;

Colors_Black:                   ;
    db 0x11                 ;   high nibble: foreground color; low nibble: background color
    db 0x11                 ;
    db 0x11                 ;
    db 0x11                 ;
    db 0x11                 ;
    db 0x11                 ;
    db 0x11                 ;
    db 0x11                 ;

Colors_Plane_Lives:                   ;
    db 0x31                 ;   high nibble: foreground color; low nibble: background color
    db 0x31                 ;
    db 0x31                 ;
    db 0x21                 ;
    db 0x21                 ;
    db 0xc1                 ;
    db 0xc1                 ;
    db 0xc1                 ;

Tile_Char_0_Number:	equ 48	; same as ascii code for this char
Tile_Char_0:                     ;
	db  00111100 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  00111100 b 		; 
	db  00000000 b 		; 

Tile_Char_1_Number:	equ 49	; same as ascii code for this char
Tile_Char_1:                     ;
	db  00111000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  01111110 b 		; 
	db  00000000 b 		; 

Tile_Char_2_Number:	equ 50	; same as ascii code for this char
Tile_Char_2:                     ;
	db  00111100 b 		; 
	db  01100110 b 		; 
	db  00000110 b 		; 
	db  00111100 b 		; 
	db  01100000 b 		; 
	db  01100000 b 		; 
	db  01111110 b 		; 
	db  00000000 b 		; 

Tile_Char_3_Number:	equ 51	; same as ascii code for this char
Tile_Char_3:                     ;
	db  01111110 b 		; 
	db  00000100 b 		; 
	db  00001000 b 		; 
	db  00011100 b 		; 
	db  00000110 b 		; 
	db  00000110 b 		; 
	db  01111100 b 		; 
	db  00000000 b 		; 

Tile_Char_4_Number:	equ 52	; same as ascii code for this char
Tile_Char_4:                     ;
	db  00001100 b 		; 
	db  00011100 b 		; 
	db  00101100 b 		; 
	db  01001100 b 		; 
	db  01111110 b 		; 
	db  00001100 b 		; 
	db  00011110 b 		; 
	db  00000000 b 		; 

Tile_Char_5_Number:	equ 53	; same as ascii code for this char
Tile_Char_5:                     ;
	db  01111100 b 		; 
	db  01000000 b 		; 
	db  01111100 b 		; 
	db  00000110 b 		; 
	db  00000110 b 		; 
	db  00000110 b 		; 
	db  01111100 b 		; 
	db  00000000 b 		; 

Tile_Char_6_Number:	equ 54	; same as ascii code for this char
Tile_Char_6:                     ;
	db  00111100 b 		; 
	db  01100000 b 		; 
	db  01111100 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  00111100 b 		; 
	db  00000000 b 		; 

Tile_Char_7_Number:	equ 55	; same as ascii code for this char
Tile_Char_7:                     ;
	db  01111110 b 		; 
	db  01000110 b 		; 
	db  00001100 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00000000 b 		; 

Tile_Char_8_Number:	equ 56	; same as ascii code for this char
Tile_Char_8:                     ;
	db  00111100 b 		; 
	db  01100110 b 		; 
	db  00111100 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  00111100 b 		; 
	db  00000000 b 		; 

Tile_Char_9_Number:	equ 57	; same as ascii code for this char
Tile_Char_9:                     ;
	db  00111100 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  00111110 b 		; 
	db  00000110 b 		; 
	db  00000110 b 		; 
	db  00111100 b 		; 
	db  00000000 b 		; 

Tile_Char_A_Number:	equ 58	; NOT same as ascii code for this char
Tile_Char_A:                     ;
	db  00111100 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01111110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  00000000 b 		; 

Tile_Char_B_Number:	equ 59	; NOT same as ascii code for this char
Tile_Char_B:                     ;
	db  01111100 b 		; 
	db  00110110 b 		; 
	db  00110110 b 		; 
	db  00111100 b 		; 
	db  00110110 b 		; 
	db  00110110 b 		; 
	db  01111100 b 		; 
	db  00000000 b 		; 

Tile_Char_C_Number:	equ 60	; NOT same as ascii code for this char
Tile_Char_C:                     ;
	db  00111100 b 		; 
	db  01100110 b 		; 
	db  01100000 b 		; 
	db  01100000 b 		; 
	db  01100000 b 		; 
	db  01100110 b 		; 
	db  00111100 b 		; 
	db  00000000 b 		; 

Tile_Char_D_Number:	equ 61	; NOT same as ascii code for this char
Tile_Char_D:                     ;
	db  01111100 b 		; 
	db  00110110 b 		; 
	db  00110110 b 		; 
	db  00110110 b 		; 
	db  00110110 b 		; 
	db  00110110 b 		; 
	db  01111100 b 		; 
	db  00000000 b 		; 

Tile_Char_E_Number:	equ 62	; NOT same as ascii code for this char
Tile_Char_E:                     ;
	db  01111110 b 		; 
	db  00110010 b 		; 
	db  00110000 b 		; 
	db  00111100 b 		; 
	db  00110000 b 		; 
	db  00110010 b 		; 
	db  01111110 b 		; 
	db  00000000 b 		; 

Tile_Char_F_Number:	equ 63	; NOT same as ascii code for this char
Tile_Char_F:                     ;
	db  01111110 b 		; 
	db  00110010 b 		; 
	db  00110000 b 		; 
	db  00111100 b 		; 
	db  00110000 b 		; 
	db  00110000 b 		; 
	db  01111000 b 		; 
	db  00000000 b 		; 

Tile_Char_G_Number:	equ 64	; NOT same as ascii code for this char
Tile_Char_G:                     ;
	db  00111100 b 		; 
	db  01100110 b 		; 
	db  01100000 b 		; 
	db  01101110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  00111100 b 		; 
	db  00000000 b 		; 

Tile_Char_H_Number:	equ 65	; NOT same as ascii code for this char
Tile_Char_H:                     ;
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01111110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  00000000 b 		; 

Tile_Char_I_Number:	equ 66	; NOT same as ascii code for this char
Tile_Char_I:                     ;
	db  01111110 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  01111110 b 		; 
	db  00000000 b 		; 

Tile_Char_J_Number:	equ 67	; NOT same as ascii code for this char
Tile_Char_J:                     ;
	db  00011110 b 		; 
	db  00001100 b 		; 
	db  00001100 b 		; 
	db  00001100 b 		; 
	db  01101100 b 		; 
	db  01101100 b 		; 
	db  00111000 b 		; 
	db  00000000 b 		; 

Tile_Char_K_Number:	equ 68	; NOT same as ascii code for this char
Tile_Char_K:                     ;
	db  01100010 b 		; 
	db  01100100 b 		; 
	db  01101000 b 		; 
	db  01110000 b 		; 
	db  01101000 b 		; 
	db  01100100 b 		; 
	db  01100010 b 		; 
	db  00000000 b 		; 

Tile_Char_L_Number:	equ 69	; NOT same as ascii code for this char
Tile_Char_L:                     ;
	db  01111000 b 		; 
	db  00110000 b 		; 
	db  00110000 b 		; 
	db  00110000 b 		; 
	db  00110000 b 		; 
	db  00110010 b 		; 
	db  01111110 b 		; 
	db  00000000 b 		; 

Tile_Char_M_Number:	equ 70	; NOT same as ascii code for this char
Tile_Char_M:                     ;
	db  01100010 b 		; 
	db  01110110 b 		; 
	db  01101010 b 		; 
	db  01100010 b 		; 
	db  01100010 b 		; 
	db  01100010 b 		; 
	db  01100010 b 		; 
	db  00000000 b 		; 

Tile_Char_N_Number:	equ 71	; NOT same as ascii code for this char
Tile_Char_N:                     ;
	db  01100010 b 		; 
	db  01100010 b 		; 
	db  01110010 b 		; 
	db  01101010 b 		; 
	db  01100110 b 		; 
	db  01100010 b 		; 
	db  01100010 b 		; 
	db  00000000 b 		; 

Tile_Char_O_Number:	equ 72	; NOT same as ascii code for this char
Tile_Char_O:                     ;
	db  00111100 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  00111100 b 		; 
	db  00000000 b 		; 

Tile_Char_P_Number:	equ 73	; NOT same as ascii code for this char
Tile_Char_P:                     ;
	db  01111100 b 		; 
	db  00110010 b 		; 
	db  00110010 b 		; 
	db  00111100 b 		; 
	db  00110000 b 		; 
	db  00110000 b 		; 
	db  01111000 b 		; 
	db  00000000 b 		; 

Tile_Char_Q_Number:	equ 74	; NOT same as ascii code for this char
Tile_Char_Q:                     ;
	db  00111100 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01101110 b 		; 
	db  00111100 b 		; 
	db  00000110 b 		; 

Tile_Char_R_Number:	equ 75	; NOT same as ascii code for this char
Tile_Char_R:                     ;
	db  01111100 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01111100 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  00000000 b 		; 

Tile_Char_S_Number:	equ 76	; NOT same as ascii code for this char
Tile_Char_S:                     ;
	db  00111110 b 		; 
	db  01100000 b 		; 
	db  01100000 b 		; 
	db  00111100 b 		; 
	db  00000110 b 		; 
	db  00000110 b 		; 
	db  01111100 b 		; 
	db  00000000 b 		; 

Tile_Char_T_Number:	equ 77	; NOT same as ascii code for this char
Tile_Char_T:                     ;
	db  01111110 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00000000 b 		; 

Tile_Char_U_Number:	equ 78	; NOT same as ascii code for this char
Tile_Char_U:                     ;
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  01100110 b 		; 
	db  00111100 b 		; 
	db  00000000 b 		; 

Tile_Char_V_Number:	equ 79	; NOT same as ascii code for this char
Tile_Char_V:                     ;
	db  01100010 b 		; 
	db  01100010 b 		; 
	db  01100010 b 		; 
	db  00110100 b 		; 
	db  00110100 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00000000 b 		; 

Tile_Char_W_Number:	equ 80	; NOT same as ascii code for this char
Tile_Char_W:                     ;
	db  01100010 b 		; 
	db  01100010 b 		; 
	db  01100010 b 		; 
	db  01100010 b 		; 
	db  01101010 b 		; 
	db  01110110 b 		; 
	db  01100010 b 		; 
	db  00000000 b 		; 

Tile_Char_X_Number:	equ 81	; NOT same as ascii code for this char
Tile_Char_X:                     ;
	db  01100010 b 		; 
	db  01100010 b 		; 
	db  00110100 b 		; 
	db  00011000 b 		; 
	db  00110100 b 		; 
	db  01100010 b 		; 
	db  01100010 b 		; 
	db  00000000 b 		; 

Tile_Char_Y_Number:	equ 82	; NOT same as ascii code for this char
Tile_Char_Y:                     ;
	db  01100010 b 		; 
	db  01100010 b 		; 
	db  00110100 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 
	db  00000000 b 		; 

Tile_Char_Z_Number:	equ 83	; NOT same as ascii code for this char
Tile_Char_Z:                     ;
	db  01111110 b 		; 
	db  00001100 b 		; 
	db  00011000 b 		; 
	db  00110000 b 		; 
	db  01100000 b 		; 
	db  01100000 b 		; 
	db  01111110 b 		; 
	db  00000000 b 		; 

Tile_Char_Dot_Number:	equ 84	; NOT same as ascii code for this char
Tile_Char_Dot:                     ;
	db  00000000 b 		; 
	db  00000000 b 		; 
	db  00000000 b 		; 
	db  00000000 b 		; 
	db  00000000 b 		; 
	db  00000000 b 		; 
	db  00011000 b 		; 
	db  00011000 b 		; 

Colors_Char:                   ;
    db 0xf1                 ;   high nibble: foreground color; low nibble: background color
    db 0xf1                 ;
    db 0xf1                 ;
    db 0xe1                 ;
    db 0xe1                 ;
    db 0x71                 ;
    db 0x71                 ;
    db 0x71                 ;

Colors_Char_1:                   ;
    db 0x31                 ;   high nibble: foreground color; low nibble: background color
    db 0x31                 ;
    db 0x31                 ;
    db 0x21                 ;
    db 0x21                 ;
    db 0xc1                 ;
    db 0xc1                 ;
    db 0xc1                 ;

{
Tile_1:
	db  01111110 b 		; 
	db  10000001 b 		; 
	db  10011001 b 		; 
	db  10011001 b 		; 
	db  10011001 b 		; 
	db  10011001 b 		; 
	db  10000001 b 		; 
	db  01111110 b 		; 

Colors_1:
    db 0x14                 ;   high nibble: foreground color; low nibble: background color
    db 0x1f                 ;
    db 0x1f                 ;
    db 0x1f                 ;
    db 0x1f                 ;
    db 0x1f                 ;
    db 0x1f                 ;
    db 0x14                 ;
}

