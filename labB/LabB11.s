main:	#--------------------
	ecall x8, x0, 5
	andi x6, x8, 0x400
	ecall x0, x6, 0
fini: