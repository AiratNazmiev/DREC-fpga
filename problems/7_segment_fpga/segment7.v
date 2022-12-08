module segment7(
	input clk,
	input [15:0]data,
	
	output [3:0]anodes,
	output reg [6:0]segments
);


// 7 segment 
reg [1:0]i = 0;

assign anodes = (4'b1 << i);

always @(posedge clk) begin 
	i <= i + 2'b1;
end

// sing +: and -: Notation part selection generic logic can be written.
// byte = data[j +: k]; 
// j  -> bit start position
// k -> Number of bits up from j’th position

//wire [3:0]d = data[i * 4 +: 4];
wire [3:0]d = i == 2'h0 ? data[3:0] :
				  i == 2'h1 ? data[7:4] :
				  i == 2'h2 ? data[11:8] :
								  data[15:12];


always @(*) begin
	case (d)
		4'h0: segments = 7'b1111110;
		4'h1: segments = 7'b0110000;
		4'h2: segments = 7'b1101101;
	   4'h3: segments = 7'b1111001;
	   4'h4: segments = 7'b0110011;
	   4'h5: segments = 7'b1011011;
	   4'h6: segments = 7'b1011111;
 	   4'h7: segments = 7'b1110000;
 	   4'h8: segments = 7'b1111111;
	   4'h9: segments = 7'b1111011;
	   4'hA: segments = 7'b1110111;
	   4'hB: segments = 7'b0011111;
	   4'hC: segments = 7'b1001110;
	   4'hD: segments = 7'b0111101;
	   4'hE: segments = 7'b1001111;
		4'hF: segments = 7'b1000111;
	endcase
end
//

endmodule
