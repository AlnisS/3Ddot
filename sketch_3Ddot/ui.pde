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
boolean pm=true; //placemode
float[] control = {0, 0};
int mouseState = 0; //up, down, this frame up, this frame down
player curp = player.P1;
void updateUI() {
  updateMouse();
  updateCursor();
}
void updateMouse() {
  if(!mousePressed) {
    if(lfmp) {
      mouseState = 2;
    } else {
      mouseState = 0;
    }
    lfmp = false;
  }
  if(mousePressed) {
    if(lfmp) {
      mouseState = 1;
    } else {
      mouseState = 3;
      lastmx = mouseX;
      lastmy = mouseY;
    }
    lfmp = true;
  }
  if(lastmy <= height*2/3) {
    control = getRotation(mouseState);
  } else {
    control = getRotation(0);
    if(lastmx >= width/2 && mouseState == 2 && abs(mouseX-lastmx) < 30) {
      if(lastmy-mouseY >= 10) {
        keypressHandler('e');
      } else if(lastmy-mouseY <= -10) {
        keypressHandler('q');
      } else {
        keypressHandler('\n');
      }
    }
    if(lastmx < width/2 && mouseState == 2 && sqrt(sq(mouseX-lastmx)+sq(mouseY-lastmy)) >= 10) {
      float[] tmp;
      float curmin = PI;
      int curmind = -1;
      tmp = returnRenderSegment(new Segment(0, 0, (ccurz-1)*CUBE_SIZE, 100, 0, (ccurz-1)*CUBE_SIZE, 0), control[1], control[0], 0, 0);
      
      float xpd = abs(radDiff(ptsToRad(tmp[0], tmp[1], tmp[2], tmp[3]), ptsToRad(lastmx, lastmy, mouseX, mouseY)));
      println(tmp[2], tmp[3], ptsToRad(tmp[0], tmp[1], tmp[2], tmp[3]), ptsToRad(lastmx, lastmy, mouseX, mouseY));
      
      if(xpd<curmin) {curmin=xpd; curmind=0;}
      float xnd = PI-xpd;
      if(xnd<curmin) {curmin=xnd; curmind=1;}
      tmp = returnRenderSegment(new Segment(0, 0, (ccurz-1)*CUBE_SIZE, 0, 100, (ccurz-1)*CUBE_SIZE, 0), control[1], control[0], 0, 0);
      println(control[0], control[1]);
      float ypd = abs(radDiff(ptsToRad(tmp[0], tmp[1], tmp[2], tmp[3]), ptsToRad(lastmx, lastmy, mouseX, mouseY)));
      println(tmp[2], tmp[3], ptsToRad(tmp[0], tmp[1], tmp[2], tmp[3]), ptsToRad(lastmx, lastmy, mouseX, mouseY));  
      if(ypd<curmin) {curmin=ypd; curmind=2;}
      float ynd = PI-ypd;
      if(ynd<curmin) {curmin=ynd; curmind=3;}
      println(xpd, xnd, ypd, ynd, curmind);
      switch(curmind) {
        case 0: keypressHandler('d'); break;
        case 1: keypressHandler('a'); break;
        case 2: keypressHandler('w'); break;
        case 3: keypressHandler('s'); break;
      }
    }
  }
  renderSegment(new Segment(0, 0, (ccurz-1)*CUBE_SIZE, 200, 0, (ccurz-1)*CUBE_SIZE, color(255, 255, 255)), control[1], control[0], width/2, height/2);
  renderSegment(new Segment(0, 0, (ccurz-1)*CUBE_SIZE, 0, 200, (ccurz-1)*CUBE_SIZE, color(255, 255, 128)), control[1], control[0], width/2, height/2);
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
void keypressHandler(char k) {
  switch(k) {
    /*
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
    */
    case 'a': if(cd!=3) cd=3; else ctargx--; break;
    case 'd': if(cd!=0) cd=0; else ctargx++; break;
    case 's': if(cd!=4) cd=4; else ctargy--; break;
    case 'w': if(cd!=1) cd=1; else ctargy++; break;
    case 'q': if(cd!=2) cd=2; else ctargz++; break;
    case 'e': if(cd!=5) cd=5; else ctargz--; break;
    //case ' ': pm=!pm; break;
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
void keyPressed() {
  keypressHandler(key);
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
float[] getRotation(int in) {
  float[] result = new float[2];
  switch(in) {
    case 0: xr+=xrv;
            zr+=zrv;
            zr=min(PI/2, max(-PI/2, zr));
            result = new float[] {xr, zr};
            break;
    case 1: result[0] = xr+RF*radians(mouseX-lastmx);
            result[1] = zr-RF*radians(mouseY-lastmy);
            break;
    case 3: result[0] = xr+RF*radians(mouseX-lastmx);
            result[1] = zr-RF*radians(mouseY-lastmy);
            break;
    case 2: xr+=RF*radians(mouseX-lastmx);
            zr-=RF*radians(mouseY-lastmy);
            result = new float[] {xr, zr};
            break;
  }
  //println(lastmx, lastmy, mouseX, mouseY);
  //println(in);
  //float[] result = new float[] {xr, zr};
  result[1] = min(PI/2, max(-PI/2, result[1]));
  xrv=result[0]-xrl;
  zrv=result[1]-zrl;
  xrv*=SPIN_FRICTION;
  zrv*=SPIN_FRICTION;
  xrl=result[0];
  zrl=result[1];
  return result;
}