module labL;
reg signed [31:0] a, b;
reg signed [31:0] expect;
reg [2:0] op;

wire ex;
wire signed [31:0] z;
reg ok, flag, zero;

yAlu mine(z, ex, a, b, op);
initial
    begin
        repeat (10)
        begin
            a = $random;
            b = $random;
            flag = $value$plusargs("op=%d", op);
            // The oracle: compute "expect" based on "op"
            case (op)
                3'b000: expect = a & b;
                3'b001: expect = a | b;
                3'b010: expect = op[2] === 0 ? a + b : a - b;
                // 3'b011: expect = a < b ? 1 : 0;
                3'b111: expect = a < b ? 1 : 0;
            endcase

            #1;

            // Compare the circuit's output with "expect"
            // and set "ok" accordingly
            if (expect === z)
               $display("PASS: a=%d b=%d op=%d z=%d exp=%d", a, b, op, z, expect);
            else
               $display("FAIL: a=%d b=%d op=%d z=%d exp=%d", a, b, op, z, expect);
            // Display ok and the various signals
        end
    end
endmodule