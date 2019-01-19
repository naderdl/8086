;---------------------------------------
.data
MaxLen DB 20
ActLen DB ?
S DB 20 DUP('')

;---------------------------------------
.code                                   
main proc far
           
            mov ah,0ah
            lea dx,MaxLen
            int 21h
;---------------------------------------
 ;CHANGE CHR(13) BY '$'.
            mov si, offset  + 1     ;NUMBER OF CHARACTERS ENTERED.
            mov cl, [ si ]              ;MOVE LENGTH TO CL.
            mov ch, 0                   ;CLEAR CH TO USE CX. 
            inc cx                      
            add si, cx                  ;NOW SI POINTS TO CHR(13).
            mov al, '$'
            mov [ si ], al              ;REPLACE CHR(13) BY '$'.             
;---------------------------------------
            lea bx, S
            mov si, bx
         n:  
            cmp [si], '$'
            je  e
            inc si
            jmp n

         e: dec si    
         
        
        
         r: 
            cmp bx, si
            jae d
            
            mov al, [bx]
            mov ah, [si]
            
            mov [si], al
            mov [bx], ah
            
            inc bx
            dec si
            jmp r

         d:       
            lea dx, s
            mov ah, 09h
            int 21h
          
            hlt
main endp
 