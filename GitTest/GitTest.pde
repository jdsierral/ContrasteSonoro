PVector pos, vel, dir;

setup()
{
  background(255);
  pos = new PVector (0, 0);
  vel = new PVector (0, 0);
  dir = new PVector (1, 1);
  
  
}

draw()
{
  background(255);
  
  vel.x = mouseX * dir
  
  pos.x += vel.x;
  pos.y += vel.y;
  
}
