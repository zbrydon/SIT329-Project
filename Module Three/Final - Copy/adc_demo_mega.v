module adc_demo_mega (
	CLOCK_50, 
	LED, 
	ADC_SCLK,
	ADC_CONVST, 
	ADC_SDO, 
	ADC_SDI,
	switch,
	LED_PWM
	);

	input CLOCK_50;
	input [2:0] switch;

	output [7:0] LED;
	input ADC_SDO;
	output ADC_SCLK, ADC_CONVST, ADC_SDI;
	output LED_PWM;
	wire [11:0] values [1:0];
	reg[7:0] result = 8'd0;
	
	reg[7:0] right = 8'd0;
	reg[7:0] left = 8'd0;
	
	reg[7:0] placeholder = 8'd0;
	reg[6:0] pwm_led = 7'd0;
	
	//assign LED = values [11:4];

	always @(posedge CLOCK_50) begin
		if (switch[2]) begin
			//MODULE 3 ( MOISTURE )
			//placeholder = values [1] [11:4];
			placeholder = 8'b11111111;
			pwm_led = 7'd0;
		end else if (switch[1]) begin
			//MODULE 2 ( POTENTIOMETER )
			pwm_led = values [0] [11:5];



			//--OLD Update onBoard LEDS--
			result = values [0] [11:4];
			
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
			//----------------------------
		end else if(switch[0] )begin
			//MODULE 1 ( DO NOTHING )
			pwm_led = 7'd0;
			placeholder = 8'd0;
		end
	end
	
	assign LED = placeholder;

	ledPWM PWMLED(
		.clk (CLOCK_50),
		.dc (pwm_led),
		.led (LED_PWM)
	);
	
		
	adc_control ADC (
	.CLOCK (CLOCK_50),
	.ADC_SCLK (ADC_SCLK),
	.ADC_CS_N (ADC_CONVST),
	.ADC_DOUT (ADC_SDO),
	.ADC_DIN (ADC_SDI),
	.CH0 (values[0]),
	.CH1 (values[1])
	);

endmodule
