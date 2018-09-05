// Use two potentiometers and an Arduino to control Processing
// The data from the potentiometers is assigned to knob1 and knob2

import processing.serial.*; // import the Serial library
Serial usbPort; // create an object from Serial class and name it:

int [] sensor = null; // an array to hold incoming sensor data
boolean firstContact = false; // check if Arduino is communicating

// IMPORTANT--------------------------------------------------

int knob1; // assigned a value in the SerialEvent tab
int knob2; // assigned a value in the SerialEvent tab
float x;
float y;
float speed;
int penSize = 5;
int waitTime = 5000; // a standby time in milliseconds to prevent immediate drawing (See FV2_Standby tab)

// --------------------------------------------------------------
// --------------------------------------------------------------

void setup() {
  // put your setup code here, to run once:

  size(512, 300);
  colorMode(HSB, 360, 100, 100, 100);   // change the color mode from RGB to HSB
  background(25, 100, 100);  // set the background color H(360),S(100),B(100)

  usbPort =new Serial(this, Serial.list()[0], 9600); // use the FV2_SerialPortFinder sketch to get the port number
  usbPort.bufferUntil('\n'); // store incoming data until carriage return

  x = width/2;
  y = height/2;
  speed = 1;
}
// --------------------------------------------------------------
// --------------------------------------------------------------

void draw() {
  // put your main code here, to run repeatedly:
  //********************************************************
  standby();
  float horz = map(knob1, 0, 1023, speed, -speed);
  float vert = map(knob2, 0, 1023, -speed, speed);
  x = x + horz;
  y = y + vert;
  noStroke();
  ellipse(x, y, penSize, penSize);
  trap(); // call the trap() function (See the FV2_Trap tab)
  //********************************************************
}
