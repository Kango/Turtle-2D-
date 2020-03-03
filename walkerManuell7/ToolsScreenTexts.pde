

// Minor functions 

void showHelpText() {

  // help text 

  if (showHelp) {
    strokeWeight(1); 
    // help text
    fill(0); 
    text(helpTextShort, 
      117, 27);
    statusBar("Turtle commands: "
      +turtleCommandString
      +" (Backspace to undo last step(s))");

    // Text for pen up yes / no:  
    text(penUpText(), 
      width-144, 17);

    // Text for Turtle color
    fill(colorTurtle); 
    text("Turtle color", 
      width-144, 17*2);

    // Text for Turtle Stroke Weight  
    fill(0);   
    text("Stroke Weight: "+strokeWeightTurtle, 
      width-144, 17*3);
    text("Line segment: "+lineSegment, 
      width-144, 17*4);
    text("Angle: "+nfs( degrees(angleCtl), 1, 2), 
      width-144, 17*5);

    // Yellow box on the side 
    helpTextSide(helpTextShort.replace( ". ", ".\n"));
  }//if
}

void statusBar(String statusBarText) {
  // footer 
  fill(77);
  noStroke();
  rect(0, height-20, 
    width, 22);

  fill(WHITE);
  text(statusBarText, 
    15, height-5);
}

void helpTextSide(String helpText) {

  // yellow box with help text on the right side

  final float heightY=263;
  fill(YELLOW); 
  stroke(BLACK); 
  rect(width-210, 110, 
    200, heightY); 
  noFill(); 
  int innerFrameDistance=3; 
  rect(width-210+innerFrameDistance, 110+innerFrameDistance, 
    200-2*innerFrameDistance, heightY-2*innerFrameDistance);

  fill(BLACK);
  text(helpText, 
    width-200, 130, 
    180, 300);

  // reset
  fill(WHITE);
}

void helpTextPos(String helpText, 
  float x_, float y_) {

  // text at position (here used for the Turtle position) 

  // yellow box with help text on the right side 
  final float heightY=93;
  fill(YELLOW); 
  stroke(BLACK); 
  rect(x_, y_, 
    230, heightY); 

  noFill(); 
  int innerFrameDistance=3; 
  rect(x_+innerFrameDistance, y_+innerFrameDistance, 
    230-(2*innerFrameDistance), heightY-(2*innerFrameDistance));

  fill(BLACK);
  text(helpText, 
    x_+11, y_+23);

  // reset
  fill(WHITE);
}
//
