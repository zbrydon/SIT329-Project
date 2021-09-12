module adc_demo_mega (
	CLOCK_50, 
	LED, 
	ADC_SCLK,
	ADC_CONVST, 
	ADC_SDO, 
	ADC_SDI	
	);

	input CLOCK_50;

	output [7:0] LED;
	input ADC_SDO;
	output ADC_SCLK, ADC_CONVST, ADC_SDI;
	wire [11:0] values;
	reg[7:0] result = 8'd0;
	
	reg[7:0] right = 8'd0;
	reg[7:0] left = 8'd0;
	
	reg[7:0] placeholder = 8'd0;
	
	//assign LED = values [11:4];
	
	always @(posedge CLOCK_50) begin
	
		result = values [11:4];
		
		// Shift right - Should divide by 2 
		result = result >> 1;
		
		if (result > 64) begin
			right = result - 64;
			placeholder = right;
		end else if (result < 64) begin
			left = 64 - result;
			placeholder = left;
		end else begin
			right = 0;
			left = 0;
		end
		
	end
	
	assign LED = placeholder;
		
	adc_control ADC (
	.CLOCK (CLOCK_50),
	.ADC_SCLK (ADC_SCLK),
	.ADC_CS_N (ADC_CONVST),
	.ADC_DOUT (ADC_SDO),
	.ADC_DIN (ADC_SDI),
	.CH0 (values)
	);

endmodule
