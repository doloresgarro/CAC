;  Modifique el programa de modo que las coordenadas y color del punto sean 
;  ingresados por teclado.

.data

;coorX: .byte 24 ; coordenada X de un punto
;coorY: .byte 24 ; coordenada Y de un punto
;color: .byte 255, 0, 255, 0 ; color: máximo rojo + máximo azul => magenta
CONTROL: .word32 0x10000
DATA: .word32 0x10008

.text

lwu $s6, CONTROL(r0)           ; $s6 = dirección de CONTROL
lwu $s7, DATA(r0)              ; $s7 = dirección de DATA

daddi $t0, $0, 7               ; CONTROL = 7 -> limpiar pantalla gráfica
sd $t0, 0($s6)               

daddi $s0, $0, 8 
sd $s0, 0($s6)                 ; CONTROL = 8 --> ingresa int

lbu $s0, 0($s7)                ; $s0 = guardo num ingresado
sb $s0, 5($s7)                 ; DATA+5 recibe el valor de coordenada X

daddi $s0, $0, 8
sd $s0, 0($s6)                 ; CONTROL = 8 --> ingresa int

lbu $s1, 0($s7)                 ; $s1 = guardo num ingresado
sb $s1, 4($s7)                 ; DATA+4 recibe el valor de coordenada Y


daddi $s0, $0, 8
sd $s0, 0($s6)                 ; CONTROL = 8 --> ingresa int

lwu $s2, 0($s7)                 ; $s2 = guardo num ingresado
sb $s2, 0($s7)                 ; DATA recibe el valor del color a pintar

daddi $s0, $0, 8
sd $s0, 0($s6)                 ; CONTROL = 8 --> ingresa int

lwu $s2, 0($s7)                 ; $s2 = guardo num ingresado
sb $s2, 2($s7)                 ; DATA recibe el valor del color a pintar

            
daddi $t0, $0, 5               ; $t0 = 5 -> función 5: salida gráfica
sd $t0, 0($s6)                 ; CONTROL recibe 5 y produce el dibujo del punto


halt





