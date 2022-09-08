class Jugador {

  FWorld mundo;
  Ficha c1, c2, c3;
  Ficha fichas[] = new Ficha[]{c1, c2, c3};
  Base base;
  Tablero t;
  float sel = 0;
  float adelanto;
  color jugadorCol;
  boolean posicionando = false;  //variable para decidir si estamos en instacia de posicionar o no
  boolean apuntar = false;       //variable para decidir si estamos en instancia de apuntar

  Jugador(FWorld w, float px, float py, float objX, float objY, float a, float bPos, boolean j1) {
    mundo = w;
    adelanto = a;
    if (j1) {
      jugadorCol = color(255, 0, 0);
    } else {
      jugadorCol = color(0, 0, 255);
    }
    t = new Tablero(j1, fichas);
    c1 = new Ficha(mundo, fichas, px, py, objX, objY, jugadorCol, false, t);
    c2 = new Ficha(mundo, fichas, px+adelanto, py*2, objX, objY, jugadorCol, true, t);
    c3 = new Ficha(mundo, fichas, px, py*3, objX, objY, jugadorCol, false, t);
    base = new Base(mundo, bPos, height/2, 5, jugadorCol);
  }

  void dibujar() {
    c1.dibujar(jugadorCol);
    c2.dibujar(jugadorCol);
    c3.dibujar(jugadorCol);
    base.actualizar();
    base.dibujarVida(width/2-adelanto, 50, jugadorCol);
    fichas = new Ficha[]{c1, c2, c3};
    //if (frameCount%180 == 0 && !posicionando && !apuntar) {
    //  disparar(); //disparan las fichas
    //}
  }

  void disparar() {
    c1.disparo();   //disparar la ficha 1
    c2.disparo();   //disparar la ficha 2
    c3.disparo();   //disparar la ficha 3
  }

  void select(Ficha c, boolean sel) {    //función para seleccionar/deseleccionar fichas
    if (sel) {
      c.seleccionar();
    } else {
      c.deSeleccionar();
    }
  }

  void deSeleccionar() {
    select(c1, false);
    select(c2, false);
    select(c3, false);
    posicionando = false;
    apuntar = false;
  }

  boolean frenado() {
    return (posicionando || apuntar);
  }

  void frenar() {
    c1.altoFuego();
    c2.altoFuego();
    c3.altoFuego();
  }

  void reanudar() {
    c1.abrirFuego();
    c2.abrirFuego();
    c3.abrirFuego();
  }

  void click() {
    if (posicionando && sel == 3) {        //si estoy en etapa de posición y con la pieza 3 seleccionada
      c3.setPos(mouseX, mouseY, t);           //posicionar sobre el mouse
      t.checkPos(c3, fichas, c3.posX(), c3.posY());
    } else if (posicionando && sel == 2) { //si estoy en etapa de posición y con la pieza 2 seleccionada
      c2.setPos(mouseX, mouseY, t);           //posicionar sobre el mouse
      t.checkPos(c2, fichas, c2.posX(), c2.posY());
    } else if (posicionando && sel == 1) { //si estoy en etapa de posición y con la pieza 1 seleccionada
      c1.setPos(mouseX, mouseY, t);           //posicionar sobre el mouse
      t.checkPos(c1, fichas, c1.posX(), c1.posY());
    } else {
      //c1.disparo();      //no usar de esta forma, era una prueba
      //c2.disparo();      //no usar de esta forma, era una prueba
      //c3.disparo();      //no usar de esta forma, era una prueba
    }
    if (apuntar && sel == 3) {        //si estoy en etapa de apuntado y con la pieza 3 seleccionada
      c3.apuntar(mouseX, mouseY);       //apuntar hacia el mouse
    } else if (apuntar && sel == 2) { //si estoy en etapa de apuntado y con la pieza 2 seleccionada
      c2.apuntar(mouseX, mouseY);       //apuntar hacia el mouse
    } else if (apuntar && sel == 1) { //si estoy en etapa de apuntado y con la pieza 1 seleccionada
      c1.apuntar(mouseX, mouseY);       //apuntar hacia el mouse
    }
  }

  void tecla(FWorld w, char tecla, char p, char a, char x) {
    if (tecla == p) {
      //--------entro en modo de posicionar---------
      posicionando = !posicionando;
      if (posicionando && apuntar) {
        apuntar = false;
      }
      //---------si no estoy posicionando, deselecciono todas las fichas-------
      if (!posicionando) {
        select(c1, false);
        select(c2, false);
        select(c3, false);
      }
    } else if (tecla == a) {
      apuntar = !apuntar;
      if (apuntar && posicionando) {
        posicionando = false;
      }
      if (!apuntar) {
        select(c1, false);
        select(c2, false);
        select(c3, false);
      }
    } else if (tecla == x) {
      println("si");
      if (posicionando || apuntar) {
        if (sel==1) {
          c1.cambioFicha(w);
        }
        if (sel==2) {
          c2.cambioFicha(w);
        }
        if (sel==3) {
          c3.cambioFicha(w);
        }
      }
    }
  }

  void teclaSel(char tecla) {
    //-------------si estoy posicionando---------
    if (posicionando || apuntar) {
      //-----------y presiono la tecla 1-----------
      if (tecla == '1') {
        //-----------selecciono la ficha c1 y deselecciono las otras---------
        sel = 1;
        select(c1, true);
        select(c2, false);
        select(c3, false);
      }
      //-----------y presiono la tecla 2----------
      if (tecla == '2') {
        //-----------selecciono la ficha c2 y deselecciono las otras---------
        sel = 2;
        select(c1, false);
        select(c2, true);
        select(c3, false);
      }
      //-----------y presiono la tecla 3----------
      if (tecla == '3') {
        //-----------selecciono la ficha c3 y deselecciono las otras---------
        sel = 3;
        select(c1, false);
        select(c2, false);
        select(c3, true);
      }
    }
  }
}
