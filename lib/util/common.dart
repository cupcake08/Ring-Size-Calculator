class Common {
  Common._();

  static int getTheRightSize(double size) {
    int x = 6;
    if (size >= 14.2 && size < 14.6) {
      x = 6;
    } else if (size >= 14.6 && size < 14.9) {
      x = 7;
    } else if (size >= 14.9 && size <= 15.2) {
      x = 8;
    } else if (size > 15.2 && size <= 15.6) {
      x = 9;
    } else if (size > 15.6 && size <= 15.8) {
      x = 10;
    } else if (size > 15.8 && size <= 16.2) {
      x = 11;
    } else if (size > 16.2 && size <= 16.4) {
      x = 12;
    } else if (size > 16.4 && size <= 16.75) {
      x = 13;
    } else if (size > 16.75 && size <= 16.95) {
      x = 14;
    } else if (size > 16.95 && size <= 17.45) {
      x = 15;
    } else if (size > 17.45 && size <= 17.65) {
      x = 16;
    } else if (size > 17.65 && size <= 18.05) {
      x = 17;
    } else if (size > 18.05 && size <= 18.25) {
      x = 18;
    } else if (size > 18.25 && size <= 18.75) {
      x = 19;
    } else if (size > 18.75 && size <= 18.95) {
      x = 20;
    } else if (size > 18.95 && size <= 19.35) {
      x = 21;
    } else if (size > 19.35 && size <= 19.65) {
      x = 22;
    } else if (size > 19.65 && size <= 19.95) {
      x = 23;
    } else if (size > 19.95 && size <= 20.25) {
      x = 24;
    } else if (size > 20.25 && size <= 20.65) {
      x = 25;
    } else if (size > 20.65) {
      x = 26;
    }
    return x;
  }
}
