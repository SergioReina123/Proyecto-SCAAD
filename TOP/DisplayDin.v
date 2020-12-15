module DisplayDin(input clk,
                  input [11:0]num,
						input [3:0]key,
                  output[0:6]sseg,
                  output reg[7:0]an);
    
    reg [3:0]BCD;
    reg [1:0]aux = 2'b00;
    
    wire clk_1kh;
    
    div_freq freq(clk,clk_1kh,clk1h);
    BCDtoSSeg bcdseg(BCD,sseg);
    
    always @(posedge clk_1kh) begin
        
        case (aux)
            
            2'b00: begin BCD <= num[3:0];   an <= 8'b11111011; end
            2'b01: begin BCD <= num[7:4];   an <= 8'b11111101; end
            2'b10: begin BCD <= num[11:8];  an <= 8'b11111110; end
				2'b11: begin BCD <= key      ;  an <= 8'b01111111; end
            default: begin an <= 8'b11111111; end

        endcase
        
         aux = aux+1;
        
    end
    
endmodule
    