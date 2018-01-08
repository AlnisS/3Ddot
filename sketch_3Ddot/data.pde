boolean[][][][] connections;
player[][][][] squares;
int p1s;
int p2s;
enum player {
  NP, P1, P2
}
void setupData() {
  connections = new boolean[3][3][3][3]; //[x][y][z][xp, yp, zp]
  squares = new player[3][3][3][3]; //[x][y][z][xyp, xzp, yzp]
  initSquares();
  p1s = 0;
  p2s = 0;
}
void setupTestData() {
  /*
  connections[0][0][0][0] = true;
  connections[0][1][0][0] = true;
  connections[0][0][0][1] = true;
  connections[1][0][0][1] = true;
  
  connections[0][0][0][0] = true;
  connections[0][0][1][0] = true;
  connections[0][0][0][2] = true;
  connections[1][0][0][2] = true;
  
  connections[0][0][0][1] = true;
  connections[0][0][1][1] = true;
  connections[0][0][0][2] = true;
  connections[0][1][0][2] = true;
  */
  iterate();
  updateField(player.P1);
}
void iterate() {
  for(int i=0; i<=2; i++) {
    for(int j=0; j<=2; j++) {
      for(int k=0; k<=1; k++) {
        connections[i][j][k][2] = true;
        connections[i][k][j][1] = true;
        connections[k][i][j][0] = true;
      }
    }
  }
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
void updateField(player p) {
  for(int i=0; i<3; i++) {
    for(int j=0; j<3; j++) {
      for(int k=0; k<3; k++) {
        ups(i, j, k, p);
      }
    }
  }
}
void initSquares() {
  for(int i=0; i<3; i++) {
    for(int j=0; j<3; j++) {
      for(int k=0; k<3; k++) {
        for(int l=0; l<3; l++) {
          squares[i][j][k][l]=player.NP;
        }
      }
    }
  }
}
//update positive squares
void ups(int x, int y, int z, player p) { //(move around array and check others iff there are connections going in those directions
  if((connections[x][y][z][0] && connections[x][y][z][1]) && (connections[x][y+1][z][0] && connections[x+1][y][z][1]) && squares[x][y][z][0]==player.NP) {
      squares[x][y][z][0] = p;
    addScore(p);
  }
  if((connections[x][y][z][0] && connections[x][y][z][2]) && (connections[x][y][z+1][0] && connections[x+1][y][z][2]) && squares[x][y][z][1]==player.NP) {
      squares[x][y][z][1] = p;
    addScore(p);
  }
  if((connections[x][y][z][1] && connections[x][y][z][2]) && (connections[x][y][z+1][1] && connections[x][y+1][z][2]) && squares[x][y][z][2]==player.NP) {
      squares[x][y][z][2] = p;
      //println(connections[x][y][z][1], connections[x][y][z][2], connections[x][y][z+1][1], connections[x][y+1][z][2]);
      println(x, y, z, p);
    addScore(p);
  }
}
void addScore(player p) {
  if(p == player.P1) {
    p1s++;
  } else if(p == player.P2) {
    p2s++;
  } else println("warning: score adding attempt to no player");
}