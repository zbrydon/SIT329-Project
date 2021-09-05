module multiple_buttons(
	input wire clk,
	
	input wire drops_button,
	input wire hoods_button, 
	input wire tops_button,
	input wire bar_button,
	input wire seat_button,
	output wire [4:0] BOARD_LEDs,
	output wire BUZZER
	
);
	reg drops, hoods, tops, bar, seat;
	reg [31:0] cnt;

	initial begin
		drops <= 0;
		hoods <= 0;
		tops <= 0;
		bar <= 0;
		seat <= 0;
		cnt <= 32'h00000000;
	end
		
	always @(posedge drops_button or posedge hoods_button or posedge tops_button or posedge bar_button or posedge seat_button)begin
		drops = drops_button;
		hoods = hoods_button;
		tops = tops_button;
		bar = bar_button;
		seat = seat_button;
		
	end
	
	always @(posedge clk) begin
		if(seat) begin
			cnt <= cnt + 1; // count up
		end
	end
	
	assign BOARD_LEDs[0] = drops;
	assign BOARD_LEDs[1] = hoods;
	assign BOARD_LEDs[2] = tops;
	assign BOARD_LEDs[3] = bar;
	assign BOARD_LEDs[4] = seat;
	
	assign BUZZER = cnt[16];
	
endmodule

