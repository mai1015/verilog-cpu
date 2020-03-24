module yAlu(z, ex, a, b, op);
    input [31:0] a, b;
    input [2:0] op;
    output [31:0] z;
	output ex;
	wire [31:0] ua, mo, da, slt;
	assign slt[31:1] = 0;
	wire [15:0] z16;
	wire [7:0] z8;
	wire [3:0] z4;
	wire [1:0] z2;
	// assign ex = 0; // not supported
	// instantiate the components and connect them
	// Hint: about 4 lines of code
	// slt
	xor sign(ssC, a[31], b[31]);

	and up[31:0](ua, a, b);
	or mid[31:0](mo, a, b);
	yArith atith(da, cout, a, b, op[2]);
	yMux #(1) sltC(slt[0], da[31], a[31], ssC);
	yMux4to1 #(32) mux(z, ua, mo, da, slt, op[1:0]);
	// zero
	or or16[15:0](z16, z[15:0], z[31:16]);
	or or8[7:0](z8, z16[7:0], z16[15:8]);
	or or4[3:0](z4, z8[3:0], z8[7:4]);
	or or2[1:0](z2, z4[1:0], z4[3:2]);
	or zero(zero, z2[0], z2[1]);
	not exp(ex, zero);
endmodule