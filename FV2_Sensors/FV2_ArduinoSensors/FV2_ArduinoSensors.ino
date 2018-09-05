int potPin = A0;
int potVal = 0;

int buttonPin = 7;
int buttonVal;

int touchPin = 8;
int touchVal;



char START_BYTE = '*';
char DELIMITER = ',';
char END_BYTE = '#';


void setup() {
  // put your setup code here, to run once:
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

  Serial.write(START_BYTE);
  Serial.print(DELIMITER);
  
  Serial.print(potVal);
  Serial.print(DELIMITER);

  Serial.print(buttonVal);
  Serial.print(DELIMITER);

  Serial.print(touchVal);
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

