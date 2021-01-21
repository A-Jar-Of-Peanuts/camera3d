import java.awt.Robot; 

Robot rbt; 
//camera variables
float eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz;
boolean w, a, s, d;
float leftRightAngle, upDownAngle;
int mx, my, pmx, pmy;
//ArrayList<Ripple> myRipples;
ArrayList<Snowflake> snowList;
color black = #000000;
color white = #FFFFFF;
color dullBlue = #7092BE;

PImage mossyStone;
PImage oakPlanks;

int gridSize; 
PImage map; 

void setup() {

  mossyStone = loadImage("Mossy_Stone_Bricks.png"); 
  oakPlanks = loadImage("Oak_Planks.png"); 

  textureMode(NORMAL); 

  size(displayWidth, displayHeight, P3D);


  eyex = width/2;
  eyey = 9*height/10;
  eyez = height/2;

  focusx = width/2;
  focusy = height/2;
  focusz = height/2-100;

  upx = 0; 
  upy = 1;
  upz = 0;

  try {
    rbt = new Robot();
  } 
  catch(Exception e) {
    println("hi");
  }

  //myRipples = new ArrayList<Ripple>();

  //int i = 0;
  //while (i < 100) {
  //  myRipples.add( new Ripple() );
  //  i = i + 1;
  //}

  //snowList = new ArrayList<Snowflake>();

  //int j = 0;
  //while (j < 100) {
  //  snowList.add( new Snowflake() );
  //  j = j + 1;
  //}

  map = loadImage("map.png");
  gridSize = 100;
}

void move() {
  if (a && canMoveForward() && canMoveLeft() && canMoveRight() && canMoveBack()) {
    eyex -= cos(leftRightAngle+PI/2)*10;
    eyez -= sin(leftRightAngle+PI/2)*10;
  }
  if (d && canMoveForward() && canMoveLeft() && canMoveRight() && canMoveBack()) {
    eyex += cos(leftRightAngle+PI/2)*10;
    eyez += sin(leftRightAngle+PI/2)*10;
  }
  if (w && canMoveForward() && canMoveLeft() && canMoveRight() && canMoveBack()) {
    eyez += sin(leftRightAngle)*10;
    eyex += cos(leftRightAngle)*10;
  }
  if (s && canMoveForward() && canMoveLeft() && canMoveRight() && canMoveBack()) {
    eyez -= sin(leftRightAngle)*10;
    eyex -= cos(leftRightAngle)*10;
  }

  focusx = eyex + cos(leftRightAngle)*100; 
  focusy = eyey + tan(upDownAngle)*100; 
  focusz = eyez + sin(leftRightAngle)*100;

  if (mouseX>pmouseX) {
    leftRightAngle = leftRightAngle + 0.1;
  } else if (pmouseX>mouseX) {
    leftRightAngle = leftRightAngle - 0.1;
  }

  if (mouseY>pmouseY) {
    upDownAngle = upDownAngle + 0.1;
  } else if (pmouseY>mouseY) {
    upDownAngle = upDownAngle - 0.1;
  }

  if (upDownAngle > radians(89)) {
    upDownAngle = radians(89);
  } else if (upDownAngle < -radians(89)) {
    upDownAngle = -radians(89);
  }

  if (frameCount % 10 == 0) rbt.mouseMove(width/2, height/2);
}

void keyPressed() { 
  switch(key) {
  case 'w':
    w = true; 
    break;
  case 'a':
    a = true;
    break;
  case 's':
    s = true;
    break; 
  case 'd':
    d = true;
    break;
  }
}
void keyReleased() {
  switch(key) {
  case 'w':
    w = false; 
    break;
  case 'a':
    a = false;
    break;
  case 's':
    s = false; 
    break; 
  case 'd':
    d = false;
    break;
  }
}

void draw() {
  pointLight(255, 255, 255, eyex, eyey, eyez);

  background(0);
  camera(eyex, eyey, eyez, focusx, focusy, focusz, upx, upy, upz); 

  drawFloor(-2000, 2000, height, gridSize);
  drawFloor(-2000, 2000, height-gridSize*4, gridSize);
  drawMap(); 

  move();

  //int i = 0;
  //while (i < 100) {
  //  Ripple r = myRipples.get(i);
  //  r.act();
  //  r.show();
  //  i = i + 1;
  //}

  //int j = 0;
  //while (j < 100) {
  //  Snowflake mySnowflake = snowList.get(j);
  //  mySnowflake.act();
  //  mySnowflake.show();
  //  j = j + 1;
  //}
}

