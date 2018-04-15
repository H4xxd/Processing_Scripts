import themidibus.*;

float a, b ;
float delta;
float time;

int counter;

float x, y;

MidiBus myBus;

void setup() {
  size(600, 600);

  time = 0;
  delta = 0;
  a = 1;
  b = 10;

  counter = 0 ;

  //myBus = new MidiBus(this, "Arturia BeatStepPro", "Arturia BeatStepPro");
}

void draw() {
  translate(width/2, height/2);
  background(255);
  noFill();

  beginShape();
  for (float  i  = 0; i < 2*PI; i+=0.01) {
    x = map(sin(a*i+delta), -1, 1, -width/2+10, width/2-10);
    y = map(sin(b*i), -1, 1, -height/2+10, height/2-10);
    vertex(x, y);
  }
  endShape(CLOSE);

  //counter++;
  //if (counter > PI/0.01) {
  //  counter = 0 ;
  //  a++;
  //  b--;
  //}

  delta+=0.01;
}

void noteOn(int channel, int pitch, int velocity) {
  if (channel == 1) {
    a = pitch% 4 +1 ;
  }
  if (channel == 2) {
    b = velocity% 4 +1;
  }
}