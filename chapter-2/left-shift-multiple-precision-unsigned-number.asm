; this routine left-shifts a multiple-precision unsigned number
; stored in memory starting at location $30. The length of the
; number, in bytes, is contained in location $2f.

    ldy $2f             ; load byte count into y
    asl $30             ; shift low-order byte 
    ldx #1              ; byte index = 1
    dey                 ; decrement byte count 
NxtByt:
    rol #30,x           ; shift next byte 
    inx 
    dey 
    bne NxtByt          ; loop until all bytes shifted 
    