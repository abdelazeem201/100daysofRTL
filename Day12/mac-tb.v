`timescale 1 ns / 10ps


module tb; 

reg clk, ct1, ct2;
reg [15:0] a;
reg [15:0] b;
reg [31:0] c;
wire [32:0] z;

mac macinst (.a(a), .b(b), .c(c), .ct1(ct1), .ct2(ct2), .z(z), .clk(clk));


//======== control mode
initial
begin
        #3000 ct1 = 1'b1;
        #3000 ct2 = 1'b1;
        #0    ct1 = 1'b0;
        #3000 ct1 = 1'b1;
end


//======== initialization
initial 
begin
	clk = 0;
	ct1 = 1'b0; ct2 = 1'b0;
	a = 16'b000000000000000;
	b = 16'b111111111111111;
	c = 32'b10101010101010101010101010101010;
end

//======== display
// initial
//	$monitor ("a b c ct1 ct2 output %h %h %h %h %h %h",a,b,c,ct1,ct2,z);

//======== vector generation
always 
begin
	#12;
	a = a+1111;
	b = b-1111;
	c = c+33331111;
end

//======== clock ============
always 
begin
	#6
	clk = ~clk;
end

//======== job control
initial 
begin
	#10001 $finish;
end


//========== VPD ============
`ifdef VPD
initial
begin
	$vcdplusfile("../src/annotate/gate.vpd");
	$vcdpluson;
end
`endif



//========== VCD ============
`ifdef VCD
initial
begin
	$dumpfile("../src/annotate/gate.vcd");
	$dumpvars;
end
`endif



//===========RTL_VCD ==========
`ifdef RTL_VCD
initial
begin
	$dumpfile("../src/annotate/rtl.vcd");
	$dumpvars;
end
`endif

//========== SDF ============

`ifdef SDF
initial
begin
  $sdf_annotate ("../src/annotate/mac.sdf", macinst);
end
`endif

endmodule
