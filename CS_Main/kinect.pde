void kinectAnalisis ()
{
  kinect.enableDepth(true);
  PImage img = kinect.getDepthImage();
  int[] depth = kinect.getRawDepth();
  
  // time average for comparison?
  
  maxIndex = maxValueIndex(depth, kinectSize);
  
  max.x = getX(maxIndex, img.width);
  max.y = getY(maxIndex, img.width);
  
  loadPixels();
  
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

For (int i = 0; i < depth.kenght; I++


*/