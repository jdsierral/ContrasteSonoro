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

boolean netEnabled = true;

int[] port = {12000, 12001, 12002};
String[] IP = {"192.168.0.100", "192.168.0.101", "192.168.0.102"};

String myIP = NetInfo.lan();
int myPort;

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
  size (640, 480);
  textPos = new PVector (20, height - 200);
  background(255);
  
  for (int i = 0; i < 2; i++)
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

  fill(255, 0, 0);
  ellipse(leapPosL1.x, leapPosL1.y, leapPosL1.z, leapPosL1.z);
  fill(0, 255, 0);
  ellipse(leapPosR1.x, leapPosR1.y, leapPosR1.z, leapPosR1.z);
  fill(0, 0, 255);
  ellipse(kinectPos1.x, kinectPos1.y, kinectPos1.z, kinectPos1.z);

  fill(255, 255, 0);
  ellipse(leapPosL2.x, leapPosL2.y, leapPosL2.z, leapPosL2.z);
  fill(0, 255, 255);
  ellipse(leapPosR2.x, leapPosR2.y, leapPosR2.z, leapPosR2.z);
  fill(255, 0, 255);
  ellipse(kinectPos2.x, kinectPos2.y, kinectPos2.z, kinectPos2.z);

  //Ref Text
  fill(100);
  text(leapText(info), textPos.x, textPos.y);
  text(kinectText(info), textPos.x + width/2, textPos.y);
  text(myIP, 50, 50);
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



//=========================================================================//

void stop() {
  kinect.quit();
  super.stop();
}

//=========================================================================//

