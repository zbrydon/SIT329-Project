module ledPWM (
	input clk,
	input [6:0] dc,
	output led
	);
	
reg [7:0] counter = 0;

always@(posedge clk) begin
	if (counter < 100) counter <= counter + 1;
	else counter <= 0;
end

assign led = (counter < dc) ? 1 : 0;

endmodule