class Canon {

  float tam;
  FWorld mundo;
  float angulo;
  FCircle bala;

  //--------Constructor: inicializo la bala, cargo como parámetros el mundo y el tamaño
  //--------de la bala.
  Canon(FWorld w, float t) {
    mundo = w;
    tam = t;
    bala = new FCircle(tam);
    bala.setDensity(2500);
    bala.setRestitution(0.5);
    bala.setPosition(-width, -height);
    mundo.add(bala);
  }

  void impulsar(FBody b) {
    //----setVelocity: mueve el FCircle bala a una cierta velocidad en x e y
    //usando seno y coseno hacemos que la velocidad dada sea hacia el angulo que usamos como
    //parametro.
    b.setVelocity(cos(angulo)*1000, sin(angulo)*1000);
  }

  void disparo(float posX, float posY, float objX, float objY) {
    //calculamos el angulo de disparo
    angulo = atan2(objY-posY, objX-posX);
    //movemos la bala a la posición de la que sale (40 pixeles fuera del centro de la ficha)
    bala.setPosition(posX+(40*cos(angulo)), posY+(40*sin(angulo)));
    //le damos velocidad a la bala
    impulsar(bala);
  }

  void actualizar() {
  }

  void altoFuego() {
    bala.removeFromWorld();
  }

  void abrirFuego() {
    bala.removeFromWorld();
    mundo.add(bala);
  }

  void remover() {
    bala.setPosition(-width, -height);
    mundo.remove(bala);
  }
}
