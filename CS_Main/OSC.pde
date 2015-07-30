void oscRoutine()
{
  OscBundle bundleMsg = new OscBundle();
  OscMessage leapMsg = new OscMessage("/leap");
  leapMsg.add(leapPosL1.array());
  leapMsg.add(leapDynL1.array());
  leapMsg.add(leapGrabL1);
  leapMsg.add(leapPosR1.array());
  leapMsg.add(leapDynR1.array());
  leapMsg.add(leapGrabR1);
  
  OscMessage kinectMsg = new OscMessage("/kinect");
  kinectMsg.add(kinectPos1.array());
  
  bundleMsg.add(leapMsg);
  bundleMsg.add(kinectMsg);
  
  osc.send(bundleMsg, CS0);
  osc.send(bundleMsg, CS1);
  osc.send(bundleMsg, CS2);
}
