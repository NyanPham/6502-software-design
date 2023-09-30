; This subroutine deletes the contents of location $2f from an
; unordered list, if it is in the list. The starting address of
; the list is in locations $30 and $31. The length of the list is
; in the first byte of the list.

DelUEl:
    ldy #0              ; fetch element count
    lda ($30),y
    tax                 ; transfer length into x
    lda $2f             ; load entry into accumulator
NextEl:
    iny                 ; index to next el
    cmp ($30),y         ; do entry and element match?
    beq Delete          ; yes, delete element
    dex 
    bne NextEl          ; anymore element to compare?
    rts 

; The instructions to follow delete an element, by moving all
; elements up one location
Delete:
    dex                 ; decrement element count
    beq DecCnt          ; End of list?
    iny                 ; no. Move next element up
    lda ($30),y 
    dey 
    sta ($30),y 
    iny                
    jmp Delete
DecCnt:
    lda ($30,x)
    sbc #01
    sta ($30,x)
    rts 
