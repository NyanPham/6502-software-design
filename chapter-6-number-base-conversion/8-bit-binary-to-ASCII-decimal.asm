; This subroutine converts an 8-bit binary value in the accumulator
; to a three-digit ASCII decimal string that is output to the
; printer

B2AD:
    ldx #00             ; initialize hundreds counter
C100:
    cmp #100            ; binary value >= 100?
    bcc Out1            ; not, go print decimal digit 
    sbc #100
    inx 
    jmp C100 
Out1:
    jsr PutOut      
    ldx #00
C10:
    cmp #10
    bcc Out2
    sbc #10 
    inx 
    jmp C10
Out2:
    jsr PutOut
    clc 
    adc #$30
    jmp PtrOut
    
PutOut:
    pha                 ; save remainer on stack
    txa                 ; move decimal count to accumulator
    adc #$30            ; convert it to ASCII
    jsr PtrOut          ; and print it.
    pla                 ; restore the remainer
    rts 