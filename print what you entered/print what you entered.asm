sseg segment stack
     DW 46 DUP(?)
sseg ends
;-----------------------------
dseg segment
    
maxlen DB 20
actlen DB ?                                                                        
strbuf DB 20 dup('$')
dseg ends              
;-----------------------------
cseg segment
     assume cs:cseg, ds:dseg
     mov ax, dseg
     mov ds,ax
; ta inja segment haro set mikonam
     mov AH,0aH
     lea DX,maxlen
     int 21h
; ta inga reshte migiram
     mov AH,02
     mov BH,0
     mov DH,1
     mov DL,0
     int 10h
;mire khat bad
     mov BX,0001H  ; number 1 for monitor filehandle
     mov Cl,actlen ; tole reshte ro baraye chap midim behesh
     lea DX,strbuf ; address shoroe reshte ro midim behesh
     mov ah,40h
     int 21h
;ta inga reshteii ke gerefte ro chap mikone
cseg ends