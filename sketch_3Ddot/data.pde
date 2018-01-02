boolean[][][][] connections;
boolean[][][][] squares;
void setupData() {
  connections = new boolean[3][3][3][3]; //[x][y][z][xp, yp, zp]
  squares = new boolean[3][3][3][3]; //[x][y][z][xyp, xzp, yzp]
}
boolean[] getConnections(int x, int y, int z) {
  boolean[] r = new boolean[6];
  r[0] = connections[x][y][z][0];
  r[1] = connections[x][y][z][1];
  r[2] = connections[x][y][z][2];
  if(x>0) r[3] = connections[x-1][y][z][0];
  if(y>0) r[4] = connections[x][y-1][z][0];
  if(z>0) r[5] = connections[x][y][z-1][0];
  return r;
}
void updateField() {
  for(int i=0; i<3; i++) {
    for(int j=0; j<3; j++) {
      for(int k=0; k<3; k++) {
        ups(i, j, k);
      }
    }
  }
}
//update positive squares
void ups(int x, int y, int z) { //(move around array and check others iff there are connections going in those directions
  if((connections[x][y][z][0] && connections[x][y][z][1]) && (connections[x][y+1][z][0] && connections[x+1][y][z][1])) squares[x][y][z][0] = true;
  if((connections[x][y][z][0] && connections[x][y][z][2]) && (connections[x][y][z+1][0] && connections[x+1][y][z][2])) squares[x][y][z][1] = true;
  if((connections[x][y][z][1] && connections[x][y][z][2]) && (connections[x][y][z+1][1] && connections[x][y+1][z][2])) squares[x][y][z][2] = true;
}


//old
void updateSquares(int x, int y, int z) {
  for(int i=x-1; i<connections.length; i++) {
    for(int j=y-1; j<connections[0].length; j++) {
      for(int k=z-1; k<connections[0][0].length; k++) {
        ups(max(0, i), max(0, j), max(0, k));
      }
    }
  }
}