module yMux1(z, a, b, c);
	output z;
	input a, b, c;
	wire notC, upper, lower;
	not my_not(notC, c);
	and upperAnd(upper, a, notC);
	and lowerAnd(lower, c, b);
	or my_or(z, upper, lower);
endmodule

module yMux(z, a, b, c);
    parameter SIZE = 2;
    output [SIZE-1:0] z;
    input [SIZE-1:0] a, b;
    input c;
    yMux1 mine[SIZE-1:0](z, a, b, c);
endmodule

module yMux4to1(z, a0, a1, a2, a3, c);
      parameter SIZE = 2;
      output [SIZE-1:0] z;
      input [SIZE-1:0] a0, a1, a2, a3;
      input [1:0] c;
      wire [SIZE-1:0] zLo, zHi;
      yMux #(SIZE) lo(zLo, a0, a1, c[0]);
      yMux #(SIZE) hi(zHi, a2, a3, c[0]);
      yMux #(SIZE) final(z, zLo, zHi, c[1]);
endmodule