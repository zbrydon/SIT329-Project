module final_module(
	input module_one,
	input module_two,
	input module_three,
	input CLOCK_50,
	
	
	input drops_b,
	input hoods_b, 
	input tops_b,
	input bar_b,
	input seat_b,

	input adc_sdo, 

	output adc_sclk, 
	output adc_convst,
	output adc_sdi,
	output [7:0] LEDs,
	output buzzer,

	output pwmLED
	
);
	reg [7:0] final_LEDs;
	reg final_buzzer;

	reg [2:0] adc_switch;

	// adc_switch = module_two;
	// adc_switch = module_three;
	
	

	wire [4:0] button_LEDs;
	wire button_buzzer;

	wire [7:0] potentiometer_moisture;
	
	wire buzzer_replacement;
	
	

	multiple_buttons position (
	.clk (CLOCK_50),
	.drops_button (drops_b),
	.hoods_button (hoods_b), 
	.tops_button (tops_b),
	.bar_button (bar_b), 
	.seat_button (seat_b),
	.BOARD_LEDs (button_LEDs),
	.BUZZER (buzzer_replacement)
	);

	adc_demo_mega angle_moisture(
	.CLOCK_50 (CLOCK_50), 
	.LED (potentiometer_moisture), 
	.ADC_SCLK (adc_sclk),
	.ADC_CONVST (adc_convst), 
	.ADC_SDO (adc_sdo), 
	.ADC_SDI (adc_sdi),
	.switch(adc_switch),
	.LED_PWM (pwmLED)	
	);
	
	always @(posedge CLOCK_50)begin
		if (module_one) begin
			final_LEDs[5] = buzzer_replacement;
			final_LEDs[4] = button_LEDs[4];
			final_LEDs[3] = button_LEDs[3];
			final_LEDs[2] = button_LEDs[2];
			final_LEDs[1] = button_LEDs[1];
			final_LEDs[0] = button_LEDs[0];
			final_buzzer = button_buzzer;
			adc_switch[0] = 1;
			adc_switch[1] = 0;
			adc_switch[2] = 0;
		end else if (module_two) begin
			adc_switch[0] = 0;
			adc_switch[1] = 1;
			adc_switch[2] = 0;
			final_LEDs = potentiometer_moisture;
			final_buzzer = 0;
			//buzzer_replacement <= 0;
		end else if (module_three) begin
			adc_switch[0] = 0;
			adc_switch[1] = 0;
			adc_switch[2] = 1;
			final_LEDs = potentiometer_moisture;
			final_buzzer = 0;
			//buzzer_replacement <= 0;
		end
	end

	assign LEDs = final_LEDs;
	assign buzzer = final_buzzer;

endmodule 