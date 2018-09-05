//------------------------------------------------------------
// connect the button to digital pin D8
int buttonPin = 8;
// an empty variable to hold data from the button
int buttonVal;


// three characters used for Serial communication
char START_BYTE = '*';
char DELIMITER = ',';
char END_BYTE = '#';

//------------------------------------------------------------

void setup() {
  // put your setup code here, to run once:
  
  // begin serial communication at 9600 baud rate
  Serial.begin(9600);

  // set the internal pullup resistor for this pin to HIGH
  digitalWrite(buttonPin, HIGH);
  
  // send a byte to establish contact until receiver responds
  establishContact();

  // end of the setup function
}

//------------------------------------------------------------

void loop() {
  // put your main code here, to run repeatedly:

  // assign button input to the empty variable
  buttonVal = digitalRead(buttonPin);

  // start of input data being communicated...
  Serial.write(START_BYTE); 
  Serial.print(DELIMITER);
  
  // communicate data from buttonVal variable
  Serial.print(buttonVal);
  Serial.print(DELIMITER);
  
  // communicate that communication is over
  Serial.write(END_BYTE);
  // send a carriage return
  Serial.println();
}

//------------------------------------------------------------

void establishContact(){
  // while there is zero (or less) serial communication
  // keep sending "hello" until the computer responds to the Arduino
  while(Serial.available() <= 0){
    Serial.println("hello");
    delay(300);
  }
}

//------------------------------------------------------------

