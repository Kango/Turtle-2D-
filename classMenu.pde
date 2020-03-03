
// The class for the Menu.

class Menu {

  // The class' variables

  // buttons
  Button[] buttons;

  // consts for positions 
  final int POS_RIGHT   = 0; 
  final int POS_LEFT    = 1; 
  final int POS_TOP     = 2; 
  final int POS_BOTTOM  = 3; 
  int menuPosition = POS_RIGHT; // current 

  // on mouse pressed, data gets returned. Must all be negative (since command button returns its ID which is positive). 
  static final int menuReturnIgnore      = -1; 
  static final int menuReturnRadioButton = -2;
  static final int menuReturnCheckBox    = -3;

  // for init buttons 
  int iForNewButtons=0; 

  // register of groups (buttons are organized in groups)
  HashMap<String, Group> hmGroups = new HashMap();

  int groupsCounter=0; 

  boolean flagDropDown=false;

  // ---------------------------------------------------------------------

  //constr
  Menu () {
    buttons = new Button[0];
  } //constr

  void addButton(String text, int type, String groupName) {
    // parameters:
    //  * text is the text 
    //  * type is either headline, commandBtn, radio button, check box, see constants in class Button
    //  * free name of the group 

    int unit=29; // distY

    // we manage the group names
    Group group;
    // Is the group new? 
    if (hmGroups.containsKey(groupName)) {
      //No, old group - update values 
      group = hmGroups.get(groupName); 
      group.maxYvalue = (iForNewButtons*unit+20) + 19;
      // when entry (button) is a headline, we manage this 
      if (type==Button.IS_HEADLINE) {
        group.headline=text; 
        if ( group.hasHeadline ) {
          println("Warning: Double assigning of headline to a group "
            + text
            +" in group "+groupName);
        } else {
          group.hasHeadline = true;
        }//else
      }//if
    } else
    {
      //Yes, new group - make group and put it in hm
      groupsCounter++; 
      group=new Group(groupName, (iForNewButtons*unit+80) );
      // when entry (button) is a headline, we manage this 
      if (type==Button.IS_HEADLINE) {
        group.headline=text; 
        group.hasHeadline = true;
      }//if
      hmGroups.put(groupName, group);
    }//else 

    // make button 
    Button newButton = new Button( text, type, groupName, 
      width-134, iForNewButtons*unit+40, 
      104, unit-6, 
      iForNewButtons ); 

    // If it's a radio button some adjustments are necessary 
    if (type==Button.IS_RADIO_BUTTON) {
      group.isRadioButtonGroup  = true; 
      newButton.id_Within_Group = group.id_Within_Group_Counter;
      group.id_Within_Group_Counter++;
    }//if
    group.indexOfButtons.add(iForNewButtons);

    // add button to array 
    buttons = (Button[]) append (buttons, newButton);
    iForNewButtons++;
  } // method 

  void addGroupHelp(String groupName, String helpText) {
    // adds one help text to a group
    Group currentGroup = hmGroups.get ( groupName );
    if (currentGroup!=null) {
      currentGroup.helpText=helpText;
    } else {
      // error 
      println("Error 331: addGroupHelp: unknown groupname: "+groupName);
      exit();
    }//else
  }// method

  // ----------------------------------------------------------------------

  void display() {
    // show Menu
    if (flagDropDown) {
      // drop down menu
      for (Button but : buttons) {
        but.update();
        Group currGroup=hmGroups.get(but.groupName);
        but.displayForDropDownMenu(currGroup);
      }//for
    } else {
      // no drop down menu
      for (Button but : buttons) {
        but.update();
        but.display();
      }//for
    }//else
  }//method

  int getValueFromGroup( String groupNameLocal ) {
    return 
      hmGroups.get(groupNameLocal).groupReturnValue;
  }

  PVector getHelpBoxPos() {
    // Just a small function for the help screen, that returns a free spot,
    // where a general help text can be placed by the programmer.
    // This is not the position of the help texts of the menus.

    if (flagDropDown) {
      return new PVector(800, 330);
    }

    // Non drop down menus 
    switch(menuPosition) {
    case POS_RIGHT:
      return new PVector(100, 330);
    case POS_LEFT:
      return new PVector(800, 330);
    case POS_TOP:
      return new PVector(100, 330);
    case POS_BOTTOM:
      return new PVector(600, 330);
    default:
      // error
      println("Error 107 : "+menuPosition);
      exit();
      break;
    }//switch
    return new PVector(600, 330);
  }//method

  // ------------------------------------------------------------

  void displayHelp() {
    // show help 
    if (flagDropDown) 
      displayHelpForDropDown();
    else 
    displayHelpForNonDropDown();
  } // method

  void displayHelpForNonDropDown() {
    // helper for displayHelp() 
    if (menuPosition==POS_LEFT || menuPosition==POS_RIGHT) {
      showTexts1();
    } //if
    else {
      showTexts2();
    }//else 

    // show Menu as HELP buttons 
    fill(0); 
    for (Button but : buttons) {
      but.displayHelpText();
    }//for

    // back to default
    textAlign(LEFT);
  }//method 

  void displayHelpForDropDown() {
    // helper for displayHelp()
    // close all 
    closeAllMenus();
    // show help texts for groups 
    showTexts3();
  }//method 

  void showTexts1() {
    // version for menuPosition POS_RIGHT and POS_LEFT
    int xValue=0;
    // for the meaning of the variables see method forkHorizontal 
    PVector pvA=new PVector(); 
    PVector pvB=new PVector(); 
    PVector pvC; 
    switch(menuPosition) {
    case POS_RIGHT:
      xValue=1170;
      pvA.x = xValue+10;
      pvB.x = buttons[0].x - 7;
      textAlign(RIGHT);
      break;   
    case POS_LEFT:
      xValue=buttons[0].x+buttons[0].sizeWidth+93;
      pvA.x=xValue-10;
      pvB.x= buttons[0].x + buttons[0].sizeWidth + 8;
      textAlign(LEFT);
      break;
    default:
      println("Error 108");
      exit();
      break;
    }//switch 

    // GROUPS 
    for (Map.Entry<String, Group> hmEntry : hmGroups.entrySet()) {
      Group currentGroup = hmEntry.getValue(); 
      text( currentGroup.helpText, 
        xValue, (currentGroup.minYvalue+currentGroup.maxYvalue)/2 +2);
      stroke(255, 0, 0);
      // for the meaning of the variables see method forkHorizontal  
      pvB.y=currentGroup.minYvalue;
      pvC=new PVector( pvB.x, currentGroup.maxYvalue );
      forkHorizontal(pvA, pvB, pvC);
    }//for 
    textAlign(LEFT);
  }//method 

  void showTexts2() {
    // version for menuPosition TOP and BOTTOM
    int yValue=0; 
    // for the meaning of the variables see method forkVertical  
    PVector pvA=new PVector(); 
    PVector pvB=new PVector(); 
    PVector pvC; 

    switch(menuPosition) {

    case POS_TOP:
      yValue=170;
      pvA.y = yValue-10;
      pvB.y = buttons[0].x + buttons[0].sizeHeight + 7;
      break;   
    case POS_BOTTOM:
      yValue=height-180;
      pvA.y = yValue+30;
      pvB.y = buttons[0].y - 7;
      break;
    default:
      println("Error 109");
      exit();
      break;
    }//switch 

    // loop over all GROUPS 
    for (Map.Entry<String, Group> hmEntry : hmGroups.entrySet()) {
      Group currentGroup = hmEntry.getValue(); 
      textAlign(CENTER);
      text( currentGroup.helpText, 
        (currentGroup.minXvalue+currentGroup.maxXvalue)/2, yValue, 
        180, 900 );
      stroke(255, 0, 0);
      // for the meaning of the variables see method forkVertical  
      pvB.x=currentGroup.minXvalue;
      pvC=new PVector( currentGroup.maxXvalue+buttons[0].sizeWidth, pvB.y);
      forkVertical(pvA, pvB, pvC);
    }//for

    textAlign(LEFT);
  }//method 

  void showTexts3() {  
    // version for drop down menus 
    int counter = 0; 
    // loop over all groups 
    for (Map.Entry<String, Group> hmEntry : hmGroups.entrySet()) {
      Group currentGroup = hmEntry.getValue(); 
      // loop over all buttons in group
      for (int ind : currentGroup.indexOfButtons) {
        if (buttons[ind].type == Button.IS_HEADLINE) {
          buttons[ind].displayForDropDownMenu(currentGroup);
        }//if
      }//for
      float xValue = buttons[currentGroup.indexOfButtons.get(0)].x + 
        buttons[currentGroup.indexOfButtons.get(0)].sizeWidth / 2;
      fill(255, 0, 0); 
      text( currentGroup.helpText, 
        xValue+50+4, (groupsCounter-counter) * 70 +4);
      stroke(255, 0, 0);
      // for the meaning of the variables see method rightAngle  
      PVector pvA=new PVector(xValue, 30) ;
      PVector pvB=new PVector(xValue+50, (groupsCounter-counter) * 70 );
      rightAngle( pvA, pvB );
      counter++;
    }//for 
    textAlign(LEFT);
  }//method 

  // -------------------------------------------
  // set positions and drop down mode 

  void setLeft() {
    menuPosition = POS_LEFT; 
    for (Button but : buttons) {
      but.x=4;
    }
  }

  void setRight() {
    menuPosition = POS_RIGHT; 
    for (Button but : buttons) {
      but.x=width-134;
    }
  }

  void setTop() {
    menuPosition = POS_TOP; 
    int i=0; 
    for (Button but : buttons) {
      but.x=i*(buttons[1].sizeWidth+4)+5; 
      but.y=12; 
      i++;
    }//for
    getSomeDataForGroups();
  }

  void setBottom() {
    menuPosition = POS_BOTTOM; 
    int i=0; 
    for (Button but : buttons) {
      but.x=i*(buttons[1].sizeWidth+4)+5; 
      but.y=height-25; 
      i++;
    }//for
    getSomeDataForGroups();
  }

  void setDropDown() {
    // changes menu to a drop down menu  
    flagDropDown=true;
    setTop();
    // x-position, y-position
    int xVal=20;
    int yVal=39;
    float textWidthHeadline=0; 
    for (Map.Entry<String, Group> hmEntry : hmGroups.entrySet()) {
      Group currentGroup = hmEntry.getValue();
      // loop over all buttons in group
      for (int ind : currentGroup.indexOfButtons) {
        if (buttons[ind].type == Button.IS_HEADLINE) {
          // make headline button (the menu header from which the menu drops down) 
          buttons[ind].x=xVal; 
          buttons[ind].sizeWidth=int(textWidth(buttons[ind].btnText)+14); 
          textWidthHeadline = textWidth(buttons[ind].btnText)+17;
        }//if
        else {
          // make buttons that drop down
          buttons[ind].x=xVal+3; // x-position little right of menu
          buttons[ind].y=yVal;   // y-position 
          yVal+=23; // next line
        }//else
      }//for
      // prepare for next menu: 
      // increase x-position, reset y-position 
      xVal += textWidthHeadline;
      yVal=32;
    } //for
  } //method

  // -------------------------------------------

  void getSomeDataForGroups() {
    //  setTop() and setBottom() use this function to set minXvalue and maxXvalue for the groups 
    for (Map.Entry<String, Group> hmEntry : hmGroups.entrySet()) {
      Group currentGroup = hmEntry.getValue();
      // pre-init 
      currentGroup.minXvalue=10000;
      currentGroup.maxXvalue=-1000;
      // loop over all buttons in grouo 
      for (int ind : currentGroup.indexOfButtons) {
        if (buttons[ind].x<currentGroup.minXvalue)
          currentGroup.minXvalue=buttons[ind].x;
        if (buttons[ind].x>currentGroup.maxXvalue)
          currentGroup.maxXvalue=buttons[ind].x;
      }//for
    }//for
  }//method 

  // -------------------------------------------

  int checkMouseOnMenu() {
    // one of the core functions of the class. 
    // Handling mouse pressed.
    int result=menuReturnIgnore; // no button found.
    if (flagDropDown) {
      // drop down menu --- 
      // step 1 : check headlines
      if (checkMouseOnMenuHeadlines())
        return result;
      // step 2 : check menu content of open menu   
      result=checkMouseOnMenuForDropDown();
    } else 
    {
      // not drop down menus ---
      result=checkMouseOnMenuForNonDropDownMenu();
    }//else 
    return result;
  }//method    

  boolean checkMouseOnMenuHeadlines() {
    // helper for checkMouseOnMenu() 
    if (!flagDropDown) 
      return false; 

    for (Button but : buttons) {
      but.press(); 
      if (but.pressed&&but.type==Button.IS_HEADLINE) {
        //drop down menu 
        Group currGroup=hmGroups.get(but.groupName);
        if (currGroup.dropDownIsOpen) {
          // close an open menu            
          currGroup.dropDownIsOpen=false;
        } else {
          // close all 
          closeAllMenus(); 
          // open this menu 
          currGroup.dropDownIsOpen=true;
        }//else 
        but.pressed=false; 
        return true;
      }//if
    }//for 
    return false;
  }// method 

  int checkMouseOnMenuForDropDown() {
    // helper for checkMouseOnMenu() 

    if (!flagDropDown) 
      return menuReturnIgnore; 

    int result = menuReturnIgnore; // no button found.

    // loop over all groups 
    for (Map.Entry<String, Group> hmEntry : hmGroups.entrySet()) {
      Group currentGroup = hmEntry.getValue();

      if (currentGroup.dropDownIsOpen) {

        // loop over all buttons in grouo 
        for (int ind : currentGroup.indexOfButtons) {
          Button but = buttons[ind];

          but.press(); 
          if (but.pressed) {
            // some analysis depending on type
            switch(but.type) {

            case Button.IS_HEADLINE : 
              if (flagDropDown) {
                //drop down menu 
                Group currGroup=hmGroups.get(but.groupName);
                if (currGroup.dropDownIsOpen) {
                  // close an open menu            
                  currGroup.dropDownIsOpen=false;
                } else {
                  // close all 
                  closeAllMenus(); 
                  // open this menu 
                  currGroup.dropDownIsOpen=true;
                }//else 
                but.pressed=false; 
                // return menuReturnIgnore; // just leave
                result =  menuReturnIgnore;
              } else {
                // NOT drop down menu 
                // ignore 
                return menuReturnIgnore; // just leave
              } // else and end of case
              break; 

            case Button.IS_COMMAND_BUTTON : 
              // returning positive value
              return but.index; // result. Other buttons won't be pressed, just leave

            case Button.IS_RADIO_BUTTON : 
              Group currentGroup1 = hmGroups.get ( but.groupName ); 
              currentGroup1.groupReturnValue = but.id_Within_Group; 
              setInactive(currentGroup1); 
              but.isActive=true; 
              return menuReturnRadioButton; 

            case Button.IS_CHECKBOX : 
              // toggle 
              but.isActive = 
                ! but.isActive; 
              return menuReturnCheckBox; 

            default : 
              // error 
              println("Error 263: type: "
                + but.type 
                + ", button text: "
                + but.btnText); 
              exit(); // terminate sketch  
              return menuReturnIgnore; // Error. Just leave.
              //
            }//switch 
            //
          } else {
            // but.isActive=false;
          }//else
        }//for
      }
    }
    return result;
  } //method 

  int checkMouseOnMenuForNonDropDownMenu() {
    // helper for checkMouseOnMenu() 

    // not suited for drop down menu
    if (flagDropDown) 
      return menuReturnIgnore;

    int result = menuReturnIgnore; // no button found.
    for (Button but : buttons) {
      but.press(); 
      if (but.pressed) {
        // some analysis depending on type
        switch(but.type) {

        case Button.IS_HEADLINE :  
          // ignore 
          return menuReturnIgnore; // just leave

        case Button.IS_COMMAND_BUTTON : 
          // returning positive value
          return but.index; // result. Other buttons won't be pressed, just leave

        case Button.IS_RADIO_BUTTON : 
          Group currentGroup = hmGroups.get ( but.groupName ); 
          currentGroup.groupReturnValue = but.id_Within_Group; 
          setInactive(currentGroup); 
          but.isActive=true; 
          return menuReturnRadioButton; 

        case Button.IS_CHECKBOX : 
          // toggle 
          but.isActive = 
            ! but.isActive; 
          return menuReturnCheckBox; 

        default : 
          // error 
          println("Error 263: type: "
            + but.type 
            + ", button text: "
            + but.btnText); 
          exit(); // terminate sketch  
          return menuReturnIgnore; // Error. Just leave.
          //
        }//switch 
        //
      }//if
    }//for
    return result;
  } //method 

  // -------------------------------------------
  // minor tools 

  void forkHorizontal (PVector pvA, PVector pvB, PVector pvC) {
    // 
    //  draws :
    //                (E)_________ B 
    //                |
    //     A ---------|(D)
    //                |
    //                (F)--------- C

    // (The x-values of B and C should be the same)  

    // pvA's y-value gets overwritten btw.
    pvA.y =  (pvB.y + pvC.y) / 2 ;

    PVector pvD = new PVector ( (pvA.x + pvB.x) / 2, (pvB.y + pvC.y) / 2 );

    PVector pvE = new PVector ( pvD.x, pvB.y ); 
    PVector pvF = new PVector ( pvD.x, pvC.y );  

    linePV ( pvA, pvD ) ; 
    linePV ( pvE, pvF ) ;

    linePV ( pvE, pvB ) ;
    linePV ( pvF, pvC ) ;
  }//method 

  void forkVertical (PVector pvA, PVector pvB, PVector pvC) {
    // 
    //  draws :
    //             A
    //             |
    //             |
    //       E-----D----F
    //       |          |
    //       |          |
    //       |          |
    //       B          C


    // (The y-values of B and C should be the same)  

    // pvA's x-value gets overwritten btw.
    pvA.x =  (pvB.x + pvC.x) / 2 ;

    PVector pvD = new PVector (  (pvB.x + pvC.x) / 2, (pvA.y + pvB.y) / 2 );

    PVector pvE = new PVector ( pvB.x, pvD.y); 
    PVector pvF = new PVector ( pvC.x, pvD.y);  

    linePV ( pvA, pvD ) ; 
    linePV ( pvE, pvF ) ;

    linePV ( pvE, pvB ) ;
    linePV ( pvF, pvC ) ;
  }//method 

  void rightAngle( PVector pvA, PVector pvB  ) {
    //draws:
    //
    //  A
    //  |
    //  |
    //  |
    //  (C)---------B
    // 
    PVector pvC = new PVector (pvA.x, pvB.y); 
    linePV( pvA, pvC );
    linePV( pvC, pvB );
  }

  void linePV(PVector pv1, PVector pv2) {
    line(pv1.x, pv1.y, 
      pv2.x, pv2.y);
  }//method

  boolean closeAllMenus() {
    // close all menus.
    // Returns failure (false) when 
    // we are not in Drop Down Mode
    // or when no menu was open.
    // When a menu was closed, success (true) is returned by the variable result. 

    // When we are not in Drop Down Mode return failure 
    if (!flagDropDown)
      return false; // return failure

    boolean result=false; 
    for (Map.Entry<String, Group> hmEntry : hmGroups.entrySet()) {
      Group currentGroup = hmEntry.getValue();
      if (currentGroup.dropDownIsOpen) {
        result=true;
      }
      currentGroup.dropDownIsOpen=false;
    }//for
    return result;
  }//method 

  boolean anyIsOpen() {
    boolean result=false; 
    for (Map.Entry<String, Group> hmEntry : hmGroups.entrySet()) {
      Group currentGroup = hmEntry.getValue();
      if (currentGroup.dropDownIsOpen) {
        result=true;
      }//if
      // currentGroup.dropDownIsOpen=false;
    }//for
    return result;
  }

  void setInactive( Group currGroup ) {
    // for radio buttons: set entire group inactive
    for (int ind : currGroup.indexOfButtons) {
      buttons[ind].isActive=false;
    }
  }//method

  void printlnCurrentButtonID() {
    // during adding buttons user can retrieve the last ID 
    println(iForNewButtons-1
      +": "
      +buttons[iForNewButtons-1].btnText);
  }
  //
}//class
//
