class Jugador {

  FWorld mundo;
  SoundFile laser;
  Ficha c1, c2, c3;
  Base base;
  ArrayList <FCircle> balas;
  float sel = 0;
  float adelanto;
  color jugadorCol;
  boolean j1;
  boolean posicionando = false;  //variable para decidir si estamos en instacia de posicionar o no
  boolean apuntar = false;       //variable para decidir si estamos en instancia de apuntar
  boolean etapaPos = false;

  Jugador(PApplet app, FWorld w, float px, float py, float objX, float objY, float a, float bPos, boolean j) {
    mundo = w;
    laser = new SoundFile(app, "lasers.wav", false);
    adelanto = a;
    j1 = j;
    if (j1) {
      jugadorCol = color(255, 0, 0);
      posicionando = true;
      etapaPos = true;
    } else {
      jugadorCol = color(0, 0, 255);
    }
    c1 = new Ficha(mundo, px, py, objX, objY, jugadorCol, false);
    c2 = new Ficha(mundo, px+adelanto, py*2, objX, objY, jugadorCol, true);
    c3 = new Ficha(mundo, px, py*3, objX, objY, jugadorCol, false);
    base = new Base(mundo, bPos, height/2, 5, jugadorCol);
    balas = new ArrayList<FCircle>();
  }

  void dibujar() {
    if (frameCount%1200 == 0) {
      if (j1) {
        if (!etapaPos) {
          posicionando = false;
          apuntar = false;
          select (c1, false);
          select (c2, false);
          select (c3, false);
        } else {
          posicionando = true;
          select (c2, true);
        }
      } else {
        posicionando = false;
        apuntar = false;
      }
    }

    c1.dibujar(jugadorCol);
    c2.dibujar(jugadorCol);
    c3.dibujar(jugadorCol);
    base.actualizar();
    base.dibujarVida(width/2-adelanto, 50, jugadorCol);
    if (!etapaPos && frameCount%180 == 0) {
      disparar();
    }
  }

  void cambioEtapa() {
    etapaPos = !etapaPos;
  }

  void cambioEtapa(boolean b) {
    etapaPos = b;
  }

  void disparar() {
    c1.disparo(balas);   //disparar la ficha 1
    c2.disparo(balas);   //disparar la ficha 2
    c3.disparo(balas);   //disparar la ficha 3
    if (laser.isPlaying() == false) {
      laser.play();
    }
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
    return (etapaPos);
  }

  //void frenar() {
  //  c1.altoFuego();
  //  c2.altoFuego();
  //  c3.altoFuego();
  //}

  //void reanudar() {
  //  c1.abrirFuego();
  //  c2.abrirFuego();
  //  c3.abrirFuego();
  //}

  void click() {
    if (posicionando && sel == 3) {        //si estoy en etapa de posición y con la pieza 3 seleccionada
      if ((j1 && mouseX < width/2) || (!j1 && mouseX > width/2)) {
        c3.setPos(mouseX, mouseY);       //posicionar sobre el mouse
      }
    } else if (posicionando && sel == 2) { //si estoy en etapa de posición y con la pieza 2 seleccionada
      if ((j1 && mouseX < width/2) || (!j1 && mouseX > width/2)) {
        c2.setPos(mouseX, mouseY);           //posicionar sobre el mouse
      }
    } else if (posicionando && sel == 1) { //si estoy en etapa de posición y con la pieza 1 seleccionada
      if ((j1 && mouseX < width/2) || (!j1 && mouseX > width/2)) {
        c1.setPos(mouseX, mouseY);           //posicionar sobre el mouse
      }
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
    if (etapaPos) {
      if (tecla == p) {
        posicionando = true;
        apuntar = false;
      } else if (tecla == a) {
        posicionando = false;
        apuntar = true;
      } else if (tecla == x) {
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

  float vida() {
    return base.vida();
  }

  ArrayList balas() {
    return balas;
  }
}
