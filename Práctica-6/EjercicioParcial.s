.data 
X: .byte 5
Y: .byte 5
CONTROL: .word 0x10000
DATA: .word 0X10008
color: .byte 0, 255, 0, 0

.code
lwu $s0, CONTROL($0)
lwu $s1, DATA($0)

daddi $t0, $0, 8
sd $t0, 0($s0)
ld $t1, 0($s1)      ; base

daddi $t0, $0, 8
sd $t0, 0($s0)
ld $t2, 0($s1)      ; altura

lwu $t3, color($0)
sw $t3, 2($s1)      ; data+2 = verde

jal ALTURA
jal BASE
jal ALTURA
jal BASE

HALT

ALTURA: dadd $t6, $0, $0 
dadd $t7, $0, $t2      ; altura

LOOPA: lbu $t4, Y($0)
sb $t4, 4($s1)

lbu $t5, X($t6) 
sb $t6, 5($s1)          ; data+5 = color

daddi $t8, $0, 5
sd $t8, 0($s0)          ; pinta pixel

daddi $t6, $t6, 1
daddi $t7, $t7, -1
bnez $t7, LOOPA

jr $ra

BASE: dadd $t6, $0, $0 
dadd $t7, $0, $t1      ; base

LOOPB: lbu $t4, X($0)
sb $t4, 5($s1)
lbu $t5, Y($t6) 
sb $t6, 4($s1)          ; data+4 = color

daddi $t8, $0, 5
sd $t8, 0($s0)          ; pinta pixel

daddi $t6, $t6, 1
daddi $t7, $t7, -1
bnez $t7, LOOPA

jr $ra




 
