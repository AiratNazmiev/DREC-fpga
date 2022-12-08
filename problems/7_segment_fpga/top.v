module top(
	input clk, // 50MHz
	
	output DS_EN_1, DS_EN_2, DS_EN_3, DS_EN_4,
	output DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G
);

reg [15:0]data = 16'h0_0_0_0;

wire [3:0]anodes;
assign {DS_EN_1, DS_EN_2, DS_EN_3, DS_EN_4} = ~anodes;

wire [6:0]segments;
assign {DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G} = segments;

clk_div #(15) clk_div1(.clk(clk), .clk_out(clk_anodes)); // 0.76kHz
clk_div #(21) clk_div2(.clk(clk), .clk_out(clk_inc));    // 12Hz

always @(posedge clk_inc) begin
    data <= data + 1;
end


segment7 segment7(.clk(clk_anodes), .data(data), .anodes(anodes), .segments(segments));


endmodule