.include "macros.asm"

.globl bandeira

bandeira:
  save_context
  move $s0, $a0
  mul $s1, $a1, -1
  mul $s2, $a2, -1
  carregar_i_j
  move $s3, $v0
  lw $s4, 0($s3)
  bgez $s4, fim
  addi $s4, $s4, -2
  sw $s4, 0($s3)
fim:
  restore_context
  jr $ra