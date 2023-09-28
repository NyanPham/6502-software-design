; This routine copies a six-byte block of memory,
; starting at location $20, into another part of
; memory, starting at location $0320.

    ldx #00             ; index = 0
    ldy #06             ; byte count = 6
NxtByt:
    lda $20,x           ; load next byte
    sta $0320,xor       ; store next byte 
    inx 
    dey 
    bne NxtByt