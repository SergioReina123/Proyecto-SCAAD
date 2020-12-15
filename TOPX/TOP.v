module TOP(	input Clk,

///////////////RFID/////////////////////
				input Rst_n,
				input Rx,
				output Tx,
				output [7:0]RxData,
////////////////////////////////////////
			  
/////////////VALVULA////////////////////
            output servo,
////////////////////////////////////////

////////////TECLADO/////////////////////
				input [3:0] filas,
            output [3:0] column,
            
            output en,
////////////////////////////////////////

/////////////TEMPORIZADOR///////////////
				input reset,
				output alarma,
////////////////////////////////////////

////////////////LCD/////////////////////
				inout [7:0] LCD_DATA,      
				output LCD_RW,        
				output LCD_EN,        
				output LCD_RS, 	
//////////////display 7/////////////////		
				output [0:6] SSeg,
				output [7:0] an,
///////////////PRESENCIA////////////////
				input presencia,
				input sw,
/////////////caudal/////////////////////
				input signal
);
			  
reg pause;
reg valvula;
reg [3:0]message;
reg [11:0] tiempo_establecido;
reg [2:0] status;
reg [1:0]sig;
reg [15:0] tiempo_aux;
reg[15:0]tiempo_sig2;
reg [29:0] count;

wire [3:0] num;
wire[15:0]tiempo_sig;								
wire[15:0] mililitros;
initial begin
	
	tiempo_aux=15'd0;
	sig=0;
	status=0;
	tiempo_establecido=15'd0;
	pause=1;
	count = 0;

end

	rfid_top rfid(.Clk(Clk),.Rst_n(Rst_n),.Rx(Rx),.Tx(Tx),.RxData(RxData));
	Valvula_top serv(.clk(Clk),.enable(valvula),.servo(servo));
	Keyboard_top key(.clk(Clk),.filas(filas),.column(column),.en(en),.num(num));
	temporizador_top temporizador(Clk,tiempo_establecido,reset,pause,alarma,tiempo_sig);
	LCD_Top lcd(.mensaje(message),.CLOCK_50(Clk),.LCD_RW(LCD_RW),.LCD_EN(LCD_EN),.LCD_RS(LCD_RS),.LCD_DATA(LCD_DATA));
	DisplayDin display(Clk,tiempo_sig2,num,SSeg,an);
	caudal cad(signal,	mililitros);
	

/////////////////////////////////////////////////////	
/////////////////MAQUINA DE ESTADOS//////////////////
/////////////////////////////////////////////////////

parameter INIT=0, MENU=1, RE_MIN=2,RE_DEC=3,RE_SEG=4, TEMP=5, PAUSE=6, END=7;

