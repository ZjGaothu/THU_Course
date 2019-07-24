/*module control(CLK,EN,key_value,outtime,outmoney,start_1);
input CLK;
input EN;
input [3:0] key_value;
output reg [6:0] outtime;
output reg [6:0] outmoney;
output reg start_1;

reg last_EN;
wire Keypress= (last_EN!=EN && EN==1);
reg [1:0] state;
reg [1:0] next_state;
reg [6:0] chargetime;
reg [6:0] chargemoney;
reg [12:0] resetcount;
reg [12:0] count;
reg [3:0] NUM;

parameter IDLE=2'b00,START=2'b01,COUNTDOWN=2'b10;


always @ (posedge CLK)
begin 
	last_EN <= EN ;
end


always @ (key_value)
begin 
	case (key_value)
			4'b0000:
				NUM <= 1;
			4'b0001:
				NUM <= 2;
			4'b0010:
				NUM <= 3;
			4'b0100:
				NUM <= 4;
			4'b0101:
				NUM <= 5;
			4'b0110:
				NUM <= 6;
			4'b1000:
				NUM <= 7;
			4'b1001:
				NUM <= 8;
			4'b1010:
				NUM <= 9;
			4'b1100:
				NUM <= 0;
			default :
				NUM <= 4'hf;
		endcase;
end

	
always @(posedge CLK)
begin
		state <= next_state;
end
always @(state)
begin
	case(state)
	IDLE:
	begin
		if(key_value == 3 & Keypress)
		begin
			next_state = START;
		end
		else
		begin
			next_state = IDLE;
		end
	end
	START:
	begin
		if(key_value == 11 & chargemoney!=0)
			begin
				next_state = COUNTDOWN;
			end
		else if(resetcount <= 2500)
		begin
			next_state = START;
		end
		else
		begin
			next_state = IDLE;
		end
	end
	COUNTDOWN:
	begin
		if(chargetime > 0 )
		begin
			next_state = COUNTDOWN;
		end
		else
		begin
			next_state = START;
		end
	end
	default:
	begin
		next_state = IDLE;
	end
	endcase
			
end
always @(state)
begin
	case(state)
	IDLE:
	begin
		start_1 = 0;
		resetcount = 0;
	end
	START:
		begin
		start_1 = 1;
		chargemoney = 0;
		chargetime =0;
		if(resetcount<=2500)
		begin
		if(key_value == 7 &&  Keypress)
		begin
			chargemoney = 0;
		end
		else if(key_value == 13 || key_value == 14 || key_value == 15)
		begin
			chargemoney = chargemoney;
		end
		else
		begin
			if((0<=key_value<=2 ||4<=key_value<=6||8<=key_value<=10)&& Keypress == 1 )
			begin
				chargemoney = (chargemoney*10 + NUM) %100;
			end
			else if(key_value == 12 && Keypress ==1 )
			begin
				chargemoney = (chargemoney*10) %100;
			end
			else 
			begin
				chargemoney = chargemoney + 0;
			end
		end
		if(chargemoney == 0)
			begin
				chargetime = 0;
				resetcount = resetcount + 1;
			end
		else
			begin
				chargetime = 2* chargemoney;
				resetcount = 0;
			end
		end
		else if(resetcount>=2500)
			begin
				resetcount = 0;
			end
		end
		COUNTDOWN:
			begin
			start_1=1;
			if(chargemoney>=20)
			begin
				chargemoney = 20;
				chargetime = 40;
			end
			else
			begin
				chargemoney = chargemoney;
			end
				if(chargetime>0)
					begin
						if(count<250)
						begin
						count = count + 1;
						end
						else
						begin
							count = 0;
							chargetime = chargetime - 1;
						end
					end
				else if(chargetime == 0)
				begin
					count = 0;
					chargemoney = 0;
				end
			end
			endcase
end

always @ (chargemoney,chargetime)
begin 
	outmoney = chargemoney;
	outtime = chargetime;
end
endmodule
*/
//一段式有状态机
/*module control(CLK,EN,key_value,outtime,outmoney,start_1);
input CLK;
input EN;
input [3:0] key_value;
output reg [6:0] outtime;
output reg [6:0] outmoney;
output reg start_1;

reg last_EN;
wire Keypress= (last_EN!=EN && EN==1);
reg [1:0] state;
reg [1:0] next_state;
reg [6:0] chargetime;
reg [6:0] chargemoney;
reg [12:0] resetcount;
reg [12:0] count;
reg [3:0] NUM;

parameter IDLE=2'b00,START=2'b01,COUNTDOWN=2'b10;


always @ (posedge CLK)
begin 
	last_EN<=EN ;
end

always @ (key_value)
begin 
	case (key_value)
			4'b0000:
				NUM <= 1;
			4'b0001:
				NUM <= 2;
			4'b0010:
				NUM <= 3;
			4'b0100:
				NUM <= 4;
			4'b0101:
				NUM <= 5;
			4'b0110:
				NUM <= 6;
			4'b1000:
				NUM <= 7;
			4'b1001:
				NUM <= 8;
			4'b1010:
				NUM <= 9;
			4'b1100:
				NUM <= 0;
			default :
				NUM <= 4'hf;
		endcase;
	end
always @( posedge CLK)
begin
	state = next_state;
	case(state)
	IDLE:
	begin
		start_1 = 0;
		if(key_value==3&&Keypress)
		begin
			next_state = START;
			chargemoney = 0;
			chargetime = 0;
		end
		else
		begin
			next_state = IDLE;
		end
	end
	START:
		begin
		start_1 = 1;
		if(resetcount<=2500)
		begin
		next_state = START;
		if(key_value == 11 && chargemoney!=0)
		begin
			next_state = COUNTDOWN;
			if(chargemoney>=20)
			begin
				chargemoney = 20;
				chargetime = 40;
			end
			else
			begin
				chargemoney = chargemoney;
			end
			count = 0;
		end
		else if(key_value == 7)
		begin
			chargemoney = 0;
		end
		else if(key_value == 13 || key_value == 14 || key_value == 15)
		begin
			chargemoney = chargemoney;
		end
		else
		begin
			if(0<=key_value<=2 && Keypress == 1 )
			begin
				chargemoney = (chargemoney*10 + NUM) %100;
			end
			else if(4<=key_value<=6 && Keypress == 1)
			begin 
				chargemoney = (chargemoney*10 + NUM) %100;
			end
			else if(8<=key_value<=10 && Keypress == 1)
			begin
				chargemoney = (chargemoney*10 + NUM)%100;
			end
			else if(key_value == 12 && Keypress ==1 )
			begin
				chargemoney = (chargemoney*10) %100;
			end
			else 
			begin
				chargemoney = chargemoney + 0;
			end
		end
		if(chargemoney==0)
			begin
				chargetime = 0;
				resetcount = resetcount + 1;
			end
		else
			begin
				chargetime = 2* chargemoney;
				resetcount = 0;
			end
		end
		else if(resetcount>=2500)
			begin
				next_state = IDLE;
				resetcount = 0;
			end
		end
		COUNTDOWN:
			begin
			start_1=1;
				if(chargetime>0)
					begin
						next_state = COUNTDOWN;
						if(count<250)
						begin
						count = count + 1;
						end
						else
						begin
							count = 0;
							chargetime = chargetime - 1;
						end
					end
				else if(chargetime == 0)
				begin
					count = 0;
					next_state = START;
					chargemoney = 0;
				end
			end
			default:
			begin
				next_state = IDLE;
				start_1=0;
			end
			endcase
end

always @ (chargemoney,chargetime)
begin 
	outmoney = chargemoney;
	outtime = chargetime;
end
endmodule

//无状态机板，可用
/*module control(CLK,EN,key_value,outtime,outmoney,start_1);
input CLK;
input EN;
input [3:0] key_value;
output reg [6:0] outtime;
output reg [6:0] outmoney;
output reg start_1;

reg last_EN;
wire Keypress= (last_EN!=EN && EN==1);
reg [1:0] state;
reg [1:0] next_state;
reg [6:0] chargetime;
reg [6:0] chargemoney;
reg [12:0] resetcount;
reg [12:0] count;
reg [3:0] NUM;

parameter IDLE=2'b00,START=2'b01,COUNTDOWN=2'b10;

always @ (posedge CLK)
begin 
	last_EN<=EN ;
	state <= next_state;
end

always @ (state)
begin
	case(state)
	IDLE:
	begin
		if(key_value == 3 & Keypress)
		begin
			next_state = START;
		end
		else
		begin
			next_state = IDLE;
		end
	end
	START:
	begin
		if(key_value == 11 & chargemoney!=0 & Keypress)
			begin
				next_state = COUNTDOWN;
			end
		else if(resetcount <= 2500)
		begin
			next_state = START;
		end
		else if(resetcount > 2500)
		begin
			next_state = IDLE;
		end
	end
	COUNTDOWN:
	begin
		if(chargetime > 0 )
		begin
			next_state = COUNTDOWN;
		end
		else if(chargetime == 0)
		begin
			next_state = START;
		end
	end
	default:
	begin
		next_state = IDLE;
	end
	endcase
			
end

always @ (state)
begin
	case(state)
	IDLE:
	begin
		start_1 = 0;
	end
	START:
	begin
		start_1 = 1;
	end
	COUNTDOWN:
	begin
		start_1 = 1;
	end
	endcase
end
always @(posedge CLK)
begin
	case(state)
	IDLE:
	begin
		resetcount <= 0;
		chargemoney <= 0;
		chargetime <= 0;
		count <= 0;
	end
	START:
	begin
		count <= 0;
		if (chargemoney == 0)
		begin
			resetcount <= resetcount + 1;
		end
		else
		begin
			resetcount <= 0;
			chargetime <= 2*chargemoney;
		end
		if(key_value == 11 & Keypress)
		begin
			chargemoney <= chargemoney;
			chargetime <= chargetime;
		end
		else if(0<=key_value<=2 && Keypress)
		begin
			chargemoney <= (chargemoney*10+NUM )%100;
			chargetime <= 2* chargemoney;
		end
		else if(4<=key_value<=6 & Keypress)
		begin
			chargemoney <= (chargemoney*10 + NUM)%100;
			chargetime <= 2*chargemoney;
		end
		else if (8<=key_value<=10 & Keypress)
		begin
			chargemoney <= (chargemoney*10 + NUM)%100;
			chargetime <= 2*chargemoney;
		end
		else if(key_value == 12 &Keypress)
		begin
			chargemoney <= chargemoney + 0;
			chargetime <= 2*chargemoney;
		end
		else if(key_value == 3 || key_value == 13 || key_value == 14 || key_value ==15)
		begin
			chargemoney <= chargemoney;
		end
		else if(key_value == 7)
		begin
			chargemoney <= 0;
			chargetime <= 0;
		end
		else if(chargemoney >=20)
			begin
				chargemoney <= 20;
				chargetime <= 40;
			end
		end
		COUNTDOWN:
		begin
			chargemoney <= chargemoney;
			if (count < 250)
			begin
				count <= count + 1;
				chargetime <= chargetime;
			end
			else
			begin
				chargetime = chargetime - 1;
				count = 0;
				if(chargetime == 0)
				begin
				chargemoney <= 0;
				chargetime <= 0;
				end
			end
		end
	endcase
end


always @ (key_value)
begin 
	case (key_value)
			4'b0000:
				NUM = 1;
			4'b0001:
				NUM = 2;
			4'b0010:
				NUM = 3;
			4'b0100:
				NUM = 4;
			4'b0101:
				NUM = 5;
			4'b0110:
				NUM = 6;
			4'b1000:
				NUM = 7;
			4'b1001:
				NUM = 8;
			4'b1010:
				NUM = 9;
			4'b1100:
				NUM = 0;
			default :
				NUM = 4'hf;
		endcase;
	end

always @ (chargemoney,chargetime)
begin
	outmoney = chargemoney;
	outtime = chargetime;
end

endmodule
*/

