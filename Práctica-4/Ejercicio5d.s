;5) d- Modificar el programa para aprovechar el ‘Delay Slot’ ejecutando una 
;instrucción útil. Simular y comparar número de ciclos, instrucciones y CPI 
;obtenidos con los de la versión anterior.
; NO SE

.data
cant: .word 8
datos: .word 1, 2, 3, 4, 5, 6, 7, 8
res: .word 0

.code
dadd r1, r0, r0          ; pone r1 en 0
ld r2, cant(r0)          ; dimL?

loop: ld r3, datos(r1)   ; en r3 carga primer elem de tabla 
daddi r2, r2, -1         ; disminuye dimL
dsll r3, r3, 1           ; rota a la izq 1 
sd r3, res(r1)           ; lo almacena en memoria 
daddi r1, r1, 8          ; avanza en la tabla
bnez r2, loop            ; si no se termina la tabla sigue
;nop                      ; período de parada
halt

