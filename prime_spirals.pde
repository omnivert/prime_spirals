
int side = 500;
int limit = (int)sq(side);
int turn = 2;
int x_offset = 0;
int y_offset = 0;
int xval = 0;
int yval = 0;
int count = 0;
int arrcount = 0;
int[] primelist = new int[limit];
double[] test = {-2.00, 0.80, -1.40, 1.40};

void prime_spiral() {
    for (int i = 0; i < limit; i++) {
    if (turn % 4 == 0) {
      turn = 0;
      if (xval == x_offset) {
        turn++;
        x_offset++;
      }
      else {
        xval++;
      }
    }
    else if (turn % 4 == 1) {
      if (yval == y_offset) {
        turn++;
        y_offset++;
      }
      else {
        yval++;
      }
    }
    else if (turn % 4 == 2) {
      if (abs(xval) == x_offset) {
        turn++;
      }
      else {
        xval--;
      }
    }
    else {
      if (abs(yval) == y_offset) {
        turn++;
      }
      else {
        yval--;
      }
    }
    if (i == primelist[count]) {
      count++;
      stroke(0);
      point((side/2)+xval,(side/2)+yval);
    }
  }
}

void mandelbrot() {
  colorMode(RGB, 255);
  double pixel_width = (test[1] - test[0]) / side;
  double pixel_height = (test[3] - test[2]) / side;
  double cur_x;
  double cur_y;
  int[] pixels = new int[3];
  for (int i = 0; i < side; i++) {
    cur_y = test[2] + (i + 1) * pixel_height;
    for (int j = 0; j < side; j++) {
      cur_x = test[0] + (j + 1) * pixel_width;
      pixels = gen_pixel_color(cur_x, cur_y);
      stroke(pixels[0], pixels[1], pixels[2]);
      point(j, i);
    }
  }
}

int[] gen_pixel_color(double x, double y) {
  int[] retval = {70, 50, 230};
  int mandelcount = 0;
  double precolor = 0.0;
  double a = 0.0;
  double b = 0.0;
  double newa = 0.0;
  double newb = 0.0;
  
  while (mandelcount < 500) {
    mandelcount++;
    newa = a * a - b * b + x;
    newb = 2 * a * b + y;
    a = newa;
    b = newb;
    if (a * a + b * b > 100.0) {
      break;
    }
  }
  if (mandelcount == 500) {
    return retval;
  }
  else {
    if (mandelcount < 50) {
      precolor = mandelcount + 50;
    }
    else if (mandelcount < 100) {
      precolor = mandelcount + 55;
    }
    else if (mandelcount < 350) {
      precolor = mandelcount + 80;
    }
    retval[0] = (int)(precolor / 500 * 120);
    retval[1] = (int)(precolor / 500 * 255);
    retval[2] = (int)(precolor / 500 * 180);
    return retval;
  }
}

void setup() {
  size(side,side);
  noStroke();
  background(255);  
  
  String[] lines = loadStrings("primes1000000.txt");
  for (int i = 0; i < lines.length; i++) {
    String[] templist = split(lines[i], ' ');
    for (int j = 0; j < templist.length; j++) {
      if (!templist[j].equals("")) {
        primelist[arrcount] = Integer.valueOf(templist[j]).intValue();
        //print("\"" + templist[j] + "\":" + arrcount + "\t");
        arrcount++;
      }
    }
  }
}

void draw() {
  mandelbrot();
}
