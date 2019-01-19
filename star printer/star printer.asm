;-----------------------------
dseg segment
    num1 DB ?
dseg ends              
;-----------------------------
cseg segment
        assume cs:cseg, ds:dseg
        mov ax, dseg
        mov ds,ax
        MOV AH,1
        INT 21H
        SUB AL,30H
        MOV NUM1,AL
        mov AH,02
     mov BH,0
     mov DH,1
     mov DL,0
     int 10h
        mov bh,num1
        mov bl,0
        MOV AH,2
    loop_1:
        cmp bh,0
        je END_1
        MOV BL,0
    LOOP_2:
        CMP BL,BH
        JAE END_2
        MOV DL,'*'
        INT 21H
        INC BL
        JMP LOOP_2
    END_2:
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
        DEC BH
        JMP LOOP_1
    END_1:
        MOV AH,4CH
        INT 21H 
cseg ends
