void dummyDraw()
{

  //Left and Right proper hand positions

  drawHand(leapPosL1.x, leapPosL1.y, leapPosL1.z, 
  leapDynL1.x, leapDynL1.y, leapDynL1.z, leapGrabL1, color(255, 0, 0));

  drawHand(leapPosR1.x, leapPosR1.y, leapPosR1.z, 
  leapDynR1.x, leapDynR1.y, leapDynR1.z, leapGrabR1, color(0, 255, 0));

  //Left and Right alien hand positions

  drawHand(leapPosL2.x, leapPosL2.y, leapPosL2.z, 
  leapDynL2.x, leapDynL2.y, leapDynL2.z, leapGrabL2, color(255, 255, 0));

  drawHand(leapPosR2.x, leapPosR2.y, leapPosR2.z, 
  leapDynR2.x, leapDynR2.y, leapDynR2.z, leapGrabR2, color(0, 255, 255));

  ellipse(kinectPos1.x, kinectPos1.y, kinectPos1.z, kinectPos1.z);

  ellipse(kinectPos2.x, kinectPos2.y, kinectPos2.z, kinectPos2.z);
}

void drawHand(float x, float y, float z, 
float roll, float pitch, float yaw, 
float grab, color c)
{
  z = 100 - z;
  pushMatrix();
  fill(c);
  translate(x, y);
  rotateX(-radians(roll));
  rotateZ( radians(pitch));
  rotateY(-radians(yaw));
  scale(1.2-grab);
  box(z, z, 2 * z);
  popMatrix();
}


