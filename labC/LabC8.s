# --- STACK definition ---
BSTACK: DD 0xffffffffffff0000 # The bottom of the stack 
TSTACK: DD 0xfffffffffffffff8 # The top of the stack 
#-----------------------------
# ----- data definition -----
MAX:     DW       2147483647;
SIZE:    DB       32;
count:   DW       0
#----------------------------
isPrime:
	sd x1, 0(x2)
	addi x2, x2, -8

	addi x2, x2, 8
	lw x1, 0(x2)
	jalr x0, 0(x1)
#----------------------------
isFactor:
	add x10, x0, x12
if_s:	blt x10, x13, if_r
	
if_r:	jalr x0, 0(x1)
#----------------------------
signum:
	sd x1, 0(x2)
	addi x2, x2, -8
	blt x12, x0, sn_l
	beq x12, x0, sn_r
	addi x11, x0, 1
	jal x0, sn_r
sn_l:	addi x11, x0, -1
	jal x0, sn_r
sn_r:	jal x1, getCount
	addi x12, x10, 1
	jal x1, setCount
	addi x2, x2, 8
	lw x1, 0(x2)
	add x10, x0, x11
	jalr x0, 0(x1)
#----------------------------
setCount:
	sd x12, count(x0)
	jalr x0, 0(x1)
#----------------------------
getCount:
	lw x10, count(x0)
	jalr x0, 0(x1)
#-----------------------------
START:
#--- Stack pointer Initialization
	ld x2, TSTACK(x0)
#-----------------------------
	ecall x12, x0, 5
	jal x1, signum
	ecall x0, x10, 0
	jal x1, getCount
	add x5, x0, x10
	ecall x0, x5, 0