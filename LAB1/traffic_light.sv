// Lab 1 Task 4 Step 4
//
// Create the enum data type.
//
// ToDo:



module traffic_light(input logic clk, reset_n, output logic green_on, yellow_on, red_on);
// Lab 1 Task 4 Step 5
//
// Change state and nxt_state to the enum data type.
//
// ToDo:
logic [2:0] state, nxt_state;


logic [5:0] count_seconds;
logic       reset_count;

// Lab 1 Task 4 Step 6
//
// Change all reference to state value to the enum state values.
// See lab writeup for guidance.
//
// ToDo:
always_comb begin
  nxt_state    = state;
  reset_count  = 1'b0;
  red_on       = 1'b0;
  green_on     = 1'b0;
  yellow_on    = 1'b0;
  case(1'b1)
    state[0]: begin
                red_on = 1'b1;
                if (count_seconds >= 20) begin
                  nxt_state    = 3'b010;
                  reset_count  = 1'b1;
                end
              end
    state[1]: begin
                green_on = 1'b1;
                if (count_seconds >= 20) begin
                  nxt_state    = 3'b100;
                  reset_count  = 1'b1;
                end
              end
    state[2]: begin
                yellow_on = 1'b1;
                if (count_seconds >= 3) begin
                  nxt_state    = 3'b001;
                  reset_count  = 1'b1;
                end
              end
    default: ;
  endcase
end

always_ff @(posedge clk or negedge reset_n) begin
  if (!reset_n) begin
    state     <= 3'b001;
  end else begin
    state     <= nxt_state;
  end
end

always_ff @(posedge clk or negedge reset_n) begin
  if (!reset_n) begin
    count_seconds   <= '0;
  end else begin
    if (reset_count) begin
      count_seconds <= '0;
    end else begin
      count_seconds <= count_seconds + 1;
    end
  end
end

endmodule
