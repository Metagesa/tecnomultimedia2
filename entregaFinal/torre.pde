class Torre {
  FWorld mundo;
  float x, y;
  float tam;
  float muertes = 0;
  float vida = 100;
  float distrib;
  int cant;
  FBox[] cuerpo;
  float[] cuerpoX;
  float[] cuerpoY;

  Torre(FWorld w, float posX, float posY, float d, color c) {
    distrib = d;
    tam = d;
    cant = int(tam*tam);
    cuerpo = new FBox[cant];
    cuerpoX = new float[cant];
    cuerpoY = new float[cant];
    float px = 0;
    float py = -tam/2;
    x = posX-(tam*(distrib-1))/2;
    y = posY-(cant/2*(tam/distrib));
    mundo = w;
    for (int i = 0; i<cant; i++) {
      px = (i*tam)%(tam*distrib);
      if (i%distrib == 0) {
        px = 0;
        py += tam;
      }
      cuerpo[i] = new FBox(tam, tam);
      cuerpo[i].setPosition(x+px, y+py);
      cuerpo[i].setDensity(35000*2);
      cuerpo[i].setNoStroke();
      cuerpo[i].setFill(red(c), green(c), blue(c));
      cuerpo[i].setGrabbable(false);
      cuerpoX[i] = cuerpo[i].getX();
      cuerpoY[i] = cuerpo[i].getY();
      cuerpo[i].setName("estructura");
      mundo.add(cuerpo[i]);
    }
  }

  void actualizar() {
    for (int i = 0; i<cant; i++) {
      if (dist(cuerpoX[i], cuerpoY[i], cuerpo[i].getX(), cuerpo[i].getY()) > tam*3) {
        mundo.remove(cuerpo[i]);
        muertes++;
        vida = map(muertes, 0, cant, 100, 0);
        println(vida);
      }
    }
  }

  void mover(float paramX, float paramY) {
    float px = 0;
    float py = -tam/2;
    for (int i = 0; i<cant; i++) {
      px = (i*tam)%(tam*distrib);
      if (i%distrib == 0) {
        px = 0;
        py += tam;
      }
      float posX = px-(tam*(distrib-1))/2;
      float posY = py-(cant/2*(tam/distrib));
      cuerpo[i].setPosition(paramX+posX, paramY+posY);
      cuerpo[i].setVelocity(0, 0);
      cuerpoX[i] = cuerpo[i].getX();
      cuerpoY[i] = cuerpo[i].getY();
    }
  }

  float distribucion() {
    return distrib;
  }

  float tamano() {
    return (tam*cant)/distrib;
  }

  float vida() {
    return vida;
  }

  void remover(FWorld w) {
    for (int i = 0; i<cant; i++) {
      w.remove(cuerpo[i]);
    }
  }
}
