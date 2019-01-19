
.data

    buffer  db   "empty buffer --- empty buffer"  
    
    size = $ - offset  buffer           
    
    s   db  "Enter Your Name: ", 0   
    
;-------------------------------------------------------
.code
 main  proc  far 
        mov     ax,@data
        mov     ds,ax
        
        lea     si, s
        call    display
        
        ; get string to ds:di
        lea     di, buffer             ; buffer offset.
        mov     dx, size        
        call    get_string
        
        putc    0Dh 
        putc    10                     
      
        print  "HELLO! "      ; print using macro:
       
        mov     si, di                 ; print string in ds:si using procedure
        call    display
        
        ; wait for any key...
        mov     ax, 0
        int     16h
  main  endp        
;-----------------------------------------------------
print   macro   a
     local   n, s, k, l  
     
     push    ax      
     push    si    
       
     jmp     l                           ; skip declaration.
     s  db   a, 0
    
l:
     lea     si, s
    
n:      
     mov     al, cs:[si]
     cmp     al, 0
     jz      k
     inc     si
     mov     ah, 0eh                     
     int     10h
     jmp     n   
k:
     pop     si      
     pop     ax     
print   endm

;----------------------------------------------------
putc    macro   char
        push    ax 
        
        mov     al, char
        mov     ah, 0eh
        int     10h 
            
        pop     ax
putc    endm

;------------------------------------------------
display  proc  near
         push    ax      
         push    si     
  n:      
        mov     al, [si]
        cmp     al, 0
        jz      p
        inc     si
        mov     ah, 0eh 
        int     10h
        jmp     n
  p:
        pop     si      
        pop     ax      

        ret
display endp
;---------------------------------------------
get_string    proc    near
        push    ax
        push    cx
        push    di
        push    dx
        
        mov     cx, 0                   ; char counter.
        
        cmp     dx, 1                   ; buffer too small?
        jbe     e            
        
        dec     dx                      

     w:

        mov     ah, 0                   ; get pressed key.
        int     16h
        
        cmp     al, 0Dh                 ; 'return' pressed?
        jz      exit
        
        cmp     al, 8                   ; 'backspace' pressed?
        jne     a      
        
        jcxz    w                       ; nothing to remove!
        
        dec     cx
        dec     di
        
        putc    8                       ; backspace.
        putc    ' '                     ; clear position.
        putc    8                       ; backspace again.  
        
        jmp     w

     a:

        cmp     cx, dx                  ; buffer is full?
        jae     w                       ; if so wait for 'backspace' or 'return'...

        mov     [di], al
        inc     di
        inc     cx
        
        ; print the key:
        mov     ah, 0eh
        int     10h

        jmp     w
   exit:
        mov     [di], 0                  ; terminate by null:

   e:
        pop     dx
        pop     di
        pop     cx
        pop     ax
        ret
get_string      endp

;-----------------------------------------------------------------------------


   end main 
 