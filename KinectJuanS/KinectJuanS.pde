import oscP5.*;
import netP5.*;
import themidibus.*;
import org.openkinect.*;
import org.openkinect.processing.*;

// kinect library object
Kinect kinect;
MidiBus myBus;
OscP5 oscP5;
NetAddress otherApp;

//=====================================================================================
/**
 
 TODO LIST
 
 - Time averaging for maxValues to avoid jittery max points CHECK
 - Multiple Max points on masks?
 - Eliminate background
 - UDP connections via OSC to PD
 - MIDI connections to IAC
 
 
 **/
//=====================================================================================

//    Global Variables

float[] depthLookUp = new float[2048];

int cercano = 0;
int kinectSize = 307200; //640 x 480
int meanSize = 2;
int[] meanDepth = new int [kinectSize];
int[] diffDepth = new int [kinectSize];
int[] lastDepth = new int [kinectSize];

int maxIndex; 
int maxX, maxY;
float r = 10;
int minThreshold = 5;
int maxThreshold = 200;
int speed = 5;
int midiX, midiY, midiZ;
int xPos, yPos, zPos;
int [] pos = new int [3];
float x, y, z;

//=====================================================================================


void setup()
{
  size(640, 480);
  background (0);
  frameRate(30);

  oscP5 = new OscP5(this, 12346);  //Processing Address
  otherApp = new NetAddress("127.0.0.1", 12345); 
  //other App Address... PD, Logic, ableton...

  kinect = new Kinect (this);
  kinect.start();

  MidiBus.list();
  myBus = new MidiBus(this, -1, 1);

  for (int i = 0; i < depthLookUp.length; i++) 
  {
    depthLookUp[i] = rawDepthToMeters(i);
  }

  //Initialize Variables
  maxX = width/2;
  maxY = height/2;
  midiX = 64;
  midiY = 64; 
  midiZ = 64;
  xPos = width/2; 
  yPos = height/2; 
  zPos = width/2;
  pos[0] = 0; 
  pos[1] = 0;
  pos[2] = 0;
  x = 0.5; 
  y = 0.5;
  z = 0.5;
}


//=====================================================================================


void draw()
{
  kinect.enableDepth(true);
  PImage img = kinect.getDepthImage();
  int[] depth = kinect.getRawDepth();
  
  lowRes (depth, width, height, meanSize);
  
    for (int i = 0; i < kinectSize; i++)
  {
    meanDepth[i] = (meanDepth[i] * 19 + depth[i])/20;
    
    diffDepth[i] = (diffDepth[i] + (abs(meanDepth[i] - lastDepth[i]) * 20))/2;
    
    lastDepth[i] = meanDepth[i];
  }
  
  loadPixels();
  //  meanSpaceVal(depth, meanDepth, width, height, meanSize);
  //  
  //  for (int i = 0; i < kinectSize; i++)
  //  {
  //      pixels[i] = meanDepth[i];
  //  }
  for (int i = 0; i < kinectSize; i++)
  {    
    pixels[(width-1-(i % width)) + (i / width)*width] = 
    color(map(diffDepth[i], 0, 500, 0, 255), 
          map(diffDepth[i], 0, 500, 0, 255), 
          map(diffDepth[i], 0, 500, 0, 255)); 
  }
  updatePixels();

  //transformation from depth data to real meters
  //  for (int i = 0; i < kinectSize; i++)
  //  {
  //    depth [i] = depthLookUp[depth[i]];
  //  }

  //function for calling for maxIndex & finding maxX and maxY;
  maxIndex = maxValueIndex(diffDepth, kinectSize); 

  int maxX_ = img.width - getX(maxIndex, img.width); 
  int maxY_ = getY(maxIndex, img.width); 

  //functions to void jittery signal
  maxX = smooth(maxX, maxX_, speed, minThreshold, maxThreshold);
  maxY = smooth(maxY, maxY_, speed, minThreshold, maxThreshold);

  // Draw DepthImage (invert positions to get inverted scene???
  //  pushMatrix();
  //  scale(-1, 1);
  //  image (img, -img.width, 0);
  //  popMatrix();

  // Draw Ball (tracker)
  fill (255, 0, 0);
  ellipse (maxX, maxY, r, r); 

  // Draw Text
  fill (0);
  text("Max Pos: (" + str(maxX) + ", " + str(maxY) + ")", 500, 440);
  text("Mouse Pos: (" + str(mouseX) + ", " + str(mouseY) + ")", 490, 455);
  //  text("MIDI Info: (" + str(note) + ", " + str(velocity) + ")", 490, 470);

  //get Norm Values

  x = map(maxX, 0, width, 0, 1);
  y = map(maxY, 0, height, 1, 0);
  z = map(depth[maxIndex], 200, 500, 0, 1);  

  // MIDI Ctrl Change

  midiX = int(x * 127);
  midiY = int(y * 127);
  midiZ = int(z * 127);

  // OSC array;
  pos[0] = int(x * 200 - 100);
  pos[1] = int(y * 200 - 100);
  pos[2] = int(z * 200 - 100);

  // send midi data
  myBus.sendControllerChange(0, 50, midiX); // Send a controllerChange
  //  delay(10);
  myBus.sendControllerChange(0, 51, midiY);
  //  delay(10);
  myBus.sendControllerChange(0, 52, midiZ);
  //  delay(10);

  //send OSC data

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

