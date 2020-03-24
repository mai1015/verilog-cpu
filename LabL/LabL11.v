module labL;
reg signed [31:0] a, b, expect;
reg [2:0] op;
reg tem;

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
            tem = $random % 2;
            op = 7;
            if (tem == 0) b = a;
            expect = a < b ? 1 : 0;
            zero = expect == 0 ? 1 : 0;
            #1;

            // Compare the circuit's output with "expect"
            // and set "ok" accordingly
            if (zero === ex)
               $display("PASS: a=%d b=%d op=%d z=%d ex=%d", a, b, op, z, ex);
            else
               $display("FAIL: a=%d b=%d op=%d z=%d ex=%d", a, b, op, z, ex);
            // Display ok and the various signals
        end
    end
endmodule