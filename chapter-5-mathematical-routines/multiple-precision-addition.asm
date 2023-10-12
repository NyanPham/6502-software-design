; This subroutine adds two multiple-byte numbers, one starting
; in location $21, the other starting in location $51. The
; result replaces the number that starts in location $21. THe
; byte count is contained in location $20.

MPAdd:  
    ldy $20             ; fetch byte count
    ldx #00             ; at start, index = 0
    clc                 ; clear carry
NextByte:
    lda $21,x         ; add 8 bits 
    adc $51,x 
    sta $21,x         ; store 8 bits
    inx                 ; update index and count
    dey 
    bne NextByte        ; loop until all bytes done 
    rts 