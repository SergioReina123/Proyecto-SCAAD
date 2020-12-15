module Valvula_top (input clk,
						  input enable,
                    output reg servo
           );
   
   reg [27:0] cont;
   reg clk_50hz; 	   
	
   
   initial begin
      cont  = 28'd0;
      clk_50hz = 0;
   end
	
   always @ ( posedge clk ) begin
      
		
		
		
		if(enable)begin
			servo = ( cont < 40_000) ? 1:0;  // abierto
		end
		else begin
			servo = ( cont < 100_000) ? 1:0;  // cerrado
		end
		
      if ( cont == 'd500_000 ) begin
         cont  = 0;
         clk_50hz = ~clk_50hz;
      end
      
      else cont = cont+28'd1;
      
		
		
		
		
		
   end
   
endmodule
