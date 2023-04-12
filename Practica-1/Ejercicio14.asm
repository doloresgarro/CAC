
ORG 1000H

vocales db "aeiouAEIOU"
cadena db "holadolores" 
fin_cadena db ?

; Memoria Instrucciones
ORG 3000H ; Subrutina 

ES_VOCAL: MOV BX, OFFSET vocales
MOV CL, OFFSET cadena - OFFSET vocales ; dimL vocales

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


VOCALES: MOV BX, AX
MOV DL, OFFSET fin_cadena - OFFSET cadena; dimL cadena
MOV DH, 0 ; inicializo contador de vocales

loop: MOV AL, [BX] ; me guardo elem de la cadena
PUSH BX
CALL ES_VOCAL
POP BX
CMP CH, 0FFH ; si es vocal termina
JNZ sigue 
INC DH 
sigue: INC BX
DEC DL ; decremento dimL de la cadena
JNZ loop 


fin: RET


ORG 2000H ; Programa principal

MOV AX, OFFSET cadena ; para pasarlo por referencia
CALL VOCALES


HLT
END
