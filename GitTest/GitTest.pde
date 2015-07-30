PVector pos; 
PVector vel;
PVector dir;

void setup() {
  background(255);
  size (640, 480);
  pos = new PVector (0, 0);
  vel = new PVector (0, 0);
  dir = new PVector (1, 1);
}
s
void draw() {
  background(255);

  vel.x = dir.x * mouseX/100;
  vel.y = dir.y * mouseY/100;

  if (pos.x >= width || pos.x <= 0)
  {
    dir.x = dir.x * -1;
  }

  if (pos.y >= height || pos.y <= 0)
  {
    dir.y = dir.y * -1;
  }

  pos.x += vel.x;
  pos.y += vel.y;
  
  fill (0);
  ellipse(pos.x, pos.y, 20, 20);
}

