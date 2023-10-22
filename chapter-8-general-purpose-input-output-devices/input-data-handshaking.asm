    lda #00         ; make port A inputs
    sta $A003
    lda #0B         ; set CA2 handshake mode with
    sta $A00C       ; CA1 interrupt flag set on
                    ;   negative transition

CheckCA1:
    lda $A00D       ; fetch IRF
    and #02         ; data ready?
    beq CheckCA1    ; loop until data ready
    lda $A001       ; then input data
    sta $40         ; and store it 