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
// la siguiente funcion buscará el valor más alto dentro de un vector y determinará
// su índice y posición dentro del vector así como el valor al cual corresponde 
// dicho índice.
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
// La siguiente función determinará la posición (x,y) dentro de arreglo bidimensional 
// del índice entregado inicialmente al ser descrito dentro de un arreglo unidimensional
// el siguiente valor entregado, w, hace referencia a la anchura del arreglo bidimensional
// del cual se quiere hacer uso.
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
// La siguiente función permite hacer una conversión entre los datos entregados por el
// Kinect y la distancia en metros exacta a la cual corresponden dichos datos.
// se basa únicamente en un LUT (Look Up Table) el cual entrega para cada valor posible
// para el Kinect una distancia en metros.
float rawDepthToMeters(int depthValue) {
  if (depthValue < 2048) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}