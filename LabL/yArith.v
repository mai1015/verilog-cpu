module yArith(z, cout, a, b, ctrl); // add if ctrl=0, subtract if ctrl=1 output [31:0] z;
	output [31:0] z;
	output cout;
    input [31:0] a, b;
    input ctrl;
    wire[31:0] notB, tmp;
    // instantiate the components and connect them
    // Hint: about 4 lines of code
    not nb[31:0](notB, b);
    yMux #(32) cb(tmp, b, notB, ctrl);
    yAdder adder(z, cout, a, tmp, ctrl);
endmodule