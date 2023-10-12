; This subroutine calls one of five user service subroutines,
; based on a user identification code (0, 1, 2, 3, or 4) in location
; $40. Locations $41 and $42 are used as scratch memory.

SelUser:
    lda $40             ; get user ID code
    cmp #05             ; Is it greater than 4?
    bcs UserDone        ; Yes. Return
    asl a               ; No. Double value of ID code 
    tay                 ;   and use it as index in y
    lda UAddR,y         ; fetch LSBY of user address
    sta $41             ;   and store it in $41
    iny 
    lda UAddR,y         ; fetch MSBY of user address
    sta $42             ;   and store it in $42 
    jmp ($0041)         ; go execute user subroutine

UserDone:
    rts 

UAddR:
    .word User0, User1, User2, User3, User4