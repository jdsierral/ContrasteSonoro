//=========================================================================//
/*
/*                                Kinect-Leap-UDP
/*                               Contraste Sonoro
/*                                Roberto Cuervo
/* 
/*                                Coded By: JuanS
 */
//=========================================================================//
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
NetAddress CS1;  //Contraste Sonoro 1
NetAddress CS2;  //Contraste Sonoro 2

LeapMotion leap;

Kinect kinect;

//=========================================================================//
//Global Variables

float[] depthLoockUp = new float[2048];
int kinectSize = 307200;  //640 x 480
int maxIndex;
float r = 20;
int minThreshold = 5;
int maxThreshold = 200;
int speed = 5;
PVector max = new PVector ();

PVector kinectPos = new PVector ();

int fps;

boolean isLeft, isRight;
float appertureL;
PVector leapPosL = new PVector ();
PVector leapDynL = new PVector ();
float appertureR;
PVector leapPosR = new PVector ();
PVector leapDynR = new PVector ();
//=========================================================================//

PVector kinectPos2 = new PVector ();
boolean isLeft2;
boolean isRight2;
float appertureL2;
PVector leapPosL2 = new PVector ();
PVector leapDynL2 = new PVector ();
float appertureR2;
PVector leapPosR2 = new PVector ();
PVector leapDynR2 = new PVector ();

//=========================================================================//

void setup() {
  size (640, 480);
  background(255);

  oscP5 = new OscP5(this, 12345);    //this mac port;

  CS0 = new NetAddress("192.168.0.100", 12350);    //Admin for TroubleShooting

  CS1 = new NetAddress("192.168.0.101", 12351);
  CS2 = new NetAddress("192.168.0.102", 12352);
  
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
}

//=========================================================================//
//=========================================================================//
//=========================================================================//

