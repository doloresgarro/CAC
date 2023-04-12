ORG 1000H
cadena db "abcde0hfghi"
fin db 30h 

; Memoria de Instrucciones
ORG 3000H ; Subrutina MUL

CONCAR: MOV BX, AX ; paso por ref via registro

MOV CH, 0; inicializo contador
LOOP: MOV AL, [BX] ; me guardo lo que tiene la cadena en esa posicion
CMP AL, DL
JZ FIN
INC CH 
INC BX 
DEC CL
JNZ LOOP

FIN:RET


ORG 2000H ; Programa principal
MOV AX, OFFSET cadena ; me guardo direc de la cadena
MOV CL, OFFSET fin - OFFSET cadena ; me guardo dimL
MOV DL, fin
CALL CONCAR


HLT
END

