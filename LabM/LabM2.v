module labM;

reg [31:0] d, e;
reg clk = 0, enable, flag;

wire [31:0] z;

register #(32) mine(z, d, clk, enable);

initial
repeat (20)
begin
	#2 d = $random;
end
always
begin
	#5 clk = ~clk;
end
initial
begin
	$monitor("%5d: clk=%b,d=%d,z=%d,expect=%d", $time,clk,d,z, e);

	flag = $value$plusargs("enable=%b", enable);
	#40;
	$finish;
end
endmodule

// should it keep update every time d changes?