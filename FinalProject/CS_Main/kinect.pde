//https://en.wikipedia.org/wiki/Amanita_muscaria

void kinectAnalisis ()
{
  kinect.enableDepth(true);
  PImage img = kinect.getDepthImage();
  int[] depth = kinect.getRawDepth();
  int[] topArray = new int[meanSize];
  int[] topIndex = new int[meanSize];
  PVector maxPos = new PVector ();
  PVector maxLerpedPos = new PVector();
  image(kinect.getDepthImage(), 0, 0); 

  top(depth, topArray, topIndex); 

  maxPos = meanPos(topIndex, width);
  fill(255, 255, 0);

  maxLerpedPos.x = PApplet.lerp(maxLerpedPos.x, maxPos.x, 0.3f);
  maxLerpedPos.y = PApplet.lerp(maxLerpedPos.y, maxPos.y, 0.3f);


  ellipse(maxPos.x, maxPos.y, 20, 20); 





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
