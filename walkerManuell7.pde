


// A String turtleCommandString gets recorded (in keyPressed()) and then evaluated (executed) in evaluateInputs().

// Keys:
//    Escape = HELP - you can see more keys there  
//    Space Bar - hide and show help texts and yellow Textboxes
//    wasd / Backspace / c - Turtle   
//    r g b Colors  - Turtle   
//    v / n colors  - Turtle   
//    many more.... see Help. 

// https://discourse.processing.org/t/drawing-connected-lines-with-keystroke-commands/17947/5
// with help from Jeremy et al., see https://forum.processing.org/two/discussion/20706/how-3d-turtle-like-in-logo-but-3d-math-problem

// To Do / Wishes : 
//    Load and save turtleCommandString
//    Edit command Strings / copy paste
//    3D 
//    Color Selector 
//    change of length of lineSegment 
//    repeat a section of the code for X times (zB > dann weiter wddd und beim nächsten < wird wiederholt)
//    Makro definieren - per Auswahlliste per mouse auswählen 
//    click mouse to let Turtle jump to a spot j(110,50) - so evaluate must involve more parsing - same for color: c(111) or c(255,0,0) 
//    Turtle as a class 
//    angle l/r by 1 degree 
//    Steering by mouse: O 
//    Menü: Save Commands / Color / Save as Image 

// Imports: ---------------------------------------

import java.util.Map;

// Constants: ---------------------------------------

// Text Constants
final String helpTextShort = 
  "Turtle program. Use wasd keys. The movement is always seen relative from the Turtle perspective. "
  + "w is forward, a is left, d is right, s is backward. c is reset. p Pen up/down. Esc for Help.";

final String helpTextLong = 
  "Turtle program. "
  +"\n\nSteer the Turtle that holds a pen to draw on a canvas. \nUse the menu. "
  +"\n\nEscape key brings you this help. You find this help also in the direct window and can copy paste and print from there."
  +"\nX leave program (Shift-x).\n"
  +"Space bar - small texts in the main program on / off."
  +"\n# - show / hide the Turtle itself."
  +"\nx - show / hide the text at the Turtle position."
  +"\nl (L) prints the commands (to copy and paste).\n"
  +"c is reset / delete all (prints and deletes the entire Turtle command String)."
  +"\nBackspace - undo last step(s)"
  +"\nCursor keys - move the entire canvas (useful when the Turtle reached a screen border)"
  +"\n1 - load Turtle Script."
  +"\n2 - save Turtle Script."
  +"\n3 - save as... Turtle Script."
  +"\n4 - Insert Turtle Script (load and insert into existing Turtle Script)"
  +"\nS - save image (shift-s) (with date and time stamp)."

  +"\n\n\n\nThe following keys control the Turtle and get recorded \n"
  +"\n"

  +"Use wasd keys. The movement is always seen relative from the Turtle perspective. w is forward, a is left, d is right, s is backward, seen from the Turtle. "
  +"\np Pen up / down. Useful when you want to move the Turtle to another place on the screen without drawing."
  +"\nUse r(ed), g(reen) and b(lue) and v (black) and n (white) for the color the Turtle draws."
  +"\nUse + / - for Stroke Weight."
  +"\nUse A / D for rotate left/right 90°."
  +"\nUse O / P for rotate by 1°."
  +"\nUse , / . for changing the length of a step (comma and dot)."
  +"\n\n\n\n"
  +"Hit Escape key to leave the help.";

// When the command String turtleCommandString is empty, we show a help text INITIAL_TEXT_for_turtleCommandString in the Status Bar
final String INITIAL_TEXT_for_turtleCommandString =
  "<Start by Hitting key \"w\" a few times>";

final int INITIAL_lineSegment = 30;  //length of line segment

// COLORS
final color BLACK  = color(0);
final color WHITE  = color(255);

final color RED    = color(255, 0, 0);
final color GREEN  = color(0, 255, 0);
final color BLUE   = color(0, 0, 255);

// Other colors 
final int LIGHTGRAY = color(111); 
final int DARKGRAY  = color(66);

final color YELLOW  = color (255, 255, 0);

// states 
final int NORMAL_STATE         = 0; 
final int HELP_STATE           = 1;
final int SPLASH_SCREEN_STATE  = 2; 
final int stateWaitForLoad     = 3; 
final int stateWaitForSave     = 4; 
final int stateError           = 5; 

// Variables -------------------------------------------------------------------------

// State 
int state = SPLASH_SCREEN_STATE; 

// the menu
Menu menu;

