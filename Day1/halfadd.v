module halfadd (
	input wire Num_1, Num_2,
	output wire Sum, Carry
	);
	
assign Sum = Num_1 ^ Num_2;
assign Carry = Num_1 & Num_2;

endmodule
