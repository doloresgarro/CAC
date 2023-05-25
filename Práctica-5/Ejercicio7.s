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

; PARÁMETROS
ld $a0, M($0)
daddi $a1, $0, tabla        ; le paso la direc de la cadena
ld $a2, dimL($0)            ; le pasamos DIML 

jal MAYORES
sd $v0, result($0)
halt

; SUBRUTINA

MAYORES: dadd $s0, $a1, $zero  ; para no perder la direc de tabla

loop: ld $a1, 0($s0)         ; guardo elem de tabla

slt $t0, $a0, $a1            ; si M < elem --> $t0 = 1
beqz $t0, salta              ; si $t1 = 0 salta 
daddi $v0, $v0, 1            ; si $t1 = 1 --> inc contador 

salta: daddi $s0, $s0, 8     ; avanzo en tabla  
ld $a1, tabla($a1)           ; avanzo en tabla
daddi $a2, $a2, -1           ; disminuyo dimL
bnez $a2, loop               ; si dimL no es 0 --> loop  

jr $ra                        ; ret




