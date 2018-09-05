#include <CapacitiveSensor.h>



int potPin = A0;
int potVal = 0;

int buttonPin = 7;
int buttonVal;

int touchPin = 8;
int touchVal;


CapacitiveSensor   foilPins1 = CapacitiveSensor(2,4);        // 10M resistor between pins 4 & 2, pin 2 is sensor pin, add a wire and or foil if desired
CapacitiveSensor   foilPins2 = CapacitiveSensor(2,3);        // 10M resistor between pins 4 & 6, pin 6 is sensor pin, add a wire and or foil



char START_BYTE = '*';
char DELIMITER = ',';
char END_BYTE = '#';


void setup() {
  // put your setup code here, to run once:
  foilPins1.set_CS_AutocaL_Millis(0xFFFFFFFF);     // turn off autocalibrate on channel 1 - just as an example
  foilPins2.set_CS_AutocaL_Millis(0xFFFFFFFF);     // turn off autocalibrate on channel 2 - just as an example

  pinMode(buttonPin, INPUT);
  digitalWrite(buttonPin, HIGH);
  digitalWrite(touchPin, HIGH);
  Serial.begin(9600);
  establishContact();

}

void loop() {
  // put your main code here, to run repeatedly:
  potVal = analogRead(potPin);
  buttonVal = digitalRead(buttonPin);
  touchVal = digitalRead(touchPin);
  long start = millis();
  long foilVal1 =  foilPins1.capacitiveSensor(1);
  long foilVal2 =  foilPins2.capacitiveSensor(1);

  Serial.write(START_BYTE);
  Serial.print(DELIMITER);
  
  Serial.print(potVal);
  Serial.print(DELIMITER);

  Serial.print(buttonVal);
  Serial.print(DELIMITER);

  Serial.print(touchVal);
  Serial.print(DELIMITER);

  Serial.print(foilVal1);
  Serial.print(DELIMITER);

  Serial.print(foilVal2);
  Serial.print(DELIMITER);

  Serial.write(END_BYTE);
  Serial.println();



}

void establishContact(){
  while(Serial.available() <= 0){
    Serial.println("hello");
    delay(300);
  }
}