// For the Turtle: 
String turtleCommandString       = INITIAL_TEXT_for_turtleCommandString;     // A String turtleCommandString gets recorded (in keyPressed()) and then evaluated (executed) in evaluateInputs().
color colorTurtle                = WHITE; // initial color - see Help 
int strokeWeightTurtle           = 1; 
boolean visibleTurtle            = true;  // show y/n
boolean showHelpAtTurtlePosition = true;  // show y/n
int lineSegment                  = INITIAL_lineSegment;    //length of line segment
boolean noCommandGiven           = true;   // indictate that the turtleCommandString is empty
boolean penUp                    = false;  // when the pen is up (true), it is not touching the ground, the Turtle is not drawing (just moving). penUp = false means the Turtle draws (pen is down on the canvas).   
float  angleCtl                  = 0;      // angle   

// For the User Interface (UI):  
boolean showHelp = true; // show help text / UI: show y/n
float posCanvasX, posCanvasY;  // change with cursor  

// For load and save 
String loadedFile=""; 
String loadPath = "";
String savePath="";
boolean scriptIsSaved=true;
String errorMsg=""; 
boolean loadWithInsert = false; 
String fileName=""; 

//----------------------------------------------------------------------------

void setup() {
  size(1500, 900);
  background(111); 
  println(helpTextLong);

  menu=new Menu();
  menu.addButton( "Menu", Button.IS_HEADLINE, "General");  //  HEADLINE

  menu.addButton( "New", Button.IS_COMMAND_BUTTON, "General" );
  //  menu.printlnCurrentButtonID();    // during adding buttons user can retrieve the last ID

  menu.addButton( "Open", Button.IS_COMMAND_BUTTON, "General" );
  menu.addButton( "Save", Button.IS_COMMAND_BUTTON, "General");
  menu.addButton( "Save As...", Button.IS_COMMAND_BUTTON, "General");
  menu.addButton( "Insert", Button.IS_COMMAND_BUTTON, "General");
  menu.addButton( "Help", Button.IS_COMMAND_BUTTON, "General");
  menu.addButton( "Quit", Button.IS_COMMAND_BUTTON, "General");

  // add help texts to the group
  menu.addGroupHelp ( "General", "Menu for main commands" ); 

  // set menu as drop down menu 
  menu.setDropDown();
  // ------------------------------
}

void draw() {
  // Depending on state 
  switch(state) {

  case NORMAL_STATE: 
    drawForStateNORMAL_STATE();
    break; 

  case HELP_STATE:
    drawForStateHELP_STATE(); 
    break;

  case SPLASH_SCREEN_STATE:
    drawForStateSPLASH_SCREEN_STATE();
    break;

  case stateWaitForSave:
    // wait
    if (!savePath.equals("")) {
      // wait is over 
      state = NORMAL_STATE;
      savePath=savePath.trim();
      if (savePath.indexOf(".txt") < 0) {
        savePath+=".txt"; // very rough approach...
      }
      saveStrings(savePath, stringToArray (turtleCommandString));
      loadedFile = savePath;
      scriptIsSaved=true; 
      fileName=nameFromPath(savePath);
      if (fileName.equals(""))
        fileName="<Not a file>";
    }//if
    // status bar (HUD) 
    // statusBar(); 
    break;

  case stateWaitForLoad:
    // wait
    // check if the input has been made: 
    if (!loadPath.equals("")) {
      // yes, waiting is over 
      state = NORMAL_STATE; 

      if (loadWithInsert) {
        //// loading and insert into existing sketch        
        //// load a separate array
        String[] loadedArray=loadStrings(loadPath);
        turtleCommandString += join(loadedArray, "\n"); 
        loadedArray=null;         
        //// Splice one array of values into another
        //tbox1.spliceArray(loadedArray);
        //tbox1.initNewLine();
        scriptIsSaved = false;
        noCommandGiven  = false;   // indictate that the turtleCommandString is filled
      } else {
        // classical loading 
        String[] temp = loadStrings(loadPath);
        turtleCommandString = join(temp, "\n"); 
        temp=null;         
        loadedFile = loadPath; 
        scriptIsSaved=true; 
        fileName=nameFromPath(loadPath);
        if (fileName.equals("")) {
          fileName="<Not a file>";
        }//if
        noCommandGiven  = false;   // indictate that the turtleCommandString is filled
      }//else
    } // outer if
    // status bar (HUD) 
    //statusBar(); 
    break; 

  default:
    // Error
    println("unknown state in draw() "
      +state);
    exit(); 
    break; 
    //
  }//switch
  //
}//func 
//
