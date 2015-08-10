import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress mac1;

//======

PVector pos = new PVector();
PVector pos2 = new PVector();
int r = 20;
String myIP = NetInfo.lan();
int port = 7777;


//======

void setup()
{
  size(640, 480);

  osc = new OscP5(this, port);
  mac1 = new NetAddress (myIP, port);

  pos.x = width/2;
  pos.y = height/2;
  pos2.x = width/2;
  pos2.y = height/2;
}

void draw()
{
  background (0);

  pos.x = mouseX; 
  pos.y = mouseY;

  fill (0, 0, 255);
  ellipse (pos.x, pos.y, r, r);
  fill (0, 255, 0);
  ellipse (pos2.x+10, pos2.y+10, r, r);

  OscBundle bndlMsg = new OscBundle();
  OscMessage msg = new OscMessage ("/position");
  msg.add(pos.array());
  bndlMsg.add(msg);

  osc.send(bndlMsg, mac1);
}

void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/position") == true) {
    if (msg.checkTypetag("fff")) {
      pos2.x = msg.get(0).floatValue();
      pos2.y = msg.get(1).floatValue();
    }
  }
}

