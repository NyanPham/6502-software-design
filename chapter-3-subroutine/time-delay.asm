; This subroutine can be used to generate time delays between 26
; microseconds and 329 microseconds, with a resolution of 5
; microseconds. The contents of locations $20 and $21 select the
; duration of the time delya.
; A value of one in $20 and $21 generates the minumum time delay,
; 26 microseconds. Each additional count increment in location $20
; generates a 5-microsecond time delay. Each additional count
; increment in location $21 generates a 1284-microsecond time delay.

Delay1:
    ldx $20             ; load x with 5-µSec count 
    ldy $21             ; load y with 1284-µSec count
Wait:
    dex
    bne Wait 
    dey 
    bne Wait 
    rts 
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 30-second time delay using Delay1 
; This sub routine generates a 30-sec time delay, by calling
; the delay1 subroutine 100 times 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
HalfMin:
    lda #$A5            ; prepare delay 1 to generate
    sta $20             ; 300-msec time delay
    lda #$EA            
    sta $21 
    lda #100            ; load A with decimal 100
CDelay:
    jsr Delay1          ; call Delay1
    sec 
    sbc #01             ; decrement the timing byte 
    bne CDelay          ; Loop until A is zero
    rts 