import themidibus.*;

float n1, n2, n3;
float a, b;
float m;

float y_angle=0;

float scale = 200;
float phi;

float d_min, d_max;

MidiBus myBus;


void setup() {
  //size(600, 600, P3D);
  fullScreen(P3D);
  //frameRate(60);
  colorMode(HSB);
  a = 1 ;
  b = 1 ;
  m = 7 ;

  n1 = 0.4 ;
  n2 = 1.7 ;
  n3 = 1.7 ;
  d_min = 10000;
  d_max = -10000;

  myBus = new MidiBus(this, "Arturia BeatStepPro", "Arturia BeatStepPro");
}


void draw() {
  translate(width/2, height/2);
  rotateY(y_angle);
  rotateX(-PI/7);
  background(0);
  noFill();
  for (float phi = -PI/2; phi <= PI/2; phi += PI/frameRate) {
    beginShape();
    for (float theta = -PI; theta <= PI; theta += PI/frameRate) {
      float r_theta = radius(theta);
      float r_phi = radius(phi);
      float x = r_theta*cos(theta)*r_phi*cos(phi);
      float y = r_theta*sin(theta)*r_phi*cos(phi);
      float z = r_phi*sin(phi);
      float dist_sqr = map(x*x+y*y+z*z, 0, 1, 0, 255);

      if (x*x+y*y+z*z <d_min) {
        d_min = x*x+y*y+z*z;
      }
      if (x*x+y*y+z*z > d_max) {
        d_max = x*x+y*y+z*z;
      }

      x = map(x, -1, 1, -scale, scale);
      y = map(y, -1, 1, -scale, scale);
      z = map(z, -1, 1, -scale, scale);

      fill(dist_sqr%256, 255, 255, 127);
      //noStroke();
      stroke(dist_sqr%256, 255, 255, 50);
      vertex(y, z, x);
    }
    endShape(CLOSE);
  }
  y_angle+=0.01;
  m  = map(sin(y_angle), -1, 1, 0, 15);

  n1  = map(sin(2*y_angle), -1, 1, 0.01, 1);
  n2  = map(sin(3*y_angle), -1, 1, 0.01, 1);

  //println(d_min, d_max);
}

float radius(float angle) {
  float result = pow(pow(abs(cos(m*angle/4)/a), n2)+pow(abs(sin(m*angle/4)/b), n3), (-1/n1));
  return result;
}

void noteOn(int ch, int p, int v) {
  a = map(p, 60, 70, 0, 1);
  println(p);
}