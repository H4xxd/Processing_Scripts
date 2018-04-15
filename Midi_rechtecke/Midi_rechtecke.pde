import themidibus.*;

MidiBus myBus;

float r, g, b, h, i ;
float b_alt, h_alt;
float a;


void setup() {
  //fullScreen();
  size(800, 800);
  background(0);
  myBus = new MidiBus(this, "Arturia BeatStepPro", "Arturia BeatStepPro");
  colorMode(HSB);

  i = 0 ;
}

void draw() {
  translate(width/2, height/2);
  noStroke();
  if (b_alt != b && h_alt != h) {
    for (int i = 0; i < 5; i++) {
    rotate(i*PI/frameRate);
    i++;
      fill(i, map(random(0, r+1), 0, r+1, 0, 255), map(random(0, g+1), 0, g+1, 0, 255), random(55, 55+a));
      rect(random(-width/2, width/2), random(-height/2, height/2), b, h);
    }
  }
  b_alt = b;
  h_alt = h;
}


void noteOn(int c, int p, int v) {
  if (c == 1) {
    r = 3*p % 255;
    g = map(v, 65, 105, 0, 255);
    //println(p, v);
  }
  if (c == 0) {
    //println(c, p, v);
    b = p;
    h = v;
  }
  if (c == 2) {
    a = p*v%200;
  }
}