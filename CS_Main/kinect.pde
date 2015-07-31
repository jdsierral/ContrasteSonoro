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

