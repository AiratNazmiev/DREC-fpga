
module system_t3 (
	clk_clk,
	reset_reset_n,
	sdram_addr,
	sdram_ba,
	sdram_cas_n,
	sdram_cke,
	sdram_cs_n,
	sdram_dq,
	sdram_dqm,
	sdram_ras_n,
	sdram_we_n,
	st2vga_video_data,
	st2vga_video_h_sync,
	st2vga_video_v_sync,
	parallel_port_0_export);	

	input		clk_clk;
	input		reset_reset_n;
	output	[11:0]	sdram_addr;
	output	[1:0]	sdram_ba;
	output		sdram_cas_n;
	output		sdram_cke;
	output		sdram_cs_n;
	inout	[15:0]	sdram_dq;
	output	[1:0]	sdram_dqm;
	output		sdram_ras_n;
	output		sdram_we_n;
	output	[7:0]	st2vga_video_data;
	output		st2vga_video_h_sync;
	output		st2vga_video_v_sync;
	input	[3:0]	parallel_port_0_export;
endmodule
