class Snowflake {
  
  //1. Instance variables: the data that each snowflake
  //                       needs to keep track of.
  float x, y, z, size, speed;
  
  //2. Constructor(s): initializes the instance variables.
  //   Rules: no return type (void), name matches class
  Snowflake() {
    x = random(-2000, 2000);
    y = random(-2000, 2000); 
    z = random(-2000, 2000); 
    size = random(3,10);
    speed = size;
  }
  
  //3. Behaviour Functions: functions that describe how
  //                        Snowflakes act and look.
  void act() {
    y = y + speed;
    if (y > height) {
      y = -2000;
      x = random(-2000,2000);
      z = random(-2000, 2000); 
    }
  }
  
  void show() {
    pushMatrix();
    translate(x, y, z); 
    box(size, size, size); 
    popMatrix();
  }

}
