
module serial_control (
	rs232_0_address,
	rs232_0_chipselect,
	rs232_0_byteenable,
	rs232_0_read,
	rs232_0_write,
	rs232_0_writedata,
	rs232_0_readdata,
	rs232_0_irq,
	rs232_0_UART_RXD,
	rs232_0_UART_TXD,
	clk_clk,
	reset_reset_n);	

	input		rs232_0_address;
	input		rs232_0_chipselect;
	input	[3:0]	rs232_0_byteenable;
	input		rs232_0_read;
	input		rs232_0_write;
	input	[31:0]	rs232_0_writedata;
	output	[31:0]	rs232_0_readdata;
	output		rs232_0_irq;
	input		rs232_0_UART_RXD;
	output		rs232_0_UART_TXD;
	input		clk_clk;
	input		reset_reset_n;
endmodule
