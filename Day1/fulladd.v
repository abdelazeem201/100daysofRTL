module fulladd (
	input wire Num_1, Num_2, C_in
	output wire Sum, Carry
	);

wire Sum_1, Carry_1, Carry_2;

halfadd U1 (.Num_1(Num_1), .Num_2(Num_2), .Sum(Sum_1), .Carry(Carry_1));	
halfadd U2 (.Num_1(Sum_1), .Num_2(C_in), .Sum(Sum), .Carry(Carry_2));
or 		U3 (Carry, Carry_1, Carry_2);

endmodule
