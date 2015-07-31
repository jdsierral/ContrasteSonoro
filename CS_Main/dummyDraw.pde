void dummyDraw()
{
  
  
  fill(255, 0, 0);
  ellipse(leapPosL1.x, leapPosL1.y, leapPosL1.z, leapPosL1.z);
  fill(0, 255, 0);
  ellipse(leapPosR1.x, leapPosR1.y, leapPosR1.z, leapPosR1.z);
  fill(0, 0, 255);
  ellipse(kinectPos1.x, kinectPos1.y, kinectPos1.z, kinectPos1.z);

  fill(255, 255, 0);
  ellipse(leapPosL2.x, leapPosL2.y, leapPosL2.z, leapPosL2.z);
  fill(0, 255, 255);
  ellipse(leapPosR2.x, leapPosR2.y, leapPosR2.z, leapPosR2.z);
  fill(255, 0, 255);
  ellipse(kinectPos2.x, kinectPos2.y, kinectPos2.z, kinectPos2.z);
}

