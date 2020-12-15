module barrido (input clk_1,
         output reg [3:0] column);
   
   reg [1:0] count;
   
   initial begin
      count <= 2'b00;
   end
   
   always @ ( posedge clk_1 ) begin
      
      case ( count )
         2'b00: column   <= 4'b0001;
         2'b01: column   <= 4'b0010;
         2'b10: column   <= 4'b0100;
         2'b11: column   <= 4'b1000;
         default: column <= 4'b0000;
      endcase
      
      count <= count+2'b01;
      
   end
   
endmodule
