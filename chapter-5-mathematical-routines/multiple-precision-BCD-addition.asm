; This subroutine adds two multiple-byte BCD numbers, one starting
; in location $21, the other starting in location $51. The result
; replaces the number that starts in location $21. The byte
; count is contained in location $20.

MPAB:
    sed                 ; set decimal mode
    ldy $20             ; fetch byte count
    ldx #00             ; at start, index = 0
    clc                 ; carry = 0
NextByte:
    lda $21,x           ; add 8 bits
    adc $51,x 
    sta $21,x           ; store 8 bits 
    inx 
    dey
    bne NextByte
    cld                 ; clear decimal mode
    rts 