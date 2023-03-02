module counter
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

  reg [WIDTH-1:0] cnt_tmp;

  function [WIDTH-1:0] cnt_func;
    input rst  ;
    input load ;
    input enab ;
    input [WIDTH-1:0] cnt_in ;
    input [WIDTH-1:0] cnt_out;
    if ( rst  ) cnt_func = 0; else
    if ( load ) cnt_func = cnt_in; else
    if ( enab ) cnt_func = cnt_out + 1; else
                cnt_func = cnt_out;
  endfunction

  always @(posedge clk)
    cnt_out <= cnt_func (rst, load, enab ,cnt_in, cnt_out);

endmodule
