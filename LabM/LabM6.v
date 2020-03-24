module LabM;

reg clk, read, write;
reg [31:0] address, memIn;
wire [31:0] memOut;

mem data(memOut, address, memIn, clk, read, write);

initial
begin
	address = 16'h28; write = 0; read = 1;
	repeat (11)
	begin
		#1 $display("Address %h contains %h", address, memOut);
		case (memOut[6:0])
			7'h33: $display("%h %h %h %h %h %h //R-Type", memOut[31:25], memOut[24:20], memOut[19:15], memOut[14:12], memOut[11:7], memOut[6:0]);
			7'h6F: $display("%h %h %h //UJ-Type", memOut[31:12], memOut[11:7], memOut[6:0]);
			7'h3, 7'h13: $display("%h %h %h %h %h //I-Type", memOut[31:20], memOut[19:15], memOut[14:12], memOut[11:7], memOut[6:0]);
			7'h23: $display("%h %h %h %h %h %h //S-Type", memOut[31:25], memOut[24:20], memOut[19:15], memOut[14:12], memOut[11:7], memOut[6:0]);
			7'h63: $display("%h %h %h %h %h %h //SB-Type", memOut[31:25], memOut[24:20], memOut[19:15], memOut[14:12], memOut[11:7], memOut[6:0]);
		endcase
		address = address + 4;
	end
	$finish;
end
endmodule