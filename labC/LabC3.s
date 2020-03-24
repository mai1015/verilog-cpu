         # --- data definition ---
MAX:     DW       2147483647;
DB       -32;
count:   DW       0
         #----------------------------
START:	lw x5, MAX(x0)
	ecall x0, x5, 0
	addi x6, x0, 8
	lb x5, MAX(x6)
	ecall x0, x5, 0