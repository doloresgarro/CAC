.data
CONTROL: .word 0x10000
DATA: .word 0x10008
msjBase: .asciiz "Ingrese base "
msjExp: .asciiz "Ingrese exponente "
uno: .double 1

.code
lwu $s0, CONTROL($0)
lwu $s1, DATA($0)

daddi $t0, $0, msjBase
sd $t0, 0($s1)           ; DATA --> direc del msj

daddi $t0, $0, 4         
sd $t0, 0($s0)           ; CONTROL = 4 --> imprime msj

daddi $t0, $0, 8
sd $t0, 0($s0)           ; CONTROL = 8 --> ingresar num flotante

l.d f1, 0($s1)           ; f1 = dato ingresado (base)

daddi $t0, $0, msjExp 
sd $t0, 0($s1)           ; DATA --> direc del msj  

daddi $t0, $0, 4 
sd $t0, 0($s0)           ; CONTROL = 4 --> imprime msj

daddi $t0, $0, 8        
sd $t0, 0($s0)           ; CONTROL = 8 --> ingresar int sin signo

ld $t1, 0($s1)           ; en $t1 = dato ingresado (exponente)

; f1 --> base
; $t1 --> exponente
jal a_la_potencia

;dadd $v0, $0, f1         ; paso resultado a $v0
s.d f0, 0($s1)           ; DATA = result

daddi $t0, $0, 3         
sd $t0, 0($s0)           ; CONTROL = 3 --> imprime num flotante


halt


;----------------------------------------------------------------

a_la_potencia: l.d f0, uno($0)
beqz $t0, FIN             ; si mi exp es 0 termina

LOOP: mul.d f0, f0, f1  
daddi $t1, $t1, -1
bnez $t1, LOOP      


FIN: jr $ra 



