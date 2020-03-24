module yMux1(z, a, b, c);
	output z;
	input a, b, c;
	wire notC, upper, lower;
	not my_not(notC, c);
	and upperAnd(upper, a, notC);
	and lowerAnd(lower, c, b);
	or my_or(z, upper, lower);
endmodule

module yMux(z, a, b, c);
    parameter SIZE = 2;
    output [SIZE-1:0] z;
    input [SIZE-1:0] a, b;
    input c;

    yMux1 mine[SIZE-1:0](z, a, b, c);
endmodule

module yMux4to1(z, a0, a1, a2, a3, c);
    parameter SIZE = 2;
    output [SIZE-1:0] z;
    input [SIZE-1:0] a0, a1, a2, a3;
    input [1:0] c;
    wire [SIZE-1:0] zLo, zHi;
    yMux #(SIZE) lo(zLo, a0, a1, c[0]);
    yMux #(SIZE) hi(zHi, a2, a3, c[0]);
    yMux #(SIZE) final(z, zLo, zHi, c[1]);
endmodule

module yAdder1(z, cout, a, b, cin);
    output z, cout;
    input a, b, cin;
    xor left_xor(tmp, a, b);
    xor right_xor(z, cin, tmp);
    and left_and(outL, a, b);
    and right_and(outR, tmp, cin);
    or my_or(cout, outR, outL);
endmodule

module yAdder(z, cout, a, b, cin);
    output [31:0] z;
    output cout;
    input [31:0] a, b;
    input cin;
    wire[31:0] in, out;
    yAdder1 mine[31:0](z, out, a, b, in);
    assign in[0] = cin;
    assign in[1] = out[0];
    assign in[2] = out[1];
	assign in[3] = out[2];
	assign in[4] = out[3];
	assign in[5] = out[4];
	assign in[6] = out[5];
	assign in[7] = out[6];
	assign in[8] = out[7];
	assign in[9] = out[8];
	assign in[10] = out[9];
	assign in[11] = out[10];
	assign in[12] = out[11];
	assign in[13] = out[12];
	assign in[14] = out[13];
	assign in[15] = out[14];
	assign in[16] = out[15];
	assign in[17] = out[16];
	assign in[18] = out[17];
	assign in[19] = out[18];
	assign in[20] = out[19];
	assign in[21] = out[20];
	assign in[22] = out[21];
	assign in[23] = out[22];
	assign in[24] = out[23];
	assign in[25] = out[24];
	assign in[26] = out[25];
	assign in[27] = out[26];
	assign in[28] = out[27];
	assign in[29] = out[28];
	assign in[30] = out[29];
	assign in[31] = out[30];
	assign cout = out[31];
endmodule

module yArith(z, cout, a, b, ctrl); // add if ctrl=0, subtract if ctrl=1 output [31:0] z;
	output [31:0] z;
	output cout;
    input [31:0] a, b;
    input ctrl;
    wire[31:0] notB, tmp;
    
    not nb[31:0](notB, b);
    yMux #(32) cb(tmp, b, notB, ctrl);
    yAdder adder(z, cout, a, tmp, ctrl);
endmodule

module yAlu(z, ex, a, b, op);
    input [31:0] a, b;
    input [2:0] op;
    output [31:0] z;
	output ex;
	wire [31:0] ua, mo, da, slt;
	assign slt[31:1] = 0;
	wire [15:0] z16;
	wire [7:0] z8;
	wire [3:0] z4;
	wire [1:0] z2;

	// slt
	xor sign(ssC, a[31], b[31]);

	and up[31:0](ua, a, b);
	or mid[31:0](mo, a, b);
	yArith atith(da, cout, a, b, op[2]);
	yMux #(1) sltC(slt[0], da[31], a[31], ssC);
	yMux4to1 #(32) mux(z, ua, mo, da, slt, op[1:0]);
	// zero
	or or16[15:0](z16, z[15:0], z[31:16]);
	or or8[7:0](z8, z16[7:0], z16[15:8]);
	or or4[3:0](z4, z8[3:0], z8[7:4]);
	or or2[1:0](z2, z4[1:0], z4[3:2]);
	or zero(zero, z2[0], z2[1]);
	not exp(ex, zero);
