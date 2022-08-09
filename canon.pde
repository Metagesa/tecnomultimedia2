class Canon {

  FCircle bala;
  FWorld mundo;
  float angulo;

  //--------Constructor: inicializo la bala, cargo como parámetros el mundo y el tamaño
  //--------de la bala.
  Canon(FWorld w, float tam) {
    bala = new FCircle(tam);
    bala.setPosition(-width/2, -height/2);
    bala.setDensity(20);
    bala.setRestitution(0.5);
    mundo = w;
    mundo.add(bala); //agrego la bala al mundo
  }

  void impulsar() {
    //----setVelocity: mueve el FCircle bala a una cierta velocidad en x e y
    //usando seno y coseno hacemos que la velocidad dada sea hacia el angulo que usamos como
    //parametro.
    bala.setVelocity(cos(angulo)*1000, sin(angulo)*1000);
  }

  void disparo(float posX, float posY, float objX, float objY) {
    //calculamos el angulo de disparo
    angulo = atan2(objY-posY, objX-posX);
    //movemos la bala a la posición de la que sale (40 pixeles fuera del centro de la ficha)
    bala.setPosition(posX+(40*cos(angulo)), posY+(40*sin(angulo)));
    //le damos velocidad a la bala
    impulsar();
  }

  FBody getBala() {
    return bala;
  }
}
