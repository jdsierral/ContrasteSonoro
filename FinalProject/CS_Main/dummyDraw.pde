void dummyDraw()
{
  if (kinectEnabled)
  {
    drawKinect();
  }
  
  if (leapEnabled)
  {
    drawLeap();
  }
}

void drawKinect()
{
  showDepth(kinectFrame);
  ellipse(kinectPos1.x, kinectPos1.y, kinectPos1.z, kinectPos1.z);
  ellipse(kinectPos2.x, kinectPos2.y, kinectPos2.z, kinectPos2.z);
}

void drawLeap()
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

void showDepth(int kinectFrame)
{ 
  pushMatrix();
  scale(-1, 1);
  translate(-kinectWidth, 0); 
  switch (kinectFrame)
  {
  case 0  :
    image (kinect.getDepthImage(), 0, 0);
    break;
  case 1  :
    PImage img1 = createImage(kinectWidth, kinectHeight, RGB);
    img1.loadPixels();
    for (int i = 0; i < kinectSize; i++)
    {
      img1.pixels[i] = color((int)map(depth[i], 0, 2048, 255, 0));
    }
    img1.updatePixels();
    image(img1, 0, 0);
    break;
  case 2  :
    PImage img2 = createImage(kinectWidth, kinectHeight, RGB);
    img2.loadPixels();
    for (int i = 0; i < kinectSize; i++)
    {
      img2.pixels[i] = color((int)map(meanDepth[i], 0, 2048, 255, 0));
    }
    img2.updatePixels();
    image(img2, 0, 0);
    break;
  case 3  :
    PImage img3 = createImage(kinectWidth, kinectHeight, RGB);
    img3.loadPixels();
    for (int i = 0; i < kinectSize; i++)
    {
      img3.pixels[i] = color((int)map(stndDepth[i], 0, 2048, 0, 255));
    }
    img3.updatePixels();
    image(img3, 0, 0);
    break;
  }
  popMatrix();
}

