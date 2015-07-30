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
  
  vel.x = mouseX * dir.x;
  vel.y = mouseY * dir.y;

If (pos.x >= width || pos.x <= 0)
{
dir.x = dir.x * -1;
}

f (pos.y >= height || pos.y <= 0)
{
dir.y = dir.y * -1;
}
  
  pos.x += vel.x;
  pos.y += vel.y;
  
}
