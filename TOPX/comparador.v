module comparador (filas, column,clk_1, num);

input [3:0] filas;
input [3:0] column;
input clk_1;
output reg [3:0] num;

initial begin
	num = 0;
end

always @(posedge clk_1) begin

	if(column == 4'b0001)begin
	
		 case(filas)
				4'b1000: num = 4'hA;
				4'b0100: num = 4'hB;
				4'b0010: num = 4'hC;
				4'b0001: num = 4'hD;		
				//default: num = 0;
				
		 endcase
	
	end
	if(column == 4'b0010)begin
	
		 case(filas)
				4'b1000: num = 4'h3;
				4'b0100: num = 4'h6;
				4'b0010: num = 4'h9;
				4'b0001: num = 4'hE; //*		
				//default: num = 0;
				
		 endcase
	
	end
	if(column == 4'b0100)begin
	
		 case(filas)
				4'b1000: num = 4'h2;
				4'b0100: num = 4'h5;
				4'b0010: num = 4'h8;
				4'b0001: num = 4'h0;		
				//default: num = 0;
				
		 endcase
	
	end
	if(column == 4'b1000)begin
	
		 case(filas)
				4'b1000: num = 4'h1;
				4'b0100: num = 4'h4;
				4'b0010: num = 4'h7;
				4'b0001: num = 4'hF;	//#	
				//default: num = 0;
				
		 endcase
	
	end

end

endmodule 