; This subroutine multiplies an 8-bit singed multiplicand in
; location $21 by an 8-bit signed multiplier in location $20.
; the 16-bit product is returned in locations $22 (low byte)
; and $23 (high byte). Location $24 is used to hold a multiplicand
; sign bit mask.

Mul8S:
    lda #80
    bit $20             ; multiplier positive?
    bpl MPos 
    bit $21             ; no, so multiplicand positive?
    bpl Swap            ; so swap operands
; Both operands are negative - negate them
    asl a               ; clear a, by left-shifting #80
    sta $24             ; mask sign bit = 0
    sbc $20             ; negate multiplier 
    sta $20 
    lda #00
    sec 
    sbc $21             ; negate multiplicand 
    sta $21
    jmp GoMultiply      

; Multiplicand pos, multiplier neg - swap them 
Swap:
    sta $24             ; mask sign bit = 1
    ldx $20             ; swap operands 
    lda $21         
    stx $21
    sta $20
    jmp GoMultiply
; Multiplier pos, if multiplicand neg, set mask sign bit = 1
MPos:
    bit $21             ; multiplicand positive?
    bmi Mask1           ; if not mask sign bit = 1
    asl a 
Mask1: 
    sta $24 
; The multiplication routine follows
GoMultiply:
    lda #00             ; clear MSBY of product 
    ldx #08             ; multiplier bit count = 8
NextBit:
    lsr $20             ; get next multiplier bit 
    bcc Align           ; multiplier bit = 1?
    clc                 ; Yes, add in multiplicand 
    adc $21 
Align:
    lsr a               ; shift product MSBY right 
    ora $24             ; Apply sign bit mask 
    ror $22             ; shift product LSBY right 
    dex                 ; decrement bit count 
    bne NextBit
    sta $23
    rts 