always @( posedge Clk) begin
	
		
		
	case (status)
	
		INIT: begin
		
			pause<=1;
			valvula<=0;		//valvula cerrada
			
			
			if(num == 4'hA)begin
				
				status <= MENU;
				count <= 0;
			
			end
			
			
			///////Mensajes////////
			if(count <= 100_000_000)begin	
				count <= count + 1;
				message <= 0; 		//Muestra en el LCD "Bienvenido a SCAAD"
			end
			else if(count <= 250_000_000) begin
				count <= count + 1;
				message <= 1; 		//Muestra en el LCD "Presione A para continuar"
			end
			else begin
				count <= 0;
			end
			////////////////////////

		end
		
		MENU: begin
		
			valvula<=0; 		//valvula cerrada
		 		
			
			if(num == 4'hB)begin
				status <= TEMP;
				count <= 0;
			end
			if(num == 4'hC)begin
				status <= RE_MIN;
				count <= 0;
			end
			
			
			
			///////Mensajes////////
			if(count <= 150_000_000)begin	
				count <= count + 1;
				message <= 3; 		//Muestra en el LCD "Oprima B para ducharse 3 min" 
			end
			else if(count <= 300_000_000) begin
				count <= count + 1;
				message <= 4; 		//Muestra en el LCD "Oprima C para programar tiempo" 
			end
			else begin
				count <= 0;
			end
			////////////////////////
		
		end
		
		RE_MIN: begin
			
			tiempo_sig2<=tiempo_aux;
			valvula<=0;	
			
			if(num!=4'hC && num!=4'hF && num!=4'hA && num!=4'hB && num!=4'hD && num!=4'hE && num!=4'h6 && num!=4'h7 && num!=4'h8 && num!=4'h9)begin  //No se pueden poner mas de 5 minutos de agua en la ducha para aumentar la efectividad del ahorro.
				tiempo_aux[11:8]<=num;
			end
			
			
			if(num==4'hF)begin
				sig=1;
				status<=RE_DEC;
				count <= 0;
			end
			
			
			///////Mensajes////////
			if(count <= 100_000_000)begin	
				count <= count + 1;
				message <= 5; 		//Muestra en el LCD "Ingrese menos de 6 minutos"  
			end
			else if(count <= 200_000_000) begin
				count <= count + 1;
				message <= 14; 		//Muestra en el LCD "Presione * para conttinuar" 
			end
			else begin
				count <= 0;
			end
			////////////////////////
			
		end
		
		RE_DEC: begin
			
			tiempo_sig2<=tiempo_aux;
			valvula<=0;
			
			
			if( num!=4'hF && num!=4'hC && num!=4'hA && num!=4'hB && num!=4'hD && num!=4'hE && num!=4'h6 && num!=4'h7 && num!=4'h8 && num!=4'h9)begin
				sig<=0;
				tiempo_aux[7:4]<=num;
			end
			
			if(num==4'hF && sig==0)begin
				sig<=1;
				status<=RE_SEG;
				count <= 0;
			end
			
			
			///////Mensajes////////
			if(count <= 100_000_000)begin	
				count <= count + 1;
				message <= 6;			//Muestra en el LCD "Ingrese las decenas de seg"  
			end
			else if(count <= 200_000_000) begin
				count <= count + 1;
				message <= 14; 		//Muestra en el LCD "Presione * para conttinuar" 
			end
			else begin
				count <= 0;
			end
			////////////////////////
				
		end
		
		RE_SEG: begin
			
			tiempo_sig2<=tiempo_aux;
			valvula<=0;
			
			
			if(num!=4'hC && num!=4'hF && num!=4'hA && num!=4'hB && num!=4'hD && num!=4'hE)begin
				sig<=0;
				tiempo_aux[3:0]<=num;
			end
			if(num==4'hF && sig==0)begin
				sig<=1;
				status<=TEMP;
				count <= 0;
			end
			
			///////Mensajes////////
			if(count <= 100_000_000)begin	
				count <= count + 1;
				message <= 7;			//Muestra en el LCD "Ingrese los segundos" 
			end
			else if(count <= 200_000_000) begin
				count <= count + 1;
				message <= 14; 		//Muestra en el LCD "Presione * para conttinuar" 
			end
			else begin
				count <= 0;
			end
			////////////////////////
			
			
		end
		
		TEMP: begin
			
			tiempo_sig2<=tiempo_sig;
			pause<=0;
									//Abre la valvula
			
			if(sig==0) begin
				tiempo_establecido<=16'b0000_0011_0000_0000;
				sig<=2;
			end
			
			if(sig==1) begin
				tiempo_establecido<=tiempo_aux;
				sig<=2;
			end
				if(tiempo_sig == 0 && count <= 250_000_000)begin
				valvula <= 0;
			end
			else valvula <= 1;
			
			if(presencia==1 || num==4'hD)begin
				status<=PAUSE;
				count <= 0;
			end
			
			if(RxData==8'b0010_1011 || RxData==8'b0100_0000  || RxData==8'b1000_0110  || RxData==8'b1111_1110)begin
				status<=END;
				count <= 0;
			end
			
			
			
			///////Mensajes////////
			if(count <= 200_000_000)begin	
				count <= count + 1;
				message <= 8; 		//Muestra en el LCD "Disfrute su ducha" 
			end
			else if(count <= 350_000_000) begin
				count <= count + 1;
				message <= 9; 		//Muestra en el LCD "Presione D para pausar la ducha"
			end
			else if(count <= 500_000_000)begin
				count <= count + 1;
				message <= 10; 		//Muestra en el LCD "Ingrese tarjeta para finalizar"
			end
			else begin
				count <= 0;
			end
			////////////////////////
			
			
		end
		
		

		PAUSE: begin
			
			valvula <= 0;
			pause <= 1;
			
			if(presencia==0 && num==4'hA)begin
				status<=TEMP;
				count <= 0;
			end
			
			if(RxData==8'b0010_1011 || RxData==8'b0100_0000  || RxData==8'b1000_0110  || RxData==8'b1111_1110)begin
				status<=END;
				count <= 0;
			end
			
			
			
			///////Mensajes////////
			if(count <= 150_000_000)begin	
				count <= count + 1;
				message <= 1; 			//Muestra en el LCD "Oprima A continuar" 
			end
			else if(count <= 250_000_000) begin
				count <= count + 1;
				message <= 10; 		//Muestra en el LCD "Ingrese tarjeta para finalizar"
			end
			else begin
				count <= 0;
			end
			////////////////////////
			
		end
		
		END: begin
			
			tiempo_sig2=mililitros;
			valvula <= 0;
			pause <= 1;
			
			if(num == 4'hE)begin
				status <= INIT;
				count <= 0;
			end
			
			///////Mensajes////////
			if(count <= 200_000_000)begin	
				count <= count + 1;
				message <= 11; 			//Muestra en el LCD "Mire su consumo en los display" 
			end
			else if(count <= 300_000_000) begin
				count <= count + 1;
				message <= 13; 		//Muestra en el LCD "Gracias por usar SCAAD"
			end
			else if(count <= 450_000_000)begin
				count <= count + 1;
				message <= 12; 		//Muestra en el LCD "Presione # para reiniciar" 
			end
			else begin
				count <= 0;
			end
			////////////////////////
			
			
			
		end
		
		default: status=INIT;
	
	endcase 
end 
endmodule
