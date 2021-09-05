// create module
	module buzzer_pwm (
	input wire clk, // 50MHz input clock
	output wire BUZZER //PIN_U13 -> D5
	);

// create a binary counter
	reg [31:0] cnt; // 32-bit counter
	reg clk_enabler = 0;
	reg test = 0;
initial begin
cnt <= 32'h00000000; // start at zero
end

always @(posedge clk) begin
	cnt <= cnt + 1; // count up
end

assign BUZZER = cnt[16];
endmodule