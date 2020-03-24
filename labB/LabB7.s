	addi x5, x0, 0
	ecall x8, x0, 5
loop:	slt x7, x5, x8
	beq x7, x0, done
	add x6, x6, x5
	addi x5, x5, 1
	jal x1, loop
done:	ecall x0, x6, 0