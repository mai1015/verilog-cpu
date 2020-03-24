# --- STACK definition ---
BSTACK: DD 0xffffffffffff0000 # The bottom of the stack 
TSTACK: DD 0xfffffffffffffff8 # The top of the stack 
#-----------------------------
# ----- data definition -----
MAX:     DW       2147483647;
SIZE:    DB       32;
count:   DW       0
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
	jal x1, getCount
	add x5, x0, x10
	ecall x0, x5, 0
	ecall x12, x0, 5
	jal x1, setCount
	jal x1, getCount
	add x5, x0, x10
	ecall x0, x5, 0