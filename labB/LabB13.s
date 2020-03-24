main:	#--------------------
	addi x6, x0, 1
	slli x6, x6, 33
	ecall x5, x0, 5
	xor x5, x5, x6
fini: