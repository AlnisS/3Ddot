float SCL;
final float SCORE_SIZE = 20; //vertical size of square counts for each player
final float SCORE_HI = 10; //horizontal inset inward for player scores
final float SCORE_VI = 25; //vertical inset inward for player scores
final color P1_COLOR = color(255, 0, 0); //player 1 color
final color P2_COLOR = color(0, 0, 255); //player 2 color
final color OTHER_COLOR = color(255, 255, 255); //other color for cursor
final color OTHER_COLOR_DARK = color(127, 127, 0); //other color when cursorb not active
final color SEG_ON = color(255, 255, 255); //color for placed segment
final color SEG_OFF = color(63, 63, 63); //color for unplaced segment
final float SSTART = -.95; //square start in cube space
final float SEND = -.05; //square end in cube space
final float CUBE_SIZE = 200; //cube size, world units per cube unit
final float CAM_LENGTH = 400; //camera length
final float CAM_DIST = 800; //distance from cube center
final float RF = .5; //rotation speed factor for mouse
final float CCO = .1; //cursor cube offset from center
final float SPIN_FRICTION = .92; //spin friction for spinning the cube with inertia
final boolean ENTER_ALWAYS_OK = true; //whether enter can always be used to place segments
final int SPLITS = 4; //subsegments to cut lines into