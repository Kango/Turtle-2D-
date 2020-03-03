
// Helper class for the Menu class.
// A group of buttons.
// Used only by the Menu class.

class Group {

  String name="";

  String helpText=""; 

  String headline="";
  boolean hasHeadline = false; 

  boolean isRadioButtonGroup = false; 
  int groupReturnValue = 0;
  int id_Within_Group_Counter = 0;

  boolean dropDownIsOpen=false; 

  float minXvalue; 
  float maxXvalue; 

  float minYvalue; 
  float maxYvalue;

  ArrayList<Integer> indexOfButtons = new ArrayList(); 

  // ------------------------------------------------------------------

  // constr 
  Group( String name_, int minYvalue_ ) {
    //
    minYvalue = minYvalue_;
    name      = name_;
  }// constr 
  //
}//class
//