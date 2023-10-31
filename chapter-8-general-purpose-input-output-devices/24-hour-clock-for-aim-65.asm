; This subroutine displays a 24-hour clock on the AIM 65. Upon
; entry, the initial BCD values of seconds minutes, and hours must 
; be contained in locations $21, $22 and $23, respectively. The
; subroutine also uses location $20 to hold a 1/20 second count.

Clock24:
    sei                 ; disable IRQ interrupts
    lda #<ClockInt      ; clock interrupt vector = ClockInt
    sta $A404           
    lda #>ClockInt      
    sta $A405
    lda #$C0            ; set T1 free running mode
    sta $A00B 
    sta $A00E           ; enable Timer 1 interrupt
    lda #$4E            ; write count LSBY
    sta $A004       
    lda #$C3            ; write count MSBY and start clock
    sta $A005 
    lda #20 
    sta $20 
    cli                 ; enable IRQ interrupts 
    brk                 ; return to monitor
    nop 

; Following is the routine that displays the 24-hour clock.
DisplayClock:
    jsr CRLF            ; reset display 
    lda $23             ; load hours count 
    jsr NUMA            ;   and output it to display
    lda $22             ; load minutes count 
    jsr NUMA            ;   and output it to display 
    lda $21             ; load seconds count 
    jsr NUMA            ;   and output it to display
    jmp DisplayClock    ; refresh the display

; Following is the 24-hour clock interrupt service routine.
ClockInt:
    pha                 ; save accumulator on stack
    dec $20             ; 20 interrupts yet?
    bne IntDun          ; no, interrupt done
    sed                 ; yes, set decimal mode 
    clc                 ; increment seconds count 
    lda $21 
    adc #01 
    sta $21 
    cmp #$60            ; seconds = 60?
    bcc Res20           ; no, reinitialize interrupt counter
    lda #00             ; yes, clear seconds count 
    sta $21 
    adc $22             ; increment minutes count
    sta $22
    cmp #$60            ; minutes = 60?
    bcc Res20           ; no, reinitialize interrupt counter 
    lda #00             ; yes, clear minutes count 
    sta $22 
    adc $23             ; increment hours count
    sta $23
    cmp #$24            ; hours = 24?
    bcc Res20           ; no, reinitialize interrupt counter
    lda #00             ; yes, clear hours count
    sta $23 
Res20:
    lda #20             ; interrupt counter = 20
    sta $20
IntDun:
    lda $A004           ; clear T1 interrupt flag 
    cld                 ; clear decimal mode 
    pla                 ; restore accumulator
    rti 

