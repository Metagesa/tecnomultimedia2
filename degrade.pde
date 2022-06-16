class Degrade {
  float t;
  float ang;
  float x = 0;
  float y = 0;
  float velocidad;
  float dir;

  boolean mover = false;

  PImage deg1, deg2, deg3, deg4, deg5, deg6, deg7, deg8;
  //PImage b1, b2, b3, b4, b5, b6, b7, b8;

  int deg;

  Degrade() {
    t=10;
    ang = 0;
    x = width/2;
    y = height/2;
    deg1 = loadImage("d1.png");
    deg2 = loadImage("d2.png");
    deg3 = loadImage("d3.png");
    deg4 = loadImage("d4.png");
    deg5 = loadImage("d5.png");
    deg6 = loadImage("d6.png");
    deg7 = loadImage("d7.png");
    deg8 = loadImage("d8.png");

    //b1 = loadImage("b1.png");
    //b2 = loadImage("b2.png");
    //b3 = loadImage("b3.png");
    //b4 = loadImage("b4.png");
    //b5 = loadImage("b5.png");
    //b6 = loadImage("b6.png");
    //b7 = loadImage("b7.png");
    //b8 = loadImage("b8.png");
    imageMode(CENTER);

    deg = int(random(8));
  }

  void dibujar(float vel) {
    push();
    imageMode(CENTER);
    if (mover) {
      x = width/2+width/2*cos(radians(ang));
      y = height/2+height/2*sin(radians(ang));
      ang +=vel;
    }
    translate(x, y);
    rotate(radians(ang+HALF_PI));
    if (deg==1) {
      background(deg1.get(1, 1));
      image(deg1, 0, 0);
    } else if (deg==2) {
      background(deg2.get(1, 1));
      image(deg2, 0, 0);
    } else if (deg==3) {
      background(deg3.get(1, 1));
      image(deg3, 0, 0);
    } else if (deg==4) {
      background(deg4.get(1, 1));
      image(deg4, 0, 0);
    } else if (deg==5) {
      background(deg5.get(1, 1));
      image(deg5, 0, 0);
    } else if (deg==6) {
      background(deg6.get(1, 1));
      image(deg6, 0, 0);
    } else if (deg==7) {
      background(deg7.get(1, 1));
      image(deg7, 0, 0);
    } else if (deg==8) {
      background(deg8.get(1, 1));
      image(deg8, 0, 0);
    }
    pop();
  }

  void moverDegrade(boolean condicion) {
    mover = condicion;
  }

  //void iluminar() {
  //  push();
  //  imageMode(CENTER);
  //  translate(x, y);
  //  rotate(radians(ang+HALF_PI));
  //  if (deg==1) {
  //    image(b1, 0, 0);
  //  } else if (deg==2) {
  //    image(b2, 0, 0);
  //  } else if (deg==3) {
  //    image(b3, 0, 0);
  //  } else if (deg==4) {
  //    image(b4, 0, 0);
  //  } else if (deg==5) {
  //    image(b5, 0, 0);
  //  } else if (deg==6) {
  //    image(b6, 0, 0);
  //  } else if (deg==7) {
  //    image(b7, 0, 0);
  //  } else if (deg==8) {
  //    image(b8, 0, 0);
  //  }
  //  pop();
  //}

  boolean moviendo() {
    return mover;
  }

  void cambiarDeg() {
    if (deg < 8) {
      deg++;
    } else {
      deg=1;
    }
  }
}
