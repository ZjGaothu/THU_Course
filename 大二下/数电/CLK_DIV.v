module CLK_DIV(ClkIn,ClkOut,rst);
	input ClkIn;
	input rst;
	output ClkOut;
	reg ClkOut;
	reg [31:0] count;
	parameter max=100000;
	
always @(posedge ClkIn or negedge rst)
	begin
	if(rst == 0)
	begin
		count <= 0;
		ClkOut <= 0;
	end
	else
	begin
	if(count>=max) 
	begin 
		ClkOut <= ~ClkOut;
		count<=0;
	end
	else
	begin
		ClkOut <= ClkOut;
		count <= count + 1;
	end
	end
end
		
endmodule