void drawMap() {
  for (int x = 0; x<map.width; x++) {
    for (int y = 0; y<map.height; y++) {
      color c = map.get(x, y); 
      if (c == dullBlue) {
        cube(x*gridSize-2000, height-gridSize, y*gridSize-2000, mossyStone, mossyStone, mossyStone, mossyStone, mossyStone, mossyStone);
        cube(x*gridSize-2000, height-gridSize*2, y*gridSize-2000, mossyStone, mossyStone, mossyStone, mossyStone, mossyStone, mossyStone);
        cube(x*gridSize-2000, height-gridSize*3, y*gridSize-2000, mossyStone, mossyStone, mossyStone, mossyStone, mossyStone, mossyStone);
      }
      if (c==black) {
        cube(x*gridSize-2000, height-gridSize, y*gridSize-2000, oakPlanks, oakPlanks, oakPlanks, oakPlanks, oakPlanks, oakPlanks);
        cube(x*gridSize-2000, height-gridSize*2, y*gridSize-2000, oakPlanks, oakPlanks, oakPlanks, oakPlanks, oakPlanks, oakPlanks);
        cube(x*gridSize-2000, height-gridSize*3, y*gridSize-2000, oakPlanks, oakPlanks, oakPlanks, oakPlanks, oakPlanks, oakPlanks);
      }
    }
  }
}

void cube(float posX, float posY, float posZ, PImage top, PImage bottom, PImage front, PImage back, PImage left, PImage right) {
  pushMatrix(); 
  translate(posX, posY, posZ); 
  scale(100);   

  noStroke();  

  beginShape(QUADS);
  texture(top); 
  //top
  vertex(0, 0, 0, 0, 0); 
  vertex(1, 0, 0, 0, 1); 
  vertex(1, 0, 1, 1, 1); 
  vertex(0, 0, 1, 1, 0); 
  endShape();


  beginShape(QUADS);
  texture(bottom); 

  //bottom
  vertex(0, 1, 0, 0, 0); 
  vertex(1, 1, 0, 0, 1); 
  vertex(1, 1, 1, 1, 1); 
  vertex(0, 1, 1, 1, 0); 
  endShape(); 

  beginShape(QUADS);
  texture(front);

  //front
  vertex(0, 0, 1, 0, 0); 
  vertex(0, 1, 1, 0, 1); 
  vertex(1, 1, 1, 1, 1); 
  vertex(1, 0, 1, 1, 0); 
  endShape();

  beginShape(QUADS);
  texture(back);

  //back
  vertex(0, 0, 0, 0, 0); 
  vertex(0, 1, 0, 0, 1); 
  vertex(1, 1, 0, 1, 1); 
  vertex(1, 0, 0, 1, 0);
  endShape();

  beginShape(QUADS);
  texture(left);

  //left
  vertex(0, 0, 0, 0, 0); 
  vertex(0, 1, 0, 0, 1); 
  vertex(0, 1, 1, 1, 1); 
  vertex(0, 0, 1, 1, 0); 
  endShape();

  beginShape(QUADS);
  texture(right);

  //right
  vertex(1, 0, 0, 0, 0); 
  vertex(1, 1, 0, 0, 1); 
  vertex(1, 1, 1, 1, 1); 
  vertex(1, 0, 1, 1, 0); 

  endShape();

  popMatrix();
}

