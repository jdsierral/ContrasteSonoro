//      SETUP SEND

void oscSetup()
{
  //Configuración de los puertos
  for (int i = 0; i < 2; i++) {
    if (myIP.equals(IP[i])) myPort = port[i];
  }
  //Imprimir la dirección IP y puerto del presente sistema
  println("YOUR IP AND PORT: " + myIP + ", " + myPort);

  osc = new OscP5(this, myPort);    //this mac port;

  CS1Pro = new NetAddress(IP[0], port[0]);
  CS2Pro = new NetAddress(IP[1], port[1]);
  CS1Max = new NetAddress(IP[1], port[2]);
  CS2Max = new NetAddress(IP[1], port[3]);
}

void midiBusSetup()
{
  MidiBus.list();
  midiBus = new MidiBus(this, -1, 1);
}

void midiRoutine()
{
  midiBus.sendControllerChange (0, 50, map(kinectPos1.x, 0, kinectWidth, 0, 127)));
  midiBus.sendControllerChange (0, 51, map(kinectPos1.y, 0, kinectHeight, 0, 127)));
  midiBus.sendControllerChange (0, 52, map(kinectPos1.z, 0, 120, 0, 127)));
  
  
}

//SEND

void oscRoutine()
{
  //Creación y envío de los mensajes OSC
  OscBundle bundleMsg = new OscBundle();

  OscMessage leapLMsg = new OscMessage("/leapL");
  leapLMsg.add(leapPosL1.array());
  leapLMsg.add(leapDynL1.array());
  leapLMsg.add(leapGrabL1);

  OscMessage leapRMsg = new OscMessage("/leapR");
  leapRMsg.add(leapPosR1.array());
  leapRMsg.add(leapDynR1.array());
  leapRMsg.add(leapGrabR1);

  OscMessage kinectMsg = new OscMessage("/kinect");
  kinectMsg.add(map(kinectPos1.x, 0, kinectWidth, 0, 100));
  kinectMsg.add(map(kinectPos1.y, 0, kinectHeight, 100, 0));
  kinectMsg.add(kinectPos1.z);

  bundleMsg.add(leapLMsg);
  bundleMsg.add(leapRMsg);
  bundleMsg.add(kinectMsg);
  
  if (!myIP.equals(IP[0])) osc.send(bundleMsg, CS1Pro);
  if (!myIP.equals(IP[1])) osc.send(bundleMsg, CS2Pro);
  if (myIP.equals(IP[0])) osc.send(bundleMsg, CS1Max);
  if (myIP.equals(IP[1])) osc.send(bundleMsg, CS2Max);
}

//    RECEIVE

void oscEvent(OscMessage dataIn) {

  if (dataIn.checkAddrPattern("/leapL") == true) 
  {
    if (dataIn.checkTypetag("fffffff")) {
      leapPosL2.x = dataIn.get(0).floatValue();
      leapPosL2.y = dataIn.get(1).floatValue();
      leapPosL2.z = dataIn.get(2).floatValue();
      leapDynL2.x = dataIn.get(3).floatValue();
      leapDynL2.y = dataIn.get(4).floatValue();
      leapDynL2.z = dataIn.get(5).floatValue();
      leapGrabL2  = dataIn.get(6).floatValue();
    }
  }

  if (dataIn.checkAddrPattern("/leapR") == true) 
  {
    if (dataIn.checkTypetag("fffffff")) {
      leapPosR2.x = dataIn.get(0).floatValue();
      leapPosR2.y = dataIn.get(1).floatValue();
      leapPosR2.z = dataIn.get(2).floatValue();
      leapDynR2.x = dataIn.get(3).floatValue();
      leapDynR2.y = dataIn.get(4).floatValue();
      leapDynR2.z = dataIn.get(5).floatValue();
      leapGrabR2  = dataIn.get(6).floatValue();
    }
  }

  if (dataIn.checkAddrPattern("/kinect") == true)
  {
    if (dataIn.checkTypetag("fff")) {
      kinectPos2.x = dataIn.get(0).floatValue();
      kinectPos2.y = dataIn.get(1).floatValue();
      kinectPos2.z = dataIn.get(2).floatValue();
    }
  }
}