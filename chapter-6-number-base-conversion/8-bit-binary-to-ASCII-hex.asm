; This subroutine converts and 8-bit binary value in the accumulator
; to a two-digit ASCII string that is output to the printer.

B2AH:
    pha             ; save binary value on stack
    lsr a           ; shift first digit into four LSB's
    lsr a
    lsr a
    lsr a 
    jsr CB2AH       ; convert it to ASCII 

; The binary-to-ASCII subroutine follows 
CB2AH:
    cmp #$0A        ; is digit between 0 and 9?
    bcc Z29         
    adc #$36        ; no, digit is between A and F, so add 37 (36 + 1 carry)
    rts 
Z29:
    ora #$30        ; yes, add MSD = $3
    rts 