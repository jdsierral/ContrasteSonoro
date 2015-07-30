//       SEND

void oscRoutine()
{
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
  kinectMsg.add(kinectPos1.array());
  
  bundleMsg.add(leapLMsg);
  bundleMsg.add(leapRMsg);
  bundleMsg.add(kinectMsg);
  
  osc.send(bundleMsg, CS0);
  osc.send(bundleMsg, CS1);
  osc.send(bundleMsg, CS2);
}

//    RECEIVE

void oscEvent(OscMessage dataIn) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+dataIn.addrPattern());
  println(" typetag: "+dataIn.typetag());

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

