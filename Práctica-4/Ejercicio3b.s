.data
A: .word 1
B: .word 6
tabla: .word 0
.code
ld r1, A(r0)
ld r2, B(r0)


sd r1, tabla(r0)
daddi r5, r5, 1


loop: dsll r1, r1, 1
daddi r2, r2, -1
bnez r2, loop
halt