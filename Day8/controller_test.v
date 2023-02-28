module controller_test;

  localparam integer HLT=0, SKZ=1, ADD=2, AND=3, XOR=4, LDA=5, STO=6, JMP=7;

  reg  [2:0] opcode ;
  reg  [2:0] phase  ;
  reg        zero   ; // accumulator is zero
  wire       sel    ; // select instruction address to memory
  wire       rd     ; // enable memory output onto data bus
  wire       ld_ir  ; // load instruction register
  wire       inc_pc ; // increment program counter
  wire       halt   ; // halt machine
  wire       ld_pc  ; // load program counter
  wire       data_e ; // enable accumulator output onto data bus
  wire       ld_ac  ; // load accumulator from data bus
  wire       wr     ; // write data bus to memory

  controller controller_inst
  (
    .opcode ( opcode ),
    .phase  ( phase  ),
    .zero   ( zero   ),
    .sel    ( sel    ),
    .rd     ( rd     ),
    .ld_ir  ( ld_ir  ),
    .inc_pc ( inc_pc ),
    .halt   ( halt   ),
    .ld_pc  ( ld_pc  ),
    .data_e ( data_e ),
    .ld_ac  ( ld_ac  ),
    .wr     ( wr     ) 
  );

  task expect;
    input [8:0] exp_out;
    if ({sel,rd,ld_ir,inc_pc,halt,ld_pc,data_e,ld_ac,wr} !== exp_out) begin
      $display("\nTEST FAILED");
      $display("time\topcode phase zero sel rd ld_ir inc_pc halt ld_pc data_e ld_ac wr");
      $display("====\t====== ===== ==== === == ===== ====== ==== ===== ====== ===== ==");
      $display("%0d\t%d      %d     %b    %b   %b  %b     %b      %b    %b     %b      %b     %b",
               $time, opcode, phase, zero, sel, rd, ld_ir, inc_pc, halt, ld_pc,
               data_e, ld_ac, wr);
      $display("WANT\t                  %b   %b  %b     %b      %b    %b     %b      %b     %b",
               exp_out[8],exp_out[7],exp_out[6],exp_out[5],exp_out[4],exp_out[3],exp_out[2],exp_out[1],exp_out[0]);
      $finish;
    end
  endtask

  initial begin

    zero=0;

    $write("Testing opcode HLT phase"); opcode=HLT;
    $write(" 0"); phase=0; #1 expect (9'b100000000); // sel
    $write(" 1"); phase=1; #1 expect (9'b110000000); // sel, rd
    $write(" 2"); phase=2; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 3"); phase=3; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 4"); phase=4; #1 expect (9'b000110000); // inc_pc, halt
    $write(" 5"); phase=5; #1 expect (9'b000000000); //
    $write(" 6"); phase=6; #1 expect (9'b000000000); //
    $write(" 7"); phase=7; #1 expect (9'b000000000); //
    $write("\n");

    $write("Testing opcode SKZ phase"); opcode=SKZ;
    $write(" 0"); phase=0; #1 expect (9'b100000000); // sel
    $write(" 1"); phase=1; #1 expect (9'b110000000); // sel, rd
    $write(" 2"); phase=2; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 3"); phase=3; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 4"); phase=4; #1 expect (9'b000100000); // inc_pc
    $write(" 5"); phase=5; #1 expect (9'b000000000); //
    $write(" 6"); phase=6; #1 expect (9'b000000000); //
                  zero=1;  #1 expect (9'b000100000); // inc_pc
    $write(" 7"); phase=7; #1 expect (9'b000000000); //
    $write("\n");

    $write("Testing opcode ADD phase"); opcode=ADD;
    $write(" 0"); phase=0; #1 expect (9'b100000000); // sel
    $write(" 1"); phase=1; #1 expect (9'b110000000); // sel, rd
    $write(" 2"); phase=2; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 3"); phase=3; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 4"); phase=4; #1 expect (9'b000100000); // inc_pc
    $write(" 5"); phase=5; #1 expect (9'b010000000); // rd
    $write(" 6"); phase=6; #1 expect (9'b010000000); // rd
    $write(" 7"); phase=7; #1 expect (9'b010000010); // rd, ld_ac
    $write("\n");

    $write("Testing opcode AND phase"); opcode=AND;
    $write(" 0"); phase=0; #1 expect (9'b100000000); // sel
    $write(" 1"); phase=1; #1 expect (9'b110000000); // sel, rd
    $write(" 2"); phase=2; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 3"); phase=3; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 4"); phase=4; #1 expect (9'b000100000); // inc_pc
    $write(" 5"); phase=5; #1 expect (9'b010000000); // rd
    $write(" 6"); phase=6; #1 expect (9'b010000000); // rd
    $write(" 7"); phase=7; #1 expect (9'b010000010); // rd, ld_ac
    $write("\n");

    $write("Testing opcode XOR phase"); opcode=XOR;
    $write(" 0"); phase=0; #1 expect (9'b100000000); // sel
    $write(" 1"); phase=1; #1 expect (9'b110000000); // sel, rd
    $write(" 2"); phase=2; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 3"); phase=3; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 4"); phase=4; #1 expect (9'b000100000); // inc_pc
    $write(" 5"); phase=5; #1 expect (9'b010000000); // rd
    $write(" 6"); phase=6; #1 expect (9'b010000000); // rd
    $write(" 7"); phase=7; #1 expect (9'b010000010); // rd, ld_ac
    $write("\n");

    $write("Testing opcode LDA phase"); opcode=LDA;
    $write(" 0"); phase=0; #1 expect (9'b100000000); // sel
    $write(" 1"); phase=1; #1 expect (9'b110000000); // sel, rd
    $write(" 2"); phase=2; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 3"); phase=3; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 4"); phase=4; #1 expect (9'b000100000); // inc_pc
    $write(" 5"); phase=5; #1 expect (9'b010000000); // rd
    $write(" 6"); phase=6; #1 expect (9'b010000000); // rd
    $write(" 7"); phase=7; #1 expect (9'b010000010); // rd, ld_ac
    $write("\n");

    $write("Testing opcode STO phase"); opcode=STO;
    $write(" 0"); phase=0; #1 expect (9'b100000000); // sel
    $write(" 1"); phase=1; #1 expect (9'b110000000); // sel, rd
    $write(" 2"); phase=2; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 3"); phase=3; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 4"); phase=4; #1 expect (9'b000100000); // inc_pc
    $write(" 5"); phase=5; #1 expect (9'b000000000); //
    $write(" 6"); phase=6; #1 expect (9'b000000100); // data_e
    $write(" 7"); phase=7; #1 expect (9'b000000101); // data_e, wr
    $write("\n");

    $write("Testing opcode JMP phase"); opcode=JMP;
    $write(" 0"); phase=0; #1 expect (9'b100000000); // sel
    $write(" 1"); phase=1; #1 expect (9'b110000000); // sel, rd
    $write(" 2"); phase=2; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 3"); phase=3; #1 expect (9'b111000000); // sel, rd, ld_ir
    $write(" 4"); phase=4; #1 expect (9'b000100000); // inc_pc
    $write(" 5"); phase=5; #1 expect (9'b000000000); //
    $write(" 6"); phase=6; #1 expect (9'b000001000); // ld_pc
    $write(" 7"); phase=7; #1 expect (9'b000001000); // ld_pc

    $display("\nTEST PASSED");
    $finish;
  end

endmodule
