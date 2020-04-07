//sensores analogos

int sensorValue;
int sensorValue2;
int sensorValue3;
int sensorValue4; 

int inputPin = 9;
int inputPin2 = 8;
int inputPin3 = 7;
int inputPin4 = 10;

void setup() 
{
  Serial.begin(9600);  
}

void loop() 
{
  //al dividirlo entre 4 me bota datos de 0-255 y no de 0-1023 ke es lo normal 
  sensorValue = digitalRead(inputPin);
  sensorValue2 = digitalRead(inputPin2);
  sensorValue3 = digitalRead(inputPin3);
  sensorValue4 = digitalRead(inputPin4);

  //sensorValue = analogRead(inputPin)/4;
  //sensorValue2 = analogRead(inputPin2)/4;
  
  
  //imprimo el dato en consola DEC para poderlo ver yo, Byte para ke lo vea la makina, solo se imprime cuando no se este usando serial.write
  //Serial.println(sensorValue, DEC);
  //Serial.println(sensorValue2, DEC);
  //Serial.println(sensorValue3, DEC);
  //Serial.println(sensorValue4, DEC);
  //otra forma de enviar los datos a processing es no usando serial.write, sino serial.println, sin embargo en processing no se utiliza port.read(), sino port.readStringUntil('\n');
  Serial.print(sensorValue);
  Serial.print('T');
  Serial.print(sensorValue2);
  Serial.print('T');
  Serial.print(sensorValue3);
  Serial.print('T');
  Serial.print(sensorValue4);
  Serial.println();
 

  //cada 100 me envia el dato  
  delay(300); 
}
