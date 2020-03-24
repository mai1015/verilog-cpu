module yIF(ins, PCp4, PCin, clk);
input clk;
input [31:0] PCin;
output [31:0] ins, PCp4;

reg [31:0] pi;

mem data(ins, pi, 0, clk, 1'b1, 1'b0);
yAlu add(PCp4, ex, pi, 4, 3'b010);

always @ (posedge clk)
  pi <= PCin;

endmodule