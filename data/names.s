; data to be copied to names table

TestChars:
	;       0  1  2  3  4  5  6  7  8  9
    db      48,49,50,51,52,53,54,55,56,57
    ;       A  B  C  D  E  F  G  H  I  J  K  L  M
    db      58,59,60,61,62,63,64,65,66,67,68,69,70
    ;       N  O  P  Q  R  S  T  U  V  W  X  Y  Z  .
    db      71,72,73,74,75,76,77,78,79,80,81,82,83,84

TopStripTiles:                   ; screen top strip with lives, score, etc
    db      2, 1, 1, 1, 1, 1, 1, 1,  1, 76, 60, 72, 75, 62, 1, 1
    db      1, 1, 1, 1, 1, 1, 1, 1, 65, 66,  1,  1,  1, 1, 1, 1

Msg_Pause:
	db		73, 58, 78, 76, 62

Msg_GameOver:
    db      "GAME OVER", 0

Msg_Start:
    db      "START", 0

Msg_TitleBottomLine:
    db      "1.0.0       ANDREBAPTISTA.COM.BR", 0