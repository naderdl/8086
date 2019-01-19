org 100h


;-----------------
    c  db  12     
    f  db   ?      
;-----------------------------------------
start:
    mov   cl, c
    mov   al, 9
    imul  cl       ;al=al*cl
    
    mov   cl, 5
    idiv  cl       ;al=al/cl
    
    add   al, 32   ;al=al+32
    
    mov   f, al
    
    mov   bl, f 
    
    hlt