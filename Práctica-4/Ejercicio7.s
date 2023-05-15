;Escribir un programa que recorra una TABLA de diez números enteros y determine 
;cuántos elementos son mayores que X. El 
;resultado debe almacenarse en una dirección etiquetada CANT. El programa debe 
;generar además otro arreglo llamado RES 
;cuyos elementos sean ceros y unos. Un ‘1’ indicará que el entero 
;correspondiente en el arreglo TABLA es mayor que X, mientras que un ‘0’ 
;indicará que es menor o igual.


.data
tabla: .word 1, 5, 10, 4, 5, 6, 7, 2, 2, 1
dimL: .word 10           ; dimL de la tabla
X: .word 5               ; elem para comparar si es mayor o menor
CANT: .word 0            ; elem para contar los mayores a X
RES: .word 0             ; arreglo de ceros y unos

.code 
dadd r1, r0, r0          ; para avanzar en tablas
ld r6, dimL(r0)          ; dimL tablas
dadd r2, r0, r0          ; contador para contar mayores a X
ld r3, X(r0)             ; r3 --> elem para comparar 
daddi r7, r7, 1

loop: ld r4, tabla(r1)   ; r4 --> primer elem de tabla
slt r5, r3, r4           ; si r3 < r4 --> r5 = 1 (el elem es mayor)
bne r5, r7, salta 
daddi r2, r2, 1          ; si r5 = 1 --> incrementa r2 (contador)
salta: sd r5, RES(r1)    ; almacena en la pos de RES 0 o 1
daddi r1, r1, 8          ; avanzo en tablas
daddi r6, r6, -1         ; disminuyo DIML
bnez r6, loop            ; si no se terminan las tablas, salta a loop

sd r2, CANT(r0)          ; almaceno contador de mayores a X en cant

nop
halt




