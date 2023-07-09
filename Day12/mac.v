module mac (z, a, b, c, clk, ct1, ct2);

output[32:0]	z;
input[15:0]	a, b;
input[31:0]	c;
input		ct1, ct2, clk;

reg[15:0]	a_r, b_r;	// sync input a, b;
reg[31:0]       c_r;            // sync input c;
reg[31:0]       c_rr, m1_r;     // sync neg registers;
reg[15:0]	a_lt, a_lm, b_lt, b_lm;	
				// latch output;
reg[31:0]	m1, m2, m3;	// mux output;
reg[32:0]	z;		// output

wire[31:0]	_mul_out_, _concat_out_;
wire[32:0]	_add_out_;


// adder and mulplier block
assign	_mul_out_ = a_lm * b_lm;
assign	_concat_out_ = { b_lt, a_lt};
assign	_add_out_ = m2 + m3;


// latches
always @ (ct1 or ct2 or a_r or b_r)
begin
case ({ct2, ct1})
	2'd2:	begin a_lt <= a_r; b_lt <= b_r; end
	default: begin a_lm <= a_r; b_lm <= b_r; end
endcase
end


// register bank
always @ (posedge clk)
begin
	a_r <= a;
	b_r <= b;
	c_r <= c;
	z   <= _add_out_;
end

always @ (negedge clk)
begin
	c_rr <= c_r;
	m1_r <= m1;
end

// muxes
always @ (ct1 or ct2 or _mul_out_ or _concat_out_ or m1 or m1_r or c_r or c_rr)
begin
case ({ct2, ct1})
        2'd0:   begin m1 <= _mul_out_; m2 <= m1; m3 <= c_r; end
	2'd1:	begin m1 <= _mul_out_; m2 <= m1_r; m3 <= c_rr; end
	2'd2:	begin m1 <= _concat_out_; m2 <= m1_r; m3 <= c_rr; end
	2'd3:	begin m1 <= _mul_out_; m2 <= m1_r; m3 <= c_rr; end
endcase
end

endmodule
