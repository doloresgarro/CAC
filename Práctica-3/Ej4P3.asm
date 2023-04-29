PIO EQU 30H
 ORG 1000H
MSJ DB "CONCEPTOS DE "
 DB "ARQUITECTURA DE "
 DB "COMPUTADORAS"
FIN DB ?

 ORG 2000H
 
 ; configuracion del PIO
 ; 1111 11SB --> S STROBE, B Busy
 MOV AL, 0FDH ; 1111 1101 --> 0 xq strobe es de salida y el busy es de entrada 
 
 OUT PIO+2, AL ; indicar q es de entrada 
 MOV AL, 0
 OUT PIO+3, AL  ; para indicar de salida
 
 ; pone el strobe del PIO en 0
 IN AL, PIO 
 AND AL, 0FDH ; 1111 1101
 OUT PIO, AL ; FIN INICIALIZACION
 
 
 MOV BX, OFFSET MSJ
 MOV CL, OFFSET FIN-OFFSET MSJ
 
; POLL --> CONSULTA DE ESTADO
POLL: IN AL, PIO ; xxxx xxxB
 AND AL, 1       ; si el ult es 1 sigue ocupada, sino sale del loop
 JNZ POLL        ; si esta ocupado salta hasta que la impresora se desocupe 
 
 MOV AL, [BX]    ; copia en AL car de la cadena
 OUT PIO+1, AL   ; le manda a PB la info a imprimir
 
 ; pone el strobe del PIO en 1
 IN AL, PIO ; PULSO 'STROBE'
 OR AL, 02H ; 0000 0010 
 OUT PIO, AL
 
 ; pone el strobe del PIO en 0
 IN AL, PIO
 AND AL, 0FDH
 OUT PIO, AL ; FIN PULSO
 
 INC BX
 DEC CL
 JNZ POLL
 INT 0
 END