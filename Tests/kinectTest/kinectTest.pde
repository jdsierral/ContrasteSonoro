import org.openkinect.*;
import org.openkinect.processing.tests.*;
import org.openkinect.processing.*;

Kinect kinect;

int meanSize = 100;
int meanLength = 50;
int meanFactor = 3;
float[] depthLookUp = new float[2048];

int deg = 10;

int kinectSize = 307200;
int kinectWidth = 640;
int kinectHeight = 480;

int[] depth = new int[kinectSize];
int[] meanDepth = new int[kinectSize];
float[] stndDepth = new float[kinectSize];

int minThreshold = 5;
int maxThreshold = 200;
int speed = 5;

PVector max = new PVector();

boolean initState = false;

void setup()
{
  size(640, 480, P3D);
  kinect = new Kinect(this);
  kinect.start();

  kinect.enableDepth(true);
  for (int i = 0; i < depthLookUp.length; i++)
  {
    depthLookUp[i] = rawDepthToMeters(i);
  }
}

void draw()
{
  background(255);

  if (initState == false)
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

    for (int j = 0; j < meanFactor * meanLength; j++)
    {
      depth = kinect.getRawDepth();
      for (int i = 0; i < kinectSize; i++)
      {
        stndDepth[i] = sqrt((stndDepth[i] * (meanLength - 1) + pow(depth[i] - meanDepth[i], 2))/meanLength);
      }
      println(str(j));
    }
    initState = true;
  }

  int[] flipedDepth = kinect.getRawDepth();
  for (int i = 0; i < kinectSize; i++)
  {
    depth[(kinectWidth-1-(i % kinectWidth)) + (i / kinectWidth) * kinectWidth] = flipedDepth[i];
  }

  int[] topArray = new int[meanSize];
  int[] topIndex = new int[meanSize];

  PVector maxPos = new PVector ();
  top(depth, topArray, topIndex);
  maxPos = meanPos(topIndex, kinectWidth);

  double speed = 5;

  if (abs(maxPos.x - max.x) > minThreshold)
  {
    max.x += ((maxPos.x - max.x)/speed);
  }

  if (abs(maxPos.y - max.y) > minThreshold)
  {
    max.y += ((maxPos.y - max.y)/speed);
  }

  showDepth();
  
  fill(255, 0, 0);
  noStroke();
  ellipse(max.x, max.y, 20, 20);
}

void showDepth()
{
  pushMatrix();
  scale(-1, 1);
  image(kinect.getDepthImage(), -kinectWidth, 0);
  popMatrix();
}

float rawDepthToMeters(int depthValue) {
  if (depthValue < 2048) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}

void top (int[] inData, int[] topArray, int[] topIndex) {
  int[] array = inData;
  for (int j = 0; j < topArray.length; j++)
  {
    int min , max;
    min = 1000;
    max = 0;
    for (int i = 0; i < array.length; i++)
    {
      if (array[i] < min)
      {
        min = array[i]; 
        topArray[j] = array[i]; 
        topIndex[j] = i;
      }
      if (array[i] > max)
      {
        max = array[i];
      }
    }
    array[topIndex[j]] = max;
  }
}

PVector meanPos (int[] topIndex, int w)
{
  PVector meanPos = new PVector ();
  int sumX = 0;
  int sumY = 0;
  for (int i = 0; i < topIndex.length; i++)
  {
    sumX += topIndex[i] % w;
    sumY += topIndex[i] / w;
  }
  meanPos.x = sumX / topIndex.length;
  meanPos.y = sumY / topIndex.length;
  
  return meanPos;
}
