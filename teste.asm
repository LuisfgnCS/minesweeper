.include "macros.asm"

.globl teste

teste:

 save_context
 jal countAdjacentBombs
 move $a0, $v0 						#print ('i')
 li $v0, 1
 syscall
 
 restore_context
 jr $ra
