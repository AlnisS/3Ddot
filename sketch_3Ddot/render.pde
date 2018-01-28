public class Segment implements Comparable<Segment> {
  public float x1; public float y1; public float z1; public float x2; public float y2; public float z2; public color c; public float d;
  Segment(float a, float b, float ci, float d, float e, float f, color g) {
    this.x1 = a;  this.y1 = b;  this.z1 = ci;  this.x2 = d;  this.y2 = e;  this.z2 = f; this.c = g;
    this.d=sqrt(sq((x1+x2)/2)+sq((y1+y2)/2)+sq((z1+z2)/2));
  }
  public int compareTo(Segment other) {
    if(this.d>other.d) {
      return 1;
    } else if(this.d<other.d) {
      return -1;
    } else {
      return 0;
    }
  }
  public Segment copy() {
    return new Segment(this.x1, this.y1, this.z1, this.x2, this.y2, this.z2, this.c);
  }
}
ArrayList<Segment> rq = new ArrayList<Segment>();
void render(float xr, float zr) {
  renderQueue(xr, zr);
  textSize(SCORE_SIZE);
  fill(P1_COLOR); text(p1s, SCORE_HI, SCORE_VI);
  fill(P2_COLOR); text(p2s, width-textWidth(str(p2s))-SCORE_HI, SCORE_VI);
  renderAxes(xr, zr);
}
void renderAxes(float xr, float zr) {
  renderSegment(new Segment(0, 0, 0, 20, 0, 0, color(255, 255, 255)), xr, zr, width/2, 20);
  renderSegment(new Segment(0, 0, 0, 0, 20, 0, color(255, 255, 255)), xr, zr, width/2, 20);
  renderSegment(new Segment(0, 0, 0, 0, 0, -20, color(255, 255, 255)), xr, zr, width/2, 20);
}
void addConnectionToDraw(int x, int y, int z, int d, boolean t) {
  float x1 = x-1;
  float y1 = y-1;
  float z1 = z-1;
  float x2 = d==0 ? x : x-1;
  float y2 = d==1 ? y : y-1;
  float z2 = d==2 ? z : z-1;
  color c = t ? SEG_ON : SEG_OFF;
  if(!((z==2&&d==2)||(y==2&&d==1)||(x==2&&d==0))){
    int[] tof = dToOffsets(d);
    if(needsSplit(x, y, z)||needsSplit(x+tof[0], y+tof[1], z+tof[2])) {
      addSplitSegmentToDraw(new Segment(x1, y1, z1, x2, y2, z2, c));
    } else {
      rq.add(new Segment(x1, y1, z1, x2, y2, z2, c));
    }
  }
}
void addSplitSegmentToDraw(Segment t) {
  for(int i=0; i<SPLITS; i++) {
    float l=1.0/SPLITS;
    float j=i*l;
    float jb=j+l;
    float k=1-j;
    float kb=1-l-j;
    Segment tmp = new Segment(t.x1*k+t.x2*j, t.y1*k+t.y2*j, t.z1*k+t.z2*j,
                              t.x1*kb+t.x2*jb, t.y1*kb+t.y2*jb, t.z1*kb+t.z2*jb, t.c); //color(55+i*20, 55+i*20, 55+i*20)
    rq.add(tmp);
  }
}

