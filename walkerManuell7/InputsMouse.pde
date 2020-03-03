

void mousePressed() {

  switch(state) {

  case NORMAL_STATE: 
    // 
    // the menu
    if (mouseButton==LEFT) {
      int menuReturn = menu.checkMouseOnMenu(); 
      doCommand(menuReturn);
    } //if
    break; 

  case HELP_STATE:
    state = NORMAL_STATE;
    break;

  case SPLASH_SCREEN_STATE:
    state = NORMAL_STATE;
    break; 

  default:
    // Error
    println("unknown state in mousePressed() ");
    // exit(); 
    break;
    //
  }//switch
  //
}
