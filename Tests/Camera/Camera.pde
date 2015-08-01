import processing.video.*;

int numPixels;
int[] lastFrame;

Capture cam;

void setup() {
  size(640, 480);
  //  frameRate(30);
  String[] cameras = Capture.list();
  for (int i = 0; i < cameras.length; i++) {
  }
  cam = new Capture(this, width, height);
  cam.start();
  numPixels = cam.width * cam.height;

  lastFrame = new int[numPixels];
  loadPixels();
}

//=================================================================

void draw() {
  if (cam.available())
  {
    cam.read();
    cam.loadPixels();
  
    int moveSum = 0;
    
    for (int i = 0; i < numPixels; i++)
    {
      color currColor = cam.pixels[i];
      color prevColor = lastFrame[i];
      
      int currR = (currColor >> 16) & 0xFF;
      int currG = (currColor >> 8 ) & 0xFF;
      int currB = (currColor ) & 0xFF;
      
      int lastR = (prevColor >> 16) & 0xFF;
      int lastG = (prevColor >> 8 ) & 0xFF;
      int lastB = prevColor & 0xFF;
      
      int diffR = abs(currR - lastR);
      int diffG = abs(currG - lastG);
      int diffB = abs(currB - lastB);
      
      moveSum += diffR + diffG + diffB;
      
      pixels [i] = 0xFF000000 | (diffR << 16) | (diffG << 8) | diffB;
      
      lastFrame[i] = currColor;
    }
    
    if (moveSum > 0)
    {
      updatePixels();
    }
  }
}

