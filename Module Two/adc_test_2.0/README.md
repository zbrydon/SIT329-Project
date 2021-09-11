# ADC Tutorial on DE10-Nano

To create the controller navigate to the **Tools => IP Catalog**. 

Once open select **University Program => Generic IO => ADC Controller for DE-series boards**.

The following window will appear, set the **Entity name** equal to *adc_control*. 

Ensure the rest of the options are relevant to your project and board, then click **OK**.

![Screenshot One](https://github.com/zbrydon/SIT329-Project/blob/main/Module%20Two/adc_test_2.0/images/one.png?raw=true)

Set the values in the next window equal to those in follwing figure, then click **Generate HDL**.

![Screenshot Two](https://github.com/zbrydon/SIT329-Project/blob/main/Module%20Two/adc_test_2.0/images/two.png?raw=true)

The following window will appear, to continue click **Generate**.

![Screenshot Three](https://github.com/zbrydon/SIT329-Project/blob/main/Module%20Two/adc_test_2.0/images/three.png?raw=true)

Once the save and generation process are completed, click **Close** in their respective windows.

![Screenshot Four](https://github.com/zbrydon/SIT329-Project/blob/main/Module%20Two/adc_test_2.0/images/four.png?raw=true)

![Screenshot Five](https://github.com/zbrydon/SIT329-Project/blob/main/Module%20Two/adc_test_2.0/images/five.png?raw=true)

Then the generated files need to be added to the project files. 
To do this navigate to **Project => Add/Remove files in Project...**, select the three dots to the right of the file path. 

Navigate to your project, from there go to ***adc_control/synthesis*** and select the ***adc_control.qip*** file.

Then click apply.

![Add Files](https://github.com/zbrydon/SIT329-Project/blob/main/Module%20Two/adc_test_2.0/images/add_files.png?raw=true)

Add the code in the following file to the project ans ensure that the module *adc_demo_mega* is recognised as the top-level entity.  

To do this navigate to **Edit Settings** on the left side of the Quartus interface.

From there select **General** and modify the **Top-level entity:** field. 

```
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
	output resLED;
	input ADC_SDO;
	output ADC_SCLK, ADC_CONVST, ADC_SDI;
	wire [11:0] values;
	assign LED = values [11:4];
		
	adc_control ADC (
	.CLOCK (CLOCK_50),
	.ADC_SCLK (ADC_SCLK),
	.ADC_CS_N (ADC_CONVST),
	.ADC_DOUT (ADC_SDO),
	.ADC_DIN (ADC_SDI),
	.CH0 (values)
	);

endmodule
```

Compile the design.

Then add the pin assignments listed below. 

![Pin Assignments](https://github.com/zbrydon/SIT329-Project/blob/main/Module%20Two/adc_test_2.0/images/pin_assignments.png?raw=true)


**Note:** This is how to get an ADC working from scratch, pulling this repository and running this module should also achieve similar results but it contains prototype features that are still in development.
