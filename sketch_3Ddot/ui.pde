int testx = 0;
int testy = 0;
int testz = 0;
float testxb = 0;
float testyb = 0;
float testzb = 0;
void updateUI() {
  testxb = .6*testx + .4*testxb;
  testyb = .6*testy + .4*testyb;
  testzb = .6*testz + .4*testzb;
  addCursorToDraw(testxb, testyb, testzb, 0, false, player.P2);
}
void keyPressed() {
  switch(key) {
    case 'a': testx--; break;
    case 'd': testx++; break;
    case 's': testy--; break;
    case 'w': testy++; break;
    case 'q': testz++; break;
    case 'e': testz--; break;
    default: break;
  }
  testx = max(0, min(2, testx));
  testy = max(0, min(2, testy));
  testz = max(0, min(2, testz));
}
float lastmx;
float lastmy;
float xr;
float zr;
boolean lfmp; //last frame mouse pressed?
float[] getRotation() {
  if(!mousePressed) {
    if(lfmp) {
      xr+=RF*radians(mouseX-lastmx);
      zr-=RF*radians(mouseY-lastmy);
    }
    lfmp = false;
  }
  float[] result = new float[] {xr, zr};
  if(mousePressed) {
    if(lfmp) {
      result[0] = xr+RF*radians(mouseX-lastmx);
      result[1] = zr-RF*radians(mouseY-lastmy);
    } else {
      lfmp = true;
      lastmx = mouseX;
      lastmy = mouseY;
      result[0] = xr+RF*radians(mouseX-lastmx);
      result[1] = zr-RF*radians(mouseY-lastmy);
    }
  }
  result[1] = min(PI/2, max(-PI/2, result[1]));
  return result;
}