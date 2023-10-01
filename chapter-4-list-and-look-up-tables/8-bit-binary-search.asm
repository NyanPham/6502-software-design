; This routine searches for the contents of location $2f in an
; ordered list whose starting address is contained in locations
; $30 and $31. The length of the list is in the first byte of the list
; (and is returned in location $33).
; location $32 holds the search result upon return. If the entry
; was found, $32 will contain the number of the matching element;
; if not, $32 will contain zero.
    
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