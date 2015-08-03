void refTextRoutine()
{
  fill(100);
  if (leapEnabled)
  {
    text(leapText(info), textPos.x, textPos.y);
  }
  if (kinectEnabled)
  {
    text(kinectText(info), textPos.x + width/2, textPos.y);
  }
  if (netEnabled)
  {
    text(myIP + ", " + myPort, 50, 50);
  }
}


String leapText (int amount)
{
  int fps = leap.getFrameRate();
  String ref = "";

  if (amount >= 0)
  {
    ref = 
      "LeapPosL1 = " + "("  + str((int)leapPosL1.x) 
      + ", " + str((int)leapPosL1.y) 
        + ", " + str((int)leapPosL1.z) + ")\n" +
          "LeapPosR1 = " + "("  + str((int)leapPosR1.x) 
          + ", " + str((int)leapPosR1.y) 
            + ", " + str((int)leapPosR1.z) + ")\n" +
              "LeapDynL1 = " + "("  + str((int)leapDynL1.x) 
              + ", " + str((int)leapDynL1.y) 
                + ", " + str((int)leapDynL1.z) + ")\n" +
                  "LeapDynR1 = " + "("  + str((int)leapDynR1.x) 
                  + ", " + str((int)leapDynR1.y) 
                    + ", " + str((int)leapDynR1.z) + ")\n" +
                      "LeapGrabL1 = " + str((int)leapGrabL1) + "\n" +
                      "LeapGrabR1 = " + str((int)leapGrabR1) + "\n" + 

                      "LeapPosL2 = " + "("  + str((int)leapPosL2.x) 
                      + ", " + str((int)leapPosL2.y) 
                        + ", " + str((int)leapPosL2.z) + ")\n" +
                          "LeapPosR2 = " + "("  + str((int)leapPosR2.x) 
                          + ", " + str((int)leapPosR2.y) 
                            + ", " + str((int)leapPosR2.z) + ")\n" +
                              "LeapDynL2 = " + "("  + str((int)leapDynL2.x) 
                              + ", " + str((int)leapDynL2.y) 
                                + ", " + str((int)leapDynL2.z) + ")\n" +
                                  "LeapDynL2 = " + "("  + str((int)leapDynR2.x) 
                                  + ", " + str((int)leapDynR2.y) 
                                    + ", " + str((int)leapDynR2.z) + ")\n" + 
                                      "LeapGrabL2 = " + str((int)leapGrabL2) + "\n" +
                                      "LeapGrabR2 = " + str((int)leapGrabR2) + "\n"               

                                      ;
  }
  if (amount >= 1)
  {
    ref = ref +  
      "fps = " + str(fps) + "\n";
  } 
  return ref;
}


//=========================================================================//


String kinectText (int amount)
{
  String ref = "";

  if (amount >= 0)
  {
    ref = 
      "kinectPos1 = " + "("  + kinectPos1.x + 
      ", " + kinectPos1.y +
      ", " + kinectPos1.z + ")\n" +
      "kinectPos2 = " + "("  + kinectPos2.x + 
      ", " + kinectPos2.y +
      ", " + kinectPos2.z + ")"

      ;
  }
  if (amount >= 1)
  {
    ref = ref;
  }
  return ref;
} 

