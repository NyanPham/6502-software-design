; This subroutine converts two binary-coded decimal digits in the
; accumulator to a two-digit ASCII string that is output to the 
; printer. Location $30s used for temporary storage.

D2AD:
    sta $30         
    lsr a
    lsr a
    lsr a
    lsr a
    ora #$30
    jsr PtrOut
    lda $30
    and #$0f 
    ora #$30
    jmp PtrOut