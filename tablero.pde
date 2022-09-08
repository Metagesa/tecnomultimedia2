class Tablero {
  int cant = 10;
  PVector pp[] = new PVector[cant];
  //boolean po[] = new boolean[cant];
  Ficha fichas[] = new Ficha[3];
  ArrayList<Integer> poc = new ArrayList<Integer>();

  Tablero(boolean lado, Ficha[] f) {

    boolean columna = false;
    boolean fila = false;
    float variacion = height/(cant/2);

    fichas = f;

    for (int i = 0; i<cant; i++) {
      //po[i] = false;

      if (i == cant/2) {
        columna = true;
      }

      if (i == cant/4 || i == int(cant/4*3.5)) {
        fila = true;
      } else {
        fila = false;
      }

      if (lado) {
        pp[i] = new PVector(150, variacion/2+i*variacion);
      } else {
        pp[i] = new PVector(width-150, variacion/2+i*variacion);
      }
      if (columna) {
        pp[i].y -= cant/2*variacion;
        if (lado) {
          pp[i].x += 150;
        } else {
          pp[i].x -= 150;
        }
      }
      if (fila) {
        if (lado) {
          pp[i].x += 50;
        } else {
          pp[i].x -= 50;
        }
      }
    }
  }

  void checkPos(Ficha f, Ficha[]fa, float px, float py) {

    float[] dist = new float[cant];
    PVector pos = new PVector(px, py);
    float minDist = width*99999;
    PVector p = new PVector(0, 0);
    boolean po = false;
    
    fichas = fa;

    for (int i = 0; i<cant; i++) {
      dist[i] = pos.dist(pp[i]);
    }

    for (int i = 0; i<cant; i++) {
      if (dist[i] < minDist) {
        for (int j = 0; j<3; j++) {
          if (fichas[j].posEnTablero() == i) {
            po = true;
          }
        }
        if (!po) {
          minDist = dist[i];
          p.set(pp[i].x, pp[i].y);
          //po[i] = true;
          f.setPosEnTablero(i);
        }
      }
    }
    f.setPos(p.x, p.y, this);
  }
}
