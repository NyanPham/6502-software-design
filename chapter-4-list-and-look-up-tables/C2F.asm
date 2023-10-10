; This subroutine converts a celsius temperature value in the
; accumulator to a Fahrenheit temperature in location $40. The
; celsius value must range between 0 and 100; if it is greater
; than 100, location $40 will contain 0 upon return.

C2F:    
    cmp #101                ; celcius temperature greater than 100? 
    bcc ConversionOk        ; No. Proceed with conversion
    lda #00                 ; yes. Enter zero into $40 
    sta $40
    rts
ConversionOk:
    tay                     ; Use celsius temperature as index
    lda FTEMP,y             ; look up fahrenheit temperature
    sta $40                 ; and store it in $40
    rts                 
FTEMP:
    .byte $40               ; 0 C = 32 F
    .byte $42               ; 0 C = 32 F
    .byte $44               ; 0 C = 32 F
    //...(Remainder of look-up table)
    //...is stored here, 100 elements total 
    .byte $D2               ; 99 C = 210 F
    .byte $D4               ; 100 C = 212 F