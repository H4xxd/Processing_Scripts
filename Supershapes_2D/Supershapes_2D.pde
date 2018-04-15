float r, phi;

float n1, n2, n3;
float a, b ;

float m;

float scale = 250;

float angle = 0;


void setup() {
  size(600, 600);
  frameRate(30);
  color(HSB);
  n1 = 0.3 ;
  n2 = 0.3;
  n3 = 0.3;
  a = 1;
  b = 1 ;
  m = 0.3;
}

void draw() {
  translate(width/2, height/2);
  background(0);


  noFill();
  stroke(255);
  beginShape();
  for (phi = 0; phi <= TWO_PI; phi += 0.01) {
    float r1 = pow(abs(cos(m*phi/4)/a), n2);
    float r2 = pow(abs(sin(m*phi/4)/b), n3);
    r = 1/(pow(r1+r2, (1/n1)));
    r*=scale;
    float x = r * cos(phi);
    float y = r * sin(phi);
    vertex(x, y);
  }
  endShape(CLOSE);

  m = map(sin(angle), -1, 1, 0, 10);
  n1 = map(sin(angle), -1, 1, 0.1, 3);
  angle += PI/111;
  //noLoop();
}