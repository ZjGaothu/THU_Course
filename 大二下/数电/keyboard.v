/*module keyboard(CLK,row,col,key_value,EN);
input CLK;
input [3:0] row;
output reg [3:0] col;
output reg [3:0] key_value;
output reg EN;
reg flag;// 0时为未按下，1时为按下
reg [1:0] state;
reg [4:0] press;
reg [4:0] loose;
initial
	begin
		key_value=4'b0000;
	end
	always @(posedge CLK)
	begin
		if(flag)
		begin
			if(row==4'b1111)
			begin
				EN<=0;
				press<=0;
				if(loose!=5'b11111)
					loose<=loose+5'b1;
				else
				begin
					loose<=0;
					flag<=0;
				end
			end
			else
			begin
				loose<=0;
			end
		end
			else
				begin
				if(row==4'b1111)
				begin
					state<=state+2'b1;
					case(state)
						2'b00:
							col<=4'b1110;
						2'b01:
							col<=4'b1101;
						2'b10:
							col<=4'b1011;
						2'b11:
							col<=4'b0111;
						default:
							col<=4'b1101;
					endcase
				end
				else
				begin
					loose<=0;
					if(press!=5'b11111)
						press<=press+5'b1;
					else
					begin
						press<=0;
						EN<=1;
						flag<=1;
					end
				end
			end
		end
	always @ (posedge EN)
	begin
		key_value=4'b0000;
		if(row==4'b1110)
			key_value[3:2]=2'b00;
		else if(row==4'b1101)
			key_value[3:2]=2'b01;
		else if(row==4'b1011)
			key_value[3:2]=2'b10;
		else if(row==4'b0111)
			key_value[3:2]=2'b11;
		if(col==4'b1110)
			key_value[1:0]=2'b00;
		else if(col==4'b1101)
			key_value[1:0]=2'b01;
		else if(col==4'b1011)
			key_value[1:0]=2'b10;
		else if(col==4'b0111)
			key_value[1:0]=2'b11;
	end
endmodule
*/

