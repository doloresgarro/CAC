;Escribir un programa que implemente un conteo regresivo 
;a partir de un valor ingresado desde el teclado. El conteo 
;debe comenzar al presionarse la tecla F10.
;El tiempo transcurrido debe mostrarse en pantalla, 
;actualizándose el valor cada segundo
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

ORG 3000H

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


FIN_F10: MOV AL, 20H
OUT PIC, AL

POP DX
POP CX
POP AX

IRET


ORG 3500H

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
OUT PIC, AL

POP AX
IRET




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
END
