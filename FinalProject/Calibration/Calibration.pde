


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
/*          Calibración del Sistema en el caso de que se esté 
/*          utilizando un sistema de automapping
/*  
/*  
/*
/*
/*
/*
/*
 */
//=========================================================================//






import themidibus.*;

import de.voidplus.leapmotion.*;
import development.*;

import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

import netP5.*;
import oscP5.*;

OscP5 osc;
MidiBus midiBus;
NetAddress CS1Pro;
NetAddress CS2Pro;
NetAddress CS1Max;
NetAddress CS2Max;


int[] port = {12001, 12002, 12011, 12012};
String[] IP = {"192.168.0.101", "192.168.0.102"};

String myIP = NetInfo.lan();
int myPort;

static final int kinectX = 0;
static final int kinectY = 1;
static final int kinectZ = 2;
static final int leapLPosX = 3;
static final int leapLPosY = 4;
static final int leapLPosZ = 5;
static final int leapRPosX = 6;
static final int leapRPosY = 7;
static final int leapRPosZ = 8;
static final int leapLDynX = 9;
static final int leapLDynY = 10;
static final int leapLDynZ = 11;
static final int leapRDynX = 12;
static final int leapRDynY = 13;
static final int leapRDynZ = 14;
static final int leapLGrab = 15;
static final int leapRGrab = 16;


void setup() {
  size(600, 600);
  MidiBus.list();
  midiBus = new MidiBus(this, -1, 1);
  
  for (int i = 0; i < 2; i++) {
    if (myIP.equals(IP[i])) myPort = port[i];
  }
  println("YOUR IP AND PORT: " + myIP + ", " + myPort);

  osc = new OscP5(this, myPort);    //this mac port;

  CS1Pro = new NetAddress(IP[0], port[0]);
  CS2Pro = new NetAddress(IP[1], port[1]);
  CS1Max = new NetAddress(IP[1], port[2]);
  CS2Max = new NetAddress(IP[1], port[3]);
}

void draw () {
  background(255);
  stroke(100);
  line(0, 200, width, 200);
  line(0, 400, width, 400);
  line(200, 0, 200, 200);
  line(400, 0, 400, 200);
  line(100, 400, 100, height);
  line(200, 400, 200, height);
  line(300, 400, 300, height);
  line(400, 400, 400, height);
  line(500, 200, 500, height);
  drawText();
  noStroke();
  fill(0);
  ellipse(mouseX, mouseY, 20, 20);
  
}

void mousePressed() {
  if (mouseX > 0 && mouseX < 200 && mouseY > 0 && mouseY < 200)
  {
    calibration(kinectX);
  }
  if (mouseX > 200 && mouseX < 400 && mouseY > 0 && mouseY < 200)
  {
    calibration(kinectY);
  }
  if (mouseX > 400 && mouseX < 600 && mouseY > 0 && mouseY < 200)
  {
    calibration(kinectZ);
  }
  if (mouseX > 0 && mouseX < 100 && mouseY > 400 && mouseY < 600)
  {
    if (mouseButton == LEFT) { 
      calibration(leapLPosX);
    } else if (mouseButton == RIGHT)
    {
      calibration (leapRPosX);
    }
  }
  if (mouseX > 100 && mouseX < 200 && mouseY > 400 && mouseY < 600)
  {
    if (mouseButton == LEFT) { 
      calibration(leapLPosY);
    } else if (mouseButton == RIGHT)
    {
      calibration (leapRPosY);
    }
  }
  if (mouseX > 200 && mouseX < 300 && mouseY > 400 && mouseY < 600)
  {
    if (mouseButton == LEFT) { 
      calibration(leapLPosZ);
    } else if (mouseButton == RIGHT)
    {
      calibration (leapRPosZ);
    }
  }
  if (mouseX > 300 && mouseX < 400 && mouseY > 400 && mouseY < 600)
  {
    if (mouseButton == LEFT) { 
      calibration(leapLDynX);
    } else if (mouseButton == RIGHT)
    {
      calibration (leapRDynX);
    }
  }
  if (mouseX > 400 && mouseX < 500 && mouseY > 400 && mouseY < 600)
  {
    if (mouseButton == LEFT) { 
      calibration(leapLDynY);
    } else if (mouseButton == RIGHT)
    {
      calibration (leapRDynY);
    }
  }
  if (mouseX > 500 && mouseX < 600 && mouseY > 400 && mouseY < 600)
  {
    if (mouseButton == LEFT) { 
      calibration(leapLDynZ);
    } else if (mouseButton == RIGHT)
    {
      calibration (leapRDynZ);
    }
  }
  if (mouseX > 500 && mouseX < 600 && mouseY > 200 && mouseY < 400)
  {
    if (mouseButton == LEFT) { 
      calibration(leapLGrab);
    } else if (mouseButton == RIGHT)
    {
      calibration (leapRGrab);
    }
  }
}