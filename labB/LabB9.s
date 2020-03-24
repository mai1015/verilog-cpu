main:	#--------------------
	addi x5, x0, -60
	srai x6, x5, 1
	ecall x0, x6, 0
	slli x6, x5, 2
	ecall x0, x6, 0
fini: