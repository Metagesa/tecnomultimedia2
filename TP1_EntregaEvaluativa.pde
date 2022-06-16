import oscP5.*;
//==========variables de calibración=============
float UMBRAL_RUIDO = 190;

float MIN_AMP = 65;
float MAX_AMP = 86;

float MIN_PITCH = 46;
float MAX_PITCH = 66;

float factor = 0.2;
//=======================================

//--- Estado -----
boolean haySonido = false;
boolean antesHabiaSonido = false;

// ---- Eventos------
boolean empezoElSonido = false;
boolean terminoElSonido = false;

float amp = 0;
float pitch = 0;
int ruido = 0;

OscP5 osc;
GestorSenial gestorAmp;
GestorSenial gestorPitch;

int tCelda = 2;
int celCol, celFil;

int xPat = 500;
int yPat = 500;

float velFondo = 1.5;

float rot = radians(0);
float mov = 0;

PGraphics degradado;
PImage patron1, patron2, patron3;
PImage cuadro, marco;

float selPat;
long finDelSonido = 0;
long inicioDelSonido = 0;

boolean colgar = false;
float tamCuadro = 50;
long tiempoAndando = 0;

patron[] hojas, lineaD, lunas;
Degrade d;

void setup() {
  size(500, 600, P2D);
  hint(ENABLE_DEPTH_SORT);

  osc = new OscP5(this, 8686);
  gestorAmp = new GestorSenial( MIN_AMP, MAX_AMP, factor );
  gestorPitch = new GestorSenial( MIN_PITCH, MAX_PITCH, factor );

  imageMode(CENTER);

  patron1 = loadImage("pat1.png");
  patron1.resize(int(xPat), int(xPat));
  patron2 = loadImage("pat2.png");
  patron2.resize(xPat/2, xPat/2);
  patron3 = loadImage("pat3.png");
  patron3.resize(int(xPat), 0);

  marco = loadImage("marco.png");

  celCol = width/patron1.width+2;
  celFil = height/patron1.height+2;

  hojas = new patron[celCol+celFil*2];
  for (int i = 0; i<hojas.length; i++) {
    hojas[i] = new patron (0, 0, patron1);
  }

  lineaD = new patron[(width/celCol+height/celFil*2)];
  for (int i = 0; i<hojas.length; i++) {
    lineaD[i] = new patron (0, 0, patron2);
  }

  lunas = new patron[(int(width/celCol*1.3)+height/celFil*2)];
  for (int i = 0; i<hojas.length; i++) {
    lunas[i] = new patron (0, 0, patron3);
  }

  d = new Degrade();
  d.moverDegrade(true);
  d.cambiarDeg();
  d.dibujar(velFondo);

  selPat = random(4);
}

void draw() {

  gestorAmp.actualizar( amp );
  gestorPitch.actualizar( pitch );

  haySonido = gestorAmp.filtradoNorm() > 0.05; // Estado

  empezoElSonido = !antesHabiaSonido && haySonido; //Evento
  terminoElSonido = antesHabiaSonido && !haySonido; //Enento

  if (!colgar) {
    tiempoAndando = millis();

    if (empezoElSonido) {
      inicioDelSonido=millis();
    }

    if (haySonido) {
      rot += radians(map(gestorPitch.filtradoNorm(), 0, 1, -1, 1));
      mov += map(gestorAmp.filtradoNorm(), 0, 1, 0, 15);
      d.dibujar(0);
    } else {
      if (millis()-finDelSonido>2500) {
        d.moverDegrade(true);
        d.dibujar(velFondo);
      } else {
        d.moverDegrade(false);
        d.dibujar(0);
      }
    }
    if (terminoElSonido) {
      finDelSonido = millis();
    }

    if (selPat < 2) {
      push();
      translate(width/2, height/2);
      rotate(rot);
      for (int i = 0; i < celCol*2; i++) {
        for (int j = 0; j < celFil*2; j++) {
          hojas[i].posicionar(i, j, mov);
          hojas[i].drawPat();
        }
      }
      pop();
    } else if (selPat < 3) {
      push();
      translate(width/2, height/2);
      rotate(rot);
      for (int i = 0; i < celCol*3; i++) {
        for (int j = 0; j < celFil*3; j++) {
          lineaD[i].posicionar(i, j, mov);
          lineaD[i].drawPat();
        }
      }
      pop();
    } else if (selPat <= 4) {
      push();
      translate(width/2, height/2);
      rotate(rot);
      for (int i = 0; i < celCol*2; i++) {
        for (int j = 0; j < celFil*2; j++) {
          lunas[i].posicionar(i-1, j, mov);
          lunas[i].drawPat();
        }
      }
      pop();
    }
  }

  if (colgar) {
    image(cuadro, width/2, height/2, width-tamCuadro*2, height-tamCuadro*2);
    image(marco, width/2, height/2);

    if (millis() - tiempoAndando > 3000) {
      save("cuadros/cuadro-"+day()+"-"+month()+"-"+hour()+"-"+minute()+"-"+second()+".png");
      colgar = false;
      d.cambiarDeg();
      selPat = random(4);
    }
  }

  if ((ruido > UMBRAL_RUIDO) && (amp>70) && !colgar) {
    colgar = true;
    cuadro = get(0, 0, width, height);
  }

  antesHabiaSonido = haySonido;
}

void oscEvent( OscMessage m) {

  if (m.addrPattern().equals("/amp")) {
    amp = m.get(0).floatValue();
    //println("Amp: " + amp);
  }

  if (m.addrPattern().equals("/pitch")) {
    pitch = m.get(0).floatValue();
    //println("Pitch: " + pitch);
  }
  if (m.addrPattern().equals("/ruido")) {

    ruido = m.get(0).intValue();
    //println("Ruido: " + ruido);
  }
}

//void mouseClicked() {  //PARA DEBUG
//  d.cambiarDeg();
//}
