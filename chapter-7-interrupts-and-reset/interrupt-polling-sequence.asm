;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Some code up there
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bit Sdev1       ; interrupte request from device 1?
bmi JISR1        ; if so, branch to JISR1
bit SDev2           
bmi JISR2
bit Sdev3 
bmi JISR3A 
bvs JISR3B 
jmp ISR4 

JISR1:  
    jmp ISR1

JISR2:
    jmp ISR2 

JISR3A:
    jmp ISR3A

JISR3B:
    jmp ISR3B