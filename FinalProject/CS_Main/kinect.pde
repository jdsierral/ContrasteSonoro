void kinectAnalisis ()
{
  kinect.enableDepth(true);
  PImage img = kinect.getDepthImage();
  int[] depth = kinect.getRawDepth();
  
  image(kinect.getDepthImage(), 0, 0);
  
  // time average for comparison?
  
  
  
}

/* new ideas

Average position among certain number o closer pixels to improve tracking.

Auto set threshold for areas to avoid after until analisis..

Constrain depth limits


For (int x = 0; x < kinect.width; x++)
{
  Counter++;

  If (depth[counter])
  Sum.x += x;
  Sum.y += y;
}

Depth[pos];

For (int i = 0; i < depth.kenght; i++)
{
  
}


*/
