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
      // The lines below assign the values of the Arduino potentiometers to the knob variables...


      knob1 = sensor[1]; // assign the value of sensor[1] to knob1
      knob2 = sensor[2]; // assign the value of sensor[2] to knob2
      // --------------------------------------------------------------
    }
  }
}
