module multiplexor
#(
  parameter WIDTH=5
 )
 (
  input  wire             sel  ,
  input  wire [WIDTH-1:0] in0  ,
  input  wire [WIDTH-1:0] in1  ,
  output reg  [WIDTH-1:0] mux_out
 );

  always @*
    if ( sel )
      mux_out = in1 ;
    else
      mux_out = in0 ;

endmodule
