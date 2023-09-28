    lda #04             ; mask off all bits but bit 2 (#%00000100)
Loop:
    bit $2340           ; Bit 2 = 0?
    bne Loop            ; keep checking until it is
Hit:
    