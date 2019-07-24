`timescale 1 ns/ 1 ns
module keyboard_tb();
reg CLK;
reg [3:0] row;
reg rst;
// wires                                               
wire EN;
wire [3:0]  col;
wire [3:0]  key_value;
wire [2:0] press_view;
wire [1:0] state_view;
                        
keyboard keyboard_test (
// port map - connection between master ports and signals/registers   
	.CLK(CLK),
	.EN(EN),
	.col(col),
	.key_value(key_value),
	.row(row),
	.rst(rst),
	.press_view(press_view),
	.state_view(state_view)
);
initial                                                
begin                                                  
		CLK = 0;
		row = 4'b1111;
		rst = 0;
		#10 rst = 1;
		#50 row = 4'b1110;
		#50 row = 4'b1111;
		#50 row = 4'b1101;
		#50 row = 4'b1111;
		#50 row = 4'b1011;
		#50 row = 4'b1111;
		#50 row = 4'b0111;
$display("Running testbench");                       
end                                                    
always                                                                 
begin                                                  
		#1 CLK = ~CLK;
                                          
end                                                    
endmodule