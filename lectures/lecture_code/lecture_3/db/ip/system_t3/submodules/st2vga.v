module st2vga
	#(parameter
		WIDTH = 8,
		DIV = 5)
	(
	input clk_clk,
	input reset_reset_n,
	output ready,
	input valid,
	input [WIDTH-1:0]data,
	input startofpacket,
	input endofpacket,
	
	output wire [WIDTH-1:0] video_data,
	output wire video_h_sync,
	output wire video_v_sync
	
	);
	
	wire [9:0]sy;
	wire [9:0]sx;
	wire de;
	reg [$clog2(DIV)-1:0] div_cnt;
	reg startofpacket_shifted;
	
	always @(posedge clk_clk) begin
		if (reset_reset_n) begin
			div_cnt <= (div_cnt == (DIV-1)) ? 0 : div_cnt + 1;
			if (div_cnt == 0) begin
				startofpacket_shifted <= startofpacket;
			end;
		end else begin
			div_cnt <= 0;
			startofpacket_shifted <= 0;
		end
	end
	
	wire clk_25Mhz;
	assign clk_25Mhz = (div_cnt == 0);
	
	assign ready = clk_25Mhz & de;
	assign video_data = de & valid ? data : 0;
	wire scan_reset;
	assign scan_reset = (~reset_reset_n) | (startofpacket & de);
	
	
	simple_vga_scan 
		simple_vga_inst
	(  .clk_pix(clk_25Mhz),
		.rst_pix(scan_reset),
		.sx(sx),
		.sy(sy),
		.hsync(video_h_sync),
		.vsync(video_v_sync),
		.de(de));
	
	
endmodule
