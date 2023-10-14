; This subroutine converts a five-digit series of ASCII decimal
; characters from the keyboard to a 16-bit binary value in locations
; $32 (LSBY) and $33 (MSBY). Carry is set if the result cannot
; be contained in these two locations.
; Location $31 is also used by the subroutine, for temporary storage.

A5D2B:
    lda #00             ; partial result MSBY = 0
    sta $33             
    jsr NewDigit        ; fetch high-order digit
    sta $32 
    ldx #04             ; remaining digits = 4
NextDigit:
    jsr NewDigit        ; fetch next digit
    jsr MPY10           ;   and add it to partial result 
    dex
    bne NextDigit       ; loop until 5 digits converted
    rts 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This subroutine inputs the next valid decimal digit, and returns
; with this digit in the four LSB's of the accumulator
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NewDigit:
    jsr KeyIn           ; fetch digit
    cmp #$30            ; is it less than $30
    bcc NewDigit
    cmp #$3A            ; is it greater than $3A
    bcs NewDigit
    and #$0f            ; no, then mask of the frou MSB's
    rts 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This subroutine multiplies the partial result in $32 and $33
; by ten, then adds the new digit to it.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MPY10:
    sta $31             ; save digit just entered in $31 
    lda $33             ; save partial result on stack
    pha 
    lda $32
    pha 
    asl $32             ; multiply partial result by 2
    rol $33
    asl $32
    rol $33             ; total multiply = 4
    pla 
    adc $32             ; add as a multiple total = 5
    sta $32 
    pla 
    adc $33 
    sta $33 
    asl $32             ; total multiply = 10
    rol $33 
    lda $31
    adc $32
    sta $32
    lda #00
    adc $33
    sta $33 
    rts 

