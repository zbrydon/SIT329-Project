module adc_demo_mega (
	CLOCK_50, 
	LED, 
	resLED,
	ADC_SCLK,
	ADC_CONVST, 
	ADC_SDO, 
	ADC_SDI	
	);


	input CLOCK_50;

	output [7:0] LED;
	output resLED;
	input ADC_SDO;
	output ADC_SCLK, ADC_CONVST, ADC_SDI;
	wire [11:0] values;
	reg[7:0] result = 8'd0;
	
	reg right = 8'd0;
	reg left = 8'd0;
	
	reg x = 0;
	
	assign LED = values [11:4];
	
	always @(posedge CLOCK_50) begin
	
		result[0] = values [4];
		result[1] = values [5];
		result[2] = values [6];
		result[3] = values [7];
		result[4] = values [8];
		result[5] = values [9];
		result[6] = values [10];
		result[7] = values [11];
		
		result[0] = result[1];
		result[1] = result[2];
		result[2] = result[3];
		result[3] = result[4];
		result[4] = result[5];
		result[5] = result[6];
		result[6] = result[7];
		result[7] = 0;
		
		
		if (result > 64) begin
			right = result - 64;
		end else if (result < 64) begin
			left = 64 - result;
		end else begin
			right = 0;
			left = 0;
		end
		
		if ( right == 64 || left == 64 || right == 0 || left == 0) begin
			x = 1;
		end else begin
			x = 0;
		end
		
	end
	
	assign resLED = x;
		

	adc_control ADC (
	.CLOCK (CLOCK_50),
	.ADC_SCLK (ADC_SCLK),
	.ADC_CS_N (ADC_CONVST),
	.ADC_DOUT (ADC_SDO),
	.ADC_DIN (ADC_SDI),
	.CH0 (values)
	);

endmodule
