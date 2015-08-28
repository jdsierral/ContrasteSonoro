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
/*  - 
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
import org.openkinect.processing.*;
import org.openkinect.processing.tests.*;

import de.voidplus.leapmotion.*;
import development.*;

//=========================================================================//

OscP5 osc;
NetAddress CS1Pro;
NetAddress CS2Pro;
NetAddress CS1Max;
NetAddress CS2Max;
LeapMotion leap;
Kinect kinect;

//=========================================================================//
////////////////////////////////GLOBAL VARIABLES/////////////////////////////
//=========================================================================//

int[] setup = {
  1, 0, 1, 1, 1
};

boolean netEnabled;
boolean leapEnabled;
boolean kinectEnabled;
boolean dummyDrawEnabled;
boolean refTextEnabled;
//UDP STUFF

int[] port = {12001, 12002, 12011, 12012};
String[] IP = {"192.168.0.101", "192.168.0.102"};

String myIP = NetInfo.lan();
int myPort;


//=========================================================================//
//////////////////////////////////KINECT STUFF///////////////////////////////
//=========================================================================//

int meanSize = 100;
int meanLength = 50;
int meanFactor = 5; // change later to 3 at least

int deg = 0;
float accuracy = 15;

int kinectSize = 307200;
int kinectWidth = 640;
int kinectHeight = 480;

int[] depth = new int[kinectSize];
int[] meanDepth = new int[kinectSize];
float[] stndDepth = new float[kinectSize];

int threshold = 5;
int stiffness = 2;

boolean initState = true;
int kinectFrame = 0;

PVector pos = new PVector();

PVector kinectPos1 = new PVector ();
PVector kinectPos2 = new PVector ();

//=========================================================================//
////////////////////////////////// LEAP STUFF////////////////////////////////
//=========================================================================//

boolean stabilization = false;
boolean isLeft1, isRight1;
float leapGrabL1;
PVector leapPosL1 = new PVector ();
PVector leapDynL1 = new PVector ();
float leapGrabR1;
PVector leapPosR1 = new PVector ();
PVector leapDynR1 = new PVector ();
//=========================================================================//

boolean isLeft2, isRight2;
float leapGrabL2;
PVector leapPosL2 = new PVector ();
PVector leapDynL2 = new PVector ();
float leapGrabR2;
PVector leapPosR2 = new PVector ();
PVector leapDynR2 = new PVector ();

//=========================================================================//
////////////////////////////////GRAPHIC STUFF////////////////////////////////
//=========================================================================//

PVector textPos;
int info = 0;

//=========================================================================//
//=========================================================================//
//=========================================================================//
//=========================================================================//

void setup() {
  size (1024, 640, P3D);
  background(255);

  initRoutine();

  if (netEnabled)
  {
    oscSetup();
  }

  if (leapEnabled)
  {
    leapSetup();
  }

  if (kinectEnabled)
  {
    kinectSetup();
  }

  println("Net: " + netEnabled);
  println("Leap: " + leapEnabled);
  println("Kinect: " + kinectEnabled);
  println("Dummy Draw: " + dummyDrawEnabled);
  println("Ref Text: " + refTextEnabled);
}


//=========================================================================//

void draw() {
  background(255);

  if (leapEnabled)
  {
    leapAnalisis();
  }

  if (kinectEnabled)
  {
    if (!initState)
    {
      kinectInit();
    }
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
    refTextRoutine();
  }
}

//=========================================================================//

void stop() {
  if (kinectEnabled)
  {
    kinect.quit();
  }
  super.stop();
}



//=========================================================================//