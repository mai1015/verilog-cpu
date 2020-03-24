# --- STACK definition ---
BSTACK: DD 0xffffffffffff0000 # The bottom of the stack 
TSTACK: DD 0xfffffffffffffff8 # The top of the stack 
#-----------------------------
# ----- data definition -----
MAX:     DW       2147483647;
SIZE:    DB       32;
count:   DW       0
#----------------------------
getCount:
	# push
	sd      x1, 0(x2)
        addi    x2, x2, -8
	# action
	lw x10, count(x0)
	# pop
	addi x2, x2, 8
	ld x1, 0(x2)
	# return
	jalr x0, 0(x1)
#-----------------------------
START:
#--- Stack pointer Initialization
	ld x2, TSTACK(x0)
#-----------------------------
	jal x1, getCount
	add x5, x0, x10
	ecall x0, x5, 0