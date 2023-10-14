; This subroutine converts a two-digiet string of hexadecimal ASCII
; characters to an 8-bit binary value in the accumulator. Location
; $30 is used for temporary storage.

AH2B:
    jsr NewHD           ; input most significant digit 


; The subroutine below inputs the next valid hexadecimal digit.
; and returns with this digit. In the four LSB's of the accumulator.
NewHD:
    jsr KeyIn           ; fetch Digit 
    cmp #$30            ; character less than $30?
    bcc NewHD       
    cmp #$47            ; no, is it more than $46?
    bcs NewHD           
    cmp #$3A            ; no, is it between 0 and 9?
    bcs A2F             
    and #$0f            ; yes, mask off the four MSB's
    rts 
A2F:
    cmp #$41            ; Character between A and F?
    bcc NewHD 
    sbc #$37            ; yes, then subtract 37 
    rts 





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; KeyIn Subroutine somewhere in the memory
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
KeyIn:
    bit $A275       ; key pressed?
    bpl KeyIn       ; no wait until it is 
    lda $A276       ; yes, fetch ASCII code 
    lsr $A275       ;   and clear status flag
    rts 
