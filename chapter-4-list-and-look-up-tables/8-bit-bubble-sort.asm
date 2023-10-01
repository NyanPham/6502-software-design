; This subroutine arranges the 8-bit elements of a list in ascending
; order. The starting address of the list is in locations $30 and
; $31. The length of the list is in the first byte of the list. Location
; $32 is used to hold an exchange flag.

Sort8:
    ldy #00             ; turn exchange flag off 
    sty $32 
    lda ($30),y         ; fetch element count 
    tax 
    iny                 ; point to first element, kick start 
    dex                 ; let's go
NextEl:
    lda ($30),y         ; fetch element
    iny 
    cmp ($30),y         ; compare with the next one
    bcc CheckEnd
    beq CheckEnd        ; if  prev <= next, skip swap 

    pha                 ; push prev to stack
    lda ($30),y         ; set next value to the prev position
    dey                 
    sta ($30),y
    pla                 ; retreive prev value from stack
    iny         
    sta ($30),y 
    lda #$ff            ; turn on exchange on 
    sta $32 
CheckEnd:
    dex 
    bne NextEl
    bit $32 
    bmi Sort8
    rts 

