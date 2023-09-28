; This routine adds 2 16-bit numbers. One number is
; stored in location $20 and $21, the other is stored in
; locations $22 and $23. The sum replaces the number in 
; locations $20 and $21 

DPAdd:
    clc             ; Carry = 0
    lda $20         ; add low-order bytes 
    adc $22     
    sta $20 
    lda $21         ; add high-order bytes 
    adc $23 
    sta $21 