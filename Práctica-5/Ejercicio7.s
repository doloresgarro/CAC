; 7) Escriba una subrutina que reciba como parámetros un número 
; positivo M de 64 bits, la dirección del comienzo de una 
; tabla que contenga valores numéricos de 64 bits sin signo y la 
; cantidad de valores almacenados en dicha tabla.

; La subrutina debe retornar la cantidad de valores mayores que M 
; contenidos en la tabla.

.data
M: .word 4
tabla: .word 1, 2, 3, 4, 5
dimL: .word 5
result: .word 0

.code ; o .text? 
ld $a0, M($0)
ld $a1, tabla($0)
ld $a2, dimL($0)

jal MAYORES
sd $v0, result($0)
halt

; SUBRUTINA
MAYORES: dadd $v0, $0, $0

loop: slt $t0, $a0, $a1      ; si M < elem --> $t1 = 1
beqz $t1, salta              ; si $t1 = 0 salta 
daddi $v0, $v0, 1            ; si $t1 = 1 --> inc contador 
salta: daddi $a1, $a1, 1  
ld $a1, tabla($a1)           ; avanzo en tabla
daddi $a2, $a2, -1           ; disminuyo dimL
bnez $a2, loop               ; si dimL no es 0 --> loop  

jr $ra                        ; ret
