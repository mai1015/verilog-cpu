main:	#--------------------
	addi x5, x0, 0xfff
	addi x6, x0, 1
	slli x6, x6, 18
	xor x6, x5, x6
fini: