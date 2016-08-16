void kinectSetup()
{
  kinect = new Kinect (this);

  kinect.initDepth();
  kinect.setTilt(deg);
}

void kinectInit()
{
  meanDepth = kinect.getRawDepth();
  for (int j = 0; j < meanFactor * meanLength; j++)
  {
    depth = kinect.getRawDepth();
    for (int i = 0; i < kinectSize; i++)
    {
      meanDepth[i] = (meanDepth[i] * (meanLength - 1) + depth[i])/meanLength;
      stndDepth[i] = 0;
    }
    println(str(j));
  }
  println("done calculating mean space");
  for (int j = 0; j < meanFactor * meanLength; j++)
  {
    depth = kinect.getRawDepth();
    for (int i = 0; i < kinectSize; i++)
    {
      stndDepth[i] = sqrt((stndDepth[i] * (meanLength - 1) + pow(depth[i] - meanDepth[i], 2))/meanLength);
    }
    println(str(j));
  }
  println("done calculating standard deviation");
  initState = true;
  println("done Calibrating backgroudn extraction");
}

void kinectAnalisis()
{  
  depth = kinect.getRawDepth();

  for (int i = 0; i < kinectSize; i++)
  {
    if (abs(depth[i] - meanDepth[i]) <= accuracy * stndDepth[i])
    {
      depth[i] = 2048;
    }
  }

  int[] topArray = new int[meanSize];
  int[] topIndex = new int[meanSize];

  PVector maxPos = new PVector();

  top(depth, topArray, topIndex);
  maxPos = meanPos(topIndex, kinectWidth);

  if (abs(pos.x - maxPos.x) > threshold)
  {
    pos.x += ((maxPos.x - pos.x)/stiffness);
  }

  if (abs(pos.y - maxPos.y) > threshold)
  {
    pos.y += ((maxPos.y - pos.y)/stiffness);
  }
  
  kinectPos1.x = kinectWidth - pos.x;
  kinectPos1.y = pos.y;
  kinectPos1.z = map(topArray[0], 0, 1024, 100, 0);
}