;Escribir un programa que solicite el ingreso de un número (de un dígito) por teclado y muestre en pantalla dicho número 
;expresado en letras. Luego que solicite el ingreso de otro y así sucesivamente. Se debe finalizar la ejecución al ingresarse en 
;dos vueltas consecutivas el número cero. 
ORG 1000H
uno db "uno   "                   ;dejamos 8 espacios para todos los numeros
dos db "dos   "
tres db "tres  "
cuatro db "cuatro"
cinco db "cinco "
seis db "seis  "
siete db "siete "
ocho db "ocho  "
nueve db "nueve "

ORG 1500H 
NUM DB ? ;numero que ingresamos 

ORG 2000H

MOV AL, 6                           ; siempre va a imprimir 6 caracteres
; la etiqueta ingrese se debe realizar hasta q se ingrese 2 veces el 0 consecutivamente, entonces hago un contador
MOV AH, 0

INGRESE: MOV BX, OFFSET NUM         ; guardamos direc del numero a leer
INT 6                               ; lee del teclado 
MOV CL, [BX]                        ; muevo a CL el num ingresado 
CMP CL, 30H
JNZ sigue

INC AH       ; si son iguales, incremento contador para ver si es 0
CMP AH, 1
JZ INGRESE
CMP AH, 2
JZ FIN

sigue: MOV AH, 0          ;inicializo el contador de ceros para ver cuando terminar

DEC CL
MOV BX, 1000H
LOOP: CMP CL, 30H
JZ SALTA
DEC CL
ADD BX, 6 
JMP LOOP

 SALTA: INT 7
 JMP INGRESE


FIN: INT 0
END
