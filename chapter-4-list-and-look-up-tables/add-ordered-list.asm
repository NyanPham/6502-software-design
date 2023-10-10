; This subroutine adds the contents of location $2f to an orderedlist,
; if it is not already in the list. The starting address of the list
; is in locations $30 and $31. The length of the list is in the 
; first byte of the list.
; The Find8 Subroutine is called to perform the search.
    
Add2Ol:     
    jsr Find8               ; search list for entry 
    lda $32                 ; is entry in the list?
    bne ItsIn               ; Yes. Return 
    sty $32                 ; Nope. Save final Y of the search 
    sec                     ; calculate number of bytes to end of list
    lda $33                 ;   as difference between list length
    sbc $32                 ;   and final search y
    tax                     ; put byte count in x 
    lda $2f                 ; load entry into accumulator 
    cmp ($30),y             ; entry > final search element?
    bcs Grtr                ; Yes. insert entry after element 
    inx 
    jmp MoveEm  

Grtr:
    inc $32 
    cpx #00                 ; is byte count = 0?
    beq Insert              ; yes tack entry on to end of list
MoveEm: 
    ldy $33                 ; index to last element in list 
MoveNxt:
    lda ($30),y             ; load element 
    iny 
    sta ($30),y             ; store it in next location 
    dey 
    dey 
    dex                     ; decrement byte count 
    bne MoveNxt 

Insert:
    lda $2f                 ; insert entry to list 
    ldy $32                 
    sta ($30),y
    inc $33                 ; update element count 
    lda $33
    ldy #00
    sta ($30),y 
ItsIn:
    rts 