; This subroutine arranges the 16-bit elements of a list in
; ascending order. The starting address of the list is in locations
; $30 and $31. The length of the list is in the first byte of the list.
; Location $32 is used to hold an exchange flag.

Sort16 subroutine:
    ldy #00                 ; turn exchange flag off 
    sty $32 
    lda ($30),y             ; fetch element count
    tay                     ;   and use it to index last element
NextEl:
    lda ($30),y             ; fetch MSBY
    pha                     ; save it onto stack
    dey 
    lda ($30),y             ; fetch LSBY 
    sec 
    dey
    dey
    sbc ($30),y             ; subtract lsby of the preceding element
    pla                     ; pull msby from stack
    iny
    sbc ($30),y             ; and subtract MSBY of preceding element
    bcc Swap                ; Are these elements out of order?
    cpy #02                 ; No, loop until all elements compared
    bne NextEl

    bit $32                 ; exchange flat still off?
    bmi Sort16              ; No, then go through the list again
    rts 

; This routine below exchanges two 16 bit elements in memory
Swap:
    lda ($30),y             ; get the MSBY1
    pha                     ; and save to stack
    dey 
    lda ($30),y             ; get the LSBY1 
    pha                     ; and save to stack

    iny 
    iny
    iny                     
    lda ($30),y             ; get the MSBY2 
    pha                     ; save it to stack (MSBY1, LSBY1, MSBY2)
    dey
    lda ($30),y             ; get the LSBY2 
    dey
    dey 
    sta ($30),y             ; store that into LSBY1 position
    ldx #03 
SLoop:
    iny 
    pla 
    sta ($30, y)
    dex 
    bne Sloop 
    lda #$ff
    sta $32 
    cpy #04                 ; was exchange done at start of list?
    beq Sort16              ; yes. Go through list again
    dey
    dey
    jmp NextEl
