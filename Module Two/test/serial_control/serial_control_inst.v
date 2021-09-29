	serial_control u0 (
		.rs232_0_address    (<connected-to-rs232_0_address>),    // rs232_0_avalon_rs232_slave.address
		.rs232_0_chipselect (<connected-to-rs232_0_chipselect>), //                           .chipselect
		.rs232_0_byteenable (<connected-to-rs232_0_byteenable>), //                           .byteenable
		.rs232_0_read       (<connected-to-rs232_0_read>),       //                           .read
		.rs232_0_write      (<connected-to-rs232_0_write>),      //                           .write
		.rs232_0_writedata  (<connected-to-rs232_0_writedata>),  //                           .writedata
		.rs232_0_readdata   (<connected-to-rs232_0_readdata>),   //                           .readdata
		.rs232_0_irq        (<connected-to-rs232_0_irq>),        //          rs232_0_interrupt.irq
		.rs232_0_UART_RXD   (<connected-to-rs232_0_UART_RXD>),   // rs232_0_external_interface.RXD
		.rs232_0_UART_TXD   (<connected-to-rs232_0_UART_TXD>),   //                           .TXD
		.clk_clk            (<connected-to-clk_clk>),            //                        clk.clk
		.reset_reset_n      (<connected-to-reset_reset_n>)       //                      reset.reset_n
	);

