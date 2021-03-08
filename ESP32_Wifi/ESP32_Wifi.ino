#include <WebServer.h>
#include <WiFi.h>
#include <WiFiUdp.h>

//set up to connect to an existing network (e.g. mobile hotspot from laptop that will run the python code)
const char* ssid = "****"; // change this to match your wifi credentials 
const char* password = "****"; // change this to match your wifi credentials 
WiFiUDP Udp;
unsigned int localUdpPort = 4210;  //  port to listen on
char incomingPacket[255];  // buffer for incoming packets

void setup()
{
  int status = WL_IDLE_STATUS;
  Serial.begin(115200);
  WiFi.begin(ssid, password);
  Serial.println("");

  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("Connected to wifi");
  Udp.begin(localUdpPort);
  Serial.printf("Now listening at IP %s, UDP port %d\n", WiFi.localIP().toString().c_str(), localUdpPort);

  // we recv one packet from the remote so we can know its IP and port
  bool readPacket = false;
  while (!readPacket) {
    int packetSize = Udp.parsePacket();
    if (packetSize)
     {
      // receive incoming UDP packets
      Serial.printf("Received %d bytes from %s, port %d\n", packetSize, Udp.remoteIP().toString().c_str(), Udp.remotePort());
      int len = Udp.read(incomingPacket, 255);
      if (len > 0)
      {
        incomingPacket[len] = 0;
      }
      Serial.printf("UDP packet contents: %s\n", incomingPacket);
      readPacket = true;
    } 
  }
}

void loop()
{
  // once we know where we got the inital packet from, send data back to that IP address and port
  Udp.beginPacket(Udp.remoteIP(), Udp.remotePort());
  // Just test touch pin - Touch0 is T0 which is on GPIO 4.
  String send = "";
  if(touchRead(T0) < 20) {
    send += "0";
  }
  if(touchRead(T8) < 30) {
    send += "1";
  }
  if(touchRead(T9) < 20) {
    send += "2";
  }
  if(touchRead(T3) < 20) {
    send += "3";
  }
  if(touchRead(T4) < 30) {
    send += "4";
  }
  if(touchRead(T5) < 20) {
    send += "5";
  }
  if(touchRead(T6) < 30) {
    send += "6";
  }
  Udp.printf(String(send).c_str(),2);
  Udp.endPacket();
  delay(500);
}

/*
// a python program to send an initial packet, then listen for packets from the ESP32
import socket
UDP_IP = "192.168.137.96" # The IP that is printed in the serial monitor from the ESP32
SHARED_UDP_PORT = 4210
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)  # Internet  # UDP
sock.connect((UDP_IP, SHARED_UDP_PORT))
def loop():
    while True:
        data = sock.recv(2048)
        print(data)
if __name__ == "__main__":
    sock.send('Hello ESP32'.encode())
    loop()
*/
