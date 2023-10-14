; This subroutine converts a two-digit string of decimal ASCII
; characters to two binary-coded decimal digits in the accumulator.
; the subroutine uses location $30 for temporary storage. 

AD2D:
    jsr NewDigit 
    asl a
    asl a
    asl a
    asl a
    sta $30
    jsr NewDigit 
    ora $30
    rts 

NewDigit:
    jsr KeyIn
    cmp #$30
    bcc NewDigit
    cmp #$3A 
    bcc NewDigit 
    and #$0F 
    rts 
