import processing.video.*;

Capture cam;
PImage prev;
PImage prevprev;

PImage diff_1;

int Width = 1280;
int Height = 720;
int FPS = 15;

float motionX = 0;
float motionY = 0;

void setup() { 
  size(1280, 720); 
  cam = new Capture(this, Width, Height, FPS);
  cam.start();
  prev=createImage(Width, Height, RGB);
  prevprev=createImage(Width, Height, RGB);
  diff_1 = createImage(Width, Height, RGB);
}

void captureEvent(Capture video) {
  prevprev.copy(prev, 0, 0, prev.width, prev.height, 0, 0, prevprev.width, prevprev.height);
  prevprev.updatePixels();
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

void draw() {
  cam.loadPixels();
  prev.loadPixels();
  prevprev.loadPixels();
  diff_1.loadPixels();

  float threshold1 = 75;
  float threshold2 = 75;
  float threshold_acc = 25;

  float avg = 0 ;
  float avg1 = 0 ;
  float avg2 = 0 ;

  int d = 0 ;
  int d1 = 0 ;
  int d2 = 0 ;


  loadPixels();
  // Begin loop to walk through every pixel
  for (int x = 0; x < cam.width; x++ ) {
    for (int y = 0; y < cam.height; y++ ) {
      int loc = x + y * cam.width;
      // What is current color
      color currentColor = cam.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      //What is previous color
      color prevColor = prev.pixels[loc];
      float r2 = red(prevColor);
      float g2 = green(prevColor);
      float b2 = blue(prevColor);
      //What is second previous color
      color prevprevColor = prevprev.pixels[loc];
      float r3 = red(prevprevColor);
      float g3 = green(prevprevColor);
      float b3 = blue(prevprevColor);


      float d_12 = distSq(r1, g1, b1, r2, g2, b2); 
      avg1 += d_12;
      d1++;
      float d_23 = distSq(r2, g2, b2, r3, g3, b3);
      avg2 += d_23;
      d2++;


      float rd12 = abs(r1 - r2);
      float gd12 = abs(g1 - g2);
      float bd12 = abs(b1 - b2);

      float rd23 = abs(r2 - r3);
      float gd23 = abs(g2 - g3);
      float bd23 = abs(b2 - b3);

      float acc = distSq(rd12, gd12, bd12, rd23, gd23, bd23);
      avg +=acc;
      d++;

      //color col = color(0, 0, 0);
      //if (d_12 > threshold1*threshold1) {
      //  pixels[loc] += color(255, 0, 0);
      //} else if (d_23 >threshold2*threshold2) {
      //  pixels[loc] += color(0, 255, 0);
      //} else if (acc >threshold_acc*threshold_acc) {
      //  pixels[loc] += color(0, 0, 255);
      //} else {
      //  pixels[loc] = col;
      //}
      pixels[loc] = color(abs(rd12-rd23), abs(gd12-gd23), abs(bd12-bd23));
      diff_1.pixels[loc] = color(abs(rd12-rd23), abs(gd12-gd23), abs(bd12-bd23));
    }
  }
  updatePixels();

  avg /=d;
  avg1 /= d1;
  avg2 /= d2;
  threshold_acc = floor(sqrt(avg));
  threshold1 = floor(sqrt(avg1));
  threshold2 = floor(sqrt(avg2));
  println(threshold_acc, threshold1, threshold2);




  image(diff_1, 0, 0, Width/2, Height/2);
  //image(prev, 0, Height/2, Width/2, Height/2);
  //image(prevprev, Width/2, 0, Width/2, Height/2);
}


float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}