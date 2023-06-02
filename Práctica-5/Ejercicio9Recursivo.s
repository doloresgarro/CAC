; 9) Recursivo
.data
valor: .word 3
result: .word 0

.text

daddi $sp, $0, 0x400     ; Inicializa el puntero al tope de la pila
ld $a0, valor($0)        ; carga valor en $a0  

jal factorial              ; llama a subrutina
sd $v0, result($0)         ; almacena result en memoria
halt

; SUBRUTINA
factorial: beq $a0, $0, FIN
daddi $sp, $sp, -8              ; reservo lugar en pila
sd $ra, 0($sp)                  ; guardo en pila direc de retorno

daddi $t0, $a0, -1
beqz $t0, salta                 ; si el num es 0 devuelve -1
daddi $sp, $sp, -8              ; reservo lugar en pila
sd $a0, 0($sp)                  ; guarda $a0 en pila

daddi $a0, $a0, -1              ; le resto 1
jal factorial

ld $a0, 0($sp)                  ; recupero valor de $a0
daddi $sp, $sp, 8               ; libera espacio en pila
dmul $v0, $v0, $a0
j fin

salta: daddi $v0, $0, 1        

FIN: ld $ra, 0($sp) 
daddi $sp, $sp, 8

jr $ra




               ; guardo en pila $s0