// create module
module DisplayPosition (
		  output wire [7:0] LED
		  );

// create a binary counter
reg [7:0] cnt;
reg [3:0] choice;


initial begin

cnt <= 8'b0; // start at zero

//choice is x/8 amount done
choice <= 6;

end

always @(choice) begin
	case (choice) 
		3'd1: cnt <= 8'd1;
		3'd2: cnt <= 8'd3;
		3'd3: cnt <= 8'd7;
		3'd4: cnt <= 8'd15;
		3'd5: cnt <= 8'd31;
		3'd6: cnt <= 8'd63;
		3'd7: cnt <= 8'd127;
		3'd8: cnt <= 8'd255;
		default: cnt <= 8'd0;
	endcase
end

assign LED = cnt[7:0];

endmodule