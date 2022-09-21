class boton {

  PImage idle, hover;
  PFont lato;
  boolean h = false, hs = false;
  float tam, posX, posY;
  SoundFile  hoverFX, clickFX;

  boton(float t, PApplet app) {
    tam = t;
    idle = loadImage("boton.png");
    idle.resize(int(tam), 0);
    hover = loadImage("botonHover.png");
    hover.resize(int(tam), 0);
    lato = loadFont("Lato-Black-80.vlw");
    hoverFX = new SoundFile(app, "hover.wav", false);
    clickFX = new SoundFile(app, "click.wav", false);
  }

  void draw(float x, float y, String text) {
    posX = x;
    posY = y;
    push();
    textFont(lato);
    textAlign(CENTER, CENTER);
    textSize(tam/10);
    imageMode(CENTER);
    if (mouseX > x - tam/2 && mouseX < x + tam/2 && mouseY > y - tam/5 && mouseY < y + tam/5) {
      image(hover, x, y);
      if (!hs) {
        hoverFX.play();
        hs = true;
      }
      h = true;
    } else {
      image(idle, x, y);
      hs = false;
      h = false;
    }
    text(text, x, y);
    pop();
  }

  boolean click() {
    if (mouseX > posX - tam/2 && mouseX < posX + tam/2 && mouseY > posY - tam/5 && mouseY < posY + tam/5) {
      h = false;
      clickFX.play();
      return true;
    } else {
      return false;
    }
  }
}
