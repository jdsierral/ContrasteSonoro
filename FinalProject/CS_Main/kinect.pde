void kinectSetup()
{
  kinect = new Kinect (this);
  kinect.start();

  kinect.enableDepth(true);
  for (int i = 0; i < depthLookUp.length; i++) 
  {
    depthLookUp[i] = rawDepthToMeters(i);
  }
}

void kinectInit()
{

}

void kinectAnalisis()
{  
  int[] flipedDepth = kinect.getRawDepth();
  for (int i = 0; i < kinectSize; i++)
  {
    depth[(kinectWidth-1-(i % kinectWidth)) + (i / kinectWidth)*kinectWidth] = flipedDepth[i];
  }

  int[] topArray = new int[meanSize];
  int[] topIndex = new int[meanSize];
  PVector maxPos = new PVector ();
  PVector maxLerpedPos = new PVector();

  top(depth, topArray, topIndex); 
  maxPos = meanPos(topIndex, width);

  maxLerpedPos.x = PApplet.lerp(maxLerpedPos.x, maxPos.x, 0.3f);
  maxLerpedPos.y = PApplet.lerp(maxLerpedPos.y, maxPos.y, 0.3f);

  fill(255, 255, 0);
  ellipse(maxPos.x, maxPos.y, 20, 20);
}

/* new ideas
 
 Average position among certain number o closer pixels to improve tracking.
 
 Auto set threshold for areas to avoid after until analisis..
 
 Constrain depth limits
 */
