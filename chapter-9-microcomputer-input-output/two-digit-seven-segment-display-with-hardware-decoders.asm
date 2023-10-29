    Displ1:
        lda #00             ; clear peripheral control register
        sta $A00C
        lda #$FF            ; make port B outputs 
        sta $A002 
        lda $40             ; fetch 2 BCD digits 
        sta $A000           ;   and display them
        rts 