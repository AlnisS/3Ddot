int ctargx = 0;
int ctargy = 0;
int ctargz = 0;
int cd = 0; //+x, +y, +z, -x, -y, -z
float ccurx = 0;
float ccury = 0;
float ccurz = 0;
boolean pm=false; //placemode
player curp = player.P1;
void updateUI() {
  ccurx = .6*ctargx + .4*ccurx;
  ccury = .6*ctargy + .4*ccury;
  ccurz = .6*ctargz + .4*ccurz;
  addCursorToDraw(ccurx, ccury, ccurz, cd, pm, curp);
}
void keyPressed() {
  switch(key) {
    case 'a': if(pm) cd=3; else ctargx--; break;
    case 'd': if(pm) cd=0; else ctargx++; break;
    case 's': if(pm) cd=4; else ctargy--; break;
    case 'w': if(pm) cd=1; else ctargy++; break;
    case 'q': if(pm) cd=2; else ctargz++; break;
    case 'e': if(pm) cd=5; else ctargz--; break;
    case ' ': pm=!pm; break;
    case '\n': if(pm) {
                 //only switch turn if valid move is made which does not make a new square
                 if(place(ctargx, ctargy, ctargz, cd, curp) &&!updateField(curp)) {
                   curp=(curp==player.P1)?player.P2:player.P1;
                 }
               }
               break;
    default: break;
  }
  
  if(ctargx==2&&cd==0) cd=3;
  if(ctargy==2&&cd==1) cd=4;
  if(ctargz==2&&cd==2) cd=5;
  if(ctargx==0&&cd==3) cd=0;
  if(ctargy==0&&cd==4) cd=1;
  if(ctargz==0&&cd==5) cd=2;
  
  ctargx = max(0, min(2, ctargx));
  ctargy = max(0, min(2, ctargy));
  ctargz = max(0, min(2, ctargz));
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