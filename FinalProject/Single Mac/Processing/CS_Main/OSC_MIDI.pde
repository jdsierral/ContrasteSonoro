//      SETUP SEND

void oscSetup()
{
  //Configuración de los puertos
  //for (int i = 0; i < 2; i++) {
  //  if (myIP.equals(IP[i])) myPort = port[i];
  //}
  //Imprimir la dirección IP y puerto del presente sistema
  println("YOUR IP AND PORT: " + myIP + ", " + myPort);

  osc = new OscP5(this, myPort);    //this mac port;

  //CS1Pro = new NetAddress(IP[0], port[0]);
  //CS2Pro = new NetAddress(IP[1], port[1]);
  //CS1Max = new NetAddress(IP[1], port[2]);
  //CS2Max = new NetAddress(IP[1], port[3]);
  
  CS1Max = new NetAddress(myIP, maxPort);
}

void midiBusSetup()
{
  MidiBus.list();
  midiBus = new MidiBus(this, -1, 1);
  midiInit = true;
}

void midiRoutine()
{

  if (kinectEnabled) {
  midiBus.sendControllerChange (1, 48, (int)map(kinectPos1.x, 0, kinectWidth, 0, 127));
  midiBus.sendControllerChange (1, 49, (int)map(kinectPos1.y, 0, kinectHeight, 0, 127));
  midiBus.sendControllerChange (1, 50, (int)map(kinectPos1.z, 0, 120, 0, 127));
  }
  
  if (leapEnabled) {
  midiBus.sendControllerChange (3, 48, (int)map(leapPosL1.x, 0, 600, 0, 127));
  midiBus.sendControllerChange (3, 49, (int)map(leapPosL1.y, 200, 600, 0, 127));
  midiBus.sendControllerChange (3, 50, (int)map(leapPosL1.z, 0, 100, 0, 127));
  midiBus.sendControllerChange (5, 48, (int)map(leapPosR1.x, 0, 600, 0, 127));
  midiBus.sendControllerChange (5, 49, (int)map(leapPosR1.y, 200, 600, 0, 127));
  midiBus.sendControllerChange (5, 50, (int)map(leapPosR1.z, 0, 100, 0, 127));
  midiBus.sendControllerChange (7, 48, (int)map(leapDynL1.x, -60, 60, 0, 127));
  midiBus.sendControllerChange (7, 49, (int)map(leapDynL1.y, -90, 90, 0, 127));
  midiBus.sendControllerChange (7, 50, (int)map(leapDynL1.z, -50, 50, 0, 127));
  midiBus.sendControllerChange (9, 48, (int)map(leapDynR1.x, -60, 60, 0, 127));
  midiBus.sendControllerChange (9, 49, (int)map(leapDynR1.y, -90, 90, 0, 127));
  midiBus.sendControllerChange (9, 50, (int)map(leapDynR1.z, -50, 50, 0, 127));
  midiBus.sendControllerChange (11, 48, (int)map(leapGrabL1, 0, 1, 0, 127));
  midiBus.sendControllerChange (11, 49, (int)map(leapGrabR1, 0, 1, 0, 127));
  }
  
  if (netEnabled) {
    if (kinectEnabled) {
  midiBus.sendControllerChange (2, 48, (int)map(kinectPos2.x, 0, kinectWidth, 0, 127));
  midiBus.sendControllerChange (2, 49, (int)map(kinectPos2.y, 0, kinectHeight, 0, 127));
  midiBus.sendControllerChange (2, 50, (int)map(kinectPos2.z, 0, 120, 0, 127));
    }
    
    if (leapEnabled) {
  midiBus.sendControllerChange (4, 48, (int)map(leapPosL2.x, 0, 200, 0, 127));
  midiBus.sendControllerChange (4, 49, (int)map(leapPosL2.y, 0, 200, 0, 127));
  midiBus.sendControllerChange (4, 50, (int)map(leapPosL2.z, 0, 200, 0, 127));
  midiBus.sendControllerChange (6, 48, (int)map(leapPosR2.x, 0, 200, 0, 127));
  midiBus.sendControllerChange (6, 49, (int)map(leapPosR2.y, 0, 200, 0, 127));
  midiBus.sendControllerChange (6, 50, (int)map(leapPosR2.z, 0, 200, 0, 127));
  midiBus.sendControllerChange (8, 48, (int)map(leapDynL2.x, 0, 200, 0, 127));
  midiBus.sendControllerChange (8, 49, (int)map(leapDynL2.y, 0, 200, 0, 127));
  midiBus.sendControllerChange (8, 50, (int)map(leapDynL2.z, 0, 200, 0, 127));
  midiBus.sendControllerChange (10, 48, (int)map(leapDynR2.x, 0, 200, 0, 127));
  midiBus.sendControllerChange (10, 49, (int)map(leapDynR2.y, 0, 200, 0, 127));
  midiBus.sendControllerChange (10, 50, (int)map(leapDynR2.z, 0, 200, 0, 127));
  midiBus.sendControllerChange (12, 48, (int)map(leapGrabL2, 0, 1, 0, 127));
  midiBus.sendControllerChange (12, 49, (int)map(leapGrabR2, 0, 1, 0, 127));
    }
  }
}
/*
    kinect   x, y, z
    leapPosL x, y, z
    leapPosR x, y, z
    leapDynL x, y, z
    leapDynR x, y, z
    leapGrabL
    leapGrabR
*/
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
  
  //if (!myIP.equals(IP[0])) osc.send(bundleMsg, CS1Pro); //NO NEED ON SINGLE MAC VERSION
  //if (!myIP.equals(IP[1])) osc.send(bundleMsg, CS2Pro); //NO NEED ON SINGLE MAC VERSION
  //if (myIP.equals(IP[0])) osc.send(bundleMsg, CS1Max);  //NO NEED ON SINGLE MAC VERSION
  //if (myIP.equals(IP[1])) osc.send(bundleMsg, CS2Max);  //NO NEED ON SINGLE MAC VERSION
  
  osc.send(bundleMsg, CS1Max);
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