// import Camera
import processing.video.*;

// import kinect 
import org.openkinect.*;
import org.openkinect.processing.tests.*;
import org.openkinect.processing.*;

// import Midi Bus
import themidibus.*;

// import OSC library
import oscP5.*;
import netP5.*;

// initialize objetcs
Capture cam;
Kinect kinect;
MidiBus midiBus;
OscP5 osc;
NetAddress address;

//===============================================================
/*
check this code:
 horizontal Flip = (width-1-x) + y*video.width;
 vertical Flip = x + (height-1-y)*video.width;
 */
//===============================================================

// GLOBAL VARIABLES

float[] realDepthTable = new float [2048];
int kinectSize = 307200;  //640 x 480;
int camSize = 307200; //640 x 480
int[] lastFrame = new int [camSize];
int[] currFrame = new int [camSize];
float[] diffFrame = new float [kinectSize];
int maxIndex;
int maxX, maxY, maxZ, maxDepth;
float maxRealDepth;
int midiX, midiY, midiZ;
int posX, posY;
float posZ;
int[] pos = new int[3];
float normX, normY, normZ;
int x = 0;
int y = 1;
int z = 2;

float r = 20;
int minThreshold = 5;
int maxThreshold = 200;
int slowness = 10;
int depthLimit = 255;

boolean isKinect = false; // chooses betwen kinect and regular cam
boolean isCam = true;

//================================================================
//================================================================

void setup()
{
  size(640, 480);
  background (0);

  if (isKinect)
  { 
    kinect = new Kinect (this);
    kinect.start();

    for (int i = 0; i < realDepthTable.length; i++)
    {
      realDepthTable[i] = rawDepthToMeters(i);
    }
  } else if (isCam)
  {
    cam = new Capture (this, width, height);
    cam.start();
    loadPixels();
  }

  // osc config
  osc = new OscP5(this, 12346); // Processing Address
  address = new NetAddress ("127.0.0.1", 12345); // otherAPP address

  //midi config
  MidiBus.list();
  midiBus = new MidiBus(this, -1, 1); // init with no Input and 
  // Out to IAC

  //Variables
  maxX = width/2;
  maxY = height/2;
  midiX = 64;
  midiY = 64;
  midiZ = 64;
  posX  = width/2;
  posY  = height/2;
  posZ  = realDepthTable[1024];
  pos[x] = 0;
  pos[y] = 0;
  pos[z] = 0;
  normX = 0.5;
  normY = 0.5;
  normZ = 0.5;
}

//================================================================

void draw()
{
  if (isKinect)
  {
    kinect.enableDepth(true);
    PImage img = kinect.getDepthImage();
    loadPixels();
    currFrame = kinect.getRawDepth();
    float[] realDepth = new float [kinectSize];

    int moveSum = 0; 

    for (int i = 0; i < kinectSize; i++)
    {
      realDepth[i] = realDepthTable[currFrame[i]];
      int currDepth = currFrame[i];
      int lastDepth = lastFrame[i];

      diffFrame[i] = abs(currDepth - lastDepth);

      moveSum += diffFrame[i];

      pixels[(width-1-(i % width)) + (i / width)*width] = color(diffFrame[i]/10, diffFrame[i]/10, diffFrame[i]/10);

      lastFrame[i] = currFrame[i];
      currFrame[i] = int(diffFrame[i]*100);
    }
    if (moveSum > 0 && true);
    {
      updatePixels();
    } 
    maxIndex = maxValueIndexWithDiff(currFrame, diffFrame, kinectSize);
//    maxIndex = maxBrightnessIndex(pixels, kinectSize);
  } 

  //================================================================

  if (isCam && cam.available())
  {
    cam.read();
    cam.loadPixels();

    int moveSum = 0;

    for (int i = 0; i < camSize; i++)
    {
      currFrame[i] = cam.pixels[i];
    }

    for (int i = 0; i < camSize; i++)
    {
      color currColor = cam.pixels[i];
      color lastColor = lastFrame[i];

      int currR = (currColor >> 16) & 0xFF;
      int currG = (currColor >> 8 ) & 0xFF;
      int currB = (currColor) & 0xFF;

      int lastR = (lastColor >> 16) & 0xFF;
      int lastG = (lastColor >> 8) & 0xFF;
      int lastB = (lastColor & 0xFF);

      int diffR = abs(currR - lastR);
      int diffG = abs(currG - lastG);
      int diffB = abs(currB - lastB);

      moveSum += diffR + diffG + diffB;

      pixels[(width-1-(i % width)) + (i / width)*width] = 
        0xFF000000 | (diffR << 16) | (diffG << 8) | diffB;

      lastFrame[i] = currColor;
    }
    maxIndex = maxBrightnessIndex(pixels, camSize);

    if (moveSum > -1 && false)
    {
      updatePixels();
    }
  }

  //================================================================
  // process location having maxindex

  int maxX_ = 0;
  if (isCam)
  {
    maxX_ = getX(maxIndex, width);
  } else if (isKinect)
  {
    maxX_ = width - getX(maxIndex, width);
  }
  int maxY_ = getY(maxIndex, width); 

  maxX = smooth(maxX, maxX_, slowness, minThreshold, maxThreshold); 
  maxY = smooth(maxY, maxY_, slowness, minThreshold, maxThreshold);
  if (isCam)
  {
    maxZ = int(brightness(pixels[maxIndex]));
  }  else if (isKinect)
  {
    maxZ = currFrame[maxIndex];
  }  

//  pushMatrix(); 
//  scale(-1, 1); 
//  image(cam, 0, 0); 
//  popMatrix(); 

  fill (255, 0, 0); 
  ellipse (maxX, maxY, r, r ); 

  fill (255); 
  text("Pos: ("  + str(maxX) +
    ", " + str(maxY) +
    ", " + str(maxDepth) + ")", width/2, height - 15); 
  text("MIDI: (" + str(midiX) +
    ", " + str(midiY) +
    ", " + str(midiZ) + ")", width/2, height - 30); 
  text("OSC: (" + str(pos[x]) +
    ", " + str(pos[y]) +
    ", " + str(pos[z]) + ")", width/2, height - 45); 
  text("Norm: (" + str(normX) +
    ", " + str(normY) +
    ", " + str(normZ) + ")", width/2, height - 60);

  normX = map(maxX, 0, width, 0, 1);
  normY = map(maxY, 0, height, 1, 0);
  normZ = map(maxZ, 0, depthLimit, 0, 1);

  midiX = int(normX * 127);
  midiY = int(normY * 127);
  midiZ = int(normZ * 127);

  pos[x] = int(normX * 200 - 100);
  pos[y] = int(normY * 200 - 100);
  pos[z] = int(normZ * 200 - 100);

  midiBus.sendControllerChange(0, 50, midiX);
  midiBus.sendControllerChange(0, 51, midiY);
  midiBus.sendControllerChange(0, 52, midiZ);

  OscBundle BundleMsg = new OscBundle();
  OscMessage msg = new OscMessage("/position");
  msg.add(pos);
  BundleMsg.add(msg);

  osc.send(BundleMsg, address);
}