/*module keyboard(CLK,R,C,key_value,EN);
input CLK;
input [3:0] R;
output reg [3:0] C;
output reg [3:0] key_value;
output reg EN;

reg [3:0] R_reg;
reg [3:0] C_reg;
parameter NO_PRESS = 6'b000_001;  // 没有按键按下  
parameter SCAN_COL0      = 6'b000_010;  // 扫描第0列 
parameter SCAN_COL1      = 6'b000_100;  // 扫描第1列 
parameter SCAN_COL2      = 6'b001_000;  // 扫描第2列 
parameter SCAN_COL3      = 6'b010_000;  // 扫描第3列 
parameter KEYPRESS    = 6'b100_000;  // 有按键按下
reg [1:0] state;

reg [5:0] current_state,next_state;

always @(posedge CLK)
	begin 
		current_state <= next_state;
	end

	always @ (posedge CLK)
	begin
	case(current_state)
		NO_PRESS:
			if(R!=4'b1111)
				next_state=SCAN_COL0;
			else
				next_state=NO_PRESS;
		/*ANTI_SHACK:
			if(press!=5'b11111 &&R!=4'b1111)
				begin
				next_state=ANTI_SHACK;
				end
			else if(press == 5'b11111 &&R!=4'b1111)
				begin
				next_state=SCAN;
				end
			else
				begin
				next_state = NO_PRESS;
				end
	 SCAN_COL0 :                         // 扫描第0列 
        if (R != 4'b1111)
          next_state = KEYPRESS;
        else
          next_state = SCAN_COL1;
    SCAN_COL1 :                         // 扫描第1列 
        if (R != 4'b1111)
          next_state = KEYPRESS;
        else
          next_state = SCAN_COL2;    
    SCAN_COL2 :                         // 扫描第2列
        if (R != 4'b1111)
          next_state = KEYPRESS;
        else
          next_state = SCAN_COL3;
    SCAN_COL3 :                         // 扫描第3列
        if (R != 4'b1111)
          next_state = KEYPRESS;
        else
          next_state = NO_PRESS;
		KEYPRESS:
			if(R!=4'b1111)
				next_state=KEYPRESS;
			else
				next_state=NO_PRESS;
		endcase
	end
always@ (posedge CLK)
 begin 
  case(next_state)
		NO_PRESS:
		begin
			EN<=0;
			C <= 4'b0000;
		end
		/*ANTI_SHACK:
		begin
		if(press!= 5'b11111)
			begin
			press <= press+5'b1;
			end
		else
			begin
			press<=0;
			end
		end
		SCAN_COL0 :                       // 扫描第0列
        C <= 4'b1110;
      SCAN_COL1 :                       // 扫描第1列
        C <= 4'b1101;
      SCAN_COL2 :                       // 扫描第2列
        C <= 4'b1011;
      SCAN_COL3 :                       // 扫描第3列
        C <= 4'b0111;
		KEYPRESS:
		begin
			R_reg <= R;
			C_reg <= C;
			EN <= 1;
		end
	endcase
end


always @ (posedge EN)
  begin 
		key_value=4'b0000;
		if(R_reg==4'b1110)
			key_value[3:2]=2'b00;
		else if(R_reg==4'b1101)
			key_value[3:2]=2'b01;
		else if(R_reg==4'b1011)
			key_value[3:2]=2'b10;
		else if(R_reg==4'b0111)
			key_value[3:2]=2'b11;
		if(C_reg==4'b1110)
			key_value[1:0]=2'b00;
		else if(C_reg==4'b1101)
			key_value[1:0]=2'b01;
		else if(C_reg==4'b1011)
			key_value[1:0]=2'b10;
		else if(C_reg==4'b0111)
			key_value[1:0]=2'b11;
	end
	
endmodule
*/
/*module keyboard(CLK, C, R, DATA, EN);
	input CLK;	
	input  [3:0] R;
	
	output reg [3:0] DATA;
	output reg EN;//determine whether the data is valid
	reg flag;//0 for release, 1 for press
	output reg [3:0] C;//Row after processing the shiver
	reg [1:0] A;
	reg [4:0] press;
	reg [4:0] loose;
	
	initial
	begin
		DATA = 4'b0000;
	end
	always @ (posedge CLK)
	begin
		if (flag)//press, flag == 1
		begin
			if (R == 4'b1111)//release now
			begin
				EN <= 0;
				press <= 0;
				if (loose != 5'b11111)//
					loose <= loose + 5'b1;
				else
				begin
					loose <= 0;
					flag <= 0;
				end
			end
			else
			begin
				loose <= 0;
			end
		end
		else//release, flag == 0
		begin
			if (R == 4'b1111)//not press, scan the column
			begin
				A <= A + 2'b1;
				case (A)
					2'b00 : 
						C <= 4'b1110;
					2'b01 : 
						C <= 4'b1101;
					2'b10 :
						C <= 4'b1011;
					2'b11 :
						C <= 4'b0111;
					default :
						C <= 4'b1110;
				endcase;
			end
			else//press any key
			begin
				loose <= 0;
				if (press != 5'b11111)
					press <= press + 5'b1;
				else
				begin
					press <= 0;
					EN <= 1;
					flag <= 1;
				end
			end
		end
	end
	
	always @ (posedge EN)//read the DATA
	begin
		DATA = 4'd0;
		if (C == 4'b0111)
			DATA[1:0] = 2'b11;
		else if (C == 4'b1011)
			DATA[1:0] = 2'b10;
		else if (C == 4'b1101)
			DATA[1:0] = 2'b01;
		else if (C == 4'b1110)
			DATA[1:0] = 2'b00;
		if (R == 4'b1110)
			DATA[3:2] = 2'b00;
		else if (R == 4'b1101)
			DATA[3:2] = 2'b01;
		else if (R == 4'b1011)
			DATA[3:2] = 2'b10;
		else if (R == 4'b0111)
			DATA[3:2] = 2'b11;
	end
endmodule*/
	/*module keyboard(CLK,row,col,key_value,EN);
input CLK;
input [3:0] row;
output reg [3:0] col;
output reg [3:0] key_value;
output reg EN;
reg flag;// 0时为未按下，1时为按下
reg [1:0] state;
reg [4:0] press;
reg [4:0] loose;
initial
	begin
		key_value=4'b0000;
	end
	always @(posedge CLK)
	begin
		if(flag)
		begin
			if(row==4'b1111)
			begin
				EN<=0;
				press<=0;
				if(loose!=5'b11111)
					loose<=loose+5'b1;
				else
				begin
					loose<=0;
					flag<=0;
				end
			end
			else
			begin
				loose<=0;
			end
		end
			else
				begin
				if(row==4'b1111)
				begin
					state<=state+2'b1;
					case(state)
						2'b00:
							col<=4'b1110;
						2'b01:
							col<=4'b1101;
						2'b10:
							col<=4'b1011;
						2'b11:
							col<=4'b0111;
						default:
							col<=4'b1101;
					endcase
				end
				else
				begin
					loose<=0;
					if(press!=5'b11111)
						press<=press+5'b1;
					else
					begin
						press<=0;
						EN<=1;
						flag<=1;
					end
				end
			end
		end
	always @ (posedge EN)
	begin
		key_value=4'b0000;
		if(row==4'b1110)
			key_value[3:2]=2'b00;
		else if(row==4'b1101)
			key_value[3:2]=2'b01;
		else if(row==4'b1011)
			key_value[3:2]=2'b10;
		else if(row==4'b0111)
			key_value[3:2]=2'b11;
		if(col==4'b1110)
			key_value[1:0]=2'b00;
		else if(col==4'b1101)
			key_value[1:0]=2'b01;
		else if(col==4'b1011)
			key_value[1:0]=2'b10;
		else if(col==4'b0111)
			key_value[1:0]=2'b11;
	end
endmodule
*/

