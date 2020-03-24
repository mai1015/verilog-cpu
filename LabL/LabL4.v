module labL;

reg [1:0] c;
reg [63:0] a0, a1, a2, a3, expect;

wire [63:0] z;

yMux4to1 #(64) mux(z, a0, a1, a2, a3, c);

initial
repeat (500)
begin
	a0 = $random;
	a1 = $random;
	a2 = $random;
	a3 = $random;
	c = $random % 4;
	case (c)
		2'b00: expect = a0;
		2'b01: expect = a1;
		2'b10: expect = a2;
		2'b11: expect = a3;
	endcase
	#1;
	if (expect === z)
       $display("PASS: a0=%d a1=%d a2=%d a3=%d c=%d z=%d", a0, a1, a2, a3, c, z);
    else
       $display("FAIL: a0=%d a1=%d a2=%d a3=%d c=%d z=%d", a0, a1, a2, a3, c, z);
end
endmodule