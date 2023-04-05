ORG 1000H
TABLA DB DUP(2,4,6,8,10,12,14,16,18,20)
;TABLA DB 2, 14, 5, 13, 19
FIN DB ?
TOTAL DB ?
MAX DB 13

ORG 2000H
MOV AL, 0
MOV CL, OFFSET FIN-OFFSET TABLA
MOV BX, OFFSET TABLA
MOV DL, MAX ;muevo a DL el max para comparar 

COMP: CMP DL, [BX]; comparo max con elem de tabla
JS salta; si hay signo que no sume xq elem de tabla es mayor a max
INC AL; incrementa xq no hay signo → elem es menor a max  
salta: INC BX ;avanza en tabla 
DEC CL ; dec dimL 
JNZ COMP

MOV BX, OFFSET TOTAL 
MOV [BX], AL         

HLT
END
