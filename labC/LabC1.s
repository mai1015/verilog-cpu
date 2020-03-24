         # --- data definition ---
MAX:     DW       2147483647;
SIZE:    DB       32;
count:   DW       0
         #----------------------------
START:
lw      x5, MAX(x0)
ecall   x0, x5, 0
lb      x5, SIZE(x0)
ecall   x0, x5, 0