/*module keyboard(CLK,row,col,key_value,EN);
input CLK;
input [3:0] row;
output reg [3:0] col;
output reg [3:0] key_value;
output reg EN;
reg flag;// 0时为未按下，1时为按下
reg [1:0] scanstate;
reg [1:0] state;
reg [4:0] press;
reg [4:0] loose;
parameter NO_PRESS = 2'b00, ANTI_SHACK = 2'b01, SCAN = 2'b10, KEYPRESS = 2'b11;
reg [1:0] next_state;
reg [3:0] R_reg;
reg [3:0] C_reg;

always @(posedge CLK)
begin 
	state <= next_state;
end

always @(posedge CLK)
begin
	case(state)
		NO_PRESS:
		begin
			if(row != 4'b1111)
				begin
					next_state <= ANTI_SHACK;
				end
			else
				begin
					next_state <= NO_PRESS;
				end
		end
		ANTI_SHACK:
		begin
			if(press != 5'b11111)
				begin
					next_state <= SCAN;
				end
			else
				begin
					next_state <= ANTI_SHACK;
				end
		end
		SCAN:
		begin
			if(row != 4'b1111)
				begin
				next_state <= KEYPRESS;
				end
			else
				begin
				next_state <= NO_PRESS;
				end
		end
		KEYPRESS:
		begin
			if(row != 4'b1111)
				begin
					next_state <= KEYPRESS;
				end
			else
				begin
					next_state <= NO_PRESS;
				end
		end
		endcase
end

always @(posedge CLK)
begin
	case(next_state)
		NO_PRESS:
		begin
			EN <= 0;
			col <= 4'b0000;
		end
		ANTI_SHACK:
		begin
		if(press!= 5'b11111)
			begin
			press <= press+5'b1;
			end
		else
			begin
			press<=0;
			end
		end
		SCAN:
		begin
				if(row == 4'b1111)
				begin
					scanstate <= scanstate+2'b1;
					case(scanstate)
						2'b00:
							col <= 4'b1110;
						2'b01:
							col <= 4'b1101;
						2'b10:
							col <= 4'b1011;
						2'b11:
							col <= 4'b0111;
						default:
							col <= 4'b1101;
					endcase
				end
		end
		KEYPRESS:
		begin
			R_reg <= row;
			C_reg <= col;
			EN <= 1;
		end
		endcase
			
end

always @ (posedge EN)
  begin 
		key_value=4'b0000;
		if(R_reg==4'b1110)
			key_value[3:2]=2'b00;
		else if(R_reg==4'b1101)
			key_value[3:2]=2'b01;
		else if(R_reg==4'b1011)
			key_value[3:2]=2'b10;
		else if(R_reg==4'b0111)
			key_value[3:2]=2'b11;
		if(C_reg==4'b1110)
			key_value[1:0]=2'b00;
		else if(C_reg==4'b1101)
			key_value[1:0]=2'b01;
		else if(C_reg==4'b1011)
			key_value[1:0]=2'b10;
		else if(C_reg==4'b0111)
			key_value[1:0]=2'b11;
	end
	
endmodule
	*/
	
	
