module labL;

reg c;
reg [63:0] a, b, expect;

wire [63:0] z;

yMux #(64) mux(z, a, b, c);

initial
repeat (500)
begin
	a = $random;
	b = $random;
	c = $random % 2;
	if (c===1)
    	expect = b;
    else 
    	expect = a;
	#1;
	if (expect === z)
       $display("PASS: a=%d b=%d c=%d z=%d", a, b, c, z);
    else
       $display("FAIL: a=%d b=%d c=%d z=%d", a, b, c, z);
end
endmodule