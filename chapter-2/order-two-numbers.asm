; This routine arranges two numbers in locations $20 and $21 in
; order of value, with the lower-valued number in location $20.

    lda $21             ; load second number into accumulator
    cmp $20             ; compare the numbers
    bcs Done            ; Done if first is less than or equal to second 
    
    ldx $20
    sta $20 
    stx $21 
Done 