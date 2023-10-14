; This subroutine divides an 8-bit signed dividend in location $21
; by an 8-bit signed divisor in location $20. The 8-bit quotient is
; returned in location $21, replacing the dividend, and the 8-bit
; remainder is returned in location $22. Location $23 is used to hold
; a divisor/dividend sign flag.

Div8S:
    ldy #00             ; Sign flags = 0
    bit $20             ; divisor positive?
    bpl CheckDividend   
    tya                 ; no, clear accumulator 
    sec 
    sbc $20 
    sta $20 
    ldy #80             ; %10000000
; If dividend is negative, make it positive 
CheckDividend:
    bit $21             ; dividend positive?
    bpl GoDivide
    lda #00             ; no, negate it 
    sec 
    sbc $21 
    sta $21
    tya 
    ora #40             ; %01000000 || %10000000
    tay 
; The division routine follows 
GoDivide:   
    sty $23             ; store sign flags 
    lda #00
    ldx #08
NextBit:
    asl $21 
    ror a 
    cmp $20 
    bcc CountDown
    sbc $20 
    inc $21 
CountDown:
    dex
    bne NextBit
    sta $22 
; Division complte. Put quotient and remainder in proper form.
    lda #$C0            ; %1100000000
    bit $23             ; quotient and remainder in proper form?
    beq NoMore          ; yes, return
    bvs NegRemainder    ; No, negate remainder 
NegQuotient:            ; No, negate quotient 
    lda #00
    sec 
    sbc $21 
    sta $21 
    rts 
NegRemainder:
    lda #00
    sec 
    sbc $22
    sta $22 
    bit $23             ; does quotient need negating too?
    bpl NegQuotient     ; yes, do that
NoMore:
    rts 