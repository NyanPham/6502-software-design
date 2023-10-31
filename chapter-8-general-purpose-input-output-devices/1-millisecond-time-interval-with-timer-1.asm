; This subroutine sets the T1 interrupt flag at the end of a one-
; millisecond time interval, with no output to PB7.

    lda #00             ; set T1 one-shot mode, with no PB7
    sta $A00B
    lda #$E6            ; write count LSBY
    sta $A004 
    lda #$03            ; write count MSBY and start timer
    sta $A005 
    lda #$40            ; set T1 interrupt mask
CheckT1:
    bit $A00D           ; has T1 counted down?
    beq CheckT1         ; no, check again
    lda $A004           ; yes clear T1 interrupt flag