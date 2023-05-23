;4)El índice de masa corporal (IMC) es una medida de asociación entre el peso 
;y la talla de un individuo. Se calcula a partir del peso (expresado en 
;kilogramos, por ejemplo: 75,7 kg) y la estatura (expresada en metros,
;por ejemplo 1,73 m), usando la fórmula: IMC = peso/(altura)^2

; Escriba un programa que dado el peso y la estatura de una persona calcule 
; su IMC y lo guarde en la dirección 
; etiquetada IMC. También deberá guardar en la dirección etiquetada estado 
;un valor según la siguiente tabla:

; IMC     Clasificación   Valor guardado
; < 18,5     Infrapeso          1
; < 25        Normal            2
; < 30      Sobrepeso           3
; ≥ 30        Obeso             4


.data
peso: .double 75.7
altura: .double 1.73
IMC: .double 0.0
estado: .word 0
tablaEstados: .word 1, 2, 3, 4
infrapeso: .double 18.5
normal: .double 25.0
sobrepeso: .double 30

.code 
l.d f1, peso(r0)
l.d f2, altura(r0)

; cálculo de IMC
mul.d f2, f2, f2    ; multiplico altura y la guardo en f2
div.d f3, f1, f2    ; f3 = peso/(altura)^2 = IMC

; cargo tabla de estados en registros 
ld r1, tablaEstados(r1)
ld r2, tablaEstados(r2)
ld r3, tablaEstados(r3)
ld r4, tablaEstados(r4)

; cargo valores en registros
l.d f4, infrapeso(r0)
l.d f5, normal(r0)
l.d f6, sobrepeso(r0)

; comparo para ver estado nutricional de la persona
c.lt.d f3, f6           ; si f3(IMC) < 30 --> FP = 1
bc1t NoObeso            ; si FP = 1  salta a NoObeso
sd r4, estado(r0)      ; si es mayor a 30 Obeso
j FIN

NoObeso: c.lt.d f3, f5  ; si f3(IMC) < 25 --> FP = 1
bc1t NoObeso            ; si FP = 1  salta
sd r3, estado(r0)      ; si es mayor a 25 sobrepeso
j FIN


NoSobrepeso: c.lt.d f3, f5  ; si f3(IMC) < 30 --> FP = 1
bc1t NoNormal           ; si FP = 1  salta
sd r2, estado(r0)      ; si es mayor a 18.5 normal
j FIN


NoNormal: sd r1, estado(r0)      ; infrapeso

FIN: s.d f3, IMC(r0)     ; almaceno resultado en memoria
halt

