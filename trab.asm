.data
	array: .word -37, 29, 46, 13, -1, 28, 7, 38, 22, 6, 123, 11, 458, 111, 27, 2, 25, 14, 13, 15, 13, 33, 30, 45, 16, 17, 18, 19, 20, 24, 34, 0, 6, 28, 61, 31, -91, 92, 97, 23, 1, 6, 32, 44, 66, 67, 55, 12, 1, 7 #array
	array2: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, #array para o qual vão ser copiados os valores do primeiro array 
	espaco: .asciiz " "
	bubble: .asciiz "BubbleSort:"
	quick: .asciiz "QuickSort:"	
.text

##############################################################################################################################################################################		
################################################################################ Bubble Sort #################################################################################
##############################################################################################################################################################################		

############################################################### Inicializa os valores necessários para o Bubble Sort ##############################################################
			     	
	la $a0, array                #associa o endereço inicial do array com o registrador $ra
	la $a2, array2
	la $a3, espaco               #associa o endereço do espaço com o registrador $a3
	addi $a1, $zero, 50          #quantidade de elementos do array
	
############################################################### Copia os valores de um array para o outro #########################################################################			     		

	add $t0, $zero, $zero        #$t0 = 0
	addi $t2, $zero, 50          # valor até o qual o for vai 
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
	
############################################################### Impressão da ordenação do buuble no Console ##################################################################

	add $t0, $zero, $zero        #$t0 = 0
	addi $t2, $zero, 50          # valor até o qual o for vai
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
			
##############################################################################################################################################################################		
################################################################################ Quick Sort ##################################################################################	
##############################################################################################################################################################################		
	
	move $a0, $zero
	move $a1, $zero
	move $a2, $zero
	move $a3, $zero
	move $t0, $zero
	move $t2, $zero
	move $t3, $zero
	move $s2, $zero		
	move $s3, $zero
	move $t4, $zero
	move $v0, $zero
	move $at, $zero
	
	la $a0, array               #carrega o endereço inicial da array em $a0
	addi $a1, $zero, 50         #carrega em $a1 a quantidade de elementos do array
	jal quicksort               #vai para a função quicksort
	jal print

	li $v0, 10                   #termina a execução do código
	syscall
############################################################################## QuickSort #####################################################################################	
quicksort:
	  add $t0, $zero, $zero      #t0 = 0
	  addi $t1, $a1, -1          # subtrai 1 de $t1
	  move $a1, $t0              # $a1 = $t0
	  move $a2, $t1              #a2 = $t1
	
	  addi $sp, $sp, -4          #cria um espaço na pilha
	  sw $ra, 0($sp)             #guarda o endereço de retorno
	  jal ordena                 # chama a função ordena
	  lw $ra, 0($sp)             # guarda o endereço de retorno na pilha
	  addi $sp, $sp, 4           # restaura o tamanho normal da pilha

	  move $v0, $a0              # $v0 := $a0
	  jr $ra                     #vai para o endereço armazenado em $ra

############################################################################## Ordena ########################################################################################
ordena:
	  add $t0, $a1, $a2          #$t0 = $a1 + $a2
	  sra $t0, $t0, 1            # pega a soma e divide por 2 pra achar o pivo
  	  sll $t0, $t0, 2            # multiplica o valor de $t0 por 4 para corresponder a posição da memória
	  add $t0, $t0, $a0          #pega o valor e soma com a posição da memória atual pra conseguir a posição de memória do pivo 
	  lw $s0, 0($t0)             #pega o pivo da memória de endereço guardado em $t0
	  move $s1, $a1              #passa o valor do parametro $a1 pra $s1
	  move $s2, $a2              #passa o valor do parametro $a2 pra $s2
	
