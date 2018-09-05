
void standby() {
  int pause = waitTime;
  int timePassed = millis();
  if (timePassed < pause) {
    x = width/2;
    y = height/2;
  }
}
