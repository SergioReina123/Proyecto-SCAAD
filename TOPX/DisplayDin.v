module DisplayDin(input clk,
                  input [15:0]num,
						input [3:0]key,
                  output[0:6]sseg,
                  output reg[7:0]an);
    
    reg [3:0]BCD;
    reg [2:0]aux = 3'b000;
    
    wire clk_1kh;
    
    div_freq freq(clk,clk_1kh,clk1h);
    BCDtoSSeg bcdseg(BCD,sseg);
    
    always @(posedge clk_1kh) begin
        
        case (aux)
            
            3'b000: begin BCD <= num[3:0];   an <= 8'b11111011; end
            3'b001: begin BCD <= num[7:4];   an <= 8'b11111101; end
            3'b010: begin BCD <= num[11:8];  an <= 8'b11111110; end
				3'b011: begin BCD <= key      ;  an <= 8'b01111111; end
				3'b100: begin BCD <= num[15:12]  ;  an <= 8'b11110111; end
            default: begin an <= 8'b11111111; end

        endcase
        
			if (aux==3'b100)
				aux=3'b000;
			else
				aux = aux+1;
        
    end
    
endmodule
    