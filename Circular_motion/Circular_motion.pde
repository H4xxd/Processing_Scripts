ArrayList<Circle> circs;

int num_of_points;

void setup() {
  size(600, 600);
  frameRate(60);
  colorMode(HSB);
  num_of_points = 10;

  circs = new ArrayList<Circle>();
  float step = 300/num_of_points;
  for (int i = 0; i < num_of_points; i++) {
    Circle circ = new Circle(5, 300-step*i, 100, random(0.01, 0.05), (TWO_PI/num_of_points)*i, pow(-1, i));
    circs.add(circ);
  }
}

void draw() {
  translate(width/2, height/2);
  background(0);
  for (Circle circ : circs) {
    circ.show();
    circ.update();
  }
  //noLoop();
}