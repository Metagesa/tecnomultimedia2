import fisica.*;

FWorld mundo;                  //DECLARO EL MUNDO
boolean posicionando = false;  //variable para decidir si estamos en instacia de posicionar o no
boolean apuntar = false;       //variable para decidir si estamos en instancia de apuntar
float sel = 0;                 //variable para ver qué ficha está seleccionada
Jugador p1, p2;
Base b1;

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

  b1 = new Base(mundo, 20, height/2, 5);

  //------inicializo el jugador------
  p1 = new Jugador(mundo, 50, height/4, width, height/2, 200);
  p2 = new Jugador(mundo, width-50, height/4, 0, height/2, -200);
}

void draw() {
  background(255);
  p1.dibujar(color(255, 0, 0));
  p2.dibujar(color(0, 0, 255));
  if (frameCount%180 == 0 && p1.frenado() == false && p2.frenado() == false) {
    p1.disparar();
    p2.disparar();
  }
  b1.actualizar();
  mundo.drawDebug();
  mundo.step();
  //line(0, height/2, width, height/2);
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
  if (key == 'd' || key == 'a') {
    p1.tecla(key, 'd', 'a');
    p2.deSeleccionar();
  } else if (key == 'l' || key == 'j') {
    p2.tecla(key, 'l', 'j');
    p1.deSeleccionar();
  }
}
