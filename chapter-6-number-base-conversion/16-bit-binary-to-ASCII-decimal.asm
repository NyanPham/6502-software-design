; This subroutine converts a 16-bit binary value in memory locations
; $31 (LSBY) and $32 (MSBY) to a five-digit ASCII decimal string
; that is output to the printer.

DPB2AD:
    ldy #00                    
NextDigit:
    ldx #00
SubEm:  
    lda $31 
    sec
    sbc SubTable,y
    sta $31 
    lda $32
    iny
    sbc SubTable,y
    bcc AddBack
    sta $32
    inx 
    dey
    jmp SubEm

AddBack:
    dey 
    lda $31
    adc SubTable,y 
    sta $31
    txa 
    ora #$30 
    jsr PtrOut
    iny 
    iny
    cpy #08
    bcc NextDigit
    lda $31
    ora #$30
    jmp PtrOut

SubTable:
    .word $2710         ; 10,000
    .word $03E8         ; 1,000
    .word $0064         ; 100
    .word $000A         ; 10