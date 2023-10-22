    lda #00         ; make port a inputs
    sta $A003       
    sta $A00C       ; set CA1 intterupt flag on 
                    ;   negative transition

CheckCA1:
    lda $A00D       ; fetch IFR 
    and #2          ; data ready?
    beq CheckCA1    ; no, loop until data ready
    lda $A001       ; yes, then input data
    sta $40         ; and store it