;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; One minute by simply doubling the A to 200 (200 * 300mSec = 60sec) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OneMin:
    lda #200            ; Decimal 100
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; A One-hour time-delay subroutine that alls the OneMin subroutine
; Need to use pushing and pulling stack as both OneHr and OneMin
; use A for timing byte 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OneHr:
    lda #60                 ; load timing byte into A
Delay2:
    pha                     ; save A of Hr timing to stack 
    jsr OneMin              ; calling OneMin subroutine, different timing byte in A there
    pla                     ; retrieve timing byte for OneHr 
    sec
    sbc #01
    bne Delay2              ; Loop until timing bye is zero
    rts                     ; return after one hour