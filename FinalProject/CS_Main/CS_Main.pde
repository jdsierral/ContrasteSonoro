//=========================================================================//
/*
/*                                Kinect-Leap-UDP
/*                               Contraste Sonoro
/*                                Roberto Cuervo
/* 
/*                                Coded By: JuanS
 */
//=========================================================================//
/*
/*
/*          TODO LIST
/*  - insert Constrains in leap variables
/*  - insert mappings in leap variables
/*  - design osc messages
/*
/*
/*
/*
/*
 */
//=========================================================================//

import oscP5.*;
import netP5.*;

import org.openkinect.*;
import org.openkinect.processing.tests.*;
import org.openkinect.processing.*;

import de.voidplus.leapmotion.*;
import development.*;

//=========================================================================//

OscP5 osc;
NetAddress CS0;  //Contraste Sonoro Admin
NetAddress CS1;  //Contraste Sonoro 1
NetAddress CS2;  //Contraste Sonoro 2

LeapMotion leap;

Kinect kinect;

//=========================================================================//
//Global Variables

boolean netEnabled = false;
boolean leapEnabled = true;
boolean kinectEnabled = true;
boolean dummyDrawEnabled = true;
boolean refTextEnabled = true;
//UDP STUFF



int[] port = {
  12000, 12001, 12002
};
String[] IP = {
  "192.168.0.100", "192.168.0.101", "192.168.0.102"
};

String myIP = NetInfo.lan();
int myPort;

//=========================================================================//


//KINECT STUFF//



float[] depthLookUp = new float[2048];
int kinectSize = 307200;  //640 x 480
int maxIndex;
float r = 20;
int minThreshold = 5;
int maxThreshold = 200;
int speed = 5;
PVector max = new PVector ();
boolean meanFlag = false;
boolean stndFlag = false; 

PVector kinectPos1 = new PVector ();

int deg = 15; 

// LEAP STUFF

int fps;

boolean stabilization = false;
boolean isLeft1, isRight1;
float leapGrabL1;
PVector leapPosL1 = new PVector ();
PVector leapDynL1 = new PVector ();
float leapGrabR1;
PVector leapPosR1 = new PVector ();
PVector leapDynR1 = new PVector ();
//=========================================================================//

PVector kinectPos2 = new PVector ();

boolean isLeft2, isRight2;
float leapGrabL2;
PVector leapPosL2 = new PVector ();
PVector leapDynL2 = new PVector ();
float leapGrabR2;
PVector leapPosR2 = new PVector ();
PVector leapDynR2 = new PVector ();

//=========================================================================//

PVector textPos;
int info = 0;
//=========================================================================//

void setup() {
  size (640, 480, P3D);
  textPos = new PVector (20, height - 200);
  background(255);

  for (int i = 0; i <= 2; i++)
  {
    if (myIP.equals(IP[i]))
    {
      myPort = port[i];
    }
  }

  osc = new OscP5(this, myPort);    //this mac port;

  CS0 = new NetAddress(IP[0], port[0]);    //Admin for TroubleShooting
  CS1 = new NetAddress(IP[1], port[1]);
  CS2 = new NetAddress(IP[2], port[2]);

  //===

  kinect = new Kinect (this);
  kinect.start();
  kinect.tilt(deg);

  //===

  leap = new LeapMotion(this);

  //===

  for (int i = 0; i < depthLookUp.length; i++) 
  {
    depthLookUp[i] = rawDepthToMeters(i);
  }
}


//=========================================================================//

void draw() {
  background(255);
  fps = leap.getFrameRate();

  if (leapEnabled)
  {
    leapAnalisis();
  }

  if (kinectEnabled)
  {
    kinectAnalisis();
  }

  if (netEnabled)
  {
    oscRoutine();
  }

  if (dummyDrawEnabled)
  {
    dummyDraw();
  }

  if (refTextEnabled)
  {
    fill(100);
    //    text(leapText(info), textPos.x, textPos.y);
    text(kinectText(info), textPos.x + width/2, textPos.y);
    text(myIP + ", " + myPort, 50, 50);
  }
}

//=========================================================================//

void keyPressed()
{
  switch (key)
  {
  case '0' : 
    info = ++info % 2; 
    break;
  case '1' : 
    netEnabled = !netEnabled;
    break;
  case '2' :
    leapEnabled = !leapEnabled; 
    break;
  case '3' :
    kinectEnabled = !kinectEnabled; 
    break;
  case '4' :
    dummyDrawEnabled = !dummyDrawEnabled; 
    break;
  case '5' :
    refTextEnabled = !refTextEnabled; 
    break;
  case CODED  :

    if (keyCode == UP)
    {
      deg++;
    } else if (keyCode == DOWN)
    {
      deg--;
    }
    kinect.tilt(deg);
    break;
  }
}
//=========================================================================//
/*
else if (key == CODED) {
 if (keyCode == UP) {
 deg++;
 } 
 else if (keyCode == DOWN) {
 deg--;
 }
 deg = constrain(deg,0,30);
 kinect.tilt(deg);
 */


//=========================================================================//

void stop() {
  kinect.quit();
  super.stop();
}

//=========================================================================//

