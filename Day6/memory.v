
module memory
#(
  parameter integer AWIDTH=5,
  parameter integer DWIDTH=8
 )
 (
  input  wire              clk  ,
  input  wire              wr   ,
  input  wire              rd   ,
  input  wire [AWIDTH-1:0] addr ,
  inout  wire [DWIDTH-1:0] data  
 );
  reg [DWIDTH-1:0] array [0:2**AWIDTH-1];
  always @(posedge clk)
    if ( wr ) array[addr] = data;
  assign data = rd ? array[addr] : 'bz;
endmodule
