; This subroutine multiplies an 8-bit unsigned multiplicand 
; in location $21 by an 8-bit unsigned multiplier in location
; $20, and returns the 16-bit unsigned product in
; locations $22 (low byte) and $23 (high byte).

Mlt8:
    lda #00                 ; clear MSBY of product 
    ldx #08                 ; multiplier bit count = 8
NextBit:
    lsr $20                 ; get next multiplier bit 
    bcc Align               ; multiplier = 1?
    clc                     ; yes, add multiplicand 
    adc $21                 
Align:
    lsr a                   ; shift product right
    ror $22             
    dex                     ; decrement bit count 
    bne NextBit             ; loop until 8 bits are done

    sta $23                 ; store product MSBY  
    rts     