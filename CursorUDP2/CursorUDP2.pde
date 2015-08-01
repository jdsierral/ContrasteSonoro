import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress mac1;
NetAddress mac2;

//======

float[]  pos = new float[9];
int x = 0;
int y = 1;
int z = 2;
int red = 0;
int blu = 3;
int thisColor = red; // or blu

//======

void setup()
{
  size(640, 480);
  
  osc = new OscP5(this, 12345);
  mac1 = netAddress ("192.168.0.11", 12345);
  mac2 = netAddress ("192.168.0.12", 12346);
  
  pos[x + red] = width/4;
  pos[y + red] = height/4;
  pos[z + red] = 20;
  
  pos[x + blu] = 3 * width/4;
  pos[y + blu] = 3 * height/4;
  pos[z + blu] = 20;
}

void draw()
{
  background (0);
  
  pos[x + thisColor] = mouseX;
  pos[y + thisColor] = mouseY;
  
  fill (0, 0, 255);
  ellipse(pos[x + red], pos[y + red], 
  
  
}  