module control(CLK,EN,key_value,outtime,outmoney,start_1);
input CLK;
input EN;
input [3:0] key_value;
output reg [6:0] outtime;
output reg [6:0] outmoney;
output reg start_1;


reg [1:0] state;
reg [6:0] chargetime;
reg [6:0] chargemoney;
reg [12:0] resetcount;
reg [12:0] downcount;
reg [3:0] NUM;
reg last_EN;

parameter IDLE=2'b00,START=2'b01,CHARGE=2'b10;

wire Keypress= (last_EN!=EN && EN==1);
always @ (posedge CLK)
begin 
	last_EN<=EN ;
end
always @ (posedge CLK)
begin
	case(state)
	IDLE:
	begin
		start_1 = 0;
		if(key_value == 3 &Keypress)
		begin
			chargemoney = 0;
			chargetime = 0;
			resetcount = 0;
			state = START;
		end
		else
		begin
			state = IDLE;
		end
		
	end
	START:
	begin
		start_1 = 1;
		if(resetcount >2500)
		begin
			resetcount = 0;
			state = IDLE;
		end
		else
		begin
			state = START;
			if(key_value == 11 && Keypress && chargemoney != 0)
			begin
				downcount = 0;
				if(chargemoney > 20)
				begin
					chargemoney = 20;
					chargetime = 40;
				end
				else
				begin
					chargetime = chargetime;
					chargemoney = chargemoney;
				end
				state = CHARGE;
			end
			else if((1<=NUM<=3||4<=key_value<=6||7<=key_value<=9) && Keypress )
			begin
				chargemoney = (chargemoney*10 + NUM) %100;
			end
			else if(key_value == 12 && Keypress )
			begin
				chargemoney = (chargemoney*10) %100;
			end
			else if (key_value == 3 || key_value == 13 ||key_value == 14 || key_value == 15)
			begin
				chargemoney = chargemoney;
				chargetime = chargetime;
			end
			else if (key_value==7 )
			begin
				chargemoney = 0;
				chargetime = 0;
			end
			if(chargemoney == 0)
			begin
				resetcount = resetcount +1;
			end
			else
			begin
				chargetime = 2* chargemoney;
				resetcount = 0;
			end
		end
	end
	CHARGE:
	begin
			start_1=1;
				if(chargetime>0)
					begin
						state = CHARGE;
						if(downcount<250)
						begin
						downcount = downcount + 1;
						end
						else
						begin
							downcount = 0;
							chargetime = chargetime - 1;
						end
					end
				else if(chargetime == 0)
				begin
					downcount = 0;
					state = START;
					chargemoney = 0;
				end
			end
			default:
			begin
				state = IDLE;
				start_1=0;
			end
			endcase
end
				
always @ (key_value)
begin 
	case (key_value)
			4'b0000:
				NUM <= 1;
			4'b0001:
				NUM <= 2;
			4'b0010:
				NUM <= 3;
			4'b0100:
				NUM <= 4;
			4'b0101:
				NUM <= 5;
			4'b0110:
				NUM <= 6;
			4'b1000:
				NUM <= 7;
			4'b1001:
				NUM <= 8;
			4'b1010:
				NUM <= 9;
			4'b1100:
				NUM <= 0;
			default :
				NUM <= 4'hf;
		endcase;
	end
always @(chargemoney , chargetime)
begin
	outmoney = chargemoney;
	outtime = chargetime;
end
endmodule
