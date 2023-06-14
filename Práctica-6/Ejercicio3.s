;Escriba un programa que realice la suma de dos números enteros (de 
;un dígito cada uno) utilizando dos subrutinas: La 
;denominada ingreso del ejercicio anterior (ingreso por teclado de 
;un dígito numérico) y 
;otra denominada resultado, que muestre en la 
;salida estándar del simulador (ventana Terminal) el resultado 
;numérico de la suma de los dos números ingresados (ejercicio 
;similar al ejercicio 7 de Práctica 2)

.data 

CONTROL: .word 0x10000
DATA: .word 0x10008
mensaje: .asciiz "Ingrese un numero "


.code

lwu $s0, CONTROL($0)
lwu $s1, DATA($S0)

jal INGRESO    
beqz $v0, FIN
dadd $t1, $0, $v0       

jal INGRESO 
beqz $v0, FIN
dadd $t2, $0, $v0   

jal RESULTADO


FIN: HALT

;-------------------------------------------------------------------------------------------------------------------

INGRESO: daddi $t0, $0, mensaje   
sd $t0, 0($s1)
daddi $t0, $0, 4         ; CONTROL = 4 para imprimir   
sd $t0, 0($s0)

daddi $t0, $0, 9         ; CONTROL = 9 para ingresar un caracter  
sd $t0, 0($s0)  

ld $t0, 0($s1)           ; en $t0 --> me guardo el num q tiene DATA 

dadd $v0, $0, $0

; digitos en ASCII --> 48..57
slti $t1, $t0, 48       ; si es menor a 48 --> no es digito: $t1=1
bnez $t1, FIN         ; $t1 <> 0 salta
slti $t1, $t0, 57       ; si es menor a 57 --> es digito: $t1 = 1
beqz $t1, FIN           ; $t1 = 0 termina

daddi $t0, $t0, -47     ; si resto 48 noo anda no se xq
daddi $v0, $t0, 0



FIN: jr $ra


;-------------------------------------------------------------------------------------------------------------------

RESULTADO: dadd $v0, $0, $0
dadd $v0, $t1, $t2  ; sumo numeros ingresados       
sd $v0, 0($s1)              ; DATA = $t1 + $t2

daddi $t4, $0, 1
sd $t4, 0($s0)              ; CONTROL = 1 --> imprime entero con signo

;daddi $t4, $0, 6
;sd $t4, 0($s0)              ; CONTROL = 6 --> limpia pantalla

jr $ra



















