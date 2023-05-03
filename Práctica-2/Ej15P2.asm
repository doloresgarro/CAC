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
RUT_F10: PUSH AX ; pusheo registro --> subrutina reusable

IN AL, PIC+1
CMP AL, 0FCH    ; 1111 1100
JZ DESHABILITAR

MOV AL, 0FCH 
OUT PIC+1, AL 
JMP FIN_F10

DESHABILITAR: MOV AL, 0FEH ;1111 1110
OUT PIC+1, AL

FIN_F10: MOV AL, 20H
OUT PIC, AL

POP AX ; subrutina reusable

IRET ;----------------------------------------------------


ORG 3500H

RUT_CLK: PUSH AX

LOOP: CMP NUM, 30H
JZ FIN_CLK

INT 7
DEC NUM
JMP LOOP

FIN_CLK: MOV AL, 0FEH ; deshabilito interrup por timer
OUT PIC+1, AL

MOV AL, 20H
OUT PIC, AL

POP AX
IRET

END
