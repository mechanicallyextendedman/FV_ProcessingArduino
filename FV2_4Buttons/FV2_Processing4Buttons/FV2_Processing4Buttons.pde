// Use multiple buttons and an Arduino to control Processing
// Incoming data from the Arduino is assigned to button1, button2, button3...
// button1, button2, button3... can then be used to control anything between the asterisk lines in void draw

// import the Serial library
import processing.serial.*;

// create an object from Serial class and name it:
Serial usbPort;
// an array to hold incoming sensor data
int [] sensor = null;
// check if Arduino is communicating
boolean firstContact = false;

int horizontal;
int vertical;
int speed = 1;

// IMPORTANT--------------------------------------------------
// The variable below will be assigned a value later:
int button1;
int button2;
int button3;
int button4;

// --------------------------------------------------------------
// --------------------------------------------------------------

void setup() {
  // put your setup code here, to run once:

  // set the canvas (width, height) 
  size(800, 600);

  // change the color mode from RGB to HSB
  // The 4th number is for opacity.
  colorMode(HSB, 360, 100, 100, 100);

  horizontal = width/2;
  vertical = height/2;

  // initialize your serial port and set baud rate to 9600
  usbPort =new Serial(this, Serial.list()[1], 9600);

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

  noStroke();
  rectMode(CENTER); 
  rect(horizontal, vertical, 10, 10); 
  move();
  trap();


  //********************************************************
}

void move() {
  if (button1 == 0) {
    vertical = vertical - speed;
  } else {
    vertical = vertical;
  }
  if (button2 == 0) {
    vertical = vertical + speed;
  } else {
    vertical = vertical;
  }
  if (button3 == 0) {
    horizontal = horizontal - speed;
  } else {
    horizontal = horizontal;
  }
  if (button4 == 0) {
    horizontal = horizontal + speed;
  } else {
    horizontal = horizontal;
  }
}

void trap() {
    if (horizontal < 0) {
      horizontal = 0;
    }else if (horizontal > width) {
      horizontal = width;
    }
    if (vertical < 0) {
      vertical = 0;
    }else if (vertical > height) {
      vertical = height;
    }
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
      // The line below assigns the buttonVals of the Arduino buttonPins...
      // ...to the "int button1,2, and 3" variables you declared at the beginning:

      // assign the value of a sensor[1,2, or 3] to a button
      button1 = sensor[1];
      button2 = sensor[2];
      button3 = sensor[3];
      button4 = sensor[4];

      // --------------------------------------------------------------
    }
  }
}
