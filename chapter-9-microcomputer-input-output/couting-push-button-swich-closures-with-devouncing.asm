; This subroutine counts closures on push-button switch NO.1 until push-
; button swich No. 2 is pushed. Push-button switch No. 1 is connected 
; to VIA pin PA2, push-button swich No. 2 is connected to VIA PIN PA7.
; The closure count is held in memory location $40

    lda #00             ; clear peripheral control register
    sta $A00C
    sta $A003           ; make port A inputs 
    sta $40             ; closure count = 0
CheckBtn:
    lda $A001           ; read port A
    bpl Done            ; Done if button No. 2 is pushed (PA7 = 0)
    and #04             ; is button No. 1 push (PA2 = 0)?
    bne CheckBtn        ; no, wait until it is
    inc $40             ; yes increment closure count.
    jsr Delay10         ; Wait 10 miliseconds to debounce
CheckRel:
    lda $A001           ; read port A again
    and #04             ; Is button No. 1 still closed?
    beq CheckRel        ; Yes, wait for release
    Jsr Delay10         ; No, debounce the key opening 
    jmp CheckBtn 
Done:
    ;;;;;

; The following subroutine uses Timer 1 to generate a 10-milisecond
; debounce time delay, by writing 10,000 ($2710) into the counters.
Delay10:
    lda #00             ; set T1 one-shot mode, with no PB7
    sta $A00B
    lda #$10            ; write count LSBY
    sta $A004 
    lda #$27            ; write count MSBY and start timer 
    sta $A005 
    lda #$40            ; select T1 interrupt mask
CheckT1:
    bit $A00D           ; has T1 counted down?
    beq CheckT1         ; no, wait until it has
    lda $A004           ; yes, clear T1 interrupt flag 
    rts                 ; return