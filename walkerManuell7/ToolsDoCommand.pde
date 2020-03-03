
// Tools for buttons 

void doCommand(int menuReturn) {

  //  statusBarText = statusBarTextDefault;

  switch(menuReturn) {

    // menuReturn is not necessary a button ID
    // but can be Menu.menuReturnIgnore, Menu.menuReturnRadioButton,
    // Menu.menuReturnCheckBox which are all negative.
    // Positive values are IDs and are used for command buttons. 

    //--------------------------
    // step 1 : three negative vars 

  case Menu.menuReturnIgnore:
    //ignore (headlines, errors etc.)
    break; 

  case Menu.menuReturnRadioButton:
    // radio button:
    // to make things easier, we just update all variables (in this case 2) that are connected to radio buttons / groups.
    // Programmer using the lib needs to know which int switch is connected to which group of radio buttons
    //mode     = menu.getValueFromGroup( "Modes_Group" );
    //viewMode = menu.getValueFromGroup( "Views_Group" ); 
    break; 

  case Menu.menuReturnCheckBox:
    // Check Box Button:
    // to make things easier, we just update all variables (in this case 1) that are connected to check box buttons.
    // you need to know IDs of buttons.
    // cam view ON/OFF     
    //boolTest = menu.buttons[13].isActive;
    break; 

    // -------------------------------------------
    // step 2 : just IDs of buttons for command buttons  

  case 1:
    // new / delete 
    commandNew();
    menu.closeAllMenus();
    break;

  case 2:
    // Open 
    loadWithInsert = false;
    menu.closeAllMenus();
    loadProgram();    
    break;

  case 3: 
    // save  
    menu.closeAllMenus();
    if (noCommandGiven && turtleCommandString.equals(INITIAL_TEXT_for_turtleCommandString)) {
      turtleCommandString=""; // delete
    }
    saveProgram();
    break; 

  case 4:
    // save as...
    menu.closeAllMenus();
    if (noCommandGiven && turtleCommandString.equals(INITIAL_TEXT_for_turtleCommandString)) {
      turtleCommandString=""; // delete
    }
    saveProgramAs();
    break;  

  case 5:
    // load as insert
    menu.closeAllMenus();
    loadWithInsert = true; 
    if (noCommandGiven && turtleCommandString.equals(INITIAL_TEXT_for_turtleCommandString)) {
      turtleCommandString=""; // delete
    }
    loadProgram();
    break; 

  case 6: 
    //Help
    menu.closeAllMenus();
    state = HELP_STATE; 
    break;

  case 7:
    // print and quit
    menu.closeAllMenus();
    if (!noCommandGiven) {
      println(turtleCommandString);
    }  
    exit();
    break; 

  default:
    // Error situation - doesn't need to be changed by user of library 
    // statusBarText="Error";
    println ("Error 170 : in doCommand: "
      +menuReturn); 
    exit();
    return; // leave here
  }//switch
}//func 
//
void commandNew() {
  // clear
  if (!noCommandGiven)
    println(turtleCommandString); 
  turtleCommandString =  INITIAL_TEXT_for_turtleCommandString; // or just = ""; 
  noCommandGiven      = true;
}
