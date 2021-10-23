
module Counter_top
(
//******************************************
//***** PINOUT
//******************************************
	input  iClk,							//pin N14	50 MHz
	
	//Display
	output [2:0]  oDispCom,						//pin B3,C3,B2
	output [23:0] oDispSeg						//pin B1,A2,A3,B4,A4,B5,A5,B7,A6,A7,A8,B8,E12,D13,D14,E13,A14,B14,C14,C13,H14,J13,D17,C17


);

	
//******************************************
//***** VARIABLES
//******************************************
	wire clk;
	reg  [31:0] cnt = 0;
	reg  [31:0] Tick = 0;


//******************************************
//***** CONNECTIONS
//******************************************
	pll MAIN_PLL (.inclk0(iClk), .c0(clk)); // c0 = 10 MHz 


	
//******************************************
//***** COUNTER
//******************************************		
	always @(posedge clk)
	begin
		if(cnt >= 1000000)
		begin
			cnt <= 0;
			Tick <= Tick + 1'b1;
		end
		else begin
			cnt <= cnt + 1'b1;
		end
	end
	
	
	
//******************************************
//***** DISPLAY LCD
//******************************************	
	lcd24x3 DISPLAY_LCD
	(
		.clk(clk),
		
		.iChar7({1'h0, Tick[31: 28]}),
		.iChar6({1'h0, Tick[27: 24]}),
		.iChar5({1'h0, Tick[23: 20]}),
		.iChar4({1'h0, Tick[19: 16]}),
		.iChar3({1'h0, Tick[15: 12]}),
		.iChar2({1'h0, Tick[11:  8]}),
		.iChar1({1'h0, Tick[ 7:  4]}),
		.iChar0({1'h0, Tick[ 3:  0]}),
		
		.iPoint(8'b00000000),
		
		.oCom(oDispCom),
		.oSeg(oDispSeg)

	);
	defparam DISPLAY_LCD.Fclk = 10000; 		
	defparam DISPLAY_LCD.Contrast = 8;



endmodule
