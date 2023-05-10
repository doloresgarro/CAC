<<<<<<< HEAD
;Escribir un programa que implemente un conteo regresivo 
;a partir de un valor ingresado desde el teclado. El conteo 
;debe comenzar al presionarse la tecla F10.
;El tiempo transcurrido debe mostrarse en pantalla, 
;actualizándose el valor cada segundo
PIC EQU 20H ;se definen las constantes
TIMER EQU 10H
N_F10 EQU 10
N_CLK EQU 15


ORG 40 ;--------------------------------------------------
IP_F10 DW RUT_F10

ORG 60
IP_CLK DW RUT_CLK

ORG 1000H
num DB ?
=======
;15) Escribir un programa que implemente un conteo regresivo a partir de un valor ingresado desde el teclado. El conteo debe 
;comenzar al presionarse la tecla F10. El tiempo transcurrido debe mostrarse en pantalla, actualizándose el valor cada segundo
TIMER EQU 10H 
N_F10 EQU 10   ; ID interrupción F10
N_CLK EQU 15   ; ID interrupción TIMER
PIC EQU 20H 

ORG 1000H
NUM DB ?
flag db 0

SEG DB 30H  ; 1000h, 0
SEG_NEXT   DB 30H  ; 1001h es la unidad. No le pone nombre xq no es necesario, 
FIN DB ?    ; 1002h

ORG 40 
IP_F10 DW RUT_F10

ORG 60
IP_CLK DW RUT_CLK
>>>>>>> 0e89db1a22a6b00f68a9bc3a8b41ddf4019577fa


ORG 2000H  ;----------------------------------------------
CLI  
MOV AL, 0FEH ; en binario es 1111 1110
OUT PIC+1, AL 

MOV AL, N_F10 
OUT PIC+4, AL

MOV AL, 1
OUT TIMER + 1, AL

MOV AL, 0
OUT TIMER, AL

MOV AL, N_CLK
OUT PIC+5, AL

STI 

MOV BX, OFFSET num
INT 6

LAZO: JMP LAZO ; bucle infinito

; subrutinas-----------------------------------------------
ORG 3000H
<<<<<<< HEAD
RUT_F10: PUSH AX ; pusheo registro --> subrutina reusable

IN AL, PIC+1
CMP AL, 0FCH    ; 1111 1100
JZ DESHABILITAR

MOV AL, 0FCH 
OUT PIC+1, AL 
JMP FIN_F10

DESHABILITAR: MOV AL, 0FEH ;1111 1110
OUT PIC+1, AL
=======

; DESDE ACA HABILITO EL TIMER!!!!!!!!!
RUT_F10: PUSH AX
PUSH CX 
PUSH DX

;tengo que deshabilitar porq al volver al prog principal no puede haber interrup por timer

IN AL, PIC + 1   ; en AL pongo lo que contiene el IMR
MOV DL, 0FCH     ; hago esto xq sino el preview no me deja comparar 
CMP AL, DL
JNZ habilitar

MOV AL, 0FCH    ; 11111110-> deshabilito TIMER 
OUT PIC + 1, AL  ; IMR = PIC + 1 
JMP FIN_F10

habilitar: MOV AL, DL
OUT PIC + 1, AL

>>>>>>> 0e89db1a22a6b00f68a9bc3a8b41ddf4019577fa

FIN_F10: MOV AL, 20H
OUT PIC, AL

<<<<<<< HEAD
POP AX ; subrutina reusable

IRET ;----------------------------------------------------
=======
POP DX
POP CX
POP AX

IRET
>>>>>>> 0e89db1a22a6b00f68a9bc3a8b41ddf4019577fa


ORG 3500H

<<<<<<< HEAD
RUT_CLK: PUSH AX

LOOP: CMP NUM, 30H
JZ FIN_CLK

INT 7
DEC NUM
JMP LOOP

FIN_CLK: MOV AL, 0FEH ; deshabilito interrup por timer
OUT PIC+1, AL

MOV AL, 20H
=======
RUT_CLK: PUSH AX 

MOV SEG, CL       ; muevo al segundo el num ingresado
INT 7             ; lo imprime
DEC SEG           ; decremento el seg 

LOOP: CMP SEG, 30H ; si es 0, termino la cuenta regresiva
JZ SALTO           
RESET: INT 7       ; imprimo
DEC SEG
JMP LOOP

SALTO: MOV AL, 0FEH ;1111 1110 -> desactivo timer
OUT PIC+1, AL  ; IMR = PIC + 1

MOV AL, 0  ; CONT = 0
OUT TIMER, AL

MOV AL, 20H ; fin de interrupcion
>>>>>>> 0e89db1a22a6b00f68a9bc3a8b41ddf4019577fa
OUT PIC, AL

POP AX
IRET

<<<<<<< HEAD
=======



ORG 2000H

CLI ; habilito interrupciones

;configuracion del PIC 
MOV AL, 0FEH     ; 11111110-> habilito F10, TIMER desde subrutina
OUT PIC + 1, AL  ; IMR = PIC + 1 

;configuracion de F10 
MOV AL, N_F10    ; mando ID de la interrupción por F10
OUT PIC + 4, AL  ; INT0 = PIC + 4

;configuracion del TIMER 
MOV AL, 1        ; cada un seg muestro en pantalla el tiempo 
OUT TIMER + 1, AL  ; PIC + 1 = COMP 

MOV AL, 0
OUT TIMER, AL      ; PIC = CONT

MOV AL, N_CLK    ; mando ID de la interrupción por TIMER
OUT PIC + 5, AL           ; INT1 = PIC + 5

STI

MOV BX, OFFSET NUM
INT 6
MOV CL, [BX]

MOV AL, OFFSET FIN - OFFSET SEG ; imprime 2 caracteres 
MOV BX, OFFSET SEG     ; muevo el num ingresado a CH


LAZO: JMP LAZO

INT 0 
>>>>>>> 0e89db1a22a6b00f68a9bc3a8b41ddf4019577fa
END
