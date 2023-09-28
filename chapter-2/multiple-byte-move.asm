; This routine moves up to 256 bytes of memory, starting at
; location $20, to another portion of memory, starting at location
; $0320. The byte count is contained in location $1f.  
    
    ldx #00             ; index = 0
NxtByt: 
    lda $20,x           ; load next byte 
    sta $0320,x         ; store next byte 
    inx 
    cpx $1f             ; all bytes moved?
    bne NxtByte         ; if not, move next byte 