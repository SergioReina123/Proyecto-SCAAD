module Keyboard_top(input clk,
                input [3:0] filas,
                output [3:0] column,
                output [0:6] SSeg,
                output reg en,
					 output [3:0] num
					 );
   
   wire clk_1;
   
	initial en <= 0;

   div_freq div( .clk(clk),.clk_1k(clk_1));
   barrido bar( clk_1,column );
   comparador comp( filas,column,clk_1 ,num);
   BCDtoSSeg bcd( num,SSeg );

   
endmodule
