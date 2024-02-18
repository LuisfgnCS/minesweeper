.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:

 save_context
 	carregar_i_j
 	move $t8, $v0
	move $s0, $a0				# início do tabuleiro
	move $s5, $zero 			# cont = 0;
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
  move $t9, $s3
inicio_for_i:
	bgt $s1, $s2, final_for_i			# finaliza o laço i
	#bltz $s1, final_for_j
	#bge $s1, $s7 final_for_j
	move $s3, $t9					# reseta j 
   	inicio_for_j:
        	bgt $s3, $s4, final_for_j    		# Finaliza o laço j
		#bltz $s3, passar
		#bge $s3, $s7, passar
			sll $t0, $s1, 5
			sll $t1, $s3, 2
			add $t0, $t0, $t1
			add $s6, $t0, $s0
        	lw $t0, 0($s6)
		bne $t0, -1, passar			# não aumenta o contador se for diferente de -1
		addi $s5, $s5, 1			# aumenta o contador em 1
		passar:
		addi $s3, $s3, 1			# j++
		j inicio_for_j
	final_for_j:
	addi $s1, $s1, 1				# i++
	j inicio_for_i
final_for_i:
  sw $s5, 0($t8)
  bnez $s5, termina
  jal revealNeighboringCells
  termina:
  restore_context
  jr $ra
