;Escribir un programa que multiplique dos números enteros utilizando sumas 
;repetidas (similar al Ejercicio 7 de la Práctica 1). 
;El programa debe estar optimizado para su ejecución con la opción Delay Slot 
;habilitada.

.data
num1: .word 5
num2: .word 5
res: .word 0

.code

dadd r1, r0, r0    ;
ld r2, num1(r0)    ; pongo en r2 el num 
ld r3, num2(r0)	 ; pongo en r3 la cant de veces q lo voy a multiplicar

loop: dadd r1, r1, r2 ; al num le sumo el mismo num
daddi r3, r3, -1      ; disminuyo cant de veces q quiero multiplicar
;slti r5, r3, 1        ; comp r3 con 1, xq si comparo con 0 me hace una vez mas
bnez r3, loop

sd r1, res(r0)        ; almcaceno en memoria el resultado

nop
halt
