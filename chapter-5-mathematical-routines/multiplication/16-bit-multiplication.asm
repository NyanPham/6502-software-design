; This subroutine mutliplies the unsigned contents of locations
; $22 (low) and $23 (high) by the unsigned contents of locations
; $20 (low) and $21 (high), producing a 32-bit unsigned product
; in locations $24 (low) through $27 (high).

Mul16:
    lda #00                 ; clear P2 and P3 of product 
    sta $26
    sta $27 
    ldx #16                 ; multiplier bit count = 16 
NextBit:
    lsr $21                 ; shift two-byte multiplier right
    ror $20
    bcc Align               ; multiplier bit = 1?

    lda $26                 ; yes, fetch P2
    clc                     ;   and add M0 to it 
    adc $22                 
    sta $26                 ; store new P2
    lda $27                 ; fetch P3
    adc $23                 ;   and add M1 to it 
Align:
    lsr a
    sta $27                 ; store new P3
    ror $26 
    ror $25
    ror $24 
    
    dex 
    bne NextBit
    rts 