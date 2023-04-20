module mismatch (clk, rst_n, A, B, C, D, dout);

  input  clk, rst_n;
  input  A, B, C;
  output D;
  output dout;
  logic  D, dout;

`ifndef sverilog

  // This is the Verilog behavioral code
  always@(A, B) begin
    D = (A & B) | C;
  end



  // Debug message for source
  `ifdef SYNTHESIS
    always $display("SYNTHESIS VERILOG");
  `else
    initial $display("TESTBENCH VERILOG");
  `endif

`else

  // Lab 1 Task 2 Step 8
  //
  // In the following code space, rewrite the always block with
  // the new SystemVerilog combinatorial coding style.
  //
  // ToDo:




  // Debug message for source
  `ifdef SYNTHESIS
    always $display("SYNTHESIS SVERILOG");
  `else
    initial $display("TESTBENCH SVERILOG");
  `endif

`endif

  always@(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
      dout <= 0;
    end else begin
      dout <= D;
    end
  end

endmodule
