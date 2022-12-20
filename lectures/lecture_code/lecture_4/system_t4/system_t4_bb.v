
module system_t4 (
	clk_clk,
	reset_reset_n,
	st2led_0_ledcom_export,
	st2led_0_ledseg_export);	

	input		clk_clk;
	input		reset_reset_n;
	output	[3:0]	st2led_0_ledcom_export;
	output	[7:0]	st2led_0_ledseg_export;
endmodule
