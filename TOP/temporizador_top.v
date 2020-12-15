module temporizador_top(clk,
                    tiempo_establecido,
                    reset,
                    pause,
                    alarma,
						  tiempo_sig
						  );
   
    input clk;
    input reset;
    input pause;
	 input [11:0] tiempo_establecido;   //12 bits para almacenar 3 BCD de 4 bits para minutos, decimas de segundos y segundos para el tiempo programado por el usuario

    output alarma;
   
	
	 output [11:0] tiempo_sig;   //Almacena el tiempo siguiente (el tiempo menos 1 segundo)
	
	
    div_freq div(clk,clk_1k,clk_1h);
    
    temporizador temp(.clk_1h(clk_1h),.tiempo_establecido(tiempo_establecido),.tiempo_sig(tiempo_sig),.reset(reset),.pause(pause),.alarma(alarma));
   

endmodule
