; This subroutine moves a block of data in memory. The starting
; address of the data is contained in locations $40 (low address)
; and $41 (high address byte). The starting address of 
; the destination of the data is contained in locations $42 (low 
; address byte) and $43 (high address byte). The number of bytes
; to be moved is contained in location $44.

MoveB subroutine:
    ldx $44             ; load byte count into x register 
    sec                 ; calculate move displacement 
    lda $42 
    sbc $40
    lda $43
    sbc $41 
    bmi DisN            ; displacement negative?
    ldy $44             ; No. Start move with last byte
Cont1:
    dey 
    lda ($40),y         ; load byte from source location 
    sta ($42),y         ; and store it at destination location
    dex                 ; x-- as loop counter 
    bne Cont1           ; loop until all bytes moved 
    rts 
DisN:
    ldy #00             ; start move with first byte 
Cont2:      
    lda ($40),y         ; load byte from source location 
    sta ($42),y         ; and store it at destination location 
    iny                 ; index to next byte 
    dex                 ; x-- as loop counter 
    bne Cont2           ; loop until all bytes moved
    rts 