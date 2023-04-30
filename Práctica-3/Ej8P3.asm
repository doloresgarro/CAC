ORG 1000H
MSJ DB "UNIVERSIDAD "
DB "NACIONAL DE LA PLATA"
FIN DB ?

ORG 3000H

; desde esta subrutina de interrupcion se imprime 
; RUTINA de atencion a la interrupcion !!!!!!!!!!!!!
RUT_HND: PUSH AX

MOV AL, [BX]  ; guarda car a imprimir
OUT HAND, AL  ; lo manda al buffer 
INC BX        ; avanza en la palabra
DEC CL        ; disminuye dimL

MOV AL, 20H   ; termina la interrupcion
OUT PIC, AL 

POP AX 
IRET

ORG 2000H

MOV BX, OFFSET MSJ
MOV CL, OFFSET FIN-OFFSET MSJ

CLI

; configuracion del PIC
MOV AL, 0FBH  ; 1111 1011 activa el HANDSHAKE
OUT PIC+1, AL ; IMR 

MOV AL, N_HND ; ID de la interrup
OUT PIC+6, AL ; INT 2

; configuracion del HANDSHAKE
MOV AL, 80H   ; 1000 0000
OUT HAND+1, AL; primer dig es 1 --> habilita interrupciones

STI

LAZO: CMP CL, 0  ; por que esto se queda en bucle sin hacer nada?
JNZ LAZO

; deshabilita interrupciones
IN AL, HAND+1
AND AL, 7FH
OUT HAND+1, AL

INT 0
END
