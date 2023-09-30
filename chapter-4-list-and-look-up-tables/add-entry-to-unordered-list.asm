; This subroutine adds the contents of location $2f to an unordered
; list, if it is not already in the list. The starting address
; of the list is in locations $30 and $31. The length of the list
; is in the first byte of the list.

Add2UL:
    ldy #0              ; fetch element count 
    lda ($30),y         
    tax                 ; transfer length into x 
    lda $2f             ; load entry into A
NextEl:
    iny                 ; index next element
    cmp ($30),y         ; entry and element match?
    beq Itsin           ; yes, done 
    dex                 ; no, decrement and check the next element
    bne NextEl          ; any more elements to compare?
    iny                 ; no, add entry to the end of list
    sta ($30),y       
    tya
    sta ($30,x)         ; x is not zero
Itsin:
    rts 