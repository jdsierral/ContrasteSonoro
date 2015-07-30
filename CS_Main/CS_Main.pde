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

//UDP STUFF

boolean netEnabled = false;

int port0 = 12350;
int port1 = 12351;
int port2 = 12352;

//=========================================================================//


//KINECT STUFF//

boolean kinectEnabled = true; 

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

// LEAP STUFF

int fps;

boolean stabilization = true;
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
  size (640, 480);
  textPos = new PVector (20, height - 200);
  background(255);

  osc = new OscP5(this, 12350);    //this mac port;

  CS0 = new NetAddress("192.168.0.100", port0);    //Admin for TroubleShooting
  CS1 = new NetAddress("192.168.0.101", port1);
  CS2 = new NetAddress("192.168.0.102", port2);

  //===

  kinect = new Kinect (this);
  kinect.start();

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
  
  if (leap.isConnected())
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
  
  






  //Ref Text
  fill(100);
  text(leapText(info), textPos.x, textPos.y);
  text(kinectText(info), textPos.x + width/2, textPos.y);
}

//=========================================================================//

void keyPressed()
{
  if (key == '0')
  {
    info = ++info % 3;
  }
}

//=========================================================================//

void stop() {
  kinect.quit();
  super.stop();
}

//=========================================================================//

