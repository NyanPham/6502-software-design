; this routine left-shifts a multiple-precision signed number
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

; the code that follows restores the sign to the most significant byte 
    dex                 ; make index point to MSBY 
    lda #30,x           ; load MSBY into a 
    bcc MSB0            ; Sign is 1?
    ora #$80            ; Yes. put one in sign bit
    jmp Sover
MSB0:   
    and #$7f            ; no. put zero to sign bit
Sover: 
    sta $30,x

    