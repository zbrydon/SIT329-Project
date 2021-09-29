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
//assign led[0] = (counter < 20) ? 1:0; //assigns led to 1 if the counter is below 20
//assign led[1] = (counter < 80) ? 1:0; //assigns led to 1 if the counter is below 80

endmodule