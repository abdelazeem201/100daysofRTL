module unintentional_latch (clk, rst_n, A, B, selA, dout);

  input  clk, rst_n;
  input  A, selA;
  output B, dout;
  logic  B, dout;

`ifndef sverilog

  // This is the Verilog behavioral code
  always@(selA, A) begin
    if (selA) begin
      B = A;
    end

    // Lab 1 Task 3 Step 8
    //
    // Complete the branch by assigning B to a default value like the following:
    //
    // else begin
    //   B = 0;
    // end
    //
    // ToDo:



  end

  // Debug message for source
  `ifdef SYNTHESIS
    always $display("SYNTHESIS VERILOG");
  `else
    initial $display("TESTBENCH VERILOG");
  `endif

`else

  // When the branch code is incomplete, SystemVerilog also treats it as a latch code
  always_comb begin
    if (selA) begin
      B = A;
    end

    // Lab 1 Task 3 Step 8
    //
    // Complete the branch by assigning B to a default value like the following:
    //
    // else begin
    //   B = 0;
    // end
    //
    // ToDo:



  end

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
      dout <= B;
    end
  end

endmodule
