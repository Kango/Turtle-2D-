

// Tools: Date and time (for the file name)

String timeStamp() {
  return todaysDate () 
    + "_" 
    + timeNow () ;
}

// --------------------------------------------------------

String todaysDate () {
  int d = day();    // Values from 1 - 31
  int m = month();  // Values from 1 - 12
  int y = year();   // 2003, 2004, 2005, etc.

  String Result = 
    nf(y, 2)+
    nf(m, 2)+
    nf(d, 2); 
  return Result;
}

String timeNow () {
  int h = hour();     // Values from 1 - 23
  int m = minute();   // Values from 1 - 60
  int s = second();   // 1-60

  String Result = 
    nf(h, 2) + "" + 
    nf(m, 2) + "" + 
    nf(s, 2); 
  return Result;
}
//
