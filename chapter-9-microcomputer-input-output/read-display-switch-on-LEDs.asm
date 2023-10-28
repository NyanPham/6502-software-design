; This subroutine reads the current settings of 8 switches that
; are connected to port A of a VIA, and sends them to 8 LED's
; that are connected to port B of the VIA.

    lda #00             ; clear peripheral control register
    sta $A00C 
    sta $A003           ; make port A inputs
    lda #$FF            ; make port B outputs 
    sta $A002 
    lda $A001           ; read switch data
    tax                 ;   and save them in X
    eor #$FF            ; complement switch data
    sta $A000           ;   and display on LED's
    txa 