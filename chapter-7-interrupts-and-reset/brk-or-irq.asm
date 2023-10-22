
    pla             ; pull status register from stack
    pha             ;   and restore it 
    and #$10        ; isolate B flag 
    bne Break       ; branch if caused by BRK
                    ; other wise process IRQ down here