import processing.serial.*; 
import processing.pdf.*;
Serial myPort; // Crée un objet de communication série
int valTone=0;


// variable ou sera stockée la valeur de la tension


int x=100;
int y=400;

void setup()
{
  size (500,500);
  background(255);
  println(Serial.list());
  beginRecord(PDF, "DESSIN.pdf");
  // You may need to change the number in [ ] to match 
  // the correct port for your system
  myPort = new Serial(this, Serial.list()[0], 9600);
 
  valTone = 0;
   
  myPort.bufferUntil('\n');
}

void draw() {
 
 
  smooth();
  if (valTone==1023)
  {
    y++;
  }
  
  if (valTone >= 990 && valTone <= 1010)
  {
    y--;
  }
  
  if (valTone >= 505 && valTone <= 515)
  {
    x++;
  }
  
  if (valTone>= 5 && valTone <= 10)
  {
    x--;
  }
  
  
  point(x,y);
} 

void serialEvent(Serial myPort) {
  // read String from the serial port:
  String inString = myPort.readString();
  println(inString);
 
  float tone = float(inString);
  println(tone);
  valTone = int(tone);
  
}

void keyPressed() {
  if (key == 'q') {
    endRecord();
    exit();
  }
}

