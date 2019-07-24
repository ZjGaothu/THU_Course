module display(CLK,start,seltime,selmoney,dig_pos,dig_sec);
input CLK;
input start;
input [6:0] seltime,selmoney;
output reg [3:0] dig_pos;
output reg [6:0] dig_sec;

reg [1:0] state;
reg [3:0] dig_num;

always @ (posedge CLK)
begin 
	state <= state + 1;
	if(state == 2'b11) state <= 2'b0;
end

always @(posedge CLK)
begin 
	if(start == 0)
	begin
		dig_pos <= 4'b0000;
	end
	else
	begin
	case(state)
		2'b00:
		begin
			dig_pos<=4'b0001;
			dig_num<=seltime/10;
		end
		2'b01:
		begin
			dig_pos<=4'b0010;
			dig_num<=seltime%10;
		end
		2'b10:
		begin
			dig_pos<=4'b0100;
			dig_num<=selmoney/10;
		end
		2'b11:
		begin
			dig_pos<=4'b1000;
			dig_num<=selmoney%10;
		end
		default:
		begin
			dig_pos<=4'b0001;
			dig_num<=0;
		end
		endcase
	end
end

always @(posedge CLK)
begin
	if(start != 0)
	begin
	case(dig_num)
	4'd0:
		dig_sec <= 7'b0111111;
	4'd1:
		dig_sec <= 7'b0000110;
	4'd2:
		dig_sec <= 7'b1011011;
	4'd3:
		dig_sec <= 7'b1001111;
	4'd4:
		dig_sec <= 7'b1100110;
	4'd5:
		dig_sec <= 7'b1101101;
	4'd6:
		dig_sec <= 7'b1111101;
	4'd7:
		dig_sec <= 7'b0000111;
	4'd8:
		dig_sec <= 7'b1111111;
	4'd9:
		dig_sec <= 7'b1100111;
	default:
		dig_sec <= 7'b0000000;
	endcase
end
end

	
endmodule
	