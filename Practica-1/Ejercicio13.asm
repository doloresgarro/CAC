ORG 1000H
vocales db "aeiouAEIOU"
car db "q"

; Memoria Instrucciones
ORG 3000H ; Subrutina 

ES_VOCAL: MOV BX, OFFSET vocales
MOV CL, OFFSET car - OFFSET vocales ; dimL

LOOP: MOV AH, [BX] ; me guardo elem de tabla
CMP AL, AH 
JZ vocal
INC BX 
DEC CL
JNZ LOOP

MOV CH, 00H
JMP FIN

vocal: MOV CH, 0FFH

FIN:RET



ORG 2000H ; Programa principal

MOV AL, car ; para pasarlo por valor
CALL ES_VOCAL


HLT
END