/*module keyboard(CLK,row,col,key_value,EN);
input CLK;
input [3:0] row;
output reg [3:0] col;
output reg [3:0] key_value;
output reg EN;
reg flag;
reg [1:0] scanstate;
reg [1:0] state;
reg [4:0] press;
reg [2:0] loose;
parameter NO_PRESS = 2'b00, ANTI_SHACK = 2'b01, SCAN = 2'b10, KEYPRESS = 2'b11;
reg [1:0] next_state;
reg [3:0] R_reg;
reg [3:0] C_reg;

always @(posedge CLK)
begin 
	state <= next_state;
end

initial
begin
	flag <=0;
end

always @(posedge CLK)
begin
	case(state)
		NO_PRESS:
		begin
			flag <= 0;
			if(row != 4'b1111)
				begin
					next_state <= ANTI_SHACK;
				end
			else
				begin
					next_state <= NO_PRESS;
				end
		end
		ANTI_SHACK:
		begin
			if(press != 5'b11111)
				begin
					next_state <= ANTI_SHACK;
				end
			else if(flag == 0)
				begin
					next_state <= SCAN;
				end
		end
		SCAN:
		begin
			if(row != 4'b1111)
				begin
				next_state <= KEYPRESS;
				end
			else if(flag ==0)
				begin
				next_state <= NO_PRESS;
				end
		end
		KEYPRESS:
		begin
			flag = 1;
			if(row != 4'b1111)
				begin
					next_state <= KEYPRESS;
				end
			else
				begin
					next_state <= NO_PRESS;
				end
		end
		default:
		begin
			next_state <= NO_PRESS;
		end
		endcase
end

always @(posedge CLK)
begin
	case(state)
		NO_PRESS:
		begin
			EN <= 0;
			col <= 4'b0000;
		end
		ANTI_SHACK:
		begin
		if(press!= 5'b11111)
			begin
			press <= press+5'b1;
			end
		else
			begin
			press <= 0;
			end
		end
		SCAN:
		begin
			scanstate <= scanstate+2'b1;
			case(scanstate)
				2'b00:
					col <= 4'b1110;
				2'b01:
					col <= 4'b1101;
				2'b10:
					col <= 4'b1011;
				2'b11:
					col <= 4'b0111;
				default:
					col <= 4'b1101;
			endcase
		end
		KEYPRESS:
		begin
		   R_reg <= row;
			C_reg <= col;
			EN <= 1;
		end
		endcase
			
end

always @ (posedge EN)
  begin 
		key_value=4'b0000;
		if(R_reg==4'b1110)
			key_value[3:2]=2'b00;
		else if(R_reg==4'b1101)
			key_value[3:2]=2'b01;
		else if(R_reg==4'b1011)
			key_value[3:2]=2'b10;
		else if(R_reg==4'b0111)
			key_value[3:2]=2'b11;
		if(C_reg==4'b1110)
			key_value[1:0]=2'b00;
		else if(C_reg==4'b1101)
			key_value[1:0]=2'b01;
		else if(C_reg==4'b1011)
			key_value[1:0]=2'b10;
		else if(C_reg==4'b0111)
			key_value[1:0]=2'b11;
	end
	
endmodule
*/
/*module keyboard(CLK,row,col,key_value,EN);
input CLK;
input [3:0] row;
output reg [3:0] col;
output reg [3:0] key_value;
output reg EN;
reg flag;
reg [1:0] scanstate;
reg [2:0] state;
reg [4:0] press;
reg [4:0] loose;
parameter NO_PRESS = 3'b000, ANTI_SHACK_P = 3'b001, SCAN = 3'b010, KEYPRESS = 3'b011,ANTI_SHACK_L=3'b100;
reg [2:0] next_state;
reg [3:0] R_reg;
reg [3:0] C_reg;
reg LAST_EN;
always @(posedge CLK)
begin 
	state <= next_state;
	LAST_EN <= EN;
end

assign ENCHANGE = LAST_EN & (~EN);

initial
begin
	flag <=0;
end

always @(posedge CLK)
begin
	case(state)
		NO_PRESS:
		begin
			if(row != 4'b1111)
				begin
					next_state <= ANTI_SHACK_P;
				end
			else
				begin
					next_state <= NO_PRESS;
				end
		end
		ANTI_SHACK_P:
		begin
			if(press != 5'b11111)
				begin
					next_state <= ANTI_SHACK_P;
				end
			else
				begin
					next_state <= KEYPRESS;
				end
		end
		KEYPRESS:
		begin
			if(row != 4'b1111)
				begin
					next_state <= KEYPRESS;
				end
			else 
				begin
					next_state <= ANTI_SHACK_L;
				end
		end
		ANTI_SHACK_L:
		begin
			if(loose != 5'b11111)
			begin
				next_state <= ANTI_SHACK_L;
			end
			else
			begin
				next_state <= NO_PRESS;
			end
		end
		default:
		begin
			next_state <= NO_PRESS;
		end
		endcase
end

always @(posedge CLK)
begin
	case(next_state)
		NO_PRESS:
		begin
			flag <= 0;
			col <= 4'b0000;
			EN <= 0;
			scanstate <= scanstate+2'b1;
			case(scanstate)
				2'b00:
					col <= 4'b1110;
				2'b01:
					col <= 4'b1101;
				2'b10:
					col <= 4'b1011;
				2'b11:
					col <= 4'b0111;
				default:
					col <= 4'b1101;
			endcase
		end
		ANTI_SHACK_P:
		begin
		if(press!= 5'b11111)
			begin
			press <= press+5'b1;
			end
		else
			begin
			press <= 0;
			flag <= 1;
			end
		end
		KEYPRESS:
		begin
			EN <= 1;
		   R_reg <= row;
			C_reg <= col;
		end
		ANTI_SHACK_L:
		begin
			if(loose != 5'b11111)
			begin
				loose <= loose + 1;
			end
			else
			begin
				loose <= 0;
				flag <= 0;
			end
		end
			endcase
			
end

always @ (posedge EN)
begin
		key_value <= 4'b0000;
		if(R_reg==4'b1110)
			key_value[3:2]=2'b00;
		else if(R_reg==4'b1101)
			key_value[3:2]=2'b01;
		else if(R_reg==4'b1011)
			key_value[3:2]=2'b10;
		else if(R_reg==4'b0111)
			key_value[3:2]=2'b11;
		if(C_reg==4'b1110)
			key_value[1:0]=2'b00;
		else if(C_reg==4'b1101)
			key_value[1:0]=2'b01;
		else if(C_reg==4'b1011)
			key_value[1:0]=2'b10;
		else if(C_reg==4'b0111)
			key_value[1:0]=2'b11;
end
	
endmodule
*/
//可使用板 但不可仿真
/*module keyboard(CLK,row,col,key_value,EN);
input CLK;
input [3:0] row;
output reg [3:0] col;
output reg [3:0] key_value;
output reg EN;
reg flag;
reg [1:0] scanstate;
reg [2:0] state;
reg [2:0] press;
reg [2:0] loose;
parameter NO_PRESS = 3'b000, ANTI_SHACK_P = 3'b001, SCAN = 3'b010, KEYPRESS = 3'b011,ANTI_SHACK_L=3'b100;
reg [2:0] next_state;
reg [3:0] R_reg;
reg [3:0] C_reg;
reg LAST_EN;
always @(posedge CLK )
begin 
	state <= next_state;
	LAST_EN <= EN;
end

assign ENCHANGE = LAST_EN & (~EN);

always @(state)
begin
	case(state)
		NO_PRESS:
		begin
			if(row != 4'b1111)
				begin
					next_state <= ANTI_SHACK_P;
				end
			else
				begin
					next_state <= NO_PRESS;
				end
		end
		ANTI_SHACK_P:
		begin
			if(press != 3'b111)
				begin
					next_state <= ANTI_SHACK_P;
				end
			else
				begin
					next_state <= KEYPRESS;
				end
		end
		KEYPRESS:
		begin
			if(row != 4'b1111)
				begin
					next_state <= KEYPRESS;
				end
			else 
				begin
					next_state <= ANTI_SHACK_L;
				end
		end
		ANTI_SHACK_L:
		begin
			if(loose != 3'b111)
			begin
				next_state <= ANTI_SHACK_L;
			end
			else
			begin
				next_state <= NO_PRESS;
			end
		end
		default:
		begin
			next_state <= NO_PRESS;
		end
		endcase
end

always @(posedge CLK)
begin
	case(next_state)
		NO_PRESS:
		begin
		if(row == 4'b1111)
		begin
			flag <= 0;
			EN <= 0;
			col <= 4'b0000;
			scanstate <= scanstate+2'b1;
			case(scanstate)
				2'b00:
					col <= 4'b1110;
				2'b01:
					col <= 4'b1101;
				2'b10:
					col <= 4'b1011;
				2'b11:
					col <= 4'b0111;
				default:
					col <= 4'b1101;
			endcase
		end
		else
		begin
			press <= 0;
		end
		end
		ANTI_SHACK_P:
		begin
		if(press!= 3'b111)
			begin
			press <= press+5'b1;
			end
		else
			begin
			press <= 0;
			flag <= 1;
			end
		end
		KEYPRESS:
		begin
			EN = 1;
		   R_reg <= row;
			C_reg <= col;
		end
		ANTI_SHACK_L:
		begin
		if(row == 4'b1111)
		begin
			if(loose != 3'b111)
			begin
				loose <= loose + 1;
			end
			else
			begin
				loose <= 0;
				flag <= 0;
			end
		end
		else
			begin
				loose <= 0;
			end
		end
			endcase
end

always @ (posedge EN)
begin
		key_value <= 4'b0000;
		if(R_reg==4'b1110)
			key_value[3:2]=2'b00;
		else if(R_reg==4'b1101)
			key_value[3:2]=2'b01;
		else if(R_reg==4'b1011)
			key_value[3:2]=2'b10;
		else if(R_reg==4'b0111)
			key_value[3:2]=2'b11;
		if(C_reg==4'b1110)
			key_value[1:0]=2'b00;
		else if(C_reg==4'b1101)
			key_value[1:0]=2'b01;
		else if(C_reg==4'b1011)
			key_value[1:0]=2'b10;
		else if(C_reg==4'b0111)
			key_value[1:0]=2'b11;
end
	
endmodule
*/
module keyboard(CLK,row,col,key_value,EN,rst, press_view, state_view);
input CLK;
input [3:0] row;
input rst;
output reg [3:0] col;
output reg [3:0] key_value;
output reg EN;
output press_view;
output state_view;
reg [1:0] scanstate;
reg [2:0] state;
reg [2:0] press;
reg [2:0] loose;
parameter NO_PRESS = 3'b000, ANTI_SHACK_P = 3'b001, SCAN = 3'b010, KEYPRESS = 3'b011,ANTI_SHACK_L=3'b100;
reg [2:0] next_state;
reg [3:0] R_reg;
reg [3:0] C_reg;
wire [2:0] press_view;
wire [2:0] state_view;
reg LAST_EN;
wire is_press_end;
wire is_row_idle;
assign press_view = press;
assign is_press_end = &press;
assign state_view = state;
/*
always @(posedge CLK or negedge rst)
begin
	if(rst == 0)
	begin
		state <= NO_PRESS;
	end
	else
	begin
		state <= next_state;
	end
end
*/
assign ENCHANGE = LAST_EN & (~EN);