boolean canMoveForward() {
  float fwdx, fwdy, fwdz;
  float leftx, lefty, leftz;
  float rightx, righty, rightz;
  int mapx, mapy; 
  int leftmapx, leftmapy;
  int rightmapx, rightmapy;
  fwdx = eyex + cos(leftRightAngle)*200; 
  fwdy = eyey;
  fwdz = eyez + sin(leftRightAngle)*200;

  leftx = eyex + cos(leftRightAngle+radians(20))*200; 
  lefty = eyey;
  leftz = eyez + sin(leftRightAngle+radians(20))*200;

  rightx = eyex + cos(leftRightAngle-radians(20))*200; 
  righty = eyey;
  rightz = eyez + sin(leftRightAngle-radians(20))*200;

  mapx = (int)(fwdx+2000)/gridSize;
  mapy = (int)(fwdz+2000)/gridSize;

  leftmapx = (int)(leftx+2000)/gridSize;
  leftmapy = (int)(leftz+2000)/gridSize;

  rightmapx = (int)(rightx+2000)/gridSize;
  rightmapy = (int)(rightz+2000)/gridSize;

  return map.get(mapx, mapy) == white && map.get(leftmapx, leftmapy) == white && map.get(rightmapx, rightmapy) == white;
}
boolean canMoveLeft() {
  float fwdx, fwdy, fwdz;
  float leftx, lefty, leftz;
  float rightx, righty, rightz;
  int mapx, mapy; 
  int leftmapx, leftmapy;
  int rightmapx, rightmapy;
  fwdx = eyex + cos(leftRightAngle+radians(90))*200; 
  fwdy = eyey;
  fwdz = eyez + sin(leftRightAngle+radians(90))*200;

  leftx = eyex + cos(leftRightAngle+radians(20)+radians(90))*200; 
  lefty = eyey;
  leftz = eyez + sin(leftRightAngle+radians(20)+radians(90))*200;

  rightx = eyex + cos(leftRightAngle-radians(20)+radians(90))*200; 
  righty = eyey;
  rightz = eyez + sin(leftRightAngle-radians(20)+radians(90))*200;

  mapx = (int)(fwdx+2000)/gridSize;
  mapy = (int)(fwdz+2000)/gridSize;

  leftmapx = (int)(leftx+2000)/gridSize;
  leftmapy = (int)(leftz+2000)/gridSize;

  rightmapx = (int)(rightx+2000)/gridSize;
  rightmapy = (int)(rightz+2000)/gridSize;

  return map.get(mapx, mapy) == white && map.get(leftmapx, leftmapy) == white && map.get(rightmapx, rightmapy) == white;
}
boolean canMoveRight() {
  float fwdx, fwdy, fwdz;
  float leftx, lefty, leftz;
  float rightx, righty, rightz;
  int mapx, mapy; 
  int leftmapx, leftmapy;
  int rightmapx, rightmapy;
  fwdx = eyex + cos(leftRightAngle-radians(90))*200; 
  fwdy = eyey;
  fwdz = eyez + sin(leftRightAngle-radians(90))*200;

  leftx = eyex + cos(leftRightAngle+radians(20)-radians(90))*200; 
  lefty = eyey;
  leftz = eyez + sin(leftRightAngle+radians(20)-radians(90))*200;

  rightx = eyex + cos(leftRightAngle-radians(20-radians(90)))*200; 
  righty = eyey;
  rightz = eyez + sin(leftRightAngle-radians(20)-radians(90))*200;

  mapx = (int)(fwdx+2000)/gridSize;
  mapy = (int)(fwdz+2000)/gridSize;

  leftmapx = (int)(leftx+2000)/gridSize;
  leftmapy = (int)(leftz+2000)/gridSize;

  rightmapx = (int)(rightx+2000)/gridSize;
  rightmapy = (int)(rightz+2000)/gridSize;

  return map.get(mapx, mapy) == white && map.get(leftmapx, leftmapy) == white && map.get(rightmapx, rightmapy) == white;
}

boolean canMoveBack() {
  float fwdx, fwdy, fwdz;
  float leftx, lefty, leftz;
  float rightx, righty, rightz;
  int mapx, mapy; 
  int leftmapx, leftmapy;
  int rightmapx, rightmapy;
  fwdx = eyex + cos(leftRightAngle-radians(180))*200; 
  fwdy = eyey;
  fwdz = eyez + sin(leftRightAngle-radians(180))*200;

  leftx = eyex + cos(leftRightAngle+radians(20)-radians(180))*200; 
  lefty = eyey;
  leftz = eyez + sin(leftRightAngle+radians(20)-radians(180))*200;

  rightx = eyex + cos(leftRightAngle-radians(20)-radians(180))*200; 
  righty = eyey;
  rightz = eyez + sin(leftRightAngle-radians(20)-radians(180))*200;

  mapx = (int)(fwdx+2000)/gridSize;
  mapy = (int)(fwdz+2000)/gridSize;

  leftmapx = (int)(leftx+2000)/gridSize;
  leftmapy = (int)(leftz+2000)/gridSize;

  rightmapx = (int)(rightx+2000)/gridSize;
  rightmapy = (int)(rightz+2000)/gridSize;

  return map.get(mapx, mapy) == white && map.get(leftmapx, leftmapy) == white && map.get(rightmapx, rightmapy) == white;
}



void drawAxes(int start, int end, int uplevel, int downlevel, int gap) {
  stroke(255); 
  strokeWeight(5); 
  line(0, 0, 0, 0, 0, 2000);
  line(0, 0, 0, 0, 2000, 0); 
  line(0, 0, 0, 2000, 0, 0); 
  noFill();
  rect(0, 0, width, height);
}

void drawFloor(int start, int end, int level, int gap) {
  stroke(255); 
  strokeWeight(1);
  int x = start;
  int z = start;
  while (z<end) {
    cube(x, level, z, oakPlanks, oakPlanks, oakPlanks, oakPlanks, oakPlanks, oakPlanks);
    x+=gap;
    if (x>=end) {
      z+=gap; 
      x = start;
    }
  }
}
