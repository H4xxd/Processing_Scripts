
class Circle {
  float radius;
  int n;
  float direction;
  float speed;
  float theta_offset;
  ArrayList<PVector> coords;
  float step;
  float alpha;
  float col_offset;

  Circle(float r_, int n_, float d_, float s_, float t_,float a_,float col_off) {
    radius = r_ ;
    n = n_ ;
    direction = d_;
    speed = s_;
    theta_offset = t_;
    step = TWO_PI/n;
    alpha = a_;
    col_offset = col_off;
    coords = new ArrayList<PVector>();
    for (float i = 0; i <= TWO_PI; i+= step) {
      float x = radius*sin(i+theta_offset);
      float y = radius*cos(i+theta_offset);
      PVector v = new PVector(x, y);
      coords.add(v);
    }
  }

  void show() {
    beginShape();
    for (PVector vec : coords) {
      float dist = map(radius, 0, height, 0, 255);
      stroke((dist+col_offset)%256, 255, 255, alpha);
      noFill();
      vertex(vec.x, vec.y);
    }
    endShape(CLOSE);
  }

  void change_alpha(int val) {
    float alpha_ = map(val, 0, 127, 0, 255);
    alpha = alpha_;
  }

  void change_col_offset(int val) {
    float col_ = map(val, 0, 127, 0, 255);
    col_offset = col_;
  }

  void update() {
    for (PVector vec : coords) {
      float theta = (float)Math.atan2(vec.x, vec.y);
      float x = radius*sin(theta+direction*0.01*speed);
      float y = radius*cos(theta+direction*0.01*speed);
      vec.x = x;
      vec.y = y;
    }
    theta_offset = (float)Math.atan2(coords.get(0).x, coords.get(0).y);
  }

  void connect(Circle inner_circ) {
    int min1 = 0;
    float dist_min = 10000;
    if (coords.size() > inner_circ.coords.size()) {
      for (PVector vec_o : coords) {
        for (PVector vec_i : inner_circ.coords) {
          if (vec_o.dist(vec_i) < dist_min) {
            dist_min = vec_o.dist(vec_i);
            min1 = inner_circ.coords.indexOf(vec_i);
          }
        }
        float dist = map(radius, 0, height, 0, 255);
        stroke((255-dist+col_offset)%256, 255, alpha);
        line(inner_circ.coords.get(min1).x, inner_circ.coords.get(min1).y, vec_o.x, vec_o.y);
      }
    } else {
      for (PVector vec_i : inner_circ.coords) {
        for (PVector vec_o : coords) {
          if (vec_i.dist(vec_o) < dist_min) {
            dist_min = vec_i.dist(vec_o);
            min1 = coords.indexOf(vec_o);
          }
        }
        float dist = map(radius, 0, height, 0, 255);
        stroke((255-dist+col_offset)%256, 255, 255, alpha);
        line(coords.get(min1).x, coords.get(min1).y, vec_i.x, vec_i.y);
      }
    }
  }
}