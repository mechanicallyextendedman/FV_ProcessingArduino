import processing.serial.*;

Serial usbPort;
int [] sensors = null;
boolean firstContact = false;

int sensor1;
int button1;
int touch1;
long foil1;
long foil2;

void setup(){
  size(800, 600);
  colorMode(HSB, 360, 100, 100, 100);

 usbPort =new Serial(this, Serial.list()[0], 9600);
 
 usbPort.bufferUntil('\n');
}



void draw(){
  background(25, 100, 100, 100);

  //filter(BLUR, 5);
  if(button1 == 1){
  fill(0, 100, 100, 100);
  }else{
    fill(50, 100, 100, 100);
  }
  if(touch1 == 0){
    strokeWeight(5);
  }else{
    strokeWeight(2);
  }
 ellipse(width/2, height/2, foil1, foil2);
 int repeat = int(map(sensor1, 0, 1023, 0, 5));
 rectBranch(width/2, height/2, 200, 200, repeat);
}


void rectBranch(int posX, int posY, int dimW, int dimH, int level){
  
  rectMode(CENTER);
  noFill();
  rect(posX, posY, dimW, dimH);
  
  if (level > 0){
  rectBranch(posX - dimW / 2, posY, dimW / 2, dimH / 2, level - 1);
  rectBranch(posX + dimW / 2, posY, dimW / 2, dimH / 2, level - 1);
  }
  
}

void serialEvent(Serial usbPort){
 String usbString = usbPort.readStringUntil('\n');
 if(usbString != null){
  usbString = trim(usbString);
  println(usbString);
  
  if(firstContact == false){
   if(usbString.equals("hello")){
    usbPort.clear();
    firstContact = true;
    usbPort.write('A');
    println("contact");
   }
  }else{
   int sensors[] = int(split(usbString, ','));
   for(int sensorNum = 1; sensorNum < sensors.length; sensorNum++){
     //println(sensorNum + " " + sensors[sensorNum]);
   }
   
   sensor1 = sensors[1];
   button1 = sensors[2];
   touch1 = sensors[3];
   foil1 = sensors[4];
   foil2 = sensors[5];
  }  
 }
}