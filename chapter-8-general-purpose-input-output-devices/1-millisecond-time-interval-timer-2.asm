; This routine sets the T2 interrupt flag at the end of a one
; millisecond time interval
    
    lda #00             ; set T1 one-shot interval timer mode
    sta $A00B 
    lda #$EB            ; write count LSBY
    sta $A008
    lda #$03            ; write count MSBY and start timer
    sta $A009 
    lda #$20            ; set T2 interrupt mask
CheckT2:
    bit $A00D           ; has T2 counted down?
    beq CheckT2         ; not, check again
    lda $A008           ; yes, clear T2 interrupt flag 

    