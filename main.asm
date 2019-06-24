# El .data es donde van las constantes
.data
uno: .double 1.0
dos: .double 2.0
cuatro: .double 4.0
ocho: .double 8.0

# El .text donde van las instrucciones
.text
main:
l.d $f20, uno		# Cargo en f20 la constante uno
l.d $f22, dos		# Cargo en f22 la constante dos
l.d $f24, cuatro	# Cargo en f24 la constante cuatro
l.d $f28, ocho		# Cargo en f28 la constante ocho

li $t0, 4		# t0 = 4 para el contador del loop
jal pi			# Salto a pi

# Cuando pi termine
li $v0, 10		# Cargo la función de sistema 10 (Terminar el programa)
syscall			# La ejecuto

pi:
movf.d $f0, $f22	# Copio el valor de f22 en f0
movf.d $f12, $f22	# Copio el valor de f22 en f12
jal raiz		# Salto a raiz

# Cuando termine raiz
li $v0, 3		# Cargo la función de sistema 3 (Imprimir el double en $f12)
syscall			# La ejecuto

mul.d $f2, $f12, $f24	# f2 = A = raiz(2)*4
movf.d $f4, $f28	# f4 = B = 8
j pi_loop		# Salto a pi_loop
jr $ra

# Cuando termine pi_loop
div.d $f2, $f2, $f22	# f2 = A/2
div.d $f4, $f4, $f22	# f4 = B/2
add.d $f0, $f2, $f4	# f0 = A/2 + B/2
div.d $f0, $f0, $f22	# f0 = (A/2 + B/2)/2
movf.d $f12, $f0	# Copio el valor de f0 en f12

li $v0, 3		# Cargo la función de sistema 3 (Imprimir el double en $f12)
syscall			# La ejecuto

jr $ra			# Termino pi y vuelvo a la funcion que la llamó

pi_loop:
add.d $f6, $f2, $f4	# f6 = A+B
mul.d $f8, $f2, $f4	# f8 = A*B
mul.d $f8, $f8, $f22	# f8 = 2*A*B
div.d $f4, $f8, $f6	# f2 = B = 2*A*B/(A+B)

mul.d $f0, $f0, $f2	# f0 = A*B
movf.d $f12, $f0	# f12 = A*B
jal raiz		# f12 = raiz(A*B)

li $v0, 3		# Cargo la función de sistema 3 (Imprimir el double en $f12)
syscall			# La ejecuto

movf.d $f2, $f12	# f2 = A = raiz(A*B)
li $t2, 2		# t2 = 2
mul $t0, $t0, $t2	# t0 = t0 * t2
bgt $t0, 1234, fin
j pi_loop

raiz:
div.d $f6, $f0, $f12	# f6 = f0 / f/12
add.d $f8, $f6, $f12	# f8 = f6 + f12
div.d $f10, $f8, $f22	# f10 = f8 / 2
c.eq.d $f10, $f12	# Si f10 == f12 se ejecuta lo que haya en bc1t
bc1t fin		# Salto a fin

# Si no cae en la condición
movf.d $f12, $f10	# Copio el valor de f10 en f12
j raiz			# Salto a raiz

fin:
jr $ra		# Termino fin y vuelvo a la funcion que la llamó



