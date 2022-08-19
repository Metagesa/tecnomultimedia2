class Tablero {
  int cant = 10;
  PVector pp[] = new PVector[cant];

  Tablero(boolean lado) {
    boolean columna = false;
    boolean fila = false;
    float variacion = height/(cant/2);

    for (int i = 0; i<cant; i++) {
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

  void checkPos(Ficha f, float px, float py) {

    float[] dist = new float[cant];
    PVector pos = new PVector(px, py);
    float minDist = width*99999;
    PVector p = new PVector(0, 0);


    for (int i = 0; i<cant; i++) {
      dist[i] = pos.dist(pp[i]);
    }

    for (int i = 0; i<cant; i++) {
      if (dist[i] < minDist) {
        minDist = dist[i];
        p.set(pp[i].x, pp[i].y);
      }
    }

    f.setPos(p.x, p.y);
  }
}
