class Ripple {

  //instance variables
  float x, y, z, speed, size, a;

  //constructor
  Ripple() {
    x = random(-2000, 2000);
    y = random(-2000, 2000);
    z = random(-2000, 2000); 
    size = random(0, 200);
    speed = 2;
  }

  //behaviour functions
  void act() {
    size = size + speed; //grow
    if (size > 200) {
      x = random(-2000, 2000);
      y = random(-2000, 2000);
      z = random(-2000, 2000); 
      size = 0;
    }
  }

  void show() {
    pushMatrix(); 
    a = map(size, 0, 200, 255, 0);
    stroke(255, a);
    translate(x, y, z); 
    sphere(size);
    popMatrix();
  }
}
