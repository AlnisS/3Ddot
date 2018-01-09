int ctargx = 0;
int ctargy = 0;
int ctargz = 0;
int ctargxb = 1;
int ctargyb = 0;
int ctargzb = 0;
int cd = 0; //+x, +y, +z, -x, -y, -z
float ccurx = 0;
float ccury = 0;
float ccurz = 0;
float ccurxb = 0;
float ccuryb = 0;
float ccurzb = 0;
boolean pm=false; //placemode
player curp = player.P1;
void updateUI() {
  updateCursor();
}
void updateCursor() {
  ccurx = .6*ctargx + .4*ccurx;
  ccury = .6*ctargy + .4*ccury;
  ccurz = .6*ctargz + .4*ccurz;
  bumpCursor();
  setCursorBTarg();
  ccurxb = .6*ctargxb + .4*ccurxb;
  ccuryb = .6*ctargyb + .4*ccuryb;
  ccurzb = .6*ctargzb + .4*ccurzb;
  
  addCursorToDraw(ccurx, ccury, ccurz, ccurxb, ccuryb, ccurzb, pm, curp);
}
void setCursorBTarg() {
  ctargxb=ctargx;
  ctargyb=ctargy;
  ctargzb=ctargz;
  switch(cd) {
    case 0: ctargxb++; break;
    case 1: ctargyb++; break;
    case 2: ctargzb++; break;
    case 3: ctargxb--; break;
    case 4: ctargyb--; break;
    case 5: ctargzb--; break;
    default: break;
  }
}
boolean bumpCursor() {
  boolean r = false;
  if(ctargx==2&&cd==0) {cd=3; r=true;}
  if(ctargy==2&&cd==1) {cd=4; r=true;}
  if(ctargz==2&&cd==2) {cd=5; r=true;}
  if(ctargx==0&&cd==3) {cd=0; r=true;}
  if(ctargy==0&&cd==4) {cd=1; r=true;}
  if(ctargz==0&&cd==5) {cd=2; r=true;}
  return r;
}
void clipCursor() {
  ctargx = max(0, min(2, ctargx));
  ctargy = max(0, min(2, ctargy));
  ctargz = max(0, min(2, ctargz));
}
void keyPressed() {
  switch(key) {
    case 'a': if(pm) cd=3; else ctargx--; break;
    case 'd': if(pm) cd=0; else ctargx++; break;
    case 's': if(pm) cd=4; else ctargy--; break;
    case 'w': if(pm) cd=1; else ctargy++; break;
    case 'q': if(pm) cd=2; else ctargz++; break;
    case 'e': if(pm) cd=5; else ctargz--; break;
    case 'j': cd=3; break;
    case 'l': cd=0; break;
    case 'k': cd=4; break;
    case 'i': cd=1; break;
    case 'u': cd=2; break;
    case 'o': cd=5; break;
    case ' ': pm=!pm; break;
    case 'g': zrv+=.05; break;
    case 't': zrv-=.05; break;
    case 'f': xrv-=.05; break;
    case 'h': xrv+=.05; break;
    case '\n': if(pm||ENTER_ALWAYS_OK) {
                 //only switch turn if valid move is made which does not make a new square
                 if(place(ctargx, ctargy, ctargz, cd, curp) && !updateField(curp)) {
                   curp=(curp==player.P1)?player.P2:player.P1;
                 }
               }
               break;
    default: break;
  }
  bumpCursor();
  clipCursor();
}
float lastmx;
float lastmy;
float xr;
float zr;
float xrl;
float zrl;
float xrv;
float zrv;
boolean lfmp; //last frame mouse pressed?
float[] getRotation() {
  if(!mousePressed) {
    if(lfmp) {
      xr+=RF*radians(mouseX-lastmx);
      zr-=RF*radians(mouseY-lastmy);
    }
    lfmp = false;
    xr+=xrv;
    zr+=zrv;
    zr=min(PI/2, max(-PI/2, zr));
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
  xrv=result[0]-xrl;
  zrv=result[1]-zrl;
  xrv*=SPIN_FRICTION;
  zrv*=SPIN_FRICTION;
  xrl=result[0];
  zrl=result[1];
  return result;
}