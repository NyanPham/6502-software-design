; This subroutine adds the contents of location $2f to an orderedlist,
; if it is not already in the list. The starting address of the list
; is in locations $30 and $31. The length of the list is in the 
; first byte of the list.
; The Find8 Subroutine is called to perform the search.

Add2Ol:
    jsr Find8       ; search list for entry 
    lda $32         ; is entry in the list?
    bne ItIsIn      ; yes return
    sty $32         ; no. Save final y of the search
    sec             ; calculate number of bytes to end of list 
    lda $33         ;   as difference between list length 
    sbc $32         ;   and final search y 
    tax             ; put byte count in x 
    lda $2f         ; load entry to A
    cmp ($30),y     ; entry > final search element?
    bcs GRTR        ; Yes? Insert entry after element
    inx 
    jmp MoveEm      
GRTR:
    inc $32 
    cpx #00         ; is byte count = 0?
    beq Insert      ; yes. Tack entry onto end of list
MoveEm:
    ldy $33         ; Index to last element of list 
MovNxt:
    lda ($30),y     ; load element 
    iny 
    sta ($30),y     ; and store it in next location
    dey             ; backtrack to preceding element 
    dey         
    dex 
    bne MovNxt
Insert:
    lda $2f
    ldy $32 
    sta ($30),y 
    inc $33         ; update element count 
    lda $33 
    ldy #00
    sta ($30),y
ItIsIn:
    rts             ; return 

Find8:
    ldy #00         ; fetch element count
    lda ($30),y     
    sta $32         ; store it in locations $32
    sta $33         ;   and $33 
    iny             ; index to first element
NextCheck:
    lsr $32         ; cut search increment by one-half
    bne NotDun      ; search increment = 0?
    bcs Even        ; yes, one last compare if increment was = 1
    rts 
NotDun:
    bcc Even        ; was search increment odd?
    inc $32         ; yes, then round upward 
Even:
    lda ($30),y     ; load element into accumulator
    cmp $2f         ; does this element match entry?
    beq Found       ; yes return now
    bcs GoLow       ; NO? then is element > entry? search lower
                    ; NO? is element < entry ? search higher
                    ; add increment to y index
    tya 
    adc $32 
    cmp $33         ; but limnit y to upper bound of list
    beq YOk1        
    bcs NextCheck       
YOk1:
    tay 
    jmp NextCheck

GoLow:
    tya 
    sbc $32
    beq NextCheck
    bcs YOk2 
    bmi NextCheck
YOk2:
    tay 
    jmp NextCheck

Found:
    sty $32
    rts 