.include "macros.asm"

.globl play

play:
  save_context
  move $s0, $a0
  move $s1, $a1
  move $s2, $a2
  li $v0, 1
  bgez $s1, passando
  bgez $s2, passando
  jal bandeira
  j fim
  passando:
  carregar_i_j
  move $t9, $v0
  lw $t0, 0($t9)
  li $v0, 1
  bne $t0, -1, prox
 	move $v0, $zero
 	j fim
prox:
  bne $t0, -2, fim
 	nop
 	move $a0, $s0
 	move $a1, $s1
 	move $a2, $s2
 	jal countAdjacentBombs
fim:
  restore_context
  jr $ra
