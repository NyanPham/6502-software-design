; This subroutine generates a six-millisecond time interval in which
; PB7 inverts each millisecond. Location $40 is used to hold a
; time interval count.
    lda #$80            ; make PB7 an ouput 
    sta $A002 
    lda #$C0            ; set T1 free-running mode, with PB7 output
    sta $A00B           
    sta $A00E           ; enable timer 1 interrupt
    lda #$E6            ; write count LSBY 
    sta $A004       
    lda #$03            ; write count MSBY and start timer
    sta $A005       
    lda #06             ; initialize time interval count = 6
    sta $40 
    cli                 ; enable interrupts in 6502 
    ;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;

; The following is the Timer 1 interrupt service routine.
ISRT1:
    lda $A004           ; clear T1 interrupt flag
    dec $40             ; decrement interval count
    bne CNTNZ           ; six milliseconds counted?
    lda #$40            ; yes, diable Timer 1 interrupt
    sta $A00E
    lda #00             ; and disable output on PB7
    sta $A002 
CNTNZ:  
    rti 