;Escribir un programa que implemente el siguiente fragmento escrito en un lenguaje 
;de alto nivel:
;	while a > 0 do begin
; 		x := x + y;
;		a := a - 1;
;	end
;Ejecutar con la opción Delay Slot habilitada

.data
x: .word 2
y: .word 3
a: .word 2
res: .word 0

.code
ld r1, x(r0)
ld r2, y(r0)
ld r3, a(r0)

loop: beqz r3, FIN    ; si a es 0 termina
dadd r1, r1, r2   ; x = x + y
daddi r3, r3, -1  ; a = a - 1
j loop

FIN: sd r1, res(r0)
halt