import java.util.Collections;
void settings() {
  size(412, 688); //for chromebook vertical display
//smooth(8);
  
}
void setup() {
  setupData();
  setupTestData();
  //ups(0, 0, 1, player.P1);
}
void draw() {
  float time = millis();
  generateQueue();
  updateUI();
  background(color(0,0,0));
  float[] control = getRotation();
  render(control[1],control[0]);
  fill(color(255, 255, 255));
  text(1000/(millis()-time), 20, 668);
}