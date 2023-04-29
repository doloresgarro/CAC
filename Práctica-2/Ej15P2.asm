;15) Escribir un programa que implemente un conteo regresivo a partir de un valor ingresado desde el teclado. El conteo debe 
;comenzar al presionarse la tecla F10. El tiempo transcurrido debe mostrarse en pantalla, actualizándose el valor cada segundo

TIMER EQU 10H
PIC EQU 20H
EOI EQU 20H
N_F10 EQU 9
N_CLK EQU 10

ORG 36
IP_F10 DW RUT_F10 
ORG 40 
IP_CLK DW RUT_CLK

ORG 1000H
SEG DB 30H
SEG_NEXT DB 30H ; 0
DB " "
FIN DB ?

ORG 3000H
RUT_F10: PUSH AX
IN AL, PIC+1 ;traigo estado del IMR
CMP AL, 0FCH ; verifico si esta habilitado el timer
JZ DESHABILITAR ;si esta habilitado lo deshabilito
MOV AL, 0FCH 
OUT PIC+1, AL  ;si esta deshabilitado lo habilito (ahora timer puede interrumpir)
JMP END_F10
DESHABILITAR: MOV AL, 0FEH
OUT PIC+1, AL
END_F10: MOV AL, EOI
OUT PIC, AL
POP AX
IRET


RUT_CLK: PUSH AX
; SEG = 0, segundo digito del seg
; SEG_NEXT = 0, primer digito del seg
INC SEG_NEXT ; 1
CMP SEG_NEXT, 3AH ; si pasa el digito (9)
JNZ RESET ; si son iguales, imprime ult dig

MOV SEG_NEXT, 30H ; le pongo 0
INC SEG ; 1 
CMP SEG, 33H ; comparo con 3 para ver si ya llego a 30 segs
JNZ RESET ; si no son iguales, todavia no llego a 30 entonces imprime

INT 7 ;si llego a 30 segundos
MOV SEG, 30H ; 0
MOV AL, 0FEH ;deshabilito timer
OUT PIC+1, AL 
JMP ELSE 

RESET: INT 7 
ELSE: MOV AL, 0

OUT TIMER, AL
MOV AL, EOI
OUT PIC, AL 
POP AX 
IRET 

ORG 2000H 

CLI

; configuracion del PIC
MOV AL, 0FCH  ; 1111 1100 acitvo timer y F10 1111 1100
OUT PIC+1, AL ; PIC + 1 = IMR = 1111 1100

MOV AL, N_CLK ; direc subrutina TIMER
OUT PIC + 5, AL ; PIC + 5 = INT1

MOV AL, N_F10 ; direc subrutina F10
OUT PIC + 4, AL ; PIC + 4 = INT0

; configuracion del TIMER
MOV AL, 1     ; TIMER + 1 = COMP
OUT TIMER + 1, AL  ; 

MOV AL, 0     ;
OUT TIMER, AL ;  TIMER = CONT

MOV BX, OFFSET SEG ;cargo direccion de segundos para INT 7
MOV AL, OFFSET FIN - OFFSET SEG 
STI 
LAZO: JMP LAZO 
END 
