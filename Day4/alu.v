module alu
#(
  parameter WIDTH=8
 )
 (
  input  wire [      2:0] opcode    ,
  input  wire [WIDTH-1:0] in_a      ,
  input  wire [WIDTH-1:0] in_b      ,
  output reg              a_is_zero ,
  output reg  [WIDTH-1:0] alu_out    
 );

  localparam PASS0=0, PASS1=1, ADD=2, AND=3, XOR=4, PASSB=5, PASS6=6, PASS7=7;

  always @*
    begin
      a_is_zero = (in_a == 0);
      if ( opcode == ADD   ) alu_out = in_a + in_b; else
      if ( opcode == AND   ) alu_out = in_a & in_b; else
      if ( opcode == XOR   ) alu_out = in_a ^ in_b; else
      if ( opcode == PASSB ) alu_out = in_b ; else
                             alu_out = in_a ;
    end

endmodule
