int aSize = 100; 
float[] array = new float[aSize];
float[] dupArray = new float[aSize];
float[] ordArray = new float [aSize];
float[] top10Array = new float [aSize];
int[] top10 = new int [10];
int amount = top10.length;

void setup()
{
  size (1000, 400);
  background(255);
  for (int i = 0; i < array.length; i++)
  {
    array[i] = (int)random(100);
  }
  arrayCopy(array, dupArray);
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
    point(10 * i, dupArray[i]);
    point(10 * i, ordArray[i] + 100);
  }
  //
  for (int j = 0; j < amount; j++)
  {
    float min = 100; 
    for (int i = 0; i < aSize; i++)
    {
      if (array[i] < min)
      {
        min = array[i]; 
        top10Array[j] = array[i]; 
        top10[j] = i;
      }
    }
    array[top10[j]] = 100;
  }
  //


  for (int i = 0; i < amount; i++)
  {
    point(10 * i, top10Array[i] + 200);
  }


  fill (0); 
  text( top10Array[0] + ", " +
    top10[0] +  ", " +
    dupArray[top10[0]] +  ", " +
    ordArray[0], 20, height - 5);
  for (int i = 0; i < amount; i++)
  {
    text((int)ordArray[i] + ", ", 20 + 20 * i, height - 20);
    text((int)top10Array[i] + ", ", 20 + 20 * i, height - 35);
  }
}

