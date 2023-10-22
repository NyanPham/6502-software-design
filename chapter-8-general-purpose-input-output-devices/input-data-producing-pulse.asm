    lda #00             ; make port A inputs 
    sta $A003           
    lda #$0A            ; set CA2 pulse output mode with
    sta $A00C           ;   CA1 intterupt flag set on
                        ;   negative transition

CheckCA1: 
    lda $A00D           ; fetch IFR
    and #02             ; data ready?
    beq CheckCA1        ; loop until data ready
    lda $A001           ; then input data
    sta $40             ; and store it