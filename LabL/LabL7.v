module labL;

reg signed [31: 0]a, b, expect;
reg c;
wire signed [31: 0]z;
wire co;

yAdder adder(z, co, a, b, c);

initial
repeat (500)
begin
	a = $random;
	b = $random;
	c = 0;
	expect = a + b;
	#1;
	if (expect === z)
	begin
       $display("PASS: a=%d b=%d z=%d", a, b, z);
    end else begin
       $display("FAIL: a=%d b=%d z=%d", a, b, z);
	end
end
endmodule