always @(state)
begin
	case(state)
		NO_PRESS:
		begin
			if(!is_row_idle)
				begin
					next_state = ANTI_SHACK_P;
				end
			else
				begin
					next_state = NO_PRESS;
				end
		end
		ANTI_SHACK_P:
		begin
			if(!is_press_end)
				begin
					next_state = ANTI_SHACK_P;
				end
			else
				begin
					next_state = KEYPRESS;
				end
		end
		KEYPRESS:
		begin
			if(!is_row_idle)
				begin
					next_state = KEYPRESS;
				end
			else 
				begin
					next_state = ANTI_SHACK_L;
				end
		end
		ANTI_SHACK_L:
		begin
			if(loose != 3'b111)
			begin
				next_state = ANTI_SHACK_L;
			end
			else
			begin
				next_state = NO_PRESS;
			end
		end
		default:
		begin
			next_state = NO_PRESS;
		end
		endcase
end

always @(posedge CLK or negedge rst)
begin
	if(rst == 0)
	begin
		EN <= 0;
		col <= 4'b0000;
		press <= 0;
		loose <= 0;
		R_reg <= 4'b1110;
		C_reg <= 4'b1110;
		scanstate <= 0;
		state <= NO_PRESS;
	end
	else
	begin
	state <= next_state;
	case(state)
		NO_PRESS:
		begin
		EN <= 0;
		R_reg <= 4'b1110;
		C_reg <= 4'b1110;
		press <= 1;
		loose <= 0;
		if(row == 4'b1111)
		begin
			scanstate <= scanstate+2'b1;
			case(scanstate)
				2'b00:
					col <= 4'b1110;
				2'b01:
					col <= 4'b1101;
				2'b10:
					col <= 4'b1011;
				2'b11:
					col <= 4'b0111;
				default:
				begin
					col <= 4'b1101;
				end
			endcase
		end
		else
		begin
			scanstate <= 2'b00;
			col <= col;
		end
		end
		ANTI_SHACK_P:
		begin
			loose <= 0;
			R_reg <= R_reg;
			C_reg <= C_reg;
			scanstate <= 2'b00;
			col <= col;
			press <= press+3'b1;
		if(!is_press_end)
			begin
			EN <= EN;
			end
		else
			begin
			EN<= 1;
			end
		end
		KEYPRESS:
		begin
			EN <= 1;
		   R_reg <= row;
			C_reg <= col;
			loose <= 0;
			press <= 0;
			scanstate <= 2'b00;
			col <= col;
		end
		ANTI_SHACK_L:
		begin
			press <= 2;
			R_reg <= R_reg;
			C_reg <= C_reg;
			scanstate <= 2'b00;
			col <= col;
			EN<= EN;
		if(row == 4'b1111)
		begin
			if(loose != 3'b111)
			begin
				loose <= loose + 1;
			end
			else
			begin
				loose <= 0;
			end
		end
		else
			begin
				loose <= 0;
			end
		end
	endcase
			
    end
end

/*always @ (posedge EN or negedge rst)
begin
		if(rst == 0)
		begin
			key_value <= 4'b0000;
		end
		else
		begin
		if(R_reg==4'b1110)
			key_value[3:2]=2'b00;
		else if(R_reg==4'b1101)
			key_value[3:2]=2'b01;
		else if(R_reg==4'b1011)
			key_value[3:2]=2'b10;
		else if(R_reg==4'b0111)
			key_value[3:2]=2'b11;
		if(C_reg==4'b1110)
			key_value[1:0]=2'b00;
		else if(C_reg==4'b1101)
			key_value[1:0]=2'b01;
		else if(C_reg==4'b1011)
			key_value[1:0]=2'b10;
		else if(C_reg==4'b0111)
			key_value[1:0]=2'b11;
		else
			key_value = 4'b0000;
		end
end*/
	
endmodule