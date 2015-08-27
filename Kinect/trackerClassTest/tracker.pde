class KinectDepthTracker {
  int kw = 640;
  int kh = 480;
  int kinectSize = 640 * 480;

  boolean initState;
  int kinectFrame;

  PVector pos;
  int[] depth = new int[kw * kh];
  int[] meanDepth = new int[kw * kh];
  float[] stndDepth = new float[kw * kh];

  float accuracy; 

  PImage img;

  /**
   *  Iniitializer
   */

  KinectDepthTracker() {
    kinect.start();
    pos = new PVector (kw/2, kh/2, 0);
    initState = false;
    accuracy = 15;
    kinectFrame = 0;
  }


// SETTERS


  void setCalibration(boolean cal) {
    initState = cal;
  }

  void setAccuracy(float acc) {
    accuracy = acc;
  }
  
// GETTERS

  boolean getCalibration() {
    return initState;
  }

  float getAccuracy() {
    return accuracy;
  }

  PVector getPos () {
    PVector invPos = new PVector ();
    invPos.x = 640 - pos.x;
    invPos.y = pos.y;
    invPos.z = pos.z;    
    return invPos;
  }

  /**
   *  Function called for calibrating background extraction
   *  for tracker to track movable objects only
   */

  void calibrate(int meanLength, int meanFactor) {
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
    setCalibration(true);
    println("done Calibrating backgroudn extraction");
  }

  void track(int meanSize, int threshold, int stiffness) {
    depth = kinect.getRawDepth();

    for (int i = 0; i < kinectSize; i++)
    {
      if (abs(depth[i] - meanDepth[i]) <= getAccuracy() * stndDepth[i])
      {
        depth[i] = 2048;
      }
    }

    int[] topArray = new int[meanSize];
    int[] topIndex = new int[meanSize];

    PVector maxPos = new PVector();

    top(depth, topArray, topIndex);
    maxPos = meanPos(topIndex, kw);

    if (abs(pos.x - maxPos.x) > threshold)
    {
      pos.x += ((maxPos.x - pos.x)/stiffness);
    }

    if (abs(pos.y - maxPos.y) > threshold)
    {
      pos.y += ((maxPos.y - pos.y)/stiffness);
    }

    pos.z = topArray[0];
  }

  void showDepth() { 
    pushMatrix();
    scale(-1, 1);
    translate(-kw, 0); 
    switch (kinectFrame)
    {
    case 0  :
      image (kinect.getDepthImage(), 0, 0);
      break;
    case 1  :
      PImage img1 = createImage(kw, kh, RGB);
      img1.loadPixels();
      for (int i = 0; i < kinectSize; i++)
      {
        img1.pixels[i] = color((int)map(depth[i], 0, 2048, 255, 0));
      }
      img1.updatePixels();
      image(img1, 0, 0);
      break;
    case 2  :
      PImage img2 = createImage(kw, kh, RGB);
      img2.loadPixels();
      for (int i = 0; i < kinectSize; i++)
      {
        img2.pixels[i] = color((int)map(meanDepth[i], 0, 2048, 255, 0));
      }
      img2.updatePixels();
      image(img2, 0, 0);
      break;
    case 3  :
      PImage img3 = createImage(kw, kh, RGB);
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


  //=========================================================================//
  ////////////////////////////////PRIVATE METHODS//////////////////////////////
  //=========================================================================//

  private void top (int[] inData, int[] topArray, int[] topIndex) {
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

  private PVector meanPos (int[] topIndex, int w) {
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
}

