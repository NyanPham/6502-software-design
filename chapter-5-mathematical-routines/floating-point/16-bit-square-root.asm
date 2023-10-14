; This subroutine takes the square root of a double-precision
; integer in locations $20 (low) and $21 (high). The 8-bit
; square root is returned in location $20. The remainder in
; location $21 

Sqrt16:
    ldy #01                 ; LSBY of first odd number = 1
    sty $22                 
    dey
    sty $23                 ; MSBY of first odd number
Again:
    sec 
    lda $20                 ; save remainder in x register 
    tax 
    sbc $22
    sta $20
    lda $21                 ; subtract odd hi from integer hi
    sbc $23 
    sta $21                 ; is subtract result negative?
    bcc NoMore              ; no, increment square root
    iny 
    lda $22                 ; calculate next odd number 
    adc #01 
    sta $22
    bcc Again 
    inc $23
    jmp Again 
NoMOre:
    sty $20
    stx $21 
    rts 