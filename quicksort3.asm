.data
	array: .word 37, 29, 46, 13, 0, 28, 1, 38, 22, 6, 123, 11, 458, 111, 27, 2, 25, 14, 13, 15, 13, 33, 30, 45, 16, 17, 18, 19, 20, 24, 34, 0, 0, 28, 61, 31, 91, 92, 97, 23, 1, 0, 32, 44, 66, 67, 55, 12, 1, 7 #array porra
	espaco: .asciiz " " #isso serve pra depois imprimir os numeros com espaço
.text
	la $a0, array

quicksort:
	# $a0 = v 
	# $a1 = p		
	# $a2 = r
	# $a3 = retorno da função separa
	# $t0 = j	
	# $t1 = auxiliar do if
	
	
	slt $t1, $a1, $a2 # condição 
	bne $t1, $zero, if#
	j fim_quicksort
	
if:	
	move $t0, $a3	