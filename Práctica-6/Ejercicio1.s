.data

texto: .asciiz 0    ; El mensaje a mostrar
CONTROL: .word32 0x10000
DATA: .word32 0x10008


.text

lwu $s0, DATA(r0)             ; $s0 = dirección de DATA
lwu $s1, CONTROL(r0)          ; $s1 = dirección de CONTROL

daddi $s3, $0, 13             ; ASCII del ENTER --> p terminar de ingresar

LOOP: daddi $t0, $zero, 9     ; para ingresar desde teclado una cadena de car
sd $t0, 0($s1)                ; CONTROL recibe 9 

lbu $t0, 0($s0)               ; tomo caracter que ingrese
beq $t0, $s3, FIN

sb $t0, texto($0)             ; lo guardo en la variable

daddi $t0, $0, texto          ; $t0 = dirección del mensaje a mostrar
sd $t0, 0($s0)                ; DATA recibe el puntero al comienzo del msj

;daddi $t0, $0, 6              ; $t0 = 6 -> función 6: limpiar pantalla alfanum
;sd $t0, 0($s1)                ; CONTROL recibe 6 y limpia la pantalla

daddi $t0, $0, 4              ; $t0 = 4 -> función 4: salida de cadena ASCII
sd $t0, 0($s1)                ; CONTROL recibe 4 y produce la salida mensaje

J LOOP

FIN: halt