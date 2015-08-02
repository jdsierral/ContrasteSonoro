int aSize = 100; 
float[] array = new float[aSize];
float[] ordArray = new float [aSize];
float[] top10Array = new float [aSize];
int[] top10 = new int [10];

void setup()
{
  size (1000, 300);
  background(255);
  for (int i = 0; i < array.length; i++)
  {
    array[i] = (int)random(100);
  }
  stroke(200);
  line(0, 100, 1000, 100);
  noLoop();
}

void draw()
{
  ordArray = sort(array);
  stroke(0);
  for (int i = 0; i < array.length; i++)
  {
    point(10 * i, array[i]);
    point(10 * i, ordArray[i] + 100);
  }
  float min = 100;
  for (int i = 0; i < aSize; i++)
  {
    if (array[i] < min)
    {
      min = array[i];
      top10Array[0] = array[i];
      top10[0] = i;
    }
  }
  fill (0);
  text( top10Array[0] + ", " +
    top10[0] +  ", " +
    array[top10[0]] +  ", " +
    ordArray[0], 20, height - 20);
}

