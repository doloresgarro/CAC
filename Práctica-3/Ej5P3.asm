PIO EQU 30H

ORG 1000H
NUM_CAR DB 5
CAR DB ?
; SUBRUTINA DE INICIALIZACION ; SUBRUTINA DE GENERACIÓN
; PIO PARA IMPRESORA ; DE PULSO 'STROBE'
ORG 3000H 

INI_IMP: MOV AL, 0FDH ; 1111 1101
OUT PIO+2, AL         ; STROBE en 0, busy en 1   

MOV AL, 0             ; 
OUT PIO+3, AL         ; CB se pone en 0
IN AL, PIO 
AND AL, 0FDH 
OUT PIO, AL 
RET


ORG 4000H 
 ; pone el strobe del PIO en 1
 PULSO: IN AL, PIO ; PULSO 'STROBE'
 OR AL, 02H ; 0000 0010 
 OUT PIO, AL
 ; pone el strobe del PIO en 0
 IN AL, PIO
 AND AL, 0FDH
 OUT PIO, AL ; FIN PULSO
 RET
 
 ; PROGRAMA PRINCIPAL
ORG 2000H

PUSH AX
CALL INI_IMP
POP AX

MOV BX, OFFSET CAR  ; direc p leer
MOV CL, NUM_CAR     ; cantidad de veces que hace el lazo

LAZO: INT 6
; cosulta de estado
POLL: IN AL, PIO
AND AL, 1
JNZ POLL

MOV AL, [BX]        ; copia el car a poner en el buffer 
OUT PIO+1, AL       ; lo pone en PB y lo manda al buffer

; STROBE
PUSH AX          
CALL PULSO
POP AX

DEC CL
JNZ LAZO

INT 0
END
