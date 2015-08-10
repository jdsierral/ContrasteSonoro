import org.openkinect.*;
import org.openkinect.processing.tests.*;
import org.openkinect.processing.*;


Kinect kinect;

int meanSize = 100; 
int meanLength = 50;
float[] depthLookUp = new float[2048];

int deg = 15;
int kinectSize = 307200;  //640 x 480
int kinectWidth = 640;
int kinectHeight = 480;

int[] depth = new int[kinectSize];
int[] meanDepth = new int[kinectSize];
float[] stndDepth = new float[kinectSize];
//int maxIndex;

int minThreshold = 5;
int maxThreshold = 200;
int speed = 5;
PVector max = new PVector ();
boolean initState = false;

PVector kinectPos1 = new PVector ();
PVector kinectPos2 = new PVector ();

void setup()
{
  size(640, 480);
  kinect = new Kinect (this);
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
    for (int j = 0; j < 100; j++)
    {
      depth = kinect.getRawDepth();
      for (int i = 0; i < kinectSize; i++)
      {
        meanDepth[i] = (meanDepth[i] * (meanLength - 1) + depth[i])/meanLength;
        stndDepth[i] = 0;
      }
      println(str(j));
    }

    for (int j = 0; j < 100; j++)
    {
      depth = kinect.getRawDepth();
      for (int i = 0; i < kinectSize; i++)
      {
        stndDepth[i] = sqrt((stndDepth[i] * (meanLength - 1) + pow(depth[i] - meanDepth[i], 2))/meanLength);
      }
      println(str(j));
//      lowRes(stndDepth, width, height, meanSize);
    }
    initState = true;
  }
  
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
  //functions to void jittery signal
  maxLerpedPos.x = smooth(maxLerpedPos.x, maxPos.x, speed, minThreshold, maxThreshold);
  maxLerpedPos.y = smooth(maxLerpedPos.y, maxPox.y, speed, minThreshold, maxThreshold);
  
  showDepth();

  fill(255, 255, 0);
  ellipse(maxPos.x, maxPos.y, 20, 20);

  


  fill(255, 0, 0);
  noStroke(); 
  ellipse(mouseX, mouseY, 20, 20);
}

void keyPressed()
{
  switch (key)
  {
  case RETURN :
    if (keyEvent.isMetaDown())
    {
      initState = true;
      println("Calibrating... Set Appart and wait please");
    }
    break;
  case CODED  :
    switch (keyCode)
    {
    case UP :
      deg++;
      break;
    case DOWN :
      deg--;
      break;
    }
    kinect.tilt(deg);
    break;
  }
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


//=====================================================================================

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

void lowRes (float [] array, int width_, int height_, int meanSize)
{
  for (int i = 0; i < array.length; i++)
  {
    if ( (i % width_) % meanSize == 0 && (i / width_) % meanSize == 0)
    {
      for (int m = 0; m < meanSize; m++)
      {
        for (int n = 0; n < meanSize; n++)
        {
          array[i] += array[m + i + n * width_];
        }
      }
      array[i] = array[i] / (meanSize * meanSize);
    } else if (i/ width_ % meanSize == 0) {
      array[i] = array[(i/meanSize * meanSize)];
    } else { 
      array[i] = array[i-width_];
    }
  }
}

void showDepth()
{  
  PImage img = kinect.getDepthImage();
  pushMatrix();
  scale(-1, 1);
  image(kinect.getDepthImage(), -kinectWidth, 0);
  popMatrix();
}

int smooth(int max, int max_, int speed, int minThreshold, int maxThreshold)
{
  if (abs(max_ - max) > minThreshold && abs(max_ - max) < maxThreshold)
  {
    max = max + ((max_ - max)/speed);
  } else if (abs(max_ - max) >= maxThreshold)
  {
    max = max_;
  }
  return max;
}

int smooth(int max, int max_, int speed, int minThreshold)
{
  if (abs(max_ - max) > minThreshold)
  {
    max = max + ((max_ - max)/speed);
  }
  return max;
}

