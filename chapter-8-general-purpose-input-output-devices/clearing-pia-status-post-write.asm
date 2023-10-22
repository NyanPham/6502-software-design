PNotRd: 
    bit PIAC            ; is peripheral ready?
    bpl PNotRd          ; no, loop until it is
    sta PIAD            ; yes, output data to peripheral
    lda PIAD            ;   then clear ready flag 
    