; 9) No recursivo
.data
valor: .word 3
result: .word 0

.text

daddi $sp, $0, 0x400       ; Inicializa el puntero al tope de la pila (1)
ld $a0, valor($0)          ; carga valor en $a0  

jal factorial              ; llama a subrutina
sd $v0, result($0)         ; almacena result en memoria
halt

; SUBRUTINA
factorial: dadd $s0, $a0, $zero            ; copio el valor 3 en s0
daddi $s1, $s0, -1              ; $s1 = 2
dmul $s0, $s0, $s1              ; $s0 = 3x2
daddi $s1, $s1, -1              ; $s1 = 1
dmul $s0, $s0, $s1              ; $s0 = 3x2x1

dadd $v0, $0, $s0 

jr $ra

