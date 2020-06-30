
Tile_0:                     ; Sea
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

Colors_0:                   ; Sea
    db 0x74                 ;   high nibble: foreground color; low nibble: background color
    db 0x74                 ;
    db 0x74                 ;
    db 0x74                 ;
    db 0x74                 ;
    db 0x74                 ;
    db 0x74                 ;
    db 0x74                 ;

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

Colors_Char:                   ;
    db 0xf1                 ;   high nibble: foreground color; low nibble: background color
    db 0xf1                 ;
    db 0xf1                 ;
    db 0xe1                 ;
    db 0xe1                 ;
    db 0x71                 ;
    db 0x71                 ;
    db 0xf1                 ;

Colors_Char_1:                   ;
    db 0x31                 ;   high nibble: foreground color; low nibble: background color
    db 0x31                 ;
    db 0x31                 ;
    db 0x21                 ;
    db 0x21                 ;
    db 0xc1                 ;
    db 0xc1                 ;
    db 0xf1                 ;

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

TestChars:
	db      48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63 		; 

TopStripTiles:                   ; screen top strip with lives, score, etc
    db      2, 48, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    db      1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1