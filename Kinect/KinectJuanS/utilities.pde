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

//Spatial Averaging

void lowRes (int [] array, int width_, int height_, int meanSize)
{
  for (int i = 0; i < array.length; i++)
  {
    if ( (i % width_) % meanSize == 0 && (i / width_) % meanSize == 0)
    {
      for(int m = 0; m < meanSize; m++)
      {
        for(int n = 0; n < meanSize; n++)
        {
          array[i] += array[m + i + n * width_]; 
        }
      }
      array[i] = array[i] / (meanSize * meanSize);
    } else if (i/ width_ % meanSize == 0){
      array[i] = array[(i/meanSize * meanSize)];
    } else { 
      array[i] = array[i-width_];
    }
  }
}


void meanSpaceVal(int[] input, int[] output, int width_, int height_, int meanSize)
{
  if (width_ % meanSize == 0 && height_ % meanSize == 0)
  { 
    int inputSize = width_ * height_;
    for (int i = 0; i < inputSize; i += meanSize)
    {
      if ((i / width_) % meanSize == 0)
      {
        for (int m = 0; m < meanSize; m++)
        {
          for (int n = 0; n < meanSize; n++)
          {
            if (((i % width_)/meanSize) * ((i/width_)/meanSize) < (inputSize /(meanSize * meanSize))
              && (i + m * meanSize + n * width_) < inputSize)
            {  
              output[i + m * meanSize + n * width_] += input[i + m * meanSize + n * width_]/meanSize;
            }
          }
        }
      } else {
        i += width_;
      }
    }
  }
}

