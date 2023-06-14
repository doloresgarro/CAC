; Escriba un programa que utilice sucesivamente dos subrutinas: La primera, 
;denominada ingreso, debe solicitar el ingreso por teclado de un número 
;entero (de un dígito), verificando que el valor ingresado realmente sea un 
;dígito.
;La segunda, denominada muestra, deberá mostrar en la salida estándar del 
;simulador (ventana Terminal) el valor del número ingresado expresado en 
;letras (es decir, si se ingresa un ‘4’, deberá mostrar ‘CUATRO’). Establezca 
;el pasaje de parámetros entre subrutinas respetando las convenciones para el 
;uso de los registros y minimice las detenciones del cauce (ejercicio similar 
;al ejercicio 6 de Práctica 2).

.data 

CONTROL: .word 0x10000
DATA: .word 0x10008
NUM:  .byte 0
uno: .asciiz "uno"
dos: .asciiz "dos"
tres: .asciiz "tres"
cuatro: .asciiz "cuatro"

.code

lwu $s0, CONTROL($0)
lwu $s1, DATA($S0)

jal INGRESO    
sd $v0, NUM($0)          ; en la direc de NUM guardo el numero que ingrese

jal MUESTRA


HALT

;-------------------------------------------------------------------------------------------------------------------

INGRESO: daddi $t0, $0, 9       
sd $t0, 0($s0)           ; CONTROL = 9 para ingresar un caracter
ld $t0, 0($s1)           ; en $t0 --> me guardo el num q tiene DATA (el q ingrese y voy a devolver al prog ppal)

dadd $v0, $0, $0

; digitos en ASCII --> 48..57
slti $t1, $t0, 48       ; si es menor a 48 --> no es digito: $t1=1
bnez $t1, salta         ; $t1 <> 0 salta
slti $t1, $t0, 57       ; si es menor a 57 --> es digito: $t1 = 1
beqz $t1, FIN           ; $t1 = 0 termina

daddi $v0, $0, 1        ; si es digito devuelve 1

FIN: jr $ra



;-------------------------------------------------------------------------------------------------------------------

MUESTRA: daddi $t1, $0, 1
daddi $t2, $0, 2
daddi $t3, $0, 3
daddi $t4, $0, 4

ld $a0, 0($s1)           ; en $a0 --> num q tiene DATA(ingresado)

bne $a0, $t1, salta      ; 
ld $t1, uno($0)          ; si es igual a 1 imprime "uno"
sd $t1, 0($s1)           ; a DATA le mando direc de uno
j imprime

salta: bne $a0, $t2, salta2      
ld $t2, dos($0)          ; si es igual a 2 imprime "dos"
sd $t2, 0($s1)           ; a DATA le mando direc de dos
j FIN

salta2: bne $a0, $t3, salta3     
ld $t3, tres($0)         ; si es igual a 3 imprime "tres"
sd $t3, 0($s1)           ; a DATA le mando direc de tres
J FIN

salta3: bne $a0, $t4, FIN
ld $t4, cuatro($0)       ; si es igual a 4 imprime "cuatro"
sd $t4, 0($s1)           ; a DATA le mando direc de cuatro

imprime: daddi $t0, $0, 4 
sd $t0, 0($s0)           ; CONTROL = 4 --> imprime cadena



FIN: jr $ra


