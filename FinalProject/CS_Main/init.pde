void initRoutine ()
{
   if (setup[0]==1) {
    netEnabled = true;
  } else {
    netEnabled = false;
  }
  if (setup[1]==1) {
    leapEnabled = true;
  } else {
    leapEnabled = false;
  }
  if (setup[2]==1) {
    kinectEnabled = true;
  } else {
    kinectEnabled = false;
  }
  if (setup[3]==1) {
    dummyDrawEnabled = true;
  } else {
    dummyDrawEnabled = false;
  }
  if (setup[4]==1) {
    refTextEnabled = true;
  } else {
    refTextEnabled = false;
  }
  
  
    textPos = new PVector (20, height - 200);

}
