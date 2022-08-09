class Jugador {

  FWorld mundo;
  Ficha c1, c2, c3;
  float sel = 0;
  boolean posicionando = false;  //variable para decidir si estamos en instacia de posicionar o no
  boolean apuntar = false;       //variable para decidir si estamos en instancia de apuntar

  Jugador(FWorld w, float px, float py, float objX, float objY, float adelanto) {
    mundo = w;
    c1 = new Ficha(mundo, px, py, objX, objY);
    c2 = new Ficha(mundo, px+adelanto, py*2, objX, objY);
    c3 = new Ficha(mundo, px, py*3, objX, objY);
  }

  void dibujar(color c) {
    c1.dibujar(c);
    c2.dibujar(c);
    c3.dibujar(c);
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

  void click() {
    if (posicionando && sel == 3) {        //si estoy en etapa de posición y con la pieza 3 seleccionada
      c3.setPos(mouseX, mouseY);           //posicionar sobre el mouse
    } else if (posicionando && sel == 2) { //si estoy en etapa de posición y con la pieza 2 seleccionada
      c2.setPos(mouseX, mouseY);           //posicionar sobre el mouse
    } else if (posicionando && sel == 1) { //si estoy en etapa de posición y con la pieza 1 seleccionada
      c1.setPos(mouseX, mouseY);           //posicionar sobre el mouse
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

  void tecla(char tecla, char p, char a) {
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
