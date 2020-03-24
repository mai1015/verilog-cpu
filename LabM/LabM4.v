module LabM;

reg clk, read, write;
reg [31:0] address, memIn;
wire [31:0] memOut;

mem data(memOut, address, memIn, clk, read, write);

initial
begin
	memIn =  32'h12345678;
	clk = 1;
	write = 1;
	address = 16;
	#1;
	clk = 0;
	memIn =  32'h89abcdef;
	address = 24;
	#1;
	clk = 1;
	#1;
	write = 0; read = 1; address = 16;
	repeat (3)
	begin
		#1 $display("Address %d contains %h", address, memOut);
		address = address + 4;
	end
	$finish;
end
endmodule