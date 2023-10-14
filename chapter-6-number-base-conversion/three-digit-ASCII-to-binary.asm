; This subroutine converts a three-digit string of decimal ASCII
; characters to an 8-bit binary value in the accumulator.
; Carry is set if the accumulator cannot hold the result.

A3D2B: 
    jsr NewDigit            ; fetch high-order digit
    sta $30                 ;   and store it as a partial result
    jsr NewDigit            ; fetch second digit
    jsr Multi10
    jsr NewDigit
    jmp Multi10

; This subroutine inputs the next valid decimal digit, and returns
; with this digit in the four LSB's of the accumulator.
NewDigit:
    jsr KeyIn               ; fetch digit 
    cmp #$30                ; is char less than #$30?
    bcc NewDigit            
    cmp #$3A                ; is char greater than $39?
    bcs NewDigit
    and #$0F                ; No. Mask out the four MSB's
    rts 

Multi10:
    sta $31                 ; save fetched digit 
    lda $30 
    asl a                   ; total mult = 2
    asl a                   ; total mult = 4
    adc $30                 ; total mult = 5
    asl a                   ; total mult = 10
    adc $31                 ; add new digit 
    sta $30                 ; update the partial result
    rts 