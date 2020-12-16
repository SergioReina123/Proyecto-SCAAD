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
			  
reg pause;								//Para pausar o iniciar el temporizador
reg valvula;							//Para abrir o cerrar el servomotor que controla la valvula
reg [3:0]message;						//Para elegir que mensaje se muestra en el LCD
reg [11:0] tiempo_establecido;	//Para asignar un tiempo al temporizador
reg [2:0] status;						//Para determinar en que estado actual de la máquina de estados
reg [1:0]sig;							//Usada como confirmación para relaizar algunas acciones cuando el usuario esta reprogramando el tiempo
reg [15:0] tiempo_aux;				//Registro auxiliar para cargar el tiempo ingresado
reg[15:0]tiempo_sig2;				//Registro auxiliar para ingresar el tiempo al temporizador
reg [29:0] count;						//Contador usado para cambiar mensajes en un mismo estado automaticamente

wire clk_1h;

reg contar_caudal;
wire [3:0] num;						//Tecla presionada en el teclado en hexadecimal
wire[15:0]tiempo_sig;				//Tiempo actualizado cada segundo que devuelve el temporizador							
wire[15:0] mililitros;				//Cantidad de consumo total devuelta por el contador de agua 'caudal'
initial begin
	
	tiempo_aux=15'd0;					//Inicialización de registros
	sig=0;
	status=0;
	tiempo_establecido=15'd0;
	pause=1;
	count = 0;
	contar_caudal = 0;

end

	rfid_top rfid(.Clk(Clk),.Rst_n(Rst_n),.Rx(Rx),.Tx(Tx),.RxData(RxData));
	Valvula_top serv(.clk(Clk),.enable(valvula),.servo(servo));
	Keyboard_top key(.clk(Clk),.filas(filas),.column(column),.en(en),.num(num));
	temporizador_top temporizador(Clk,tiempo_establecido,reset,pause,alarma,tiempo_sig);
	LCD_Top lcd(.mensaje(message),.CLOCK_50(Clk),.LCD_RW(LCD_RW),.LCD_EN(LCD_EN),.LCD_RS(LCD_RS),.LCD_DATA(LCD_DATA));
	DisplayDin display(Clk,tiempo_sig2,num,SSeg,an);
	caudal cad(clk_1h, contar_caudal	,mililitros);
	
	div_freq (.clk(Clk), .clk_1h(clk_1h));
	

/////////////////////////////////////////////////////	
/////////////////MAQUINA DE ESTADOS//////////////////
/////////////////////////////////////////////////////

parameter INIT=0, MENU=1, RE_MIN=2,RE_DEC=3,RE_SEG=4, TEMP=5, PAUSE=6, END=7;

