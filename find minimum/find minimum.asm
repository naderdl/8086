;FIND MINIMUM

.DATA
A    DB    +2 , -40 , +7 , -16
MIN  DB    ?

.CODE

MAIN:
MOV  AX,@data
MOV  DS,AX

MOV  CX,4

MOV  SI, OFFSET  A

MOV  AL,[SI]

L1:
INC  SI

CMP  AL,[SI]

JLE  L2

MOV  AL,[SI]

L2:
LOOP L1

MOV  MIN,AL

END  MAIN