`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:09:32 07/03/2017 
// Design Name: 
// Module Name:    DHT11 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Temp(
	 input CLK,  //100 MHz
    //input EN,
    input RST,
    inout DHT_DATA,
	 //output [7:0] HUM_INT,
	 //output [7:0] HUM_FLOAT,
    output [7:0] TEMP_INT
	 //output [7:0] TEMP_FLOAT,
	 //output [7:0] CRC,
	 //output WAIT
    );


	reg DHT_OUT, DIR, WAIT;  //Registrador de saida	
	reg [20:0] COUNTER; //Contador de ciclos para gerar delays
	reg [4:0] index;
	reg [39:0] INTDATA; //registrador de dados interno
	
	//wire DHT_IN;
	
	assign DHT_DATA = DIR ? DHT_OUT : 1'bZ; // Se DIR 1 -- copia DHT_OUT para saida, caso nao, deixa o pino indefinido para atuar como entrada
	//assign DHT_IN = DHT_DATA;
	
	assign TEMP_INT[0] = INTDATA[16];  
	assign TEMP_INT[1] = INTDATA[17];
	assign TEMP_INT[2] = INTDATA[18];
	assign TEMP_INT[3] = INTDATA[19];
	assign TEMP_INT[4] = INTDATA[20];
	assign TEMP_INT[5] = INTDATA[21];
	assign TEMP_INT[6] = INTDATA[22];
	assign TEMP_INT[7] = INTDATA[23];

	 reg [3:0] STATE;
	 
	 //Definição de estados
	 parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6, S7=7, S8=8, S9=9, STOP=10;

 
	//Processo de FSM 
	always @(posedge CLK)
	begin: FSM
	  //if (EN == 1'b1)
	  //begin
		 if ( RST == 1'b1)
		 begin			  
			  DHT_OUT <= 1'b0;			  
			  WAIT <= 1'b0;
			  COUNTER <= 20'b0;	
			  DIR <= 1'b1;			   //Configura pino saida
			  STATE <= S0;
		 end else begin
		 
			 case (STATE)
				 S0:
					 begin
					   DIR <= 1'b1;	
					   DHT_OUT <= 1'b1;
						WAIT <= 1'b1;
						if (COUNTER < 21'b111001111110111100000)							//100.000.000/2 = 50.000.000 -> 1/50.000.000 = 0,00002ms --> 18ms/0,00002 = 900000 ciclos)
						begin
							COUNTER <= COUNTER +1'b1;
						end else begin
							COUNTER <= 20'b0;
							STATE <= S1;
						end
					 end
				 
				 S1:
					 begin
					   DHT_OUT <= 1'b0;	
						WAIT <= 1'b1;
						if (COUNTER < 21'b111001111110111100000)							//100.000.000/2 = 50.000.000 -> 1/50.000.000 = 0,00002ms --> 18ms/0,00002 = 900000 ciclos)
						begin
							COUNTER <= COUNTER +1'b1;
						end else begin
							COUNTER <= 20'b0;
							STATE <= S2;
						end
					 end
				S2:
					begin
						DHT_OUT <= 1'b1;			
						STATE <= S3;
					end
				S3:
					begin	                  					
						if (COUNTER < 21'b000000000000000000111)							//100.000.000/2 = 50.000.000 -> 1/50.000.000 = 0,00002ms --> 18ms/0,00002 = 900000 ciclos)
						begin						  
							COUNTER <= COUNTER +1'b1;
						end else begin
							COUNTER <= 20'b0;
							DIR <= 1'b0;
							DHT_OUT <= 1'b0;
							STATE <= S4;
						end
					end
				
				S4:
					begin
						if ( DHT_DATA == 0)
						begin
							STATE <= S5;
						end else begin
							STATE <= S4;
						end
					end
					
				S5:
					begin
						if ( DHT_DATA == 1)
						begin
							STATE <= S6;
							index <= 5'b0; //reseta indexador
						end else begin
							STATE <= S5;
						end
					end
			//Inicio da analise de dados
				S6:
					begin
						if ( DHT_DATA == 0)
						begin
							STATE <= S7;
						end 
					end
				
				S7:
					begin
					  if ( DHT_DATA == 1'b1)
					  begin
							STATE <= S8;
						end							
					end
					
				S8:
				   begin
						if (  DHT_DATA == 0 ) /// 50MHz = 0,02 uS -> 50uS = 2500 ciclos
						begin
									
									if ( COUNTER > 2500) 
									begin
									   INTDATA[index] <= 1'b1;
									   COUNTER <= 20'b0; 
									end else begin
										INTDATA[index] <= 1'b0;
									   COUNTER <= 20'b0;
									end
									STATE <= S9;
									
						end else begin
									COUNTER <= COUNTER + 1'b1;
						end
					 end
				 S9:
					begin
						if (index < 40 )
						begin
							index <= index+1'b1;
							STATE <= S6;
						end else begin
							WAIT <= 1'b0;							
							index <= 5'b0;
							COUNTER <= 20'b0;
							
							STATE <= STOP;
						end						
					end	
				 
				 STOP:
					begin
						STATE <= STOP;
					end
			 endcase
		end
	end
  //end


endmodule
