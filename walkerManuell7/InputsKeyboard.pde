
// Inputs 

void keyPressed() {

  switch(state) {

  case NORMAL_STATE: 
    keyPressedForStateNORMAL_STATE();   
    break; 

  case HELP_STATE:
    keyPressedForStateHELP_STATE(); 
    break;

  case SPLASH_SCREEN_STATE:
    key=0; 
    state = NORMAL_STATE;
    break; 

  default:
    // Error
    println("unknown state in keyPressed() ");
    exit(); 
    break;
    //
  }//switch
  //
}//func 

// -----------------------------------------------
// These functions are called from keyPressed() 

void keyPressedForStateHELP_STATE() {
  // Esc
  if (key==ESC) {
    key=0; 
    state = NORMAL_STATE;
  }//if
}//func 

void keyPressedForStateNORMAL_STATE() {
  // Many keys 

  // CODED? 
  if (key==CODED) {
    // MOVE canvas 
    switch(keyCode) {
    case UP:
      posCanvasY--; 
      break;
    case DOWN:
      posCanvasY++; 
      break;

    case LEFT:
      posCanvasX--; 
      break;
    case RIGHT:
      posCanvasX++; 
      break;
    }//switch

    // Leave here
    return;
  } // CODED -----------------------------------------------

  // All not coded from here on:  -----------------------------

  // wasd etc. - these get recorded in String turtleCommandString with the Turtle Commands (only recorded, and later executed in evaluateInputs())
  if (key == 'w'|| 
    key == 'a'  ||
    key == 's'  ||
    key == 'd'  ||

    key == 'A' ||
    key == 'D' ||

    key == ',' ||
    key == '.' ||

    key == 'p' ||

    key == 'O' ||
    key == 'P' ||

    key == 'r' ||
    key == 'g' ||
    key == 'b' ||

    key == 'v' ||
    key == 'n' ||

    key == '+' ||
    key == '-' ) {
    // record keys --------------------- 
    // When it's the first time, we kill the default text 
    if (noCommandGiven) {
      turtleCommandString = ""; 
      noCommandGiven      = false;
    }
    turtleCommandString += key;
    //----------------------------------------------------------
  } else if (key==BACKSPACE) {
    // shorten by 1 (undo)
    // When there is no command, we don't delete
    if (noCommandGiven)
      return; 
    if (turtleCommandString.length()>0) {
      turtleCommandString=turtleCommandString.substring(0, turtleCommandString.length()-1);
    }//if

    // When the command String turtleCommandString is empty, we show a help text INITIAL_TEXT_for_turtleCommandString in the Status Bar 
    if (turtleCommandString.length()==0) {
      noCommandGiven      = true;
      turtleCommandString =  INITIAL_TEXT_for_turtleCommandString; // or just = "";
    }//if
  } else if (key=='c') {
    commandNew();
  } else if (key=='l') {
    // print 
    println(turtleCommandString);
  } else if (key==' ') {
    // showHelp 
    showHelp = !showHelp;
  } else if (key=='X') {
    // print and quit
    if (!noCommandGiven)
      println(turtleCommandString);
    exit();
  } else if (key=='x') {
    showHelpAtTurtlePosition = !showHelpAtTurtlePosition;
  } else if (key=='S') {
    save(timeStamp()
      +".jpg");
  } else if (key=='#') {
    visibleTurtle= !visibleTurtle;
  } 
  // ---------
  // Save and Load 
  else if (key=='1') { 
    loadWithInsert = false; 
    loadProgram();
  } else if (key=='2') { 
    // save  
    saveProgram();
  } else if (key=='3') {
    // save as...
    saveProgramAs();
  } else if (key=='4') {
    // load as insert
    loadWithInsert = true; 
    loadProgram();
  } 
  //----------------------
  // Escape  
  else if (key==ESC||key=='h'||key=='H') {
    // Help 
    key=0; // kill Esc
    if (menu.anyIsOpen()) {
      menu.closeAllMenus(); 
      return; // leave
    }
    if (!noCommandGiven)
      println(turtleCommandString);
    state=HELP_STATE;
  } // else if Esc key
  //
}//func
//
