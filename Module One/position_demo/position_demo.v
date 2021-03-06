module position_demo 
(
	input wire clk,
	input wire drops_button,
	input wire hoods_button, 
	input wire tops_button,
	input wire bar_button,
	input wire seat_button,
	input wire BUZZER,
	output wire [4:0] BOARD_LEDs
);

	reg drops, hoods, tops, bar, seat;
	buzzer_pwm b_p(seat, clk, BUZZER);
	initial begin
		drops <= 0;
		hoods <= 0;
		tops <= 0;
		bar <= 0;
		seat <= 0;
	end
	
	always @(*)begin
		drops = drops_button;
		hoods = hoods_button;
		tops = tops_button;
		bar = bar_button;
		seat = seat_button;
	end
	
	assign BOARD_LEDs[0] = drops;
	assign BOARD_LEDs[1] = hoods;
	assign BOARD_LEDs[2] = tops;
	assign BOARD_LEDs[3] = bar;
	assign BOARD_LEDs[4] = seat;
endmodule

module buzzer_pwm (
	input wire active,
	input wire clk, // 50MHz input clock
	output wire BUZZER //PIN_U13 -> D5
	);
	reg [31:0] buzzer_signal;
	reg [31:0] cnt; // 32-bit counter
	reg clk_enabler = 0;
	reg test = 0;
initial begin
cnt <= 32'h00000000; // start at zero
buzzer_signal <= 32'd0;
end

always @(posedge clk) begin
	cnt <= cnt + 1; // count up
	
	if (active) begin
		buzzer_signal <= cnt[16];
	end else begin
		buzzer_signal <= 32'd0;
	end
end

assign BUZZER = buzzer_signal;
endmodule
	
		