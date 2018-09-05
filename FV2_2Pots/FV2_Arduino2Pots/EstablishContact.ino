void establishContact() {
  // while there is zero (or less) serial communication
  // keep sending "hello" until the computer responds to the Arduino
  while (Serial.available() <= 0) {
    Serial.println("hello");
    delay(300);
  }
}

