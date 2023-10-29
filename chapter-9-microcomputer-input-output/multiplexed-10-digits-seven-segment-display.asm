; This subroutine displays the contents of memory location $40
; through $44 on a 10-digit seven-segment display.

    lda #$A0            ; set CB2 to pulse output mode
    sta $A00C
    lda #$FF            ; make port B ouputs 
    sta $A002 
Recycl:
    ldx #00             ; point to first location
    ldy #05             ; number of digit pairs = 5
OutMux:
    lda $40,x           ; fetch next two digits 
    sta $A000           ;   and display them
    jsr Dly3            ; wait 3 milliseconds.
    inx
    dey                 ; any more digits?
    bne OutMux          ; yes. go fetch them.
    beq Recycl          ; no, cycle through again.

; The following subroutine uses Timer 1 to generate a 3-millisecond
; delay, by writing 3000 ($0BB8) into the counters 
Dly3:
    lda #00             ; set T1 one-shot mode, with NO PB7
    sta $A00B            
    lda #$B8            ; write count LSBY
    sta $A004           
    lda #$0B            ; write count MSBY and start timer
    sta $A005
    lda #$40            ; select T1 interrupt mask
CheckT1:
    bit $A00D           ; has Timer 1 counted down?
    beq CheckT1         ; no, wait until it has
    lda $A004           ; yes, clear T1 interrupt flag
    rts 