

// These functions are called from draw() 

void drawForStateNORMAL_STATE() {

  // clear all
  background(111); 

  // Menu
  if (showHelp) {
    menu.display();
  }

  // Help text and text for penUp
  showHelpText();

  // Init Turtle (reset a few parameters) (undo stuff that in last execution has been changed, like color or strokeWeight)
  translate((width/2) + posCanvasX, (height/2) + posCanvasY); 
  rotate(-HALF_PI);
  penUp=false;
  colorTurtle = WHITE; // reset initial color - see Help
  stroke(colorTurtle);
  strokeWeightTurtle=1;  // reset 
  strokeWeight(strokeWeightTurtle); 
  lineSegment = INITIAL_lineSegment;    //length of line segment
  angleCtl=0;

  // Eval Input String
  evaluateInputs();

  // draw Turtle 
  drawTurtle();
}

void drawForStateHELP_STATE() {
  // clear all
  background(0);
  // show text 
  fill(255);
  text(helpTextLong, 
    17, 17);
}

void drawForStateSPLASH_SCREEN_STATE() {
  // yellow box 

  final int widthBox=800; 
  final float heightY=363;

  fill(YELLOW); 
  stroke(BLACK); 
  rect(width/2-widthBox/2, 110, 
    widthBox, heightY); 
  noFill(); 
  int innerFrameDistance=3; 
  rect(width/2-widthBox/2 +innerFrameDistance, 110+innerFrameDistance, 
    widthBox    -2*innerFrameDistance, heightY-2*innerFrameDistance);

  fill(BLACK);
  textSize(60); 
  text("Turtle Draw Program", 
    width/2-widthBox/2 + 9, 290);
  textSize(33);
  text("Use wasd keys, use the menu.\n"
    +"Press any key.", 
    width/2-widthBox/2 + 39, 373);

  // reset
  fill(WHITE);
  textSize(12);

  // Status Bar (bottom of the screen)
  statusBar("Press any key");
}
//
