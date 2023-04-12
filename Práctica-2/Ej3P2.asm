ORG 1000H
DIML DB 26             ; cant de veces que lo va a hacer porq son 26 letras

ORG 2000H

MOV CL, 41H            ; A
MOV CH, 61H            ; a

MOV BX, OFFSET DIML    ; la direc que esta en BX contiene lo que voy a imprimir
MOV AL, 1              ; cantidad de caracteres que voy a imprimir 

LOOP:MOV [BX], CL      ; a lo que contiene BX le asigno la mayus
INT 7                  ; imprime la mayus porq esta en la direc de BX
INC CL 
MOV [BX], CH 	     ; a lo que contiene BX le pongo la minus
INT 7                  ; imprime la minus porq esta en la direc de BX
INC CH 
CMP DIML, CH           ; si CH llega a 26 para
JNZ LOOP


INT 0
END
