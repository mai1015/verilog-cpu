module labL;

reg signed [31: 0]a, b, expect;
reg c;
wire signed [31: 0]z;
wire co;

yArith adder(z, co, a, b, c);

initial
repeat (500)
begin
	a = $random;
	b = $random;
	c = $random % 2;
	if (c === 0)
		expect = a + b;
	else
		expect = a - b;
	#1;
	if (expect === z)
	   $display("PASS: a=%d b=%d c=%d z=%d", a, b, c, z);
	else
	   $display("FAIL: a=%d b=%d c=%d z=%d", a, b, c, z);
end
endmodule