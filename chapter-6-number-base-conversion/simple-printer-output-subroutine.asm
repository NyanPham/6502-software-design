; This subroutine outputs an ASCII code from the accumulator to
; location $A278. Location $A277 contains a "Printer ready"
; status flag in bit 7.

PtrOut:
    bit $A277       ; printer ready?
    bpl PtrOut      ; no, wait until it is 
    sta $A278       ; yes, output it
    lsr $A277       ;   and clear status flag
    rts 