enquanto_1:
	    slt $t0, $s2, $s1        #condição do while
	    bne $t0, $zero, fim_enquanto_1 # enquanto $s2 < $s1 
	    
	enquanto_2:
	      #ve se v[i] < que o pivo conseguido
	      sll $t0, $s1, 2 
	      add $t0, $t0, $a0 
	      lw $t0, 0($t0)
	      slt $t0, $t0, $s0
	      beq $t0, $zero, fim_enquanto_2
	      # ve se i < dir
	      slt $t0, $s1, $a2
	      beq $t0, $zero, fim_enquanto_2
	      #se as duas consições forem satisfeitas incrementa 1 em i volta para o enquanto_2	      
	      addi $s1, $s1, 1	      
	      j enquanto_2
	fim_enquanto_2:
	
	enquanto_3:
	      #ve se v[j] > pivo
	      sll $t0, $s2, 2
	      add $t0, $t0, $a0
	      lw $t0, 0($t0)
	      slt $t0, $s0, $t0
	      beq $t0, $zero, fim_enquanto_3
	      #ve se j > esq      
	      slt $t0, $a1, $s2
	      beq $t0, $zero, fim_enquanto_3
	      #se as duas condições forem satisfeitas decrementa j e volta no enquanto_3	      
	      addi $s2, $s2, -1 
	      j enquanto_3
	fim_enquanto_3:
	
	se1:
	      slt $t0, $s2, $s1
	      bne $t0, $zero, fim_se_1
	      #se i <= j troca
	      #v[i] = v[j]
	      #v[j] = v[i]
	      #ou seja troca os números de posição
      	      sll $t0, $s1, 2
	      add $t0, $t0, $a0
	      lw $t1, 0($t0)
	      sll $t2, $s2, 2
	      add $t2, $t2, $a0
	      lw $t3, 0($t2)
	      sw $t1, 0($t2)
	      sw $t3, 0($t0)
	      addi $s1, $s1, 1
	      addi $s2, $s2, -1
	fim_se_1:
	j enquanto_1
		
fim_enquanto_1:
	se2:  # se j > esq chama a função ordena com esq na
	      #pos inicial e j na pos final do vetor
	      slt $t0, $a1, $s2
	      beq $t0, $zero, fim_se_2
	      addi $sp, $sp, -12
	      sw $a2, 0($sp)
	      sw $s1, 4($sp)
	      sw $ra, 8($sp)
	      add $a2, $s2, $zero
	      jal ordena
       	      lw $a2, 0($sp)
	      lw $s1, 4($sp)
	      lw $ra, 8($sp)
	      addi $sp, $sp, 12
	fim_se_2: 
	se3:  #se i < dir chama a função ordena com i na posição
	      #inicial e dir na posição final do vetor
	      slt $t0, $s1, $a2
	      beq $t0, $zero, fim_se_3
	      addi $sp, $sp, -4
	      sw $ra, 0($sp)
	      move $a1, $s1
	      jal ordena
	      lw $ra, 0($sp)
              addi $sp, $sp, 4
	fim_se_3:
	add $v0, $zero, $a0
	#finaliza tudo chamando a sub-rotina que chamou a função quick sort
	jr $ra
########################################################################## Impressão do vetor do quick ordenado ##############################################################
print:	#faz a impressão do quick no console	
	li $v0, 4                    # indica para que o syscall realize a função de impressão de string
	la $a0, quick                # passa o endereço da string a ser impressa
	syscall                      # chama o syscall
	
	
	
	li $v0, 11 # imprime uma quebra de linha na tela
	addi $a0, $zero, 10
	syscall
	
	la $a3, espaco	
	la $a2, array
	add $t0, $zero, $zero        #$t0 = 0
	addi $t2, $zero, 50          # valor até o qual o for vai
	move $t5, $a3 
	add $t3, $zero, $zero        #valor inicial da variável contadora
	move $s2, $a2 		     #$s2 = endereço inicial do vetor				
loop_imprime2: 	

	lw $t0, 0($s2)               #pega o valor do array e joga para o registrador
	li $v0, 1                    # indica para que o syscall realize a função de impressão de inteiro 
	move $a0, $t0                #passa o valor a ser escrito
	syscall   		     #chama o syscall	
	
	li $v0, 4                    # indica para que o syscall realize a função de impressão de string
	move $a0, $t5                # passa o endereço da string a ser impressa
	syscall                      # chama o syscall			
	
	addi $s2, $s2, 4             #vai para a próxima posição do vetor
	addi $t3, $t3, 1             #incrementa um no contador
	slt  $t4, $t3, $t2           # ve se o contador ainda é menor
				
	bne $t4, $zero, loop_imprime2 # se ainda for menor retorna no loop de impressão

	  
	  
	  
	  
	  
