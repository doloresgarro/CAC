TIMER EQU 10H
PIC EQU 20H
EOI EQU 20H
N_CLK EQU 10


ORG 40
IP_CLK DW RUT_CLK  ; ip_clk tiene la direc 3000H

ORG 1000H
SEG DB 30H  ; 1000h, 0
SEG_NEXT   DB 30H  ; 1001h es la unidad. No le pone nombre xq no es necesario, 
FIN DB ?    ; 1002h


ORG 3000H
RUT_CLK: PUSH AX ;

INC SEG_NEXT        ; incrementa la unidad
CMP SEG_NEXT, 3AH   ; compara unidad con el que le sigue al 9 en ASCII
JNZ RESET        ; si es igual es porq es decena

MOV SEG_NEXT , 30H   ; lo inicializa en 0 para imprima 10
INC SEG          ; 1 
CMP SEG, 36H     ; compara para ver si llego al minuto
JNZ RESET        ; si no llega imprime 
MOV SEG, 30H     ; lo inicializa en 0 xq 

RESET: INT 7    ; imprime numero 


MOV AL, 0       ; 
OUT TIMER, AL
MOV AL, EOI
OUT PIC, AL
POP AX
IRET


ORG 2000H

CLI

; CONFIGURACION DEL PIC
MOV AL, 0FDH  ; indica que se prende el timer -> 11111101               
OUT PIC+1, AL ; PIC: registro IMR, se prende timer
MOV AL, N_CLK ; en AL pone 10
OUT PIC+5, AL ; PIC: registro INT1 

; CONFIGURACION DEL TIMER

MOV AL, 1    ;  para que se dispare en 1 segundo
OUT TIMER + 1, AL ; TIMER + 1: registro COMP -> esta en la 11H
MOV AL, 0     ; para q cuente
OUT TIMER, AL ; TIMER: registro CONT -> esta en la 10H

MOV BX, OFFSET SEG ; tiene la direc del 0
MOV AL, OFFSET FIN-OFFSET SEG ; en AL se guarda 3
; entonces va a haber una interrupción cuando COMP = CONT =  1

STI

LAZO: JMP LAZO

INT 0
END