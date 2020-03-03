
// Turtle functions 

void tLine(int x) {
  // Depending on penUp
  // we move or draw 
  if (penUp) 
    tStep(x); 
  else 
  tLineDraw(x);
}

void tLineDraw(int x) {
  // draw and move (pen is down, penUp=false)
  line(0, 0, 
    x, 0);
  translate(x, 0);
}

void tStep(int x) {
  // just move (if pen is up, penUp=true) 
  translate(x, 0);
}

// -----------------------------------------------------------------------

void drawTurtle() {
  // show the Turtle itself as a triangle

  // Do we want to draw the Turtle at all?
  if (!visibleTurtle)
    return; // leave here

  noFill(); 
  stroke(colorTurtle); 
  ellipse(-2, 0, 2, 2);
  line(0, -5, 7, 0);
  line(0, 5, 7, 0);
  strokeWeight(1);

  // The variable visibleTurtle must be true and these two variables must be true to show the helpTextPos() at the Turtle 
  if (showHelp) {
    if (showHelpAtTurtlePosition) {

      // text at Turtle position 

      rotate(HALF_PI);
      rotate(-angleCtl); 

      translate(17, 17);

      helpTextPos(
        "The Turtle carries a pen to draw.\n"
        +"You can steer the Turtle \nwith wasd.\n"
        +"Press Esc for help. Close box with x.", 
        0, 0);
    }
  }
}//func 

// -----------------------------------------------------------------------

String penUpText() {
  // Depending on penUp
  if (penUp) 
    return"Turtle only moves.";
  else 
  return"Turtle draws: Pen down.";
  //
}//func
//
