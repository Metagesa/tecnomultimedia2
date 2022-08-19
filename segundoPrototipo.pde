import fisica.*;

FWorld mundo;                  //DECLARO EL MUNDO
boolean posicionando = true;  //variable para decidir si estamos en instacia de posicionar o no
boolean apuntar = false;       //variable para decidir si estamos en instancia de apuntar
float sel = 0;                 //variable para ver qué ficha está seleccionada
Jugador p1, p2;

FBox[] pared = new FBox[10];

void setup() {

  //-----configuración de pantalla---------

  fullScreen();
  surface.setSize(900, 700);
  surface.setLocation(displayWidth/2-width/2, displayHeight/2-int(height/1.9));

  //-----inicializo fisica, el mundo (sacando la gravedad y poniendo los bordes), y las fichas---------
  Fisica.init(this);
  mundo = new FWorld();
  mundo.setGravity(0, 0);
  mundo.setEdges();

  //------inicializo el jugador------
  p1 = new Jugador(mundo, 50, height/4, width, height/2, 200, 20, true);
  p2 = new Jugador(mundo, width-50, height/4, 0, height/2, -200, width-100, false);
}

void draw() {
  background(255);
  p1.dibujar();
  p2.dibujar();
  if (frameCount%180 == 0 && p1.frenado() == false && p2.frenado() == false) {
    p1.disparar();
    p2.disparar();
  }

  //mundo.drawDebug();
  mundo.draw();
  mundo.step();
  //line(0, height/2, width, height/2);
}

void frenarJuego() {
  if (p1.frenado() || p2.frenado()) {
    p1.frenar();
    p2.frenar();
  } else {
    p1.reanudar();
    p2.reanudar();
  }
}

void mouseReleased() {
  p1.click();
  p2.click();
}

void keyPressed() {
  if (key == '1' || key == '2' || key == '3') {
    p1.teclaSel(key);
    p2.teclaSel(key);
  }
  if (key == 'd' || key == 'a' || key == 'x') {
    p1.tecla(mundo, key, 'd', 'a', 'x');
    p2.deSeleccionar();
    frenarJuego();
  } else if (key == 'l' || key == 'j' || key == 'm') {
    p2.tecla(mundo, key, 'l', 'j', 'm');
    p1.deSeleccionar();
    frenarJuego();
  }
}
