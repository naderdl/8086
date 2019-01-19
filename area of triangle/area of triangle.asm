.model small
.stack 32
.data
   A    DB    3 , 5 , 2      
   T    DB    ? 

.code


MAIN:
     
     MOV AX,@data
     MOV DS,AX
 
     
     lea ax,A
     mov si,ax
     mov ax,0000h
     mov AL,[SI]
     inc SI
     mul [SI]
     inc si
     div [SI]
     mov T,AL

     RET