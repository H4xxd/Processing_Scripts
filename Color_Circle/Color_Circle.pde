int r, g, b;
float a;
float x, y;
float speed;
int diameter;
float angle;
int r_d, g_d, b_d, a_d;

int counter;

void setup() {
  size(600, 600);
  //fullScreen();
  x = 0;
  y = 0;
  speed = 25;
  diameter = 0;
  angle = 0;
  counter = 0 ;
  
  ellipseMode(CORNERS);

  r = g = b = 1 ;
  a = 1.0;
  r_d = g_d = b_d = a_d = 1;
}

void draw() {
  if(counter%50 == 0 ){
    background(127);
    counter = 0;
  }
  translate(width/2, height/2);
  x=map(sin(angle), -1, 1, -speed, speed);
  y=map(cos(angle), -1, 1, -speed, speed);

  if (r <= 0 || r >= 255) {
      r_d *= -1;
  }
  if (g <= 0 || g >= 255) {
      g_d *= -1;
  }
  if (b <= 0 || b >= 255) {
      b_d *= -1;
  }
  if (a <= 0 || a >= 255) {
      a_d *= -1;
  }

    r+=(r_d*3);
    g+=(g_d*7);
    b+=(b_d*11);
    //a = map(sin(angle*13),-1,1,0,255);

    angle+= PI/91;
    speed+= PI/31;
    
    noStroke();
    fill(r,g,b);
    ellipse(x, y, diameter, diameter);
    
    counter++;
  }