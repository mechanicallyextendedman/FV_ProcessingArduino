// Use a potentiometer, a touch sensor, a button and an Arduino to control shapes in Processing

import processing.serial.*; // import the Serial library

Serial usbPort;
int [] sensor = null;
boolean firstContact = false;

// IMPORTANT--------------------------------------------------
// The variables below will be assigned values later:
int potA;
int touchA;
int buttonA;

// --------------------------------------------------------------

void setup() {
  // put your setup code here, to run once:

  size(512, 300);
  colorMode(HSB, 360, 100, 100, 100);
  usbPort =new Serial(this, Serial.list()[0], 9600);
  usbPort.bufferUntil('\n');
}
// --------------------------------------------------------------

void draw() {
  // put your main code here, to run repeatedly:
  //********************************************************
  background(25, 100, 100);
  
  if (touchA == 0) {
    strokeWeight(10);
  } else {
    strokeWeight(20);
  }
  
  if (buttonA == 0) {
    fill(90, 100, 100);
  } else {
    fill(280, 100, 100);
  }
  
  ellipse(potA/2, 150, 100, 100);

  
  //********************************************************
}
// --------------------------------------------------------------

void serialEvent(Serial usbPort) {
  String usbString = usbPort.readStringUntil('\n');
  if (usbString != null) {
    usbString = trim(usbString);
    println(usbString);
    if (firstContact == false) { 
      if (usbString.equals("hello")) { 
        usbPort.clear(); 
        firstContact = true;
        usbPort.write('A'); 
        println("contact");
      }
    } else {
      int sensor[] = int(split(usbString, ','));
      for (int sensorNum = 1; sensorNum < sensor.length; sensorNum++) {
      }

      // IMPORTANT--------------------------------------------------
      // The line below assigns the value of the Arduino sensors...
      // ...to the variables declared at the beginning:

      // assign the sensor values to the variables:
      potA = sensor[1];
      touchA = sensor[2];
      buttonA = sensor[3];

      // --------------------------------------------------------------
    }
  }
}