import org.openkinect.*;
import org.openkinect.processing.tests.*;
import org.openkinect.processing.*;

Kinect kinect;

PVector pos = new PVector();

void setup () {
  size (640, 480);
  kinect = new Kinect(this);
  kinect.start();
}

void draw() {
  background(255);

  int w = 640;
  int h = 480;
  int threshold = 450;
  int [] depth;
  PImage display;

  kinect.enableDepth(true);
  display = createImage(w, h, RGB);
  depth = kinect.getRawDepth();

  float sumX = 0;
  float sumY = 0;
  float count = 0;
  PImage img = kinect.getDepthImage();

  display.loadPixels();
  for (int x = 0; x < w; x++)
  {
    for (int y = 0; y < h; y++)
    {
      int offset = w-x-1+y*w;
      int rawDepth = depth[offset];

      int pix = x+y*display.width;
      if (rawDepth < threshold)
      {
        display.pixels[pix] = color(150, 50, 50);
        sumX += x;
        sumY += y;
        count++;
      } else {
        display.pixels[pix] = img.pixels[offset];
      }
    }
    display.updatePixels();

    pos = new PVector (sumX/count, sumY/count);
  }

  image(display, 0, 0);
  fill(50, 100, 250, 200);
  noStroke();
  ellipse(pos.x, pos.y, 20, 20);
}

void stop() {
  super.stop();
}

