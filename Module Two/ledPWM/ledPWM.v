`timescale 1ns / 1 ps

module ledPWM (
	input clk,
	output[1:0] led
	);
	
reg [7:0] counter = 0;

always@(posedge clk) begin
	if (counter < 100) counter <= counter + 1;
	else counter <= 0;
end

assign led[0] = (counter < 20) ? 1:0; //assigns led to 1 if the counter is below 20

assign led[1] = (counter < 80) ? 1:0; //assigns led to 1 if the counter is below 80

endmodule