
ORG 1000H
cadena db "abcdeaoaoa"
caracter db "o"
car2 db "X"

; Memoria de Instrucciones
ORG 3000H ; Subrutina MUL

CONCAR: MOV BX, AX ; paso por ref via registro

MOV CH, 0 ; inicializo contador de veces q aparece el car

LOOP: MOV AL, [BX] ; me guardo lo que tiene la cadena en esa posicion
CMP AL, DL
JNZ SIGUE
MOV [BX], DH ; cambio el car por X
INC CH ; incrementa contador
SIGUE: INC BX 
DEC CL
JNZ LOOP

RET
