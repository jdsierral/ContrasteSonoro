void calibration (int cal)
{
  println(cal);

  OscBundle bundleMsg = new OscBundle();
  
  switch(cal)
  {
  case kinectX : 
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (0, 48, i);
      OscMessage kinectMsg = new OscMessage ("/kinect");
      kinectMsg.add(i);
      kinectMsg.add(0);
      kinectMsg.add(0);
      bundleMsg.add(kinectMsg);
      delay(50);
    };
    break;
  case kinectY :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (0, 49, i);
      OscMessage kinectMsg = new OscMessage ("/kinect");
      kinectMsg.add(0);
      kinectMsg.add(i);
      kinectMsg.add(0);
      bundleMsg.add(kinectMsg);
      delay(50);
    }
    break;
  case kinectZ :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (0, 50, i);
      OscMessage kinectMsg = new OscMessage ("/kinect");
      kinectMsg.add(0);
      kinectMsg.add(0);
      kinectMsg.add(i);
      bundleMsg.add(kinectMsg);
      delay(50);
    }
    break;
  case leapLPosX :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (1, 48, i);
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
  case leapLPosY :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (1, 49, i);
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
  case leapLPosZ :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (1, 50, i);
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
  case leapRPosX :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (2, 48, i);
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
  case leapRPosY :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (2, 49, i);
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
  case leapRPosZ :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (2, 50, i);
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
  case leapLDynX :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (3, 48, i);
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
  case leapLDynY :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (3, 49, i);
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
  case leapLDynZ :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (3, 50, i);
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
  case leapRDynX :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (4, 48, i);
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
  case leapRDynY :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (4, 49, i);
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
  case leapRDynZ :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (4, 50, i);
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
  case leapLGrab :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (5, 48, i);
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
  case leapRGrab :
    for (int i = 0; i < 50; i++) {
      midiBus.sendControllerChange (5, 49, i);
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
  }
  if (!myIP.equals(IP[0])) osc.send(bundleMsg, CS1Pro);
  if (!myIP.equals(IP[1])) osc.send(bundleMsg, CS2Pro);
  if (myIP.equals(IP[0])) osc.send(bundleMsg, CS1Max);
  if (myIP.equals(IP[1])) osc.send(bundleMsg, CS2Max);
}