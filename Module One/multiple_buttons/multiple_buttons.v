module multiple_buttons(
	input wire clk,
	
	input wire drops_button,
	input wire hoods_button, 
	input wire tops_button,
	input wire bar_button,
	input wire seat_button,
	output wire [4:0] BOARD_LEDs
	// ToDo: Add buzzer output
);
	reg drops, hoods, tops, bar, seat;

	initial begin
		drops <= 0;
		hoods <= 0;
		tops <= 0;
		bar <= 0;
		seat <= 0;
	end
		
	always @(posedge drops_button or posedge hoods_button or posedge tops_button or posedge bar_button or posedge seat_button)begin
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
