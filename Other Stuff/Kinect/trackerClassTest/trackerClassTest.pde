import org.openkinect.*;
import org.openkinect.processing.tests.*;
import org.openkinect.processing.*;

Kinect kinect;
KinectDepthTracker tracker;


int meanLength = 100;
int meanFactor = 3;
int t = 0;

PVector posicion = new PVector();

void setup()
{
  size (640, 480);
  background (0);

  kinect = new Kinect(this);
  tracker = new KinectDepthTracker();
  
  kinect.enableDepth(true);

  kinect.tilt(t);
}

void draw()
{
  background (0);
  tracker.track(100, 10, 2);
  
  tracker.showDepth(); 
  posicion = tracker.getPos();
  
  fill(255);
  noStroke();
  ellipse (posicion.x, posicion.y, posicion.z/100, posicion.z/100);
}

void keyPressed()
{
  if (key == CODED)
  {
    switch(keyCode)
    {
    case UP     :
      t++;
      kinect.tilt(t);
      if (tracker.getCalibration()) 
      {
        tracker.setCalibration(false);
        println("Needs Calibration");
      }
      break;
    case DOWN    :
      t--;
      kinect.tilt(t);
      if (tracker.getCalibration()) 
      {
        tracker.setCalibration(false);
        println("Needs Calibration");
      }
      break;
    case RIGHT  :
      tracker.calibrate(meanLength, meanFactor);
      break;
    case LEFT  :
      if (tracker.getCalibration())
      {
        println("Is Calibrated");
      } else {
        println("Needs Calibration");
      }
      break;
    default  :
      break;
    }
  }
}

