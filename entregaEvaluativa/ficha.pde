class Ficha {

  FBox ficha;
  Canon disparo;
  Torre torre;
  FWorld mundo;

  PImage torreta;

  Ficha fichas[] = new Ficha[3];

  color colFicha = color(255, 0, 0);
  boolean select = false;
  float tam = 120;
  float x = 0;
  float y = 0;

  boolean canon;
  boolean destruido = false;

  float impactos = 0;

  float distribTorre = 8;
  float tamTorre = 5;

  float miraX;
  float miraY;

  boolean esRojo, esAzul;

  int posicionTablero = -1;

  float vida = 100;

  Ficha(FWorld w, float posX, float posY, float objX, float objY, color col, boolean c) {
    canon = c;
    colFicha = col;
    x = posX;
    y = posY;
    if (x>width/2) {
      esAzul = true;
      esRojo = false;
      torreta = loadImage("torretaAzul.png");
    } else {
      esRojo = true;
      esAzul = false;
      torreta = loadImage("torretaRoja.png");
    }
    torreta.resize(int(tam), 0);
    miraX = objX;
    miraY = objY;
    mundo = w;
    inicializar(col);
  }

  void inicializar(color col) {
    if (canon) {
      disparo = new Canon(mundo, 30, col, esRojo);
    } else {
      torre = new Torre(mundo, x, y, distribTorre, col);
    }
    ficha = new FBox(tam, tam/6);
    ficha.setPosition(x, y);
    ficha.setStatic(true);
    ficha.setDrawable(false);
    ficha.setName("canon");
    if (canon) {
      mundo.add(ficha);
    }
  }

  void reiniciar() {
    if (canon) {
      revivirCanon();
      mundo.remove(ficha);
    } else {
      torre.remover(mundo);
    }
    inicializar(colFicha);
  }

  void dibujar(color c) {
    x = ficha.getX();
    y = ficha.getY();
    if (canon) {
      dibujarCanon(c);
    } else {
      dibujarTorre(c);
      torre.actualizar();
    }
  }

  void dibujarCanon(color c) {
    push();
    if (select) {
      tint(255, 0, 255);
      if (destruido) {
        tint(128, 0, 128);
      }
    } else {
      tint(255);
      if (destruido) {
        tint(128);
      }
    }
    imageMode(CENTER);
    translate(x, y);
    rotate(PI+atan2(miraY-y, miraX-x));
    image(torreta, 0, 0);
    pop();
  }

  void destruirCanon() {
    destruido = true;
    ficha.setSensor(true);
  }

  void atacarCanon() {
    if (impactos < 2) {
      impactos++;
    } else {
      destruirCanon();
      impactos = 0;
    }
  }

  void revivirCanon() {
    destruido = false;
    ficha.setSensor(false);
  }

  void dibujarTorre(color c) {
    push();
    if (select) {
      colFicha = color(200, 100, 100);
    } else {
      colFicha = color(c);
    }
    float tamVida = tamTorre*tamTorre*(distribTorre/2);
    noFill();
    stroke(0);
    strokeWeight(4);
    circle(x, y, tamVida);
    stroke(c);
    arc(x, y, tamVida, tamVida, 0, map(torre.vida(), 0, 100, 0, TWO_PI));
    pop();
  }

  void setPos(float posX, float posY) {
    if (canon) {
      ficha.setPosition(posX, posY);
    } else {
      ficha.setPosition(posX, posY);
      torre.mover(posX, posY);
    }
    x = posX;
    y = posY;
  }

  void setPosEnTablero(int posT) {
    posicionTablero = posT;
  }

  int posEnTablero() {
    return posicionTablero;
  }

  void seleccionar() {
    select = true;
  }

  void deSeleccionar() {
    select = false;
  }

  void disparo(ArrayList bal) {
    if (canon) {
      if (!destruido) {
        disparo.disparo(x, y, miraX, miraY, bal);
      }
    }
  }

  void apuntar(float objX, float objY) {
    miraX = objX;
    miraY = objY;
  }

  void cambioFicha(FWorld w) {
    canon = !canon;
    if (canon) {
      torre.remover(w);
    } else {
      w.remove(ficha);
    }
    inicializar(colFicha);
  }

  boolean select() {
    return select;
  }

  float posX() {
    return x;
  }

  float posY() {
    return y;
  }
}
