main:	#--------------------
	ecall x8, x0, 5
	slli x5, x8, 53
	srli x6, x5, 63
	ecall x0, x6, 0
fini: