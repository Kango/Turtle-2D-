

// Helper class for the Menu class.
// Used only by the Menu class.

class Button {

  // visible text
  String btnText; 

  // type: Headline or command button or ............. 
  static final int IS_HEADLINE       = 0; // constants: unique numbers 
  static final int IS_COMMAND_BUTTON = 1;
  static final int IS_RADIO_BUTTON   = 2; 
  static final int IS_CHECKBOX       = 3;
  // type
  int type = IS_COMMAND_BUTTON; 

  // which group does the button belong to?  
  String groupName = "";
  int id_Within_Group = 0; // for radio buttons: a group has one and only one active member.  

  // pos and size
  int x, y; // The x- and y-coordinates
  int sizeWidth, sizeHeight; // size (width and height) (w/h)

  // flags 
  boolean over    = false; // True when the mouse is over
  boolean pressed = false; // True when the mouse is over and pressed

  // index 
  int index; // index 

  // is it ON ? 
  boolean isActive=false;  // for check box and radio button 

  // -------------------------------------------------------------------------

  // constructor 
  Button(String text_, 
    int type_, 
    String groupName_, 
    int xp_, int yp_, 
    int sizeWidth_, int sizeHeight_, 
    int index_) {

    btnText    = text_;
    type       = type_; 
    groupName  = groupName_;

    x = xp_;
    y = yp_;

    sizeWidth  = sizeWidth_;
    sizeHeight = sizeHeight_; 

    index = index_;
  } // constructor 

  // Updates the over field every frame
  void update() {
    if ((mouseX >= x) && (mouseX <= x + sizeWidth) &&
      (mouseY >= y) && (mouseY <= y + sizeHeight)) {
      over = true;
    } else {
      over = false;
    }
  }

  boolean press() {
    if (over) {
      pressed = true;
      return true;
    } else {
      pressed = false; 
      return false;
    }
  }

  void release() {
    pressed = false; // Set to false when the mouse is released
  }

  void displayForDropDownMenu(Group currGroup) {
    //
    switch(type) {

    case IS_HEADLINE: 
      // Headline
      // display like normal button/command button  
      fill(YELLOW); // box
      noStroke(); 
      rect(x, y, 
        sizeWidth, sizeHeight);

      fill(0);  // white
      textAlign(LEFT);
      text(btnText, x+6, y+16);
      break;

    default:
      if (currGroup.dropDownIsOpen) {
        // 
        display();
      }//if
      break;
    }//switch
  }//method 

  void display() {
    //
    float dist = 2;
    switch(type) {

    case IS_HEADLINE: 
      // Headline
      fill(0);  // white
      textAlign(LEFT);
      text(btnText, x+0, y+16);
      break;

    case IS_COMMAND_BUTTON:
      // normal button 
      fill(11);
      noStroke(); 
      rect(x, y, 
        sizeWidth, sizeHeight);

      fill(255);  // white
      textAlign(LEFT);
      text(btnText, x+6, y+16);
      break;

    case IS_RADIO_BUTTON:
      //
      fill(111);
      noStroke(); 
      rect(x, y, 
        sizeWidth, sizeHeight);

      noFill(); 
      stroke(0);
      dist = 2; 
      strokeWeight(1);//reset
      ellipseMode(CENTER);  // Set ellipseMode to CENTER
      ellipse(x+dist+8, y+dist+9, 
        9, 9);  
      noStroke(); 
      if (isActive) {
        fill(0); 
        ellipseMode(CENTER);  // Set ellipseMode 
        ellipse(x+dist+8, y+dist+9, 
          4, 4);  
        strokeWeight(2);
        stroke(0, 225, 0);//green
        noFill();
      }

      dist = 1; 
      rect(x+dist, y+dist, 
        sizeWidth-dist-dist, sizeHeight-dist-dist);
      strokeWeight(1);//reset

      fill(255);  // white
      textAlign(LEFT);
      text(btnText, x+19, y+16);
      break; 

    case IS_CHECKBOX:
      // yes/no boolean
      //
      fill(111);
      noStroke();
      rect(x, y, 
        sizeWidth, sizeHeight);

      noFill(); 
      stroke(0);
      dist = 2; 
      strokeWeight(1);//reset
      // rect with a CHECKBOX 
      PVector upperLeftCorner=new PVector(x+dist+2, y+dist+2+2);
      rect(upperLeftCorner.x, upperLeftCorner.y, 
        9, 9);

      noStroke(); 
      if (isActive) {
        fill(0); 
        stroke(0); 
        // line \
        line(upperLeftCorner.x, upperLeftCorner.y, 
          upperLeftCorner.x+9, upperLeftCorner.y+9);  
        // line /
        line(upperLeftCorner.x+9, upperLeftCorner.y, 
          upperLeftCorner.x, upperLeftCorner.y+9);  
        strokeWeight(2);
        stroke(0, 225, 0);//green
        noFill();
      }// if

      dist = 1; 
      rect(x+dist, y+dist, 
        sizeWidth-dist-dist, sizeHeight-dist-dist);
      strokeWeight(1);//reset

      fill(255);  // white
      textAlign(LEFT);
      text(btnText, x+19, y+16);
      break;

    default:
      println("Error 121");
      exit();
      break;
    }//switch
  }//method

  void displayHelpText() {
    // Help View 
    if (type==IS_HEADLINE) {
      // Headline
      fill(0);  // 
      textAlign(LEFT);
      text(btnText, x+6, y+16);
    } else {
      // normal button 
      noFill(); 
      stroke(111);
      rect(x, y, sizeWidth, sizeHeight);
      strokeWeight(1);//reset
      fill(111);
      textAlign(LEFT);
      text(btnText, x+6, y+16);
    }//else
  }
  //
}//class
//
