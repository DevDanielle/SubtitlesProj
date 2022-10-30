/* 

Author: Danielle Kelly dlc1219
CSC 545 Assignment 4: Video Player with Subtitles

Plays videos with subtitles provided by an srt file. Subtitles broken into lines. 

*/

//****This program uses the UP and DOWN arrow keys to control speed because I do not have a mouse*****

import processing.video.*;

String fname = "Ready-Player-One-Trailer-HD-English-French-Subtitles.srt";
String movieName = "Ready-Player-One.mp4";
PImage old_img;
SubtitlePlayer sp;
Movie m;
boolean paused = false;
float playSpeed = 1.0; //Movie speed

void setup() {
  size(640, 460); //space provided for subtitles at bottom
  sp = new SubtitlePlayer(fname);
  frameRate(30);
  m = new Movie(this, movieName);
  m.play();
   
}
void draw() {
  background(0);
  image(m, 0, 0, 640, 360);
  sp.findSubtitle();
  int x = 555, y = 440;
  text(playSpeed, x, y);
}

void movieEvent(Movie m) {
  //Code here to read the new frame
  m.read();
  old_img = m.get();  //Copy the new frame into old_img
  
}

void keyReleased() {
  if (key == 'r') {  //reverse
    playSpeed = -playSpeed;
    m.speed(playSpeed);
  } else if (key == CODED) {
      if (keyCode == UP && playSpeed <= 2.0) {
      playSpeed = playSpeed + 0.1; //Increase speed
      m.speed(playSpeed);
      } else if (keyCode == DOWN && playSpeed >= 0.1) {
        playSpeed = playSpeed - 0.1; //Decrease speed
        m.speed(playSpeed);
      }
  } else if (key == ' ') {
    if (paused) {
    //Start the video playing again
    paused = false;
    m.play();
    } else {
    //Pause the video
    m.pause();
    paused = true;
    }
  }
}
