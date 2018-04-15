import themidibus.*;

MidiBus myBus;

Circle myCirc_inner, myCirc_outer, myCirc_inner2;

ArrayList<Circle> circles;

int number_of_circles;
int number_of_points;

void setup() {
  //size(600, 600);
  fullScreen();
  frameRate(60);
  smooth();
  colorMode(HSB);

  //myBus = new MidiBus(this, "Arturia BeatStepPro", "Arturia BeatStepPro");

  number_of_points =3;
  number_of_circles = 100;
  //float w = sqrt(width/2*width/2+height/2*height/2);
  float w = height/2-10;
  float s =number_of_circles/(2*number_of_points);
  circles = new ArrayList<Circle>();

  for (int i = 0; i < number_of_circles; i++) {
    float wid = w-(w/number_of_circles)*i;
    float dir = pow(-1, i);
    float speed = s- (s/number_of_circles)*i;
    Circle circ = new Circle(wid, number_of_points, dir, speed, 0, 255, 0);
    circles.add(i, circ);
  }
}

void draw() {
  background(0);
  translate(width/2, height/2);

  for (int i = 0; i < circles.size(); i++) {
    circles.get(i).update();
    if (i < circles.size()-1) {
      circles.get(i).connect(circles.get(i+1));
    }
    circles.get(i).show();
  }

  //if (frameCount <= 500) {
  //  println(frameCount);
  //  TImage frame = new TImage(width, height, RGB, sketchPath("frame_"+nf(frameCount, 3)+".png"));
  //  frame.set(0, 0, get());
  //  frame.saveThreaded();
  //}
}

void update_n(int new_n, int pos, ArrayList<Circle> circs) {
  float r = circs.get(pos).radius;
  float d = circs.get(pos).direction;
  float s = circs.get(pos).speed;
  float t_off = circs.get(pos).theta_offset;
  float alpha = circs.get(pos).alpha;
  float col = circs.get(pos).col_offset;
  Circle new_circ = new Circle(r, new_n, d, s, t_off, alpha, col);
  circs.set(pos, new_circ);
}

void noteOn(int c, int p, int v) {
  for (int i = 0; i < circles.size(); i++) {
    switch(c) {
    case 1:
      if (i%2 ==0) {
        update_n(p%12+1, i, circles);
      }
      break;
    case 2:
      if (i%2 == 1) {
        update_n(p%12+1, i, circles);
      }
      break;
    }
  }
}

void controllerChange(int c, int n, int v) {
  for (int i = 0; i < circles.size(); i++) {
    switch(n) {
    case 102:
      if (i%2 == 0) {
        circles.get(i).change_alpha(v);
      }
      break;
    case 103:
      if (i%2 == 1) {
        circles.get(i).change_alpha(v);
      }
      break;
    case 115:
      if (i%2 == 0) {
        circles.get(i).change_col_offset(v);
      }
      break;
    case 116: 
      if (i%2 == 1) {
        circles.get(i).change_col_offset(v);
      }
      break;
    }
  }
}


class TImage extends PImage implements Runnable {//separate thread for saving images
  String filename;

  TImage(int w, int h, int format, String filename) {
    this.filename = filename;
    init(w, h, format);
  }

  public void saveThreaded() {
    new Thread(this).start();
  }

  public void run() {
    this.save(filename);
  }
}