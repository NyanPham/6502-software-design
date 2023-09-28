; This routine subtracts a 16-bit number stored in locations
; $22 and $23 from another number 
; stored in locations $20 and $21. Locations $20
; and $22 hold the low-order bytes of the numbers. The result
; replaces the number in locations $20 and $21.

DPSub:
    sec          ; Carry = 1
    lda $20         ; subtract low-order bytes
    sbc $22 
    sta $20
    lda $21         ; subtract high-order bytes 
    sbc $23 
    sta $21 