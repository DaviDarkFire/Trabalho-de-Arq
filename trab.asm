.data
	array: .word 3, 2, 1, 0, 1, 2
	espaco: .asciiz " "
.text
	la $a0, array
	la $a3, espaco
	li $a1, 5
	
	j sort	
	
troca:  sll  $t1, $a1, 2 #v = $a0, k =  $a1
	add  $t1, $a0, $t1# $a0 e $a1 são parâmetros que eu passei pra troca
	
	lw   $t0, 0($t1)
	lw   $t2, 4($t1)
	
	sw   $t2, 0($t1)
	sw   $t0, 4($t1)
	
	jr $ra
	
	
sort:   addi $sp, $sp, -20	
	sw   $ra, 16($sp)
	sw   $s3, 12($sp)
	sw   $s2, 8($sp)
	sw   $s1, 4($sp)
	sw   $s0, 0($sp)
						
	
	move $s2, $a0
	move $s3, $a1
	
	move $s0, $zero
for_ext:slt  $t0, $s0, $s3
	beq  $t0, $zero, saida1
	
	addi $s1, $s0, -1
for_int: slti $t0, $s1, 0
	bne  $t0, $zero, saida2
	sll  $t1, $s1, 2
	add  $t2, $s2, $t1
	lw   $t3, 0($t2)
	lw   $t4, 4($t2)	  	
	slt  $t0, $t4, $t3
	beq  $t0, $zero, saida2
	
	move $a0, $s2
	move $a1, $s1
	jal troca
	
	addi $s1, $s1, -1
	j for_int
	
saida2: addi $s0, $s0, 1
	j for_ext		
	
saida1: lw $s0, 0($sp)	
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $ra, 16($sp)
	addi $sp, $sp, 20
	
	
	add $t0, $zero, $zero
	addi $t1, $zero, 5
	move $s2, $a0
	move $s3, $a1
loop_imprime: 	
	slt $t3, $t0, $t1
	beq $t3, $zero, fim
	
	move $t4, $t0
	sll $t4, $t4, 2
	add $s2, $s2, $t4
	lw $t5, 0($s2)
	
	move $t6, $a0
	move $a0, $t5
	syscall
	move $a0, $a3
	syscall		
	move $a0, $t6	
	
	addi $t0, $t0, 1
	j loop_imprime

fim:
			

	jr $ra

	
	

