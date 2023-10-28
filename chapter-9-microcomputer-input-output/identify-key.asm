    lda #$FF            ; make port B outputs 
    sta $A002
    lda #00             ; clear peripheral control register
    sta $A00C
    sta $A003           ; make port A inputs 
    sta $A000           ; ground all outpus 
Check4GD:   
    lda $A001           ; get column data
    cmp #$E0            ; is any column grounded?
    bcs Check4GD        ; no, wait until one is.
    jsr Delay10         ; yes, debounce the key

; Following are the row scanning instructions 
    lda #00             ; row offset = 0
    sta $40
    lda #$C0            ; ground row 0
    sta $A000
    lda $A001           ; get column data for row 0
    cmp #$E0            ; is any column grounded?
    bcc IDKey           ; yes, identify key pressed
    lda $40             ; No, add 3 to row offset 
    adc #02             
    sta $40
    lda #$A0            ; ground row 1 
    sta $A000
    lda $A001           ; get column data for row 1
    cmp #$E0            ; is any column grounded?
    bcc IDKey           ; yes, identify key pressed
    asl a               ; no, row offset = 6
    lda #$60            ; ground row 2
    sta $A00
    lda $A001           ; get column data for row 2

; The following instructions identify the key
IDKey:  
    asl a               ; is key 2, 5, or 8 pressed?
    bcs Key147          ; no, check 1, 4, or 7 pressed 
    lda #02             ; yes, calculate key code
    jmp Done 

Key147:
    asl a               ; is key 1, 4 or 7 pressed?
    bcs Key036          ; no, key 0, 3 or 6 is pressed
    lda #01             ; yes, calculate key code 
    jmp Done 
Key036:
    lda #00
Done:
    adc $40
