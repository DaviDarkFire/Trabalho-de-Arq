#Função quicksort
#a0: parametro p
#a1: parametro j / parametro r
#a2: array access
#a3: resultado separa
#s1: j
#s3: p
#s4: r
#t1: comparação

.data
	array: .word 37, 29, 46, 13, 0
	espaco: .asciiz " " #isso serve pra depois imprimir os numeros com espaço
.text
	la $a2, array
	add  $s3, $zero, $zero
	addi $s4, $zero, 4	
	quicksort:
		addi $sp, $sp, -24 #abre espaço na sp
		sw $s1, 20($sp) #salva o j
		sw $s3, 16($sp) #salva o p
		sw $s4, 12($sp) #salva o r
		sw $a0, 8($sp)
		sw $a1, 4($sp)
		sw $ra, 0($sp)
			
		
		slt $t1, $s3, $s4 # t1 = 1 if(p < q)
		beq $t1, $zero, end #vai para end se t1 == 0
		
		while:
			move $a0, $s3 #parametro p = p
			move $a1, $s4 #parametro r = r
			jal separa
			move $s1, $v0 #j = separa
			move $a0, $s3 #parametro p = p
			addi $a1, $s1, -1 #parametro j = j - 1
			jal quicksort
			addi $s3, $s1, 1 #p = j + 1
			
			slt $t1, $s3, $s4 # t1 = 1 if(p < q)
			bne $t1, $zero, while #vai para while se t1 == 1
		
		end: 
			lw $ra, 0($sp)
			lw $a1, 4($sp)
			lw $a0, 8($sp)			
			lw $s4, 12($sp) #carrega o r	
			lw $s3, 16($sp) #carrega o p					
			lw $s1, 20($sp) #carrega o j			
			addi $sp, $sp, 24
			
			jr $ra

#Função Separa
#t1: aux p
#s0: c
#s1: i
#s2: t	
#s3: j
#a0: parametro p
#a1: parametro r
	separa:
		addi $sp, $sp, -20
		sw $s1, 16($sp)
		sw $s2, 12($sp)
		sw $a0, 8($sp)
		sw $a1, 4($sp)
		sw $t1, 0($sp)

		
		addi $s1, $a0, 1 #i = p+1
		sll $t1, $a0, 2 #aux p = p * 4
		add $s0, $a2, $t1 #c = endereço de v[p]
		lw $s0, 0($s0) #c = v[p]
		add $s3, $a1, $zero #j = r
		
		LaçoGeral:
			j laço1
			laço1:
				#t0 e t1: resultados comparação
				#t2 = auxi
				#t3 = auxv
				#t4: resultado or
			
				slt $t0, $a1, $s1 #t0 = 1 se r<i					
				sll $t2, $s1, 2 #auxi = ix4
				add $t3, $a2, $t2 # t3 = endereço de v[i]
				
				lw $t3, 0($t3) #t3 = v[i]	
							
				slt $t1, $s0, $t3 #t1 = 1 se c<v[i]						
				or $t4, $t0, $t1
			
							
				bne $t4, $zero, laço2
				addi $s1, $s1, 1 #i++		


				j laço1
		
			laço2:
				#t0: auxj
				#t1: auxv
				#t2: resultado da comparação
				
				sll $t0, $s3, 2 #t0: j * 4
				add $t1, $a2, $t0 #t1 = endereço de v[j]
				lw $t1, 0($t1) #t1 = v[j]
				slt $t2, $s0, $t1 #t2 = 1 se c < v[j]
				beq $t2, $zero, se #sai do laço se t2 = 0
				addi $s3, $s3, -1 #j--
				j laço2
				
			se:
				slt $t0, $s3, $s1 #t0 = 1 se j < i
				bne $t0, $zero, fim
				j LaçoGeral2
		LaçoGeral2:
			#t0 = auxi
			#t1 = auxj
			#t2 = endereço de v[i]
			#t3 = endereço de v[j]
			#t4 = v[j]
			#t5 = t
			
			
			add $t0, $s1, $zero #t0 = i
			sll $t0, $t0, 2 #t0 = i * 4
			add $t5, $a2, $t0 #t5 = endereço de v[i]
			lw $t5, 0($t5) #t5 = v[i]
			
			add $t1, $s3, $zero #t1 = j
			sll $t1, $t1, 2 #t1 = t1 * 4	
			add $t3, $a2, $t1 # t3 = endereço de v[j]
			lw $t4, 0($t3) #t4 = v[j]
			add $t2, $a2, $t0 #t2 = endereço de v[i]
			sw $t4, 0($t2) #v[i] = v[j]
			
			sw $t5, 0($t3) # v[j] = t
			
			addi $s1, $s1, 1
			addi $s3, $s3, -1
			
			j LaçoGeral
		fim:
			#t0 = auxp
			#t1 = auxj
			#t2 = endereço v[p]
			#t3 = endereço v[j]
			#t4 = v[j]
			#a0 = p
			#s0 = c
			#s3 = j
			
			sll $t0, $a0, 2 #t0 = p * 4
			add $t2, $a2, $t0 # t2 = endereço v[p]
			
			sll $t1, $s3, 2 #t1 = j * 4
			add $t3, $a2, $t1 # t3 = endereço v[j]
			lw $t4, 0($t3) #t4 = v[j]
			sw $t4, 0($t2) #v[p] = v[j]
			sw $s0, 0($t3) #v[j] = c
			
			addi $v0, $s3, 0 #v0 = j
			
			
			lw $t1, 0($sp)
			lw $a1, 4($sp)
			lw $a0, 8($sp)
			lw $s2, 12($sp)
			lw $s1, 16($sp)
									
			addi $sp, $sp, 20
			jr $ra
