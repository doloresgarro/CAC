ORG 1000H
b db 00000001b

; Memoria de Instrucciones
ORG 3000H ; Subrutina MUL

ROTARIZQ: CMP CL, 0 ; decremento 7 hasta que me lo rote
JZ FIN
add AL, AL ; le voy sumando lo que tenia, se va corriendo 1
DEC CL 
JNZ ROTARIZQ

FIN: RET

ORG 2000H ; Programa principal
MOV AL, b ;por valor 
MOV CL, 7
CALL ROTARIZQ


HLT
END
