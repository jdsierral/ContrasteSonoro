


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
/*           
/*          
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

static final int kinect1X = 0;
static final int kinect1Y = 1;
static final int kinect1Z = 2;
static final int leapLPos1X = 3;
static final int leapLPos1Y = 4;
static final int leapLPos1Z = 5;
static final int leapRPos1X = 6;
static final int leapRPos1Y = 7;
static final int leapRPos1Z = 8;
static final int leapLDyn1X = 9;
static final int leapLDyn1Y = 10;
static final int leapLDyn1Z = 11;
static final int leapRDyn1X = 12;
static final int leapRDyn1Y = 13;
static final int leapRDyn1Z = 14;
static final int leapLGrab1 = 15;
static final int leapRGrab1 = 16;
static final int kinect2X = 17;
static final int kinect2Y = 18;
static final int kinect2Z = 19;
static final int leapLPos2X = 20;
static final int leapLPos2Y = 21;
static final int leapLPos2Z = 22;
static final int leapRPos2X = 23;
static final int leapRPos2Y = 24;
static final int leapRPos2Z = 25;
static final int leapLDyn2X = 26;
static final int leapLDyn2Y = 27;
static final int leapLDyn2Z = 28;
static final int leapRDyn2X = 29;
static final int leapRDyn2Y = 30;
static final int leapRDyn2Z = 31;
static final int leapLGrab2 = 32;
static final int leapRGrab2 = 33;


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
  if (keyPressed != true) {
    if (mouseX > 0 && mouseX < 200 && mouseY > 0 && mouseY < 200)
    {
      calibration(kinect1X);
    }
    if (mouseX > 200 && mouseX < 400 && mouseY > 0 && mouseY < 200)
    {
      calibration(kinect1Y);
    }
    if (mouseX > 400 && mouseX < 600 && mouseY > 0 && mouseY < 200)
    {
      calibration(kinect1Z);
    }
    if (mouseX > 0 && mouseX < 100 && mouseY > 400 && mouseY < 600)
    {
      if (mouseButton == LEFT) { 
        calibration (leapLPos1X);
      } else if (mouseButton == RIGHT)
      {
        calibration (leapRPos1X);
      }
    }
    if (mouseX > 100 && mouseX < 200 && mouseY > 400 && mouseY < 600)
    {
      if (mouseButton == LEFT) { 
        calibration(leapLPos1Y);
      } else if (mouseButton == RIGHT)
      {
        calibration (leapRPos1Y);
      }
    }
    if (mouseX > 200 && mouseX < 300 && mouseY > 400 && mouseY < 600)
    {
      if (mouseButton == LEFT) { 
        calibration(leapLPos1Z);
      } else if (mouseButton == RIGHT)
      {
        calibration (leapRPos1Z);
      }
    }
    if (mouseX > 300 && mouseX < 400 && mouseY > 400 && mouseY < 600)
    {
      if (mouseButton == LEFT) { 
        calibration(leapLDyn1X);
      } else if (mouseButton == RIGHT)
      {
        calibration (leapRDyn1X);
      }
    }
    if (mouseX > 400 && mouseX < 500 && mouseY > 400 && mouseY < 600)
    {
      if (mouseButton == LEFT) { 
        calibration(leapLDyn1Y);
      } else if (mouseButton == RIGHT)
      {
        calibration (leapRDyn1Y);
      }
    }
    if (mouseX > 500 && mouseX < 600 && mouseY > 400 && mouseY < 600)
    {
      if (mouseButton == LEFT) { 
        calibration(leapLDyn1Z);
      } else if (mouseButton == RIGHT)
      {
        calibration (leapRDyn2Z);
      }
    }
    if (mouseX > 500 && mouseX < 600 && mouseY > 200 && mouseY < 400)
    {
      if (mouseButton == LEFT) { 
        calibration(leapLGrab1);
      } else if (mouseButton == RIGHT)
      {
        calibration (leapRGrab1);
      }
    }
  } else if (keyPressed && keyCode == SHIFT) {
    if (mouseX > 0 && mouseX < 200 && mouseY > 0 && mouseY < 200)
    {
      calibration(kinect2X);
    }
    if (mouseX > 200 && mouseX < 400 && mouseY > 0 && mouseY < 200)
    {
      calibration(kinect2Y);
    }
    if (mouseX > 400 && mouseX < 600 && mouseY > 0 && mouseY < 200)
    {
      calibration(kinect2Z);
    }
    if (mouseX > 0 && mouseX < 100 && mouseY > 400 && mouseY < 600)
    {
      if (mouseButton == LEFT) { 
        calibration(leapLPos2X);
      } else if (mouseButton == RIGHT)
      {
        calibration (leapRPos2X);
      }
    }
    if (mouseX > 100 && mouseX < 200 && mouseY > 400 && mouseY < 600)
    {
      if (mouseButton == LEFT) { 
        calibration(leapLPos2Y);
      } else if (mouseButton == RIGHT)
      {
        calibration (leapRPos2Y);
      }
    }
    if (mouseX > 200 && mouseX < 300 && mouseY > 400 && mouseY < 600)
    {
      if (mouseButton == LEFT) { 
        calibration(leapLPos2Z);
      } else if (mouseButton == RIGHT)
      {
        calibration (leapRPos2Z);
      }
    }
    if (mouseX > 300 && mouseX < 400 && mouseY > 400 && mouseY < 600)
    {
      if (mouseButton == LEFT) { 
        calibration(leapLDyn2X);
      } else if (mouseButton == RIGHT)
      {
        calibration (leapRDyn2X);
      }
    }
    if (mouseX > 400 && mouseX < 500 && mouseY > 400 && mouseY < 600)
    {
      if (mouseButton == LEFT) { 
        calibration(leapLDyn2Y);
      } else if (mouseButton == RIGHT)
      {
        calibration (leapRDyn2Y);
      }
    }
    if (mouseX > 500 && mouseX < 600 && mouseY > 400 && mouseY < 600)
    {
      if (mouseButton == LEFT) { 
        calibration(leapLDyn2Z);
      } else if (mouseButton == RIGHT)
      {
        calibration (leapRDyn2Z);
      }
    }
    if (mouseX > 500 && mouseX < 600 && mouseY > 200 && mouseY < 400)
    {
      if (mouseButton == LEFT) { 
        calibration(leapLGrab2);
      } else if (mouseButton == RIGHT)
      {
        calibration (leapRGrab2);
      }
    }
  }
}