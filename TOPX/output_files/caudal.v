module caudal(
		input signal,	
		input contar_caudal,
		output reg[15:0]mililitros 
);



initial mililitros=16'b0;

always @(posedge signal)begin

	if(contar_caudal)begin
		mililitros[3:0]=mililitros[3:0]+4'd6;
	end
	
	if (mililitros[3:0] >= 4'h9) begin
							 
		mililitros[3:0] = 4'd0; 
		mililitros[7:4] = mililitros[7:4] + 4'd1;
							 
	end
						
	if (mililitros[7:4] == 4'hA) begin
							 
		mililitros[7:4]  = 4'd0;    
		mililitros[11:8] = mililitros[11:8] + 4'd1; 
							 
	end
	
	if (mililitros[11:8] == 4'hA) begin
							 
		mililitros[11:8]  = 4'd0;    
		mililitros[15:12] = mililitros[15:12] + 4'd1; 
							 
	end
								
end

endmodule
