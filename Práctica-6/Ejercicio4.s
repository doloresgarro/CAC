.data
CONTROL: .word 0x10000
DATA: .word 0x10008
mensaje: .asciiz "Ingrese un caracter "
clave: .asciiz "hola"
ingresada: .asciiz 0
mensaje1: .asciiz "Bienvenido"
mensaje2: .asciiz "Error"

.code 
lwu $s0, CONTROL($0)
lwu $s1, DATA ($0)


daddi $t3, $0, ingresada   ; paso direc de ingresada a $t3

dadd $t5, $0, $0
daddi $t0, $0, 4       ; cant de veces q voy a llamar a ingreso
LOOP: jal INGRESO
daddi $t0, $t0, -1
bnez $t0, LOOP  ; si ya leyó 4 cars va a comparar las claves

salta: jal COMPARAR

HALT

INGRESO: daddi $t1, $0, mensaje
sd $t1, 0($s1)             ; DATA = direc de msj
daddi $t2, $0, 4 
sd $t2, 0($s0)             ; CONTROL = 4 --> imprime string

daddi $t2, $0, 9
sd $t2, 0($s0)             ; CONTROL = 9 --> lee un car

lbu $t4, 0($s1)             ; guardo en $t4 num q ingrese

sb $t4, ingresada($t5)   
daddi $t5, $t5, 1           ; voy inc 1 a la direc de ingresada


jr $ra

;Si las dos cadenas son iguales entre si, la subrutina llamada 
;respuesta mostrará el texto “Bienvenido” en la salida estándar del 
;simulador (ventana Terminal). En cambio, si las cadenas no son 
;iguales, la subrutina deberá mostrar “ERROR” y solicitar 
;nuevamente el ingreso de la clave.

COMPARAR: 

daddi $t0, $0, clave
daddi $t1, $0, ingresada
dadd $t2, $0, $0
daddi $t4, $t4, 4

loop: ld $t3, clave($t2)    ; guardo car de clave
ld $t4, ingresada($t2)      ; guardo car de ingresado
bne $t3, $t4, distintas     ; si no son iguales
daddi $t2, $t2, 1           ; aumento $t2 para avanzar en cadenas
daddi $t4, $t4, -1
bnez $t4, loop              ; si la diml no es 0 salta a loop         

; si llega aca es porq las cadenas son iguales
daddi $t0, $0, mensaje1
sd $t0, 0($s1)          ; DATA = direc de Bienvenido
daddi $t0, $0, 4        
sd $t0, 0($s0)          ; CONTROL = 4 --> imprime string

j FIN

distintas: daddi $t0, $0, mensaje2
sd $t0, 0($s1)          ; DATA = direc de Error
daddi $t0, $0, 4        
sd $t0, 0($s0)          ; CONTROL = 4 --> imprime string

FIN: jr $ra













