module labL;

reg c;
reg [1:0] a, b, expect;

wire [1:0] z;
integer i, j, k;

yMux2 mux(z, a, b, c);

initial
begin
   for (i = 0; i < 4; i = i + 1)
   begin
      for (j = 0; j < 4; j = j + 1)
      begin
	      for (k = 0; k < 2; k = k + 1)
	      begin
	        a = i; b = j; c = k;
	        expect[0] = (a[0] & ~c) | (b[0] & c);
	        expect[1] = (a[1] & ~c) | (b[1] & c);
	        #1; // wait for z
	        if (expect === z)
	           $display("PASS: a=%b b=%b c=%b z=%b", a, b, c, z);
	        else
	           $display("FAIL: a=%b b=%b c=%b z=%b", a, b, c, z);
		    end
       end
   end
   $finish;
end
endmodule