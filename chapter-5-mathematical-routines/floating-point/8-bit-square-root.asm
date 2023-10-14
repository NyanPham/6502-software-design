; This subroutine takes the square root of the unsigned integer
; in location $20. The square root is returned in location $20,
; the remainder in location $21.

Sqrt8:
    ldy #00             ; square root = 0
    lda #01             ; first odd number = 1
    sta $21             
    lda $20             ; fetch integer number
Again:
    cmp $21             ; can a subtraction be made?
    bcc NoMore              
    sbc $21             ; yes, make the subtraction
    iny                 ; increment square root 
    inc $21 
    inc $21 
    jmp Again 
NoMore:
    sty $20
    sta $21 
    rts 