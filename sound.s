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