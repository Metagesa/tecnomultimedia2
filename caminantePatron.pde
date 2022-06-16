class patron {

  float x, y, w, h, velX, velY;
  float ang;
  float mover = 0;
  PImage patron;
  boolean sombraLuz = false;

  patron(float posX, float posY, PImage p) {
    x = posX;
    y = posY;
    patron = p;
    w = patron.width;
    h = patron.height;
    velX = 8;
    velY = 0;
    ang = 0;
  }

  void drawPat() {
    push();
    translate(x-width, y-height);
    image(patron, 0, 0);
    pop();
  }

  void posicionar(int indW, int indH, float mov) {
    x = w*indW+mov%w;
    y = h*indH+mov%w;
  }

  void sombreado() {
    sombraLuz = true;
  }

  float darAncho() {
    return patron.width;
  }

  float darAlto() {
    return patron.height;
  }
}
