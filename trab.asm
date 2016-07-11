.data
	array: .word 3, 2, 1, 0, 1, 2
.text
	la $a0, array
	li $a1, 5
	
sort:   move $s2, $a0
	move $s3, $a1
	
	move $s0, $zero
for_ext:slt  $t0, $s0, $s3
	beq $t0, $zero, saida1
	
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
	
saida1:	addi $s1, $s1, -1
	j for_int
	
saida2: addi $s0, $s0, 1
	j for_ext	
	
	
troca:  sll  $t1, $a1, 2 #v = $a0, k =  $a1
	add  $t1, $a0, $t1# $a0 e $a1 são parâmetros que eu passei pra troca
	
	lw   $t0, 0($t1)
	lw   $t2, 4($t1)
	
	sw   $t2, 0($t1)
	sw   $t0, 4($t1)
	
	jr   $ra	

