// clkinter.v

// Generated using ACDS version 18.0 614

`timescale 1 ps / 1 ps
module clkinter (
		input  wire  inclk,  //  altclkctrl_input.inclk
		output wire  outclk  // altclkctrl_output.outclk
	);

	clkinter_altclkctrl_0 altclkctrl_0 (
		.inclk  (inclk),  //  altclkctrl_input.inclk
		.outclk (outclk)  // altclkctrl_output.outclk
	);

endmodule
