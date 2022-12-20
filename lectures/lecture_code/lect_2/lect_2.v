module lect_2(
	input clk_50
	);
	
system_t1 system_t1_u0 (
	.clk_clk       (clk_50),       //   clk.clk
	.reset_reset_n (1)  // reset.reset_n
);

	
endmodule