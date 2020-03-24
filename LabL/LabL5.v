module labL;

reg a, b, c;
reg [1:0] expect;

integer i, j, k;
wire z, co;

yAdder1 adder(z, co, a, b, c);

initial
begin
   for (i = 0; i < 2; i = i + 1)
   begin
      for (j = 0; j < 2; j = j + 1)
      begin
	      for (k = 0; k < 2; k = k + 1)
	      begin
	        a = i; b = j; c = k;
	        expect = a + b + c;
	        #1; // wait for z
	        if (expect[0] === z && expect[1] === co)
	           $display("PASS: a=%b b=%b c=%b z=%b co=%b", a, b, c, z, co);
	        else
	           $display("FAIL: a=%b b=%b c=%b z=%b co=%b", a, b, c, z, co);
		    end
       end
   end
   $finish;
end
endmodule