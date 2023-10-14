; This subroutine subtracts two multiple-byte numbers, one starting
; in location $51 from a multiple-byte number starting in location 
; $21. The result replaces the number that starts in 
; location $21. The byte count is contained in location $20.

MPSub:  
    ldy $20             ; fetch byte count
    ldx #00             ; at start, index = 0
    sec                 ; borrow = 0
NextByte:   
    lda $21,x           ; subtract 8 bits
    sbc $51,x           
    sta $21,x 
    inx                 ; update index and count 
    dey 
    bne NextByte        ; loop until all bytes done
    rts 
