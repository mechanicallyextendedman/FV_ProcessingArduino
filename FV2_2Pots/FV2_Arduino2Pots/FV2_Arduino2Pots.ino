//------------------------------------------------------------

int pot1Pin = A1; // pot on analog pin A1
int pot2Pin = A2; // pot on analog pin A2

// three characters used for Serial communication
char START_BYTE = '*';
char DELIMITER = ',';
char END_BYTE = '#';

//------------------------------------------------------------

void setup() {
  // put your setup code here, to run once:

  Serial.begin(9600); // begin serial communication at 9600 baud rate
  establishContact(); // send a byte to establish contact until receiver responds

  // end of the setup function
}

//------------------------------------------------------------

void loop() {
  // put your main code here, to run repeatedly:

  // assign potentiometer input to a variable
  int pot1Val = analogRead(pot1Pin); // a variable to hold data from pot1Pin
  int pot2Val = analogRead(pot2Pin); // a variable to hold data from pot2Pin

  // start of input data being communicated...
  // START_BYTE, DELIMITER, and END_BYTE were defined above...

  Serial.write(START_BYTE); // print *
  Serial.print(DELIMITER); // then ,

  Serial.print(pot1Val); // then the value of pot1Pin (ranges from 0 to 1023)
  Serial.print(DELIMITER); // then ,

  Serial.print(pot2Val); // then the value of pot2Pin (ranges from 0 to 1023)
  Serial.print(DELIMITER); // then ,

  Serial.write(END_BYTE); // then #

  Serial.println();  // then send a carriage return (go to a new line)
}

//------------------------------------------------------------



