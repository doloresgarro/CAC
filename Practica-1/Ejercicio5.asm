TABLA DB DUP(2,4,6,8,10,12,14,16,18,20)
; deberia sumar 110
FIN DB ?
TOTAL DB ?
MAX DB 13

ORG 2000H
MOV AL, 0
MOV CL, OFFSET FIN-OFFSET TABLA ;dimL 
MOV BX, OFFSET TABLA ; direc de tabla en BX
SUMA: ADD AL, [BX] ; sumo lo que tiene BX a AX
INC BX ; avanzo en la tabla
DEC CL ; decremento dimL 
JNZ SUMA ; si result no es 0 sigue recorrido
HLT
END

; deberia sumar 110
