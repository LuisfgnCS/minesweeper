.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:

 save_context
	move $s0, $a0				# início do tabuleiro
	li $s7, SIZE
	addi $s1, $a1, -1			# i = i - 1
	addi $s2, $a1, 1			# i = i + 1
	addi $s3, $a2, -1			# j = j - 1
	addi $s4, $a2, 1			# j = j + 1

# if (i >= 0 && i < SIZE && j >= 0 && j < SIZE) ------------------------------------------------------------------------
	bgez $s1, plus_i			# if(i - 1 < 0){
	addi $s1, $s1, 1			#   i++;
	j sub_i					# se já está na extremidade superior, não precisa verificar a inferior
plus_i:						# }

	blt $s2, $s7, sub_i			# if(i + 1 >= SIZE){
	addi $s2, $s2, -1			#   i--;
sub_i:						# }

	bgez $s3, plus_j			# if(j - 1 < 0){
	addi $s3, $s3, 1			#   j++;
	j sub_j					# se já está na extremidade esquerda, não precisa verificar a direita
plus_j:						#}

	blt $s4, $s7, sub_j			# if(j + 1 >= SIZE){
	addi $s4, $s4, -1			#   j--;
sub_j:						# }
# ----------------------------------------------------------------------------------------------------------------------
  move $s6, $s3
inicio_for_i:
	bgt $s1, $s2, final_for_i			# finaliza o laço i
	#bltz $s1, final_for_j
	#bge $s1, $s7 final_for_j
	move $s3, $s6					# reseta j 
   	inicio_for_j:
        	bgt $s3, $s4, final_for_j    		# Finaliza o laço j
		#bltz $s3, pular
		#bge $s3, $s7, pular
        	move $a0, $s0
        	move $a1, $s1
        	move $a2, $s3
		carregar_i_j
		move $t9, $v0
        	lw $t0, 0($t9)
        	bgt $t0, -2 pular              		# Se não for -2, pula
	        move $a0, $s0
	        move $a1, $s1
	        move $a2, $s3
	        jal play
        	pular:
      		addi $s3, $s3, 1            		# j++
		j inicio_for_j
	final_for_j:
	addi $s1, $s1, 1                		# i++
    	j inicio_for_i
final_for_i:
  restore_context
  jr $ra
  
