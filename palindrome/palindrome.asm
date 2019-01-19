; palindrome 
org 100h
;--------------------------------------------------------
.data
    m1:
        s db 'abcdefggfedcba'
        s_size = $ - m1
        db 0Dh,0Ah,'$'
        
    msg1  db  " yes $"
    msg2  db  " no $"
;---------------------------------------------------------
.code
main proc far
    mov  ax,@data
    mov  ds,ax

    mov  ah, 9
    mov  dx, offset s
    int  21h

    lea  di, s
    mov  si, di
    add  si, s_size
    dec  si             ; point to last char!
    
    mov  cx, s_size
   
    cmp  cx, 1
    je   is_palindrome  ; single char is always palindrome!
    
    shr  cx, 1          ; divide by 2!
    
    call check

is_palindrome:  
    mov  ah, 9
    mov  dx, offset msg1
    int  21h     
    jmp  stop

not_palindrome:
    mov  ah, 9
    mov  dx, offset msg2
    int  21h
  
stop:
    ; wait for any key press:
    mov  ah, 0
    int  16h
main endp   
;---------------------------------------------------------
check proc   
l:
    mov  al, [di]
    mov  bl, [si]
    cmp  al, bl
    jne  not_palindrome
    inc  di
    dec  si
    loop l 
    ret
check  endp   
;-------------------------------------------------------------
   end main 


