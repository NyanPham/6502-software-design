; This subroutine converts a BCD digit in location $40 to a
; sevent segment code and displays it, if the BCD digit represents
; a decimal digit (0 - 9). If the BCD digit does not convert
; to a decimal digit, the subroutine blanks the display.

Displ:
    lda #00             ; clear peripheral control register
    sta $A00C
    lda #$FF            ; make port B outputs 
    sta $A002
    ldy $40             ; fetch BCD digit into Y
    cpy #10             ; is digit greater than 9?
    bcc Conv7           ; no, go convert and output
    lda #00             ; yes, blank display
    jmp Out7            
Conv7:
    lda SSEG,y          ; lookup seven-segment code 
Out7:
    sta $A000           ; output to display 
    rts 


SSEG:
    .byte $3F,$06,$5B,$4F,$66
    .byte $6D,$7D,$07,$7F,$6F
