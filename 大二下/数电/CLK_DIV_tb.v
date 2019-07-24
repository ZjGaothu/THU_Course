`timescale 10 ns/ 10 ns
module CLK_DIV_tb();
reg ClkIn;
reg rst;
// wires                                               
wire ClkOut;

// assign statements (if any)                          
CLK_DIV i1 (
// port map - connection between master ports and signals/registers   
	.ClkIn(ClkIn),
	.ClkOut(ClkOut),
	.rst(rst)
);
initial                                                
begin                                                  
	ClkIn = 0;
	rst =  0;
	#50 rst = 1;
$display("Running testbench");                       
end                                                    
always                                                                 
	begin                                                  
		#10 ClkIn = ~ClkIn;
	end                                                    
endmodule

