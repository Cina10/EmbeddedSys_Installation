import hypermedia.net.*;
import processing.sound.*;

// For connecting to the socket
int PORT = 4210;
String IP = "192.168.1.224";
UDP udp;

// sensors
boolean pressed[] = new boolean[7];
String sensorValue = "";

// For generating the randomized circles
int globalX = 0;
int globalY = 0;
ArrayList<ExpandingCircle> circles = new ArrayList<ExpandingCircle>();

// For generating the sound
Sound s;



// Class that creates expanding circles
class ExpandingCircle {
  int x,y;
  float radius;
  color c;
  int transparency;
 
  ExpandingCircle(int x, int y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
    transparency = 255;
  }
  
  void update() {
    radius++;
    transparency--;
  }
 
  void display() {
    //println(transparency);
    noStroke();
    fill(c,transparency);
    ellipse(x,y,radius,radius);
  }
}

void setup() {
  //udp = new UDP(this, PORT, IP);
  udp = new UDP(this, PORT);
  udp.send("Hello ESP32", IP);

  udp.listen(true);
  print("Listening");

  //fullScreen();
  size(500,500);
  background(0);
  globalX = (int)abs(randomGaussian() * (width/2));
  globalY = (int)abs(randomGaussian() * (height/2));
}

void draw() {
  background(0); // reset background
  for(int i = 0; i < pressed.length; i++)
  {
    checkSensor(i);
  }
   
  // Draws the colored circles
    println(circles.size());
  for (int i=0; i<circles.size(); i++) {
    ExpandingCircle ec = circles.get(i);
    ec.update();
    ec.display();
    if (ec.transparency <= 0) { circles.remove(i); } // remove invisible circles
  }
  
  //randomEcho();
}









void receive(byte[] data) {
   sensorValue = new String(data); 
}

// adds a circle and randomly increments the center of the circle
void addCircle(int num) {
  
  // make the num change the color 
  color c = color(random(255),random(255),random(255));
  circles.add(new ExpandingCircle(globalX, globalY, c));
  
  
  if ((int)random(0, 2) == 0) {
    int change = (int)random(10, 40);
    while(globalX + change > width) {
      change = (int)random(10, 40);
    }
     globalX = globalX + change;
  } else {
    int change = (int)random(10, 40);
    while(globalX - change < 0) {
      change = (int)random(10, 40);
    }
     globalX = globalX - change;
  }
  
  if ((int)random(0, 2) == 0) {
    int change = (int)random(10, 40);
    while(globalY + change > height) {
      change = (int)random(10, 40);
    }
     globalY = globalY + change;
  } else {
    int change = (int)random(10, 40);
    while(globalY - change < 0) {
      change = (int)random(10, 40);
    }
     globalY = globalY - change;
  }
}

// check if given sensor has been touched
void checkSensor(int num) {
  String n = num + "";
  if (sensorValue.contains(n)) {
    if(pressed[num] == false) {
      addCircle(num);
      pressed[num] = true;
    }
  } else{
     pressed[num] = false ; 
  }
}

// randomly decided whether to echo another cicle
void randomEcho() {
  if (circles.size() > 0 && (int)random(0, 150) == 0) {
    int i = (int) random(0, circles.size());
    ExpandingCircle circ = circles.get(i);
    ExpandingCircle echo = new ExpandingCircle(circ.x,  circ.y, circ.c);
    circles.add(echo);
  }
}
