void keyPressed()
{
  switch (key)
  {
  case '0' : 
    info = ++info % 2; 
    break;
  case '1' :
    netEnabled = !netEnabled;
    if (netEnabled)
    { 
      oscSetup();
    }    
    println("Net: " + netEnabled); 
    break;
  case '2' :
    leapEnabled = !leapEnabled;
    if (leapEnabled)
    {
      leapSetup();
    }
    println("Leap: " + leapEnabled); 
    break;
  case '3' :
    kinectEnabled = !kinectEnabled;
    if (kinectEnabled)
    {
      kinectSetup();
    }
    println("Kinect: " + kinectEnabled); 
    break;
  case '4' :
    dummyDrawEnabled = !dummyDrawEnabled;
    println("Dummy Draw: " + dummyDrawEnabled); 
    break;
  case '5' :
    refTextEnabled = !refTextEnabled;
    println("Ref Text: " + refTextEnabled); 
    break;
  case 'c' :
    initState = false;
    println("Calibrating... Set Appart and wait please");
    break;
  case ' '  :
    kinectFrame = ++kinectFrame % 4;
    println(kinectFrame);
    break;
  case CODED  :
    switch (keyCode)
    {
    case UP :
      deg++;
      if (kinectEnabled)
      {
        kinect.setTilt(deg);
        println("tilt: " + deg);
      }
      break;
    case DOWN :
      deg--;
      if (kinectEnabled)
      {
        kinect.setTilt(deg);
        println("tilt: " + deg);
      }
      break;
    case LEFT  :
      accuracy -= 0.5;
      println("Accuracy: " + accuracy);
      break;
    case RIGHT  :
      accuracy += 0.5;
      println("Accuracy: " + accuracy);
      break;
    }

    break;
  }
}

void mouseWheel(MouseEvent event) {
  if (!kinectEnabled) {
    mousePos.z = constrain(mousePos.z + event.getCount(), 0, 100);
    println(mousePos);
  }
}