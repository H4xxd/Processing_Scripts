class Circle {

  float dia;
  float radius;
  float n;
  float speed;
  float theta;
  float direction;

  ArrayList<PVector> coords;

  Circle(float d_, float r_, float n_, float s_, float t_, float dir_) {
    dia = d_;
    radius = r_;
    n =n_;
    speed = s_;
    theta = t_;
    direction = dir_;

    coords = new ArrayList<PVector>();
    float step = PI/n;
    for (int i = 0; i < n; i++) {
      float x = radius*sin(theta+step*(i+1));
      float y = radius*cos(theta+step*(i+1));
      PVector vec = new PVector(x, y);
      coords.add(vec);
    }
  }

  void show() {
    for (PVector vec : coords) {
      noStroke();
      int n  = coords.indexOf(vec);
      float col = map(radius, 0, width/2, 0, 255);
      if (direction == 1) {

        fill(255-col, 255, 255, 255/(n+1));
      }
      if (direction == -1) {
        fill(col, 255, 255, 255/(coords.size()-n));
      }
      ellipse(vec.x, vec.y, dia, dia);
    }
  }

  void update() {
    for (PVector vec : coords) {
      float t = (float)Math.atan2(vec.x, vec.y);
      float x = radius*sin(t-speed*direction);
      float y = radius*cos(t-speed*direction);
      vec.x = x;
      vec.y = y;
    }
  }
}