;10) Escribir un programa que cuente la cantidad de veces que un determinado 
;caracter aparece en una cadena de texto. Observar cómo se almacenan en memoria 
;los códigos ASCII de los caracteres (código de la letra “a” es 61H). Utilizar 
;la instrucción lbu (load byte unsigned) para cargar códigos en registros. La 
;inicialización de los datos es la siguiente:


.data
cadena: .asciiz "adbdcdedfdgdhdid" ; cadena a analizar
car: .asciiz "d" ; caracter buscado
cant: .word 0 ; cantidad de veces que se repite el caracter car en caden

.code
dadd r1, r0, r0      ; para recorrer la cadena
lbu r2, car(r0)      ; en r2 cargo car
daddi r3, r3, 16     ; dimL: hay alguna forma de calcularla para no contar?
dadd r5, r0, r0      ; contador de cant veces q se repite car

loop: lbu r4, cadena(r1)   ; en r4 cargo elemento de cadena
bne r2, r4, salta		   ; si r2 es distinto de r4 salta
daddi r5, r5, 1            ; incremento contador
salta: daddi r1, r1, 1     ; avanzo en tabla
daddi r3, r3, -1           ; disminuyo dimL
bnez r3, loop              ; si no se termina la cadena salta a loop 

sd r5, cant(r0)            ; almaceno en memoria el resultado
nop
halt