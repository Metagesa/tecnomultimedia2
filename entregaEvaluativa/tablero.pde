class tablero {

  PImage tablero, mascara;
  PGraphics bordes;
  FWorld mundo;

  FBox izquierdaAbajo;
  FBox izquierdaArriba;
  FBox izquierdaArribaLat;
  FBox izquierdaAbajoLat;
  FBox izquierdaArribaDiag;
  FBox izquierdaAbajoDiag;

  FBox derechaAbajo;
  FBox derechaArriba;
  FBox derechaArribaLat;
  FBox derechaAbajoLat;
  FBox derechaArribaDiag;
  FBox derechaAbajoDiag;

  tablero(FWorld w) {
    mundo = w;
    tablero = loadImage("tableroSinBlanco.png");
    tablero.resize(width, height);

    mascara = loadImage("tableroSoloBlanco.png");
    mascara.resize(width, height);

    bordes = createGraphics(tablero.width, tablero.height);

    izquierda();
    derecha();
  }

  void draw(color c) {
    push();
    imageMode(CENTER);
    image(tablero, width/2, height/2);
    
    bordes.beginDraw();
    bordes.clear();
    bordes.fill(c);
    bordes.noStroke();
    bordes.rect(0, 0, width, height);
    bordes.endDraw();
    bordes.mask(mascara);
    image(bordes, width/2, height/2);
    pop();
  }

  void derecha() {
    derechaAbajo = new FBox(20, 180);
    derechaAbajo.setPosition(1200, 110);
    derechaAbajo.setStatic(true);
    derechaAbajo.setGrabbable(false);

    derechaArriba = new FBox(20, 180);
    derechaArriba.setPosition(1200, 606);
    derechaArriba.setStatic(true);
    derechaArriba.setGrabbable(false);

    derechaArribaLat = new FBox(250, 20);
    derechaArribaLat.setPosition(1065, 55);
    derechaArribaLat.setStatic(true);
    derechaArribaLat.setGrabbable(false);

    derechaAbajoLat = new FBox(250, 20);
    derechaAbajoLat.setPosition(1065, 665);
    derechaAbajoLat.setStatic(true);
    derechaAbajoLat.setGrabbable(false);

    derechaArribaDiag = new FBox(130, 40);
    derechaArribaDiag.setPosition(880, 20);
    derechaArribaDiag.setRotation(radians(25));
    derechaArribaDiag.setStatic(true);
    derechaArribaDiag.setGrabbable(false);

    derechaAbajoDiag = new FBox(130, 40);
    derechaAbajoDiag.setPosition(880, height-20);
    derechaAbajoDiag.setRotation(radians(-25));
    derechaAbajoDiag.setStatic(true);
    derechaAbajoDiag.setGrabbable(false);

    //------------------

    derechaAbajo.setDrawable(false);
    derechaArriba.setDrawable(false);
    derechaArribaLat.setDrawable(false);
    derechaAbajoLat.setDrawable(false);
    derechaArribaDiag.setDrawable(false);
    derechaAbajoDiag.setDrawable(false);

    //-----------------

    mundo.add(derechaAbajo);
    mundo.add(derechaArriba);
    mundo.add(derechaArribaLat);
    mundo.add(derechaAbajoLat);
    mundo.add(derechaArribaDiag);
    mundo.add(derechaAbajoDiag);
  }

  void izquierda() {
    izquierdaAbajo = new FBox(20, 180);
    izquierdaAbajo.setPosition(80, 110);
    izquierdaAbajo.setStatic(true);
    izquierdaAbajo.setGrabbable(false);

    izquierdaArriba = new FBox(20, 180);
    izquierdaArriba.setPosition(80, 606);
    izquierdaArriba.setStatic(true);
    izquierdaArriba.setGrabbable(false);

    izquierdaArribaLat = new FBox(250, 20);
    izquierdaArribaLat.setPosition(215, 55);
    izquierdaArribaLat.setStatic(true);
    izquierdaArribaLat.setGrabbable(false);

    izquierdaAbajoLat = new FBox(250, 20);
    izquierdaAbajoLat.setPosition(215, 665);
    izquierdaAbajoLat.setStatic(true);
    izquierdaAbajoLat.setGrabbable(false);

    izquierdaArribaDiag = new FBox(130, 40);
    izquierdaArribaDiag.setPosition(400, 20);
    izquierdaArribaDiag.setRotation(radians(-25));
    izquierdaArribaDiag.setStatic(true);
    izquierdaArribaDiag.setGrabbable(false);

    izquierdaAbajoDiag = new FBox(130, 40);
    izquierdaAbajoDiag.setPosition(400, height-20);
    izquierdaAbajoDiag.setRotation(radians(25));
    izquierdaAbajoDiag.setStatic(true);
    izquierdaAbajoDiag.setGrabbable(false);

    //------------------

    izquierdaAbajo.setDrawable(false);
    izquierdaArriba.setDrawable(false);
    izquierdaArribaLat.setDrawable(false);
    izquierdaAbajoLat.setDrawable(false);
    izquierdaArribaDiag.setDrawable(false);
    izquierdaAbajoDiag.setDrawable(false);

    //-----------------

    mundo.add(izquierdaAbajo);
    mundo.add(izquierdaArriba);
    mundo.add(izquierdaArribaLat);
    mundo.add(izquierdaAbajoLat);
    mundo.add(izquierdaArribaDiag);
    mundo.add(izquierdaAbajoDiag);
  }
}
