import java.util.Collections;
void settings() {
  size(displayWidth, displayHeight, P3D);
  //size(1366, 688);
  //size(412, 688); //for chromebook vertical display
  //smooth(8);
}
void setup() {
  SCL = min(((float)(width))/512, ((float)(height))/512);
  println(width, height, width/412, height/412);
  setupData();
  setupTestData();
  //ups(0, 0, 1, player.P1);
  //frameRate(5);
}
int frames = 0;
void draw() {
  
  int time = millis();
  generateQueue();
  background(color(0,0,0));
  updateUI();
  render(control[1],control[0]);
  fill(color(255, 255, 255));
  frames++;
  //text(frames*1000/(millis()), 20, 668);
  //println(millis()-time);
  
  //println(radDiff(PI/2, ptsToRad(width/2, height/2, mouseX, height-mouseY)), ptsToRad(width/2, height/2, mouseX, height-mouseY));
  //println(ptToRad(width/2, height/2, mouseX, height-mouseY));
  println(SCL);
}
float ptsToRad(float x1, float y1, float x2, float y2) {
  float c = x2<x1?PI:0;
  return atan((y2-y1)/(x2-x1))+c;
}
float radDiff(float r1, float r2) {
  if(r1-r2>PI) r2 += 2*PI;
  if(r1-r2<-PI) r2 -= 2*PI;
  return r2-r1;
}