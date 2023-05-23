; 3) Escribir un programa que calcule la superficie de un triángulo 
; rectángulo de base 5,85 cm y altura 13,47 cm.
; Pista: la superficie de un triángulo se calcula como: 

.data 
base: .double 5.85
altura: .double 13.47
sup: .double 0.0

.code 
l.d f1, base(r0)      ; cargo la base en f1
l.d f2, altura(r0)    ; cargo la altura en f2
daddi r1, r0, 2       ; cargo 2 en f3 para dividir

mtc1 r1, f3           ; copia el 2 en un registro flotante     
cvt.d.l f3, f3        ; convierte 2 a flotante


mul.d f4, f1, f2      ; b*a lo guardo en f3
div.d f5, f4, f3      ; b*a dividido 2

s.d f5, sup(r0)       ; almaceno en memoria el resultado

halt