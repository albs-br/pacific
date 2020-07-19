SoundExplosion:

    ld a, 7
    ld e, 254
    call BIOS_WRTPSG        ; call 147

    ld a, 8
    ld e, 15
    call BIOS_WRTPSG

    ld e, 40
.ciclo:
    ld a, 0
    call BIOS_WRTPSG

    ld a, 10
.tempo:
    push af
    ld a, 255
.tem:
    dec a
    jp nz, .tem

    pop af
    dec a
    jp nz, .tempo
    ld a, e
    sub 150
    ; jp z, .seg
    ret z
    add a, 151
    ld e, a
    jp .ciclo


    ret


{
 10 SOUND 8,15:SOUND 0,93:SOUND 1,0:FOR F=0 TO 20:NEXT F
 20 SOUND 0,45:SOUND 1,0:FOR F=0 TO 29:NEXT F: SOUND 8,0

' mude o valor do registro 0 na linha 10 para alterar o timbre
}
SoundGetItem:
    ld a, 8
    ld e, 15
    call BIOS_WRTPSG

    ld a, 0
    ld e, 93
    call BIOS_WRTPSG

    ld a, 1
    ld e, 0
    call BIOS_WRTPSG

    ; for 0 to 20
    ; ld a, 255
    ld b, 255
.loop1:
    djnz .loop1
    ; dec a
    ; jp nz, .loop1

    ld a, 0
    ld e, 45
    call BIOS_WRTPSG

    ld a, 1
    ld e, 0
    call BIOS_WRTPSG

    ; for 0 to 29
    ; ld a, 255
    ld b, 255
.loop2:
    djnz .loop2
    ; dec a
    ; jp nz, .loop2

    ld a, 8
    ld e, 0
    call BIOS_WRTPSG



    ret