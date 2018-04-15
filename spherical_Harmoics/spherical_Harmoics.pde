float angle = 0 ;

float m0, m2, m4, m6;
float m1, m3, m5, m7;

float phi, theta;
int div = 2;
int steps = floor(TWO_PI / (div*0.01)), count;

void setup() {
  size(600, 600, P3D);  
  colorMode(HSB);
  frameRate(30);

  m0 = 1;
  m2 = 1;
  m4 = 1;
  m6 = 1;

  m1 = 1;
  m3 = 1;
  m5 = 1;
  m7 = 1;

  phi = 0 ;
  theta = 0 ;
  count = 0;
}


void draw() {
  background(0);
  translate(width/2, height/2);

  rotateY(angle);
  angle += 0.01;
  m0 = (map(sin(angle), -1, 1, 0, 5));
  m2 = (map(cos(angle), -1, 1, 0, 5));
  m4 = (map(sin(angle)*cos(angle), -1, 1, 0, 5));
  



  noStroke();

  beginShape(TRIANGLE_STRIP);
  while (phi <= PI+0.03) {
    while (theta <= TWO_PI+0.03) {
      float r = pow(sin(m0*phi), m1) + pow(cos(m2*phi), m3) + pow(sin(m4*theta), m5) + pow(cos(m6*theta), m7);
      r *= 75;
      float x = r * sin(phi) * cos(theta);
      float y = r * sin(phi) * sin(theta);
      float z = r * cos(phi);

      float d_square = x*x + y*y + z*z;
      float col = map(d_square, 0, 45000, 0, 255);
      fill(col, 255, 255);
      stroke(col, 255, 255);
      vertex(x, y, z);

      theta += 0.02;
    }
    theta = 0;
    phi += 0.02;
  }
  phi = 0;
  endShape();

  // count++;
  //if (count >= steps ) {
  //   count = count % steps;
  // m0++;
  //}
}