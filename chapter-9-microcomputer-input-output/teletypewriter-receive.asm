; This subroutine inputs an ASCII character from the teletypewriter
; into the accumulator. Location $40 is used to assemble the
; serial data as it is received.

GetTTY:
    lda #00             ; Clear peripheral control register
    sta $A80C           
    ldx #07             ; data bit count = 7
    stx $40             ; clear MSB of data storage location
Get1:   
    bit $A800           ; has started bit been received?
    bvs Get1            ; no, wait until it is.
    jsr Delay           ; yes wait one bit time.
    jsr DeHalf          ; wait one-half bit time, to center
Get3:
    lda $A800           ; fetch input data register B
    and #$40            ; mask out all bit except bit 6
    lsr $40             ; right shift data byte, 
    ora $40             ;   combine it with the new bit,
    sta $40             ;   and store updated byte.
    jsr Delay           ; Wait one bit time
    dex                 ; decrement data bit count 
    bne Get3            ; if count is not zero, get next bit
    jsr Delay           ; wait one bit time to skip parity
    lda $40             ; fetch data byte 
    rts 

; The following subroutine generates a one-bit time delay.
Delay:
    lda #$3F            ; Initialize timer 2 low count 
    sta $A808           
    lda #$23            ; intialize timer 2 high count 
    sta $A809           ;   and start timer 
De2:
    lda #A80D           ; fetch interrupt flag register 
    and #$20            ; T2 interrupt flag set?    
    beq De2             ; no, wait until it is 
    rts 

; The following subroutine generates a one-half bit time delay.
DeHalf:
    lda #$23            ; load timer 2 high count
    lsr a               ;   and shift ir right into carry 
    lda #$3f            ; load timer 2 low count
    ror a               ;   and divide it by 2 with carry from
                        ;   high count 
    sta $A808           ; initialize timer 2 low count 
    lda #$23            ; initialize timer 2 high count 
    lsr a               ;   divide it by 2,
    sta $A809           ;   and start timer.
    jmp De2 