`timescale 1ns / 1ps
module LCD_Top(
                CLOCK_50,  //50 MZ
                 LCD_RW,   //LCD Read/Write Select, 0 = Write, 1 = Read
                 LCD_EN,   //LCD Enable
                 LCD_RS,   //LCD Command/Data Select, 0 = Command, 1 = Data
                 LCD_DATA, //LCD Data bus 8 bits
						mensaje
					  );


reg [8:0] Mostrar_10 = "H";
reg [8:0] Mostrar_11 = "O";
reg [8:0] Mostrar_12 = "L";
reg [8:0] Mostrar_13 = "A";
reg [8:0] Mostrar_14 = " ";
reg [8:0] Mostrar_15 = "M";
reg [8:0] Mostrar_16 = "U";
reg [8:0] Mostrar_17 = "N";
reg [8:0] Mostrar_18 = "D";
reg [8:0] Mostrar_19 = "O";
reg [8:0] Mostrar_110 = " ";
reg [8:0] Mostrar_111 = "L";
reg [8:0] Mostrar_112 = "I";
reg [8:0] Mostrar_113 = "N";
reg [8:0] Mostrar_114 = "E";
reg [8:0] Mostrar_115 = "1";
reg [8:0] Mostrar_20 = "P";
reg [8:0] Mostrar_21 = "R";
reg [8:0] Mostrar_22 = "U";
reg [8:0] Mostrar_23 = "E";
reg [8:0] Mostrar_24 = "B";
reg [8:0] Mostrar_25 = "A";
reg [8:0] Mostrar_26 = " ";
reg [8:0] Mostrar_27 = "L";
reg [8:0] Mostrar_28 = "I";
reg [8:0] Mostrar_29 = "N";
reg [8:0] Mostrar_210 = "E";
reg [8:0] Mostrar_211 = "A";
reg [8:0] Mostrar_212 = " ";
reg [8:0] Mostrar_213 = "2";
reg [8:0] Mostrar_214 = " ";
reg [8:0] Mostrar_215 = " ";               


input CLOCK_50;       //50 MHz
inout [7:0] LCD_DATA; //LCD Data bus 8 bits
input [3:0] mensaje;
output LCD_RW;        //LCD Read/Write Select, 0 = Write, 1 = Read
output LCD_EN;        //LCD Enable
output LCD_RS;        //LCD Command/Data Select, 0 = Command, 1 = Data



wire DLY_RST;


Reset_Delay r0 ( .iCLK(CLOCK_50),.oRESET(DLY_RST)    );

always @ ( *)begin

case(mensaje)
	0:begin
		Mostrar_10<=9'h120;//ESP
		Mostrar_11<=9'h120;//ESP
		Mostrar_12<=9'h142;//B
		Mostrar_13<=9'h149;//I
		Mostrar_14<=9'h145;//E
		Mostrar_15<=9'h14E;//N
		Mostrar_16<=9'h156;//V
		Mostrar_17<=9'h145;//E
		Mostrar_18<=9'h14E;//N
		Mostrar_19<=9'h149;//I
		Mostrar_110<=9'h144;//D
		Mostrar_111<=9'h14F;//O
		Mostrar_112<=9'h120;//ESP
		Mostrar_113<=9'h141;//A
		Mostrar_114<=9'h120;//ESP
		Mostrar_115<=9'h120;//ESP
		
		Mostrar_20<=9'h120;//ESP
		Mostrar_21<=9'h120;//ESP
		Mostrar_22<=9'h120;//ESP
		Mostrar_23<=9'h120;//ESP
		Mostrar_24<=9'h12A;//*
		Mostrar_25<=9'h153;//S
		Mostrar_26<=9'h143;//C
		Mostrar_27<=9'h141;//A
		Mostrar_28<=9'h141;//A
		Mostrar_29<=9'h144;//D
		Mostrar_210<=9'h12A; //*
		Mostrar_211<=9'h120;//ESP
		Mostrar_212<=9'h120;//ESP
		Mostrar_213<=9'h120;//ESP
		Mostrar_214<=9'h120;//ESP
		Mostrar_215<=9'h120;//ESP
	end
	1:begin
		Mostrar_10<=9'h150;//P
		Mostrar_11<=9'h172;//r
		Mostrar_12<=9'h165;//e
		Mostrar_13<=9'h173;//s
		Mostrar_14<=9'h169;//i
		Mostrar_15<=9'h16F;//o
		Mostrar_16<=9'h16E;//n
		Mostrar_17<=9'h165;//e
		Mostrar_18<=9'h120;//ESP
		Mostrar_19<=9'h141;//A
		Mostrar_110<=9'h120;//ESP
		Mostrar_111<=9'h170;//p
		Mostrar_112<=9'h161;//a
		Mostrar_113<=9'h172;//r
		Mostrar_114<=9'h161;//a
		Mostrar_115<=9'h120;//ESP
		
		Mostrar_20<=9'h120;//ESP
		Mostrar_21<=9'h120;//ESP
		Mostrar_22<=9'h120;//ESP
		Mostrar_23<=9'h163;//c
		Mostrar_24<=9'h16F;//o
		Mostrar_25<=9'h16E;//n
		Mostrar_26<=9'h174;//t
		Mostrar_27<=9'h169;//i
		Mostrar_28<=9'h16E;//n
		Mostrar_29<=9'h175;//u
		Mostrar_210<=9'h161;//a
		Mostrar_211<=9'h172;//r
		Mostrar_212<=9'h120;//ESP
		Mostrar_213<=9'h120;//ESP
		Mostrar_214<=9'h120;//ESP
		Mostrar_215<=9'h120;//ESP
	end
	3:begin
		Mostrar_10<=9'h14F;//O
		Mostrar_11<=9'h170;//p
		Mostrar_12<=9'h172;//r
		Mostrar_13<=9'h169;//i
		Mostrar_14<=9'h16D;//m
		Mostrar_15<=9'h161;//a
		Mostrar_16<=9'h120;//ESP
		Mostrar_17<=9'h142;//B
		Mostrar_18<=9'h120;//ESP
		Mostrar_19<=9'h170;//p
		Mostrar_110<=9'h161;//a
		Mostrar_111<=9'h172;//r
		Mostrar_112<=9'h161;//a
		Mostrar_113<=9'h120;//ESP
		Mostrar_114<=9'h120;//ESP
		Mostrar_115<=9'h120;//ESP
		
		Mostrar_20<=9'h164;//d
		Mostrar_21<=9'h175;//u
		Mostrar_22<=9'h163;//c
		Mostrar_23<=9'h168;//h
		Mostrar_24<=9'h161;//a
		Mostrar_25<=9'h172;//r
		Mostrar_26<=9'h173;//s
		Mostrar_27<=9'h165;//e
		Mostrar_28<=9'h120;//ESP
		Mostrar_29<=9'h133;//3
		Mostrar_210<=9'h120;//ESP
		Mostrar_211<=9'h16D;//m
		Mostrar_212<=9'h169;//i
		Mostrar_213<=9'h16E;//n
		Mostrar_214<=9'h120;//ESP
		Mostrar_215<=9'h120;//ESP
	end
	4:begin
		Mostrar_10<=9'h14F;//O
		Mostrar_11<=9'h170;//p
		Mostrar_12<=9'h172;//r
		Mostrar_13<=9'h169;//i
		Mostrar_14<=9'h16D;//m
		Mostrar_15<=9'h161;//a
		Mostrar_16<=9'h120;//ESP
		Mostrar_17<=9'h143;//C
		Mostrar_18<=9'h120;//ESP
		Mostrar_19<=9'h170;//p
		Mostrar_110<=9'h161;//a
		Mostrar_111<=9'h172;//r
		Mostrar_112<=9'h161;//a
		Mostrar_113<=9'h120;//ESP
		Mostrar_114<=9'h120;//ESP
		Mostrar_115<=9'h120;//ESP
		
		Mostrar_20<=9'h170;//p
		Mostrar_21<=9'h172;//r
		Mostrar_22<=9'h16F;//o
		Mostrar_23<=9'h167;//g
		Mostrar_24<=9'h172;//r
		Mostrar_25<=9'h161;//a
		Mostrar_26<=9'h16D;//m
		Mostrar_27<=9'h161;//a
		Mostrar_28<=9'h172;//r
		Mostrar_29<=9'h120;//ESP
		Mostrar_210<=9'h174;//t
		Mostrar_211<=9'h169;//i
		Mostrar_212<=9'h165;//e
		Mostrar_213<=9'h16D;//m
		Mostrar_214<=9'h170;//p
		Mostrar_215<=9'h16F;//o
	end
	5:begin
		Mostrar_10<=9'h149;//I
		Mostrar_11<=9'h16E;//n
		Mostrar_12<=9'h167;//g
		Mostrar_13<=9'h172;//r
		Mostrar_14<=9'h165;//e
		Mostrar_15<=9'h173;//s
		Mostrar_16<=9'h165;//e
		Mostrar_17<=9'h120;//ESP
		Mostrar_18<=9'h16D;//m
		Mostrar_19<=9'h165;//e
		Mostrar_110<=9'h16E;//n
		Mostrar_111<=9'h16F;//o
		Mostrar_112<=9'h173;//s
		Mostrar_113<=9'h120;//ESP
		Mostrar_114<=9'h164;//d
		Mostrar_115<=9'h165;//e
		
		Mostrar_20<=9'h120;//ESP
		Mostrar_21<=9'h120;//ESP
		Mostrar_22<=9'h120;//ESP
		Mostrar_23<=9'h136;//6
		Mostrar_24<=9'h120;//ESP
		Mostrar_25<=9'h16D;//m
		Mostrar_26<=9'h169;//i
		Mostrar_27<=9'h16E;//n
		Mostrar_28<=9'h175;//u
		Mostrar_29<=9'h174;//t
		Mostrar_210<=9'h16F;//o
		Mostrar_211<=9'h173;//s
		Mostrar_212<=9'h120;//ESP
		Mostrar_213<=9'h120;//ESP
		Mostrar_214<=9'h120;//ESP
		Mostrar_215<=9'h120;//ESP
	end
	6:begin
		Mostrar_10<=9'h120;//ESP
		Mostrar_11<=9'h120;//ESP
		Mostrar_12<=9'h149;//I
		Mostrar_13<=9'h16E;//n
		Mostrar_14<=9'h167;//g
		Mostrar_15<=9'h172;//r
		Mostrar_16<=9'h165;//e
		Mostrar_17<=9'h173;//s
		Mostrar_18<=9'h165;//e
		Mostrar_19<=9'h120;//ESP
		Mostrar_110<=9'h16C;//l
		Mostrar_111<=9'h161;//a
		Mostrar_112<=9'h173;//s
		Mostrar_113<=9'h120;//ESP
		Mostrar_114<=9'h120;//ESP
		Mostrar_115<=9'h120;//ESP
		
		Mostrar_20<=9'h120;//ESP
		Mostrar_21<=9'h164;//d
		Mostrar_22<=9'h165;//e
		Mostrar_23<=9'h163;//c
		Mostrar_24<=9'h165;//e
		Mostrar_25<=9'h16E;//n
		Mostrar_26<=9'h161;//a
		Mostrar_27<=9'h173;//s
		Mostrar_28<=9'h120;//ESP
		Mostrar_29<=9'h164;//d
		Mostrar_210<=9'h165;//e
		Mostrar_211<=9'h120;//ESP
		Mostrar_212<=9'h173;//s
		Mostrar_213<=9'h165;//e
		Mostrar_214<=9'h167;//g
		Mostrar_215<=9'h120;//ESP
	end
	7:begin
		Mostrar_10<=9'h120;//ESP
		Mostrar_11<=9'h120;//ESP
		Mostrar_12<=9'h149;//I
		Mostrar_13<=9'h16E;//n
		Mostrar_14<=9'h167;//g
		Mostrar_15<=9'h172;//r
		Mostrar_16<=9'h165;//e
		Mostrar_17<=9'h173;//s
		Mostrar_18<=9'h165;//e
		Mostrar_19<=9'h120;//ESP
		Mostrar_110<=9'h16C;//l
		Mostrar_111<=9'h16F;//o
		Mostrar_112<=9'h173;//s
		Mostrar_113<=9'h120;//ESP
		Mostrar_114<=9'h120;//ESP
		Mostrar_115<=9'h120;//ESP
		
		Mostrar_20<=9'h120;//ESP
		Mostrar_21<=9'h120;//ESP
		Mostrar_22<=9'h120;//ESP
		Mostrar_23<=9'h120;//ESP
		Mostrar_24<=9'h173;//s
		Mostrar_25<=9'h165;//e
		Mostrar_26<=9'h167;//g
		Mostrar_27<=9'h175;//u
		Mostrar_28<=9'h16E;//n
		Mostrar_29<=9'h164;//d
		Mostrar_210<=9'h16F;//o
		Mostrar_211<=9'h173;//s
		Mostrar_212<=9'h120;//ESP
		Mostrar_213<=9'h120;//ESP
		Mostrar_214<=9'h120;//ESP
		Mostrar_215<=9'h120;//ESP
	end
	8:begin
		Mostrar_10<=9'h120;//ESP
		Mostrar_11<=9'h120;//ESP
		Mostrar_12<=9'h120;//ESP
		Mostrar_13<=9'h144;//D
		Mostrar_14<=9'h169;//i
		Mostrar_15<=9'h173;//s
		Mostrar_16<=9'h166;//f
		Mostrar_17<=9'h172;//r
		Mostrar_18<=9'h175;//u
		Mostrar_19<=9'h174;//t
		Mostrar_110<=9'h165;//e
		Mostrar_111<=9'h120;//ESP
		Mostrar_112<=9'h173;//s
		Mostrar_113<=9'h175;//u
		Mostrar_114<=9'h120;//ESP
		Mostrar_115<=9'h120;//ESP
		
		Mostrar_20<=9'h120;//ESP
		Mostrar_21<=9'h120;//ESP
		Mostrar_22<=9'h120;//ESP
		Mostrar_23<=9'h120;//ESP
		Mostrar_24<=9'h120;//ESP
		Mostrar_25<=9'h120;//ESP
		Mostrar_26<=9'h164;//d
		Mostrar_27<=9'h175;//u
		Mostrar_28<=9'h163;//c
		Mostrar_29<=9'h168;//h
		Mostrar_210<=9'h161;//a
		Mostrar_211<=9'h120;//ESP
		Mostrar_212<=9'h120;//ESP
		Mostrar_213<=9'h120;//ESP
		Mostrar_214<=9'h120;//ESP
		Mostrar_215<=9'h120;//ESP
	end
	9:begin
		Mostrar_10<=9'h150;//P
		Mostrar_11<=9'h172;//r
		Mostrar_12<=9'h165;//e
		Mostrar_13<=9'h173;//s
		Mostrar_14<=9'h169;//i
		Mostrar_15<=9'h16F;//o
		Mostrar_16<=9'h16E;//n
		Mostrar_17<=9'h165;//e
		Mostrar_18<=9'h120;//ESP
		Mostrar_19<=9'h144;//D
		Mostrar_110<=9'h120;//ESP
		Mostrar_111<=9'h170;//p
		Mostrar_112<=9'h161;//a
		Mostrar_113<=9'h172;//r
		Mostrar_114<=9'h161;//a
		Mostrar_115<=9'h120;//ESP
		
		
		Mostrar_20<=9'h120;//ESP
		Mostrar_21<=9'h170;//p
		Mostrar_22<=9'h161;//a
		Mostrar_23<=9'h175;//u
		Mostrar_24<=9'h173;//s
		Mostrar_25<=9'h161;//a
		Mostrar_26<=9'h172;//r
		Mostrar_27<=9'h120;//ESP
		Mostrar_28<=9'h16C;//l
		Mostrar_29<=9'h161;//a
		Mostrar_210<=9'h120;//ESP
		Mostrar_211<=9'h164;//d
		Mostrar_212<=9'h175;//u
		Mostrar_213<=9'h163;//c
		Mostrar_214<=9'h168;//h
		Mostrar_215<=9'h161;//a
	end
	10:begin
	
		Mostrar_10<=9'h149;//I
		Mostrar_11<=9'h16E;//n
		Mostrar_12<=9'h167;//g
		Mostrar_13<=9'h172;//r
		Mostrar_14<=9'h165;//e
		Mostrar_15<=9'h173;//s
		Mostrar_16<=9'h165;//e
		Mostrar_17<=9'h120;//ESP
		Mostrar_18<=9'h174;//t
		Mostrar_19<=9'h161;//a
		Mostrar_110<=9'h172;//r
		Mostrar_111<=9'h16A;//j
		Mostrar_112<=9'h165;//e
		Mostrar_113<=9'h174;//t
		Mostrar_114<=9'h161;//a
		Mostrar_115<=9'h120;//ESP
		
		
		Mostrar_20<=9'h120;//ESP
		Mostrar_21<=9'h170;//p
		Mostrar_22<=9'h161;//a
		Mostrar_23<=9'h172;//r
		Mostrar_24<=9'h161;//a
		Mostrar_25<=9'h120;//ESP
		Mostrar_26<=9'h166;//f
		Mostrar_27<=9'h169;//i
		Mostrar_28<=9'h16E;//n
		Mostrar_29<=9'h161;//a
		Mostrar_210<=9'h16C;//l
		Mostrar_211<=9'h169;//i
		Mostrar_212<=9'h17A;//z
		Mostrar_213<=9'h161;//a
		Mostrar_214<=9'h172;//r
		Mostrar_215<=9'h120;//ESP
	end
	11:begin
	
		Mostrar_10<=9'h14D;//M
		Mostrar_11<=9'h169;//i
		Mostrar_12<=9'h172;//r
		Mostrar_13<=9'h165;//e
		Mostrar_14<=9'h120;//ESP
		Mostrar_15<=9'h173;//s
		Mostrar_16<=9'h175;//u
		Mostrar_17<=9'h120;//ESP
		Mostrar_18<=9'h167;//g
		Mostrar_19<=9'h161;//a
		Mostrar_110<=9'h173;//s
		Mostrar_111<=9'h174;//t
		Mostrar_112<=9'h16F;//o
		Mostrar_113<=9'h120;//ESP
		Mostrar_114<=9'h165;//e
		Mostrar_115<=9'h16E;//n
		
		Mostrar_20<=9'h16C;//l
		Mostrar_21<=9'h16F;//o
		Mostrar_22<=9'h173;//s
		Mostrar_23<=9'h120;//ESP
		Mostrar_24<=9'h164;//d
		Mostrar_25<=9'h169;//i
		Mostrar_26<=9'h173;//s
		Mostrar_27<=9'h170;//p
		Mostrar_28<=9'h16C;//l
		Mostrar_29<=9'h161;//a
		Mostrar_210<=9'h179;//y
		Mostrar_211<=9'h120;//ESP
		Mostrar_212<=9'h128;//(
		Mostrar_213<=9'h16D;//m
		Mostrar_214<=9'h14C;//L
		Mostrar_215<=9'h129;//)
	end
	12:begin
		Mostrar_10<=9'h150;//P
		Mostrar_11<=9'h172;//r
		Mostrar_12<=9'h165;//e
		Mostrar_13<=9'h173;//s
		Mostrar_14<=9'h169;//i
		Mostrar_15<=9'h16F;//o
		Mostrar_16<=9'h16E;//n
		Mostrar_17<=9'h165;//e
		Mostrar_18<=9'h120;//ESP
		Mostrar_19<=9'h123;//#
		Mostrar_110<=9'h120;//ESP
		Mostrar_111<=9'h170;//p
		Mostrar_112<=9'h161;//a
		Mostrar_113<=9'h172;//r
		Mostrar_114<=9'h161;//a
		Mostrar_115<=9'h120;//ESP
		
		
		Mostrar_20<=9'h120;//ESP
		Mostrar_21<=9'h120;//ESP
		Mostrar_22<=9'h120;//ESP
		Mostrar_23<=9'h172;//r
		Mostrar_24<=9'h165;//e
		Mostrar_25<=9'h169;//i
		Mostrar_26<=9'h16E;//n
		Mostrar_27<=9'h169;//i
		Mostrar_28<=9'h163;//c
		Mostrar_29<=9'h169;//i
		Mostrar_210<=9'h161;//a
		Mostrar_211<=9'h172;//r
		Mostrar_212<=9'h120;//ESP
		Mostrar_213<=9'h120;//ESP
		Mostrar_214<=9'h120;//ESP
		Mostrar_215<=9'h120;//ESP
	end
	13:begin
		Mostrar_10<=9'h147;//G
		Mostrar_11<=9'h172;//r
		Mostrar_12<=9'h161;//a
		Mostrar_13<=9'h163;//c
		Mostrar_14<=9'h169;//i
		Mostrar_15<=9'h161;//a
		Mostrar_16<=9'h173;//s
		Mostrar_17<=9'h120;//ESP
		Mostrar_18<=9'h170;//p
		Mostrar_19<=9'h16F;//o
		Mostrar_110<=9'h172;//r
		Mostrar_111<=9'h120;//ESP
		Mostrar_112<=9'h175;//u
		Mostrar_113<=9'h173;//s
		Mostrar_114<=9'h161;//a
		Mostrar_115<=9'h172;//r
		
		
		Mostrar_20<=9'h120;//ESP
		Mostrar_21<=9'h120;//ESP
		Mostrar_22<=9'h120;//ESP
		Mostrar_23<=9'h120;//ESP
		Mostrar_24<=9'h12A;//*
		Mostrar_25<=9'h153;//S
		Mostrar_26<=9'h143;//C
		Mostrar_27<=9'h141;//A
		Mostrar_28<=9'h141;//A
		Mostrar_29<=9'h144;//D
		Mostrar_210<=9'h12A; //*
		Mostrar_211<=9'h120;//ESP
		Mostrar_212<=9'h120;//ESP
		Mostrar_213<=9'h120;//ESP
		Mostrar_214<=9'h120;//ESP
		Mostrar_215<=9'h120;//ESP
	end
	14:begin
		Mostrar_10<=9'h150;//P
		Mostrar_11<=9'h172;//r
		Mostrar_12<=9'h165;//e
		Mostrar_13<=9'h173;//s
		Mostrar_14<=9'h169;//i
		Mostrar_15<=9'h16F;//o
		Mostrar_16<=9'h16E;//n
		Mostrar_17<=9'h165;//e
		Mostrar_18<=9'h120;//ESP
		Mostrar_19<=9'h12A;//*
		Mostrar_110<=9'h120;//ESP
		Mostrar_111<=9'h170;//p
		Mostrar_112<=9'h161;//a
		Mostrar_113<=9'h172;//r
		Mostrar_114<=9'h161;//a
		Mostrar_115<=9'h120;//ESP
		
		Mostrar_20<=9'h120;//ESP
		Mostrar_21<=9'h120;//ESP
		Mostrar_22<=9'h120;//ESP
		Mostrar_23<=9'h163;//c
		Mostrar_24<=9'h16F;//o
		Mostrar_25<=9'h16E;//n
		Mostrar_26<=9'h174;//t
		Mostrar_27<=9'h169;//i
		Mostrar_28<=9'h16E;//n
		Mostrar_29<=9'h175;//u
		Mostrar_210<=9'h161;//a
		Mostrar_211<=9'h172;//r
		Mostrar_212<=9'h120;//ESP
		Mostrar_213<=9'h120;//ESP
		Mostrar_214<=9'h120;//ESP
		Mostrar_215<=9'h120;//ESP
	end
		

endcase

end

LCD_TEST u5 (//Host Side
         .iCLK(CLOCK_50),
         .iRST_N(DLY_RST),
             //    LCD Side
         .LCD_DATA(LCD_DATA),
         .LCD_RW(LCD_RW),
         .LCD_EN(LCD_EN),
         .LCD_RS(LCD_RS),   
         .Mostrar_10(Mostrar_10),
		   .Mostrar_11(Mostrar_11),
			.Mostrar_12(Mostrar_12),
			.Mostrar_13(Mostrar_13),
			.Mostrar_14(Mostrar_14),
			.Mostrar_15(Mostrar_15),
			.Mostrar_16(Mostrar_16),
			.Mostrar_17(Mostrar_17),
			.Mostrar_18(Mostrar_18),
			.Mostrar_19(Mostrar_19),
			.Mostrar_110(Mostrar_110),
			.Mostrar_111(Mostrar_111),
			.Mostrar_112(Mostrar_112),
			.Mostrar_113(Mostrar_113),
			.Mostrar_114(Mostrar_114),
			.Mostrar_115(Mostrar_115),
			.Mostrar_20(Mostrar_20),
			.Mostrar_21(Mostrar_21),
			.Mostrar_22(Mostrar_22),
			.Mostrar_23(Mostrar_23),
			.Mostrar_24(Mostrar_24),
			.Mostrar_25(Mostrar_25),
			.Mostrar_26(Mostrar_26),
			.Mostrar_27(Mostrar_27),
			.Mostrar_28(Mostrar_28),
			.Mostrar_29(Mostrar_29),
			.Mostrar_210(Mostrar_210),
			.Mostrar_211(Mostrar_211),
			.Mostrar_212(Mostrar_212),
			.Mostrar_213(Mostrar_213),
			.Mostrar_214(Mostrar_214),
			.Mostrar_215(Mostrar_215)
             );

endmodule

