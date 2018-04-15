import gifAnimation.*;

float x, y ;
float n ;

GifMaker gifExport;

void setup() {
  size(200,200);

  n = 1;

  gifExport = new GifMaker(this, "test.gif");
  gifExport.setRepeat(0);
  
  background(0);
}

void draw() {
  translate(width/2, height/2);
  //background(0);
  stroke(random(0,255),random(0,255),random(0,255),127);
  noFill();
  beginShape();
  for (float i = 0; i <= 4*PI; i+= 0.001) {
    x = cos(n*i)*cos(i);
    y = cos(n*i)*sin(i);
    x = map(x, -1, 1, -width/2, width/2);
    y = map(y, -1, 1, -height/2, height/2);
    vertex(x, y);
  }
  endShape(CLOSE);

  gifExport.setDelay(1);
  gifExport.addFrame();

  n += 1;

  if (mousePressed) {
    gifExport.finish();
  }
}