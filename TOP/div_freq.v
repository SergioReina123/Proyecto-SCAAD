module div_freq (input clk,
                 output reg clk_1k,
                 output reg clk_1h);
   
   reg [27:0] cont;
   reg [27:0] cont2;
   
   initial begin
      cont  <= 28'd0;
      cont2 <= 28'd0;
   end
   
   always @ ( posedge clk ) begin
      cont  <= cont+28'd1;
      cont2 <= cont2+28'd1;
      if ( cont == 25_000 ) begin
         cont  <= 0;
         clk_1k <= ~clk_1k;
      end
      if ( cont2 == 25_000_000 ) begin
         cont2  <= 0;
         clk_1h <= ~clk_1h;
      end
   end
   
endmodule
