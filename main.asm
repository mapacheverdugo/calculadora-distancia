.data
valor: .float 32.0
dos: .float 2.0

.text
main:
li $t0, 1	# Se define t0 como contador iniciado en 1
lwc1 $f0, valor
lwc1 $f12, valor
l.s $f29, dos	
jal raiz
	

# f12 = X_n	-> Iteración actual o promedio
# f0 = input
# f1 = f(x)/X_n -> Cociente
# f2 = f2 + f1

imprimirYTerminar:

li $v0, 2
syscall

li $v0, 10
syscall

raiz:
beq $t0, 4, imprimirYTerminar
div.s $f1, $f0, $f12
add.s $f2, $f1, $f12
div.s $f12, $f2, $f29
addi $t0, $t0, 1
j raiz
