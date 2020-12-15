module temporizador(clk_1h,
                    tiempo_establecido,
                    tiempo_sig,
                    reset,
                    pause,
                    alarma);
    
    
    input clk_1h;
    
    input [11:0] tiempo_establecido;    //12 bits para almacenar 3 BCD de 4 bits para minutos, decimas de segundos y segundos para el tiempo programado por el usuario
    input reset;
    input pause;
    
    output reg[11:0] tiempo_sig;   //Almacena el tiempo siguiente (el tiempo menos 1 segundo)
    output reg alarma;
	 reg [1:0]status;

    initial begin
	 
		status = 0;
		alarma = 1;
			
    end
    
	 
	 parameter INIT=0, EJEC=1;
	 
    always@(posedge clk_1h)begin  	 //Proceso para lógica del temporizador
	 
	 case (status)
			INIT: begin
				tiempo_sig=tiempo_establecido;
				if(tiempo_sig != 12'd0) begin
					status = EJEC;
				end
			end
			EJEC: begin 
				  if (!pause)begin
						
						if (tiempo_sig != 12'd0)begin  //cuandon llegue a 0 se detiene el temporizador
							 
							 if (tiempo_sig[11:8]== 4'd0  && tiempo_sig[7:4]<= 4'd3 && tiempo_sig[3:0]>= 4'd0)begin //La alarma suena unos segundos cuando faltan 30 seg del tiempo total  tiempo_seg <= 30
								  
								  if (tiempo_sig[11:8]== 4'd0  && tiempo_sig[7:4]== 4'd2 && tiempo_sig[3:0]>= 4'd4)begin
										alarma = alarma + 1;    //Se desactiva la alarma cuando el temporizador llegue al 24 seg del tiempo establecido (se apaga y se prende cada segundo por desbordamiento)
								  end
								  
								  else begin
										alarma = 1; //Apaga la alarma despues de 6 señales de reloj
								  end
							 
							 end
						
							 tiempo_sig[3:0] = tiempo_sig[3:0] - 4'd1;   // restamos 1 cada segundo
						
							 if (tiempo_sig[3:0] == 4'hf) begin
							 
								  tiempo_sig[3:0] = 4'd9; //Condición para el display de segundos
								  tiempo_sig[7:4] = tiempo_sig[7:4] - 4'd1;
							 
							 end
						
							 if (tiempo_sig[7:4] == 4'hf) begin
							 
								  tiempo_sig[7:4]  = 4'd5;    //Condición para el display de decenas segundos
								  tiempo_sig[11:8] = tiempo_sig[11:8] - 4'd1; //Condición para el display de minutos
							 
							 end
								
						
						end

				  
						else begin
				  
							 alarma = alarma + 1;    //Se activa la alarma cuando el temporizador llegue a cero (se apaga y se prende cada segundo por desbordamiento)
				  
						end
					
			 
					end
					
					else begin
						alarma=1;
					end
			end
			
		default: status=INIT;
	endcase 
    
   end
    
endmodule
