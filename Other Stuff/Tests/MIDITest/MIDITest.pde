import themidibus.*;

MidiBus midi;

int frac = 640/12;
int X, Y; 
int note, velocity; 

void setup()
{
  size(640, 480);

  //  MidiBus.list(); //Enable to check MIDI Devices Numbers

  midi = new MidiBus(this, 0, 1);
}

void draw()
{
  background(255);
  for (int i = 1; i < 12; i++)
  {
    fill(0);
    line(frac * i, 0, frac * i, height);
  }

  ellipse(mouseX, mouseY, 20, 20);
}

void mouseMoved()
{
  X = int(map(mouseX, 0, width, 0, 127));
  Y = int(map(mouseY, 0, height, 0, 127));

  midi.sendControllerChange(0, 10, X);
}

void mousePressed()
{
  note = int(map(mouseX, 0, width, 60, 72));
  velocity = int(map(mouseY, 0, height, 0, 127)); 
  
  midi.sendNoteOn(0, note, velocity);
}

void mouseReleased()
{
  midi.sendNoteOff(0, note, velocity);
}