endmodule

module yIF(ins, PC, PCp4, PCin, clk);
	output [31:0] ins, PC, PCp4;
	input [31:0] PCin;
	input clk;

	wire zero;
	wire read, write, enable;
	wire [31:0] a, memIn;
	wire [2:0] op;

	register #(32) pcReg(PC, PCin, clk, enable);
	mem insMem(ins, PC, memIn, clk, read, write);
	yAlu myAlu(PCp4, zero, a, PC, op);

	assign enable = 1'b1;
	assign a = 32'h0004;
	assign op = 3'b010;
	assign read = 1'b1;
	assign write = 1'b0;
endmodule

// module yIF(ins, PCp4, PCin, clk);
// 	input clk;
// 	input [31:0] PCin;
// 	output [31:0] ins, PCp4;

// 	reg [31:0] pi;

// 	mem data(ins, pi, 0, clk, 1'b1, 1'b0);
// 	yAlu add(PCp4, ex, pi, 4, 3'b010);

// 	always @ (posedge clk)
// 	  pi <= PCin;

// endmodule

module yID(rd1, rd2, immOut, jTarget, branch, ins, wd, RegWrite, clk); 
	output [31:0] rd1, rd2, immOut;
	output [31:0] jTarget;
	output [31:0] branch;

	input [31:0] ins, wd; 
	input RegWrite, clk;

	wire [19:0] zeros, ones;   // For I-Type and SB-Type    
	wire [11:0] zerosj, onesj; // For UJ-Type   
	wire [31:0] imm, saveImm;  // For S-Type

	rf myRF(rd1, rd2, ins[19:15], ins[24:20], ins[11:7], wd, clk, RegWrite); 

	assign imm[11:0] = ins[31:20];
	assign zeros = 20'h00000;
	assign ones = 20'hFFFFF;

	yMux #(20) se(imm[31:12], zeros, ones, ins[31]);

	assign saveImm[11:5] = ins[31:25];
	assign saveImm[4:0] = ins[11:7];
	yMux #(20) saveImmSe(saveImm[31:12], zeros, ones, ins[31]);

	yMux #(32) immSelection(immOut, imm, saveImm, ins[5]);

	assign branch[11] = ins[31];
	assign branch[10] = ins[7];
	assign branch[9:4] = ins[30:25];
	assign branch[3:0] = ins[11:8];
	yMux #(20) bra(branch[31:12], zeros, ones, ins[31]);

	assign zerosj = 12'h000;
	assign onesj = 12'hFFF;
	assign jTarget[19] = ins[31];
	assign jTarget[18:11] = ins[19:12];
	assign jTarget[10] = ins[20];
	assign jTarget[9:0] = ins[30:21];
	yMux #(12) jum(jTarget[31:20], zerosj, onesj, jTarget[19]);

endmodule

module yEX(z, zero, rd1, rd2, imm, op, ALUSrc); 
	output [31:0] z;
	output zero;

	input [31:0] rd1, rd2, imm; 
	input [2:0] op;
	input ALUSrc;

	wire [31:0] b;

	yMux #(32) src(b, rd2, imm, ALUSrc);
	yAlu mop(z, zero, rd1, b, op);

endmodule

module yDM(memOut, exeOut, rd2, clk, MemRead, MemWrite); 
	output [31:0] memOut;
	input [31:0] exeOut, rd2;
	input clk, MemRead, MemWrite;
	// instantiate the circuit (only one line)
	mem data(memOut, exeOut, rd2, clk, MemRead, MemWrite);
endmodule
//---------------------------------------------------------------
module yWB(wb, exeOut, memOut, Mem2Reg);
	output [31:0] wb;
	input [31:0] exeOut, memOut;
	input Mem2Reg;
	// instantiate the circuit (only one line)
	yMux #(32) wbo(wb, exeOut, memOut, Mem2Reg);
endmodule

