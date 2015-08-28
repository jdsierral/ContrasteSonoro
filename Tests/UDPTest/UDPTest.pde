import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress CS1Pro;
NetAddress CS2Pro;
NetAddress CS1Max;
NetAddress CS2Max;

//======

PVector pos = new PVector();
PVector pos2 = new PVector();
int[] port = {
  12001, 12002, 12011, 12012
};
String[] IP = {"192.168.0.101", "192.168.0.102"};

String myIP = NetInfo.lan();
int myPort;

//======

void setup()
{
  size(640, 480);

  for (int i = 0; i < 2; i++) {
    if (myIP.equals(IP[i])) myPort = port[i];
  }

  println("YOUR IP AND PORT: " + myIP + ", " + myPort);

  osc = new OscP5(this, myPort);    //this mac port; //<>//
  CS1Pro = new NetAddress(IP[0], port[0]);
  CS2Pro = new NetAddress(IP[1], port[1]); //<>//
  CS1Max = new NetAddress(IP[1], port[2]); //<>//
  CS2Max = new NetAddress(IP[1], port[3]);

  pos.x = width/2; //<>//
  pos.y = height/2; //<>//
  pos2.x = width/2;
  pos2.y = height/2;
}

void draw()
{
  background (0);

  pos.x = mouseX; 
  pos.y = mouseY;

  fill (0, 0, 255);
  ellipse (pos.x, pos.y, pos.z, pos.z);
  fill (0, 255, 0);
  ellipse (pos2.x+10, pos2.y+10, pos2.z, pos2.z);

  OscBundle bndlMsg = new OscBundle();
  OscMessage msg = new OscMessage ("/position");
  msg.add(pos.array());
  bndlMsg.add(msg);

  if (!myIP.equals(IP[0])) osc.send(bndlMsg, CS1Pro);
  if (!myIP.equals(IP[1])) osc.send(bndlMsg, CS2Pro);
  if (myIP.equals(IP[0])) osc.send(bndlMsg, CS1Max); //<>//
  if (myIP.equals(IP[1])) osc.send(bndlMsg, CS2Max);
}

void mouseWheel(MouseEvent event)
{
  if (pos.z >= 0 && pos.z <= height/2) 
  {
    float e = 1; 
    e = event.getCount();
    pos.z += e;
  } else if (pos.z < 0) 
  {
    pos.z = 0;
  } else if (pos.z > height/2)
  {
    pos.z = height/2;
  }
}

void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/position") == true) {
    if (msg.checkTypetag("fff")) {
      pos2.x = msg.get(0).floatValue();
      pos2.y = msg.get(1).floatValue();
      pos2.z = msg.get(2).floatValue();
    }
  }
}