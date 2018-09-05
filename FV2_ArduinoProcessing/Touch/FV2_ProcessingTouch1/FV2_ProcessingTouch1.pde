// Use a touch sensor and an Arduino to control shapes in Processing
// The data from the sensor is assigned to touchA
// touchA can then be used to control anything between the asterisk lines in void draw

// import the Serial library
import processing.serial.*;

// create an object from Serial class and name it:
Serial usbPort;
// an array to hold incoming sensor data
int [] sensor = null;
// check if Arduino is communicating
boolean firstContact = false;

// IMPORTANT--------------------------------------------------
// The variable below will be assigned a value later:

int touchA;

// --------------------------------------------------------------
// --------------------------------------------------------------

void setup() {
  // put your setup code here, to run once:

  // set the canvas (width, height) 
  size(512, 300);

  // change the color mode from RGB to HSB
  // The 4th number is for opacity.
  colorMode(HSB, 360, 100, 100, 100);

  // initialize your serial port and set baud rate to 9600
  usbPort =new Serial(this, Serial.list()[0], 9600);

  // store incoming data until carriage return
  usbPort.bufferUntil('\n');
}
// --------------------------------------------------------------
// --------------------------------------------------------------

void draw() {
  // put your main code here, to run repeatedly:
  //********************************************************
  // set the background color H(360),S(100),B(100)
  background(25, 100, 100);

  // if touchA is off...
  if (touchA == 0) {
    // draw this:
    ellipse(width/2, 150, 100, 200);
  } else { // otherwise...
    // draw this:
    ellipse(width/2, 150, 200, 100);
  }

  
  //********************************************************
}


// the serialEvent function:
// check for Serial communication from usbPort...
void serialEvent(Serial usbPort) {
  // if a carriage return \n is found...
  String usbString = usbPort.readStringUntil('\n');
  // and if the data string is not empty...
  if (usbString != null) {
    usbString = trim(usbString);
    // print the string to the console...
    println(usbString);

    // and if firstContact is false...
    if (firstContact == false) { 
      // ...and if "hello" is sent by the Arduino...
      if (usbString.equals("hello")) { 
        // ...clear the USB port...
        usbPort.clear(); 
        // ...and set firstContact to true...
        firstContact = true;
        // ...then send char 'A' back to the Arduino...
        usbPort.write('A'); 
        // ...and print "contact" on a new line in the console below.
        println("contact");
      }
    } else { // Otherwise...
      // ...create an array named sensors that splits data coming from Arduino wherever there's a ',' (DELIMITER)
      int sensor[] = int(split(usbString, ','));
      // A for loop that checks how many sensors are sending data and puts them in the array.
      for (int sensorNum = 1; sensorNum < sensor.length; sensorNum++) {
      }

      // IMPORTANT--------------------------------------------------
      // The line below assigns the value of the first Arduino sensor...
      // ...to the "int touchA" variable you declared at the beginning:

      // assign the value of sensor[1] to touchA
      touchA = sensor[1];

      // --------------------------------------------------------------
    }
  }
}