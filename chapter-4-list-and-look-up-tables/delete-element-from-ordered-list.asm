; This subroutine deletes the contents of location $2f from an ordered 
; list, if it is in the list. The starting address of the list is in
; locations $30 and $31. The length of the list is in the
; first byte of the list.
; The Find8 subroutine is called to perform the search.

DelOl:
    jsr Find8               ; search list for entry 
    lda $32                 ; is entry in the list?
    beq ItsOut              ; No, then return.
    iny                     ; Yess. Address next element
MoveMor:
    lda ($30),y             ; load it into accumulator
    dey 
    sta ($30),y             ; and move it down one location in list
    iny
    iny     
    cpy $33                 ; Have all elements been moved?
    bcc MoveMor             ; No. Go move another element
    beq MoveMor             
    lda $33                 ; yes. Decrement element count 
    sbc #01
    ldy #00
    sta ($30),y 

ItsOut:
    rts 