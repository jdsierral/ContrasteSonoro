void calibration (int cal)
{
  println("Calibrating: " + cal);

  OscBundle bundleMsg = new OscBundle();

  switch(cal) {
  case kinect1X : 
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (1, 48, i);
      OscMessage kinectMsg = new OscMessage ("/kinect");
      kinectMsg.add(i);
      kinectMsg.add(0);
      kinectMsg.add(0);
      bundleMsg.add(kinectMsg);
      delay(50);
    };
    break;
  case kinect1Y :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (1, 49, i);
      OscMessage kinectMsg = new OscMessage ("/kinect");
      kinectMsg.add(0);
      kinectMsg.add(i);
      kinectMsg.add(0);
      bundleMsg.add(kinectMsg);
      delay(50);
    }
    break;
  case kinect1Z :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (1, 50, i);
      OscMessage kinectMsg = new OscMessage ("/kinect");
      kinectMsg.add(0);
      kinectMsg.add(0);
      kinectMsg.add(i);
      bundleMsg.add(kinectMsg);
      delay(50);
    }
    break;
  case leapLPos1X :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (3, 48, i);
      OscMessage leapMsg = new OscMessage ("/leapL");
      leapMsg.add(i);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      bundleMsg.add(leapMsg);
      delay(50);
    }
    break;
  case leapLPos1Y :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (3, 49, i);
      OscMessage leapMsg = new OscMessage ("/leapL");
      leapMsg.add(0);
      leapMsg.add(i);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      bundleMsg.add(leapMsg);
      delay(50);
    }
    break;
  case leapLPos1Z :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (3, 50, i);
      OscMessage leapMsg = new OscMessage ("/leapL");
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(i);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      bundleMsg.add(leapMsg);
      delay(50);
    }
    break;
  case leapRPos1X :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (5, 48, i);
      OscMessage leapMsg = new OscMessage ("/leapR");
      leapMsg.add(i);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      bundleMsg.add(leapMsg);
      delay(50);
    }
    break;
  case leapRPos1Y :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (5, 49, i);
      OscMessage leapMsg = new OscMessage ("/leapR");
      leapMsg.add(0);
      leapMsg.add(i);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      bundleMsg.add(leapMsg);
      delay(50);
    }
    break;
  case leapRPos1Z :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (5, 50, i);
      OscMessage leapMsg = new OscMessage ("/leapR");
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(i);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      bundleMsg.add(leapMsg);
      delay(50);
    }
    break;
  case leapLDyn1X :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (7, 48, i);
      OscMessage leapMsg = new OscMessage ("/leapL");
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(i);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      bundleMsg.add(leapMsg);
      delay(50);
    }
    break;
  case leapLDyn1Y :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (7, 49, i);
      OscMessage leapMsg = new OscMessage ("/leapL");
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(i);
      leapMsg.add(0);
      leapMsg.add(0);
      bundleMsg.add(leapMsg);
      delay(50);
    }
    break;
  case leapLDyn1Z :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (7, 50, i);
      OscMessage leapMsg = new OscMessage ("/leapL");
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(i);
      leapMsg.add(0);
      bundleMsg.add(leapMsg);
      delay(50);
    }
    break;
  case leapRDyn1X :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (9, 48, i);
      OscMessage leapMsg = new OscMessage ("/leapR");
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(i);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      bundleMsg.add(leapMsg);
      delay(50);
    }
    break;
  case leapRDyn1Y :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (9, 49, i);
      OscMessage leapMsg = new OscMessage ("/leapR");
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(i);
      leapMsg.add(0);
      leapMsg.add(0);
      bundleMsg.add(leapMsg);
      delay(50);
    }
    break;
  case leapRDyn1Z :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (9, 50, i);
      OscMessage leapMsg = new OscMessage ("/leapR");
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(i);
      leapMsg.add(0);
      bundleMsg.add(leapMsg);
      delay(50);
    }
    break;
  case leapLGrab1 :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (11, 48, i);
      OscMessage leapMsg = new OscMessage ("/leapL");
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(i);
      bundleMsg.add(leapMsg);
      delay(50);
    }
    break;
  case leapRGrab1 :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (11, 49, i);
      OscMessage leapMsg = new OscMessage ("/leapR");
      leapMsg.add(i);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(0);
      leapMsg.add(i);
      bundleMsg.add(leapMsg);
      delay(50);
    }
    break;


    //// Calibración de MIDI a través de la lectura interna de processing de los datos ajenos.    

  case kinect2X : 
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (2, 48, i);
      delay(50);
    };
    break;
  case kinect2Y :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (2, 49, i);
      delay(50);
    }
    break;
  case kinect2Z :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (2, 50, i);
      delay(50);
    }
    break;
  case leapLPos2X :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (4, 48, i);
      delay(50);
    }
    break;
  case leapLPos2Y :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (4, 49, i);
      delay(50);
    }
    break;
  case leapLPos2Z :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (4, 50, i);
      delay(50);
    }
    break;
  case leapRPos2X :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (6, 48, i);
      delay(50);
    }
    break;
  case leapRPos2Y :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (6, 49, i);
      delay(50);
    }
    break;
  case leapRPos2Z :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (6, 50, i);
      delay(50);
    }
    break;
  case leapLDyn2X :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (8, 48, i);
      delay(50);
    }
    break;
  case leapLDyn2Y :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (8, 49, i);
      delay(50);
    }
    break;
  case leapLDyn2Z :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (8, 50, i);
      delay(50);
    }
    break;
  case leapRDyn2X :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (10, 48, i);
      delay(50);
    }
    break;
  case leapRDyn2Y :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (10, 49, i);
      delay(50);
    }
    break;
  case leapRDyn2Z :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (10, 50, i);
      delay(50);
    }
    break;
  case leapLGrab2 :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (12, 48, i);
      delay(50);
    }
    break;
  case leapRGrab2 :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (12, 49, i);
      delay(50);
    }
    break;
  }
  if (!myIP.equals(IP[0])) osc.send(bundleMsg, CS1Pro);
  if (!myIP.equals(IP[1])) osc.send(bundleMsg, CS2Pro);
  if (myIP.equals(IP[0])) osc.send(bundleMsg, CS1Max);
  if (myIP.equals(IP[1])) osc.send(bundleMsg, CS2Max);
  println("Calibration Done");
}