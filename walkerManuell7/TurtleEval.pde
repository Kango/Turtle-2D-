

// evaluate the recorded String turtleCommandString with the Turtle Commands

void evaluateInputs() {

  // eval the recorded String turtleCommandString with the Turtle Commands

  // When there hasn't been any command yet
  if (noCommandGiven)
    return; // leave 

  for (int i=0; i < turtleCommandString.length(); i++) {
    // println (turtleCommandString.charAt(i));

    /*
    // When we would not use the Turtle draw color: 
     // the line color is set between black and red
     float amtValue = map( i, 
     0, turtleCommandString.length(), 
     0, 1); 
     stroke(lerpColor(BLACK, RED, amtValue));
     */

    switch (turtleCommandString.charAt(i)) {
      //
    case 'w':
      tLine(lineSegment);
      break;

    case 's':
      tLine(-lineSegment);
      break; 

    case 'a':
      rotate(-HALF_PI);
      angleCtl+=-HALF_PI; 
      tLine(lineSegment);
      break;

    case 'd':
      rotate(HALF_PI);
      angleCtl+=HALF_PI; 
      tLine(lineSegment);
      break;

      // ------------------------------

    case 'A':
      rotate(-HALF_PI);
      angleCtl+=-HALF_PI; 
      break;

    case 'D':
      rotate(HALF_PI);
      angleCtl+=HALF_PI; 
      break;

      // ------------------------------

    case ',':
      lineSegment--;
      break;

    case '.':
      lineSegment++;
      break;

      // ------------------------------

    case 'p':
      penUp = !penUp; 
      break;

      // colors -------

    case 'r':
      stroke(RED); 
      colorTurtle = RED; 
      break; 

    case 'g':
      stroke(GREEN);
      colorTurtle = GREEN; 
      break; 

    case 'b':
      stroke(BLUE); 
      colorTurtle = BLUE; 
      break;

    case 'v':
      stroke(BLACK); 
      colorTurtle = BLACK; 
      break; 

    case 'n':
      stroke(WHITE); 
      colorTurtle = WHITE; 
      break;

      //-------------------

    case '+':
      strokeWeightTurtle++;
      strokeWeight(strokeWeightTurtle); 
      break; 

    case '-':
      strokeWeightTurtle--;
      if (strokeWeightTurtle<0)
        strokeWeightTurtle=0; 
      strokeWeight(strokeWeightTurtle); 
      break;

      //-------------------

    case 'O':
      rotate(-TWO_PI/360.0);
      angleCtl+=-TWO_PI/360.0; 
      break;

    case 'P':
      rotate(TWO_PI/360.0);
      angleCtl+=TWO_PI/360.0;
      break;

      //-------------------

    default:
      //Error (a key has been added in keyPressed() that has not been evaluated here)
      println("Error 1492: Unknown command "
        + turtleCommandString.charAt(i) 
        + " at position " 
        + i 
        + ".");
      break;
      //
    }//switch
    //
  }//for
}//func 
//
