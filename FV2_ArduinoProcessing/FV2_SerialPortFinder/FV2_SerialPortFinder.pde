  // Find your Serial Port

// import the Serial library:
import processing.serial.*;

// create an object from Serial class and name it:
Serial myPort;

void setup(){
  // print a list of the serial ports:
  printArray(Serial.list());
}