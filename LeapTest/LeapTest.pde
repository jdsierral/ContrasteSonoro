import de.voidplus.leapmotion.*;
import development.*;

LeapMotion leap;

PVector pos, dyn, vel;
boolean isLeft;
float apperture;
int fps;




void setup() {
  size(640, 480, P3D);
  background(255);

  leap = new LeapMotion(this);

  pos = new PVector (0, 0, 0);
  dyn = new PVector (0, 0, 0);
  apperture = 0;
}

void draw() {
  background(255);

  fps = leap.getFrameRate();

  for (Hand hand : leap.getHands ()) {
    pos = hand.getPosition();
    pos.z = 100 - pos.z;
    dyn = hand.getDynamics();
    apperture = hand.getGrabStrength();
  }

  fill(0);
  text("(" + pos.x + ", " + pos.y + ", " + pos.z + ")", 20, 20);
  text("(" + dyn.x + ", " + dyn.y + ", " + dyn.z + ")", 20, 40);
  text("(" + apperture + ")", 20, 60);
  
  fill(100);
  translate(pos.x, pos.y);
  rotateX(-radians(dyn.x));
  rotateZ( radians(dyn.y));
  rotateY(-radians(dyn.z));
  box(pos.z, pos.z, 2 * pos.z);
  
}




