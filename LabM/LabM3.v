module LabM;

reg clk, w, flag;
reg [4:0]  rs1, rs2, wn;
reg [31:0] wd;
wire [31:0] rd1, rd2;

integer i;

rf #(1) myRF(rd1, rd2, rs1, rs2, wn, wd, clk, w);

initial
begin
	flag = $value$plusargs("w=%b", w);
	for (i = 0; i < 32; i = i + 1) begin
		clk = 0;
		wd = i * i;
		wn = i;
		clk = 1;
		#1;
	end
	repeat (10)
	begin
		clk = ~clk;
		wd = $random;
		wn = $random;
		rs1 = wn;
		rs2 = wn;
		#2
		$display("clk=%b wd=%d, wn=%d rd1=%d", clk, wd, wn, rd1);
	end
	$finish;
end
endmodule