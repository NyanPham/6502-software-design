; This subroutine deletes the contents of location $2f from an ordered
; list. If it is in the list. The starting address of the list is in
; locations $30 and $31. The length of the list is in the
; first byte of the list.
; The find8 subroutine is called to perform the search.

DelOl:
    jsr Find8           ; search list for entry 
    lda $32             ; is Entry in the list
    beq ItsOut          ; Nope, return
    iny 
    

ItsOut:
    rts