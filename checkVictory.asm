.include "macros.asm"

.globl checkVictory

checkVictory:

 save_context
 move $s0, $a0					# endereço do início
 move $s1, $zero				# i = 0
 move $s2, $zero				# j = 0
 move $s7, $zero				# count = 0;
 inicio_for_i:
	beq $s1, SIZE, final_for_i		# finaliza o laço i
	move $s2, $zero
	inicio_for_j:
		beq $s2, SIZE, final_for_j	# finaliza o laço j
		move $a0, $s0
		move $a1, $s1
		move $a2, $s2
		carregar_i_j
		lw $s3, ($v0)
		bltz $s3, pass			# não aumenta o contador se for menor que zero
		addi $s7, $s7, 1		# aumenta o contador em 1
		pass:
		addi $s2, $s2, 1		# j++
		j inicio_for_j
	final_for_j:
	addi $s1, $s1, 1			# i++
	j inicio_for_i
final_for_i:

 li $t0, SIZE
 mul $t0, $t0, $t0				# SIZE * SIZE
 sub $t0, $t0, BOMB_COUNT			# SIZE * SIZE - BOMB_COUNT
 seq $v0, $s7, $t0				# Se count for igual a expresão acima, retorne 0. Senão, retorne 1.
 
restore_context
jr $ra
