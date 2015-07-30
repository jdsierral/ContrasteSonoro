void leapAnalisis()
{
  for (Hand hand : leap.getHands ()) {
    if (hand.isLeft())
    {
      if (stabilization)
      {
        leapPosL1 = hand.getStabilizedPosition();
      } else {
        leapPosL1 = hand.getPosition();
      }
      leapDynL1 = hand.getDynamics();
      leapGrabL1 = hand.getSphereRadius();
    } 
    if (hand.isRight())
    {
      if (stabilization)
      {
        leapPosR1 = hand.getStabilizedPosition();
      } else {
        leapPosR1 = hand.getPosition();
      }
      leapDynR1 = hand.getDynamics();
      leapGrabR1 = hand.getSphereRadius();
    }
  }
}
