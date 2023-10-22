; This routine sets the T2 interrupt flag after 10 pulses have
; been counted on PB6

    lda #00         ; make port B inputs
    sta $A002

    lda #01         ; set T2 pulse-couting mode 
    sta $A00B 
    lda #0A         ; write count LSBY
    sta $A008 
    lda #00         ; write count MSBY and start counting
    sta $A009
    lda #$20        ; set T2 interrupt mask
CheckT2:
    bit $A00D       ; has T2 counted down?
    beq CheckT2     ; no, check again
    lda $A008       ; yes, clear T2 interrupt flag