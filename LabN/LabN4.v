module labN;
reg clk;
reg [31:0] entryPoint;
reg INT;
wire RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg;
wire isBranch, isJump;
wire [1:0] ALUop;
wire [2:0] funct3, op;
wire [31:0] PCin, PC;
wire [31:0] wd, rd1, rd2, imm, ins, PCp4, aluZ, memOut, wb;
wire [31:0] jTarget, branch;
wire zero;
wire [4:0] rs1, rs2, rd;
wire isStype, isRtype, isItype, isLw;
yPC myPC(PCin, PC, PCp4, INT, entryPoint, branch, jTarget, zero, isBranch, isJump);
yIF myIF(ins, PC, PCp4, PCin, clk);
yC1 myC1(isStype, isRtype, isItype, isLw, isJump, isBranch, ins[6:0]);
yC2 myC2(RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg, isStype, isRtype, isItype, isLw, isJump, isBranch);
yC3 myC3(ALUop, isRtype, isBranch);
assign funct3 = ins[14:12];
yC4 myC4(op, ALUop, funct3);
yID myID(rd1, rd2, imm, jTarget, branch, ins, wd, RegWrite, clk);
yEX myEx(aluZ, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, aluZ, rd2, clk, MemRead, MemWrite);
yWB myWB(wb, aluZ, memOut, Mem2Reg);
assign wd = wb;

initial
begin
        //------------------------------------Entry point
        entryPoint = 32'h28; INT = 1; #1;

        //------------------------Prepare for the next ins
  //       if (INT == 1) 
  //       	PCin = entryPoint;
  //       else
		// if (beq && zero == 1)
		// 	PCin = PCp4 + branchImm shifted left twice;
		// else
		// if (jal)
		// 	PCin = PCin + jImm shifted left twice;
		// else
		// 	PCin = PCp4;

	
        //------------------------------------Run program
        repeat (43)
        begin

                //---------------------------------Fetch an ins
                clk = 1; #1; INT = 0;
                //---------------------------------Set control signals
               
                //---------------------------------Execute the ins               
                clk = 0; #1;

  		        // $display("ins[7:0]=%h", ins[7:0]);
        		$display("PC: %h", PC);
        		$display("Type: s:%d r:%d I:%d L:%d jump:%d, branch:%d", isStype, isRtype, isItype, isLw, isJump, isBranch);
        		$display("Ops: RegWrite:%d, ALUSrc:%d, MemRead:%d, MemWrite:%d, Mem2Reg:%d", RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg);

			   
                //---------------------------------View results
                 $display("%h: rd1=%2d rd2=%2d z=%3d zero=%b wb=%2d", ins, rd1, rd2, aluZ, zero, wb);
//                 $display("%h: rs1=%d, rs2=%d, rd=%d, rd1=%2d rd2=%2d aluZ=%3d zero=%b wb=%2d", ins, rs1, rs2, rd, rd1, rd2, aluZ, zero, wb);
               
                //---------------------------------Prepare for the next ins
               
        end
		
        $finish;
end
endmodule