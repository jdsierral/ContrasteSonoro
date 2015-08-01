//=====================================================================================
/**
 
 
 COMMON FUNCTIONS FOR REGULAR CODE
 
 
 **/
//=====================================================================================
//=====================================================================================

int maxValueIndex (int[] array, int size)
{

  int maxIndex = 0;
  for (int i = 0; i < size; i++) 
  {
    float newnumber = array[i];
    if ((newnumber > array[maxIndex])) 
    {
      maxIndex = i;
    }
  }
  return maxIndex;
}

//================================================================================================

int maxValueIndexWithDiff (int[] array, float[] diff, int size)
{

  int maxIndex = 0;
  for (int i = 0; i < size; i++) 
  {
    if (diff[i] > 1000)
    {
      float newnumber = array[i];
      if ((newnumber > array[maxIndex])) 
      {
        maxIndex = i;
      }
    }
  }
  return maxIndex;
}

//=====================================================================================


int minValueIndex (int[] array, int size)
{

  int maxIndex = 0;
  for (int i = 0; i < size; i++) 
  {
    float newnumber = array[i];
    if ((newnumber < array[maxIndex])) 
    {
      maxIndex = i;
    }
  }
  return maxIndex;
}

//=====================================================================================

int maxBrightnessIndex (int[] array, int size)
{

  int maxIndex = 0;
  for (int i = 0; i < size; i++) 
  {
    float newnumber = brightness(array[i]);
    if ((newnumber < brightness(array[maxIndex]))) 
    {
      maxIndex = i;
    }
  }
  return maxIndex;
}

//=====================================================================================
//=====================================================================================


float rawDepthToMeters(int depthValue) {
  if (depthValue < 2048) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}


//=====================================================================================
//=====================================================================================


int getX (int value, int widthValue)
{
  return maxIndex % widthValue;
}

//=====================================================================================


int getY (int value, int widthValue)
{
  return maxIndex / widthValue;
}

//=====================================================================================
//=====================================================================================

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

//=====================================================================================

int smooth(int max, int max_, int speed, int minThreshold)
{
  if (abs(max_ - max) > minThreshold)
  {
    max = max + ((max_ - max)/speed);
  }
  return max;
}

//=====================================================================================
//=====================================================================================

