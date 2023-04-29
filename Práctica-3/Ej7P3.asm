HAND EQU 40H

ORG 1000H

MSJ DB "INGENIERIA E "
DB "INFORMATICA"
FIN DB ?

ORG 2000H

IN AL, HAND+1     ; pone en AL es estado
AND AL, 7FH       ; pone en 0 el estado
OUT HAND+1, AL   

MOV BX, OFFSET MSJ
MOV CL, OFFSET FIN-OFFSET MSJ

; consulta de estado 
POLL: IN AL, HAND+1  
AND AL, 1
JNZ POLL

MOV AL, [BX]   ; primer car 
OUT HAND, AL   ; lo manda al buffer

INC BX
DEC CL
JNZ POLL
INT 0
END


; si la impresora es muy lenta,
; si no hay consulta de estado se pueden perder caracteres
; debido a que la CPU le envia datos y capaz el buffer esta lleno 