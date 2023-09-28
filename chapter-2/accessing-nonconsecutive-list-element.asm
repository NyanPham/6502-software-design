; This routine uses every fifth element (0, 5, 10, etc.) of a
; list that starts at location $0501 to construct a new list,
; starting at location $21. The length of the source list, in
; bytes, is contained in location $0500. The byte length of
; the new list is entered into location $20

    ldy #0                  ; source list index = 0
    ldx #0                  ; new list index = 0
GetEm:
    lda $0501,y 
    sta $21,x  
    inx 
    
    tya 
    clc
    adc #05 
    tay 
    cmp $0500
    bcc GetEm
Done: 
    stx $20
