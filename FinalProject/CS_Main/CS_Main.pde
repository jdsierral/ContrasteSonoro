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
////////////////////////////////GLOBAL VARIABLES/////////////////////////////
//=========================================================================//

int[] setup = {
  1, 1, 0, 1, 1
};

boolean netEnabled;
boolean leapEnabled;
boolean kinectEnabled;
boolean dummyDrawEnabled;
boolean refTextEnabled;
//UDP STUFF

int[] port = {
  12000, 12001, 12002
};
String[] IP = {
  "192.168.10.106", "192.168.0.184", "192.168.0.102"
};

String myIP = NetInfo.lan();
int myPort;


//=========================================================================//
//////////////////////////////////KINECT STUFF///////////////////////////////
//=========================================================================//

int meanSize = 10; 
int meanLength = 50;
float[] depthLookUp = new float[2048];

int deg = 15;
int kinectSize = 307200;  //640 x 480
int kinectWidth = 640;
int kinectHeight = 480;

int[] depth = new int[kinectSize];
int[] meanDepth = new int[kinectSize];
float[] stndDepth = new float[kinectSize];
//int maxIndex;

int minThreshold = 5;
int maxThreshold = 200;
int speed = 5;
PVector max = new PVector ();
boolean initState = false;

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
    if (initState)
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

void keyPressed()
{
  switch (key)
  {
  case '0' : 
    info = ++info % 2; 
    break;
  case '1' :
    netEnabled = !netEnabled;
    if (netEnabled)
    { 
      oscSetup();
    }    
    println("Net: " + netEnabled); 
    break;
  case '2' :
    leapEnabled = !leapEnabled;
    if (leapEnabled)
    {
      leapSetup();
    }
    println("Leap: " + leapEnabled); 
    break;
  case '3' :
    kinectEnabled = !kinectEnabled;
    if (kinectEnabled)
    {
      kinectSetup();
    }
    println("Kinect: " + kinectEnabled); 
    break;
  case '4' :
    dummyDrawEnabled = !dummyDrawEnabled;
    println("Dummy Draw: " + dummyDrawEnabled); 
    break;
  case '5' :
    refTextEnabled = !refTextEnabled;
    println("Ref Text: " + refTextEnabled); 
    break;
  case RETURN :
    if (keyEvent.isMetaDown())
    {
      initState = true;
      println("Calibrating... Set Appart and wait please");
    }
    break;
  case CODED  :
    switch (keyCode)
    {
    case UP :
      deg++;
      break;
    case DOWN :
      deg--;
      break;
    }
    if (kinectEnabled)
    {
      kinect.tilt(deg);
    }
    break;
  }
}
//=========================================================================//



//=========================================================================//

void stop() {
  if (kinectEnabled)
  {
    kinect.quit();
  }
  super.stop();
}

//=========================================================================//

