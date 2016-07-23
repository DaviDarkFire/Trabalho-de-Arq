.data
	array: .word 37, 29, 46, 13, 0, 28, 1, 38, 22, 6, 123, 11, 458, 111, 27, 2, 25, 14, 13, 15, 13, 33, 30, 45, 16, 17, 18, 19, 20, 24, 34, 0, 0, 28, 61, 31, 91, 92, 97, 23, 1, 0, 32, 44, 66, 67, 55, 12, 1, 7 #array porra
.text
	la $a0, array #carrega o endereço inicial da array em $a0
	addi $a1, $zero, 50 #carrega em $a1 a quantidade de elementos do array
	Jal quicksort #vai para a função quicksort

	li $v0, 10 #termina a execução do código
	syscall


quicksort:
	  add $t0, $zero, $zero #t0 = 0
	  addi $t1, $a1, -1 # subtrai 1 de $t1
	  move $a1, $t0 # $a1 = $t0
	  move $a2, $t1 #a2 = $t1
	
	  addi $sp, $sp, -4 #cria um espaço na pilha
	  sw $ra, 0($sp) #guarda o endereço de retorno
	  Jal ordena # chama a função ordena
	  lw $ra, 0($sp) # guarda o endereço de retorno na pilha
	  addi $sp, $sp, 4 # restaura o tamanho normal da pilha

	  move $v0, $a0 # $v0 := $a0
	  jr $ra #vai para o endereço armazenado em $ra


ordena:
	  add $t0, $a1, $a2 #$t0 = $a1 + $a2
	  sra $t0, $t0, 1 # divide $t0 por 2 e coloca o valor de volta em $t0
  	  sll $t0, $t0, 2 # multiplica o valor de $t0 por 2
	  add $t0, $t0, $a0 #
	  lw $s0, 0($t0)
	  move $s1, $a1 #i
	  move $s2, $a2 #j
	
enquanto_1:
	    slt $t0, $s2, $s1 #condição do while
	    bne $t0, $zero, fim_enquanto_1 # enquanto $s2 < $s1 
	    
	enquanto_2:
	      sll $t0, $s1, 2 #multiplica $s1 por 2 e coloca em $t0
	      add $t0, $t0, $a0
	      lw $t0, 0($t0)
	      slt $t0, $t0, $s0
	      beq $t0, $zero, fim_enquanto_2
	      slt $t0, $s1, $a2
	      beq $t0, $zero, fim_enquanto_2
	      addi $s1, $s1, 1
	      j enquanto_2
	fim_enquanto_2:
	
	enquanto_3:
	      sll $t0, $s2, 2
	      add $t0, $t0, $a0
	      lw $t0, 0($t0)
	      slt $t0, $s0, $t0
	      beq $t0, $zero, fim_enquanto_3
	      slt $t0, $a1, $s2
	      beq $t0, $zero, fim_enquanto_3
	      addi $s2, $s2, -1
	      j enquanto_3
	fim_enquanto_3:
	
	#IF_1:
	      slt $t0, $s2, $s1
	      bne $t0, $zero, fim_se_1
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
	#IF_2:
	      slt $t0, $a1, $s2
	      beq $t0, $zero, fim_se_2
	      addi $sp, $sp, -12
	      sw $a2, 0($sp)
	      sw $s1, 4($sp)
	      sw $ra, 8($sp)
	      add $a2, $s2, $zero
	      Jal ordena
       	      lw $a2, 0($sp)
	      lw $s1, 4($sp)
	      lw $ra, 8($sp)
	      addi $sp, $sp, 12
	fim_se_2: 
	#IF_3: 
	      slt $t0, $s1, $a2
	      beq $t0, $zero, fim_se_3
	      addi $sp, $sp, -4
	      sw $ra, 0($sp)
	      move $a1, $s1
	      Jal ordena
	      lw $ra, 0($sp)
              addi $sp, $sp, 4
	fim_se_3:
	add $v0, $zero, $a0
	Jr $ra
	  
	  
	  
	  
	  