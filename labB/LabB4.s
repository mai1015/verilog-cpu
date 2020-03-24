addi x6, x0, 6
ecall x5, x0, 5
beq x5, x6, XX
sub x7, x5, x6
jal x1, YY
XX: add x7, x5, x6
YY: ecall x0, x7, 0