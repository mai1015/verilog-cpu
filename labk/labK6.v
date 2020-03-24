module labK;
reg a, b, c, expect;

wire z;
integer i, j, k;

and (tA, c, b);
not (tC, c);
and (tB, a, tC);
or (z, tA, tB);

initial
begin
	a = 1; b = 1; c = 0;
	#1 $display("a=%b b=%b c=%b z=%b", a, b, c, z);
	$finish;
   // for (i = 0; i < 2; i = i + 1)
   // begin
   //    for (j = 0; j < 2; j = j + 1)
   //    begin
   //       a = i; b = j;
   //       expect = i & ~b;
   //       #1; // wait for z
   //       if (expect === z)
   //          $display("PASS: a=%b b=%b z=%b", a, b, z);
   //       else
   //          $display("FAIL: a=%b b=%b z=%b", a, b, z);
   //     end
   // end
   // $finish;
end
endmodule