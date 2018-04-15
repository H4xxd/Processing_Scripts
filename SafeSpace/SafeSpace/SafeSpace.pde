PFont Helvetica_bold;
//PFont RNDFont;

ArrayList<String> Text = new ArrayList<String>();

int height_total = 0 ;
int y_margin = 10;
int x_margin = 10;

void Print(ArrayList<String> Text) {
  height_total = y_margin;

  int textsize = 0;
  float box_width = width-(2*x_margin);
  for ( String s : Text) {
    for (int h = 20; h <= 1000; h+= 1) {
      textSize(h);
      float b = textWidth(s);
      if (b <= box_width) {
        textsize = h;
      }
    }
    textSize(textsize);
    int box_height = textsize+1;
    text(s, x_margin, height_total, box_width, box_height);
    height_total += textsize-(width/15);
  }
  println(height_total, height);
}


void setup() {

  //String[] fontList = PFont.list();
  //int rnd = floor(random(fontList.length));
  //RNDFont = createFont(fontList[rnd], 32);
  //textFont(RNDFont);
  //println(fontList[rnd]);
  //printArray(fontList);

  Helvetica_bold = createFont("Helvetica-Bold", 32);
  textFont(Helvetica_bold);

  String s1 = "HIER";
  String s2 = "IST EIN";
  String s3 = "SAFE";
  String s4 = "SPACE";

  Text.add(s1);
  Text.add(s2);
  Text.add(s3);
  Text.add(s4);

  size(1000, 1100);
  fill(255, 0, 255);
  background(0, 255, 255);
  Print(Text);

  save("safespace.png");
}