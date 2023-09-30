;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Build in the 300-mSec delay into the subroutine HalfMin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HalfMin:
    lda #100            ; Decimal 100
GenDelay:       
    ldx #$A5            ; load x and y for a 300-sec time delay
    ldy #$EA            
Wait:
    dex 
    bne Wait 
    dey 
    bne Wait                  
    sec 
    sbc #01
    bne GenDelay
    rts 