always @( posedge Clk) begin
	
		
		
	case (status)
	
		INIT: begin
		
			pause<=1;										//Temporizador pausado
			valvula<=0;										//valvula cerrada
			contar_caudal <= 0;
			
				
			if(num == 4'hA)begin							//Condicional a la espera de presionar 'A' para continuar
				
				status <= MENU;
				count <= 0;									//Al salir de cada estado se reinicia el contador del tiempo de los mensajes para que se muestren en el orden correcto
			
			end
			
			
			///////Mensajes////////	
			if(count <= 100_000_000)begin				//Duración de 2 segundos (el clk de la FPGA es de 50MHz)
				count <= count + 1;
				message <= 0; 								//Muestra en el LCD "Bienvenido a SCAAD"
			end
			else if(count <= 250_000_000) begin		//Duración de 3 segundos, si se tiene en cuenta que el mensaje se empieza a mostrar cuando count es mayor a 100 millones
				count <= count + 1;
				message <= 1; 								//Muestra en el LCD "Presione A para continuar"
			end
			else begin
				count <= 0;									//Al mostrar los dos mensajes se reinicia el contador para vlvler al primer condicional y repetir el proceso
			end
			////////////////////////

		end
		
		MENU: begin
		
			valvula<=0; 									//Válvula cerrada
		 		
			
			if(num == 4'hB)begin							//Si se presiona B se pasa al estado TEMP (Temporizador)
				status <= TEMP;
				count <= 0;
			end
			if(num == 4'hC)begin							//Si se presiona C se pasa al estado RE_MIN (Para programar el tiempo de baño)
				status <= RE_MIN;
				count <= 0;
			end
			
			
			
			///////Mensajes////////
			if(count <= 150_000_000)begin	
				count <= count + 1;
				message <= 3; 								//Muestra en el LCD "Oprima B para ducharse 3 min" 
			end
			else if(count <= 300_000_000) begin
				count <= count + 1;
				message <= 4; 								//Muestra en el LCD "Oprima C para programar tiempo" 
			end
			else begin
				count <= 0;
			end
			////////////////////////
		
		end
		
		RE_MIN: begin
			
			tiempo_sig2<=tiempo_aux;					//Se carga en tiempo sig2 tiempo auxiliar el cual fue incializado en cero
			valvula<=0;										//Válvula cerrada
			
			if(num!=4'hC && num!=4'hF && num!=4'hA && num!=4'hB && num!=4'hD && num!=4'hE && num!=4'h6 && num!=4'h7 && num!=4'h8 && num!=4'h9)begin  //No se pueden poner 6 o mas minutos de agua en la ducha para aumentar la efectividad del ahorro. Tampoco se pueden ingresar letras
				tiempo_aux[11:8]<=num;					//Carga el número ingresado en el teclado en los 4 bits mas significaticos de tiempo auxiliar que representan los minutos
			end
			
			
			if(num==4'hF)begin							//Se espera que se presione '*' para confirmar la información recibida y continuar a programar las decenas de segundos					
				sig=1;
				status<=RE_DEC;							//Se asigna siguiente a 1 lo cual permite evitar errores por la alta frecuencia de lectura del teclado
				count <= 0;
			end
			
			
			///////Mensajes////////
			if(count <= 100_000_000)begin	
				count <= count + 1;
				message <= 5; 								//Muestra en el LCD "Ingrese menos de 6 minutos"  
			end
			else if(count <= 200_000_000) begin
				count <= count + 1;
				message <= 14; 							//Muestra en el LCD "Presione * para conttinuar" 
			end
			else begin
				count <= 0;
			end
			////////////////////////
			
		end
		
		RE_DEC: begin
			
			tiempo_sig2<=tiempo_aux;					//Se carga en tiempo_sig el tiempo con los minutos ya ingresados
			valvula<=0;										//Válvula cerrada
			
			
			if( num!=4'hF && num!=4'hC && num!=4'hA && num!=4'hB && num!=4'hD && num!=4'hE && num!=4'h6 && num!=4'h7 && num!=4'h8 && num!=4'h9)begin		//No se pueden poner 6 o mas decenas de segundos porque 60 segundos equivalen a 1 minuto. Tampoco se pueden ingresar letras
				sig<=0;
				tiempo_aux[7:4]<=num;					//Se guarda en tiempo_aux el número ingresado en el teclado
			end
			
			if(num==4'hF && sig==0)begin				//Condicional que permite la confirmación del número con '*'. La condición de sig permite que no se ejecute este if con la tecla presionada en el anterior estado por la alta frecuencia de transmisión de datos del teclado. 
				sig<=1;
				status<=RE_SEG;							//Se continua al estado para programar los segundos
				count <= 0;
			end
			
			
			///////Mensajes////////
			if(count <= 100_000_000)begin	
				count <= count + 1;
				message <= 6;								//Muestra en el LCD "Ingrese las decenas de seg"  
			end
			else if(count <= 200_000_000) begin
				count <= count + 1;
				message <= 14; 							//Muestra en el LCD "Presione * para conttinuar" 
			end
			else begin
				count <= 0;
			end
			////////////////////////
				
		end
		
		RE_SEG: begin
			
			tiempo_sig2<=tiempo_aux;
			valvula<=0;										//Válvula cerrada
			
			
			if(num!=4'hC && num!=4'hF && num!=4'hA && num!=4'hB && num!=4'hD && num!=4'hE)begin		//No se permite ingresar letras
				sig<=0;
				tiempo_aux[3:0]<=num;					//Se guardan los segundos ingresados en tiempo_aux
			end
			if(num==4'hF && sig==0)begin				//Condicional que permite la confirmación del número con '*'. La condición de sig permite que no se ejecute este if con la tecla presionada en el anterior estado por la alta frecuencia de transmisión de datos del teclado. 
				sig<=1;
				status<=TEMP;								//Una vez se ingresan los segundos se pasa al estado donde empieza la ducha
				count <= 0;
			end
			
			///////Mensajes////////
			if(count <= 100_000_000)begin	
				count <= count + 1;
				message <= 7;								//Muestra en el LCD "Ingrese los segundos" 
			end
			else if(count <= 200_000_000) begin
				count <= count + 1;
				message <= 14; 							//Muestra en el LCD "Presione * para conttinuar" 
			end
			else begin
				count <= 0;
			end
			////////////////////////
			
			
		end
		
		TEMP: begin
			
			tiempo_sig2<=tiempo_sig;					//El tiempo cargado se muestra en el display
			pause<=0;										//Abre la valvula
			contar_caudal <= 1;							//Se inicia a contar el agua que fluye
				
				
			if(tiempo_sig == 0 && count <= 250_000_000)begin	//Abre y cierra valvula cuando cada 3 segundos cuando el tiempo se agote. El contador es el mismo usado para los mensajes y este se reinicia en dichas lineas de código
				valvula <= 0;
			end
			else valvula <= 1;							//De lo contrario abre la válvula
			
										
			if(sig==0) begin							//Si sig = 0 significa que no se entró en los estados para programar el tiempo y se pone un timepo por default de 3 minutos
				tiempo_establecido<=16'b0000_0011_0000_0000;		//Se carga tiempo por default de 3 minutos
				sig<=2;
			end
			
			if(sig==1) begin							//Si sig = 1 el usuario si ingresó un tiempo y este es posteriormente cargado en tiempo establecido
				tiempo_establecido<=tiempo_aux;
				sig<=2;
			end
				
			
			if(presencia==1 || num==4'hD)begin		//Si no se detecta a alguien en la ducha o se presiona 'D' en el teclado se va al estado PAUSE
				status<=PAUSE;
				count <= 0;
			end
			
			if(RxData==8'b0010_1011 || RxData==8'b0100_0000  || RxData==8'b1000_0110  || RxData==8'b1111_1110)begin		//Si acerca la terjeta al lector RFID se detecta la señal y se va al estado END
				status<=END;
				count <= 0;
			end
			
			
			
			///////Mensajes////////
			if(count <= 200_000_000)begin	
				count <= count + 1;
				message <= 8; 							//Muestra en el LCD "Disfrute su ducha" 
			end
			else if(count <= 350_000_000) begin
				count <= count + 1;
				message <= 9; 							//Muestra en el LCD "Presione D para pausar la ducha"
			end
			else if(count <= 500_000_000)begin
				count <= count + 1;
				message <= 10; 						//Muestra en el LCD "Ingrese tarjeta para finalizar"
			end
			else begin
				count <= 0;
			end
			////////////////////////	
			
			
		end
		
		

		PAUSE: begin
			
			valvula <= 0;								//Válvula cerrada
			pause <= 1;									//El temporizador se pone en pausa
			contar_caudal <= 0;						//Detiene el conteo del agua
			
			if(presencia==0 && num==4'hA)begin
				status<=TEMP;							//Si se detecta a alguien en la ducha y se presiona 'A' se reanuda el baño
				count <= 0;
			end
			
			if(RxData==8'b0010_1011 || RxData==8'b0100_0000  || RxData==8'b1000_0110  || RxData==8'b1111_1110)begin 	//Si acerca la terjeta al lector RFID se detecta la señal y se va al estado END
				status<=END;
				count <= 0;
			end
			
			
			
			///////Mensajes////////
			if(count <= 150_000_000)begin	
				count <= count + 1;
				message <= 1; 							//Muestra en el LCD "Oprima A continuar" 
			end
			else if(count <= 250_000_000) begin
				count <= count + 1;
				message <= 10; 						//Muestra en el LCD "Ingrese tarjeta para finalizar"
			end
			else begin
				count <= 0;
			end
			////////////////////////
			
		end
		
		END: begin
			
			tiempo_sig2=mililitros;					//Se usa la variable tiempo siguiente mostrada en los display para cargar los mililitros y que estos aparezcan allí
			valvula <= 0;								//Cierra la válvula
			pause <= 1;									//Detiene el conteo del temporizador
			contar_caudal <= 0;
			
			if(num == 4'hE)begin						//Si se presiona '#' en el teclado, se vuelve al estado INIT
				status <= INIT;
				count <= 0;
			end
			
			///////Mensajes////////
			if(count <= 200_000_000)begin	
				count <= count + 1;
				message <= 11; 						//Muestra en el LCD "Mire su consumo en los display" 
			end
			else if(count <= 300_000_000) begin
				count <= count + 1;
				message <= 13; 						//Muestra en el LCD "Gracias por usar SCAAD"
			end
			else if(count <= 450_000_000)begin
				count <= count + 1;
				message <= 12; 						//Muestra en el LCD "Presione # para reiniciar" 
			end
			else begin
				count <= 0;
			end
			////////////////////////
			
			
			
		end
		
		default: status=INIT;						//Si hay algún error en el registro status, por defecto la máquina irá a INIT
	
	endcase 
end 
endmodule
