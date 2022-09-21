import processing.sound.*;
import fisica.*;

FWorld mundo;                  //DECLARO EL MUNDO
boolean posicionando = true;   //variable para decidir si estamos en instacia de posicionar o no
boolean apuntar = false;       //variable para decidir si estamos en instancia de apuntar
float sel = 0;                 //variable para ver qué ficha está seleccionada
int pantalla = 0;
Jugador p1, p2;

int turnos = 0;
float tiempoTurno = 20000;

tablero tab;

long contadorParcial = 0;
long contador = 0;

boton reiniciar, iniciar;

PImage logo, boton, botonHover, ganarAzul, ganarRojo, empate;
SoundFile musicaInicio, musicaJugando, golpe, lasers;

FBox[] pared = new FBox[10];

void setup() {

  //-----configuración de pantalla---------

  fullScreen();
  surface.setSize(int(1920/1.5), int(1080/1.5));
  surface.setLocation(displayWidth/2-width/2, displayHeight/2-int(height/1.9));

  //-----inicializo fisica, el mundo (sacando la gravedad y poniendo los bordes), y las fichas---------
  Fisica.init(this);
  mundo = new FWorld();
  mundo.setGravity(0, 0);

  musicaInicio = new SoundFile(this, "musicaInicio.wav");
  musicaJugando = new SoundFile(this, "musicaJugando.wav");
  golpe = new SoundFile(this, "golpe.wav", false);
  lasers = new SoundFile(this, "lasers.wav", false);

  reiniciar = new boton (width/6, this);
  iniciar = new boton (width/6, this);

  logo = loadImage("inicio.png");
  logo.resize(width, height);
  boton = loadImage("boton.png");
  botonHover = loadImage("botonHover.png");
  ganarAzul = loadImage("ganarAzul.png");
  ganarAzul.resize(int(width/1.3), 0);
  ganarRojo = loadImage("ganarRojo.png");
  ganarRojo.resize(int(width/1.3), 0);
  empate = loadImage("empate.png");
  empate.resize(int(width/1.3), 0);

  tab = new tablero(mundo);

  inicializar();
  musicaInicio.amp(0.1);
  musicaInicio.loop();
}

void draw() {
  background(0);
  println(turnos);
  contador = millis();
  //println((frameCount%1200)/10);
  //println(frameRate);
  //println(p1.frenado());
  //println(p2.frenado());
  if (pantalla == 0) {
    push();
    imageMode(CENTER);
    image(logo, width/2, height/2);
    textAlign(CENTER, CENTER);
    textSize(18);
    pop();
    iniciar.draw(width/2, height/6*4.2, "INICIAR");
  }

  if (pantalla == 1) {
    tab.draw(color(255, map(contador - contadorParcial, tiempoTurno/4*3, tiempoTurno, 255, 0), map(contador - contadorParcial, tiempoTurno/4*3, tiempoTurno, 255, 0)));
    if (contador - contadorParcial > tiempoTurno) {
      p1.deSeleccionar();
      p2.deSeleccionar();
      p1.cambioEtapa();
      p2.cambioEtapa();
      posicionando = !posicionando;
      contadorParcial = millis();
      turnos += 1;
    }

    if (posicionando) {
      push();
      fill(255, 0, 0, 50);
      //rect(0, 0, width, height);
      fill(255);
      textAlign(CENTER, CENTER);
      text("POSICIONA TUS FICHAS... "+(int(tiempoTurno/1000-(contador-contadorParcial)/1000))+" segundos restantes...", width/2, 200);
      pop();
    }

    p1.dibujar();
    p2.dibujar();

    //mundo.drawDebug();
    mundo.draw();
    mundo.step();

    println(p1.vida());
    println(p2.vida());
    
    if (turnos > 5) {
      if (p2.vida() == p1.vida()) {
        pantalla = 4;
      } else if (p2.vida() < p1.vida()) {
        pantalla = 3;
      } else if (p2.vida() > p1.vida()) {
        pantalla = 2;
      }
    }

    if (p2.vida() <= 0) {
      pantalla = 3;
    }
    if (p1.vida() <= 0) {
      pantalla = 2;
    }
  } else if (pantalla == 2) {
    push();
    reiniciar.draw(width/2, height/6*5, "REINICIAR");
    imageMode(CENTER);
    image(ganarAzul, width/2, height/2-100);
    pop();
  } else if (pantalla == 3) {
    push();
    reiniciar.draw(width/2, height/6*5, "REINICIAR");
    imageMode(CENTER);
    image(ganarRojo, width/2, height/2-100);
    pop();
  } else if (pantalla == 4) {
    push();
    reiniciar.draw(width/2, height/6*5, "REINICIAR");
    imageMode(CENTER);
    image(empate, width/2, height/2-100);
    pop();
  }
}

void mouseReleased() {
  if ((pantalla == 0) && iniciar.click()) {
    pantalla = 1;
    turnos = 0;
    musicaInicio.stop();
    musicaJugando.loop();
    contadorParcial = millis();
  }
  if ((pantalla == 2 || pantalla == 3 || pantalla == 4) && reiniciar.click()) {
    inicializar();
    musicaJugando.stop();
    musicaInicio.amp(0.1);
    musicaInicio.loop();
    pantalla = 0;
    sel = 0;
    turnos = 0;
    posicionando = true;
    mundo.clear();
    tab = new tablero(mundo);
  }
  p1.click();
  p2.click();
}

void keyPressed() {
  if (pantalla == 0) {
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
  p1 = new Jugador(this, mundo, 150, height/4, width, height/2, 200, 120, true);
  p2 = new Jugador(this, mundo, width-150, height/4, 0, height/2, -200, width-200, false);

  p1.cambioEtapa(true);
  p2.cambioEtapa(true);
}

void contactStarted(FContact c) {
  if (c.contains("bala", "estructura")) {
    if (golpe.isPlaying() == false) {
      golpe.play();
    }
  }
}

void contactEnded(FContact c) {
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
