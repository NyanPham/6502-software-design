; this routine stores the contents of the accumulator into location
; $20, $21 or $22, depending upon whether the accumulator holds
; a value less than 3, equal to 3, or greater than 3, respectively.

    cmp #03             ; compare accumulartor to 3
    bcs EquGt3 
    sta $20 
    jmp Done
EquGt3:
    bne Gt3             
    sta $21
    jmp Done 
Gt3:
    sta $22

Done:   