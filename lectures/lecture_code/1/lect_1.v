module lect_1(
	input wire clk_50Mhz
	);
	
	t1_system u0 (
		.clk_clk       (clk_50Mhz),       //   clk.clk
		.reset_reset_n (1)  // reset.reset_n
	);


endmodule
