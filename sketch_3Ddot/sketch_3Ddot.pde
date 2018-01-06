void settings() {
  size(412, 688); //for chromebook vertical display
}
void setup() {
  setupData();
  setupTestData();
}

void draw() {
  generateQueue();
  background(color(0,0,0));
  float[] control = getRotation();
  render(control[1],control[0]);
}