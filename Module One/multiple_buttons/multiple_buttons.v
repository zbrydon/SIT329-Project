//module button_debouncer(
//	input button_in,
//	input clk_in,
//	input reset,
//	output button_out
//);
//	reg q9, q8, q7, q6, q5, q4, q3, q2, q1, q0;
//
//	always @ ( posedge clk_in or posedge reset)
//
//	if (reset == 1'b1)
//		{q9, q8, q7, q6, q5, q4, q3, q2, q1, q0} <= 10'b0;
//	else begin
//		q9 <= q8; q8 <= q7; q7 <= q6; q6 <= q5; q5 <= q4;
//		q4 <= q3; q3 <= q2; q2 <= q1; q1 <= q0; q0 <= button_in;
//	end
//	
//	assign button_out = !q9 & q8 & q7 & q6 & q5 & q4 & q3 & q2 & q1 & q0;
//
//endmodule

//	button_debouncer drops_debounce(drops_button, clk, reset, BOARD_LEDs[0]);
//	button_debouncer hoods_debounce( hoods_button, clk, reset, BOARD_LEDs[1]);
//	button_debouncer tops_debounce( tops_button, clk, reset, BOARD_LEDs[2]);
//	button_debouncer bar_debounce( bar_button, clk, reset, BOARD_LEDs[3]);
//	button_debouncer seat_debounce( seat_button, clk, reset, BOARD_LEDs[4]);

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
