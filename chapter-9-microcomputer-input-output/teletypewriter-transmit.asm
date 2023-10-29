; This subroutine transmits an ASCII character in the accumulator
; to the teletypewriter. Location $40 is used for temporary storage.

OutTTY:
    pha                 ; save ASCII character on stack
    sta $40             ;   and in memory
    lda #00             ; clear peripheral control register
    sta $A80C           
    sta $A800           ; transmit start bit (logic 0)
    jsr Delay           ; wait one bit count
    ldx #08             ; data bit count = 8
    lda $40             ; fetch ASCII character 
    rol a               ; align LSB with bit 2
    rol a 
OutBit:
    sta $A800           ; transmit data bit 
    ror a               ; shift next bit into bit 2 
    jsr Delay           ; wait one bit time 
    dex                 ; all bit transmitted?
    bne OutBit          ; no, transmit next bit 
    lda #04             ; transmit stop bit (logic 1's)
    sta $A800
    jsr Delay
    jsr Delay
    pla                 ; restore accumulator contents 
    rts 