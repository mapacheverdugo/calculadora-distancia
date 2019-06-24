.data
uno: .double 1.0
dos: .double 2.0
msjA: .asciiz "Ingrese la distancia del punto A respecto al punto C: "
msjB: .asciiz "Ingrese la distancia del punto B respecto al punto C: "
msjR: .asciiz "La distancia entre los puntos A y B es de "
msjU: .asciiz " unidades"

# El .text donde van las instrucciones
.text
Main:
l.d $f20, uno		# Cargo en f20 la constante uno
l.d $f22, dos		# Cargo en f22 la constante dos

li $v0, 4     # Se imprimirá un mensaje
la $a0, msjA  # Configura el mensaje msjA
syscall       # Imprímelo

li $v0, 7          # Se solicitará al usuario un double
syscall            # Solicítalo
movf.d $f16, $f0   # Copia el valor leído ($f0) a $f16

li $v0, 4     # Se imprimirá un mensaje
la $a0, msjB  # Configura el mensaje msjB
syscall       # Imprímelo

li $v0, 7          # Se solicitará al usuario un double
syscall            # Solicítalo
movf.d $f18, $f0   # Copia el valor leído ($f0) a $f18

mul.d $f16, $f16, $f16   # A = A * A = A^2
mul.d $f18, $f18, $f18   # B = B * B = B^2
add.d $f0, $f16, $f18    # f0 = A^2 + B^2
movf.d $f12, $f0         # Copia el valor de $f0 a $f12

jal raiz      # Se salta a etiqueta raiz

li $v0, 4     # Se imprimirá un mensaje
la $a0, msjR  # Configura el mensaje msjR
syscall       # Imprímelo

li $v0, 3     # Se imprimirá un double
syscall       # Imprímelo

li $v0, 4     # Se imprimirá un mensaje
la $a0, msjU  # Configura el mensaje msjU
syscall       # Imprímelo

li $v0, 10    # Se terminará el programa
syscall       # Termínalo

raiz:
div.d $f6, $f0, $f12	  # f6 = f0 / f/12
add.d $f8, $f6, $f12	  # f8 = f6 + f12
div.d $f10, $f8, $f22	  # f10 = f8 / 2
c.eq.d $f10, $f12	      # Si f10 == f12 se ejecuta lo que haya en bc1t
bc1t fin		          # Salto a fin
# Si no cae en la condición
movf.d $f12, $f10	      # Copio el valor de f10 en f12
j raiz			      # Salto a raiz

fin:
jr $ra
