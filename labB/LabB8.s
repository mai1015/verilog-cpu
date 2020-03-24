main:	#--------------------
	addi x5, x0, 60
	addi x6, x0, 7
	div x7, x5, x6
	ecall x0, x7, 0
	rem x28, x5, x6
	ecall x0, x28, 0
	mul x7, x5, x6
	ecall x0, x7, 0