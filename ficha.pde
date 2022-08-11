class Ficha {

  FCircle ficha;
  Canon disparo;
  Torre torre;
  FWorld mundo;
  color colFicha = color(255, 0, 0);
  boolean select = false;
  float tam = 50;
  float x = 0;
  float y = 0;

  boolean canon;

  float distribTorre = 8;
  float tamTorre = 5;

  float miraX;
  float miraY;

  float vida = 100;

  Ficha(FWorld w, color col) {
    mundo = w;
    colFicha = col;
    inicializar(col);
  }

  Ficha(FWorld w, float posX, float posY, float objX, float objY, color col, boolean c) {
    canon = c;
    colFicha = col;
    x = posX;
    y = posY;
    miraX = objX;
    miraY = objY;
    mundo = w;
    inicializar(col);
  }

  void inicializar(color col) {
    if (canon) {
      disparo = new Canon(mundo, 30);
    } else {
      torre = new Torre(mundo, x, y, distribTorre, col);
    }
    ficha = new FCircle(tam);
    ficha.setPosition(x, y);
    ficha.setStatic(true);
    ficha.setDrawable(false);
    if (canon) {
      mundo.add(ficha);
    }
  }

  void dibujar(color c) {
    x = ficha.getX();
    y = ficha.getY();
    if (canon) {
      dibujarCanon(c);
    } else {
      dibujarTorre();
      torre.actualizar();
    }
  }

  void dibujarCanon(color c) {
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

  void dibujarTorre() {
    push();
    if (select) {
      colFicha = color(200, 100, 100);
    } else {
      colFicha = color(128);
    }
    noFill();
    stroke(colFicha);
    strokeWeight(2);
    circle(x, y, tam*2);
    pop();
  }

  //void dibujarTorre() {
  //  push();
  //  if (select) {
  //    colFicha = color(200, 100, 100);
  //  } else {
  //    colFicha = color(128);
  //  }
  //  rectMode(CENTER);
  //  fill(colFicha);
  //  noStroke();
  //  rect(x-(tamTorre*distribTorre)/2, y, torre.tamano()*1.5, torre.tamano()*1.5);
  //  noFill();
  //  stroke(0);
  //  strokeWeight(2);
  //  rect(x-(tamTorre*distribTorre)/2, y, torre.tamano()*1.8, torre.tamano()*1.8);
  //  pop();
  //}

  void setPos(float posX, float posY) {
    if (canon) {
      ficha.setPosition(posX, posY);
    } else {
      ficha.setPosition(posX, posY);
      torre.mover(posX, posY);
    }
  }

  void seleccionar() {
    select = true;
  }

  void deSeleccionar() {
    select = false;
  }

  void altoFuego() {
    if (canon) {
      disparo.altoFuego();
    }
  }

  void abrirFuego() {
    if (canon) {
      disparo.abrirFuego();
    }
  }

  void disparo() {
    if (canon) {
      disparo.disparo(x, y, miraX, miraY);
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
      disparo.remover();
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
