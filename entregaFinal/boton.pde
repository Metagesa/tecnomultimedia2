class boton {

  PImage idle, hover;
  boolean h;
  float tam, posX, posY;

  boton(float t) {
    tam = t;
    idle = loadImage("boton.png");
    idle.resize(int(tam), 0);
    hover = loadImage("botonHover.png");
    hover.resize(int(tam), 0);
  }

  void draw(float x, float y) {
    posX = x;
    posY = y;
    push();
    imageMode(CENTER);
    if (mouseX > x - tam/2 && mouseX < x + tam/2 && mouseY > y - tam/5 && mouseY < y + tam/5) {
      image(hover, x, y);
      h = true;
    } else {
      image(idle, x, y);
      h = false;
    }
    pop();
  }

  boolean click() {
    if (mouseX > posX - tam/2 && mouseX < posX + tam/2 && mouseY > posY - tam/5 && mouseY < posY + tam/5) {
      h = false;
      return true;
    } else {
      return false;
    }
  }
}
