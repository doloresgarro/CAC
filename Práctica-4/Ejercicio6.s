;Escribir un programa que lea tres números enteros A, B y C de la memoria de 
;datos 
;y determine cuántos de ellos son iguales entre sí (0, 2 o 3).
;El resultado debe quedar almacenado en la dirección de memoria D

;que lea de la mem de datos se refiere a que este almacenado en mem y lo pase a
;un registro?

; capaz se puede hacer recorriendo como si fuera una tabla? 

.data 
A: .word 3
B: .word 3
C: .word 3
D: .word 0

.code
ld r1, A(r0)      
ld r2, B(r0)
ld r3, C(r0)
dadd r4, r0, r0

bne r1, r2, sigue            ; si r1 distinto r2
daddi r4, r4, 1              ; si son iguales sumo 1 a la cantidad
sigue: bne r1, r3, salta     ; si r1 distinto r3
daddi r4, r4, 1              ; si son iguales sumo 1 a la cantidad
salta: bne r2, r3, FIN       ; si r2 disitinto r3
daddi r4, r4, 1              ; si son iguales sumo 1 a la cantidad

FIN: sd r4, D(r0)            ; almaceno en memoria la cantidad de num iguales
halt

