//=====================================================================================
/*
/*
/*                      COMMON FUNCTIONS FOR REGULAR CODE
/* 
/* 
/*                               Coded by JuanS 
/* 
/* 
 */
//=====================================================================================
//=====================================================================================
//=====================================================================================

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

//=====================================================================================

float rawDepthToMeters(int depthValue) {
  if (depthValue < 2048) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}

//=====================================================================================
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

void lowRes (int [] array, int width_, int height_, int meanSize)
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
//=====================================================================================
//=====================================================================================
/*



int maxValueIndexSpaced (int[] array, int size, int space)
{

  int maxIndex = 0;
  for (int i = 0; i < size; i += space) 
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

int maxValueIndexWithDiff (int[] array, int [] diff, int size)
{

  int maxIndex = 0;
  for (int i = 0; i < size; i++) 
  {
    if (diff[i] > 0)
    {
      float newnumber = array[i];
      if ((newnumber < array[maxIndex])) 
      {
        maxIndex = i;
      }
    }
  }
  return maxIndex;
}
//=====================================================================================

int maxValueIndexWithStnd (int[] input, int[] mean, float[] stnd, int size)
{

  int maxIndex = 0;
  for (int i = 0; i < size; i++) 
  {
    if (abs(input[i] - mean[i]) > stnd[i])
    {
      float newnumber = input[i];
      if ((newnumber < input[maxIndex])) 
      {
        maxIndex = i;
      }
    }
  }
  return maxIndex;
}

//=========================================================================================

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
*/
