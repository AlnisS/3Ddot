void setup() {
  setupData();
  connections[0][0][0][0] = true;
  connections[0][1][0][0] = true;
  connections[0][0][0][1] = true;
  connections[1][0][0][1] = true;
  updateField();
  size(400, 400);
  background(color(0,0,0));
}

void draw() {
  generateQueue();
  background(color(0,0,0));
  renderQueue(radians(mouseY),radians(mouseX));
}