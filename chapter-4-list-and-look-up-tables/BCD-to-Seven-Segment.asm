; This subrtouine converts a BCD digit in location $40 to a
; seven-segment display code in location $41. If location $40
; does not contain a digit between zero and nine, location
; $41 contains zero upon return.

BCD2SS:
    lda #00
    sta $41             ; initialize result location to zero
    ldy $40             ; load digit into index register y
    cpy #10             ; is digit greater than nine?
    bcs SSDun           ; yes. return with zero in $41
    lda SSEG,y          ; no. Look up seven-segment code
    sta $41 
SSDun:
    rts 
SSEG:
    .byte $3f,$06,$5B,$4f,$66
    .byte $6d,$7d,$07,$7f,$6f