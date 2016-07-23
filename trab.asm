.data
	array: .word 37, 29, 46, 13, 0, 28, 1, 101, 60, 12 #array
	array2: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #array para o qual vão ser copiados os valores do primeiro array 
	espaco: .asciiz " "
	bubble: .asciiz "BubbleSort:"
	quick: .asciiz "QuickSort:"	
.text
############################################################### Inicializa os valores necessários para o Bubble Sort ##############################################################
			     	
	la $a0, array                #associa o endereço inicial do array com o registrador $ra
	la $a2, array2
	la $a3, espaco               #associa o endereço do espaço com o registrador $a3
	addi $a1, $zero, 10          #quantidade de elementos do array
	
############################################################### Copia os valores de um array para o outro #########################################################################			     		

	add $t0, $zero, $zero        #$t0 = 0
	addi $t2, $zero, 10          # valor até o qual o for vai 
	add $t3, $zero, $zero        #valor inicial da variável contadora
	move $s2, $a0                #$s2 = endereço inicial do vetor1
	move $s3, $a2 		     #$s3 = endereço inicial do vetor2

loop_copia_arrays:
	lw $t0, 0($s2)		     # passa o valor de um array pro outro
	sw $t0, 0($s3)
	
	
	addi $s2, $s2, 4             #vai para a próxima posição do vetor
	addi $s3, $s3, 4             #vai para a próxima posição do vetor
	addi $t3, $t3, 1             #incrementa um no contador
	slt  $t4, $t3, $t2           # ve se o contador ainda é menor
	bne $t4, $zero, loop_copia_arrays # se ainda for menor retorna no loop de impressão
	
	move $t0, $zero              #restaura os valores originais dos registradores usados antes de ir para a função sort
	move $t2, $zero
	move $t3, $zero	
	move $s2, $zero
	move $s3, $zero		
	
	j sort	                     #vai para a função de ordenação
	
############################################################### Função que faz troca de dois dados em um array ###################################################################	
troca:  sll  $t1, $a1, 2             #v = $a0, k =  $a1
	add  $t1, $a0, $t1           # $a0 e $a1 são parâmetros que eu passei pra troca
	
	lw   $t0, 0($t1)             # pega o valor da posição anterior da memória
	lw   $t2, 4($t1)             # pega o valor da posição atual da memória
	
	sw   $t2, 0($t1)             # guarda o valor na posição anterior
	sw   $t0, 4($t1)             #guarda o valor na posição posterior
	
	jr $ra
	
############################################################### Função de Ordenação Bubble Sort #############################################################################	

sort:   addi $sp, $sp, -20           #cria espaço na pilha pra 5 registradores	
	sw   $ra, 16($sp)            #salva $ra na pilha
	sw   $s3, 12($sp)            #salva $s3 na pilha
	sw   $s2, 8($sp)             #salva $s2 na pilha
	sw   $s1, 4($sp)             #salva $s1 na pilha
	sw   $s0, 0($sp)             #salva $s0 na pilha
						
	
	move $s2, $a0                #passa o parametro para que ele possa ser usado na função
	move $s3, $a1                #passa o parametro para que ele possa ser usado na função
	
	move $s0, $zero              #i = 0
for_ext:slt  $t0, $s0, $s3           #$t0 = 0 se (i >= n)
	beq  $t0, $zero, saida1      # vai para a saida se (i >= n)
	
	addi $s1, $s0, -1            #j = i-1
for_int: slti $t0, $s1, 0            # $t0 = 1 se (j < 0)
	bne  $t0, $zero, saida2      #vai pra saida2 se (j < 0)
	sll  $t1, $s1, 2             #$t1 = j*4
	add  $t2, $s2, $t1           #$t2 = v+(j*4)
	lw   $t3, 0($t2)             #$t3 = v[j]
	lw   $t4, 4($t2)             #$t4 = v[j+1]	  	
	slt  $t0, $t4, $t3           #$t0 = 0 se $t4 >= $t3
	beq  $t0, $zero, saida2      #vai pra saida2 se $t4 >= $t3
	
	move $a0, $s2                #1 parametro da função de troca é v
	move $a1, $s1                #2 parametro da função de troca é j
	jal troca                    #vai pra função de troca
	
	addi $s1, $s1, -1            #j = j-1
	j for_int                    #vai para o loop interno
	
saida2: addi $s0, $s0, 1             #i = i+1
	j for_ext                    #vai para o loop externo		
	
saida1: lw $s0, 0($sp)	             #restaura os valores da pilha
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $ra, 16($sp)
	addi $sp, $sp, 20            #restaura o pilha na posição inicial dela
	
############################################################### Impressão das ordenações no Console ############################################################################

	add $t0, $zero, $zero        #$t0 = 0
	addi $t2, $zero, 10          # valor até o qual o for vai
	move $t5, $a3 
	add $t3, $zero, $zero        #valor inicial da variável contadora
	move $s2, $a0                #$s2 = endereço inicial do vetor
		
	la $a0, bubble
	li $v0, 4
	syscall
	
	li $v0, 11 # imprime um espaço na tela
	addi $a0, $zero, 10
	syscall
		
loop_imprime: 	

	lw $t0, 0($s2)               #pega o valor do array e joga para o registrador
	li $v0, 1                    # indica para que o syscall realize a função de impressão de inteiro 
	move $a0, $t0                #passa o valor a ser escrito
	syscall                      #chama o syscall
	
	li $v0, 4                    # indica para que o syscall realize a função de impressão de string
	move $a0, $t5                # passa o endereço da string a ser impressa
	syscall                      # chama o syscall
			
	addi $s2, $s2, 4             #vai para a próxima posição do vetor
	addi $t3, $t3, 1             #incrementa um no contador
	slt  $t4, $t3, $t2           # ve se o contador ainda é menor
				
	bne $t4, $zero, loop_imprime # se ainda for menor retorna no loop de impressão
	
	li $v0, 11 # imprime um espaço na tela
	addi $a0, $zero, 10
	syscall
	
	add $t0, $zero, $zero        #$t0 = 0
	addi $t2, $zero, 10          # valor até o qual o for vai
	move $t5, $a3 
	add $t3, $zero, $zero        #valor inicial da variável contadora
	move $s2, $a2                #$s2 = endereço inicial do vetor
	
	
	la $a0, quick
	li $v0, 4
	syscall
	
	li $v0, 11 # imprime uma quebra de linha na tela
	addi $a0, $zero, 10
	syscall
	
		
loop_imprime2: 	

	lw $t0, 0($s2)               #pega o valor do array e joga para o registrador
	li $v0, 1                    # indica para que o syscall realize a função de impressão de inteiro 
	move $a0, $t0                #passa o valor a ser escrito
	syscall                      #chama o syscall
	
	li $v0, 4                    # indica para que o syscall realize a função de impressão de string
	move $a0, $t5                # passa o endereço da string a ser impressa
	syscall                      # chama o syscall
			
	addi $s2, $s2, 4             #vai para a próxima posição do vetor
	addi $t3, $t3, 1             #incrementa um no contador
	slt  $t4, $t3, $t2           # ve se o contador ainda é menor
				
	bne $t4, $zero, loop_imprime2 # se ainda for menor retorna no loop de impressão
	
	


fim:	jr $ra                       #retorna para o rotina que chamou a função sort

	
	

