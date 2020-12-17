#include <SPI.h>          //  Libreria SPI
#include <MFRC522.h>      // Libreria  MFRC522

#define RST_PIN  9        // Pin de reset
#define SS_PIN  10        // Pin de slave select

MFRC522 mfrc522(SS_PIN, RST_PIN);   // Objeto mfrc522 enviando pines de slave select y reset

byte LecturaUID[4];                             // Array para almacenar el UID leido
byte Usuario1[4] = {0x63, 0xF7, 0x41, 0x1D} ;   // {0x63, 0xF7, 0x41, 0x1D} NUMERO DEL USUARIO 1 (ponga el de su tarjeta)
byte Usuario2[4] = {0xE7, 0x2E, 0xDB, 0xD8} ;   // {0xE7, 0x2E, 0xDB, 0xD8} NUMERO DEL USUARIO 2 (ponga el de su tarjeta)

int cont;
String inbyte;

void setup() {

  Serial.begin(9600);                   // inicializa comunicacion por monitor serie a 9600 bps
  SPI.begin();                          // inicializa bus SPI
  mfrc522.PCD_Init();                   // inicializa modulo lector

}

void loop() {
  
  if ( ! mfrc522.PICC_IsNewCardPresent())       // si no hay una tarjeta presente
  return;                                       // retorna al loop esperando por una tarjeta
  
  if ( ! mfrc522.PICC_ReadCardSerial())         // si no puede obtener datos de la tarjeta
  return;                                       // retorna al loop esperando por otra tarjeta
                           
  for (byte i = 0; i < 4; i++) {                // bucle recorre de a un byte por vez el UID
          
    LecturaUID[i]=mfrc522.uid.uidByte[i];       // almacena en array el byte del UID leido      
  
  }                         
  if(comparaUID(LecturaUID, Usuario1))          // llama a funcion comparaUID con Usuario1
    Serial.print(String('@'));
  
  else if(comparaUID(LecturaUID, Usuario2))    // llama a funcion comparaUID con Usuario2
    Serial.print(String('+'));     // si retorna verdadero muestra texto bienvenida
  
  else                                          // si retorna falso
    Serial.print(0);        
             
  mfrc522.PICC_HaltA();                         // detiene comunicacion con tarjeta       

}

boolean comparaUID(byte lectura[],byte usuario[]){  // funcion comparaUID
  
  for (byte i=0; i < 4; i++)                        // bucle recorre de a un byte por vez el UID
    if(lectura[i] != usuario[i])                    // si byte de UID leido es distinto a usuario
      return(false);                                // retorna falso
  
  return(true);                                     // si los 4 bytes coinciden retorna verdadero

}
