ORG 1000H
b db 00000001b

; Memorie Instrucciones
ORG 3000H ; Subrutina 

ROTARIZQ: ADD AL, AL 
JNC FIN 
INC AL

FIN:RET

ROTARDER: CMP CL, 0 ; decremento 7 hasta que me lo rote
JZ FINN
CALL ROTARIZQ
DEC CL 
JNZ ROTARDER

FINN: RET

ORG 2000H ; Programa principal
MOV AL, b ;por valor 
MOV CL, 7
CALL ROTARDER


HLT
END
