// OSC libraries
import oscP5.*;
import netP5.*;

// MIDI library
import themidibus.*;

// declarations
MidiBus myBus;
OscP5 oscP5;
NetAddress otherApp;

// word declarations
float x, y, z;               // norm values
int xPos, yPos, zPos;        // Screen Values
int midiX, midiY, midiZ;     // midi Values
int [] pos = new int[3];     // osc Values
int zLowLimit, zHighLimit;


//==================================================================

void setup()
{
  size (640, 480);
  background (0);

  MidiBus.list();
  oscP5 = new OscP5(this, 12346);  //Processing Address

  otherApp = new NetAddress("127.0.0.1", 12345); //other App Address... PD, Logic, ableton...

  x = 0.5;
  y = 0.5;
  z = 0.5;
  
  pos[0] = 50;
  pos[1] = 50;
  pos[2] = 50;

  xPos = width/2;
  yPos = height/2;
  zPos = 0; 

  midiX = 64;
  midiY = 64;
  midiZ = 64;

  zLowLimit =  0;
  zHighLimit = height;

  myBus = new MidiBus(this, -1, 1);
}


//==================================================================

void draw()
{
  background(0);

  xPos = mouseX;
  yPos = mouseY;

  // Draw Ball
  fill (255, 0, 0);
  ellipse (xPos, yPos, zPos, zPos);

  //Draw Text
  fill (255);
  text("Pos: (" + str(xPos) + ", " + str(yPos) + ", " + str(zPos) + ")", width - 200, height - 20);
  text("Midi: (" + str(midiX) + ", " + str(midiY) + ", " + str(midiZ) + ")", width - 200, height - 10);

  // Norm Section
  x = map(xPos, 0, width, 0, 1);
  y = map(yPos, 0, height, 1, 0);
  z = map(zPos, 0, height/2, 0, 1);

  // Midi Section
  midiX = int(x * 127);
  midiY = int(y * 127);
  midiZ = int(z * 127);

  myBus.sendControllerChange(0, 50, midiX);
//  delay(10); // caution delays to avoid overload
  myBus.sendControllerChange(0, 51, midiY);
//  delay(10);
  myBus.sendControllerChange(0, 52, midiZ);
//  delay(10);

  //OSC Section
  
  pos[0] = int(x * 100);
  pos[1] = int(y * 100);
  pos[2] = int(z * 100);
  
  OscBundle BundleMsg = new OscBundle();
  OscMessage msg = new OscMessage("/position");
  msg.add(pos);
  BundleMsg.add(msg);

  oscP5.send(BundleMsg, otherApp);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

void mouseWheel(MouseEvent event) 
{
  if (zPos >= 0 && zPos <= height/2) 
  {
    float e = 1; 
    e = event.getCount();
    zPos = zPos + int(e);
  } else if (zPos < 0) 
  {
    zPos = 0;
  } else if (zPos > height/2)
  {
    zPos = height/2;
  }
}

//==================================================================
//==================================================================
//==================================================================
//==================================================================
/*

OSC messages consist of an Address pattern, a Type tag string, 
Arguments and an optional time tag. Address patterns form a 
hierarchical name space, reminiscent of a Unix filesystem path, 
or a URL. Type tag strings are a compact string representation 
of the argument types. Arguments are represented in binary form 
with 4-byte alignment. 

*/
