;VERSION INTERRUPCIÓN
; no anda :((((

PIC EQU 20H
HAND EQU 40H
ESTADO EQU 41H
N_HND EQU 10

ORG 40
IP_HND DW RUT_HND

ORG 1000H
CAR DB ?
cantCar db 5

ORG 3500H

EST: MOV BX, ESTADO

MOV AL, [BX]
salta: CMP AL, 81H   ; 1000 0001 --> ult bit en 1: ocupada
JZ salta
ret

ORG 3000H

RUT_HND: PUSH AX


MOV BX, OFFSET CAR
MOV CL, 0

loop: MOV AL, [BX] 
OUT HAND, AL   ; lo manda al buffer

INC BX
INC CL
CMP CL, 5
JNZ loop
DEC BX    ; porq sino me imprime dos veces la s


loop2: PUSH AX 
PUSH BX
CALL EST
POP BX
POP AX

DEC BX
MOV AL, [BX] 
OUT HAND, AL   ; lo manda al buffer
DEC CL
JNZ loop2

MOV AL, 20H   ; termina la interrupcion
OUT PIC, AL 

POP AX 
IRET

ORG 2000H

MOV BX, OFFSET CAR
MOV CL, cantCar

; los pone en memoria
pp: INT 6
INC BX
DEC CL
JNZ pp

CLI

; configuracion del PIC
MOV AL, 0FBH  ; 1111 1011 activa el HANDSHAKE
OUT PIC+1, AL ; IMR 

MOV AL, N_HND ; ID de la interrup
OUT PIC+6, AL ; INT2


; configuracion del HANDSHAKE
MOV AL, 80H   ; 1000 0000
OUT ESTADO, AL; primer dig es 1 --> habilita interrupciones

STI


; deshabilita interrupciones
IN AL, HAND+1
AND AL, 7FH
OUT HAND+1, AL

INT 0
END
