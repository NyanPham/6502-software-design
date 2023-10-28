; This subroutine checks to see whether a push-button switch attached to
; pin PA2 of a VIA is pushed, if it is, location $40 is set to a one.

    lda #00         ; clear peripheral control register
    sta $A00C       
    sta $A003       ; make port A inputs 
    sta $40         ; button flag = 0
    lda $A001       ; read port A
    and #04         ; is button pushed (PA2 = 0)?
    bne Done        ; no, done.
    inc $40
Done:
    ;;;;;;