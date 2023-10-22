; This sequence identifies the highest-priority interrupt request
; in a VIA that oocupies addresses $A000 through $A00F

    lda $A000D          ; does VIA have an active IRQ?
    bpl NextDevice      ; no, go check next device 
    and $A00E           ; Yes, logically an IFR with IER
    asl a               ; check for T1 interrupt 
    bmi JT1             
    asl a               ; check for T2 interrupt
    bmi JT2 
    asl a               ; check for CB1 interrupt 
    bmi JCB1        
    asl a               ; check for CB2 interrupt
    bmi JCB2 
    asl a               ; check for SR interrupt
    bmi JSHR            
    asl a               ; check for CA1 interrupt 
    bmi JCA1            
    asl a               ; check for CA2 interrupt 
    bmi JCA2 
    jmp Error 

JT1: 
    jmp ISRT1 
JT2:
    jmp ISRT2 
JCB1:
    jmp ISRCB1 
JCB2:
    jmp ISRCB2 
JSHR:
    jmp ISRSR 
JCA1:
    jmp ISRCA1 
JCA2:
    jmp ISRCA2 
    
NextDevice:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Interrupt polling for next device
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;