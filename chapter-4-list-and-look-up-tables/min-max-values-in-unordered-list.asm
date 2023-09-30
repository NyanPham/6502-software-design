; This subroutine finds the minimum and maximum values in an
; unordered list, storing the minimum value into location $32 and
; the maximum value into location #33. The starting address of
; the list is in locations $30 and $31. The length of the list
; is in the first byte of the list

MinMax:
    ldy #00 
    lda ($30),y
    tax 
    iny                 ; index to first element 
    lda ($30),y         ; load it into accumulator 
    sta $32             ; make first element the initial min 
    sta $33             ; and max value 
Again:
    dex                 ; decrement element count 
    beq BothIn          ; end of list?
    iny                 ; no, index to next element
    lda ($30),y         ; load it to accumulator
    cmp $32             ; is element a new min? 
    bcs CheckMax        ; no, check if it's a max 
    sta $32             ; yes, store it in min 
    jmp Again               
CheckMax:
    cmp $33             ; is it a new max 
    bcc Again 
    beq Again 
    sta $33
    jmp Again 
BothIn:
    rts 