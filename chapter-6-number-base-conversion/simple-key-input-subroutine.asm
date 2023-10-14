; This subroutine inputs and ASCII code from location $A276 to
; the accumulator. Location $A275 contains a "Key Pressed"
; status flag in bit 7.

KeyIn:
    bit $A275       ; key pressed?
    bpl KeyIn       ; no wait until it is 
    lda $A276       ; yes, fetch ASCII code 
    lsr $A275       ;   and clear status flag
    rts 
