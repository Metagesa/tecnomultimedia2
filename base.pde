class Base {

  FWorld mundo;
  float x, y, angulo;
  float tam = 20;
  float muertes = 0;
  float vida = 100;
  int cant = 50;
  FBox[] cuerpo = new FBox[cant];
  float[] cuerpoX = new float[cant];
  float[] cuerpoY = new float[cant];

  Base(FWorld w, float posX, float posY, float ang, color c) {
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
      cuerpo[i].setDensity(20000);
      cuerpo[i].setNoStroke();
      cuerpo[i].setFill(red(c), green(c), blue(c));
      cuerpoX[i] = cuerpo[i].getX();
      cuerpoY[i] = cuerpo[i].getY();
      cuerpo[i].setName("estructura");
      mundo.add(cuerpo[i]);
    }
  }

  void dibujarVida(float posx, float posy, color c) {
    push();
    rectMode(CENTER);
    fill(0);
    noStroke();
    rect(posx, posy, 20, 200);
    fill(c);
    rect(posx, posy-map(vida, 0, 100, 100, 0), 20, map(vida, 0, 100, 0, 200));
    pop();
  }

  void actualizar() {
    for (int i = 0; i<cant; i++) {
      if (dist(cuerpoX[i], cuerpoY[i], cuerpo[i].getX(), cuerpo[i].getY()) > tam*3) {
        mundo.remove(cuerpo[i]);
        muertes++;
        vida = map(muertes, 0, 50, 100, 0);
        println(vida);
      }
    }
  }

  float vida() {
    return vida;
  }
}