void addCursorToDraw(float x, float y, float z, float xb, float yb, float zb, boolean e, player p) {
  float x1=x-CCO-1;
  float x2=x+CCO-1;
  float y1=y-CCO-1;
  float y2=y+CCO-1;
  float z1=z-CCO-1;
  float z2=z+CCO-1;
  color c = p==player.P1 ? P1_COLOR : P2_COLOR;
  addCube(x1, y1, z1, x2, y2, z2, c);
  c=e?OTHER_COLOR:OTHER_COLOR_DARK;
  x1=xb-CCO/2-1;
  x2=xb+CCO/2-1;
  y1=yb-CCO/2-1;
  y2=yb+CCO/2-1;
  z1=zb-CCO/2-1;
  z2=zb+CCO/2-1;
  addCube(x1, y1, z1, x2, y2, z2, c);
}
void addCube(float x1, float y1, float z1, float x2, float y2, float z2, color c) {
  rq.add(new Segment(x1, y1, z1, x2, y1, z1, c));//top
  rq.add(new Segment(x2, y1, z1, x2, y2, z1, c));
  rq.add(new Segment(x2, y2, z1, x1, y2, z1, c));
  rq.add(new Segment(x1, y2, z1, x1, y1, z1, c));
  rq.add(new Segment(x1, y1, z2, x2, y1, z2, c));//bottom
  rq.add(new Segment(x2, y1, z2, x2, y2, z2, c));
  rq.add(new Segment(x2, y2, z2, x1, y2, z2, c));
  rq.add(new Segment(x1, y2, z2, x1, y1, z2, c));
  rq.add(new Segment(x1, y1, z1, x1, y1, z2, c));//verticals
  rq.add(new Segment(x2, y1, z1, x2, y1, z2, c));
  rq.add(new Segment(x2, y2, z1, x2, y2, z2, c));
  rq.add(new Segment(x1, y2, z1, x1, y2, z2, c));
}
void addSquareToDraw(int x, int y, int z, int d, player p) {
  if(p == player.NP) return;
  color c;
  float x1; float y1; float z1;
  float x2; float y2; float z2;
  if(p == player.P1) {
    c = P1_COLOR;
  } else {
    c = P2_COLOR;
  }
  switch (d) {
    case 0: x1=SSTART+x; y1=SSTART+y; z1=-1+z;
            x2=SEND+x; y2=SEND+y;
            addSplitSegmentToDraw(new Segment(x1, y1, z1, x2, y1, z1, c));
            addSplitSegmentToDraw(new Segment(x2, y1, z1, x2, y2, z1, c));
            addSplitSegmentToDraw(new Segment(x2, y2, z1, x1, y2, z1, c));
            addSplitSegmentToDraw(new Segment(x1, y2, z1, x1, y1, z1, c));
            break;
    case 1: x1=SSTART+x; y1=-1+y; z1=SSTART+z;
            x2=SEND+x; z2=SEND+z;
            addSplitSegmentToDraw(new Segment(x1, y1, z1, x2, y1, z1, c));
            addSplitSegmentToDraw(new Segment(x2, y1, z1, x2, y1, z2, c));
            addSplitSegmentToDraw(new Segment(x2, y1, z2, x1, y1, z2, c));
            addSplitSegmentToDraw(new Segment(x1, y1, z2, x1, y1, z1, c));
            break;
    case 2: x1=-1+x; y1=SSTART+y; z1=SSTART+z;
            y2=SEND+y; z2=SEND+z;
            addSplitSegmentToDraw(new Segment(x1, y1, z1, x1, y2, z1, c));
            addSplitSegmentToDraw(new Segment(x1, y2, z1, x1, y2, z2, c));
            addSplitSegmentToDraw(new Segment(x1, y2, z2, x1, y1, z2, c));
            addSplitSegmentToDraw(new Segment(x1, y1, z2, x1, y1, z1, c));
            //println(x1, y1, z1, x1, y2, z2);
            break;
    default: break;
  }
}
void generateQueue() {
  for(int i=0; i<3; i++) {
    for(int j=0; j<3; j++) {
      for(int k=0; k<3; k++) {
        for(int l=0; l<3; l++) {
          addConnectionToDraw(i, j, k, l, connections[i][j][k][l]);
          addSquareToDraw(i, j, k, l, squares[i][j][k][l]);
        }
      }
    }
  }
}
void renderQueue(float xr, float zr) {
  text(rq.size(), 20, 648);

  for(Segment t:rq) {
    Segment tmp = readySegment(t, xr, zr);
    t.d=sqrt(sq((tmp.x1+tmp.x2)/2)+sq((tmp.y1+tmp.y2)/2)+sq((tmp.z1+tmp.z2)/2));
  }
  Collections.sort(rq);
  Collections.reverse(rq);
  while(rq.size() != 0) {
    Segment tmp = rq.get(0); //this is not a copy of the added point, but it is deleted right after so it is ok to modify the original (as it is doing)
    tmp.x1 *= CUBE_SIZE;
    tmp.y1 *= CUBE_SIZE;
    tmp.z1 *= CUBE_SIZE;
    tmp.x2 *= CUBE_SIZE;
    tmp.y2 *= CUBE_SIZE;
    tmp.z2 *= CUBE_SIZE;
    renderSegment(tmp, xr, zr, width/2, height/2);
    rq.remove(0);
  }
}
void renderSegment(Segment t, float xr, float zr, float cntx, float cnty) {
  Segment tmp = readySegment(t, xr, zr);
  stroke(tmp.c);
  strokeWeight(2);
  line(cntx+tmp.x1/tmp.y1*CAM_LENGTH, cnty+tmp.z1/tmp.y1*CAM_LENGTH, cntx+tmp.x2/tmp.y2*CAM_LENGTH, cnty+tmp.z2/tmp.y2*CAM_LENGTH);
}
float[] returnRenderSegment(Segment t, float xr, float zr, float cntx, float cnty) {
  Segment tmp = readySegment(t, xr, zr);
  //println(tmp.x1, tmp.y1, tmp.z1, tmp.x2, tmp.y2, tmp.z2);
  stroke(tmp.c);
  strokeWeight(2);
  float[] r = {cntx+tmp.x1/tmp.y1*CAM_LENGTH, cnty+tmp.z1/tmp.y1*CAM_LENGTH, cntx+tmp.x2/tmp.y2*CAM_LENGTH, cnty+tmp.z2/tmp.y2*CAM_LENGTH};
  return r;
}
Segment readySegment(Segment t, float xr, float zr) {
  Segment tmp = t.copy();
  float tx = tmp.x1;
  float ty = tmp.y1;
  float tz = tmp.z1;
  tmp.x1 = tx*cos(zr) - ty*sin(zr);
  tmp.y1 = tx*sin(zr) + ty*cos(zr);
  tx = tmp.x1;
  ty = tmp.y1;
  tz = tmp.z1;
  tmp.y1 = ty*cos(xr) - tz*sin(xr);
  tmp.z1 = ty*sin(xr) + tz*cos(xr);
  tx = tmp.x2;
  ty = tmp.y2;
  tz = tmp.z2;
  tmp.x2 = tx*cos(zr) - ty*sin(zr);
  tmp.y2 = tx*sin(zr) + ty*cos(zr);
  tx = tmp.x2;
  ty = tmp.y2;
  tz = tmp.z2;
  tmp.y2 = ty*cos(xr) - tz*sin(xr);
  tmp.z2 = ty*sin(xr) + tz*cos(xr);
  tmp.y1 += CAM_DIST;
  tmp.y2 += CAM_DIST;
  return tmp;
}