; 8) Escriba una subrutina que reciba como parámetros las 
;direcciones 
; del comienzo de dos cadenas terminadas en cero y retorne la 
; posición en la que las dos cadenas difieren. En caso de que las 
; dos cadenas sean idénticas, debe retornar -1.

.data
cadena1: .word 1,2,5,4,0
cadena2: .word 1,2,3,4,0
;dimL: .word 5
result: .word 0

.code
daddi $a0, $0, cadena1
daddi $a1, $0, cadena2
;ld $a3, dimL(r0)

jal SUBRUTINA
sd $v0, result(r0)
halt

SUBRUTINA: dadd $v0, $0, $0   ; $v0 --> pos donde dejan de ser =
dadd $s0, $a0, $zero          ; para no perder la direc de cad1
dadd $s1, $a1, $zero          ; para no perder la direc de cad2

LOOP: ld $t0, 0($s0)          ; $t0 --> elem de la cad1
ld $t1, 0($s1)                ; $t1 --> elem de la cad2
beqz $t0, fin
beqz $t1, fin
bne $t0, $t1, fin            ; si $t0 <> $t1 fin
daddi $s0, $s0, 8            ; avanzo en tablas
daddi $s1, $s1, 8 
j LOOP 

fin: dadd $v0, $0, $s0        ; $v0 --> pos en la que $t0 <> $t1
jr $ra                        ; ret

