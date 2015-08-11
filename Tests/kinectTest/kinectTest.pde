import org.openkinect.*;
import org.openkinect.processing.tests.*;
import org.openkinect.processing.*;

Kinect kinect;

int meanSize = 100;
int meanLength = 50;
int meanFactor = 5; // change later to 3 at least

int deg = 0;
float accuracy = 15;

int kinectSize = 307200;
int kinectWidth = 640;
int kinectHeight = 480;

int[] depth = new int[kinectSize];
int[] meanDepth = new int[kinectSize];
float[] stndDepth = new float[kinectSize];

int threshold = 5;
int stiffness = 2;

PVector max = new PVector();

boolean initState = false;
int kinectFrame = 0;

void setup()
{
  size (640, 480);
  kinect = new Kinect(this);
  kinect.start();

  kinect.enableDepth(true);
  kinect.tilt(deg);
}

void draw()
{
  background(255);

  if (!initState)
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

  if (abs(maxPos.x - max.x) > threshold)
  {
    max.x += ((maxPos.x - max.x)/stiffness);
  }

  if (abs(maxPos.y - max.y) > threshold)
  {
    max.y += ((maxPos.y - max.y)/stiffness);
  }

  showDepth(kinectFrame);

  fill(255, 0, 0);
  noStroke();
  ellipse(max.x, max.y, 20, 20);
}



void showDepth(int kinectFrame)
{
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
}



void keyPressed()
{
  switch (key)
  {
  case ' '  :
    kinectFrame = ++kinectFrame % 4;
    println(kinectFrame);
    break;
  }
}

void top (int[] inData, int[] topArray, int[] topIndex) {
  int[] array = inData;
  for (int j = 0; j < topArray.length; j++)
  {
    int min, max;
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

