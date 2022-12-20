
module simple_nios_vga
    (
      input  wire     clk_50Mhz, 
		 
	// VGA
		output wire [4:0] video_r,
		output wire [5:0] video_g,
		output wire [4:0] video_b,
		output wire video_h_sync,
		output wire video_v_sync,
		
	// SDRAM   
		  output	wire[12:0]	sdram_addr,
	     output	wire [1:0]	sdram_ba,
	     output	wire	sdram_cas_n,
	     output	wire	sdram_cke,
	     output	wire	sdram_cs_n,
	     inout	wire [15:0]	sdram_dq,
	     output	wire [1:0]	sdram_dqm,
	     output	wire	sdram_ras_n,
	     output	wire	sdram_we_n,
		  output wire  sdram_clk,
   //KEYS
        input wire [3:0] keys_input
    );
	 
	wire [7:0] video;

//	assign video_r = {video[7:5], 2'b0}; // better  to rewrite bit filling
//	assign video_g = {video[4:2], 3'b0};
//	assign video_b = {video[1:0], 2'b0};
	
	assign video_r = {video[7:5], {2{video[5]}}};
	assign video_g = {video[4:2], {3{video[2]}}};
	assign video_b = {video[1:0], {2{video[0]}}};

	wire sys_clk;
	wire sdram_clk_;
	wire sys_clk_;
	
	pll1 pll1_i (
	.inclk0(clk_50Mhz),
	.c0(sys_clk_),
	.c1(sdram_clk_));
	
/*	clkdriver clkdriver_1 (
		.inclk  (sdram_clk_),  //  altclkctrl_input.inclk
		.outclk (sdram_clk)  // altclkctrl_output.outclk
	);
*/
  //assign sdram_clk = sdram_clk_;
  clkinter clkinter1 (
		.inclk  (sdram_clk_),  //  altclkctrl_input.inclk
		.outclk (sdram_clk)  // altclkctrl_output.outclk
	);
  
  	clkinter clkinter0 (
		.inclk  (sys_clk_),  //  altclkctrl_input.inclk
		.outclk (sys_clk)  // altclkctrl_output.outclk
	);

	 
	system_t3 u0 (
		.clk_clk       (sys_clk),       //   clk.clk
		.reset_reset_n (1), // reset.reset_n
		.sdram_addr    (sdram_addr),    // sdram.addr
		.sdram_ba      (sdram_ba),      //      .ba
		.sdram_cas_n   (sdram_cas_n),   //      .cas_n
		.sdram_cke     (sdram_cke),     //      .cke
		.sdram_cs_n    (sdram_cs_n),    //      .cs_n
		.sdram_dq      (sdram_dq),      //      .dq
		.sdram_dqm     (sdram_dqm),     //      .dqm
		.sdram_ras_n   (sdram_ras_n),   //      .ras_n
		.sdram_we_n    (sdram_we_n),     //      .we_n
		.st2vga_video_data   (video),   // st2vga.video_data
		.st2vga_video_h_sync (video_h_sync), //       .video_h_sync
		.st2vga_video_v_sync (video_v_sync),  //       .video_v_sync
		.parallel_port_0_export(keys_input)
	);


	 
	 
endmodule
