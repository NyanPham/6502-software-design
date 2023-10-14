; This routine divides a 16-bit unsigned dividend in locations
; $22 and $23 by a 16-bit divisor in locations $20 and 
; $21. The 16-bit quotient replaces the dividend. The 16-bit
; remainder is returned in locations $24 and $25. The low-order
; byte occupies the low address in all cases.

Div16:
    lda #00             ; clear partial dividend 
    sta $24
    sta $25 
    ldx #16             ; divident bit count = 16
NextBit:
    asl $22             ; shift dividend/quotient left 
    ror $23
    rol $24             ; shift partial dividend left
    rol $25 
    lda $24             ; subtract low bytes
    sec 
    sbc $20 
    tay 
    lda $25             ; subtract high bytes 
    sbc $21 
    bcc CountDown       ; divisor > dividend ?
    inc $22             ; no, set bit in quotient
    sta $25             ; and enter subtraction result
    sta $24             ; into partial dividend 
CountDown:
    dex
    bne NextBit
    rts 