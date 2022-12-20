module simple_vga_scan (
    input  wire  clk_pix,   // pixel clock
    input  wire  rst_pix,   // reset in pixel clock domain
    output  reg    [9:0] sx,  // horizontal screen position
    output  reg    [9:0] sy,  // vertical screen position
    output  wire     hsync,     // horizontal sync
    output  wire     vsync,     // vertical sync
    output  wire     de         // data enable (low in blanking interval)
    );

    // horizontal timings
    parameter HA_END = 639;           // end of active pixels
    parameter HS_STA = HA_END + 16;   // sync starts after front porch
    parameter HS_END = HS_STA + 96;   // sync ends
    parameter LINE   = 799;           // last pixel on line (after back porch)

    // vertical timings
    parameter VA_END = 479;           // end of active pixels
    parameter VS_STA = VA_END + 10;   // sync starts after front porch
    parameter VS_END = VS_STA + 2;    // sync ends
    parameter SCREEN = 524;           // last line on screen (after back porch)


    assign hsync = ~(sx >= HS_STA && sx < HS_END);  // invert: negative polarity
    assign vsync = ~(sy >= VS_STA && sy < VS_END);  // invert: negative polarity
    assign de = (sx <= HA_END && sy <= VA_END);
    

    // calculate horizontal and vertical screen position
    always @(posedge clk_pix) begin
		if (rst_pix) begin
			sx <= 0;
         sy <= 0;
		end else
		begin
        if (sx == LINE) begin  // last pixel on line?
            sx <= 0;
            sy <= (sy == SCREEN) ? 0 : sy + 1;  // last line on screen?
        end else begin
            sx <= sx + 1;
        end
      end
    end
endmodule


module simple_vga
	(
	input wire clk_50Mhz,
	
	output wire [4:0] video_r,
	output wire [5:0] video_g,
	output wire [4:0] video_b,
	output wire video_h_sync,
	output wire video_v_sync
	
	);
	
	wire [9:0]sy;
	wire [9:0]sx;
	wire de;
	reg clk_25Mhz;
	always @(posedge clk_50Mhz) begin
		clk_25Mhz <= !clk_25Mhz;
	end
	
	
	simple_vga_scan 
		simple_vga_inst
	(  .clk_pix(clk_25Mhz),
		.rst_pix(0),
		.sx(sx),
		.sy(sy),
		.hsync(video_h_sync),
		.vsync(video_v_sync),
		.de(de));
	
	assign video_r = de ? sx[4:0] : 0;
	assign video_g = de ? sy[5:0] : 0;
	assign video_b = de ? sy[4:0] : 0;
	
	
endmodule
