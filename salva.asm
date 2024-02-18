.include "macros.asm"

#.globl revealNeighboringCells

#revealNeighboringCells:

 save_context
	move $s0, $a0				# início do tabuleiro
	li $s7, SIZE
	addi $s1, $a1, -1			# i = i - 1
	addi $s2, $a1, 1			# i = i + 1
	addi $s3, $a2, -1			# j = j - 1
	addi $s4, $a2, 1			# j = j + 1

  move $s6, $s3
inicio_for_i:
	bgt $s1, $s2, final_for_i			# finaliza o laço i
	bltz $s1, final_for_j
	bge $s1, $s7 final_for_j
	move $s3, $s6					# reseta j 
   	inicio_for_j:
        	bgt $s3, $s4, final_for_j    		# Finaliza o laço j
		bltz $s3, pular
		bge $s3, $s7, pular
        	move $a0, $s0
        	move $a1, $s1
        	move $a2, $s3
        	carregar_i_j
        	move $t9, $v0
        	lw $t0, 0($t9)
        	bltz $t0, att0
        	att1:
        	move $a0, $s0
  		move $a1, $s1
  		move $a2, $s3
        	beqz $t0, revealNeighboringCells
        	pular:
      		addi $s3, $s3, 1            		# j++
		j inicio_for_j
	final_for_j:
	addi $s1, $s1, 1                		# i++
    	j inicio_for_i
final_for_i:
  restore_context
  jr $ra

att0:
  move $a0, $s0
  move $a1, $s1
  move $a2, $s3
  jal countAdjacentBombs
  move $t0, $v0
  j att1
  
