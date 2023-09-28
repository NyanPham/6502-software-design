; this routine right-shifts a multiple-precision signed number
; stored in memory starting at location $30. The length of the 
; number, in bytes, is contained in location $2f.

    clc                 ; prepare for sign = 0 shift
    ldx $2f             ; load byte count into x 
    dex                 ; set index for MSBY 
    lda $30,x           ; load high-order byte 
    bpl MSB0            ; sign = 1?
    sec                 ; yes, prepare for sign = 1 shift 
MSB0: 
    ror a               ; shift high-order byte
    sta $30,x           ; return it to memory 
    dex                 ; decrement index for next byte 
NxtByt:
    ror #30,x           ; shift next byte 
    dex 
    bpl NxtByt          ; loop until all bytes shifted