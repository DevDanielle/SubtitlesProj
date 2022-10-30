/*
Author: Danielle Kelly 
*/

class SubtitlePlayer {
  String arrow = "-->";  //Arrow separating start time from end time
  String tokens = ":,";
  String[] lines;
  int fontSize = 30;
  
  SubtitlePlayer(String fname) {
    //Load the file into the lines array
    lines = loadStrings(fname);
  }
  
void findSubtitle() {
    int i = 0;
    while (i < lines.length) {
      //If the line contains an arrow, you have a new subtitle - get it into a StringList
      if (lines[i].contains(arrow)) {
        StringList subtitle = new StringList();
        subtitle.append(lines[i++]);
        while (lines[i].length() > 0) {
          subtitle.append(lines[i++]);
        }
        printSubtitle(subtitle);
      }

      i++;  //Skip line
    }
  }
  int parseTime(String[] timeArr) {
    //Returns time in ms; time array has format hours, minutes, seconds, milliseconds
    int t0 = parseInt(timeArr[0].trim()) * 60 * 60 * 1000; //hours
    int t1 = parseInt(timeArr[1].trim()) * 60 * 1000; //mins
    int t2 = parseInt(timeArr[2].trim()) * 1000; //secs
    int t3 = parseInt(timeArr[3].trim()); //millisecs
    int t = t0 + t1+ t2 + t3; //total time in ms
    return t;
  }
  void printSubtitle(StringList subtitle) {
    //Get the time line - the first element in subtitle
    
    String timeLine = subtitle.get(0);
    //Find the position of the arrow (-1 if not found - but it should be there)
    int arrowPos = timeLine.indexOf(arrow);
    //Get the string to the left of the arrow - that's the start time
    String t1Str = timeLine.substring(0, arrowPos); //timeline up to arrow
    //Get the string to the right of the arrow - that's the end time
    String t2Str = timeLine.substring(arrowPos + arrow.length() + 1);
    //Split the start time on tokens, creating an array of strings
    String[] startTimeArr = splitTokens(t1Str, tokens);
    //Split the end time on tokens, creating another array of strings
    String[] endTimeArr = splitTokens(t2Str, tokens);
    int t1 = parseTime(startTimeArr);  //Start time
    int t2 = parseTime(endTimeArr);    //End time
    
    int xpos = 15; 
    
    //get movie time
    int movieTime = int (m.time());
    //convert to ms
    movieTime = movieTime * 1000;
    
    //Print the text lines in the subtitle StringList
    if (movieTime >= t1 && movieTime <= t2){
      for (int i = 1; i < subtitle.size(); i++) { 
        //convert to text statement
        text(subtitle.get(i), xpos, height-fontSize * (subtitle.size() - i)); 
        //text gets x and y pos ,y is vertical pos 
        
      }
    }
  }
}
