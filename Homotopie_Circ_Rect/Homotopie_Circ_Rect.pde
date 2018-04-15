float radius;
float t ;
float angle ;

float a, d;

void setup() {
  size(400, 400);
  //fullScreen();
  background(0);
  frameRate(60);
  colorMode(HSB);
  rectMode(CENTER);

  radius = height/2-10;
  t = 0 ;
  angle = 0 ;
  d= 3.0;
  a = 2.0/d ;
}

void draw() {
  background(0);
  translate(width/2, height/2);
  noFill();
  stroke(255);
  beginShape();
  float limit =TWO_PI*d;
  //println(limit);
  for (float i = 0; i <= limit; i+=0.01) {
    PVector hom = homotopie(i, t, radius);
    vertex(hom.x, hom.y);
    //ellipse(hom.x, hom.y, 2, 2);
  }
  endShape(CLOSE);
  t = map(sin(angle), -1, 1, 0, 1);
  angle+=0.01;
}

PVector homotopie(float phi, float t, float rad) {
  PVector circ = circle(phi, rad);
  PVector rect = rectangle(phi, rad);

  float x = (1-t)*circ.x + t*rect.x;
  float y = (1-t)*circ.y + t*rect.y;

  PVector hom = new PVector(x, y);

  return hom;
}

PVector circle(float phi, float rad) {
  //Polargleichung Kreis 
  //float x = rad*(cos(phi));
  //float y = rad*(sin(phi));

  // Polargleichung r = (a*phi)
  float x = rad*cos(a*phi)*cos(phi);
  float y = rad*cos(a*phi)*sin(phi);

  PVector erg = new PVector(x, y);

  return erg;
}

PVector rectangle(float phi, float rad) {
  float x=0;
  float y=0;
  float phi_ = phi%TWO_PI;
  if ((phi_ >= 0 && phi_ <= HALF_PI/2)|| phi_ > 7*HALF_PI/2) {
    x = rad;
    y = rad* tan(phi_);
  }
  if (phi_ > HALF_PI/2 && phi_ <= 3*HALF_PI/2) {
    x = rad*tan(HALF_PI-phi_);
    y = rad;
  }
  if (phi_ > 3*HALF_PI/2 && phi_ <= 5*HALF_PI/2) {
    x = -rad;
    y = -rad*tan(phi_-PI);
  }
  if (phi_ > 5*HALF_PI/2 && phi_ <= 7*HALF_PI/2) {
    x = rad*tan(phi_-HALF_PI);
    y = -rad;
  }

  PVector erg = new PVector(x, y);
  return erg;
}