import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress mac1;
NetAddress mac2;

//===

float[] posRed = new float[3];
float[] posRed_ = new float[3];
float[] posBlu = new float[3];
float[] posBlu_ = new float[3];
int x = 0;
int y = 1;
int z = 2;

//===

void setup()
{
  size(640, 480);

  osc = new OscP5(this, 12345);
  mac1 = new NetAddress ("192.168.0.11", 12345);
  mac2 = new NetAddress ("192.168.0.12", 12346);

  posRed[x] = mouseX;
  posRed[y] = mouseY;
  posRed[z] = 10;

  posBlu[x] = mouseX;
  posBlu[y] = mouseY;
  posBlu[z] = 10;
}

void draw()
{
  background (0);

  posBlu[x] = mouseX;
  posBlu[y] = mouseY; 

  fill (0, 0, 255); 
  ellipse (posRed[x], posRed[y], posRed[z], posRed[z]);

  fill (255, 0, 0); 
  ellipse (posBlu[x], posBlu[y], posBlu[z], posBlu[z]);

  if (posBlu[x] != posBlu_[x])
  {
    OscBundle BundleMsg = new OscBundle();
    OscMessage msg = new OscMessage("/position");
    msg.add(posBlu_);
    BundleMsg.add(msg);

    osc.send(BundleMsg, mac2);
    
    posBlu_ = posBlu;
  }
}

void mouseWheel(MouseEvent event) 
{
  if (posBlu[z] >= 0 && posBlu[z] <= height/2) 
  {
    float e = 1; 
    e = event.getCount();
    posBlu[z] = posBlu[z] + (e);
  } else if (posBlu[z] < 0) 
  {
    posBlu[z] = 0;
  } else if (posBlu[z] > height/2)
  {
    posBlu[z] = height/2;
  }
}

void oscEvent(OscMessage dataIn) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+dataIn.addrPattern());
  println(" typetag: "+dataIn.typetag());

  if (dataIn.checkAddrPattern("/position")==true) {
    if (dataIn.checkTypetag("fff")) {
      posRed[x] = dataIn.get(0).floatValue();
      posRed[y] = dataIn.get(1).floatValue();
      posRed[z] = dataIn.get(2).floatValue();
      return;
    }
  }
}

