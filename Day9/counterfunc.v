module counterfunc
#(
  parameter integer WIDTH=5
 )
 (
  input  wire clk  ,
  input  wire rst  ,
  input  wire load ,
  input  wire enab ,
  input  wire [WIDTH-1:0] cnt_in ,
  output reg  [WIDTH-1:0] cnt_out 
 );

  
//////////////////////////////////////////////////////////////////////////////
//TO DO: DEFINE THE COUNTER COMBINATIONAL LOGIC using FUNCTION AS INSTRUCTED//
//////////////////////////////////////////////////////////////////////////////

  always @(posedge clk)
     cnt_out <= cnt_func (rst, load, enab ,cnt_in, cnt_out); //function call

endmodule
