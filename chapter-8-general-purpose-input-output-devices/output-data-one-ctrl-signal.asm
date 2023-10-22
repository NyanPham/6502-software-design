    lda #$FF            ; make port B outputs
    sta $A002           
    lda #$10            ; set CB1 interupt flag on
                        ;   positive transition

    sta $A00C 
CheckCB1:
    lda $A00D           ; fetch IFR 
    and #$10            ; peripheral ready?
    beq CheckCB1        ; loop untal peripheral ready
    lda $40             ; then fetch data
    sta $A000           ; and output it.
