public class Segment {
  public float x1; public float y1; public float z1; public float x2; public float y2; public float z2; public color c;
  Segment(float a, float b, float ci, float d, float e, float f, color g) {
    this.x1 = a;  this.y1 = b;  this.z1 = ci;  this.x2 = d;  this.y2 = e;  this.z2 = f; this.c = g;
  }
}
ArrayList<Segment> rq = new ArrayList<Segment>();
void addConnectionToDraw(int x, int y, int z, int d, boolean t) {
  float x1 = x-1;
  float y1 = y-1;
  float z1 = z-1;
  float x2 = d==0 ? x : x-1;
  float y2 = d==1 ? y : y-1;
  float z2 = d==2 ? z : z-1;
  color c = t ? color(255, 255, 255) : color(127, 127, 127);
  Segment tmp = new Segment(x1, y1, z1, x2, y2, z2, c);
  if(!((z==2&&d==2)||(y==2&&d==1)||(x==2&&d==0))) rq.add(tmp);
}
void generateQueue() {
  for(int i=0; i<3; i++) {
    for(int j=0; j<3; j++) {
      for(int k=0; k<3; k++) {
        for(int l=0; l<3; l++) {
          addConnectionToDraw(i, j, k, l, connections[i][j][k][l]);
        }
      }
    }
  }
}
void renderQueue(float xr, float zr) {
  while(rq.size() != 0) {
    Segment tmp = rq.get(0); //this is not a copy of the added point, but it is deleted right after so it is ok to modify the original (as it is doing)
    tmp.x1 *= 100;
    tmp.y1 *= 100;
    tmp.z1 *= 100;
    tmp.x2 *= 100;
    tmp.y2 *= 100;
    tmp.z2 *= 100;
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
    tmp.y1 += 300;
    tmp.y2 += 300;
    stroke(tmp.c);
    line(width/2+tmp.x1/tmp.y1*200, height/2+tmp.z1/tmp.y1*200, width/2+tmp.x2/tmp.y2*200, height/2+tmp.z2/tmp.y2*200);
    //println(tmp.x1/tmp.y1, tmp.z1/tmp.y1, tmp.x2/tmp.y2, tmp.z2/tmp.y2);
    //println(tmp.x1);
    rq.remove(0);
  }
}