import ddf.minim.AudioPlayer;

class Bola {
  AudioPlayer bounceSound;
  PVector    pos, vel;
  float      radio = 10;

  Bola() {
    reset();
  }

  void setBounceSound(AudioPlayer ap) {
    bounceSound = ap;
  }

  void reset() {
    pos = new PVector(width/2, height/2);
    vel = PVector.random2D().mult(300);
    vel.y = abs(vel.y);
  }

  void actualizar(float dt, Paleta p) {
    pos.add(PVector.mult(vel, dt));
    boolean reboto = false;

    // Rebote muros
    if (pos.x < radio || pos.x > width - radio) {
      vel.x *= -1;
      pos.x = constrain(pos.x, radio, width - radio);
      reboto = true;
    }
    // Rebote techo
    if (pos.y < radio) {
      vel.y *= -1;
      pos.y = radio;
      reboto = true;
    }

    // Colisión avanzada con paleta
    if (p.tipo < 2) {
      float top    = p.pos.y;
      float left   = p.pos.x;
      float right  = p.pos.x + p.ancho;
      if (pos.x > left && pos.x < right &&
          pos.y + radio >= top && vel.y > 0) {

        boolean withinHole = false;
        if (p.tipo == 1) {
          float seg = (p.ancho - p.holeWidth) / 2;
          withinHole = (pos.x > left + seg && pos.x < left + seg + p.holeWidth);
        }

        if (!withinHole) {
          reboto = true;
          float centro = left + p.ancho/2;
          float relX   = (pos.x - centro) / (p.ancho/2);
          float ang    = relX * (PI/3);
          float mag    = vel.mag();
          vel.x = mag * sin(ang);
          vel.y = -abs(mag * cos(ang));
          pos.y = top - radio;
        }
      }
    } 
    else {
      PVector centro = new PVector(p.pos.x + p.ancho/2, p.pos.y + p.alto/2);
      float dist = PVector.dist(pos, centro);
      if (dist <= radio + p.radius && vel.y > 0) {
        vel.y *= -1;
        PVector dir = PVector.sub(pos, centro).normalize();
        pos = PVector.add(centro, dir.mult(radio + p.radius));
        reboto = true;
      }
    }

    if (reboto && bounceSound != null) {
      bounceSound.rewind();
      bounceSound.play();
    }
  }

  void mostrar() {
    fill(255, 100, 100);
    noStroke();
    ellipse(pos.x, pos.y, radio*2, radio*2);
  }
}
