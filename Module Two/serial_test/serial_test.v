module serial_test (
	CLOCK_50,
	RXD,
	TXD

	);
	input CLOCK_50;
	input RXD;
	output TXD;
	
	reg reset_, address_, chipselect_, read_, write_;
	reg[3:0] byteenable_;
	
	reg[31:0] writedata_ = 32'b1;
	reg[31:0] readdata_;
	
	
	
	wire irq_;
	
	serial_control serial(
	.clk_clk(CLOCK_50),
	.reset_reset_n(reset_),
	.rs232_0_address(address_),
	.rs232_0_chipselect(chipselect_),
	.rs232_0_byteenable(byteenable_),
	.rs232_0_read(read_),
	.rs232_0_write(write_),
	.rs232_0_writedata(writedata_),
	.rs232_0_readdata(readdata_),
	.rs232_0_irq(irq_),
	.rs232_0_UART_RXD(RXD),
	.rs232_0_UART_TXD(TXD)
	);
	
endmodule


