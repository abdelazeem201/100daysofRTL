
module fifo (input clk, input reset_n, fifo_if.fslave_if b_if); 
  timeunit 1ns;
  timeprecision 100ps;
  import fifo_pkg::*;
  logic [BIT_DEPTH-1 : 0] wr_addr; // write fifo address
  logic [BIT_DEPTH-1 : 0] rd_addr; // read fifo address  
  buffer_t buffer; // fifo storage
  parameter shiftVal = int'(2**BIT_DEPTH) ;

  // Push on full with no pop error 
  property p_push_error; 
    @ (posedge clk) 
       not (b_if.push && b_if.full && !b_if.pop); 
  endproperty : p_push_error
  ap_push_error_1 : assert property (p_push_error);
  // mp_push_error : assume property (p_push_error);
  
  // No pop on empty 
  property p_pop_error; 
   @ (posedge clk) 
       not (b_if.pop && b_if.empty); 
  endproperty : p_pop_error
  ap_pop_error_1 : assert property (p_pop_error);
 // mp_pop_error : assume property (p_pop_error);
  
  // RTL Detailed design
  logic [1:0]            push_pop;
  // Defining control for maintenance of FIFO word count
  assign             push_pop = {b_if.push , b_if.pop};    // temporary concatenation 
  // providing READ data to output
  assign b_if.data_out = buffer[rd_addr];

  // purpose: writes data from FIFO and controls
  //          words within the FIFO.  It also provides the READ and
  //          WRITE Fifo Addresses. 
 
  always @ (posedge clk or negedge reset_n) 
    begin 
    if (!reset_n)  
        begin  // asynchronous reset (active low)
          rd_addr         <= 0;
          wr_addr         <= 0;
        end
      else
        begin
          case (push_pop)
        2'b00 :
        ;              // no push, no pop
            
            2'b01 : 
              begin                   // no push, pop for READ 
                rd_addr         <= (rd_addr+1) % shiftVal;
              end   
            2'b10 :                    // push for WRITE, no pop
              begin              
                wr_addr         <= (wr_addr + 1) % shiftVal;
                buffer[wr_addr] <= b_if.data_in;
              end
            2'b11 :                    // push for WRITE, pop for READ
              begin
                 rd_addr <= (rd_addr+1) % shiftVal;
                wr_addr <= (wr_addr + 1) % shiftVal;
                buffer[wr_addr] <= b_if.data_in;
              end
           default  :
           begin
              a_illegal_fifo_cmd_1 : assert (1'b0) else
                 $warning ("%0t %0m Meta value detected in FIFO command, push_pop %2b ",
                           $time, push_pop);
           end
           
           endcase
        end //else
    end //always

  // Reporting of flags
  // properties used as guide for this design since they define
  // the requirements
  
  always @ (posedge clk)
  begin
    b_if.error <= (b_if.pop && b_if.empty) || (b_if.push && b_if.full && !b_if.pop);
  end // always
  
  assign b_if.full = (wr_addr - rd_addr) == FULL;
  assign b_if.empty = (wr_addr == rd_addr);
  assign b_if.almost_full = (wr_addr - rd_addr) >= ALMOST_FULL;
  assign b_if.almost_empty = (wr_addr - rd_addr) <= ALMOST_EMPTY;
  

endmodule : fifo
