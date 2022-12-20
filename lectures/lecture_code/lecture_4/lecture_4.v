module lecture_4(
	input wire clk_50Mhz,
	output wire [7:0]ds_seg,
	output wire [3:0]ds_com
);

	system_t4 u0 (
		.clk_clk                (clk_50Mhz),                //             clk.clk
		.reset_reset_n          (1),          //           reset.reset_n
		.st2led_0_ledcom_export (ds_seg), // st2led_0_ledcom.export
		.st2led_0_ledseg_export (ds_com)  // st2led_0_ledseg.export
	);


endmodule