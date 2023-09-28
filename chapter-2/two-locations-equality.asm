; this routine sets memory location $22 to "One" if the contents
; of locations $20 and $21 are equal, and to "Zero" if otherwise.

    ldx #00             ; initialize flag to zero
    lda $20             ; get first value 
    cmp $21             ; is second value identical?
    bne Done
    inx                 ; yes, set flag to one
Done:
    stx $22