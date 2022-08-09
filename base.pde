class Base {

  FWorld mundo;
  float x, y, angulo;
  float tam = 20;
  int cant = 50;
  FBox[] cuerpo = new FBox[cant];
  float[] cuerpoX = new float[cant];
  float[] cuerpoY = new float[cant];

  Base(FWorld w, float posX, float posY, float ang) {
    float px = 0;
    float py = -tam/2;
    float distrib = 5;
    x = posX;
    y = posY-(cant/2*(tam/distrib));
    angulo = ang;
    mundo = w;
    for (int i = 0; i<cant; i++) {
      px = (i*tam)%(tam*distrib);
      if (i%distrib == 0) {
        px = 0;
        py += tam;
      }
      cuerpo[i] = new FBox(tam, tam);
      cuerpo[i].setPosition(x+px, y+py);
      cuerpo[i].setDensity(100);
      cuerpoX[i] = cuerpo[i].getX();
      cuerpoY[i] = cuerpo[i].getY();
      mundo.add(cuerpo[i]);
    }
  }

  void actualizar() {
    for (int i = 0; i<cant; i++) {
      if (dist(cuerpoX[i], cuerpoY[i], cuerpo[i].getX(), cuerpo[i].getY()) > tam*3) {
        mundo.remove(cuerpo[i]);
      }
    }
  }
}
