import processing.sound.*;
import fisica.*;

FWorld mundo;                  //DECLARO EL MUNDO
boolean posicionando = true;   //variable para decidir si estamos en instacia de posicionar o no
boolean apuntar = false;       //variable para decidir si estamos en instancia de apuntar
float sel = 0;                 //variable para ver qué ficha está seleccionada
int pantalla = 0;
Jugador p1, p2;

float contadorParcial = 0;
long contador = 0;

boton reiniciar;

PImage logo, boton, botonHover, ganarAzul, ganarRojo;
SoundFile musicaInicio, musicaJugando, golpe, lasers;

FBox[] pared = new FBox[10];

void setup() {

  //-----configuración de pantalla---------

  fullScreen();
  surface.setSize(displayWidth, 700);
  surface.setLocation(displayWidth/2-width/2, displayHeight/2-int(height/1.9));

  //-----inicializo fisica, el mundo (sacando la gravedad y poniendo los bordes), y las fichas---------
  Fisica.init(this);
  mundo = new FWorld();
  mundo.setGravity(0, 0);

  musicaInicio = new SoundFile(this, "musicaInicio.wav");
  musicaJugando = new SoundFile(this, "musicaJugando.wav");
  golpe = new SoundFile(this, "golpe.wav", false);
  lasers = new SoundFile(this, "lasers.wav", false);

  reiniciar = new boton (width/6);

  logo = loadImage("inicio.png");
  boton = loadImage("boton.png");
  botonHover = loadImage("botonHover.png");
  ganarAzul = loadImage("ganarAzul.png");
  ganarAzul.resize(width, 0);
  ganarRojo = loadImage("ganarRojo.png");
  ganarRojo.resize(width, 0);

  inicializar();
  musicaInicio.amp(0.1);
  musicaInicio.loop();
}

void draw() {
  background(0);
  contador = millis();
  println((frameCount%1200)/10);
  println(frameRate);
  println(p1.frenado());
  println(p2.frenado());
  if (pantalla == 0) {
    push();
    imageMode(CENTER);
    image(logo, width/2, 150);
    textAlign(CENTER, CENTER);
    textSize(18);
    text("Barra espaciadora para iniciar...", width/2, height/2);
    pop();
  }

  if (pantalla == 1) {
    if (contador - contadorParcial > 20*1000) {
      p1.deSeleccionar();
      p2.deSeleccionar();
      p1.cambioEtapa();
      p2.cambioEtapa();
      posicionando = !posicionando;
      contadorParcial = millis();
    }

    if (posicionando) {
      push();
      fill(255, 0, 0, 50);
      rect(0, 0, width, height);
      fill(255);
      textAlign(CENTER, CENTER);
      text("POSICIONA TUS FICHAS... "+(int(20-(contador-contadorParcial)/1000))+" segundos restantes...", width/2, 200);
      pop();
    }

    p1.dibujar();
    p2.dibujar();

    //mundo.drawDebug();
    mundo.draw();
    mundo.step();

    if (p2.vida() <= 0) {
      pantalla = 2;
    }
    if (p1.vida() <= 0) {
      pantalla = 3;
    }
  } else if (pantalla == 2) {
    push();
    reiniciar.draw(width/2, height/6*5);
    imageMode(CENTER);
    image(ganarAzul, width/2, height/2-100);
    pop();
  } else if (pantalla == 3) {
    push();
    reiniciar.draw(width/2, height/6*5);
    imageMode(CENTER);
    image(ganarRojo, width/2, height/2-100);
    pop();
  }
}

//void frenarJuego() {
//  if (p1.frenado() || p2.frenado()) {
//    p1.frenar();
//    p2.frenar();
//  } else {
//    p1.reanudar();
//    p2.reanudar();
//  }
//}

void mouseReleased() {
  if ((pantalla == 2 || pantalla == 3) && reiniciar.click()) {
    inicializar();
    musicaJugando.stop();
    musicaInicio.amp(0.1);
    musicaInicio.loop();
    pantalla = 0;
    sel = 0;
    posicionando = true;
    mundo.clear();
  }
  p1.click();
  p2.click();
}

void keyPressed() {
  if (pantalla == 0) {
    if ( key == ' ') {
      pantalla = 1;
      musicaInicio.stop();
      musicaJugando.loop();
      contadorParcial = millis();
    }
  }
  if (pantalla == 1) {
    if (key == '1' || key == '2' || key == '3') {
      p1.teclaSel(key);
      p2.teclaSel(key);
    }
    if (key == 'd' || key == 'a' || key == 'x') {
      if (p1.frenado()) {
        p1.tecla(mundo, key, 'd', 'a', 'x');
        p2.deSeleccionar();
      }
    } else if (key == 'l' || key == 'j' || key == 'm') {
      if (p2.frenado()) {
        p2.tecla(mundo, key, 'l', 'j', 'm');
        p1.deSeleccionar();
      }
    }
  }
}

void inicializar() {
  //------inicializo el jugador------
  p1 = new Jugador(this, mundo, 50, height/4, width, height/2, 200, 20, true);
  p2 = new Jugador(this, mundo, width-50, height/4, 0, height/2, -200, width-100, false);

  p1.cambioEtapa(true);
  p2.cambioEtapa(true);
}

void contactStarted(FContact c) {
  FBody c1 = c.getBody1();
  FBody c2 = c.getBody2();
  boolean balas = (c1.getName().equals("bala") && c2.getName().equals("bala"));

  if (c.contains("bala", "estructura")) {
    if (golpe.isPlaying() == false) {
      golpe.play();
    }
  }
}

void contactEnded(FContact c) {
  String n1 = c.getBody1().getName();
  String n2 = c.getBody2().getName();
  int b1 = -1;
  int b2 = -1;

  for (int i = 0; i < p1.balas().size(); i++) {
    if (p1.balas.get(i).getX() == c.getBody1().getX() && p1.balas.get(i).getY() == c.getBody1().getY()) {
      b1 = i;
    }
    if (p1.balas.get(i).getX() == c.getBody2().getX() && p1.balas.get(i).getY() == c.getBody2().getY()) {
      b2 = i;
    }
  }

  for (int i = 0; i < p2.balas().size(); i++) {
    if (p2.balas.get(i).getX() == c.getBody1().getX() && p2.balas.get(i).getY() == c.getBody1().getY()) {
      b1 = i;
    }
    if (p2.balas.get(i).getX() == c.getBody2().getX() && p2.balas.get(i).getY() == c.getBody2().getY()) {
      b2 = i;
    }
  }

  if (b1>-1 && b2 >-1) {
    if (random(100) > 50) {
      mundo.remove(c.getBody2());
    } else {
      mundo.remove(c.getBody1());
    }
  }
}
