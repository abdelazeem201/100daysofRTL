module risc
(
  input  wire clk,
  input  wire rst,
  output wire halt
);

  localparam integer AWIDTH=5, DWIDTH=8 ;


  /////////////////////
  // CLOCK GENERATOR //
  /////////////////////

  wire [2:0] phase ;

  counter
  #(
    .WIDTH   ( 3  ) 
   )
    counter_clk
   (
    .clk     ( clk   ),
    .rst     ( rst   ),
    .load    ( 1'b0  ),
    .enab    ( !halt ),
    .cnt_in  ( 3'b0  ),
    .cnt_out ( phase ) 
   ) ;


  ////////////////
  // CONTROLLER //
  ////////////////

  wire [2:0] opcode ;

  controller controller_inst
  (
    .opcode  ( opcode ), // operation code
    .phase   ( phase  ), // instruction phase
    .zero    ( zero   ), // accumulator is zero
    .sel     ( sel    ), // select instruction address to memory
    .rd      ( rd     ), // enable memory output onto data bus
    .ld_ir   ( ld_ir  ), // load instruction register
    .inc_pc  ( inc_pc ), // increment program counter
    .halt    ( halt   ), // halt machine
    .ld_pc   ( ld_pc  ), // load program counter
    .data_e  ( data_e ), // enable accumulator output onto data bus
    .ld_ac   ( ld_ac  ), // load accumulator from data bus
    .wr      ( wr     )  // write data bus to memory
  ) ;


  /////////////////////
  // PROGRAM COUNTER //
  /////////////////////

  wire [AWIDTH-1:0] ir_addr, pc_addr ;

  counter
  #(
    .WIDTH   ( AWIDTH  ) 
   )
    counter_pc
   (
    .clk     ( clk     ),
    .rst     ( rst     ),
    .load    ( ld_pc   ),
    .enab    ( inc_pc  ),
    .cnt_in  ( ir_addr ),
    .cnt_out ( pc_addr ) 
   ) ;


  /////////////////////
  // ADDESS SELECTOR //
  /////////////////////

  wire [AWIDTH-1:0] addr ;

  multiplexor
  #(
    .WIDTH   ( AWIDTH  ) 
   )
    address_mux
   (
    .sel     ( sel     ),
    .in0     ( ir_addr ),
    .in1     ( pc_addr ),
    .mux_out ( addr    ) 
   ) ;


  /////////////////////////
  // DATA/PROGRAM MEMORY //
  /////////////////////////

  wire [DWIDTH-1:0] data ;

  memory
  #(
    .AWIDTH ( AWIDTH ),
    .DWIDTH ( DWIDTH ) 
   )
    memory_inst
   (
    .clk    ( clk    ),
    .wr     ( wr     ),
    .rd     ( rd     ),
    .addr   ( addr   ),
    .data   ( data   ) 
   ) ;


  //////////////////////////
  // INSTRUCTION REGISTER //
  //////////////////////////

  register
  #(
    .WIDTH    ( DWIDTH ) 
   )
    register_ir
   (
    .clk      ( clk    ),
    .rst      ( rst    ),
    .load     ( ld_ir  ),
    .data_in  ( data   ),
    .data_out ( {opcode,ir_addr} )
   ) ;


  ////////////////////////
  // ARITHMETIC & LOGIC //
  ////////////////////////

  wire [DWIDTH-1:0] acc_out, alu_out ;

  alu
  #(
    .WIDTH     ( DWIDTH ) 
   )
    alu_inst
   (
    .opcode    ( opcode  ),
    .in_a      ( acc_out ),
    .in_b      ( data    ),
    .a_is_zero ( zero    ),
    .alu_out   ( alu_out ) 
   ) ;


  //////////////////////////
  // ACCUMULATOR REGISTER //
  //////////////////////////

  register
  #(
    .WIDTH    ( DWIDTH  ) 
   )
    register_ac
   (
    .clk      ( clk     ),
    .rst      ( rst     ),
    .load     ( ld_ac   ),
    .data_in  ( alu_out ),
    .data_out ( acc_out ) 
   ) ;


  //////////////////////////
  // BUS DRIVER           //
  //////////////////////////

  driver
  #(
    .WIDTH    ( DWIDTH  ) 
   )
    driver_inst
   (
    .data_en  ( data_e  ),
    .data_in  ( alu_out ),
    .data_out ( data    ) 
   ) ;

endmodule