module yPC(PCin, PC, PCp4, INT, entryPoint, branchImm, jImm, zero, isbranch, isjump);
	output [31:0] PCin;
	input [31:0] PC, PCp4, entryPoint, branchImm;
	input [31:0] jImm;
	input INT, zero, isbranch, isjump;
	wire [31:0] branchImmX4, jImmX4, jImmX4PPCp4, bTarget, choiceA, choiceB;
	wire doBranch, zf;

	// Shifting left branchImm twice
   	assign branchImmX4[31:2] = branchImm[29:0];
  	assign branchImmX4[1:0] = 2'b00;

  	// Shifting left jump twice
 	assign jImmX4[31:2] = jImm[29:0];
 	assign jImmX4[1:0] = 2'b00;

 	// adding PC to shifted twice, branchImm
    yAlu bALU(bTarget, zf, PC, branchImmX4, 3'b010);

    // adding PC to shifted twice, jImm
    yAlu jALU(jImmX4PPCp4, zf, PC, jImmX4, 3'b010);

    and (doBranch, isbranch, zero);

    yMux #(32) mux1(choiceA, PCp4, bTarget, doBranch);

   	yMux #(32) mux2(choiceB, choiceA, jImmX4PPCp4, isjump);

   	yMux #(32) mux3(PCin, choiceB, entryPoint, INT);
endmodule

module yC1(isStype, isRtype, isItype, isLw, isjump, isbranch, opCode);
output isStype, isRtype, isItype, isLw, isjump, isbranch;
input [6:0] opCode;
wire lwor, ISselect, JBselect, sbz, sz;
	//   opCode
	// lw 		0000011
	// I-Type   0010011
	// R-Type   0110011
	// SB-Type  1100011 //branches
	// UJ-Type  1101111 // jal
	// S-Type   0100011
	// Detect UJ-type
	assign isjump=opCode[3];
	// Detect lw
	or (lwor, opCode[6], opCode[5], opCode[4], opCode[3], opCode[2]);
	not (isLw, lwor);
	// Select between S-Type and I-Type
	xor (ISselect, opCode[6], opCode[5], opCode[4], opCode[3], opCode[2]);
	and (isStype, ISselect, opCode[5]);
	and (isItype, ISselect, opCode[4]);
	// Detect R-Type
	and (isRtype, opCode[5], opCode[4]);
	// Select between JAL and Branch
	and (JBselect, opCode[6], opCode[5]);
	not (sbz, opCode[2]);
	and (isbranch, JBselect, sbz);
endmodule

module yC2(RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg, isStype, isRtype, isItype, isLw, isjump, isbranch);
	output RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg;
	input isStype, isRtype, isItype, isLw, isjump, isbranch;
    
    or (RegWrite, isRtype, isItype, isLw);
    or (ALUSrc, isStype, isItype, isLw);
    assign MemRead = isLw;
    assign Mem2Reg = isLw;
    assign MemWrite = isStype;
endmodule

module yC3(ALUop, isRtype, isbranch);
	output [1:0] ALUop;
	input isRtype, isbranch;
    // wire ri;
    assign ALUop[1] = isRtype;
    assign ALUop[0] = isbranch;
    // yMux #(2) choice(ri, 2'b00, 2'b10, isRtype);
    // yMux #(2) out(ALUop, ri, 2'b01, isbranch);
endmodule

module yC4(op, ALUop, funct3);
    output [2:0] op;
	input [2:0] funct3;
	input [1:0] ALUop;

	xor (uF, funct3[2], funct3[1]);
	xor (dF, funct3[1], funct3[0]);
	and (uA, ALUop[1], uF);
	and (op[0], ALUop[1], dF);
	or (op[2], ALUop[0], uA);
	not (nU, ALUop[1]);
	not (nF, funct3[1]);
	or (op[1], nU, nF);
endmodule

module yChip(ins, rd2, wb, entryPoint, INT, clk);
	output [31:0] ins, rd2, wb;
	input [31:0] entryPoint;
	input INT, clk;

	//state
	wire isStype, isRtype, isItype, isLw, zero;
	wire RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg, isBranch, isJump;
	//op
	wire [1:0] ALUop;
	wire [2:0] funct3, op;
	//reg
	wire [4:0] rs1, rs2, rd;
	// work
	wire [31:0] PCin, PC;
	wire [31:0] wd, rd1, imm, PCp4, aluZ, memOut;
	wire [31:0] jTarget, branch;

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
endmodule