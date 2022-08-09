class Ficha {

  FCircle ficha;
  Canon disparo;
  FWorld mundo;
  color colFicha = color(255, 0, 0);
  boolean select = false;
  float tam = 50;
  float x = 0;
  float y = 0;

  float miraX;
  float miraY;

  float vida = 100;

  Ficha(FWorld w) {
    mundo = w;
    inicializar();
  }

  Ficha(FWorld w, float posX, float posY, float objX, float objY) {
    x = posX;
    y = posY;
    miraX = objX;
    miraY = objY;
    mundo = w;
    inicializar();
  }

  void inicializar() {
    disparo = new Canon(mundo, 30);
    ficha = new FCircle(tam);
    ficha.setPosition(x, y);
    ficha.setStatic(true);
    ficha.setDrawable(false);
    mundo.add(ficha);
  }

  void dibujar(color c) {
    x = ficha.getX();
    y = ficha.getY();
    push();
    noStroke();
    if (select) {
      colFicha = color(200, 100, 100);
    } else {
      colFicha = c;
    }
    fill(colFicha);
    circle(x, y, tam);
    pop();
  }

  void setPos(float posX, float posY) {
    ficha.setPosition(posX, posY);
  }

  void seleccionar() {
    select = true;
  }

  void deSeleccionar() {
    select = false;
  }

  void disparo() {
    disparo.disparo(x, y, miraX, miraY);
  }

  void apuntar(float objX, float objY) {
    miraX = objX;
    miraY = objY;
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

  FBody[] getFicha() {
    FBody[] f;
    f = new FBody[2];
    f[0] = disparo.getBala();
    f[1] = ficha;
    return f;
  }
}
