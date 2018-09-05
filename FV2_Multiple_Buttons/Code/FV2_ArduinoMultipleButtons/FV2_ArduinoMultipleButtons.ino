//------------------------------------------------------------

int button1Pin = 8; // button on digital pin D8
int button2Pin = 9; // button on digital pin D9
int button3Pin = 10; // button on digital pin D10


int button1Val; // an empty variable to hold data from button1Pin
int button2Val; // an empty variable to hold data from button2Pin
int button3Val; // an empty variable to hold data from button3Pin

// three characters used for Serial communication
char START_BYTE = '*';
char DELIMITER = ',';
char END_BYTE = '#';

//------------------------------------------------------------

void setup() {
  // put your setup code here, to run once:
 
  Serial.begin(9600); // begin serial communication at 9600 baud rate

  digitalWrite(button1Pin, HIGH); // set button1Pin internal pullup resistor to HIGH
  digitalWrite(button2Pin, HIGH); // set button2Pin internal pullup resistor to HIGH
  digitalWrite(button3Pin, HIGH); // set button3Pin internal pullup resistor to HIGH
  
  establishContact(); // send a byte to establish contact until receiver responds
  
  // end of the setup function
}

//------------------------------------------------------------

void loop() {
  // put your main code here, to run repeatedly:

  
  button1Val = digitalRead(button1Pin); // assign button1Pin input to button1Val
  button2Val = digitalRead(button2Pin); // assign button2Pin input to button2Val
  button3Val = digitalRead(button3Pin); // assign button3Pin input to button3Val

  
  // start of input data being communicated...
  // START_BYTE, DELIMITER, and END_BYTE were defined above...
   
  Serial.write(START_BYTE); // print * 
  Serial.print(DELIMITER); // then ,

  Serial.print(button1Val); // then the value of button1Pin (0 or 1)
  Serial.print(DELIMITER); // then ,

  Serial.print(button2Val); // then the value of button2Pin (0 or 1)
  Serial.print(DELIMITER); // then ,

  Serial.print(button3Val); // then the value of button3Pin (0 or 1)
  Serial.print(DELIMITER); // then ,

  Serial.write(END_BYTE); // then #

  Serial.println();  // then send a carriage return (go to a new line)
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

